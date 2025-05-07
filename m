Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B19C3ABC5
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 21:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCm5K-0006Hg-Kn; Wed, 07 May 2025 17:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4y-0006Cb-1h
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uCm4u-0006FK-Db
 for qemu-devel@nongnu.org; Wed, 07 May 2025 17:13:23 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so358175b3a.3
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746652397; x=1747257197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GtWEOmY8WNzf/zuqN1oHdsdFxXcLLPjcJIdBZ8JJ7O4=;
 b=hQ+/BzBnGXbd3+fKfLM0q1FRo9c2Fghnr7v9RryvBERWeWWahvMp2oazL3nonP5FNE
 Mv0n5lah3NMsv268EkhMKt5NUmrNUfNS4pB7Y3pUkLOVhvTv8+hAJTxIUISncuqP2eyr
 orylrHEHR8IdXxiX04pwt1CYVa0kaBijDqxT158WiPOas/wm/5wxvBZ2KyV/FzDhl1cz
 Rzi0B+wxm4UJucO93AGJRwmOW0y0nnLV5iF7tkh8rbIb0eSJy85ip2MBWxgCD6ozxdfk
 IdkEJ+HrZkSmq3ysomSAJ/iyelQpM08GuAJfUXCT30lm38EtEqFw6Zet4lwl0/8wzttg
 yfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746652397; x=1747257197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GtWEOmY8WNzf/zuqN1oHdsdFxXcLLPjcJIdBZ8JJ7O4=;
 b=uY0fUJl58muyErqPv9vznYTcR4+3JNIOw7pT2h/PgqujQYGfvA8aOF6VssGeAINnXf
 yQURheVxCTFoBbtN9YyOmmCl6qSxJVVCfwHulKwVHMic/nrZ8OU2J7BC4GBmjPFtwsIe
 L5zEk044+EadavolJITvTbNlp5pvSlF9wq68p4oCre2l71AXD/MnB/kyVPu0qcIyP3Tc
 imnyb/WdttiFy+Ms2jlVv5kdS5VXWNGtX9S/R9CTQwiFKZ8P7YbM1Uy1FCNIwUrbq8jd
 AO8+0BgaH2FaAPUK3dEnUYAEdg+GsdcBEmsMC+FRf2ZCqGLmqFLyr14K+vq2MHiqO7gq
 LXRw==
X-Gm-Message-State: AOJu0YyLBAXTLsT/fdnIdjQEdvKeJijBAgps+428K/e2XOQPxhPTsDd/
 OE4NpBAKpvZyvzTV4V+rU17cejXIJeecM3gAPd4paYHTGruEXQJ8D86btgnFsHM1C05ZQhjYgYV
 B
X-Gm-Gg: ASbGncux9cK7Kqenoo98CqPk5KGds0J3N6O2PB7w9QrWinkXBN0D0rPmZSS7uEH99On
 jOLMfJF14ufKGTW0eq9sN7H/vNfgnwevdl7sXujwx9ISTxFHVrgyeDR891GqYpixWvVwfpG8kUz
 Snnf02+IPDC6s7LXNTsUUdyqZ01TtQeC/rxW5x0elT57RuJGg/ISH0E+C5O1R0npTcyCiF8nWoD
 IIcVVdehGUB1RyRV2P61RfFxmY1W01cD8pG6hxtnYgU3WgBi+namAe5ccm7JzS+ChiVsn9mywLz
 AmB6VZH9QUGHqGc4O2tfASVNPuCaxQvQTec/7raMKdKpB+Efp0TaXvjpTEuwV4Nc4xIPEyBiIei
 XvZogvKY0dg==
X-Google-Smtp-Source: AGHT+IE/Ej/Y45wJFUCGjHyQhsFRxgecfHPCs5KUnVEIKmaFK7E53x1RIDZTxnecFP2RJrRJw7eQag==
X-Received: by 2002:a05:6a20:72a1:b0:1f5:92ac:d6a1 with SMTP id
 adf61e73a8af0-2148b52649emr6219232637.4.1746652397629; 
 Wed, 07 May 2025 14:13:17 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405902154dsm12255251b3a.90.2025.05.07.14.13.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 14:13:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 19/24] target/m68k: Merge gen_load_fp, gen_load_mode_fp
Date: Wed,  7 May 2025 14:12:54 -0700
Message-ID: <20250507211300.9735-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507211300.9735-1-richard.henderson@linaro.org>
References: <20250507211300.9735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 642e80857c..711f1477c8 100644
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


