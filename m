Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BFB4CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwhaZ-0003aL-8Q; Thu, 11 Sep 2025 09:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uwhaV-0003Yy-Ef
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uwhaR-0003V6-PX
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757598221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJE52WELL8ju9OR0d+WZwTwi5R18JbMSBCtMSDbor+8=;
 b=YS1qntHK30Yot7E+h2eRTi8Ie4KvqwhCPMVQze01/TwKPo4qlVIi4s1m6kUl77ca4mXvOq
 UfQM6eTDWX3HXQiCQ3div2ZHhXezwKZ2DGClPO4TO0kWwl4oPRrQ0kE+Bo4RwzDHIhD/IS
 iVZUejIk2aoxgrtUTRU0L4N53pglKEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-maa4L9mdOLudpuotnqpvuA-1; Thu,
 11 Sep 2025 09:43:37 -0400
X-MC-Unique: maa4L9mdOLudpuotnqpvuA-1
X-Mimecast-MFC-AGG-ID: maa4L9mdOLudpuotnqpvuA_1757598216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1683180057E; Thu, 11 Sep 2025 13:43:35 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 174AB1944CEB; Thu, 11 Sep 2025 13:43:31 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com
Subject: [RFC 1/3] target/arm/cpu: Add new CPU property for KVM regs to hide
Date: Thu, 11 Sep 2025 15:40:27 +0200
Message-ID: <20250911134324.3702720-2-eric.auger@redhat.com>
In-Reply-To: <20250911134324.3702720-1-eric.auger@redhat.com>
References: <20250911134324.3702720-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

New kernels sometimes expose new registers in an unconditionnal
 manner.  This situation breaks backward migration as qemu notices
there are more registers to store on guest than supported in the
destination kerenl. This leads to a "failed to load
cpu:cpreg_vmstate_array_len" error.

A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
migration from a host kernel which features the commit to a destination
host that doesn't fail.

Currently QEMU is not using that feature so ignoring this latter
is not a problem. An easy way to fix the migration issue is to teach
qemu we don't care about that register and we can simply ignore it,
including its state migration.

This patch introduces a CPU property, under the form of an array of
reg indices which indicates which registers can be ignored.

The goal then is to set this property in machine type compats such
as:
static GlobalProperty arm_virt_kernel_compat_10_1[] = {
    /* KVM_REG_ARM_VENDOR_HYP_BMAP_2 */
    { TYPE_ARM_CPU, "kvm-hidden-regs", "0x6030000000160003" },
}

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h        |  4 ++++
 target/arm/kvm.c        | 36 ++++++++++++++++++++++++++++++++++--
 target/arm/trace-events |  2 ++
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c15d79a106..121b4372b2 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1031,6 +1031,10 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /* KVM registers that must be ignored/hidden */
+    uint64_t *kvm_hidden_regs;
+    uint32_t nr_kvm_hidden_regs;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 6672344855..67675781f4 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,8 @@
 #include "qemu/log.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
+#include "hw/qdev-properties.h"
+#include "hw/qdev-properties-system.h"
 #include "target/arm/gtimer.h"
 #include "migration/blocker.h"
 
@@ -483,6 +485,10 @@ static void kvm_steal_time_set(Object *obj, bool value, Error **errp)
     ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
 }
 
+static const Property arm_cpu_kvm_compat_hidden_regs_property =
+    DEFINE_PROP_ARRAY("kvm-hidden-regs", ARMCPU,
+                      nr_kvm_hidden_regs, kvm_hidden_regs, qdev_prop_uint64, uint64_t);
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -504,6 +510,8 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                              kvm_steal_time_set);
     object_property_set_description(obj, "kvm-steal-time",
                                     "Set off to disable KVM steal time.");
+
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_kvm_compat_hidden_regs_property);
 }
 
 bool kvm_arm_pmu_supported(void)
@@ -764,6 +772,26 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
+/**
+ * kvm_vcpu_compat_hidden_reg:
+ * @cpu: ARMCPU
+ * @regidx: index of the register to check
+ *
+ * Depending on the CPU compat returns true if @regidx must be
+ * ignored during sync & migration
+ */
+static inline bool
+kvm_vcpu_compat_hidden_reg(ARMCPU *cpu, uint64_t regidx)
+{
+    for (int i = 0; i < cpu->nr_kvm_hidden_regs; i++) {
+        if (cpu->kvm_hidden_regs[i] == regidx) {
+            trace_kvm_vcpu_compat_hidden_reg(regidx);
+            return true;
+        }
+    }
+    return false;
+}
+
 /**
  * kvm_arm_init_cpreg_list:
  * @cpu: ARMCPU
@@ -798,7 +826,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     qsort(&rlp->reg, rlp->n, sizeof(rlp->reg[0]), compare_u64);
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
-        if (!kvm_arm_reg_syncs_via_cpreg_list(rlp->reg[i])) {
+        if (!kvm_arm_reg_syncs_via_cpreg_list(rlp->reg[i]) ||
+            kvm_vcpu_compat_hidden_reg(cpu, rlp->reg[i])) {
             continue;
         }
         switch (rlp->reg[i] & KVM_REG_SIZE_MASK) {
@@ -814,6 +843,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         arraylen++;
     }
 
+    trace_kvm_arm_init_cpreg_list_arraylen(arraylen);
+
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
@@ -825,7 +856,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
         uint64_t regidx = rlp->reg[i];
-        if (!kvm_arm_reg_syncs_via_cpreg_list(regidx)) {
+        if (!kvm_arm_reg_syncs_via_cpreg_list(regidx) ||
+            kvm_vcpu_compat_hidden_reg(cpu, regidx)) {
             continue;
         }
         cpu->cpreg_indexes[arraylen] = regidx;
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 4438dce7be..1b4ab0c683 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -13,3 +13,5 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
+kvm_arm_init_cpreg_list_arraylen(uint32_t arraylen) "arraylen=%d"
+kvm_vcpu_compat_hidden_reg(uint64_t regidx) "0x%"PRIx64" is hidden"
-- 
2.49.0


