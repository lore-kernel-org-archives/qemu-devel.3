Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5035CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 01:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3lFQ-0005Ks-56; Tue, 30 Sep 2025 21:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lFJ-0005In-MS
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3lEp-000826-QH
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 21:03:05 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e5b7dfeb0so7059165e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759280549; x=1759885349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WtDeaYzA1MV6zzT9oYsDOCleQdedNz0SYja7ELSAFkY=;
 b=d1Aib1xF9goxnwiMn5MC5gqn5ynB0+OU/wo1H+IbRZQfTQdR1lPUjdNiVzuAg5KKYy
 SqSk+pwunjI6f6CedgLGCxZqZibDgc/bcITkycScu5Jqer11UI79p22iHxIQM0xwlOZd
 GljJTy3iIAhA9PWX1bQnA+bi4lg+blZfpVjYGZmRKmFLuBh9nyAIKhePJBdrjdk68raA
 A29S4lumxkBXb3QFLhzh6TtJiO4HQ+ka4a/RokTDC+JYAMM1+fhtrQqgS5jtko6xTHOs
 71H3hCp6NOR/tuyo/14Y8Ft4/FsVelDCIsJktqeo4gSxKJ0dATC5GGyvakPMa4iimDh/
 ncwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759280549; x=1759885349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WtDeaYzA1MV6zzT9oYsDOCleQdedNz0SYja7ELSAFkY=;
 b=mBvGFGfW1/dKQIUTuruQ2PTWERc1XY/Krh4FH2XqP1Svuz7RTqxtoRYZFNH3mWbmU5
 eT4spSffYYxNcnTluy/u1r9ZCf//D9mrzqDFIqeMqn0dqduV+7NqB6ux4dt4I76m0zrm
 KZIUYRtHO7znD41nvkj9Ljgg5/Hi1eqdQgJ7Wg4J5CfNlwz+EcHf3A5TmTglg2qr62zE
 01KkiKGa461YcJvIfSrHZfwGILfMu0AP7XEQpm+7OnvEtKcUb0Uw0svcbqcDhoQSl4s2
 sGD/JkX6aihMtpJdUzs+uNLQlpQfNCp2DEi0jgYr+ztjZfSV9NiAdKgMapMsQ77KGAbI
 vESA==
X-Gm-Message-State: AOJu0Yx6oYK4JdQl+hNe7ZxTZuO4x82nOU6ytzpjKVbrVeOx3DsfJuFd
 2wSrWex1+iMvnbmT/t2wYfkWl++KtiE/lK27t19/4suV7mPyD7JGihTnH1b+QtundaEWKYMINs9
 8nQ5A06QUgw==
X-Gm-Gg: ASbGncsWd/zxiR81NPNCcwj9dy8jeQKVnIpdGYd1L4xut/+dQlIyGvZwRjfgePh84EU
 +EkUtZ5oCTEf8AjxIqOKrd97ulFVtf3LjZyefFTx4NFZHRBWxhaCu/i1u+wMmgX+J6b8ewOJYJp
 qnZ3YVb1rynLA+6dudI5lVCXIthl6ZIVTFOyvfR0GzxZ8nIvLYQB1wFfN4JaA+YUFyfpTNSs0YK
 Pc7aBuSB3p2z9c/xLRuS0/oORaO72h+EOMHfz8YpH357EX1wiZSVac9NSICxBpzgWA/xrlpMwmh
 YgS5gpB/EBSHbBY3UHIb5idTB9i0q8vddM2RhD4xqpOMxy0kZiJ+pnJEbfMKl/QzkBuWqZJQF6x
 z4A0FL7mOmApLviprLsOgN2QJRKyR0FriFRWztnJnKSwHgYTiS01W3QqMyx2AVc9C9cxC60Usq7
 9HMkeVNeRYDcWSLFPtuLRZdgFJHGt6t3CBmgctRsWI7x4=
X-Google-Smtp-Source: AGHT+IGmImWBLExOHMlhhQZSBnRbv0NKvnMBuXTQlTH3hM2ZcVnond1I1jMy53iy5AXLeDb5OLHr7Q==
X-Received: by 2002:a05:600c:3543:b0:46e:4921:9443 with SMTP id
 5b1f17b1804b1-46e612e3f92mr13058985e9.37.1759280548909; 
 Tue, 30 Sep 2025 18:02:28 -0700 (PDT)
Received: from localhost.localdomain ([90.209.204.182])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm24587426f8f.24.2025.09.30.18.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 18:02:27 -0700 (PDT)
From: salil.mehta@opnsrc.net
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	mst@redhat.com
Cc: salil.mehta@huawei.com, maz@kernel.org, jean-philippe@linaro.org,
 jonathan.cameron@huawei.com, lpieralisi@kernel.org,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 imammedo@redhat.com, armbru@redhat.com, andrew.jones@linux.dev,
 david@redhat.com, philmd@linaro.org, eric.auger@redhat.com,
 will@kernel.org, ardb@kernel.org, oliver.upton@linux.dev,
 pbonzini@redhat.com, gshan@redhat.com, rafael@kernel.org,
 borntraeger@linux.ibm.com, alex.bennee@linaro.org,
 gustavo.romero@linaro.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 linux@armlinux.org.uk, darren@os.amperecomputing.com,
 ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com,
 gankulkarni@os.amperecomputing.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, salil.mehta@opnsrc.net, zhukeqian1@huawei.com,
 wangxiongfeng2@huawei.com, wangyanan55@huawei.com, wangzhou1@hisilicon.com,
 linuxarm@huawei.com, jiakernel2@gmail.com, maobibo@loongson.cn,
 lixianglai@loongson.cn, shahuang@redhat.com, zhao1.liu@intel.com
Subject: [PATCH RFC V6 07/24] arm/gicv3: Refactor CPU interface init for
 shared TCG/KVM use
Date: Wed,  1 Oct 2025 01:01:10 +0000
Message-Id: <20251001010127.3092631-8-salil.mehta@opnsrc.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
References: <20251001010127.3092631-1-salil.mehta@opnsrc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Salil Mehta <salil.mehta@huawei.com>

GICv3 CPU interface initialization currently has separate logic paths for TCG
and KVM accelerators, even though much of the flow—such as iterating over vCPUs
and applying common setup—should be identical. This separation makes it harder
to add new CPU interface features that apply to both backends, as each needs to
be updated individually.

To address this, the common CPU interface setup is now centralized in
‘gicv3_init_cpuif()’, called during GIC realization. Accelerator-specific code
is still handled via a class hook for register-level initialization, but all
iteration and shared setup is unified.

This refactoring is required to:
 - Ensure later patches can set ‘gicc_accessible‘ for all vCPUs in a consistent
   manner.
 - Provide a single entry point for any future common initialization, avoiding
   duplication between TCG and KVM.
 - Maintain correct initialization for both enabled and administratively
   disabled but present vCPUs.

No functional change intended here.

Co-developed-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 hw/intc/arm_gicv3.c                |   1 +
 hw/intc/arm_gicv3_cpuif.c          | 262 ++++++++++++++---------------
 hw/intc/arm_gicv3_cpuif_common.c   |  11 ++
 hw/intc/arm_gicv3_kvm.c            |  12 +-
 hw/intc/gicv3_internal.h           |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 6 files changed, 150 insertions(+), 138 deletions(-)

diff --git a/hw/intc/arm_gicv3.c b/hw/intc/arm_gicv3.c
index 6059ce926a..8ca61413d2 100644
--- a/hw/intc/arm_gicv3.c
+++ b/hw/intc/arm_gicv3.c
@@ -459,6 +459,7 @@ static void arm_gicv3_class_init(ObjectClass *klass, const void *data)
     ARMGICv3Class *agc = ARM_GICV3_CLASS(klass);
 
     agcc->post_load = arm_gicv3_post_load;
+    agcc->init_cpu_reginfo = gicv3_init_cpu_reginfo;
     device_class_set_parent_realize(dc, arm_gic_realize, &agc->parent_realize);
 }
 
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 4b4cf09157..a7904237ac 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3016,154 +3016,150 @@ static void gicv3_cpuif_el_change_hook(ARMCPU *cpu, void *opaque)
     gicv3_cpuif_virt_irq_fiq_update(cs);
 }
 
-void gicv3_init_cpuif(GICv3State *s)
+void gicv3_init_cpu_reginfo(CPUState *cs)
 {
     /* Called from the GICv3 realize function; register our system
      * registers with the CPU
      */
-    int i;
-
-    for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-        GICv3CPUState *cs = &s->cpu[i];
+    ARMCPU *cpu = ARM_CPU(cs);
+    GICv3CPUState *gcs = icc_cs_from_env(&cpu->env);
 
-        /*
-         * If the CPU doesn't define a GICv3 configuration, probably because
-         * in real hardware it doesn't have one, then we use default values
-         * matching the one used by most Arm CPUs. This applies to:
-         *  cpu->gic_num_lrs
-         *  cpu->gic_vpribits
-         *  cpu->gic_vprebits
-         *  cpu->gic_pribits
-         */
+    /*
+     * If the CPU doesn't define a GICv3 configuration, probably because
+     * in real hardware it doesn't have one, then we use default values
+     * matching the one used by most Arm CPUs. This applies to:
+     *  cpu->gic_num_lrs
+     *  cpu->gic_vpribits
+     *  cpu->gic_vprebits
+     *  cpu->gic_pribits
+     */
 
-        /* Note that we can't just use the GICv3CPUState as an opaque pointer
-         * in define_arm_cp_regs_with_opaque(), because when we're called back
-         * it might be with code translated by CPU 0 but run by CPU 1, in
-         * which case we'd get the wrong value.
-         * So instead we define the regs with no ri->opaque info, and
-         * get back to the GICv3CPUState from the CPUARMState.
-         *
-         * These CP regs callbacks can be called from either TCG or HVF code.
-         */
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
+    /* Note that we can't just use the GICv3CPUState as an opaque pointer
+     * in define_arm_cp_regs_with_opaque(), because when we're called back
+     * it might be with code translated by CPU 0 but run by CPU 1, in
+     * which case we'd get the wrong value.
+     * So instead we define the regs with no ri->opaque info, and
+     * get back to the GICv3CPUState from the CPUARMState.
+     *
+     * These CP regs callbacks can be called from either TCG or HVF code.
+     */
+    define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
 
-        /*
-         * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
-         * implement FEAT_GICv3_NMI, which is the CPU interface part
-         * of NMI support. This is distinct from whether the GIC proper
-         * (redistributors and distributor) have NMI support. In QEMU
-         * that is a property of the GIC device in s->nmi_support;
-         * cs->nmi_support indicates the CPU interface's support.
-         */
-        if (cpu_isar_feature(aa64_nmi, cpu)) {
-            cs->nmi_support = true;
-            define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
-        }
+    /*
+     * If the CPU implements FEAT_NMI and FEAT_GICv3 it must also
+     * implement FEAT_GICv3_NMI, which is the CPU interface part
+     * of NMI support. This is distinct from whether the GIC proper
+     * (redistributors and distributor) have NMI support. In QEMU
+     * that is a property of the GIC device in s->nmi_support;
+     * gcs->nmi_support indicates the CPU interface's support.
+     */
+    if (cpu_isar_feature(aa64_nmi, cpu)) {
+        gcs->nmi_support = true;
+        define_arm_cp_regs(cpu, gicv3_cpuif_gicv3_nmi_reginfo);
+    }
 
-        /*
-         * The CPU implementation specifies the number of supported
-         * bits of physical priority. For backwards compatibility
-         * of migration, we have a compat property that forces use
-         * of 8 priority bits regardless of what the CPU really has.
-         */
-        if (s->force_8bit_prio) {
-            cs->pribits = 8;
-        } else {
-            cs->pribits = cpu->gic_pribits ?: 5;
-        }
+    /*
+     * The CPU implementation specifies the number of supported
+     * bits of physical priority. For backwards compatibility
+     * of migration, we have a compat property that forces use
+     * of 8 priority bits regardless of what the CPU really has.
+     */
+    if (gcs->gic->force_8bit_prio) {
+        gcs->pribits = 8;
+    } else {
+        gcs->pribits = cpu->gic_pribits ?: 5;
+    }
 
-        /*
-         * The GICv3 has separate ID register fields for virtual priority
-         * and preemption bit values, but only a single ID register field
-         * for the physical priority bits. The preemption bit count is
-         * always the same as the priority bit count, except that 8 bits
-         * of priority means 7 preemption bits. We precalculate the
-         * preemption bits because it simplifies the code and makes the
-         * parallels between the virtual and physical bits of the GIC
-         * a bit clearer.
-         */
-        cs->prebits = cs->pribits;
-        if (cs->prebits == 8) {
-            cs->prebits--;
-        }
-        /*
-         * Check that CPU code defining pribits didn't violate
-         * architectural constraints our implementation relies on.
-         */
-        g_assert(cs->pribits >= 4 && cs->pribits <= 8);
+    /*
+     * The GICv3 has separate ID register fields for virtual priority
+     * and preemption bit values, but only a single ID register field
+     * for the physical priority bits. The preemption bit count is
+     * always the same as the priority bit count, except that 8 bits
+     * of priority means 7 preemption bits. We precalculate the
+     * preemption bits because it simplifies the code and makes the
+     * parallels between the virtual and physical bits of the GIC
+     * a bit clearer.
+     */
+    gcs->prebits = gcs->pribits;
+    if (gcs->prebits == 8) {
+        gcs->prebits--;
+    }
+    /*
+     * Check that CPU code defining pribits didn't violate
+     * architectural constraints our implementation relies on.
+     */
+    g_assert(gcs->pribits >= 4 && gcs->pribits <= 8);
 
-        /*
-         * gicv3_cpuif_reginfo[] defines ICC_AP*R0_EL1; add definitions
-         * for ICC_AP*R{1,2,3}_EL1 if the prebits value requires them.
-         */
-        if (cs->prebits >= 6) {
-            define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr1_reginfo);
-        }
-        if (cs->prebits == 7) {
-            define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr23_reginfo);
-        }
+    /*
+     * gicv3_cpuif_reginfo[] defines ICC_AP*R0_EL1; add definitions
+     * for ICC_AP*R{1,2,3}_EL1 if the prebits value requires them.
+     */
+    if (gcs->prebits >= 6) {
+        define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr1_reginfo);
+    }
+    if (gcs->prebits == 7) {
+        define_arm_cp_regs(cpu, gicv3_cpuif_icc_apxr23_reginfo);
+    }
 
-        if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
-            int j;
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
+        int j;
 
-            cs->num_list_regs = cpu->gic_num_lrs ?: 4;
-            cs->vpribits = cpu->gic_vpribits ?: 5;
-            cs->vprebits = cpu->gic_vprebits ?: 5;
+        gcs->num_list_regs = cpu->gic_num_lrs ?: 4;
+        gcs->vpribits = cpu->gic_vpribits ?: 5;
+        gcs->vprebits = cpu->gic_vprebits ?: 5;
 
-            /* Check against architectural constraints: getting these
-             * wrong would be a bug in the CPU code defining these,
-             * and the implementation relies on them holding.
-             */
-            g_assert(cs->vprebits <= cs->vpribits);
-            g_assert(cs->vprebits >= 5 && cs->vprebits <= 7);
-            g_assert(cs->vpribits >= 5 && cs->vpribits <= 8);
+        /* Check against architectural constraints: getting these
+         * wrong would be a bug in the CPU code defining these,
+         * and the implementation relies on them holding.
+         */
+        g_assert(gcs->vprebits <= gcs->vpribits);
+        g_assert(gcs->vprebits >= 5 && gcs->vprebits <= 7);
+        g_assert(gcs->vpribits >= 5 && gcs->vpribits <= 8);
 
-            define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
+        define_arm_cp_regs(cpu, gicv3_cpuif_hcr_reginfo);
 
-            for (j = 0; j < cs->num_list_regs; j++) {
-                /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
-                 * are split into two cp15 regs, LR (the low part, with the
-                 * same encoding as the AArch64 LR) and LRC (the high part).
-                 */
-                ARMCPRegInfo lr_regset[] = {
-                    { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
-                      .opc0 = 3, .opc1 = 4, .crn = 12,
-                      .crm = 12 + (j >> 3), .opc2 = j & 7,
-                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
-                      .nv2_redirect_offset = 0x400 + 8 * j,
-                      .access = PL2_RW,
-                      .readfn = ich_lr_read,
-                      .writefn = ich_lr_write,
-                    },
-                    { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
-                      .cp = 15, .opc1 = 4, .crn = 12,
-                      .crm = 14 + (j >> 3), .opc2 = j & 7,
-                      .type = ARM_CP_IO | ARM_CP_NO_RAW,
-                      .access = PL2_RW,
-                      .readfn = ich_lr_read,
-                      .writefn = ich_lr_write,
-                    },
-                };
-                define_arm_cp_regs(cpu, lr_regset);
-            }
-            if (cs->vprebits >= 6) {
-                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
-            }
-            if (cs->vprebits == 7) {
-                define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
-            }
-        }
-        if (tcg_enabled() || qtest_enabled()) {
-            /*
-             * We can only trap EL changes with TCG. However the GIC interrupt
-             * state only changes on EL changes involving EL2 or EL3, so for
-             * the non-TCG case this is OK, as EL2 and EL3 can't exist.
+        for (j = 0; j < gcs->num_list_regs; j++) {
+            /* Note that the AArch64 LRs are 64-bit; the AArch32 LRs
+             * are split into two cp15 regs, LR (the low part, with the
+             * same encoding as the AArch64 LR) and LRC (the high part).
              */
-            arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, cs);
-        } else {
-            assert(!arm_feature(&cpu->env, ARM_FEATURE_EL2));
-            assert(!arm_feature(&cpu->env, ARM_FEATURE_EL3));
-        }
+            ARMCPRegInfo lr_regset[] = {
+                { .name = "ICH_LRn_EL2", .state = ARM_CP_STATE_BOTH,
+                  .opc0 = 3, .opc1 = 4, .crn = 12,
+                  .crm = 12 + (j >> 3), .opc2 = j & 7,
+                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                  .nv2_redirect_offset = 0x400 + 8 * j,
+                  .access = PL2_RW,
+                  .readfn = ich_lr_read,
+                  .writefn = ich_lr_write,
+                },
+                { .name = "ICH_LRCn_EL2", .state = ARM_CP_STATE_AA32,
+                  .cp = 15, .opc1 = 4, .crn = 12,
+                  .crm = 14 + (j >> 3), .opc2 = j & 7,
+                  .type = ARM_CP_IO | ARM_CP_NO_RAW,
+                  .access = PL2_RW,
+                  .readfn = ich_lr_read,
+                  .writefn = ich_lr_write,
+                },
+            };
+            define_arm_cp_regs(cpu, lr_regset);
+        }
+        if (gcs->vprebits >= 6) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr1_reginfo);
+        }
+        if (gcs->vprebits == 7) {
+            define_arm_cp_regs(cpu, gicv3_cpuif_ich_apxr23_reginfo);
+        }
+    }
+    if (tcg_enabled() || qtest_enabled()) {
+        /*
+         * We can only trap EL changes with TCG. However the GIC interrupt
+         * state only changes on EL changes involving EL2 or EL3, so for
+         * the non-TCG case this is OK, as EL2 and EL3 can't exist.
+         */
+        arm_register_el_change_hook(cpu, gicv3_cpuif_el_change_hook, gcs);
+    } else {
+        assert(!arm_feature(&cpu->env, ARM_FEATURE_EL2));
+        assert(!arm_feature(&cpu->env, ARM_FEATURE_EL3));
     }
 }
diff --git a/hw/intc/arm_gicv3_cpuif_common.c b/hw/intc/arm_gicv3_cpuif_common.c
index ff1239f65d..f9a9b2d8a3 100644
--- a/hw/intc/arm_gicv3_cpuif_common.c
+++ b/hw/intc/arm_gicv3_cpuif_common.c
@@ -20,3 +20,14 @@ void gicv3_set_gicv3state(CPUState *cpu, GICv3CPUState *s)
 
     env->gicv3state = (void *)s;
 };
+
+void gicv3_init_cpuif(GICv3State *s)
+{
+    ARMGICv3CommonClass *agcc = ARM_GICV3_COMMON_GET_CLASS(s);
+    int i;
+
+    /* define and register `system registers` with the vCPU  */
+    for (i = 0; i < s->num_cpu; i++) {
+        agcc->init_cpu_reginfo(s->cpu[i].cpu);
+    }
+}
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6166283cd1..4ca889da45 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -776,6 +776,10 @@ static void vm_change_state_handler(void *opaque, bool running,
     }
 }
 
+static void kvm_gicv3_init_cpu_reginfo(CPUState *cs)
+{
+    define_arm_cp_regs(ARM_CPU(cs), gicv3_cpuif_reginfo);
+}
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
@@ -811,11 +815,8 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
-    for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
-
-        define_arm_cp_regs(cpu, gicv3_cpuif_reginfo);
-    }
+    /* initialize vCPU interface */
+    gicv3_init_cpuif(s);
 
     /* Try to create the device via the device control API */
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_V3, false);
@@ -929,6 +930,7 @@ static void kvm_arm_gicv3_class_init(ObjectClass *klass, const void *data)
 
     agcc->pre_save = kvm_arm_gicv3_get;
     agcc->post_load = kvm_arm_gicv3_put;
+    agcc->init_cpu_reginfo = kvm_gicv3_init_cpu_reginfo;
     device_class_set_parent_realize(dc, kvm_arm_gicv3_realize,
                                     &kgc->parent_realize);
     resettable_class_set_parent_phases(rc, NULL, kvm_arm_gicv3_reset_hold, NULL,
diff --git a/hw/intc/gicv3_internal.h b/hw/intc/gicv3_internal.h
index bc9f518fe8..cc8edc499b 100644
--- a/hw/intc/gicv3_internal.h
+++ b/hw/intc/gicv3_internal.h
@@ -722,6 +722,7 @@ void gicv3_redist_vinvall(GICv3CPUState *cs, uint64_t vptaddr);
 
 void gicv3_redist_send_sgi(GICv3CPUState *cs, int grp, int irq, bool ns);
 void gicv3_init_cpuif(GICv3State *s);
+void gicv3_init_cpu_reginfo(CPUState *cs);
 
 /**
  * gicv3_cpuif_update:
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c18503869f..3720728227 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -313,6 +313,7 @@ struct ARMGICv3CommonClass {
 
     void (*pre_save)(GICv3State *s);
     void (*post_load)(GICv3State *s);
+    void (*init_cpu_reginfo)(CPUState *cs);
 };
 
 void gicv3_init_irqs_and_mmio(GICv3State *s, qemu_irq_handler handler,
-- 
2.34.1


