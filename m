Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11560CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:13:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v298Y-0007Pm-5m; Fri, 26 Sep 2025 10:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298N-0007CK-SW
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:16 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298B-0005eX-ES
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3eebc513678so2334992f8f.1
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895736; x=1759500536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3ZX0c41v1i+yUMBoECquObmsp+0Qst2hYIT7F2Gx2Ow=;
 b=OfAF8T5tJqK7X3hV7aFSUxL10M+ATJMBAfC9juRqp6mBu0t6Ki6bL/Dw4RfY6TpIyw
 SKkcBYB9nYpVWOK6dkYF/UTizYV4egnUbAlzOlviItb835Z5IhWtH1qall1XM6iF9jrW
 bNZuEipNgIiAkgVRAZSxHDkBOHvRKspeREoTeDqzFDsbGIDuJ30t2mGvO5BW6SkEWDrc
 QAWKlqnZrpXIdMQsi35IWd1FDo2OkC8WcYTahERN9Ztt2OFCXEkQkCeyGA2QXQECigLH
 chbW9B+dfFID4W4PLl+SrkZzfR4Xjv0LbjGrSZmk7H0fHl7fxMJu8sI4GKQJkcsdt/lp
 OiHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895736; x=1759500536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ZX0c41v1i+yUMBoECquObmsp+0Qst2hYIT7F2Gx2Ow=;
 b=HZSre7ndp54/QDeukUrI+YIew0G4qw6Iabl3huHf8VIf7Q+LNwfGoPyGDgtA1EGavF
 nSXHYoi83Xd+/fvR9KpQm+pSLHQTcHhlZAAhkIjSGzI/qQ88xLJ8Gz5uAytuNUTdy96G
 lPdvem2hmo/OIuzs73tMD5qeDQbGmLXc6kdW/54OqFtiUHDx0F2BjMm/dDCrLdEiLJPN
 6cHhBjf29PkE6IB9kyQh/zXfomgEJppj1LnvjBCtPRRPoJESmSDnn11Os7yg41zEdaF/
 AFqVI4EZnR9kvWWV55XyxG/CNYgqLuG846fOS/Z1+CDSFefmR4Q+Fm12hXiN0jdRQTO4
 2snQ==
X-Gm-Message-State: AOJu0YxEuffTtJkZXp+f7puita6seTaBp2gRMYdRhaGpNodPD2ESbPnY
 s8PDgZ7wcAoOGMJbW1XPXpK11jDC/42AF7hpwIo9zGmXjflVUDAkyLwaQ0AIhJYqvgcSllk1P7G
 bzUYE
X-Gm-Gg: ASbGnctLbTOOLpxdQKSD0o5ymm//y5vNtNHdQA3qHzMOo0x/gCMhGSW1PahcsDeN+BR
 NzZ/ZdlB+ASlRbwPTwkpsKTiEdyioR1ApHa6cnrujdfYECq3BhDXHnHN9zV3/fxa4+s6i7f7FmS
 FGAo1oVtIPJpicuCS9ULFU0+QfNhdH+CaMSlw/CKm3TXY3xlXOxBIwfeGjBRrKmIDKU1IN36gsh
 ahoZf0rLlY8QMzfHXrosryjUoKD1Jyv8Y/Jp/tuUvmUsXn6ihJLh+xl8ArYLjDFMIjM8pTR4UvR
 JNn9e8OOUyevUjjtDPR7KIE3dohXaRnAj+3dQqSmT7udjpO03bbr/2xgoHdoHOsT2ph+Ut03k6M
 bHY5tIrw6Ranbrf0wMaQ9LipBOCE4
X-Google-Smtp-Source: AGHT+IHnZQn0PUzjIs3PSHxtJ+y64kuVhUAWelmFuTRz5mIvi3Rvqisdn5oOMxr2nQo3io/g3Vb32g==
X-Received: by 2002:a05:6000:2c10:b0:3ec:7583:3b76 with SMTP id
 ffacd0b85a97d-40e4745e9a6mr6744426f8f.22.1758895736254; 
 Fri, 26 Sep 2025 07:08:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.08.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:08:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/44] target/arm/hvf: Replace hvf_sreg_match with hvf_sreg_list
Date: Fri, 26 Sep 2025 15:08:09 +0100
Message-ID: <20250926140844.1493020-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Change hvf_get_registers and hvf_put_registers to iterate over
cpregs_indexes instead of hvf_sreg_match.

This lets us drop the cp_idx member of hvf_sreg_match, which leaves
only one member in the struct.  Replace the struct with a const array.
Instead of int, use the proper enum type: hv_sys_reg_t.
Rename from hvf_sreg_match to hvf_sreg_list because there is no
longer any matching going on.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 45 +++++++++++++++-----------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 98f49ce33a4..b043eac8c62 100644
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
 
-#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  { HVF_ID },
+#define DEF_SYSREG(HVF_ID, op0, op1, crn, crm, op2)  HVF_ID,
 
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


