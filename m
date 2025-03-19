Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1A5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4Q-0000O7-Ji; Wed, 19 Mar 2025 14:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4G-000084-Fo
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4B-0006Mc-Hx
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso35678285e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408577; x=1743013377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8cJ0n2MLq0D1KATXMYewHUR1inYzbGMB0GndiKaR2hw=;
 b=khprakExbS8SXKI34/bXH/3axN1yKvJH2FAYWnvaTEa91Tn9vObavxuH1BwNcp7QUH
 4/ktB2nX9mf0G529PFOIkDdCMPYBCcGnCvyzeZzzSAZQ+OMsVk3+IRif+42q5T+fU3T1
 yG9Q+egWsik4m2kqXxCbmXvUpTkjN5YBYiHda/HEin/dXFqfgL+aqdwoCaMyjcC60NXW
 SoOz3lMmmelw3XhecWcqX/UAXturisqeDJO7uxKetAMAQmXXibMz+nW/j8LAX0ZEo/km
 kWXzMrt0YKYI7+gXwuEnDAFaEqhSSFVC5BYO6maZeZ4kVPWaWIpVy1MGqZGNq3TVqouN
 YZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408577; x=1743013377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8cJ0n2MLq0D1KATXMYewHUR1inYzbGMB0GndiKaR2hw=;
 b=oghYtOJfizYvhIi2Kx+LSi3bvlRbVZyoxIGVIV6hznJJwVFu3/hhGdRNO92DqoIkwQ
 Q7QRnGWh8d6DNZ4LyOtDYUbq9743BF7gJeFcoyRzTmNLn9PW7aDa9cqhKqFXQp9OXpv7
 I3W8CxirPq7x8SSbIzefsgMLyjymzUI+6lDmxdFe1EDZ1su7/uRTljV0oVsELE2incFc
 A5q4lMW8sZX+iKWjrAC2XYXWbGi2jEVd69zKu45oVvCYEHzUkVgntpFgC+/flOuSzXHQ
 4OM+wJWHkQwVuIcf/GpHiEERE9M9kLbRfwIqrWvp4iCgWI3ntFfK+wXsc/CrT17K93yt
 aKNw==
X-Gm-Message-State: AOJu0YySpdMcCNrDksSFNHia2pdGXg3+oyRZxwXsJCTk3yvhzRXBSB7Y
 SpSr+uwPg5bpiR5p7wUWjqXoN360HK9jkTZamdqOTV+xSjVp2wyfGLi0P/j+2lY=
X-Gm-Gg: ASbGnctZHlB3Mdto1aUIj7mR49V8rfkgtKIwVHYExCF+TYxmAfwZ9/Zify19jO6Zf92
 02eqdsHxfOXzekxw2g72EQDe7s5NvN7MZfOxHkSf/VhKznz5X3oI/xwJlVPAE1Fx7L+UODlk/pM
 CWWWgaCFBSkr6RvOf4SjYnzatS8fnZ5bUXj2LEmrYPUuQCDulb3+nEF8+v2+4vYttSTLqx33wV7
 JO4sMKdcfbJqiGriks6vFKIDT+giJyWHTLR234V4SnC6TFtFMJ2ef9PcBf3omklLatdVOdCkggE
 BqTulOPPdNXDB6ExNztsZ3YI6tTX1tkADA9IA7FhTxQHXi4=
X-Google-Smtp-Source: AGHT+IFADQT79Ns8ByjAii8aVa4W9/RS096Ut1etVHHbqn8c/WBDbGY+JTgtbCFltpJdE1I+PHeetA==
X-Received: by 2002:a05:6000:1a8e:b0:391:3b11:d604 with SMTP id
 ffacd0b85a97d-39973b360afmr2727868f8f.54.1742408577117; 
 Wed, 19 Mar 2025 11:22:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39972df9b9esm3027838f8f.18.2025.03.19.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7B7E45FAA0;
 Wed, 19 Mar 2025 18:22:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH 03/10] target/arm: convert 32 bit gdbstub to new helper
Date: Wed, 19 Mar 2025 18:22:48 +0000
Message-Id: <20250319182255.3096731-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

For some of the helpers we need a temporary variable to copy from
although we could add some helpers to return pointers into env in
those cases if we wanted to.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/gdbstub.c | 57 ++++++++++++++++++++++++++++----------------
 1 file changed, 36 insertions(+), 21 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 30068c2262..14d931b0bf 100644
--- a/target/arm/gdbstub.c
+++ b/target/arm/gdbstub.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
-#include "gdbstub/helpers.h"
+#include "gdbstub/registers.h"
 #include "gdbstub/commands.h"
 #include "system/tcg.h"
 #include "internals.h"
@@ -33,12 +33,16 @@ typedef struct RegisterSysregFeatureParam {
     int n;
 } RegisterSysregFeatureParam;
 
-/* Old gdb always expect FPA registers.  Newer (xml-aware) gdb only expect
-   whatever the target description contains.  Due to a historical mishap
-   the FPA registers appear in between core integer regs and the CPSR.
-   We hack round this by giving the FPA regs zero size when talking to a
-   newer gdb.  */
-
+/*
+ * Old gdb always expect FPA registers. Newer (xml-aware) gdb only
+ * expect whatever the target description contains. Due to a
+ * historical mishap the FPA registers appear in between core integer
+ * regs and the CPSR. We hack round this by giving the FPA regs zero
+ * size when talking to a newer gdb.
+ *
+ * While gdb cares about the memory endianess of the target all
+ * registers are passed in little-endian mode.
+ */
 int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 {
     ARMCPU *cpu = ARM_CPU(cs);
@@ -46,15 +50,17 @@ int arm_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     if (n < 16) {
         /* Core integer register.  */
-        return gdb_get_reg32(mem_buf, env->regs[n]);
+        return gdb_get_register_value(MO_TEUL, mem_buf, (uint8_t *) &env->regs[n]);
     }
     if (n == 25) {
         /* CPSR, or XPSR for M-profile */
+        uint32_t reg;
         if (arm_feature(env, ARM_FEATURE_M)) {
-            return gdb_get_reg32(mem_buf, xpsr_read(env));
+            reg = xpsr_read(env);
         } else {
-            return gdb_get_reg32(mem_buf, cpsr_read(env));
+            reg = cpsr_read(env);
         }
+        return gdb_get_register_value(MO_TEUL, mem_buf, (uint8_t *) &reg);
     }
     /* Unknown register.  */
     return 0;
@@ -115,19 +121,22 @@ static int vfp_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
 
     /* VFP data registers are always little-endian.  */
     if (reg < nregs) {
-        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
+        return gdb_get_register_value(MO_TEUQ, buf,
+                                      (uint8_t *) aa32_vfp_dreg(env, reg));
     }
     if (arm_feature(env, ARM_FEATURE_NEON)) {
         /* Aliases for Q regs.  */
         nregs += 16;
         if (reg < nregs) {
             uint64_t *q = aa32_vfp_qreg(env, reg - 32);
-            return gdb_get_reg128(buf, q[0], q[1]);
+            return gdb_get_register_value(MO_TEUO, buf, (uint8_t *) q);
         }
     }
     switch (reg - nregs) {
+        uint32_t fpcr;
     case 0:
-        return gdb_get_reg32(buf, vfp_get_fpscr(env));
+        fpcr = vfp_get_fpscr(env);
+        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpcr);
     }
     return 0;
 }
@@ -166,9 +175,11 @@ static int vfp_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
 
     switch (reg) {
     case 0:
-        return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]);
+        return gdb_get_register_value(MO_TEUL, buf,
+                                      (uint8_t *) &env->vfp.xregs[ARM_VFP_FPSID]);
     case 1:
-        return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]);
+        return gdb_get_register_value(MO_TEUL, buf,
+                                      (uint8_t *) &env->vfp.xregs[ARM_VFP_FPEXC]);
     }
     return 0;
 }
@@ -196,7 +207,8 @@ static int mve_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
 
     switch (reg) {
     case 0:
-        return gdb_get_reg32(buf, env->v7m.vpr);
+        return gdb_get_register_value(MO_TEUL, buf,
+                                      (uint8_t *) &env->v7m.vpr);
     default:
         return 0;
     }
@@ -236,9 +248,11 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
     ri = get_arm_cp_reginfo(cpu->cp_regs, key);
     if (ri) {
         if (cpreg_field_is_64bit(ri)) {
-            return gdb_get_reg64(buf, (uint64_t)read_raw_cp_reg(env, ri));
+            uint64_t cpreg = read_raw_cp_reg(env, ri);
+            return gdb_get_register_value(MO_TEUQ, buf, (uint8_t *) &cpreg);
         } else {
-            return gdb_get_reg32(buf, (uint32_t)read_raw_cp_reg(env, ri));
+            uint32_t cpreg = (uint32_t) read_raw_cp_reg(env, ri);
+            return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &cpreg);
         }
     }
     return 0;
@@ -375,12 +389,12 @@ static uint32_t *m_sysreg_ptr(CPUARMState *env, MProfileSysreg reg, bool sec)
 static int m_sysreg_get(CPUARMState *env, GByteArray *buf,
                         MProfileSysreg reg, bool secure)
 {
-    uint32_t *ptr = m_sysreg_ptr(env, reg, secure);
+    uint8_t *ptr = (uint8_t *) m_sysreg_ptr(env, reg, secure);
 
     if (ptr == NULL) {
         return 0;
     }
-    return gdb_get_reg32(buf, *ptr);
+    return gdb_get_register_value(MO_TEUL, buf, ptr);
 }
 
 static int arm_gdb_get_m_systemreg(CPUState *cs, GByteArray *buf, int reg)
@@ -393,7 +407,8 @@ static int arm_gdb_get_m_systemreg(CPUState *cs, GByteArray *buf, int reg)
      * banked and non-banked bits.
      */
     if (reg == M_SYSREG_CONTROL) {
-        return gdb_get_reg32(buf, arm_v7m_mrs_control(env, env->v7m.secure));
+        uint32_t reg32 = arm_v7m_mrs_control(env, env->v7m.secure);
+        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &reg32);
     }
     return m_sysreg_get(env, buf, reg, env->v7m.secure);
 }
-- 
2.39.5


