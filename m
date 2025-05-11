Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2E5C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP5-0003Qk-Na; Sun, 11 May 2025 16:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP4-0003K9-KA
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:06 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP2-0006Mv-S9
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:06 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-22e6a088e16so26287445ad.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995763; x=1747600563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=adEj1uMhhPTJoB3dHT9pCp4OzRXbGgu9A26lKGGeCpw=;
 b=bujo/Ji9TALCC+hvoBpCgig3CAkSdavnYMSZllv/fqVqAbM8wTMZTpRwhZrFdvg2gr
 8GNMPdH91ib2cXvWVZvBsRAEBuu5IHLvTAM2hb8kroJ2GT03lGgSG6W59xHXStg0cePM
 unfZrzOaneXoVUzpcJu8vivdv4XDUolj0NtFPdL9XlebcuNILoO4oSmOEt7QjyDixC1a
 AXtADhsYmawAFP5L/WyrY5ec5/s5u3oCNgmTUkqPyT4bRXrPmaLbUz0pRbvIEdq9C322
 47aP/xZcAYM7i3uDJESvwV8e/w/q86HTpCBIdyq1vZ8jSDVYd3GSSyUWgnMEMQs0MhBC
 Tn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995763; x=1747600563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=adEj1uMhhPTJoB3dHT9pCp4OzRXbGgu9A26lKGGeCpw=;
 b=R8Pj2446Npz/ygGUrLBHEluDhKi03tJHjc/Jm9FkhiUJl2HpZrEFv5Kh5iZWlCvAYA
 GyLvD7mZotrqUJs3AmBDopuDwyjsit522s+WotiRS2vKK0OS7/njnaMs6E65+13pCFw8
 7abED1MFa7Pd9IzxkNFoIruwJDMMAxr4CqVlnQPs+bUECRCDvlQa0dH+5lQA0ZfTS6WM
 H+/Yywv3N7pJNJo2b0bvlfBlGl9F4A/Q1ZSXtTgFbzwNz5dJc/jlAibzZUOMXZ/zWtHY
 79Nd3kG3tl4CW+8X8ugx07oQSa4/+p/egZBNvf3WNzkn8op0+yL+kIhAlP8T0gw2XSYv
 X0Zg==
X-Gm-Message-State: AOJu0Yz7wnodMgkXWPgQGQA9CBNxBC21VxbTZ2kLej5PYKvQq/m676R9
 f9ZO5VDUpH4IRXmTMQMLMw3Mu6TxJ2xCC5J4ZpiOD4stf+88Y8+7q9fvbBGdqTDoe2bge2ZHQZL
 Y
X-Gm-Gg: ASbGnctWOJfmyAsNPjD9O3E4ExA9ghUJ+YH/KK2fQ0a9+lBvRDJOxe4YEupGyqb8oLm
 BCHUsvP4A/tbk+FdxRkWWSR+kA7II9jkoo5WGkZ7M8wwquAu8CUfnT+utTvZVv1f7YWPCF5+B6N
 VDFcVf6+RM5xTUd+ljGSqVgNYVEbzXzxKzDzk0OLopjV0+wb03AQhjhyDq9/YHqvKWXtGLCv/XC
 v0TVG+e4mhwoizBkxJts/AY2MN7szb6FZ9tsVkPY9b/x5+7kWyDHSLi2bTicnYSNAoKg1Sjc7cO
 RsTtw992kKx11TokQNoFoLKBogiVN+VO5K/7fMfeK+hl6VtraQBWs//bmu5jBdAhtXmMhOWZWjv
 jF2APTeRD/RmO3cMCSnpb
X-Google-Smtp-Source: AGHT+IE/AppKzbJYBbeuQmVHxaPlhgDn+gQCA+idoR6O6jH8eFGP0OdijkPRYy353vE9T+mG9hE4cA==
X-Received: by 2002:a17:903:1c8:b0:225:abd2:5e5a with SMTP id
 d9443c01a7336-22e846e04d9mr201094455ad.4.1746995763301; 
 Sun, 11 May 2025 13:36:03 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 20/24] target/m68k: Merge gen_store_fp, gen_store_mode_fp
Date: Sun, 11 May 2025 13:35:42 -0700
Message-ID: <20250511203546.139788-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

This enables the exceptions raised by the actual store
to be reflected as a failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 107 ++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 54 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index dbbe1b7c91..c20f1eb518 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -902,53 +902,6 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
     tcg_gen_st_i64(t64, dest, offsetof(FPReg, l.lower));
 }
 
-static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
-                         int index)
-{
-    TCGv tmp;
-    TCGv_i64 t64;
-
-    t64 = tcg_temp_new_i64();
-    tmp = tcg_temp_new();
-    switch (opsize) {
-    case OS_BYTE:
-    case OS_WORD:
-    case OS_LONG:
-        gen_helper_reds32(tmp, tcg_env, fp);
-        tcg_gen_qemu_st_tl(tmp, addr, index, opsize | MO_TE);
-        break;
-    case OS_SINGLE:
-        gen_helper_redf32(tmp, tcg_env, fp);
-        tcg_gen_qemu_st_tl(tmp, addr, index, MO_TEUL);
-        break;
-    case OS_DOUBLE:
-        gen_helper_redf64(t64, tcg_env, fp);
-        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
-        break;
-    case OS_EXTENDED:
-        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-            break;
-        }
-        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
-        tcg_gen_shli_i32(tmp, tmp, 16);
-        tcg_gen_qemu_st_i32(tmp, addr, index, MO_TEUL);
-        tcg_gen_addi_i32(tmp, addr, 4);
-        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
-        tcg_gen_qemu_st_i64(t64, tmp, index, MO_TEUQ);
-        break;
-    case OS_PACKED:
-        /*
-         * unimplemented data type on 68040/ColdFire
-         * FIXME if needed for another FPU
-         */
-        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-        break;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
                         TCGv_ptr fp, int index)
 {
@@ -1088,12 +1041,13 @@ static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
     return true;
 }
 
-static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
-                              TCGv_ptr fp, int index)
+static bool gen_store_fp(DisasContext *s, uint16_t insn, int opsize,
+                         TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
-    TCGv reg, addr;
+    TCGv reg, addr, tmp;
+    TCGv_i64 t64;
 
     switch (mode) {
     case 0: /* Data register direct.  */
@@ -1127,10 +1081,55 @@ static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
             gen_addr_fault(s);
             return false;
         }
-        gen_store_fp(s, opsize, addr, fp, index);
-        return true;
+        break;
+
+    default:
+        g_assert_not_reached();
     }
-    g_assert_not_reached();
+
+    switch (opsize) {
+    case OS_BYTE:
+    case OS_WORD:
+    case OS_LONG:
+        tmp = tcg_temp_new();
+        gen_helper_reds32(tmp, tcg_env, fp);
+        tcg_gen_qemu_st_tl(tmp, addr, index, opsize | MO_TE);
+        break;
+    case OS_SINGLE:
+        tmp = tcg_temp_new();
+        gen_helper_redf32(tmp, tcg_env, fp);
+        tcg_gen_qemu_st_tl(tmp, addr, index, MO_TEUL);
+        break;
+    case OS_DOUBLE:
+        t64 = tcg_temp_new_i64();
+        gen_helper_redf64(t64, tcg_env, fp);
+        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
+        break;
+    case OS_EXTENDED:
+        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            return false;
+        }
+        tmp = tcg_temp_new();
+        t64 = tcg_temp_new_i64();
+        tcg_gen_ld16u_i32(tmp, fp, offsetof(FPReg, l.upper));
+        tcg_gen_shli_i32(tmp, tmp, 16);
+        tcg_gen_qemu_st_i32(tmp, addr, index, MO_TEUL);
+        tcg_gen_addi_i32(addr, addr, 4);
+        tcg_gen_ld_i64(t64, fp, offsetof(FPReg, l.lower));
+        tcg_gen_qemu_st_i64(t64, addr, index, MO_TEUQ);
+        break;
+    case OS_PACKED:
+        /*
+         * unimplemented data type on 68040/ColdFire
+         * FIXME if needed for another FPU
+         */
+        gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+        return false;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
 }
 
 typedef struct {
@@ -4889,7 +4888,7 @@ DISAS_INSN(fpu)
     case 3: /* fmove out */
         cpu_src = gen_fp_ptr(REG(ext, 7));
         opsize = ext_opsize(ext, 10);
-        if (gen_store_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+        if (gen_store_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             gen_helper_ftst(tcg_env, cpu_src);
         }
         return;
-- 
2.43.0


