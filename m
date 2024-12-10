Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50CFE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2xM-0003T8-4v; Tue, 10 Dec 2024 11:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2x2-0002wB-8l
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:15 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2ww-0006Rh-66
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:19:07 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-54020b0dcd2so2073087e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847538; x=1734452338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qB2IZAS09IccrdqxBacklaTzmXPtI54chcpe7/zCzag=;
 b=JeZmM7g2zFg7MX83VqlTD89KFXV6f0R+fAMopwggJZRvbD+PdsNmylCzu5ttii3IM+
 ryzFFdI+FGhW2lJ23h5edOMSCXKen6aPpN9hlb8RR9jL8N1hV3akdFlDcSspMZhVgRwS
 /XuC6fWigxJqZLkJpi9FI79ZyTnmNvqfL4zxJVnk6Xq5kNLP6MIAxkI1VUH1qcJbBTvc
 S92L5K8hNwwG4c3hN9XjChsgBZIN3qA1KKPbWuo0TuTmMaaSsu//pnsV2TePP5A3/a/y
 p0XHI6cngQrAEALfqNbrEv9j+r/qXLTJoq9mQHZN93WQWW1LxPZN73S3E+BEucmGnheA
 tvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847538; x=1734452338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qB2IZAS09IccrdqxBacklaTzmXPtI54chcpe7/zCzag=;
 b=O/QRC5czbbkVfTktDQScO2h9D+lxSlUWM4vLOveA1rcewrXPndf6JSseFNgWl/n4QA
 /GHd26mIuKOG2bFUCnmNQ20uMZ7EKVkoMG/HoMxSTBzBAKVyRyBAyYF1gtAoAtlrzhR3
 8VIHbcbQy6+8OYBtSP0QPCJOdGwO5PoLP9ETlCaJNfgtDjeZdR1eQ86kFW7cgxpzTzC1
 5JIKDboarPmT8QGYeuAITLlj7QkaMYgrYxnYZMnC/JPLn533iCq14tnmyiOUZ/c9D9Z0
 WJ7fmpLv4XdoC3bfx8ccty5ssIKIc5sth3cXKuf4QuBLjDpype5FhE0ue5/xree+yGup
 DZCg==
X-Gm-Message-State: AOJu0YwNj4sPtJ7qC6utbtFuP9SmQMRQRUEE87KoVniyooMpzrLFCyqf
 64mhjASylxj17cZa1459g+Pgw29tJLbzOTWz6EV0ilYFjNsVSbX2Rvnn1hsLbRs2VdBT0Vjl+ZE
 7YySB5PZ/
X-Gm-Gg: ASbGncuVL/42fycBe7tgznAqhqEMboqPUXa9A4kD9y5ULfA14A4Eq1Vo2kgf2ccFZQz
 2pe9fH+/KY8EgCZ9UWgLoblr/uMGi1sAFygUdes5eNZpIwRyvOeh4QyEQY9G1IeFP/WfOSpcFKI
 bURTlrtdP12BzpzrSX/48ofFkU87WqNIhq/TpQtacT3+qBfbnoFyligrbD+nB5SqvT+2i0O+R08
 mlacsQmlc8h9AnBpdIZddbt9qiABcFZb1RXNCV8RaCmmc4WrXERvnC5NGo=
X-Google-Smtp-Source: AGHT+IG0ATOPoGPMflZCLgM7wZrb6WCIfYUy3T8h+8CZ0qY0aLI39AuUi5xiiwjqDQWv2hYrsD6mOA==
X-Received: by 2002:a05:6512:3d09:b0:540:1db4:3c72 with SMTP id
 2adb3069b0e04-540251e58ebmr1343187e87.10.1733847537850; 
 Tue, 10 Dec 2024 08:18:57 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 19/69] target/arm: Convert disas_cond_select to decodetree
Date: Tue, 10 Dec 2024 10:16:43 -0600
Message-ID: <20241210161733.1830573-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
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

This includes CSEL, CSINC, CSINV, CSNEG.  Remove disas_data_proc_reg,
as these were the last insns decoded by that function.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index a9d7d57199..5670846768 100644
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


