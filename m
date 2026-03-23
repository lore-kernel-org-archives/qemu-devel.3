Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC24FF46126
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 14:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4foa-0000CZ-CV; Mon, 23 Mar 2026 09:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1w4fo5-0008Jg-PG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:03 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1w4fo4-0006tE-C6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 09:59:01 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.76])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8649420B7007;
 Mon, 23 Mar 2026 06:58:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8649420B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1774274339;
 bh=+449kqpsT3rs/26cTO+xTXYI56NYmCzZVttigepvBaE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=o73bjwCv1M6bmGMltUPwyi9QAIV+9orQPu8JdvTulptPQu+OYOS/eYdweG9gWS8MK
 BCLIxFKwQi2/TGqoLCre1iGiIanPEfphanY1iJmVbs/FYp5lYzVFDcZiGTOpcLMeGv
 dzUJ0apeVV4YTV/rYUgk3fRG0aXlrH1fJP6IdmKo=
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
Subject: [RFC 11/32] accel/mshv: use s->irq_routes in commit_routes
Date: Mon, 23 Mar 2026 14:57:51 +0100
Message-Id: <20260323135812.383509-12-magnuskulke@linux.microsoft.com>
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

In mshv_irqchip_commit_routes() the entries that have been accumulated
in s->irq_routes are committed directly to MSHV's irqchip.

The old commit_msi_routing_table() fn will be removed in a subsquent commit.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 accel/accel-irq.c       | 2 +-
 accel/mshv/irq.c        | 7 ++++---
 accel/stubs/mshv-stub.c | 2 +-
 include/system/mshv.h   | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/accel/accel-irq.c b/accel/accel-irq.c
index 0cb3ef78d3..4303e10e40 100644
--- a/accel/accel-irq.c
+++ b/accel/accel-irq.c
@@ -55,7 +55,7 @@ void accel_irqchip_commit_routes(void)
 {
 #ifdef CONFIG_MSHV_IS_POSSIBLE
     if (mshv_msi_via_irqfd_enabled()) {
-        mshv_irqchip_commit_routes();
+        mshv_irqchip_commit_routes(mshv_state);
     }
 #endif
     if (kvm_enabled()) {
diff --git a/accel/mshv/irq.c b/accel/mshv/irq.c
index 990ce34620..9ba837f0e2 100644
--- a/accel/mshv/irq.c
+++ b/accel/mshv/irq.c
@@ -394,16 +394,17 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
     return 0;
 }
 
-void mshv_irqchip_commit_routes(void)
+void mshv_irqchip_commit_routes(MshvState *s)
 {
     int ret;
-    int vm_fd = mshv_state->vm;
+    int vm_fd = s->vm;
 
-    ret = commit_msi_routing_table(vm_fd);
+    ret = ioctl(vm_fd, MSHV_SET_MSI_ROUTING, s->irq_routes);
     if (ret < 0) {
         error_report("Failed to commit msi routing table");
         abort();
     }
+    trace_mshv_commit_msi_routing_table(vm_fd, s->irq_routes->nr);
 }
 
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *event,
diff --git a/accel/stubs/mshv-stub.c b/accel/stubs/mshv-stub.c
index dadf05511a..8b69539a85 100644
--- a/accel/stubs/mshv-stub.c
+++ b/accel/stubs/mshv-stub.c
@@ -28,7 +28,7 @@ int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev)
     return -ENOSYS;
 }
 
-void mshv_irqchip_commit_routes(void)
+void mshv_irqchip_commit_routes(MshvState *s)
 {
 }
 
diff --git a/include/system/mshv.h b/include/system/mshv.h
index 2033beed70..0c9a4f927c 100644
--- a/include/system/mshv.h
+++ b/include/system/mshv.h
@@ -62,8 +62,8 @@ int mshv_request_interrupt(MshvState *mshv_state, uint32_t interrupt_type, uint3
 
 int mshv_irqchip_add_msi_route(AccelRouteChange *c, int vector, PCIDevice *dev);
 int mshv_irqchip_update_msi_route(int virq, MSIMessage msg, PCIDevice *dev);
-void mshv_irqchip_commit_routes(void);
 void mshv_irqchip_release_virq(MshvState *s, int virq);
+void mshv_irqchip_commit_routes(MshvState *s);
 int mshv_irqchip_add_irqfd_notifier_gsi(const EventNotifier *n,
                                         const EventNotifier *rn, int virq);
 int mshv_irqchip_remove_irqfd_notifier_gsi(const EventNotifier *n, int virq);
-- 
2.34.1


