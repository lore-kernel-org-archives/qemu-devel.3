Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A39FF46122
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:05:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4foa-0000CD-CZ; Mon, 23 Mar 2026 09:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fo2-0008Ga-Hl
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:02 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fo0-0006s9-SB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:58:58 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 00BCF20B700D;
 Mon, 23 Mar 2026 06:58:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00BCF20B700D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274335;
 bh=4H6AOTHbSt4M6umhyzila9t2EZwbHKhGHm3APiPWRFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ogk3+hhNAmK2F2D7EZqoy8Tq5JUjReQ2gcuNfVMHJuOvIOJBookBdOcNZ/oiD6uQ7
 pZNAEfNs9TU0yj+qMZNmbuIkdwaGgEtUiBGw5TlBHZ4wzXEjeH84SAjov+N7uDi8UU
 PO+qfdmZxDZsSycV4/hVnpBU/dOQU5RFCMPdnIv4=
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
Subject: [RFC 10/32] accel/mshv: update s->irq_routes in release_virq
Date: Mon, 23 Mar 2026 14:57:50 +0100
Message-Id: <20260323135812.383509-11-magnuskulke@linux.microsoft.com>
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

The state's irq_routes field will be updated when an irqchip's gsi
is requested to be released.

The old remove_msi_routing() fn is redundant and can be removed.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c       |  2 +-
 accel/mshv/irq.c        | 43 ++++++++++++++---------------------------
 accel/stubs/mshv-stub.c |  2 +-
 include/system/mshv.h   |  2 +-
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 5a97a345b2..0cb3ef78d3 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -67,7 +67,7 @@ void accel_irqchip_release_virq(int virq)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_release_virq(virq);
+        mshv_irqchip_release_virq(mshv_state, virq);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index b5a047b367..990ce34620 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -123,33 +123,6 @@ static int commit_msi_routing_table(int vm_fd)
     return 0;
 }
 
-static int remove_msi_routing(uint32_t gsi)
-{
-    struct mshv_user_irq_entry *route_entry;
-    GHashTable *gsi_routes;
-
-    trace_mshv_remove_msi_routing(gsi);
-
-    if (gsi >= MSHV_MAX_MSI_ROUTES) {
-        error_report("Invalid GSI: %u", gsi);
-        return -1;
-    }
-
-    assert(msi_control);
-
-    WITH_QEMU_LOCK_GUARD(&msi_control_mutex) {
-        gsi_routes = msi_control->gsi_routes;
-        route_entry = g_hash_table_lookup(gsi_routes, GINT_TO_POINTER(gsi));
-        if (route_entry) {
-            g_hash_table_remove(gsi_routes, GINT_TO_POINTER(gsi));
-            g_free(route_entry);
-            msi_control->updated = true;
-        }
-    }
-
-    return 0;
-}
-
 /* Pass an eventfd which is to be used for injecting interrupts from userland */
 static int irqfd(int vm_fd, int fd, int resample_fd, uint32_t gsi,
                  uint32_t flags)
@@ -319,9 +292,21 @@ int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
     return gsi;
 }
 
-void mshv_irqchip_release_virq(int virq)
+void mshv_irqchip_release_virq(MshvState *s, int virq)
 {
-    remove_msi_routing(virq);
+    struct mshv_user_irq_entry *e;
+    int i;
+
+    for (i = 0; i < s->irq_routes->nr; i++) {
+        e = &s->irq_routes->entries[i];
+        if (e->gsi == virq) {
+            s->irq_routes->nr--;
+            *e = s->irq_routes->entries[s->irq_routes->nr];
+        }
+    }
+    irqchip_release_gsi(s, virq);
+
+    trace_mshv_remove_msi_routing(virq);
 }
 
 static int update_routing_entry(MshvState *s,
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index 998c9e2fc6..dadf05511a 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -19,7 +19,7 @@ int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void mshv_irqchip_release_virq(int virq)
+void mshv_irqchip_release_virq(MshvState *s, int virq)
 {
 }
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 7f60aba308..2033beed70 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -63,7 +63,7 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
 void mshv_irqchip_commit_routes(void);
-void mshv_irqchip_release_virq(int virq);
+void mshv_irqchip_release_virq(MshvState *s, int virq);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
-- 
2.34.1


