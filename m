Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A7BCE77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPdo-0007VP-25; Wed, 11 Dec 2024 11:32:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcg-0004Px-Bk
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:40 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPce-0001Gq-Ak
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:38 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-467918c35easo7220181cf.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934695; x=1734539495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KnGIQa/BmdLZVq6MuFlUl+Av3qfctnpKwsMblLrHMtk=;
 b=CcPCGZj2yYzo4nyhJQnRxLDpN7x3mq38Eu39RVsyFzRRZ/IJd4r6usMK/1VYaSm0Dr
 gzJeb7jmhdfFlw3f13DSthrVzq7aWWbx5ZBURBHDhk/CZ+eefMGWWu9dkAbG3hJJaMqo
 rcUtFeuAgYpXzRlxG4jQ1BiOATOYg8hcVZcUSuTg0HdgGLsiHFyD7Yv/5B1idQE6x6Kd
 VMQwvH8g2MnMHQgEdoPDTSTdI0LjWf+BSnmSTcuE7MkerbCmOI8ZBQP2KQ0Yc8Eg57p1
 CMQG9y6bxuiPyE94EFvkG0xjVp6WiNX0AFWa+pIZwNDATG0C6HW0JyRbEf7+3tb0Ayyz
 E32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934695; x=1734539495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KnGIQa/BmdLZVq6MuFlUl+Av3qfctnpKwsMblLrHMtk=;
 b=TtKewE2P1kLWjiVsr1tAKySehmWHpaDOsm+q96tiMql3VHhxT77Wdd5eQEEIZ+jN6O
 weqS/cC/ghlg9/M2ObcrjUR3ryyncwijsY7Os6snEb/MMgCbpoMEPmpcEWSFB3nsd5G+
 8PmdAPKUFc5SDoweQW5s58SPT9hOo795dMBOJfOfh6pFce7pLY2OZEJzE82jAfF0xrvZ
 En1ulJQKFfTVqPjWRwh/42JpgXuGX6e7gQceP/2kxCkJ9YjKI7xiBuQx6JWoXu3o/tCj
 jv6avlMVz9RQTG/B91QofAvdeJw/H2Fztgt4Y/sbFrMJSx9KVB6FJLfrF0i48VYKMmEV
 gDOQ==
X-Gm-Message-State: AOJu0YxxUvpCGpDnykPJ0iqSFLWT+TskcmyNyGkCtWaiBVeNP6kVkc42
 FI+wdlhrgJUup+pUJchMyhZDBwgxNk5RQlyzD6iGcKVJdV87K21ztk9X1u5RAdjZBR2W4rwaHHY
 04FR9z5AH
X-Gm-Gg: ASbGnct1Rs6z7ScQC3sp00qM8b308XCz3eXM3qtvOP/SrpiRdYfe00LN4oYXX0mrhT9
 f3tV6LJ2FM5jLgvSLHVlzGmZQ2IXXFI2GPWZ1hvI8n5cQqxj+veIdbR4wERQOMPN+oYlH95RC7N
 +5E7p6oybgak4bgJcW9sF51v8g+2XlT3EL4edmOhnaOeC6OecFALKf6QhJrwbVGNdszxQj4y9pe
 x0i5rTJUSObAgISzo/Gfoyrre+nqL6DOA+SrNCNhPYXXaT4c0suO60v2Nswzg==
X-Google-Smtp-Source: AGHT+IER4LAJYo9PpGKPX+uvcvj0aq49QpHBjVrtUG2Uz/f64st9M8dpBHouf3kFYzl6tsRI3tYLqg==
X-Received: by 2002:a05:622a:5448:b0:467:6226:bfc1 with SMTP id
 d75a77b69052e-46789309ec8mr68821881cf.29.1733934695234; 
 Wed, 11 Dec 2024 08:31:35 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 14/69] target/arm: Convert disas_data_proc_3src to
 decodetree
Date: Wed, 11 Dec 2024 10:29:41 -0600
Message-ID: <20241211163036.2297116-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211163036.2297116-1-richard.henderson@linaro.org>
References: <20241211163036.2297116-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::82f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x82f.google.com
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

This includes MADD, MSUB, SMADDL, SMSUBL, UMADDL, UMSUBL, SMULH, UMULH.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 119 ++++++++++++---------------------
 target/arm/tcg/a64.decode      |  16 +++++
 2 files changed, 59 insertions(+), 76 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index d570bbb696..99ff787c61 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7955,98 +7955,68 @@ TRANS(SUB_r, do_addsub_reg, a, true, false)
 TRANS(ADDS_r, do_addsub_reg, a, false, true)
 TRANS(SUBS_r, do_addsub_reg, a, true, true)
 
-/* Data-processing (3 source)
- *
- *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
- *  +--+------+-----------+------+------+----+------+------+------+
- *  |sf| op54 | 1 1 0 1 1 | op31 |  Rm  | o0 |  Ra  |  Rn  |  Rd  |
- *  +--+------+-----------+------+------+----+------+------+------+
- */
-static void disas_data_proc_3src(DisasContext *s, uint32_t insn)
+static bool do_mulh(DisasContext *s, arg_rrr *a,
+                    void (*fn)(TCGv_i64, TCGv_i64, TCGv_i64, TCGv_i64))
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int ra = extract32(insn, 10, 5);
-    int rm = extract32(insn, 16, 5);
-    int op_id = (extract32(insn, 29, 3) << 4) |
-        (extract32(insn, 21, 3) << 1) |
-        extract32(insn, 15, 1);
-    bool sf = extract32(insn, 31, 1);
-    bool is_sub = extract32(op_id, 0, 1);
-    bool is_high = extract32(op_id, 2, 1);
-    bool is_signed = false;
-    TCGv_i64 tcg_op1;
-    TCGv_i64 tcg_op2;
-    TCGv_i64 tcg_tmp;
+    TCGv_i64 discard = tcg_temp_new_i64();
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_rn = cpu_reg(s, a->rn);
+    TCGv_i64 tcg_rm = cpu_reg(s, a->rm);
 
-    /* Note that op_id is sf:op54:op31:o0 so it includes the 32/64 size flag */
-    switch (op_id) {
-    case 0x42: /* SMADDL */
-    case 0x43: /* SMSUBL */
-    case 0x44: /* SMULH */
-        is_signed = true;
-        break;
-    case 0x0: /* MADD (32bit) */
-    case 0x1: /* MSUB (32bit) */
-    case 0x40: /* MADD (64bit) */
-    case 0x41: /* MSUB (64bit) */
-    case 0x4a: /* UMADDL */
-    case 0x4b: /* UMSUBL */
-    case 0x4c: /* UMULH */
-        break;
-    default:
-        unallocated_encoding(s);
-        return;
-    }
+    fn(discard, tcg_rd, tcg_rn, tcg_rm);
+    return true;
+}
 
-    if (is_high) {
-        TCGv_i64 low_bits = tcg_temp_new_i64(); /* low bits discarded */
-        TCGv_i64 tcg_rd = cpu_reg(s, rd);
-        TCGv_i64 tcg_rn = cpu_reg(s, rn);
-        TCGv_i64 tcg_rm = cpu_reg(s, rm);
+TRANS(SMULH, do_mulh, a, tcg_gen_muls2_i64)
+TRANS(UMULH, do_mulh, a, tcg_gen_mulu2_i64)
 
-        if (is_signed) {
-            tcg_gen_muls2_i64(low_bits, tcg_rd, tcg_rn, tcg_rm);
-        } else {
-            tcg_gen_mulu2_i64(low_bits, tcg_rd, tcg_rn, tcg_rm);
-        }
-        return;
-    }
+static bool do_muladd(DisasContext *s, arg_rrrr *a,
+                      bool sf, bool is_sub, MemOp mop)
+{
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 tcg_op1, tcg_op2;
 
-    tcg_op1 = tcg_temp_new_i64();
-    tcg_op2 = tcg_temp_new_i64();
-    tcg_tmp = tcg_temp_new_i64();
-
-    if (op_id < 0x42) {
-        tcg_gen_mov_i64(tcg_op1, cpu_reg(s, rn));
-        tcg_gen_mov_i64(tcg_op2, cpu_reg(s, rm));
+    if (mop == MO_64) {
+        tcg_op1 = cpu_reg(s, a->rn);
+        tcg_op2 = cpu_reg(s, a->rm);
     } else {
-        if (is_signed) {
-            tcg_gen_ext32s_i64(tcg_op1, cpu_reg(s, rn));
-            tcg_gen_ext32s_i64(tcg_op2, cpu_reg(s, rm));
-        } else {
-            tcg_gen_ext32u_i64(tcg_op1, cpu_reg(s, rn));
-            tcg_gen_ext32u_i64(tcg_op2, cpu_reg(s, rm));
-        }
+        tcg_op1 = tcg_temp_new_i64();
+        tcg_op2 = tcg_temp_new_i64();
+        tcg_gen_ext_i64(tcg_op1, cpu_reg(s, a->rn), mop);
+        tcg_gen_ext_i64(tcg_op2, cpu_reg(s, a->rm), mop);
     }
 
-    if (ra == 31 && !is_sub) {
+    if (a->ra == 31 && !is_sub) {
         /* Special-case MADD with rA == XZR; it is the standard MUL alias */
-        tcg_gen_mul_i64(cpu_reg(s, rd), tcg_op1, tcg_op2);
+        tcg_gen_mul_i64(tcg_rd, tcg_op1, tcg_op2);
     } else {
+        TCGv_i64 tcg_tmp = tcg_temp_new_i64();
+        TCGv_i64 tcg_ra = cpu_reg(s, a->ra);
+
         tcg_gen_mul_i64(tcg_tmp, tcg_op1, tcg_op2);
         if (is_sub) {
-            tcg_gen_sub_i64(cpu_reg(s, rd), cpu_reg(s, ra), tcg_tmp);
+            tcg_gen_sub_i64(tcg_rd, tcg_ra, tcg_tmp);
         } else {
-            tcg_gen_add_i64(cpu_reg(s, rd), cpu_reg(s, ra), tcg_tmp);
+            tcg_gen_add_i64(tcg_rd, tcg_ra, tcg_tmp);
         }
     }
 
     if (!sf) {
-        tcg_gen_ext32u_i64(cpu_reg(s, rd), cpu_reg(s, rd));
+        tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
+    return true;
 }
 
+TRANS(MADD_w, do_muladd, a, false, false, MO_64)
+TRANS(MSUB_w, do_muladd, a, false, true, MO_64)
+TRANS(MADD_x, do_muladd, a, true, false, MO_64)
+TRANS(MSUB_x, do_muladd, a, true, true, MO_64)
+
+TRANS(SMADDL, do_muladd, a, true, false, MO_SL)
+TRANS(SMSUBL, do_muladd, a, true, true, MO_SL)
+TRANS(UMADDL, do_muladd, a, true, false, MO_UL)
+TRANS(UMSUBL, do_muladd, a, true, true, MO_UL)
+
 /* Add/subtract (with carry)
  *  31 30 29 28 27 26 25 24 23 22 21  20  16  15       10  9    5 4   0
  * +--+--+--+------------------------+------+-------------+------+-----+
@@ -8364,13 +8334,10 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
         disas_cond_select(s, insn);
         break;
 
-    case 0x8 ... 0xf: /* (3 source) */
-        disas_data_proc_3src(s, insn);
-        break;
-
     default:
     do_unallocated:
     case 0x6: /* Data-processing */
+    case 0x8 ... 0xf: /* (3 source) */
         unallocated_encoding(s);
         break;
     }
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 27a3101bc6..b0cc8bd476 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -753,6 +753,22 @@ SUBS_ext        . 11 01011001 ..... ... ... ..... .....     @addsub_ext
 # Conditional select
 # Data Processing (3-source)
 
+&rrrr           rd rn rm ra
+@rrrr           . .. ........ rm:5 . ra:5 rn:5 rd:5     &rrrr
+
+MADD_w          0 00 11011000 ..... 0 ..... ..... ..... @rrrr
+MSUB_w          0 00 11011000 ..... 1 ..... ..... ..... @rrrr
+MADD_x          1 00 11011000 ..... 0 ..... ..... ..... @rrrr
+MSUB_x          1 00 11011000 ..... 1 ..... ..... ..... @rrrr
+
+SMADDL          1 00 11011001 ..... 0 ..... ..... ..... @rrrr
+SMSUBL          1 00 11011001 ..... 1 ..... ..... ..... @rrrr
+UMADDL          1 00 11011101 ..... 0 ..... ..... ..... @rrrr
+UMSUBL          1 00 11011101 ..... 1 ..... ..... ..... @rrrr
+
+SMULH           1 00 11011010 ..... 0 11111 ..... ..... @rrr
+UMULH           1 00 11011110 ..... 0 11111 ..... ..... @rrr
+
 ### Cryptographic AES
 
 AESE            01001110 00 10100 00100 10 ..... .....  @r2r_q1e0
-- 
2.43.0


