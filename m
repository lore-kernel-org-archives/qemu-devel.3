Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E7C5CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v299t-0000ht-3t; Fri, 26 Sep 2025 10:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298x-00086U-3E
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v298T-0005id-Vj
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:09:49 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45dd505a1dfso12675085e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758895751; x=1759500551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Eg6nfok1GwG5zNCB5mi0v4fpJCgjR6fP+MDXEr0QDn8=;
 b=LeokCobNN2gp/0NarPHbAF0esq95H/z1PPXftGy66PLQIn6juFTEvf+KR4l3L6mQa8
 CbxvXoEei4jDtCb21QivFDfXDMRvjB5dGoeYhtUBLtQwSbOXCMDfJVeybp+mUPiJbT7t
 o+XAlxNdED/8kGQspC5F/bxW3QWyONdXwz/re50Cd5HVPDL/EBmb23Y3JeuOCX/34Lu+
 rZE0oVoMHiOeXBPUTU06ceOMvKfpSsyMPZmSlbfeCi8OtyQ1ctxOvDInNQxYdwmQWg/d
 7P0jT++R97ffW/EXkKbR+QxzW8zg1GNCoSKEi5kEI694/mpCUxUXcoaLYVe9IgyoWbZU
 7P6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758895751; x=1759500551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eg6nfok1GwG5zNCB5mi0v4fpJCgjR6fP+MDXEr0QDn8=;
 b=eRuDWMrQ414nKWfgufnZ0oOPUSJcgG/Sk7fDyCXEYNX1AlcbfiMMLSG4D/fNwox8dx
 0r7rNF/WmEQmLecoXsZS+YKeo1FxYKehYh2eSLIFbrY/WbZy8IE1wckr7jX71bOGfcQc
 FgwC37MPwRgCUwOVCLfnGFI0tCqMThuljKsosekg07uZaioWM+oet+nOtIr4O5paZaQu
 oxjkql0UXz6KKeoxmm+2kRFaXvdVvCKUZrv4WDTzi3QTx5Vp2c23JB6ykH45AL/JmfiU
 1m5K1EnPn8KExXoMtz6lOYSnimwi20jGsrWAXn7UjJnCmCINGy/p4iHLqHmAmcY2HXEB
 XNkg==
X-Gm-Message-State: AOJu0YyCEYUa34VnkhF3VQdfXStRZiafp7RCJuO7anZ4ZH8Y42NS0/YO
 OghsDYasv92+maff1T+XEGw7JTZboQOhsYR1HlPOyS6/ytRHCNfChi04eQx0ya4J5F+O1BWI6HY
 iG4P1
X-Gm-Gg: ASbGncuzlWnJpoHdccc8SCosUdB/xvqfpAFFvPDpuXNhoP+jDninTXfDPmyKB9bI/9t
 tORXAgNQt5jIi8Id+4BCfo/3WNVI3f8Dl0TiEp95dQjr4o4RT+n/KncIstLH06vp7dvIYpWR+83
 t/o2dDv167mK632HmzbHedAopiXGRXua5lJaAJszgyYe0kFAZj3eNX0ycJo3dMyj5CPOlu7Iy6A
 Dyg0HFJlwQziEHjyPRmRXSd0ka1KA+qwlAe0pBIMgwtbo32AYpHitKo8VmH02dpLBO6XU0qIRwm
 i16EQQHuCYhzDGSeBNJPmzSN+abEq4z+df8WJaR8TJ1HyBvSGLDOusSeo9sTCjZQ0DHNO+zfsti
 1D9K3hcFBy6GiWWbpKKsIgsqyNkCo
X-Google-Smtp-Source: AGHT+IGSFhAOg0W+ArWQFeAHzr1Q9MIEFOMWR4NbiA8VLX11MgExdYuPGde0PLZN65BKBaIhb+tiEA==
X-Received: by 2002:a05:600c:310c:b0:46e:21c8:ad37 with SMTP id
 5b1f17b1804b1-46e35d550acmr55983085e9.25.1758895751486; 
 Fri, 26 Sep 2025 07:09:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-410f2007372sm6338315f8f.16.2025.09.26.07.09.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 07:09:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/44] target/arm: Move cp processing to define_one_arm_cp_reg
Date: Fri, 26 Sep 2025 15:08:24 +0100
Message-ID: <20250926140844.1493020-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926140844.1493020-1-peter.maydell@linaro.org>
References: <20250926140844.1493020-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Processing of cp was split between add_cpreg_to_hashtable and
define_one_arm_cp_reg.  Unify it all to the top-level function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 53 +++++++++++++++++++--------------------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8c2b7e037e8..f0e423e623b 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7368,7 +7368,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
  */
 static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
                                    CPState state, CPSecureState secstate,
-                                   int crm, int opc1, int opc2,
+                                   int cp, int crm, int opc1, int opc2,
                                    const char *name)
 {
     CPUARMState *env = &cpu->env;
@@ -7376,28 +7376,14 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
     ARMCPRegInfo *r2;
     bool is64 = r->type & ARM_CP_64BIT;
     bool ns = secstate & ARM_CP_SECSTATE_NS;
-    int cp = r->cp;
     size_t name_len;
     bool make_const;
 
     switch (state) {
     case ARM_CP_STATE_AA32:
-        /* We assume it is a cp15 register if the .cp field is left unset. */
-        if (cp == 0 && r->state == ARM_CP_STATE_BOTH) {
-            cp = 15;
-        }
         key = ENCODE_CP_REG(cp, is64, ns, r->crn, crm, opc1, opc2);
         break;
     case ARM_CP_STATE_AA64:
-        /*
-         * To allow abbreviation of ARMCPRegInfo definitions, we treat
-         * cp == 0 as equivalent to the value for "standard guest-visible
-         * sysreg".  STATE_BOTH definitions are also always "standard sysreg"
-         * in their AArch64 view (the .cp value may be non-zero for the
-         * benefit of the AArch32 view).
-         */
-        assert(cp == 0 || r->state == ARM_CP_STATE_BOTH);
-        cp = 0;
         key = ENCODE_AA64_CP_REG(r->opc0, opc1, r->crn, crm, opc2);
         break;
     default:
@@ -7558,7 +7544,7 @@ static void add_cpreg_to_hashtable(ARMCPU *cpu, const ARMCPRegInfo *r,
 }
 
 static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
-                                        int crm, int opc1, int opc2)
+                                        int cp, int crm, int opc1, int opc2)
 {
     /*
      * Under AArch32 CP registers can be common
@@ -7571,16 +7557,16 @@ static void add_cpreg_to_hashtable_aa32(ARMCPU *cpu, const ARMCPRegInfo *r,
     switch (r->secure) {
     case ARM_CP_SECSTATE_S:
     case ARM_CP_SECSTATE_NS:
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               r->secure, crm, opc1, opc2, r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, r->secure,
+                               cp, crm, opc1, opc2, r->name);
         break;
     case ARM_CP_SECSTATE_BOTH:
         name = g_strdup_printf("%s_S", r->name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               ARM_CP_SECSTATE_S, crm, opc1, opc2, name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_S,
+                               cp, crm, opc1, opc2, name);
         g_free(name);
-        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32,
-                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, r->name);
+        add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA32, ARM_CP_SECSTATE_NS,
+                               cp, crm, opc1, opc2, r->name);
         break;
     default:
         g_assert_not_reached();
@@ -7611,11 +7597,11 @@ static void add_cpreg_to_hashtable_aa64(ARMCPU *cpu, const ARMCPRegInfo *r,
             nxs_ri.fgt |= R_FGT_NXS_MASK;
         }
         add_cpreg_to_hashtable(cpu, &nxs_ri, ARM_CP_STATE_AA64,
-                               ARM_CP_SECSTATE_NS, crm, opc1, opc2, name);
+                               ARM_CP_SECSTATE_NS, 0, crm, opc1, opc2, name);
     }
 
     add_cpreg_to_hashtable(cpu, r, ARM_CP_STATE_AA64, ARM_CP_SECSTATE_NS,
-                           crm, opc1, opc2, r->name);
+                           0, crm, opc1, opc2, r->name);
 }
 
 void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
@@ -7650,6 +7636,7 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
     int opc1max = (r->opc1 == CP_ANY) ? 7 : r->opc1;
     int opc2min = (r->opc2 == CP_ANY) ? 0 : r->opc2;
     int opc2max = (r->opc2 == CP_ANY) ? 7 : r->opc2;
+    int cp = r->cp;
 
     /*
      * AArch64 regs are all 64 bit so ARM_CP_64BIT is meaningless.
@@ -7672,21 +7659,25 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
      */
     switch (r->state) {
     case ARM_CP_STATE_BOTH:
-        /* 0 has a special meaning, but otherwise the same rules as AA32. */
-        if (r->cp == 0) {
+        /*
+         * If the cp field is left unset, assume cp15.
+         * Otherwise apply the same rules as AA32.
+         */
+        if (cp == 0) {
+            cp = 15;
             break;
         }
         /* fall through */
     case ARM_CP_STATE_AA32:
         if (arm_feature(&cpu->env, ARM_FEATURE_V8) &&
             !arm_feature(&cpu->env, ARM_FEATURE_M)) {
-            assert(r->cp >= 14 && r->cp <= 15);
+            assert(cp >= 14 && cp <= 15);
         } else {
-            assert(r->cp < 8 || (r->cp >= 14 && r->cp <= 15));
+            assert(cp < 8 || (cp >= 14 && cp <= 15));
         }
         break;
     case ARM_CP_STATE_AA64:
-        assert(r->cp == 0);
+        assert(cp == 0);
         break;
     default:
         g_assert_not_reached();
@@ -7756,13 +7747,13 @@ void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *r)
             for (int opc2 = opc2min; opc2 <= opc2max; opc2++) {
                 switch (r->state) {
                 case ARM_CP_STATE_AA32:
-                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_AA64:
                     add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
                     break;
                 case ARM_CP_STATE_BOTH:
-                    add_cpreg_to_hashtable_aa32(cpu, r, crm, opc1, opc2);
+                    add_cpreg_to_hashtable_aa32(cpu, r, cp, crm, opc1, opc2);
                     add_cpreg_to_hashtable_aa64(cpu, r, crm, opc1, opc2);
                     break;
                 default:
-- 
2.43.0


