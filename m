Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688C1D262B0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 07:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viSxl-0004Y5-BZ; Wed, 21 Jan 2026 02:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSxd-0004Vs-Nd
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1viSxb-0003Rn-NN
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 02:49:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768981743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vocxVT7YCKzPjeXzWh1+L4bHuMZRKOWWYk7R3HWIrCY=;
 b=BnvITgn7IJIVjFEsN4ipYOIL6i0OsKH0cP5Ubo/kzpAnSyW9fmM9b5i74yGU0Rg+nxaZrE
 KcZ4cx60F4V2FG/pzQu+TUK2C/SIaA33lkTejrMn3GAeL5/3eFWajaQN9kJsZ3f73VAmyC
 UfzB2rAbvP9vOQPk0m4uPguF2N/wH9Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-425-SllJ6i5VMCudEK7qtis1qA-1; Wed,
 21 Jan 2026 02:48:58 -0500
X-MC-Unique: SllJ6i5VMCudEK7qtis1qA-1
X-Mimecast-MFC-AGG-ID: SllJ6i5VMCudEK7qtis1qA_1768981737
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 978B9195608E; Wed, 21 Jan 2026 07:48:57 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBFA419560A2; Wed, 21 Jan 2026 07:48:52 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, cohuck@redhat.com,
 maz@kernel.org, oliver.upton@linux.dev, sebott@redhat.com,
 gshan@redhat.com, ddutile@redhat.com, peterx@redhat.com, philmd@linaro.org,
 pbonzini@redhat.com
Subject: [PATCH v5 03/11] target/arm/cpu: Allow registers to be hidden
Date: Wed, 21 Jan 2026 08:46:40 +0100
Message-ID: <20260121074834.1900677-4-eric.auger@redhat.com>
In-Reply-To: <20260121074834.1900677-1-eric.auger@redhat.com>
References: <20260121074834.1900677-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

More recent kernels sometimes expose new registers in an
unconditionnal manner. This situation breaks backward migration
as qemu notices there are more registers in the input stream
than supported on the destination host. This leads to a
"failed to load cpu:cpreg_vmstate_array_len" error.

A good example is the introduction of KVM_REG_ARM_VENDOR_HYP_BMAP_2
pseudo FW register in v6.16 by commit C0000e58c74e (“KVM: arm64:
Introduce KVM_REG_ARM_VENDOR_HYP_BMAP_2”). Trying to do backward
migration from a host kernel that features the commit to a destination
host that doesn't, fail with above error.

Currently QEMU is not using that feature so ignoring this latter
is not a problem. An easy way to fix the migration issue is to teach
qemu we don't care about that register and we can simply ignore it
when syncing its state during migration.

This patch introduces an array of such hidden registers. Soon it will
be settable through an array property.

If hidden, the register is moved out of the array of cpreg which is
built in kvm_arm_init_cpreg_list(). That way their state won't be
synced.

To extend that functionality to TCG, do the same in add_cpreg_to_list()
and count_cpreg().

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Sebastian Ott <sebott@redhat.com>

---
v2 -> v3:
- use kvm_regidx

v1 -> v2:
- Move the property in a separate patch
- improve the commit msg
- change the trace point to just print info in
  kvm_arm_init_cpreg_list()
- improve comment in cpu.h (Connie)

target/arm/helper: Skip hidden registers

In case a cpreg is hidden, skip it when initialing the cpreg
list.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu.h        | 20 ++++++++++++++++++++
 target/arm/helper.c     | 12 +++++++++++-
 target/arm/kvm.c        | 12 +++++++++++-
 target/arm/trace-events |  2 ++
 4 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 7f67c42cfd7..b80f77d3743 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1045,6 +1045,15 @@ struct ArchCPU {
     /* KVM steal time */
     OnOffAuto kvm_steal_time;
 
+    /*
+     * Array of register indexes that need to be hidden to allow migration
+     * in certain cases, i.e. when a register is exposed in KVM or defined
+     * in TCG but not actually used in QEMU. Indexes are described in Linux
+     * Documentation/virt/kvm/api.rst for both KVM and TCG.
+     */
+    uint64_t *hidden_regs;
+    uint32_t nr_hidden_regs;
+
     /* Uniprocessor system with MP extensions */
     bool mp_is_up;
 
@@ -1185,6 +1194,17 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
+static inline bool
+arm_cpu_hidden_reg(ARMCPU *cpu, uint64_t regidx)
+{
+    for (int i = 0; i < cpu->nr_hidden_regs; i++) {
+        if (cpu->hidden_regs[i] == regidx) {
+            return true;
+        }
+    }
+    return false;
+}
+
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index dce648b4824..8217517150b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -235,9 +235,13 @@ static void add_cpreg_to_list(gpointer key, gpointer value, gpointer opaque)
     ARMCPU *cpu = opaque;
     uint32_t regidx = (uintptr_t)key;
     const ARMCPRegInfo *ri = value;
+    uint64_t kvm_regidx = cpreg_to_kvm_id(regidx);
 
+    if (arm_cpu_hidden_reg(cpu, kvm_regidx)) {
+        return;
+    }
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
-        cpu->cpreg_indexes[cpu->cpreg_array_len] = cpreg_to_kvm_id(regidx);
+        cpu->cpreg_indexes[cpu->cpreg_array_len] = kvm_regidx;
         /* The value array need not be initialized at this point */
         cpu->cpreg_array_len++;
     }
@@ -247,6 +251,12 @@ static void count_cpreg(gpointer key, gpointer value, gpointer opaque)
 {
     ARMCPU *cpu = opaque;
     const ARMCPRegInfo *ri = value;
+    uint32_t regidx = (uintptr_t)key;
+    uint64_t kvm_regidx = cpreg_to_kvm_id(regidx);
+
+    if (arm_cpu_hidden_reg(cpu, kvm_regidx)) {
+        return;
+    }
 
     if (!(ri->type & (ARM_CP_NO_RAW | ARM_CP_ALIAS))) {
         cpu->cpreg_array_len++;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c6f0d0fc4e1..7e0a3680748 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -789,7 +789,10 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
     qsort(&rlp->reg, rlp->n, sizeof(rlp->reg[0]), compare_u64);
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
-        if (!kvm_arm_reg_syncs_via_cpreg_list(rlp->reg[i])) {
+        uint64_t regidx = rlp->reg[i];
+
+        if (!kvm_arm_reg_syncs_via_cpreg_list(regidx) ||
+            arm_cpu_hidden_reg(cpu, regidx)) {
             continue;
         }
         switch (rlp->reg[i] & KVM_REG_SIZE_MASK) {
@@ -805,6 +808,8 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
         arraylen++;
     }
 
+    trace_kvm_arm_init_cpreg_list_arraylen(arraylen);
+
     cpu->cpreg_indexes = g_renew(uint64_t, cpu->cpreg_indexes, arraylen);
     cpu->cpreg_values = g_renew(uint64_t, cpu->cpreg_values, arraylen);
     cpu->cpreg_vmstate_indexes = g_renew(uint64_t, cpu->cpreg_vmstate_indexes,
@@ -816,9 +821,14 @@ static int kvm_arm_init_cpreg_list(ARMCPU *cpu)
 
     for (i = 0, arraylen = 0; i < rlp->n; i++) {
         uint64_t regidx = rlp->reg[i];
+
         if (!kvm_arm_reg_syncs_via_cpreg_list(regidx)) {
             continue;
         }
+        if (arm_cpu_hidden_reg(cpu, regidx)) {
+            trace_kvm_arm_init_cpreg_list_skip_hidden_reg(rlp->reg[i]);
+            continue;
+        }
         cpu->cpreg_indexes[arraylen] = regidx;
         arraylen++;
     }
diff --git a/target/arm/trace-events b/target/arm/trace-events
index 0a5ed3e69d5..20f4b4f2cd0 100644
--- a/target/arm/trace-events
+++ b/target/arm/trace-events
@@ -14,6 +14,8 @@ arm_gt_update_irq(int timer, int irqstate) "gt_update_irq: timer %d irqstate %d"
 # kvm.c
 kvm_arm_fixup_msi_route(uint64_t iova, uint64_t gpa) "MSI iova = 0x%"PRIx64" is translated into 0x%"PRIx64
 kvm_arm_cpu_post_load_missing_reg(char *name) "Missing register in input stream: %s"
+kvm_arm_init_cpreg_list_arraylen(uint32_t arraylen) "arraylen=%d"
+kvm_arm_init_cpreg_list_skip_hidden_reg(uint64_t regidx) "hidden 0x%"PRIx64" is skipped"
 
 # cpu.c
 arm_cpu_reset(uint64_t mp_aff) "cpu %" PRIu64
-- 
2.52.0


