Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936CDCA0FF0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4co-00054P-VU; Tue, 26 Aug 2025 21:06:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4cR-0004Ne-8s
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:06:32 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4bh-0007Iy-Ks
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:05:49 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-76e434a0118so7242778b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756256742; x=1756861542; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RWOUahuffRODKn11bwqIgWpsGqBtiathLmHpxPmSXXk=;
 b=lFiBRuajLbgyyASD2ewo+hcp7c8cxtW0XuYM+mxJpiGEoITkh9xDOy5upNB90QTWjX
 meJq/0wt5fKDMp4yFO8e4apunWRWoJmjynQIp8KInRJnQ7DLm8QVW4K5wbgwu9bcTHim
 7KGZF67qdjNBLN1KTs7w5vYY9FL3c77812j+bBcy+yDudKGn5gldSaWetcsEEJJNMDJc
 IP44nweyCcn3VyUPedgoQIUjiaEgd+N0yrHODiBWw5Buu/IVKtxFPDYtmDPb+NsQkpKN
 09lrOsq3wm4OLuOW47VGFxy2Wl37q8eiQWh3C52hnrhedbAYhnnraqm+XcfKVcW0+niO
 DDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756256742; x=1756861542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RWOUahuffRODKn11bwqIgWpsGqBtiathLmHpxPmSXXk=;
 b=ni5vAoSiYjI87L+risiWewosafxZ96RCGoI7qa1IVNZQtz0/P7BetPW6moTE3yXX37
 uaDhCv3xwytYoykwwtwYpolwC4VujM0bGF5tNL5ktzo1d/xpxV19L1+cI4IMT2RtdxeI
 sCILngx3aWuhi6VbRV3vCW2LxcmC5isT9rdDEQnViloPVmAjOswMdJk8uAYp5wsTG2lI
 nupIgrZQxQACm1iF+owSDGlJZkZc0jiv13hIIFqWKcOQvkPZB7/S6kfKJo6vbtbd2UE5
 CALXTpE89VNd61Prd9s10miV9D2Bhx8DpbWNOHTu3zw/+Cml3MEd/CKHubwrm6771fBi
 ubGQ==
X-Gm-Message-State: AOJu0Yxt8Gl0qWW8w2+lzUnDeZfWAQXpnrB+7+EZbdDlE8bh1Wn4XBy0
 tPz2kP6q9/ezK5r/bV9e7ehoUPAozJlpll67owWGuJ1FtoE+bU4jgk1MsQ5pRZafVVQzBTuIKZc
 UeZpPiIc=
X-Gm-Gg: ASbGncthqCjsyNAmOK60ys3q+hkvlIgDg7fVi/W4WFOe8Gw2SC4oRToDgEe1S45DkBt
 YPzUG0AktGHPA7ikiwN4NSSxhPCyw51jjBWcJz7T/ZvQLBrbx+mdj66bIHQALStUt69ViPE5he5
 OSK6cFupexVDH18S30OVHbiRfTxbZsR9edSk1PPfTGW1TpDeE+mH/XqHhhRa5mvg0kYHnqsHF2s
 f5MUwXcPb47ZIzcEPDpH2DpoO8VZjsmYsyo0IwOIfLbsRagWmcFs1c6HBx1buFkc3wkl+SHHg3Z
 EfUowfh7y9WhqR5xGJNrwgOANpGVyHXDxSt6pk5bTUNKyH7SfLbA4Jd00ZQt657HpCPHu7uyXjN
 Dp/73Auwn4sPX84ezM6yy3VDmXA==
X-Google-Smtp-Source: AGHT+IG2Md/ERToJJ89SckfrF77Y+ttmZlxzYDlrmMK8aEKe3Drst8M8vh36j5mWke8knPeLxNIO5w==
X-Received: by 2002:a05:6a00:2ea3:b0:771:e3d7:4320 with SMTP id
 d2e1a72fcca58-771e3d752b9mr10636260b3a.19.1756256741782; 
 Tue, 26 Aug 2025 18:05:41 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7720274534esm1419241b3a.47.2025.08.26.18.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:05:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 6/7] target/arm/hvf: Replace hvf_sreg_match with hvf_sreg_list
Date: Wed, 27 Aug 2025 11:03:56 +1000
Message-ID: <20250827010453.4059782-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Change hvf_get_registers and hvf_put_registers to iterate over
cpregs_indexes instead of hvf_sreg_match.

This lets us drop the cp_idx member of hvf_sreg_match, which leaves
only one member in the struct.  Replace the struct with a const array.
Instead of int, use the proper enum type: hv_sys_reg_t.
Rename from hvf_sreg_match to hvf_sreg_list because there is no
longer any matching going on.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/hvf/hvf.c | 45 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 46e52e8d34..647eb675ef 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -394,11 +394,6 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
     { HV_SIMD_FP_REG_Q31, offsetof(CPUARMState, vfp.zregs[31]) },
 };
 
-struct hvf_sreg_match {
-    int reg;
-    uint32_t cp_idx;
-};
-
 /*
  * QEMU uses KVM system register ids in the migration format.
  * Conveniently, HVF uses the same encoding of the op* and cr* parameters
@@ -419,9 +414,9 @@ struct hvf_sreg_match {
 
 #undef DEF_SYSREG
 
-#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2)  { HVF_ID },
+#define DEF_SYSREG(HVF_ID, crn, crm, op0, op1, op2)  HVF_ID,
 
-static struct hvf_sreg_match hvf_sreg_match[] = {
+static const hv_sys_reg_t hvf_sreg_list[] = {
 #include "sysreg.c.inc"
 };
 
@@ -434,7 +429,7 @@ int hvf_get_registers(CPUState *cpu)
     hv_return_t ret;
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
-    int i;
+    int i, n;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         ret = hv_vcpu_get_reg(cpu->accel->fd, hvf_reg_match[i].reg, &val);
@@ -463,13 +458,9 @@ int hvf_get_registers(CPUState *cpu)
     assert_hvf_ok(ret);
     pstate_write(env, val);
 
-    for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
-        int hvf_id = hvf_sreg_match[i].reg;
-        uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
-
-        if (hvf_sreg_match[i].cp_idx == -1) {
-            continue;
-        }
+    for (i = 0, n = arm_cpu->cpreg_array_len; i < n; i++) {
+        uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
+        int hvf_id = KVMID_TO_HVF(kvm_id);
 
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
@@ -553,7 +544,7 @@ int hvf_get_registers(CPUState *cpu)
 
                 val = read_raw_cp_reg(env, ri);
 
-                arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
+                arm_cpu->cpreg_values[i] = val;
                 continue;
             }
             }
@@ -562,7 +553,7 @@ int hvf_get_registers(CPUState *cpu)
         ret = hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_id, &val);
         assert_hvf_ok(ret);
 
-        arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
+        arm_cpu->cpreg_values[i] = val;
     }
     assert(write_list_to_cpustate(arm_cpu));
 
@@ -578,7 +569,7 @@ int hvf_put_registers(CPUState *cpu)
     hv_return_t ret;
     uint64_t val;
     hv_simd_fp_uchar16_t fpval;
-    int i;
+    int i, n;
 
     for (i = 0; i < ARRAY_SIZE(hvf_reg_match); i++) {
         val = *(uint64_t *)((void *)env + hvf_reg_match[i].offset);
@@ -605,12 +596,9 @@ int hvf_put_registers(CPUState *cpu)
     aarch64_save_sp(env, arm_current_el(env));
 
     assert(write_cpustate_to_list(arm_cpu, false));
-    for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
-        int hvf_id = hvf_sreg_match[i].reg;
-
-        if (hvf_sreg_match[i].cp_idx == -1) {
-            continue;
-        }
+    for (i = 0, n = arm_cpu->cpreg_array_len; i < n; i++) {
+        uint64_t kvm_id = arm_cpu->cpreg_indexes[i];
+        int hvf_id = KVMID_TO_HVF(kvm_id);
 
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
@@ -688,7 +676,7 @@ int hvf_put_registers(CPUState *cpu)
             }
         }
 
-        val = arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx];
+        val = arm_cpu->cpreg_values[i];
         ret = hv_vcpu_set_sys_reg(cpu->accel->fd, hvf_id, val);
         assert_hvf_ok(ret);
     }
@@ -899,7 +887,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
     CPUARMState *env = &arm_cpu->env;
-    uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_match);
+    uint32_t sregs_match_len = ARRAY_SIZE(hvf_sreg_list);
     uint32_t sregs_cnt = 0;
     uint64_t pfr;
     hv_return_t ret;
@@ -924,17 +912,14 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* Populate cp list for all known sysregs */
     for (i = 0; i < sregs_match_len; i++) {
-        int hvf_id = hvf_sreg_match[i].reg;
+        hv_sys_reg_t hvf_id = hvf_sreg_list[i];
         uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
         uint32_t key = kvm_to_cpreg_id(kvm_id);
         const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
-            hvf_sreg_match[i].cp_idx = sregs_cnt;
             arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
-        } else {
-            hvf_sreg_match[i].cp_idx = -1;
         }
     }
     arm_cpu->cpreg_array_len = sregs_cnt;
-- 
2.43.0


