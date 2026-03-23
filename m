Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AE3F4611C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 13:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4fnw-0008DE-7W; Mon, 23 Mar 2026 09:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fnr-000885-7S
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:58:48 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fnp-0006nf-OV
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:58:47 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 108DA20B7138;
 Mon, 23 Mar 2026 06:58:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 108DA20B7138
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274324;
 bh=Q99VB31zJMe+kwy7P7q526bcuOKPTBKL3PaUmcduhVg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UMugpAwPlir5DpKO9i8Us7blVSXe4E05zoCjdDxYfujRpzKhOP+wMH9RrbRjxoRfl
 +/sLmlCFC+M7Yscfn0ou5YM1nneprBNHqAFcP41oByX5dsdslcXwPesGVg76Cr/z25
 KCR+5wXkiJV8WnAvEwOMM23oRtTMJ4oHDKwxeRG0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Wei Liu <wei.liu@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC 07/32] accel/mshv: add irq_routes to state
Date: Mon, 23 Mar 2026 14:57:47 +0100
Message-Id: <20260323135812.383509-8-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
References: <20260323135812.383509-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change adds fields related to irq routing to the MSHV state, following
similar fields in the KVM implementation.

So far the fields are only initialized, they will be used in subsequent
commits for bookkeeping purposes and storing uncommitted interrupt routes.

The TYPE_MSHV_ACCEL defines have been moved to the header.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/mshv/irq.c          | 10 ++++++++++
 accel/mshv/mshv-all.c     |  6 ++----
 include/system/mshv.h     |  7 +++++++
 include/system/mshv_int.h |  5 +++++
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 3c238c33c3..82f2022c7c 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -396,3 +396,13 @@ int mshv_reserve_ioapic_msi_routes(int vm_fd)
 
     return 0;
 }
+
+void mshv_init_irq_routing(MshvState *s)
+{
+    int gsi_count = MSHV_MAX_MSI_ROUTES;
+
+    s->irq_routes = g_malloc0(sizeof(*s->irq_routes));
+    s->nr_allocated_irq_routes = 0;
+    s->gsi_count = gsi_count;
+    s->used_gsi_bitmap = bitmap_new(gsi_count);
+}
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 04d248fe1d..8acb080db1 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -43,10 +43,6 @@
 #include <err.h>
 #include <sys/ioctl.h>
 
-#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
-
-DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE, TYPE_MSHV_ACCEL)
-
 bool mshv_allowed;
 
 MshvState *mshv_state;
@@ -457,6 +453,8 @@ static int mshv_init(AccelState *as, MachineState *ms)
 
     mshv_state = s;
 
+    mshv_init_irq_routing(s);
+
     register_mshv_memory_listener(s, &s->memory_listener, &address_space_memory,
                                   0, "mshv-memory");
     memory_listener_register(&mshv_io_listener, &address_space_io);
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 1e96b3a606..0d1745315b 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -45,7 +45,13 @@ extern bool mshv_allowed;
 #define mshv_msi_via_irqfd_enabled() mshv_enabled()
 #endif
 
+#define TYPE_MSHV_ACCEL ACCEL_CLASS_NAME("mshv")
+
 typedef struct MshvState MshvState;
+
+DECLARE_INSTANCE_CHECKER(MshvState, MSHV_STATE,
+                         TYPE_MSHV_ACCEL)
+
 extern MshvState *mshv_state;
 
 /* interrupt */
@@ -60,5 +66,6 @@ void mshv_irqchip_release_virq(int virq);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
+void mshv_init_irq_routing(MshvState *s);
 
 #endif
diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
index 70631ca6ba..56fda76a9c 100644
--- a/include/system/mshv_int.h
+++ b/include/system/mshv_int.h
@@ -48,6 +48,11 @@ struct MshvState {
     int nr_as;
     MshvAddressSpace *as;
     int fd;
+    /* irqchip routing */
+    struct mshv_user_irq_table *irq_routes;
+    int nr_allocated_irq_routes;
+    unsigned long *used_gsi_bitmap;
+    unsigned int gsi_count;
 };
 
 typedef struct MshvMsiControl {
-- 
2.34.1


