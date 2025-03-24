Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF3AC36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewl-0002w4-VB; Mon, 24 Mar 2025 06:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewQ-0002l6-B5
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:02 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewH-0006zw-Mq
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:21:54 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-ac2bb7ca40bso934057366b.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811707; x=1743416507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjpRMxNrkVBin7ubrwGG1HVh+PO75FtdmPA/R4NJ0CI=;
 b=TkDIUzV5lYlMX/3iNusRqcEVOCqnwmXjcsUFkxxCSO6uN/cGBm8bklmF+N+iLsHAxS
 DIaIBOZYPFlK15ampgXUFliRj/YvOCbv9ARZllkrJZPbGAAmIVu3wCM2riryVGpyDMTt
 9IanLYYKjxH2ZMihuLzHrYZxJlUaHNvxIpTpsX0Oy9Vl6vOYxnt9808QKIEeA33yAwhw
 3/mhnr/GBim1DoYW0mu9JcfwnBIM3tug+bwYzH2mYbz/NQAe41XIEkqG2QoeFVLSi+RK
 Cry8vFwQDzfKEGyDTNoZ9Z48SImQEg0CP714MMtXZQagT297nCAgChcXNY4DbascX0Ft
 sVbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811707; x=1743416507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XjpRMxNrkVBin7ubrwGG1HVh+PO75FtdmPA/R4NJ0CI=;
 b=pvkYj1laxZ5EXJs0FJWeRtNEUhSQw4T7slQUgfDTq+FxCTTy3vZy3g6CVCGQMDo1lO
 XoYu5vJL8lTZ+s0WAOqM9CQ8tyENMhOYJ1aL/of5D7A8gvT6CDDd7eAzkPFODrznADLn
 2LeXO8x1pTITKT7xA/NWIa0f81xn2hTik5wN5NbgE/GAYix+QZsY5HqEXTfgM6uTq2sC
 3R4ENtwpX8UtK7fkAOOflqS1NpFfajEiO/c8KpRyG/Nc3rOu0cKy8PzBg4GITyzyBBfF
 RkAJ5Kp58HagZ/3m8nhsTKzSFziCUp4QiMeoEvTEAOvrAj8yJZI+EHQvd3mXvZWvUNYp
 q5uQ==
X-Gm-Message-State: AOJu0YwOXnvq3G9j6N8+tzMugjbhtddxgR0xinD2wxMppaM2BTvhusVH
 HNpSsw9ng9pmv7cMc+gkr8ITIi3ZZTLECufxkpsVgn7AuZZv1278IVoS75l75jM=
X-Gm-Gg: ASbGncvNB/2+5/8/q3TLOkS8hTXMbVAZywPdSjj6gDdLdtAukQR5Ig/NOVYx+ZXT5s2
 Oi3ubedIKHoWJj5/dMZXuUeLt0tBG8I7cMxmRdZlxm+uzbATp5GJSF6/pt1uH0WfrCsyOoSU3aK
 8N5f33D3mN3yev4/itwPO9GIPMLTtC7aEAG3AgNlQZ8Fi/G6JFnFQtGni56SJ2Lhc2i3RAE9nRx
 kK7KNstliAipEPNsuK8k6ldNGmuGAxzjhLL0AUeOOGQZeyZ7pkJJsT9mdvDyfRMRgHlCQPjHcWE
 /we6grJ5ES8GJ0ZAnVlUDj7yOX6ilnK0g+VuRgIXxMHCcOrtyUzQZscvJQ==
X-Google-Smtp-Source: AGHT+IEeqeXGnv+FgmgF2VYDfGcTiZ/HHDBJqQBs+nkCWzneCes76V1qPeHoh5y+16Ha7awLmJcolA==
X-Received: by 2002:a17:907:6d0f:b0:ac3:4487:6a99 with SMTP id
 a640c23a62f3a-ac3f2586dd2mr1234260066b.47.1742811707481; 
 Mon, 24 Mar 2025 03:21:47 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef8d3f17sm652317166b.63.2025.03.24.03.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1520F5FBC3;
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
Subject: [PATCH v2 05/11] target/arm: convert 32 bit gdbstub to new helpers
Date: Mon, 24 Mar 2025 10:21:36 +0000
Message-Id: <20250324102142.67022-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - use new wrappers
  - explicit MO_32 usage and reg32/64 helpers
---
 target/arm/gdbstub.c | 55 +++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/target/arm/gdbstub.c b/target/arm/gdbstub.c
index 30068c2262..71d672ace5 100644
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
+        return gdb_get_reg32_value(MO_TE | MO_32, mem_buf, &env->regs[n]);
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
+        return gdb_get_reg32_value(MO_TE | MO_32, mem_buf, &reg);
     }
     /* Unknown register.  */
     return 0;
@@ -115,19 +121,21 @@ static int vfp_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
 
     /* VFP data registers are always little-endian.  */
     if (reg < nregs) {
-        return gdb_get_reg64(buf, *aa32_vfp_dreg(env, reg));
+        return gdb_get_reg64_value(MO_TE | MO_64, buf, aa32_vfp_dreg(env, reg));
     }
     if (arm_feature(env, ARM_FEATURE_NEON)) {
         /* Aliases for Q regs.  */
         nregs += 16;
         if (reg < nregs) {
             uint64_t *q = aa32_vfp_qreg(env, reg - 32);
-            return gdb_get_reg128(buf, q[0], q[1]);
+            return gdb_get_reg64_value(MO_TE | MO_64, buf, q);
         }
     }
     switch (reg - nregs) {
+        uint32_t fpcr;
     case 0:
-        return gdb_get_reg32(buf, vfp_get_fpscr(env));
+        fpcr = vfp_get_fpscr(env);
+        return gdb_get_reg32_value(MO_TE | MO_32, buf, &fpcr);
     }
     return 0;
 }
@@ -166,9 +174,11 @@ static int vfp_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
 
     switch (reg) {
     case 0:
-        return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPSID]);
+        return gdb_get_reg32_value(MO_TE | MO_32, buf,
+                                   &env->vfp.xregs[ARM_VFP_FPSID]);
     case 1:
-        return gdb_get_reg32(buf, env->vfp.xregs[ARM_VFP_FPEXC]);
+        return gdb_get_reg32_value(MO_TE | MO_32, buf,
+                                   &env->vfp.xregs[ARM_VFP_FPEXC]);
     }
     return 0;
 }
@@ -196,7 +206,7 @@ static int mve_gdb_get_reg(CPUState *cs, GByteArray *buf, int reg)
 
     switch (reg) {
     case 0:
-        return gdb_get_reg32(buf, env->v7m.vpr);
+        return gdb_get_reg32_value(MO_TE | MO_32, buf, &env->v7m.vpr);
     default:
         return 0;
     }
@@ -236,9 +246,11 @@ static int arm_gdb_get_sysreg(CPUState *cs, GByteArray *buf, int reg)
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
@@ -375,12 +387,12 @@ static uint32_t *m_sysreg_ptr(CPUARMState *env, MProfileSysreg reg, bool sec)
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
@@ -393,7 +405,8 @@ static int arm_gdb_get_m_systemreg(CPUState *cs, GByteArray *buf, int reg)
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


