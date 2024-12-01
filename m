Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FA2D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlWz-0001Sl-4P; Sun, 01 Dec 2024 10:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWs-0001Nv-S4
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:34 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlWq-0004DE-N6
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:06:34 -0500
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-71d51a9a42bso1484270a34.1
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065591; x=1733670391; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/e/LG5UrhiLtD4WGU52HpCFQh7KQHX53bSZj6MYyvY=;
 b=KpBhIxfx5AEgdG9VADFO3GxqgIivfL9Wz02Lfs1YAG4nUaQreD96UmP+h41i1NR6Mt
 Q9ce+0hfilkEJNuikxYGsKNPDTwom6DdQj8u5heHfIyhvOCcayAGp2jjMOqZJqj1Bt+w
 /jDIOZ7lnSHNV8ICHBYIng8HQ3bCM61R4roRPflnK2DdGzPjwaNTVeHiF2oueLEOgO7F
 axI42/tfbq7hzreGexp9veIBpBp1cTfDzNUEWFQ7Ypq1NpMlxr7+0dPmC4UDaB9jB3VY
 ezY8P4izI0GsVxmbcNMwxKEYKiLN1qY1ysEmgk6/EaG0c3diDHTjq9XUTKHc+PTeIuzm
 m0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065591; x=1733670391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8/e/LG5UrhiLtD4WGU52HpCFQh7KQHX53bSZj6MYyvY=;
 b=htmQcYj8mp1TKtTJNeybrVy6NtLw6/uf6XHnSSl8UcvdqIxx9XlbLYKptlK3oVx4aF
 NLattXTNf6VgPbPddphZ+UoKwT69hcpeZaXT/LH1mpATXdjwsRE5tyNnCAOBqyY7sQxb
 oF0qUa+acK+PKnV3pcEjTjGCWvjJ04doO8Zn/2UvR8NU6dWhwpEw3g/yo2ahRepFbEtj
 ZyBjOXRFEVg9XXV0oLbRZAZFfq193+7QL1U6uaWgIgMiyQhXWJ6cLQBhgxlgbODA9uUT
 lFC1hGLcNTDm0F2OrPuGzdKBwfZO4z4arVJI3Zc9IdXvCk+5xQIdVACVMns6ZhCCdsVH
 fWkQ==
X-Gm-Message-State: AOJu0Yz7mjjivMHfFcKN5cfGK7pirbUroqN4teUHmijY0uWf9SAETsmi
 GhW5CSwhLjz7NX8pquDHI3v/jYlHF9WcAVIqsvro1agnLtEg/zyrXhFIFTDgYeB5KAUq5yaSHcq
 ocVo=
X-Gm-Gg: ASbGncvSpm9PIYoTKNZdXZNCNsN+0vf87I3eypiUFwNbyS0jj6RVhMrIfNyqNV6/rQQ
 mK7zVZKp9kMhYAd1tsaYRz+KdhLa92F7WAqg8RM8HYgk74pjcCR/i9wQmqM4ppXW9cHq/VmA9y3
 5HJqcmgb/41JTP8agQ1X6LBRTeD31v1F/vn4rCfhGjxAxq+X3+P7HRTnYDZcrUHqDeD6t+xB3uk
 e+S8Cb+52pu1+rGQUHwo3V2g1AJEHHssQHQz79qeh+EhSSkC8CgKjDr3Bb+r74hDdct/aw0g1jE
 VfdkTWf/Pt8wWFq9RKhrXhpEBDhR80f3+Pvy
X-Google-Smtp-Source: AGHT+IGB1gu6pilbTki+GbCPvMDfrdxFQc2GcllWTtSgXHbamnZ+VJ/xJ32fv4JtGUFcEAeCu1x3eQ==
X-Received: by 2002:a05:6830:7308:b0:71d:5f22:aff3 with SMTP id
 46e09a7af769-71d65c6f968mr14370787a34.4.1733065591477; 
 Sun, 01 Dec 2024 07:06:31 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d7254473asm1822220a34.27.2024.12.01.07.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:06:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 19/67] target/arm: Convert disas_cond_select to decodetree
Date: Sun,  1 Dec 2024 09:05:18 -0600
Message-ID: <20241201150607.12812-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

This includes CSEL, CSINC, CSINV, CSNEG.  Remove disas_data_proc_reg,
as these were the last insns decoded by that function.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 84 ++++++----------------------------
 target/arm/tcg/a64.decode      |  3 ++
 2 files changed, 17 insertions(+), 70 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 56a445a3c2..9c6365f5ef 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8171,39 +8171,17 @@ static bool trans_CCMP(DisasContext *s, arg_CCMP *a)
     return true;
 }
 
-/* Conditional select
- *   31   30  29  28             21 20  16 15  12 11 10 9    5 4    0
- * +----+----+---+-----------------+------+------+-----+------+------+
- * | sf | op | S | 1 1 0 1 0 1 0 0 |  Rm  | cond | op2 |  Rn  |  Rd  |
- * +----+----+---+-----------------+------+------+-----+------+------+
- */
-static void disas_cond_select(DisasContext *s, uint32_t insn)
+static bool trans_CSEL(DisasContext *s, arg_CSEL *a)
 {
-    unsigned int sf, else_inv, rm, cond, else_inc, rn, rd;
-    TCGv_i64 tcg_rd, zero;
+    TCGv_i64 tcg_rd = cpu_reg(s, a->rd);
+    TCGv_i64 zero = tcg_constant_i64(0);
     DisasCompare64 c;
 
-    if (extract32(insn, 29, 1) || extract32(insn, 11, 1)) {
-        /* S == 1 or op2<1> == 1 */
-        unallocated_encoding(s);
-        return;
-    }
-    sf = extract32(insn, 31, 1);
-    else_inv = extract32(insn, 30, 1);
-    rm = extract32(insn, 16, 5);
-    cond = extract32(insn, 12, 4);
-    else_inc = extract32(insn, 10, 1);
-    rn = extract32(insn, 5, 5);
-    rd = extract32(insn, 0, 5);
+    a64_test_cc(&c, a->cond);
 
-    tcg_rd = cpu_reg(s, rd);
-
-    a64_test_cc(&c, cond);
-    zero = tcg_constant_i64(0);
-
-    if (rn == 31 && rm == 31 && (else_inc ^ else_inv)) {
+    if (a->rn == 31 && a->rm == 31 && (a->else_inc ^ a->else_inv)) {
         /* CSET & CSETM.  */
-        if (else_inv) {
+        if (a->else_inv) {
             tcg_gen_negsetcond_i64(tcg_invert_cond(c.cond),
                                    tcg_rd, c.value, zero);
         } else {
@@ -8211,53 +8189,23 @@ static void disas_cond_select(DisasContext *s, uint32_t insn)
                                 tcg_rd, c.value, zero);
         }
     } else {
-        TCGv_i64 t_true = cpu_reg(s, rn);
-        TCGv_i64 t_false = read_cpu_reg(s, rm, 1);
-        if (else_inv && else_inc) {
+        TCGv_i64 t_true = cpu_reg(s, a->rn);
+        TCGv_i64 t_false = read_cpu_reg(s, a->rm, 1);
+
+        if (a->else_inv && a->else_inc) {
             tcg_gen_neg_i64(t_false, t_false);
-        } else if (else_inv) {
+        } else if (a->else_inv) {
             tcg_gen_not_i64(t_false, t_false);
-        } else if (else_inc) {
+        } else if (a->else_inc) {
             tcg_gen_addi_i64(t_false, t_false, 1);
         }
         tcg_gen_movcond_i64(c.cond, tcg_rd, c.value, zero, t_true, t_false);
     }
 
-    if (!sf) {
+    if (!a->sf) {
         tcg_gen_ext32u_i64(tcg_rd, tcg_rd);
     }
-}
-
-/*
- * Data processing - register
- *  31  30 29  28      25    21  20  16      10         0
- * +--+---+--+---+-------+-----+-------+-------+---------+
- * |  |op0|  |op1| 1 0 1 | op2 |       |  op3  |         |
- * +--+---+--+---+-------+-----+-------+-------+---------+
- */
-static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
-{
-    int op1 = extract32(insn, 28, 1);
-    int op2 = extract32(insn, 21, 4);
-
-    if (!op1) {
-        goto do_unallocated;
-    }
-
-    switch (op2) {
-    case 0x4: /* Conditional select */
-        disas_cond_select(s, insn);
-        break;
-
-    default:
-    do_unallocated:
-    case 0x0:
-    case 0x2: /* Conditional compare */
-    case 0x6: /* Data-processing */
-    case 0x8 ... 0xf: /* (3 source) */
-        unallocated_encoding(s);
-        break;
-    }
+    return true;
 }
 
 static void handle_fp_compare(DisasContext *s, int size,
@@ -11212,10 +11160,6 @@ static bool btype_destination_ok(uint32_t insn, bool bt, int btype)
 static void disas_a64_legacy(DisasContext *s, uint32_t insn)
 {
     switch (extract32(insn, 25, 4)) {
-    case 0x5:
-    case 0xd:      /* Data processing - register */
-        disas_data_proc_reg(s, insn);
-        break;
     case 0x7:
     case 0xf:      /* Data processing - SIMD and floating point */
         disas_data_proc_simd_fp(s, insn);
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index b339adee6f..3bc2767106 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -766,6 +766,9 @@ SETF16          0 01 11010000 00000 010010 rn:5 01101
 CCMP            sf:1 op:1 1 11010010 y:5 cond:4 imm:1 0 rn:5 0 nzcv:4
 
 # Conditional select
+
+CSEL            sf:1 else_inv:1 011010100 rm:5 cond:4 0 else_inc:1 rn:5 rd:5
+
 # Data Processing (3-source)
 
 &rrrr           rd rn rm ra
-- 
2.43.0


