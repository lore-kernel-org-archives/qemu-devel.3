Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF6DCCAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 13:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwhaa-0003b8-6F; Thu, 11 Sep 2025 09:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uwhaW-0003Z5-RR
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:43:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uwhaS-0003VU-Bm
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 09:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757598223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09+9glxCNez7qUz7UASruAF+e/F/Ri1H0Rleipm38aA=;
 b=fTgU4zPgp2/KP8sUNtuH2+4/TFlCKo2a8h1ar8pJX031rDlT7Yacq77YbhNmkWBYiu341b
 B23+IOLXBYLJm+lZYquFiW1S0wlROcrg5dC9jG88Zp5FQAa2ng9PMJijmmCS1OohfSEa7Z
 3IsgWgizGY1f2W9urvUVw20nivC14NA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-PeP8B2FRPgiOmznj6r2tjw-1; Thu,
 11 Sep 2025 09:43:41 -0400
X-MC-Unique: PeP8B2FRPgiOmznj6r2tjw-1
X-Mimecast-MFC-AGG-ID: PeP8B2FRPgiOmznj6r2tjw_1757598219
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B473C1953947; Thu, 11 Sep 2025 13:43:39 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.45.224.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2C24B1944CEB; Thu, 11 Sep 2025 13:43:35 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com, gshan@redhat.com
Subject: [RFC 2/3] target/arm/kvm: Add new CPU property for KVM regs to enforce
Date: Thu, 11 Sep 2025 15:40:28 +0200
Message-ID: <20250911134324.3702720-3-eric.auger@redhat.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Newer kernels sometimes revokes exposure of KVM regs to
userspace. This can happen if some registers were unconditionnally
exposed, by mistake, in previous versions and then conditionnally exposed.

Recently this happened with 3 registers: TCR2_EL1, PIRE0_EL1,  PIR_EL1.
The associated kernel commit were:
0fcb4eea5345  KVM: arm64: Hide TCR2_EL1 from userspace when disabled for guests
a68cddbe47ef  KVM: arm64: Hide S1PIE registers from userspace when disabled for guests

Those commits were actual fixes but the cons is that is breaks forward
miration from old to new host kernels as the number of KVM regs exposed
to userspace decreases and this leads to "failed to load cpu:cpreg_vmstate_array_len"
when migrating the CPU state.

This patchs adds a new CPU property, under the form of an array of reg
indices that teach (destination) QEMU that some registers must exist.
If they don't (because KVM does not expose them anymore), qemu fakes them but
does not care of their state.

This is meant to be applied as a cmahine type compat like:
static GlobalProperty arm_virt_kernel_compat_10_1[] = {
    { TYPE_ARM_CPU, "kvm-enforced-regs",
      /* TCR_EL1, PIRE0_EL1, PIR_EL1 */
      "0x603000000013c103, 0x603000000013c512, 0x603000000013c513" },
};

In case we migrate from a source where the KVM regs are not exposed and
where regs are faked to a destination where KVM expose them, this means that
anyway FEAT_TCR2 and S1PIE are not supported by the guest so it should
not matter that dumb values are written on dest.

But obviously introducing fake registers is a last resort solution.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 target/arm/cpu.h        | 11 +++++++
 target/arm/kvm.c        | 63 +++++++++++++++++++++++++++++++++++++++--
 target/arm/trace-events |  4 +++
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 121b4372b2..ea9045e5ff 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1035,6 +1035,17 @@ struct ArchCPU {
     uint64_t *kvm_hidden_regs;
     uint32_t nr_kvm_hidden_regs;
 
+    /*
+     * KVM registers whose presence must be enforced
+     * Either they must be exposed to user space by KVM or
+     * they must be faked for migration sake
+     */
+    uint64_t *kvm_enforced_regs;
+    uint32_t nr_kvm_enforced_regs;
+
+    /* registers among those to be enforced that are faked */
+    uint64_t *kvm_fake_regs;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 67675781f4..f8c36ffa2f 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -489,6 +489,11 @@ static const Property arm_cpu_kvm_compat_hidden_regs_property =
     DEFINE_PROP_ARRAY("kvm-hidden-regs", ARMCPU,
                       nr_kvm_hidden_regs, kvm_hidden_regs, qdev_prop_uint64, uint64_t);
 
+static const Property arm_cpu_kvm_compat_enforced_regs_property =
+    DEFINE_PROP_ARRAY("kvm-enforced-regs", ARMCPU,
+                      nr_kvm_enforced_regs, kvm_enforced_regs,
+                      qdev_prop_uint64, uint64_t);
+
 /* KVM VCPU properties should be prefixed with "kvm-". */
 void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
 {
@@ -512,6 +517,7 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
                                     "Set off to disable KVM steal time.");
 
     qdev_property_add_static(DEVICE(obj), &arm_cpu_kvm_compat_hidden_regs_property);
+    qdev_property_add_static(DEVICE(obj), &arm_cpu_kvm_compat_enforced_regs_property);
 }
 
 bool kvm_arm_pmu_supported(void)
@@ -772,6 +778,27 @@ static bool kvm_arm_reg_syncs_via_cpreg_list(uint64_t regidx)
     }
 }
 
+/**
+ * kvm_vcpu_compat_fake_reg:
+ * @cpu: ARMCPU
+ * @regidx: index of the register to check
+ *
+ * Depending on the CPU compat returns true if @regidx is a
+ * fake register that does not need any sync, false otherwise
+ */
+static inline bool
+kvm_vcpu_compat_fake_reg(ARMCPU *cpu, uint64_t regidx)
+{
+    for (int i = 0; i < cpu->nr_kvm_enforced_regs; i++) {
+        if (cpu->kvm_fake_regs[i] &&
+            cpu->kvm_enforced_regs[i] == regidx) {
+            trace_kvm_vcpu_compat_fake_reg(regidx);
+            return true;
+        }
+    }
+    return false;
+}
+
 /**
  * kvm_vcpu_compat_hidden_reg:
  * @cpu: ARMCPU
@@ -806,7 +833,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 {
     struct kvm_reg_list rl;
     struct kvm_reg_list *rlp;
-    int i, ret, arraylen;
+    int i, ret, arraylen, rln;
+    int nr_fake_regs = 0;
     CPUState *cs = CPU(cpu);
 
     rl.n = 0;
@@ -814,12 +842,34 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     if (ret != -E2BIG) {
         return ret;
     }
-    rlp = g_malloc(sizeof(struct kvm_reg_list) + rl.n * sizeof(uint64_t));
+    rln = rl.n + cpu->nr_kvm_enforced_regs;
+    rlp = g_malloc(sizeof(struct kvm_reg_list) + rln * sizeof(uint64_t));
     rlp->n = rl.n;
     ret = kvm_vcpu_ioctl(cs, KVM_GET_REG_LIST, rlp);
     if (ret) {
         goto out;
     }
+
+    trace_kvm_arm_init_cpreg_list(rlp->n, cpu->nr_kvm_enforced_regs);
+
+    cpu->kvm_fake_regs = g_new0(uint64_t, cpu->nr_kvm_enforced_regs);
+
+    for (int j = 0; j < cpu->nr_kvm_enforced_regs; j++) {
+        uint64_t v64;
+        int res;
+
+        res = kvm_get_one_reg(cs, cpu->kvm_enforced_regs[j], &v64);
+
+        if (res != -ENOENT) {
+            trace_kvm_arm_init_cpreg_exposed(cpu->kvm_enforced_regs[j], v64, res);
+            continue;
+        }
+        rlp->reg[j + rl.n] = cpu->kvm_enforced_regs[j];
+        cpu->kvm_fake_regs[j] = true;
+        nr_fake_regs++;
+    }
+    rlp->n = rl.n + nr_fake_regs;
+
     /* Sort the list we get back from the kernel, since cpreg_tuples
      * must be in strictly ascending order.
      */
@@ -912,6 +962,10 @@ bool write_kvmstate_to_list(ARMCPU *cpu)
         uint32_t v32;
         int ret;
 
+        if (kvm_vcpu_compat_fake_reg(cpu, regidx)) {
+            continue;
+        }
+
         switch (regidx & KVM_REG_SIZE_MASK) {
         case KVM_REG_SIZE_U32:
             ret = kvm_get_one_reg(cs, regidx, &v32);
@@ -947,6 +1001,10 @@ bool write_list_to_kvmstate(ARMCPU *cpu, int level)
             continue;
         }
 
+        if (kvm_vcpu_compat_fake_reg(cpu, regidx)) {
+            continue;
+        }
+
         switch (regidx & KVM_REG_SIZE_MASK) {
         case KVM_REG_SIZE_U32:
             v32 = cpu->cpreg_values[i];
@@ -1654,6 +1712,7 @@ static void kvm_arch_set_eager_split_size(Object *obj, Visitor *v,
     s->kvm_eager_split_size = value;
 }
 
+
 void kvm_arch_accel_class_init(ObjectClass *oc)
 {
     object_class_property_add(oc, "eager-split-size", "size",
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 1b4ab0c683..57d2b6afd4 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -15,3 +15,7 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 kvm_arm_init_cpreg_list_arraylen(uint32_t arraylen) "arraylen=%d"
 kvm_vcpu_compat_hidden_reg(uint64_t regidx) "0x%"PRIx64" is hidden"
+kvm_arm_init_cpreg_list(uint32_t kvm_regs, uint32_t fake_regs) "%d regs exposed by KVM, %d enforced regs"
+kvm_vcpu_compat_fake_reg(uint64_t regidx) "0x%"PRIx64" is fake"
+kvm_arm_init_cpreg_exposed(uint64_t regidx, uint64_t val, int ret) "enforced reg 0x%"PRIx64" is already exposed by KVM: value=0x%"PRIx64 " ret=%d: nothing to do"
+
-- 
2.49.0


