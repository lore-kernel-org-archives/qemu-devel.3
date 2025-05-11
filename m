Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6A5C3ABC3
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 20:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEDP6-0003U2-BW; Sun, 11 May 2025 16:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP3-0003I8-Uv
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:06 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEDP2-0006Mm-3g
 for qemu-devel@nongnu.org; Sun, 11 May 2025 16:36:05 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so2711245a12.3
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 13:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746995762; x=1747600562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ajr6sQHdjTxKRS0SoK6A2gKsRODsAKPtm5i21TP9SuA=;
 b=M663ZojUGCwKMT4PbO0yIfwgYfqgiG50NZQ3ujDMvv/Q5wRgOYKppXaYOOdDFQ28Gd
 0nz589bzyn2ttrBEX61FZu8nqJFrHNfXvSAt7z+TbtyrrFAvTQVJSqTRka+Jo8iuNqCw
 sdmOz0PtYMBhXUlx0JJAUmPjvDbe4m44ojfHBipTUOshejTdCTPL6wFbm58DR96QpYb7
 VA+9QV4zCl7k11v8ERbaPimAjJOLHHUoHFzjOqjg0DpytcHf4i/yl81DgSid6I2VKYyS
 xx2K7M6cbQ6bXbdT7QjqAp/9zWnVPdtnmGQ8Gwf2kDZ0o/lWnlGkFHe5ZEKsbVdPduvb
 bRbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746995762; x=1747600562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ajr6sQHdjTxKRS0SoK6A2gKsRODsAKPtm5i21TP9SuA=;
 b=TobCcVA6ADQyV9LqpjTZFOrPSYuBNa7kQ87IoHMWx3NSsIagYbEVqI6lLbt4pPSltW
 79LO8i+Es6gibbxGInOw7ZsTHHU2h8iLUu+BphSKD5yfWieJe9MK+Gd/hX6jcMwVlJOL
 mFHnDUZkkFZxyhi3Vz93PhD1UfzTx1BocpKLiWwD/pTp0CWuy3nqOVxyWZIqr3oooXa6
 H8o2LuFn6EeXoWHRSu0jJw3Y9OARsF8bLU5OAnEDgAPJlYtFer8AHG+h6mE119zYDN9V
 n4WekgtFMbWYLLE0gdUbISMiYwqTIwrCzNCMzY1etjItbkUIyQwwB/7uYbawxV7CUTig
 9bJw==
X-Gm-Message-State: AOJu0YxRGoAt5IsikkefZS4KOUN4qoBTMvwHxLcX1KjnPuqhveZGUePb
 ewfJwy1rwNWEwX5Xs5Gvtx1FpA1RYuCZ4f+BL9oazPUJq3wCv3xZlrUvtArnAZtUhT5JSpMPPVG
 a
X-Gm-Gg: ASbGncvuK4k76BWRNmhGqn5eiVLv7pQNnoBbhRSDyulyEXncEYMgW/CFcdSk0omButr
 kwVjkugSgqXv9IRvz5agEk015Vu8nqpC5f7woJxertlodHrm2ySkpkpVs3R79qe+nRcPxxTSkm8
 zXUbjmO7VhfApcEn6AbAJOTek3bqYpWmZAMncQKda459LS3o82tTpPbS0tba+CcTFixWSblbNwG
 RLOGZDn3+CfUbjoAqF3NcaJCkcwRRnVkZywHblxvWk24ONpc2uZ+pndBWfGoTcQx+ExnG61jbY3
 6DGjCxyEEcjy+uDFMtdrc1JjwsGX/ToQegSmkiyWN8AZQvOXTo4Qn/KUcya2vjM6g7nqhByLhMh
 W+HfLQFD4LA==
X-Google-Smtp-Source: AGHT+IGQov3aHk2fw9nl9BT1MWFOnwpb8p0hhRgxb+WQNIt0Ibngu0b6DcugjLSDkAOayKxzNmTmFQ==
X-Received: by 2002:a17:902:d4d2:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22fc8b6b97fmr154371395ad.21.1746995762480; 
 Sun, 11 May 2025 13:36:02 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7544d86sm49955095ad.47.2025.05.11.13.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 13:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, schwab@linux-m68k.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 19/24] target/m68k: Merge gen_load_fp, gen_load_mode_fp
Date: Sun, 11 May 2025 13:35:41 -0700
Message-ID: <20250511203546.139788-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250511203546.139788-1-richard.henderson@linaro.org>
References: <20250511203546.139788-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

This enables the exceptions raised by the actual load
to be reflected as a failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/translate.c | 104 ++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 53 deletions(-)

diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index ab6db2cd57..dbbe1b7c91 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -902,53 +902,6 @@ static void gen_fp_move(TCGv_ptr dest, TCGv_ptr src)
     tcg_gen_st_i64(t64, dest, offsetof(FPReg, l.lower));
 }
 
-static void gen_load_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
-                        int index)
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
-        tcg_gen_qemu_ld_tl(tmp, addr, index, opsize | MO_SIGN | MO_TE);
-        gen_helper_exts32(tcg_env, fp, tmp);
-        break;
-    case OS_SINGLE:
-        tcg_gen_qemu_ld_tl(tmp, addr, index, MO_TEUL);
-        gen_helper_extf32(tcg_env, fp, tmp);
-        break;
-    case OS_DOUBLE:
-        tcg_gen_qemu_ld_i64(t64, addr, index, MO_TEUQ);
-        gen_helper_extf64(tcg_env, fp, t64);
-        break;
-    case OS_EXTENDED:
-        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
-            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
-            break;
-        }
-        tcg_gen_qemu_ld_i32(tmp, addr, index, MO_TEUL);
-        tcg_gen_shri_i32(tmp, tmp, 16);
-        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
-        tcg_gen_addi_i32(tmp, addr, 4);
-        tcg_gen_qemu_ld_i64(t64, tmp, index, MO_TEUQ);
-        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
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
 static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
                          int index)
 {
@@ -996,8 +949,8 @@ static void gen_store_fp(DisasContext *s, int opsize, TCGv addr, TCGv_ptr fp,
     }
 }
 
-static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
-                             TCGv_ptr fp, int index)
+static bool gen_load_fp(DisasContext *s, uint16_t insn, int opsize,
+                        TCGv_ptr fp, int index)
 {
     int mode = extract32(insn, 3, 3);
     int reg0 = REG(insn, 0);
@@ -1084,10 +1037,55 @@ static bool gen_load_mode_fp(DisasContext *s, uint16_t insn, int opsize,
             gen_addr_fault(s);
             return false;
         }
-        gen_load_fp(s, opsize, addr, fp, index);
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
+        tcg_gen_qemu_ld_tl(tmp, addr, index, opsize | MO_SIGN | MO_TE);
+        gen_helper_exts32(tcg_env, fp, tmp);
+        break;
+    case OS_SINGLE:
+        tmp = tcg_temp_new();
+        tcg_gen_qemu_ld_tl(tmp, addr, index, MO_TEUL);
+        gen_helper_extf32(tcg_env, fp, tmp);
+        break;
+    case OS_DOUBLE:
+        t64 = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i64(t64, addr, index, MO_TEUQ);
+        gen_helper_extf64(tcg_env, fp, t64);
+        break;
+    case OS_EXTENDED:
+        if (m68k_feature(s->env, M68K_FEATURE_CF_FPU)) {
+            gen_exception(s, s->base.pc_next, EXCP_FP_UNIMP);
+            return false;
+        }
+        tmp = tcg_temp_new();
+        t64 = tcg_temp_new_i64();
+        tcg_gen_qemu_ld_i32(tmp, addr, index, MO_TEUL);
+        tcg_gen_addi_i32(addr, addr, 4);
+        tcg_gen_qemu_ld_i64(t64, addr, index, MO_TEUQ);
+        tcg_gen_shri_i32(tmp, tmp, 16);
+        tcg_gen_st16_i32(tmp, fp, offsetof(FPReg, l.upper));
+        tcg_gen_st_i64(t64, fp, offsetof(FPReg, l.lower));
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
 
 static bool gen_store_mode_fp(DisasContext *s, uint16_t insn, int opsize,
@@ -4911,7 +4909,7 @@ DISAS_INSN(fpu)
         /* Source effective address.  */
         opsize = ext_opsize(ext, 10);
         cpu_src = gen_fp_result_ptr();
-        if (!gen_load_mode_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
+        if (!gen_load_fp(s, insn, opsize, cpu_src, IS_USER(s))) {
             return;
         }
     } else {
-- 
2.43.0


