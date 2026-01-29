Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCEDD6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaw-00017a-HY; Thu, 29 Jan 2026 11:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUat-0000p5-Lg
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:07 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUar-00074g-P9
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:07 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so1139943f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769703004; x=1770307804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iDghPW5CxBXO9mC8DhlYzxtsMzpsZXCT4re3Q+rFilk=;
 b=rjSc977exSI85yvG6YiLTsfVHaOB0Lcl08lYehocANIP/oi4ZS5vrXwIUG/DQzSepV
 rKflxrWbPEiYGreoBdncw4IjLFdOhO8SewnQ/D8Iwok8aGbX74NgaOg1OfwQm+1Hw7pK
 fiN8D3xJl8AIl1UlzY4eiaiiolqYlV6NcIoCTLDYsVT8ag7eI8lrwCfX3vjsY5LVDAlF
 S6y5oYezrwddCQvW5+i9x/Pfcf5lxw7R7TNH41eC9UZFJXhdIBXFfVcIO437+7YVmKxM
 dEcCgdYNPt4ESNMcvy419VAl1h633HrIqKWOz5SSvsUASlbdy2C5sbqcFZj2Jyzn/aOY
 MEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769703004; x=1770307804;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iDghPW5CxBXO9mC8DhlYzxtsMzpsZXCT4re3Q+rFilk=;
 b=hpIEFWREkBMbdWj/N56VKGq6ZrkDOYpUdGXFibtIRp+qumNLsF3I7rURHNflPiMMeK
 I+eVZTVyS380NW+nOts9cctoMinD9TuxnL6TYTr5T+05PsOkbetNFuwmawZzKFXPPgU+
 dK3qb10yRjrDlQ9NzxTbjCnE95YRNgV52+B+KHLZKx/wu81nx1O+dpBG/WKldsCqb77M
 FGPwZYiNVoKQiU2klifWj8EATMx5d0PG60I5lb4dkrc11cIVH3D2nCYfRpybslNKvkw2
 0kTckleE8hgmj4RcnWxwwsJS5oxJav8C6AyF5/CNuPWAyvxQ/vXW+THKhFjKE3wLrnP4
 6JbQ==
X-Gm-Message-State: AOJu0Yxg9gb7jPAykAPj62SkoSQkhrX/p0I0GqphhAvjgEZ4t8kMbbZs
 zZVDKOPG0BEfLvT8MKTxUAGXApUHaIPkjXdjlX+R/+Fka8jNeccX+SZgrj7N5j8i0stNKZCI7+J
 wf9kfetM=
X-Gm-Gg: AZuq6aLwCd+o31eRYzjW+ROhpTj1qvu9key91SbsNchzkV8LzkpUq15YSW5cUSOTjlV
 z1eqNASJTKrBZiwYnBFTFEGUn6eI6ME4H+yfbldE82Dk2xptWOogPWuOo5bBuoNUYsB0AH2LUi1
 mdwAqxqmhl4Asa9LZKF6lIbpGDtxoA4GwlX8B68fiOV6NDxMQAXAnCFu94vTB+SbzPNcCmR4lzg
 D+iYeTe8IQEFta3pneI6RSLWUkCWsDsuWiwUypvP+JeKqJRH3kzTb/6WT/rulXD3QebZyrB/cjW
 V4JtaDFeXJgGDjyUN0wHUDQvI+CeoHu4OcL1Bivfv+GHmmzN1dVGFAHtbyplFJLxTggQmMC4QSp
 nYFjOU9MuDKSjvsP71XSLMWerDhyPnytxsh/Bc1JXcwUmnLZYhnrKkuEzfdot0aBj6GD+slgzFn
 ZsLLUyTkWa+CcnE9hxXG99pacWUxKopzuV9xBggO/d
X-Received: by 2002:a05:6000:310c:b0:435:9770:9ec8 with SMTP id
 ffacd0b85a97d-435f3aa9ec7mr154863f8f.32.1769703004022; 
 Thu, 29 Jan 2026 08:10:04 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.10.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:10:03 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 38/43] target/arm/hvf: Move hvf_sysreg_[read,
 write]_cp() functions around
Date: Thu, 29 Jan 2026 16:09:12 +0000
Message-ID: <20260129160917.1415092-39-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Next commit will use these functions prototype earlier. Rather
than forward-declaring them, move them around.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Message-id: 20260118215945.46693-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 142 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index e4c0d936f1..fcb7fa3b30 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -423,6 +423,77 @@ static const hv_sys_reg_t hvf_sreg_list[] = {
 
 #undef DEF_SYSREG
 
+static uint32_t hvf_reg2cp_reg(uint32_t reg)
+{
+    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
+                              (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
+                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
+                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
+                              (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
+}
+
+static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
+                               uint32_t reg, uint64_t *val)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const ARMCPRegInfo *ri;
+
+    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
+    if (ri) {
+        if (!cp_access_ok(1, ri, true)) {
+            return false;
+        }
+        if (ri->accessfn) {
+            if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
+                return false;
+            }
+        }
+        if (ri->type & ARM_CP_CONST) {
+            *val = ri->resetvalue;
+        } else if (ri->readfn) {
+            *val = ri->readfn(env, ri);
+        } else {
+            *val = raw_read(env, ri);
+        }
+        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
+        return true;
+    }
+
+    return false;
+}
+
+static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
+                                uint32_t reg, uint64_t val)
+{
+    ARMCPU *arm_cpu = ARM_CPU(cpu);
+    CPUARMState *env = &arm_cpu->env;
+    const ARMCPRegInfo *ri;
+
+    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
+
+    if (ri) {
+        if (!cp_access_ok(1, ri, false)) {
+            return false;
+        }
+        if (ri->accessfn) {
+            if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
+                return false;
+            }
+        }
+        if (ri->writefn) {
+            ri->writefn(env, ri, val);
+        } else {
+            raw_write(env, ri, val);
+        }
+
+        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
+        return true;
+    }
+
+    return false;
+}
+
 int hvf_arch_get_registers(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1161,46 +1232,6 @@ static bool is_id_sysreg(uint32_t reg)
            SYSREG_CRM(reg) < 8;
 }
 
-static uint32_t hvf_reg2cp_reg(uint32_t reg)
-{
-    return ENCODE_AA64_CP_REG((reg >> SYSREG_OP0_SHIFT) & SYSREG_OP0_MASK,
-                              (reg >> SYSREG_OP1_SHIFT) & SYSREG_OP1_MASK,
-                              (reg >> SYSREG_CRN_SHIFT) & SYSREG_CRN_MASK,
-                              (reg >> SYSREG_CRM_SHIFT) & SYSREG_CRM_MASK,
-                              (reg >> SYSREG_OP2_SHIFT) & SYSREG_OP2_MASK);
-}
-
-static bool hvf_sysreg_read_cp(CPUState *cpu, const char *cpname,
-                               uint32_t reg, uint64_t *val)
-{
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
-    const ARMCPRegInfo *ri;
-
-    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
-    if (ri) {
-        if (!cp_access_ok(1, ri, true)) {
-            return false;
-        }
-        if (ri->accessfn) {
-            if (ri->accessfn(env, ri, true) != CP_ACCESS_OK) {
-                return false;
-            }
-        }
-        if (ri->type & ARM_CP_CONST) {
-            *val = ri->resetvalue;
-        } else if (ri->readfn) {
-            *val = ri->readfn(env, ri);
-        } else {
-            *val = raw_read(env, ri);
-        }
-        trace_hvf_emu_reginfo_read(cpname, ri->name, *val);
-        return true;
-    }
-
-    return false;
-}
-
 static int hvf_sysreg_read(CPUState *cpu, uint32_t reg, uint64_t *val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -1454,37 +1485,6 @@ static void pmswinc_write(CPUARMState *env, uint64_t value)
     }
 }
 
-static bool hvf_sysreg_write_cp(CPUState *cpu, const char *cpname,
-                                uint32_t reg, uint64_t val)
-{
-    ARMCPU *arm_cpu = ARM_CPU(cpu);
-    CPUARMState *env = &arm_cpu->env;
-    const ARMCPRegInfo *ri;
-
-    ri = get_arm_cp_reginfo(arm_cpu->cp_regs, hvf_reg2cp_reg(reg));
-
-    if (ri) {
-        if (!cp_access_ok(1, ri, false)) {
-            return false;
-        }
-        if (ri->accessfn) {
-            if (ri->accessfn(env, ri, false) != CP_ACCESS_OK) {
-                return false;
-            }
-        }
-        if (ri->writefn) {
-            ri->writefn(env, ri, val);
-        } else {
-            raw_write(env, ri, val);
-        }
-
-        trace_hvf_emu_reginfo_write(cpname, ri->name, val);
-        return true;
-    }
-
-    return false;
-}
-
 static int hvf_sysreg_write(CPUState *cpu, uint32_t reg, uint64_t val)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
-- 
2.43.0


