Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19390ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 16:26:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snhAS-0003Z0-Dy; Mon, 09 Sep 2024 12:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAP-0003Mq-4R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1snhAN-0007n2-9i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 12:23:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-206e614953aso35273395ad.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 09:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725898982; x=1726503782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FjPJdMiFp2qtQ+N77Rf2O8K/HKwrhuZ1eIewOSHyicM=;
 b=E1bNa+dLvXAZn9Reau2g7DB99WAmHax8TCyTmc54Zp/wEXQSREtZLPYyew2g49R4L5
 hi3jx4EbqZW5AVrG5Ntorl5eZksVzDmkCutix6IRYcOH8+fy+uFbeogt4vrPSF4O/q/6
 3GTwWMhWdmEpqkDY8nOEEBFLDJ4c9VKkS97bKM82aobZ0MsmyUJ+GG3Eq2YZ7osFWmsr
 25pw4YT19eAUfvKpNz068RnS2mY8koPLX1d/gU1yUp1YROm6VvToI/qvYKb2Qr9FfX1Y
 tLhTZ/kNQo/CfzT9ZK4BFef/WekXlqZaKEAAnWvnDcBko9iVOZ9Pnb2pTHJMrlWBHn4m
 WOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898982; x=1726503782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FjPJdMiFp2qtQ+N77Rf2O8K/HKwrhuZ1eIewOSHyicM=;
 b=mOZWM3d2Ms3ceLfrH5A/Lr0pXjsHpNIO6XjYvJezUHcWW5ehiQu5aUWQgM9Z0xhMnG
 6j+EZxbGnj3Bp1p3995mb7lXLg6ty2yRkJlJHEEy2JsL/oJA3XbQw9DYFY9ubAFXpHzP
 flwYmp3lwCto4GiefJf+a3JaIpu3rf+2ff8DdXFO+PF/H4iOl6ZbD44t1VM6iLFL9PYh
 KjZTO7/dE+3d/HxTZwFUux1XmZhCX3P1LZzrJHgfJgMr3KyLZVATyA86/J0CO8Ce1jJd
 hyiH/rl3PJccsRJEeLmM/12MfpsCEoEgqEdbi2B8hREaOn50/Fp4no6lsv6NDF3SfdgF
 5Oaw==
X-Gm-Message-State: AOJu0YxYOrJHct8TYQK3nPQZ8X6j/kSDVHcrJ/kVn48Sxh0VHWlm29Io
 CVhCZutALpG6ugXfCBA14jPlpDjaXOVQnu2FPXMeNYxi2LOL+t+ZhFkSwgyh2PZ8uK7vy34LQ3W
 e
X-Google-Smtp-Source: AGHT+IGstsf10Ke6ruxdLsz/p9BB74O8+n232Rctjuc6csy1/JvfY6Uc/t4dR019snavmKo+Ptslcw==
X-Received: by 2002:a17:903:1c2:b0:207:1722:37d4 with SMTP id
 d9443c01a7336-207172238bemr100809875ad.33.1725898982018; 
 Mon, 09 Sep 2024 09:23:02 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f35d79sm35753305ad.288.2024.09.09.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 09:23:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 22/29] target/arm: Convert SHRN, RSHRN to decodetree
Date: Mon,  9 Sep 2024 09:22:32 -0700
Message-ID: <20240909162240.647173-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909162240.647173-1-richard.henderson@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 95 +++++++++++++++++-----------------
 target/arm/tcg/a64.decode      |  8 +++
 2 files changed, 55 insertions(+), 48 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f4deacd554..8871087af0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7091,6 +7091,51 @@ static void gen_urshr_d(TCGv_i64 dst, TCGv_i64 src, int64_t shift)
     }
 }
 
+static bool do_vec_shift_imm_narrow(DisasContext *s, arg_qrri_e *a,
+                                    WideShiftImmFn * const fns[3], MemOp sign)
+{
+    TCGv_i64 tcg_rn, tcg_rd;
+    int esz = a->esz;
+    int esize;
+    WideShiftImmFn *fn;
+
+    tcg_debug_assert(esz >= MO_8 && esz <= MO_32);
+
+    if (!fp_access_check(s)) {
+        return true;
+    }
+
+    tcg_rn = tcg_temp_new_i64();
+    tcg_rd = tcg_temp_new_i64();
+    tcg_gen_movi_i64(tcg_rd, 0);
+
+    fn = fns[esz];
+    esize = 8 << esz;
+    for (int i = 0, elements = 8 >> esz; i < elements; i++) {
+        read_vec_element(s, tcg_rn, a->rn, i, (esz + 1) | sign);
+        fn(tcg_rn, tcg_rn, a->imm);
+        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_rn, esize * i, esize);
+    }
+
+    write_vec_element(s, tcg_rd, a->rd, a->q, MO_64);
+    clear_vec_high(s, a->q, a->rd);
+    return true;
+}
+
+static WideShiftImmFn * const shrn_fns[] = {
+    tcg_gen_shri_i64,
+    tcg_gen_shri_i64,
+    gen_ushr_d,
+};
+TRANS(SHRN_v, do_vec_shift_imm_narrow, a, shrn_fns, 0)
+
+static WideShiftImmFn * const rshrn_fns[] = {
+    gen_urshr_bhs,
+    gen_urshr_bhs,
+    gen_urshr_d,
+};
+TRANS(RSHRN_v, do_vec_shift_imm_narrow, a, rshrn_fns, 0)
+
 /* Shift a TCGv src by TCGv shift_amount, put result in dst.
  * Note that it is the caller's responsibility to ensure that the
  * shift amount is in range (ie 0..31 or 0..63) and provide the ARM
@@ -10496,52 +10541,6 @@ static void disas_simd_scalar_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
-/* SHRN/RSHRN - Shift right with narrowing (and potential rounding) */
-static void handle_vec_simd_shrn(DisasContext *s, bool is_q,
-                                 int immh, int immb, int opcode, int rn, int rd)
-{
-    int immhb = immh << 3 | immb;
-    int size = 32 - clz32(immh) - 1;
-    int dsize = 64;
-    int esize = 8 << size;
-    int elements = dsize/esize;
-    int shift = (2 * esize) - immhb;
-    bool round = extract32(opcode, 0, 1);
-    TCGv_i64 tcg_rn, tcg_rd, tcg_final;
-    int i;
-
-    if (extract32(immh, 3, 1)) {
-        unallocated_encoding(s);
-        return;
-    }
-
-    if (!fp_access_check(s)) {
-        return;
-    }
-
-    tcg_rn = tcg_temp_new_i64();
-    tcg_rd = tcg_temp_new_i64();
-    tcg_final = tcg_temp_new_i64();
-    read_vec_element(s, tcg_final, rd, is_q ? 1 : 0, MO_64);
-
-    for (i = 0; i < elements; i++) {
-        read_vec_element(s, tcg_rn, rn, i, size+1);
-        handle_shri_with_rndacc(tcg_rd, tcg_rn, round,
-                                false, true, size+1, shift);
-
-        tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
-    }
-
-    if (!is_q) {
-        write_vec_element(s, tcg_final, rd, 0, MO_64);
-    } else {
-        write_vec_element(s, tcg_final, rd, 1, MO_64);
-    }
-
-    clear_vec_high(s, is_q, rd);
-}
-
-
 /* AdvSIMD shift by immediate
  *  31  30   29 28         23 22  19 18  16 15    11  10 9    5 4    0
  * +---+---+---+-------------+------+------+--------+---+------+------+
@@ -10564,13 +10563,13 @@ static void disas_simd_shift_imm(DisasContext *s, uint32_t insn)
     }
 
     switch (opcode) {
-    case 0x10: /* SHRN */
+    case 0x10: /* SHRN / SQSHRUN */
     case 0x11: /* RSHRN / SQRSHRUN */
         if (is_u) {
             handle_vec_simd_sqshrn(s, false, is_q, false, true, immh, immb,
                                    opcode, rn, rd);
         } else {
-            handle_vec_simd_shrn(s, is_q, immh, immb, opcode, rn, rd);
+            unallocated_encoding(s);
         }
         break;
     case 0x12: /* SQSHRN / UQSHRN */
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index bf67f8a357..164ed575b9 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -1277,3 +1277,11 @@ SSHLL_v         0.00 11110 .... ... 10100 1 ..... .....     @q_shli_s
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_b
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_h
 USHLL_v         0.10 11110 .... ... 10100 1 ..... .....     @q_shli_s
+
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_b
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_h
+SHRN_v          0.00 11110 .... ... 10000 1 ..... .....     @q_shri_s
+
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_b
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_h
+RSHRN_v         0.00 11110 .... ... 10001 1 ..... .....     @q_shri_s
-- 
2.43.0


