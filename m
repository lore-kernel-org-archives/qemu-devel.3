Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D5B3C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewh-0002s6-9v; Mon, 24 Mar 2025 06:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewS-0002lY-ES
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewI-00070K-2w
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:55 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e6ff035e9aso7771912a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811708; x=1743416508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u48Ps24sxm/UA6HDLANAAPrFnpXIZhtYmXPm5ePf1Zo=;
 b=Zd9q2OoUyHnBJxZKAyTuM8aS3H0Rb7DJpDTWVTIOty47ZiHePwCDrOIufpU6iOjR2A
 b2ndvaiLot00onndqZmEakYXW5V3QrWVTuCf2qIs8YR5SiuCR47DhThXnvj90EBAbgg7
 R6ZIAXpvRtVGOFPysfacAKN9kA2wnMYu921DdEY4DG9wXrlB01wow1arOSLY2vvPXzq/
 lKUVneS8jLtsLpKwcmtpPSY4bUHH6IaNjhwLf5isCeCwYhzEYPpQdDBwTSbAwScQI9ky
 TbJniKEti7m8YXQOUDedbkq1ZFLdDyHssXwiIUxLh107gOKlmiXdR1HR9o4a0F1cE0u1
 1zYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811708; x=1743416508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u48Ps24sxm/UA6HDLANAAPrFnpXIZhtYmXPm5ePf1Zo=;
 b=MkOWiTWuQxTDsTI2yaoZIMG/o7HgLyfl4q+AwbI76XmfeE9ztr5dCH7HYoGZJFhvUl
 bQXMOLZQN8x5/oh5thQyZaCCiwtv0AwNgAB/knxnmdEZt6GATkyEa9E3DnZHrJJhMzYk
 d+PQBRM/psaQ+gewFmbVbOmWPICT4F8B7sTcwM9WSys4Nts2XMRHw1XaizBwF9FzXSEt
 pLFxceHVshnHf7Bjra3AivOygofKOXQFh+08qiQEvH/AcP+oM4AhatgZrdCPhmdz/fWY
 DzHyfDO5mNCnZqhDfYKOnoH6GAaPypoXRlICDFLNsihfSGV9Fh3fUUsQ7uPCj9IECsq3
 6Yow==
X-Gm-Message-State: AOJu0Yxz4f9FCWzBLlzuvYeTOe+Da3XX45qjp/Vlr3pE+m9xvmeAA9hr
 UhHW7saKEZKbhk8zaIgTNxkjWvM/AEHNM2s2JPl+1Y3gRTkVU4xcx+SMwrJFixo=
X-Gm-Gg: ASbGncumD4SzfmW7vdXS9TidKqSaFB1fH2LX0+C5HaEN+0/Q/akBxDzpNUEp/y+yWae
 eTs0qVEPUXcaCvpOWcq3SXfmvfSmLTei+irhP4TLhvPS5vKO1ML/Romh0DJItZFJMw4OZc05lhW
 dDKfHQXpxik1Gj/VGSZiQztOXlmQY1yznXhTA182lPBiv89sgnbA1LyMS8JxB5PYWc25Qpo4Pde
 M/yTbevavLhAPKdSMf6s7SeEvjhuUTSXuBR8sSOREnO1PNCilFdF89wPBgZe5iqwVL4U35b9Biz
 ScvM+ej/t2xqPmrp/ZNjwWUUNVSi+4jlnLmUURszdfyFtE7Ib1pkcu+SRw==
X-Google-Smtp-Source: AGHT+IEwua52C4RPesmyaGlRb+Z/zf/TNF62Ig2vgKkEa09zQ20VPcoOpjYfl+0DH8yyYAuYJZVM0w==
X-Received: by 2002:a05:6402:5c9:b0:5e6:13a0:2321 with SMTP id
 4fb4d7f45d1cf-5ebcd52d0dcmr9621665a12.32.1742811707977; 
 Mon, 24 Mar 2025 03:21:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ebccf68308sm5823794a12.5.2025.03.24.03.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2CD3B5FC1A;
 Mon, 24 Mar 2025 10:21:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 06/11] target/arm: convert 64 bit gdbstub to new helpers
Date: Mon, 24 Mar 2025 10:21:37 +0000
Message-Id: <20250324102142.67022-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For some of the helpers we need a temporary variable to copy from
although we could add some helpers to return pointers into env in
those cases if we wanted to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use MO32/MO64 varients for reg sizes
  - use wrappers for 32/64 bit regs
  - do SVE Z registers in 128bit chunks
---
 target/arm/gdbstub64.c | 53 ++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 1a4dbec567..6ad10368e8 100644
--- a/target/arm/gdbstub64.c
+++ b/target/arm/gdbstub64.c
@@ -20,7 +20,7 @@
 #include "qemu/log.h"
 #include "cpu.h"
 #include "internals.h"
-#include "gdbstub/helpers.h"
+#include "gdbstub/registers.h"
 #include "gdbstub/commands.h"
 #include "tcg/mte_helper.h"
 #if defined(CONFIG_USER_ONLY) && defined(CONFIG_LINUX)
@@ -32,18 +32,21 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    MemOp mop = MO_TE; /* TE = LE for registers despite SCTLR.EE/E0E */
+    uint32_t pstate;
 
     if (n < 31) {
         /* Core integer register.  */
-        return gdb_get_reg64(mem_buf, env->xregs[n]);
+        return gdb_get_reg64_value(mop | MO_64, mem_buf, &env->xregs[n]);
     }
     switch (n) {
     case 31:
-        return gdb_get_reg64(mem_buf, env->xregs[31]);
+        return gdb_get_reg64_value(mop | MO_64, mem_buf, &env->xregs[31]);
     case 32:
-        return gdb_get_reg64(mem_buf, env->pc);
+        return gdb_get_reg64_value(mop | MO_64, mem_buf, &env->pc);
     case 33:
-        return gdb_get_reg32(mem_buf, pstate_read(env));
+        pstate = pstate_read(env);
+        return gdb_get_reg32_value(mop | MO_32, mem_buf, &pstate);
     }
     /* Unknown register.  */
     return 0;
@@ -82,23 +85,27 @@ int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    uint32_t fpr;
 
     switch (reg) {
     case 0 ... 31:
     {
         /* 128 bit FP register - quads are in LE order */
         uint64_t *q = aa64_vfp_qreg(env, reg);
-        return gdb_get_reg128(buf, q[1], q[0]);
+        return gdb_get_register_value(MO_TE | MO_128, buf, q);
     }
     case 32:
         /* FPSR */
-        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+        fpr = vfp_get_fpsr(env);
+        break;
     case 33:
         /* FPCR */
-        return gdb_get_reg32(buf, vfp_get_fpcr(env));
+        fpr = vfp_get_fpcr(env);
+        break;
     default:
         return 0;
     }
+    return gdb_get_reg32_value(MO_TE | MO_32, buf, &fpr);
 }
 
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
@@ -132,30 +139,35 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
+    MemOp mop = MO_TE; /* TE = LE for registers despite SCTLR.EE/E0E */
+    uint32_t fpr;
 
     switch (reg) {
     /* The first 32 registers are the zregs */
     case 0 ... 31:
     {
         int vq, len = 0;
+        ARMVectorReg *zreg = &env->vfp.zregs[reg];
+
         for (vq = 0; vq < cpu->sve_max_vq; vq++) {
-            len += gdb_get_reg128(buf,
-                                  env->vfp.zregs[reg].d[vq * 2 + 1],
-                                  env->vfp.zregs[reg].d[vq * 2]);
+            len += gdb_get_register_value(mop | MO_128, buf, &zreg->d[vq * 2]);
         }
         return len;
     }
     case 32:
-        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+        fpr = vfp_get_fpsr(env);
+        return gdb_get_reg32_value(mop | MO_32, buf, &fpr);
     case 33:
-        return gdb_get_reg32(buf, vfp_get_fpcr(env));
+        fpr = vfp_get_fpcr(env);
+        return gdb_get_reg32_value(mop | MO_32, buf, &fpr);
     /* then 16 predicates and the ffr */
     case 34 ... 50:
     {
         int preg = reg - 34;
         int vq, len = 0;
         for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
-            len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
+            len += gdb_get_reg64_value(mop | MO_64, buf,
+                                       &env->vfp.pregs[preg].p[vq / 4]);
         }
         return len;
     }
@@ -165,8 +177,8 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
          * We report in Vector Granules (VG) which is 64bit in a Z reg
          * while the ZCR works in Vector Quads (VQ) which is 128bit chunks.
          */
-        int vq = sve_vqm1_for_el(env, arm_current_el(env)) + 1;
-        return gdb_get_reg64(buf, vq * 2);
+        uint64_t vq = (sve_vqm1_for_el(env, arm_current_el(env)) + 1) * 2;
+        return gdb_get_reg64_value(mop | MO_64, buf, &vq);
     }
     default:
         /* gdbstub asked for something out our range */
@@ -248,10 +260,11 @@ int aarch64_gdb_get_pauth_reg(CPUState *cs, GByteArray *buf, int reg)
             bool is_data = !(reg & 1);
             bool is_high = reg & 2;
             ARMMMUIdx mmu_idx = arm_stage1_mmu_idx(env);
-            ARMVAParameters param;
+            ARMVAParameters param = aa64_va_parameters(env, -is_high, mmu_idx,
+                                                       is_data, false);
+            uint64_t pauth_mask = pauth_ptr_mask(param);
 
-            param = aa64_va_parameters(env, -is_high, mmu_idx, is_data, false);
-            return gdb_get_reg64(buf, pauth_ptr_mask(param));
+            return gdb_get_reg64_value(MO_TE | MO_64, buf, &pauth_mask);
         }
     default:
         return 0;
@@ -399,7 +412,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 
     tcf0 = extract64(env->cp15.sctlr_el[1], 38, 2);
 
-    return gdb_get_reg64(buf, tcf0);
+    return gdb_get_reg64_value(MO_TE | MO_64, buf, &tcf0);
 }
 
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
-- 
2.39.5


