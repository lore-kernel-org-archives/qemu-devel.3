Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755D0C3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:15:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5Q-0006Iw-AO; Wed, 07 May 2025 17:13:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4y-0006Cc-9U
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:24 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4u-0006F5-DZ
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:23 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7376e311086so487508b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652396; x=1747257196; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EhkUBLDgBKrW8ClWiq8/+jgtiQv4CNEKhBjqg5DTUHo=;
 b=Y6mxyPW5ml3b8gVT06K4UPsx97lWFlX+rmUmVgpC45CmUzazOUJPWySWLQRphxcvgw
 hvwgnvak2csS/BTLfd17X+WSdK98S884sG7DWf4EoVGICD/UjGCoKcLZl3T0W9u1VWVq
 Z8tEZ0NjgaGVmUCT1hAfrld8ugkzRI0NDjWF2souEs02CF8s6YaQCZDuIAZhNBhUJ7P7
 D+yJisvJOsiNnrYso7xeDk3YqMCdZF2YU2/Jr55JKlTyL6qwkwLzof4RSqMH/iztkbkl
 htVmrdCYY5YtccGbPh3rbi3smHuPksouD4rrNSNLlJdQ0EZWVIdlb1yKpYnr3sJRlK7O
 0SfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652396; x=1747257196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EhkUBLDgBKrW8ClWiq8/+jgtiQv4CNEKhBjqg5DTUHo=;
 b=N3jpN4OQMiap2qNWBp3UV2LoMcYFAhOs+tTlB+yGsIWcv/lxZwv98S59m5ymqczc+k
 dzX/q54wy0obzPCevIitOkKgaR0jvpaRO6rIf282tPT8Nr9pybRL5J8aMgxuPinOGnmW
 XSmwfNBa9k8f5NPgkpdhwWce8B3aV3DzxGJCaXSIth/a7OqwAMmMK3igjdb6ydHFl/Xa
 rEe11LxUYq/aioye2fyYWvfGM2lV2XHJBSo20VsC0MPmaC/9Sp5r+N2qtyu6KNtFPmqy
 y7ecqH+5TK9LVyk56Y35Bpmomvq5r+5f/F0VDpwoFhjkGtn1KGtbLH4EDerpAj0YvGW6
 M5Jg==
X-Gm-Message-State: AOJu0YwgLTijMLKYYAEINqidDoxtvOIvJzovOcu/wAspKUVZi5FOPZKq
 81qiX7SpmxAMNY3Q1MLDLZ98GsTlooppU44BQp3KzK8uqyKsfhRCVXGnQAU+UjdN6usywgk9BPx
 e
X-Gm-Gg: ASbGnctw3JFei/r8kKYMpPXsZMlCZmu3ZQ1zF+GpgTY0YR2kuMh0fr6lJclLXtV0Evo
 FSEr/r2AcVqxJZBhvPB0nn2wTQbvgscxARaLP+Y4z96mS4jHFwAo4l5hKxGTr7MJFVH9Jagw7M3
 yg6490UppzlnBMT4JpIrSL3FPvxdDfUC1IcL00s766otKJHCmBfelkSJkzIqbv3ymggQ7ewA7Op
 3QEgtnAyIb5+x4ZrBijq22thg8oACpRESQ0SU9OY9tmgJhYgMxW6iuP6Jg3N2Wzo7aWXUICjegt
 Q97tE2TtTcH4fpWhxEHLoG171CAkWha6jCKYa2THur+MAsLiX3wzSDtuBgrKa+1Nk4/YWwq0evQ
 =
X-Google-Smtp-Source: AGHT+IEkyN1AOxvX2zM9z6tueTQqxJqU9ugv8Utpo/saB/lEsQKO24mDzhDoRWNQR/5kGe7+cPillA==
X-Received: by 2002:a05:6a21:3a8f:b0:1f5:9024:324f with SMTP id
 adf61e73a8af0-2159b01b320mr1129534637.31.1746652396109; 
 Wed, 07 May 2025 14:13:16 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 17/24] target/m68k: Split gen_ea_mode_fp for load/store
Date: Wed,  7 May 2025 14:12:52 -0700
Message-ID: <20250507211300.9735-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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
index 2694620375..a6afde7f49 100644
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


