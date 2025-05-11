Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 130FAC3ABCC
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP6-0003T8-3f; Sun, 11 May 2025 16:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP2-0003Be-GL
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP0-0006MS-Gk
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22e09f57ed4so49971355ad.0
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995761; x=1747600561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xQpsi3ddplo1PeXu/oY6EwqxGm4q0Fc5nd7cUu3ei9c=;
 b=Tlti6lSlyCX4Aqg6zJIw7fjoovQ50PDRiPpEnNvcVpCqxVZkKeUpNinWwC7mrv5VFS
 2AM1egwMmbkrK2a96sM7mMvd9EGYG2gFeK9QrE06B5rWA0dx2tyr+Siu5WBZjxK3Hctk
 q3IpwQJsZQZjVag7v053jPLi4g+T93n7Y0FKwjQjQI14UIqWJH4MeUSMFw3rg6fxjRTu
 fZ/gvst1YH6LGESxuzeIIqMJsa23peI497RvK+vHx8ihgLpHWL5HvVqRFL5Y8Qs7mjSw
 rCUTT8BE92VruxfUGU+EVTAmxdu1TxWnHz4nkyR27JsqUAE8zZLkg1OHQuZadjehsEte
 hZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995761; x=1747600561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xQpsi3ddplo1PeXu/oY6EwqxGm4q0Fc5nd7cUu3ei9c=;
 b=LFEqK0pMHVWSxba+Zysnzz+jf7kmPu2sX7hY0NNu1w3J3dYnzODGD7AQO94Hqwt+rM
 WW1V2JDTiuHmrPJnX6V/2aE2t3gPOSCVAQOJgtcFPPQDntxlS4tmKXshoj9pVmCubTw9
 QfpvgV1aWJSmhce+rIjhoWLV1x4sjie2AUbYKL+elfwdLQJ1oZwGQhECkzeNUZiHaNvh
 Og0IiTj2xfHKqMi4sZf4v7PbUOVAcMAm8NFi9xNafZugXbiTuhKpM90nS6IUVboJy50v
 FrICehGq2mt7P3iVsy7fH6XNu/EMCqmQ8d/SGcji4JJH0sd2pvKxFYDyIfkCsc8ZNkYY
 5JCg==
X-Gm-Message-State: AOJu0Yytn3PH1eBpAoZ8l0K3stcGrg64BUjmaJam5f2CPMMsCYplqfYg
 2jw4jtgzeRNn63MFUYZsUXGtY8nEpjYYN+uVou4cbFxkT+8oBdO/MAp4A4Dj53VwR503zOrkytw
 3
X-Gm-Gg: ASbGncuEPtEdbp1SKmVGw4TympUIBOcFBQG3whXPqA9tYIbcj30amTI/KLGGYhVUsDG
 KSXgYusPRyuh89AUKP0HE2W0GOChLiVG4t5fF0L1cOKBbmSnGo0OMe/sbu4JpT7dS0EEuahMSXE
 9crHDKL3iTODwQ7R1rVzghratT5CIltCfcojexlu2gb4+Or4taqoiTCB52k89mgTkFZiDBcDd7z
 DmKXZdd4R+s8BUQgbJFoP8w70e+6jIsxXBqjMKWgP9Wavb2w7IkBVxoVrzGYFNfCV1ZBvcHELSG
 dtA6ycvH35ObReJpNfNoOWsyfS6kOa6RUYrcK9PUjAIMRyfFHX2iMJPYXHrDvBsyXixVooXZyan
 8IaUnT6N61g==
X-Google-Smtp-Source: AGHT+IGywAVPHGaU5RNWWg3G0+7BmFwwJiXYDQnRjLkyaMbvfswzIMvecVexH5trhqBAHs1KSVxlpQ==
X-Received: by 2002:a17:903:244b:b0:21f:98fc:8414 with SMTP id
 d9443c01a7336-22e847db5f5mr205475465ad.26.1746995761032; 
 Sun, 11 May 2025 13:36:01 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 17/24] target/m68k: Split gen_ea_mode_fp for load/store
Date: Sun, 11 May 2025 13:35:39 -0700
Message-ID: <20250511203546.139788-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Replace with gen_load_mode_fp and gen_store_mode_fp.
Return bool for success from the new functions.
Remove gen_ldst_fp and ea_what as unused.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 125 +++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 60 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index 779890d3d3..da3293d762 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -330,12 +330,6 @@ static inline void gen_store(DisasContext *s, int opsize, TCGv addr, TCGv val,
     }
 }
 
-typedef enum {
-    EA_STORE,
-    EA_LOADU,
-    EA_LOADS
-} ea_what;
-
 /* Read a 16-bit immediate constant */
 static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
 {
@@ -1002,60 +996,38 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
     }
 }
 
-static void gen_ldst_fp(DisasContext *s, int opsize, TCGv addr,
-                        TCGv_ptr fp, ea_what what, int index)
-{
-    if (what == EA_STORE) {
-        gen_store_fp(s, opsize, addr, fp, index);
-    } else {
-        gen_load_fp(s, opsize, addr, fp, index);
-    }
-}
-
-static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
-                          TCGv_ptr fp, ea_what what, int index)
+static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
+                             TCGv_ptr fp, int index)
 {
+    int mode = extract32(insn, 3, 3);
+    int reg0 = REG(insn, 0);
     TCGv reg, addr, tmp;
     TCGv_i64 t64;
 
     switch (mode) {
     case 0: /* Data register direct.  */
         reg = cpu_dregs[reg0];
-        if (what == EA_STORE) {
-            switch (opsize) {
-            case OS_BYTE:
-            case OS_WORD:
-            case OS_LONG:
-                gen_helper_reds32(reg, tcg_env, fp);
-                break;
-            case OS_SINGLE:
-                gen_helper_redf32(reg, tcg_env, fp);
-                break;
-            default:
-                g_assert_not_reached();
-            }
-        } else {
-            tmp = tcg_temp_new();
-            switch (opsize) {
-            case OS_BYTE:
-            case OS_WORD:
-            case OS_LONG:
-                tcg_gen_ext_i32(tmp, reg, opsize | MO_SIGN);
-                gen_helper_exts32(tcg_env, fp, tmp);
-                break;
-            case OS_SINGLE:
-                gen_helper_extf32(tcg_env, fp, reg);
-                break;
-            default:
-                g_assert_not_reached();
-            }
+        tmp = tcg_temp_new();
+        switch (opsize) {
+        case OS_BYTE:
+        case OS_WORD:
+        case OS_LONG:
+            tcg_gen_ext_i32(tmp, reg, opsize | MO_SIGN);
+            gen_helper_exts32(tcg_env, fp, tmp);
+            break;
+        case OS_SINGLE:
+            gen_helper_extf32(tcg_env, fp, reg);
+            break;
+        default:
+            g_assert_not_reached();
         }
-        return 0;
+        return true;
+
     case 1: /* Address register direct.  */
-        return -1;
+        return false;
 
     case 7: /* Other */
-        if (reg0 == 4 && what != EA_STORE) {
+        if (reg0 == 4) {
             switch (opsize) {
             case OS_BYTE:
                 tmp = tcg_constant_i32((int8_t)read_im8(s->env, s));
@@ -1097,7 +1069,7 @@ static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
             default:
                 g_assert_not_reached();
             }
-            return 0;
+            return true;
         }
         /* fall through */
 
@@ -1108,20 +1080,55 @@ static int gen_ea_mode_fp(DisasContext *s, int mode, int reg0, int opsize,
     case 6: /* Indirect index + displacement.  */
         addr = gen_lea_mode(s, mode, reg0, opsize);
         if (IS_NULL_QREG(addr)) {
-            return -1;
+            return false;
         }
-        gen_ldst_fp(s, opsize, addr, fp, what, index);
-        return 0;
+        gen_load_fp(s, opsize, addr, fp, index);
+        return true;
     }
     g_assert_not_reached();
 }
 
-static int gen_ea_fp(CPUM68KState *env, DisasContext *s, uint16_t insn,
-                       int opsize, TCGv_ptr fp, ea_what what, int index)
+static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
+                              TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    return gen_ea_mode_fp(s, mode, reg0, opsize, fp, what, index);
+    TCGv reg, addr;
+
+    switch (mode) {
+    case 0: /* Data register direct.  */
+        reg = cpu_dregs[reg0];
+        switch (opsize) {
+        case OS_BYTE:
+        case OS_WORD:
+        case OS_LONG:
+            gen_helper_reds32(reg, tcg_env, fp);
+            break;
+        case OS_SINGLE:
+            gen_helper_redf32(reg, tcg_env, fp);
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return true;
+
+    case 1: /* Address register direct.  */
+        return false;
+
+    case 2: /* Indirect register */
+    case 3: /* Indirect postincrement.  */
+    case 4: /* Indirect predecrememnt.  */
+    case 5: /* Indirect displacement.  */
+    case 6: /* Indirect index + displacement.  */
+    case 7: /* Other */
+        addr = gen_lea_mode(s, mode, reg0, opsize);
+        if (IS_NULL_QREG(addr)) {
+            return false;
+        }
+        gen_store_fp(s, opsize, addr, fp, index);
+        return true;
+    }
+    g_assert_not_reached();
 }
 
 typedef struct {
@@ -4880,8 +4887,7 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (gen_ea_fp(env, s, insn, opsize, cpu_src,
-                      EA_STORE, IS_USER(s)) == -1) {
+        if (!gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_addr_fault(s);
         }
         gen_helper_ftst(tcg_env, cpu_src);
@@ -4902,8 +4908,7 @@ DISAS_INSN(fpu)
         /* Source effective address.  */
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
-        if (gen_ea_fp(env, s, insn, opsize, cpu_src,
-                      EA_LOADS, IS_USER(s)) == -1) {
+        if (!gen_load_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_addr_fault(s);
             return;
         }
-- 
2.43.0


