Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59631E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPd5-0004x8-3u; Wed, 11 Dec 2024 11:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPce-0004Mu-L2
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:36 -0500
Received: from mail-qt1-x82f.google.com ([2607:f8b0:4864:20::82f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLPcc-0001GX-Tc
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:31:36 -0500
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4678cd314b6so6582441cf.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934693; x=1734539493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NvYUTxGU0SlbdB/A8XWhhOlkaNp7pR5YZMOeGOSqwZc=;
 b=ziw+EZGKicgIINjyeuaVFGr+60UYx811d9i8burA46jbCXbwz/9HpJcGEybY1YnRWG
 J4DP5MZbXRltRJML/1fM+9rwWVX9wf5+scIYpktRImUrITyTl1eEfdoUHGMx8xLICfxR
 7KOOlfpDm0W9SU3EyR97ThzYLnpXHuWzgHDbvQHCqUKLsqL/mMH0q6W8UhUcYRMoqB7z
 BnOfsbEbxdV/d94/sISA62dxmgfSE1et1Ab7ai7MFxW5n/n2GMiWB9DG1imsHcM4uvh3
 CrTO/2kvWerbA8jbwDVJQm5T3yFgzY+FHY0nQQeHVRXwXoe/mgB4OpVJMTFW06mSOkbn
 3ipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934693; x=1734539493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NvYUTxGU0SlbdB/A8XWhhOlkaNp7pR5YZMOeGOSqwZc=;
 b=RXCt7Hi40i2Ta+U0tMNIZPVGcUaVVRhpRMNg0EiWjcf/mdhsLnZesXYpli414MUQcf
 tKShuasRrut2fJjFDiCpyDodWGhFV+i9Wa9q+zWbEWOIp2z2IoNwWWDK6OL1n6KhKnEa
 MJGq5/GzI2BxxbLSyuujyj7cW2wSi1Cdwmh+Nwm2ml+No1BrwCDYKbbdzna+sUDuMBgX
 FheqvJ8NPkEjOmMkUhEE7fHe7w9LK81i23XpxeyJrXP5+JrwOIWHsYcTBKtjDiSmV6Qw
 F38LG5hUm1UkTGDI4jULk2TXb0ikEv/Js3GTRmX7Xwj6YsiG6X4KND+X0ZYtBgt2Z8it
 xKdQ==
X-Gm-Message-State: AOJu0YweZ/okSdbDxLkIxql3L64oqoQXyBP6CFDK6rMP4n2rk9VnDl9s
 J6qJlD/2x1xCKrV5Te/9RlkptnU8FrbylsrHJWF0Wj7OXpl17A95BCkHtr0HhvQkaoq+8IjC7JU
 EfgjeX0wY
X-Gm-Gg: ASbGncubfhu6+eNNLE/BUdgwiYD0SWPTCCg2dzZRLL2nTfKJi6n2sQvN2ENgyUyHtu6
 v/CNbzMmG3xWunmSIfHbOvMH+HXKK4dP4DVKU9zkLbtmNxekYlJc4eYNQRyPtgHhmQlaMkSwotA
 C1QMwvQJxgDTZ2oNh7XB05mH9f4gspsSEkGVgbp2eoOX8b7mGOvGx94C+jfVBPg9ZVL03hXknWJ
 vmVcwNOI2zRHkoHwVHKXSSbXbARfZPU47esz0FXJc+1PnUsbdDss22dvfkRmA==
X-Google-Smtp-Source: AGHT+IFvC+fvHqjMTTmrzqrZHV7NXuowh2P7Idq/hnVKKJZiFxMteKNxcFxzyRZg+3nhUsRNzJPg3w==
X-Received: by 2002:ac8:7f94:0:b0:466:a3d2:ae44 with SMTP id
 d75a77b69052e-467892e9f85mr64904811cf.2.1733934693641; 
 Wed, 11 Dec 2024 08:31:33 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46755db613csm43849381cf.70.2024.12.11.08.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:31:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 13/69] target/arm: Convert disas_add_sub_reg to decodetree
Date: Wed, 11 Dec 2024 10:29:40 -0600
Message-ID: <20241211163036.2297116-14-richard.henderson@linaro.org>
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


