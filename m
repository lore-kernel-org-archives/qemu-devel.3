Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9A9CD8C92
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbn2-0001ub-Ex; Mon, 08 Jun 2026 11:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joro@8bytes.org>) id 1wWbn0-0001t7-FI
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:22 -0400
Received: from mail.8bytes.org ([2a01:238:42d9:3f00:e505:6202:4f0c:f051])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joro@8bytes.org>) id 1wWbmy-0007sv-Vp
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 11:21:22 -0400
Received: from io.home.8bytes.org (p4ffe1d30.dip0.t-ipconnect.de
 [79.254.29.48])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.8bytes.org (Postfix) with ESMTPSA id 5144020294B;
 Mon,  8 Jun 2026 17:21:16 +0200 (CEST)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@linaro.org, marcel.apfelbaum@gmail.com, zhao1.liu@intel.com,
 berrange@redhat.com, mst@redhat.com, cohuck@redhat.com,
 mtosatti@redhat.com, Tom Lendacky <thomas.lendacky@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, coconut-svsm@lists.linux.dev,
 joerg.roedel@amd.com
Subject: [RFC PATCH 10/10] KVM: Set GSI routes for default plane
Date: Mon,  8 Jun 2026 17:21:09 +0200
Message-ID: <20260608152109.356783-11-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608152109.356783-1-joro@8bytes.org>
References: <20260608152109.356783-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:238:42d9:3f00:e505:6202:4f0c:f051;
 envelope-from=joro@8bytes.org; helo=mail.8bytes.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joerg Roedel <joerg.roedel@amd.com>

This ensures that all IOAPIC IRQs are routed to the default device
plane in the KVM guest.

Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
---
 accel/kvm/kvm-all.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 31d80f7ac48b..2bd98efaadab 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -134,6 +134,7 @@ static int map_kvm_run(KVMState *s, CPUState *cpu, Error **errp);
 static int map_kvm_dirty_gfns(KVMState *s, CPUState *cpu, Error **errp);
 static int vcpu_unmap_regions(KVMState *s, CPUState *cpu);
 static void kvm_alloc_vcpu_plane(CPUState *cpu, unsigned plane_id, int kvm_fd);
+static int kvm_create_plane(KVMState *s, unsigned id);
 
 struct KVMResampleFd {
     int gsi;
@@ -2238,6 +2239,7 @@ void kvm_init_irq_routing(KVMState *s)
 
 void kvm_irqchip_commit_routes(KVMState *s)
 {
+    unsigned plane = qdev_default_plane();
     int ret;
 
     if (kvm_gsi_direct_mapping()) {
@@ -2250,7 +2252,7 @@ void kvm_irqchip_commit_routes(KVMState *s)
 
     s->irq_routes->flags = 0;
     trace_kvm_irqchip_commit_routes();
-    ret = kvm_vm_ioctl(s, KVM_SET_GSI_ROUTING, s->irq_routes);
+    ret = kvm_vm_plane_ioctl(s, plane, KVM_SET_GSI_ROUTING, s->irq_routes);
     assert(ret == 0);
 }
 
@@ -2667,6 +2669,8 @@ static int do_kvm_irqchip_create(KVMState *s)
 
 static void kvm_irqchip_create(KVMState *s)
 {
+    int device_plane = qdev_default_plane();
+
     assert(s->kernel_irqchip_split != ON_OFF_AUTO_AUTO);
 
     if (do_kvm_irqchip_create(s) < 0) {
@@ -2679,6 +2683,11 @@ static void kvm_irqchip_create(KVMState *s)
     kvm_async_interrupts_allowed = true;
     kvm_halt_in_kernel_allowed = true;
 
+    /* Make sure irqchip target plane is known to KVM */
+    if (device_plane != 0) {
+        kvm_create_plane(s, device_plane);
+    }
+
     kvm_init_irq_routing(s);
 
     s->gsimap = g_hash_table_new(g_direct_hash, g_direct_equal);
-- 
2.53.0


