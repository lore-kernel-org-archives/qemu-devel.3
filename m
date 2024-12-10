Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC65E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 16:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL2wg-0002cb-9u; Tue, 10 Dec 2024 11:18:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wY-0002b4-7T
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:38 -0500
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tL2wW-0006OD-Gh
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 11:18:37 -0500
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-54024aa9febso1380655e87.1
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733847515; x=1734452315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvYUTxGU0SlbdB/A8XWhhOlkaNp7pR5YZMOeGOSqwZc=;
 b=RGYKuuMbMbyb+rLgLk56XP+ay0zUaoh5Bn5oxmpyqZGtWYnFviHyWMA14SpyAIHqzE
 8SGhrEvy2I3kDFplVAzHpiTqzxvHEyErzPZtVDgS2EW3p63FYGWLsuUFwdekfzeXid7X
 QZO876JGu+WQLpPDPyPGy/yDq8+015BXKPy9cbWbfAqcFioxe9jun08Hc7MvWlGNS++i
 eEl/n72qPx6CuH+pZaMwQ2mBcMUYncqmFHnEOMtlsRJ0/19QT6uI7AK48qkn4mtqnQrZ
 4lp+twlWJ8wZ2AGQ8N0orvCdrBgS0EQhiFdsEFLqskLNPTX6Q4RvVB+D87no7BTQmwv2
 q5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733847515; x=1734452315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvYUTxGU0SlbdB/A8XWhhOlkaNp7pR5YZMOeGOSqwZc=;
 b=DOry+WJpFHXvglnoC1VgRreV8gRRJw8JtKwEG4DHtKVfMS6mQj2GSQvWlE5q6xX8rz
 eQ8dlHLLRJ8wsYa21Et3mLiwlv6RvNGQRzWHwwhNaTwuVHxT9hMbH0wHqppr393o7KqO
 LT+lUVl1pieHedQ9ITa+OEKskOQjB22hQINB/Px0ob9vLSgndaEGolboaYF/343LEGup
 N8KfajSJGaYCI3NAqI8T+CQgGwj53eqwr19WS+6te1zQ7i+CscA0vRvs/QHxygm+bdVH
 NNTZX7zLcitPXOb4T6CJLbIqk/ZEDCv9MXUBC25DEWalsKGxa8w/YvCd3hYCdlpZQ8yZ
 GVJA==
X-Gm-Message-State: AOJu0YylH/Nxc4EkM0s2nResG0ETQdXu4/nXcOWjPdKOmJSsfgxkhaUl
 OitcC6QKoj6ACQPuW0AI+kztsBp0rL4NhOaVWEAAeOJpy+EHUPdEzi4LbfApvVN6QuBbrRr1PCi
 HsT+UwjKl
X-Gm-Gg: ASbGncuVSV4r4W41VQ7pxOxSX9HqOrqH8EHGcj0d+1rspog2VzumNKmBpDSK2Lsp8CB
 7f9HOs/3nrlVNzXk2TXtFkXoo5s4QVl1AxF4ObCf/B5bDN4T9Cn+EQDq2iDXlVhbLt7FR69sl7o
 4kQct3iKqzoJXuU4aSJfKvwFEbItBcUg28sNWd6ok38DbCuery8iaevYGvSIAtXNKZxd12ZlL8v
 yge66eZE4R5fi4FzvDGdhQxYd6RXRhhMlD2MgbK9v97AS2brno3qJDf08I=
X-Google-Smtp-Source: AGHT+IFEHS99LtFsf1kkfmVUKrTW92FO0YM6TiIH9Y8Xf6L+V8XFlRtqvXUTBDcV2uQX+lMd9fSOtg==
X-Received: by 2002:a05:6512:1382:b0:540:1a0c:9ba6 with SMTP id
 2adb3069b0e04-5401a0c9d50mr3898112e87.34.1733847514762; 
 Tue, 10 Dec 2024 08:18:34 -0800 (PST)
Received: from stoup.. ([91.209.212.80]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53f93377eefsm1026343e87.67.2024.12.10.08.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 08:18:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 13/69] target/arm: Convert disas_add_sub_reg to decodetree
Date: Tue, 10 Dec 2024 10:16:37 -0600
Message-ID: <20241210161733.1830573-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241210161733.1830573-1-richard.henderson@linaro.org>
References: <20241210161733.1830573-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x129.google.com
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

This includes ADD, SUB, ADDS, SUBS (shifted register).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.c | 64 ++++++++++------------------------
 target/arm/tcg/a64.decode      |  9 +++++
 2 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8f777875fe..d570bbb696 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -7912,47 +7912,22 @@ TRANS(SUB_ext, do_addsub_ext, a, true, false)
 TRANS(ADDS_ext, do_addsub_ext, a, false, true)
 TRANS(SUBS_ext, do_addsub_ext, a, true, true)
 
-/*
- * Add/subtract (shifted register)
- *
- *  31 30 29 28       24 23 22 21 20   16 15     10 9    5 4    0
- * +--+--+--+-----------+-----+--+-------+---------+------+------+
- * |sf|op| S| 0 1 0 1 1 |shift| 0|  Rm   |  imm6   |  Rn  |  Rd  |
- * +--+--+--+-----------+-----+--+-------+---------+------+------+
- *
- *    sf: 0 -> 32bit, 1 -> 64bit
- *    op: 0 -> add  , 1 -> sub
- *     S: 1 -> set flags
- * shift: 00 -> LSL, 01 -> LSR, 10 -> ASR, 11 -> RESERVED
- *  imm6: Shift amount to apply to Rm before the add/sub
- */
-static void disas_add_sub_reg(DisasContext *s, uint32_t insn)
+static bool do_addsub_reg(DisasContext *s, arg_addsub_shift *a,
+                          bool sub_op, bool setflags)
 {
-    int rd = extract32(insn, 0, 5);
-    int rn = extract32(insn, 5, 5);
-    int imm6 = extract32(insn, 10, 6);
-    int rm = extract32(insn, 16, 5);
-    int shift_type = extract32(insn, 22, 2);
-    bool setflags = extract32(insn, 29, 1);
-    bool sub_op = extract32(insn, 30, 1);
-    bool sf = extract32(insn, 31, 1);
+    TCGv_i64 tcg_rd, tcg_rn, tcg_rm, tcg_result;
 
-    TCGv_i64 tcg_rd = cpu_reg(s, rd);
-    TCGv_i64 tcg_rn, tcg_rm;
-    TCGv_i64 tcg_result;
-
-    if ((shift_type == 3) || (!sf && (imm6 > 31))) {
-        unallocated_encoding(s);
-        return;
+    if (a->st == 3 || (!a->sf && (a->sa & 32))) {
+        return false;
     }
 
-    tcg_rn = read_cpu_reg(s, rn, sf);
-    tcg_rm = read_cpu_reg(s, rm, sf);
+    tcg_rd = cpu_reg(s, a->rd);
+    tcg_rn = read_cpu_reg(s, a->rn, a->sf);
+    tcg_rm = read_cpu_reg(s, a->rm, a->sf);
 
-    shift_reg_imm(tcg_rm, tcg_rm, sf, shift_type, imm6);
+    shift_reg_imm(tcg_rm, tcg_rm, a->sf, a->st, a->sa);
 
     tcg_result = tcg_temp_new_i64();
-
     if (!setflags) {
         if (sub_op) {
             tcg_gen_sub_i64(tcg_result, tcg_rn, tcg_rm);
@@ -7961,19 +7936,25 @@ static void disas_add_sub_reg(DisasContext *s, uint32_t insn)
         }
     } else {
         if (sub_op) {
-            gen_sub_CC(sf, tcg_result, tcg_rn, tcg_rm);
+            gen_sub_CC(a->sf, tcg_result, tcg_rn, tcg_rm);
         } else {
-            gen_add_CC(sf, tcg_result, tcg_rn, tcg_rm);
+            gen_add_CC(a->sf, tcg_result, tcg_rn, tcg_rm);
         }
     }
 
-    if (sf) {
+    if (a->sf) {
         tcg_gen_mov_i64(tcg_rd, tcg_result);
     } else {
         tcg_gen_ext32u_i64(tcg_rd, tcg_result);
     }
+    return true;
 }
 
+TRANS(ADD_r, do_addsub_reg, a, false, false)
+TRANS(SUB_r, do_addsub_reg, a, true, false)
+TRANS(ADDS_r, do_addsub_reg, a, false, true)
+TRANS(SUBS_r, do_addsub_reg, a, true, true)
+
 /* Data-processing (3 source)
  *
  *    31 30  29 28       24 23 21  20  16  15  14  10 9    5 4    0
@@ -8348,15 +8329,6 @@ static void disas_data_proc_reg(DisasContext *s, uint32_t insn)
     int op3 = extract32(insn, 10, 6);
 
     if (!op1) {
-        if (op2 & 8) {
-            if (op2 & 1) {
-                goto do_unallocated;
-            } else {
-                /* Add/sub (shifted register) */
-                disas_add_sub_reg(s, insn);
-            }
-            return;
-        }
         goto do_unallocated;
     }
 
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 0539694506..27a3101bc6 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -726,6 +726,15 @@ EOR_r           . 10 01010 .. . ..... ...... ..... .....    @logic_shift
 ANDS_r          . 11 01010 .. . ..... ...... ..... .....    @logic_shift
 
 # Add/subtract (shifted reg)
+
+&addsub_shift    rd rn rm sf sa st
+@addsub_shift    sf:1 .. ..... st:2 . rm:5 sa:6 rn:5 rd:5   &addsub_shift
+
+ADD_r           . 00 01011 .. 0 ..... ...... ..... .....    @addsub_shift
+SUB_r           . 10 01011 .. 0 ..... ...... ..... .....    @addsub_shift
+ADDS_r          . 01 01011 .. 0 ..... ...... ..... .....    @addsub_shift
+SUBS_r          . 11 01011 .. 0 ..... ...... ..... .....    @addsub_shift
+
 # Add/subtract (extended reg)
 
 &addsub_ext     rd rn rm sf sa st
-- 
2.43.0


