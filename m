Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA37CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:19:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298l-0007cw-K0; Fri, 26 Sep 2025 10:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298N-0007CJ-TI
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:16 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2988-0005eF-OC
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46de78b595dso11290045e9.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895735; x=1759500535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cBibtUZWXpQ+45X6TP72VZdFkcxeDblm6hizC7gDVac=;
 b=ZuFBLVRJ04lKbZupy7u7kWpU1vmv9ECRIkJPmkCy8CQEEOkC2wn7Esg3SkmiLrm5rs
 Vn1hN3+ISdxaOd2BvbolH1Osj8QBQxq22ieIgCQGKmABK692dy5rYUhCX3Qi5TgVwnuc
 D+Pu9DbnWIQrGXhX1QbgXV3NoMy1voja5yMnfBrb9uIgNpIOPcKBrbibvKLajGqVzMpQ
 ldPHKI7TgWHqd4qOi89o+AHzoX55ECcKwBw1rpfOfpSUz3Rj3B4q4CQaVVMj2N0om1uI
 SYdSsGRoQZKwGAa/yR9ykBjVJaSjrbsL831L4a0evtS1q4wjwWuC0aHFfyNNhr4WNTJJ
 tkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895735; x=1759500535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cBibtUZWXpQ+45X6TP72VZdFkcxeDblm6hizC7gDVac=;
 b=htVXmv2vECODrRJNCbTT5ygcc0gCBcFk5qVtANGDKPK/ObRpengjlFlMC6iy69RLTQ
 1DMSbrVe9dXShbq/jAEG9laDRTJGJxt7B00te0wO5qYR1+ooSPILkYGweB0fn43N/rzt
 cFW3LzuWeMVqy2mKYVW0twfrBEPQZJCNRgm956Cl+tHq7y4nn9AriLh0g0eDg9QXIXbf
 qQ2NXJERu4ejxURgFkMjbJCEEEDy7d/zbdfpoz6K87PTanubr1MRcfqk13e94rQS8N9E
 6uUQxcXbPvfRVmq2t3ZtZp6OMawkjmfrvBam6RGvBfs/E6iV7wwQyGGY0Cq8VDMQQctd
 ed6w==
X-Gm-Message-State: AOJu0YyEtpCh2rC5zDYTTbzn1WFY3RWGMXJq6XjB34XQERC8f6HKY/nX
 k2WDlkaLb+hWXkegNA7Blkr338H2wiNQkTGkg+U2O/yDp+mklHb4Oy6+RINuRPM2GYGYXhZiPo7
 +Fqk6
X-Gm-Gg: ASbGncullZPdvba4izGPSccYb4e9xQjgdIsnjqqJkRk83EjVKSLGHL8ZN8P0Ycz2dNS
 JSb2Pyezy/p4JgAp9M9Uj8BwYGIdkC8yTiU6J8XRVhmeHUovDYRprBHQi481Ya7p50STXwLygxf
 gxPMFE7fQ0iCpCjT0Eh6Cwsmwks1ZKDImYqJyoeuetyCGnCZmNoP+swwMYoa8z/7//2ZsihXmjC
 m679++/QBQ2S044IDw77SEzFU1Q0VyZcwu5hCaNSSZZEtsIcMNVm3Kdp+rgWnsOTzhYFaT6Bds0
 fj7v4fs5GOcuZlhbTHpCnYAxUFyYnmDihwq8T7Pa6L0X6anBbL0em5WEZluANg/OsOizCwMfyi9
 9o8HjbLBLMVgM0MHGtlylUVNSgAUl
X-Google-Smtp-Source: AGHT+IE5ziMkQkxF6U9OUEMoCijHZ4GRovQcdg0TfIc9wZPHA8C5HJD578toBMsFfq9QsurmX1L1pw==
X-Received: by 2002:a05:600c:19c9:b0:46e:3700:67b1 with SMTP id
 5b1f17b1804b1-46e37006e40mr52640145e9.4.1758895735298; 
 Fri, 26 Sep 2025 07:08:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/44] target/arm/hvf: Remove hvf_sreg_match.key
Date: Fri, 26 Sep 2025 15:08:08 +0100
Message-ID: <20250926140844.1493020-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Use conversion functions instead of table lookup.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 7515e59c56d..98f49ce33a4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -152,9 +152,6 @@ void hvf_arm_init_debug(void)
         g_array_sized_new(true, true, sizeof(HWWatchpoint), max_hw_wps);
 }
 
-#define HVF_SYSREG(crn, crm, op0, op1, op2) \
-        ENCODE_AA64_CP_REG(CP_REG_ARM64_SYSREG_CP, crn, crm, op0, op1, op2)
-
 #define SYSREG_OP0_SHIFT      20
 #define SYSREG_OP0_MASK       0x3
 #define SYSREG_OP0(sysreg)    ((sysreg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK)
@@ -399,7 +396,6 @@ static const struct hvf_reg_match hvf_fpreg_match[] = {
 
 struct hvf_sreg_match {
     int reg;
-    uint32_t key;
     uint32_t cp_idx;
 };
 
@@ -423,8 +419,7 @@ struct hvf_sreg_match {
 
 #undef DEF_SYSREG
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2) \
-    { HVF_ID, HVF_SYSREG(crn, crm, op0, op1, op2) },
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  { HVF_ID },
 
 static struct hvf_sreg_match hvf_sreg_match[] = {
 #include "sysreg.c.inc"
@@ -469,13 +464,16 @@ int hvf_get_registers(CPUState *cpu)
     pstate_write(env, val);
 
     for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
+        int hvf_id = hvf_sreg_match[i].reg;
+        uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+
         if (hvf_sreg_match[i].cp_idx == -1) {
             continue;
         }
 
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
-            switch (hvf_sreg_match[i].reg) {
+            switch (hvf_id) {
             case HV_SYS_REG_DBGBVR0_EL1:
             case HV_SYS_REG_DBGBCR0_EL1:
             case HV_SYS_REG_DBGWVR0_EL1:
@@ -549,8 +547,10 @@ int hvf_get_registers(CPUState *cpu)
                  * vCPU but simply keep the values from the previous
                  * environment.
                  */
-                const ARMCPRegInfo *ri;
-                ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_sreg_match[i].key);
+                uint32_t key = kvm_to_cpreg_id(kvm_id);
+                const ARMCPRegInfo *ri =
+                    get_arm_cp_reginfo(arm_cpu->cp_regs, key);
+
                 val = read_raw_cp_reg(env, ri);
 
                 arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
@@ -559,7 +559,7 @@ int hvf_get_registers(CPUState *cpu)
             }
         }
 
-        ret = hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_sreg_match[i].reg, &val);
+        ret = hv_vcpu_get_sys_reg(cpu->accel->fd, hvf_id, &val);
         assert_hvf_ok(ret);
 
         arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx] = val;
@@ -606,13 +606,15 @@ int hvf_put_registers(CPUState *cpu)
 
     assert(write_cpustate_to_list(arm_cpu, false));
     for (i = 0; i < ARRAY_SIZE(hvf_sreg_match); i++) {
+        int hvf_id = hvf_sreg_match[i].reg;
+
         if (hvf_sreg_match[i].cp_idx == -1) {
             continue;
         }
 
         if (cpu->accel->guest_debug_enabled) {
             /* Handle debug registers */
-            switch (hvf_sreg_match[i].reg) {
+            switch (hvf_id) {
             case HV_SYS_REG_DBGBVR0_EL1:
             case HV_SYS_REG_DBGBCR0_EL1:
             case HV_SYS_REG_DBGWVR0_EL1:
@@ -687,7 +689,7 @@ int hvf_put_registers(CPUState *cpu)
         }
 
         val = arm_cpu->cpreg_values[hvf_sreg_match[i].cp_idx];
-        ret = hv_vcpu_set_sys_reg(cpu->accel->fd, hvf_sreg_match[i].reg, val);
+        ret = hv_vcpu_set_sys_reg(cpu->accel->fd, hvf_id, val);
         assert_hvf_ok(ret);
     }
 
@@ -922,14 +924,15 @@ int hvf_arch_init_vcpu(CPUState *cpu)
 
     /* Populate cp list for all known sysregs */
     for (i = 0; i < sregs_match_len; i++) {
-        const ARMCPRegInfo *ri;
-        uint32_t key = hvf_sreg_match[i].key;
+        int hvf_id = hvf_sreg_match[i].reg;
+        uint64_t kvm_id = HVF_TO_KVMID(hvf_id);
+        uint32_t key = kvm_to_cpreg_id(kvm_id);
+        const ARMCPRegInfo *ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
 
-        ri = get_arm_cp_reginfo(arm_cpu->cp_regs, key);
         if (ri) {
             assert(!(ri->type & ARM_CP_NO_RAW));
             hvf_sreg_match[i].cp_idx = sregs_cnt;
-            arm_cpu->cpreg_indexes[sregs_cnt++] = cpreg_to_kvm_id(key);
+            arm_cpu->cpreg_indexes[sregs_cnt++] = kvm_id;
         } else {
             hvf_sreg_match[i].cp_idx = -1;
         }
-- 
2.43.0


