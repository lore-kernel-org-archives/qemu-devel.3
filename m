Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E6CE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9XI-00078u-CF; Fri, 13 Dec 2024 12:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9X2-0006xu-4B
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Wx-0001U7-Ky
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:32:50 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso1894175f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111166; x=1734715966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mGrNgxcstODmyTVtIUWdTSuI8DC92TSEcEt0qgRJw8A=;
 b=sOmscSEeBypVPl9ZudqKSnIuS5Gy2/4pFnsfGXIVk6XIT4balFlW2qOjmt5e56VA2s
 hKNOPnLxHbBevHPo2n2S6PQf2MDe5C9rJh/a8AKK6pwaTKpCItdfp5Qc98bmQk0mO/Gf
 ucnm2dQvsM3AzwtT/5gwmfKR3J9epi1YUHEpc6Xcg+Inbk8tSYkl2CIplDRXKsfWL4Jt
 UKlnjd2FnqHC+tBek5iMWxDb7iNW2GH37jCZpbQO0XCV16Vmv69tZwyp2hVsUrvmNQSj
 UUTCzyRZuPlgCTICHNovTgZdccnybQ4+6L8JH2rgf3o8TeTHnrmnhTrsBINeU/AjXidX
 9bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111166; x=1734715966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mGrNgxcstODmyTVtIUWdTSuI8DC92TSEcEt0qgRJw8A=;
 b=EMld+W1ND5mpHQ3N2gyWKeEzDCgSE57mr80D2EgUkZ8+ZBr1O2nE8UadEHaDRrXrAA
 KzXxx1cTOZKKJi9parUKpAVdp5/2CVGZrNNhj6BgIG3zT+tg9hZXYeVB/XnlPb3no5ZK
 HHKztkNMvnsfkrryho8l0QlzjATxu4xE+3XYVwTKk/TdTZxASPQ514eX30LloB5fWKVy
 Fqud6O0ePXgci3nCIIUD3kHaLSSOQpaK80fUuDQmkME+RrUXEWz+kJK59Ap4ymWP43Es
 vBBz14Tl5KXx7SIQA5LwxJDyFrCePRwZEhjv7Jx7w8OvYHI1nBHa7SvV2rcOBuTI+ABa
 Uf1g==
X-Gm-Message-State: AOJu0Yzua27b6j6vienRA5WxeUtkMDgtiX+ADLnwl2FxsjdPaL2nIWno
 PWTp5N/3moaCbdzjZetdEzcBTHZ3SBZIBm+hGvwAPxPGLSfhtVODAt8H/nij1vx+VsRC2pP+DYT
 G
X-Gm-Gg: ASbGncu932OeDsweAEtwbQ6fd6Fr6o833wkiXzqFSHLmcxXBndUGJ5dbBIUEyKkIUaU
 Y8echP8cKJmG3SMz4HD1edEX8RSkBpBf2cs/hCjqI9oj3IXRASgEAs9fg+gUxGetMrOqSxrgVkf
 Po3ZOKGCl8tvpdm6D6mnw49mQU/Y1k2MFzHtulhzejMKSlQIqlnD1ywHXLvTDHAFCzte9xyD4aw
 I6dkV+IMG1GbKecwvbqwKALUe5hCxaRtVWbVU2FdD4qXSXABUoONDFdeUfs6w==
X-Google-Smtp-Source: AGHT+IH1GXZKubxbWpqgtp1qpIh6vtXmgi2cChqf2j1nbPDvNNtZoPzrn8pheBMK0I0GKkCh2DfM9A==
X-Received: by 2002:a05:6000:1f83:b0:386:3213:5ba1 with SMTP id
 ffacd0b85a97d-38880ad9288mr3274898f8f.24.1734111165661; 
 Fri, 13 Dec 2024 09:32:45 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.32.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:32:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/85] target/arm: Convert disas_add_sub_reg to decodetree
Date: Fri, 13 Dec 2024 17:31:17 +0000
Message-Id: <20241213173229.3308926-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This includes ADD, SUB, ADDS, SUBS (shifted register).

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      |  9 +++++
 target/arm/tcg/translate-a64.c | 64 ++++++++++------------------------
 2 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 05396945062..27a3101bc69 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 8f777875fe0..d570bbb6969 100644
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
 
-- 
2.34.1


