Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C416C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYluN-0005T4-9l; Mon, 07 Jul 2025 09:29:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYlhX-00026v-S1
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:16:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYlhV-0001Kt-Q9
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:16:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751894164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9UxRJvPZbUcaS5XkaTexqwX2GQAj6Hec0NFKw8sW+0=;
 b=XypMwNG/3DjfyVK3PBhyA+2E5l8cMGTDSxRNYJHiGxkoIbWY+qLFsSbRf3P/KXUTGPfLYm
 VqqyMTNhqI3f+OOTAPUA4Wi6sUdoQWnCHss+wT8FrxGsJxJYM4oyQkpLJqE3sgRya+x/HC
 j1HR84bKe/o7LFwBnv6eaPLkZ9FiNhg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-660-poVC_94PPeu_zk2wFmtnbw-1; Mon,
 07 Jul 2025 09:15:59 -0400
X-MC-Unique: poVC_94PPeu_zk2wFmtnbw-1
X-Mimecast-MFC-AGG-ID: poVC_94PPeu_zk2wFmtnbw_1751894157
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D4E018DA380; Mon,  7 Jul 2025 13:15:57 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 759C419560AD; Mon,  7 Jul 2025 13:15:53 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
Subject: [PATCH v8 4/4] hw/arm/virt: Allow virt extensions with KVM
Date: Mon,  7 Jul 2025 15:14:51 +0200
Message-ID: <20250707131530.1141759-5-eric.auger@redhat.com>
In-Reply-To: <20250707131530.1141759-1-eric.auger@redhat.com>
References: <20250707131530.1141759-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Haibo Xu <haibo.xu@linaro.org>

Up to now virt support on guest has been only supported with TCG.
Now it becomes feasible to use it with KVM acceleration.

Check neither in-kernel GICv3 nor aarch64=off is used along with KVM
EL2.

Also add a migration blocker in case KVM NV is set as some
GIC registers are most probably not properly saved/restored:
ICH_AP*R<n>_EL2, ICH_EISR_EL2, ICH_ELRSR_EL2, ICH_HCR_EL2,
ICH_LR<n>_EL2, etc etc.

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

---
v7 -> v8:
- add the migration blocker
- s/only is/is only
- check aarch64=off
- update the commit message

v6 -> v7:
- rebase on top of "hw/arm/virt: Make EL2 accelerator check an
  accept-list". I dared to keep Richard's R-b though.

v2 -> v3:
- check gic version/in-kernel implementation when kvm el2 is set (Peter)

v1 -> v2:
- fixed test ordering: virt && ((kvm && !kvm_el2) || hvf) [Richard]
- tweeked the commit title & message
---
 hw/arm/virt.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 550a272fbb..54337527d0 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -65,6 +65,7 @@
 #include "hw/intc/arm_gic.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
+#include "migration/blocker.h"
 #include "hw/irq.h"
 #include "kvm_arm.h"
 #include "hvf_arm.h"
@@ -792,6 +793,13 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
     default:
         g_assert_not_reached();
     }
+
+    if (kvm_enabled() && vms->virt &&
+        (revision != 3 || !kvm_irqchip_in_kernel())) {
+        error_report("KVM EL2 is only supported with in-kernel GICv3");
+        exit(1);
+    }
+
     vms->gic = qdev_new(gictype);
     qdev_prop_set_uint32(vms->gic, "revision", revision);
     qdev_prop_set_uint32(vms->gic, "num-cpu", smp_cpus);
@@ -2066,6 +2074,10 @@ static void virt_post_cpus_gic_realized(VirtMachineState *vms,
             memory_region_init_ram(pvtime, NULL, "pvtime", pvtime_size, NULL);
             memory_region_add_subregion(sysmem, pvtime_reg_base, pvtime);
         }
+        if (!aarch64 && vms->virt) {
+            error_report("vcpu with both EL1_32BIT and HAS_EL2 is not supported");
+            exit(1);
+        }
 
         CPU_FOREACH(cpu) {
             if (pmu) {
@@ -2211,11 +2223,24 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
-        error_report("mach-virt: %s does not support providing "
-                     "Virtualization extensions to the guest CPU",
-                     current_accel_name());
-        exit(1);
+    if (vms->virt) {
+        if (!(kvm_enabled() && kvm_arm_el2_supported()) &&
+            !tcg_enabled() && !qtest_enabled()) {
+            error_report("mach-virt: %s does not support providing "
+                         "Virtualization extensions to the guest CPU",
+                         current_accel_name());
+            exit(1);
+        }
+        if (kvm_enabled()) {
+            Error *kvm_nv_migration_blocker = NULL;
+
+            error_setg(&kvm_nv_migration_blocker,
+                       "Live migration disabled due to KVM nested virt enabled");
+            if (migrate_add_blocker(&kvm_nv_migration_blocker, NULL)) {
+                error_free(kvm_nv_migration_blocker);
+                return;
+            }
+        }
     }
 
     if (vms->mte && hvf_enabled()) {
-- 
2.49.0


