Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC12C36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 18:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuy4O-0000JQ-8U; Wed, 19 Mar 2025 14:23:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4I-00009v-I9
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:06 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tuy4C-0006N0-26
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 14:23:06 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so6823315e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742408578; x=1743013378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3IgWp4WCaXbcrtv8Yoastsvt3hmlgscQMXb34UR5gEk=;
 b=bkNHF12uX7+66nWTN+Vy4utk31odQ9g7IboA5KsO75ntncqsQD4vI68Ygm/qLJj+Uz
 hl8vGfa7usXp0+lC2qCyLqFLb9SDIOrpz91ECaPntM4wdziFGu+TSEVd1UP6g/Fdfosn
 29DCwzSGasm2HekaMmqShQGhJKSaiN/AoIzJi2U/dt3WWFPYQtiWyOraQ7aLi3w/kUsK
 CyT0Ol8g+jpriGH24FcJjsf7gBI8BT4pUTeu/pxkjp3Vd1sBujPkc7ZTH18CmkdJu0DK
 9HmIzN2+i+9ag3jajBxe3sPXzaHWoDaZbpDwCz9KrTlw8kh8Y5HtXCzGTHLuigYvpWtk
 +png==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742408578; x=1743013378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3IgWp4WCaXbcrtv8Yoastsvt3hmlgscQMXb34UR5gEk=;
 b=fG/APSxypBbe3UTcHfkd1SQ1Tc48/XyditvLpTUeG6eb+ZpuoASCMJgsB0tPQ1P0oz
 xy0UtjRKRR4wyrYzH6RGNBUClA0iwxmENwXiFqgyaXG2NRRXRmUl6gzYDxxjbCkYB3Fx
 yQaTbxNU+/CQdPdu1xUgCRnd7ti84Sf9V+moEAUYGNWsaYcokEo7HhXZVIwRbum6FhYs
 3ZvB172uJRlYMMwhP6jHq0qTJ1dt/A70JMdj0w+8ig52DLCBS1/u3g49PQ6ZyzccIMfV
 vNKXZNx4i2QI3BQCUkcEMy55nQqGyhiBJp2c3IhasTvBUAJhRAlqU7h7j9x5qCmkgfAj
 10Kw==
X-Gm-Message-State: AOJu0YxYo4+k5ycD2Lq9GhWpdAYUsGsDmAMrCypvS5DeKTur04JS4fhM
 Hr9ydsH/xP6RfCxh/r/NnQLfOLLVFChuyiXDqkS2x9tlxhRyjKOFHzQdcA6yjZ8=
X-Gm-Gg: ASbGncuYytOT/Xo8tQFysipjpdf6ALGgvAaypek+SqEzCEaKeb6lE4jYqCKcEGw89F0
 fZmlBrFW48/rWFi+55djbC9Cj9YEQJYsvDEYJhmf7U0Q+D6Mn1HvsDnUQJPDjc9EN47K2MV4wLG
 HeESoRgE2vbRZ03XgxrulcLvCvsivZe5CsAMWSgPZDYBmDr7jYcPKV9O6PLL+9MKuoik3ukUuPr
 XSv9jqMc0cGNrBvHIJN5Dfsc3Oenz09fP01PrDRbDVzDKx0pG69J5jUSQgS/c1qPXqc75P32cGB
 hDYFoWwfN3Id8i55LVq7L5/DaB+MX/Qcurzl888rfGDMoZ8=
X-Google-Smtp-Source: AGHT+IHInZiHFKhcsVP4Td6oIgZNdEkttHm93MlPVGH9No0cSuMWiwNAfQA6b8KETHcZLP9ag/cEfQ==
X-Received: by 2002:a5d:5f4c:0:b0:391:b93:c971 with SMTP id
 ffacd0b85a97d-39979586d6fmr572712f8f.20.1742408578086; 
 Wed, 19 Mar 2025 11:22:58 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f376d3sm26330865e9.4.2025.03.19.11.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 11:22:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 908D45FAC7;
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
Subject: [PATCH 04/10] target/arm: convert 64 bit gdbstub to new helper
Date: Wed, 19 Mar 2025 18:22:49 +0000
Message-Id: <20250319182255.3096731-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250319182255.3096731-1-alex.bennee@linaro.org>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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
 target/arm/gdbstub64.c | 53 ++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
index 1a4dbec567..793332af31 100644
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
@@ -35,15 +35,16 @@ int aarch64_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
 
     if (n < 31) {
         /* Core integer register.  */
-        return gdb_get_reg64(mem_buf, env->xregs[n]);
+        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &env->xregs[n]);
     }
     switch (n) {
     case 31:
-        return gdb_get_reg64(mem_buf, env->xregs[31]);
+        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &env->xregs[31]);
     case 32:
-        return gdb_get_reg64(mem_buf, env->pc);
+        return gdb_get_register_value(MO_TEUO, mem_buf, (uint8_t *) &env->pc);
     case 33:
-        return gdb_get_reg32(mem_buf, pstate_read(env));
+        uint32_t pstate = pstate_read(env);
+        return gdb_get_register_value(MO_TEUL, mem_buf, (uint8_t *) &pstate);
     }
     /* Unknown register.  */
     return 0;
@@ -82,23 +83,27 @@ int aarch64_gdb_get_fpu_reg(CPUState *cs, GByteArray *buf, int reg)
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
+        return gdb_get_register_value(MO_TEUO, buf, (uint8_t *) q);
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
+    return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpr);
 }
 
 int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t *buf, int reg)
@@ -132,30 +137,37 @@ int aarch64_gdb_get_sve_reg(CPUState *cs, GByteArray *buf, int reg)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
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
+            len += gdb_get_register_value(MO_TEUQ, buf,
+                                          (uint8_t *) &zreg->d[vq * 2 + 1]);
+            len += gdb_get_register_value(MO_TEUQ, buf,
+                                          (uint8_t *) &zreg->d[vq * 2]);
         }
         return len;
     }
     case 32:
-        return gdb_get_reg32(buf, vfp_get_fpsr(env));
+        fpr = vfp_get_fpsr(env);
+        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpr);
     case 33:
-        return gdb_get_reg32(buf, vfp_get_fpcr(env));
+        fpr = vfp_get_fpcr(env);
+        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &fpr);
     /* then 16 predicates and the ffr */
     case 34 ... 50:
     {
         int preg = reg - 34;
         int vq, len = 0;
         for (vq = 0; vq < cpu->sve_max_vq; vq = vq + 4) {
-            len += gdb_get_reg64(buf, env->vfp.pregs[preg].p[vq / 4]);
+            len += gdb_get_register_value(MO_TEUQ, buf,
+                                          (uint8_t *) &env->vfp.pregs[preg].p[vq / 4]);
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
+        return gdb_get_register_value(MO_TEUL, buf, (uint8_t *) &vq);
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
+            return gdb_get_register_value(MO_TEUQ, buf, (uint8_t *) &pauth_mask);
         }
     default:
         return 0;
@@ -399,7 +412,7 @@ int aarch64_gdb_get_tag_ctl_reg(CPUState *cs, GByteArray *buf, int reg)
 
     tcf0 = extract64(env->cp15.sctlr_el[1], 38, 2);
 
-    return gdb_get_reg64(buf, tcf0);
+    return gdb_get_register_value(MO_TEUQ, buf, (uint8_t *) &tcf0);
 }
 
 int aarch64_gdb_set_tag_ctl_reg(CPUState *cs, uint8_t *buf, int reg)
-- 
2.39.5


