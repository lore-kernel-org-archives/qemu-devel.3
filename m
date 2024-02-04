Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878F3C4828F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFd-0003Ow-16; Sun, 04 Feb 2024 16:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFS-0002t5-Nn
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:42:00 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFQ-0003b3-Ka
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:58 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d9b2400910so1721775ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082915; x=1707687715; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7DMJgHEIfczGa+x10sgEDsRXfwUGwOd6p01k71b3vA=;
 b=HlO9ieAYYe4uZC/h/HF3D/TWoMKTK1/YXtGVoBBEA1p+8roAmbjhGWETFPOUMeQreq
 ZZ1BOemCAP55GZ8E+uhleKjfbRAfnUG2JZMyuwqJc8ZvP8LQM1d15AG6vM/3BqWkbiWT
 b0naTO3CfUE6P5hMlcBtTqwkn3uwnl71Vl2/60aHEUJ8+Hq3vBJdZmJQHP2E0qnnjuwI
 ijJx3t+5P9spkpXDEpyAm8OOIa4mEq70Uk3INY3cvHaX7jbhWjYzlxPvas3SEbiqm85R
 XM+4k+p9QzrFeLbI/qgdL9TFeCEnmUCe9FGB3atIxhI2cmKylTn63KwbaH+77rfRrS90
 WgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082915; x=1707687715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w7DMJgHEIfczGa+x10sgEDsRXfwUGwOd6p01k71b3vA=;
 b=f49TXlGuB8x40f7DtfnxAq14aqB/xO5hOguBjHam4NBFiaMqk1f0xAfW/wsenlr51T
 q+jXmqJcLPiRApgcVwFfckV9AlvWwOdYuvWTnGn81wzVyUGnrN/de93EdpIRf8XfxPDp
 LdiGadMLZ6JHsjm+q3jr4AIIHbVDY6mXhT7NON0Pe4gWXzI5SyBwqsr3nJ4bqfAV3FcL
 u5jGtU+W5pgXXH5y2SJBwTzpCfioXG2piTCfQxsPigkIlcofQSV3S5FM3I2hxK6KtHNV
 44zDyeSakM/5+HOTcXHjU/enWztnflV+qlvMQ+RYvdKBfvDKCS0ROoRU0QtsiT81ClIP
 v+Zw==
X-Gm-Message-State: AOJu0YyMSP2vSW5WlM5JxNNmhRh+IkkgWqMVj5+YZ5Rt4sRN7Fi+BkOS
 eLM4yWqWmSsjcs/uCn1Oex+USUwG5HlmbCTP7e4qbi6uJ+RyD2mOFxXPioY/ZnZGXL5xiIG3F/c
 bZeg=
X-Google-Smtp-Source: AGHT+IHvr13lbzos7CeV9v+NVbxs5FVXKcfkBppDgloL0zZZpuScfeM2mE1lYbfCd4Wn2gJhJekySA==
X-Received: by 2002:a17:902:e882:b0:1d9:30e3:ea84 with SMTP id
 w2-20020a170902e88200b001d930e3ea84mr5965524plg.2.1707082915311; 
 Sun, 04 Feb 2024 13:41:55 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 28/39] tcg/sparc64: Hoist read of tcg_cond_to_rcond
Date: Mon,  5 Feb 2024 07:40:41 +1000
Message-Id: <20240204214052.5639-29-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use a non-zero value here (an illegal encoding) as a better
condition than is_unsigned_cond for when MOVR/BPR is usable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/sparc64/tcg-target.c.inc | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index ac86b92b75..e16b25e309 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -620,7 +620,7 @@ static const uint8_t tcg_cond_to_bcond[] = {
     [TCG_COND_GTU] = COND_GU,
 };
 
-static const uint8_t tcg_cond_to_rcond[] = {
+static const uint8_t tcg_cond_to_rcond[16] = {
     [TCG_COND_EQ] = RCOND_Z,
     [TCG_COND_NE] = RCOND_NZ,
     [TCG_COND_LT] = RCOND_LZ,
@@ -679,7 +679,8 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
                                int32_t arg2, int const_arg2, TCGLabel *l)
 {
     /* For 64-bit signed comparisons vs zero, we can avoid the compare.  */
-    if (arg2 == 0 && !is_unsigned_cond(cond)) {
+    int rcond = tcg_cond_to_rcond[cond];
+    if (arg2 == 0 && rcond) {
         int off16 = 0;
 
         if (l->has_value) {
@@ -688,7 +689,7 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
             tcg_out_reloc(s, s->code_ptr, R_SPARC_WDISP16, l, 0);
         }
         tcg_out32(s, INSN_OP(0) | INSN_OP2(3) | BPR_PT | INSN_RS1(arg1)
-                  | INSN_COND(tcg_cond_to_rcond[cond]) | off16);
+                  | INSN_COND(rcond) | off16);
     } else {
         tcg_out_cmp(s, arg1, arg2, const_arg2);
         tcg_out_bpcc(s, tcg_cond_to_bcond[cond], BPCC_XCC | BPCC_PT, l);
@@ -696,11 +697,10 @@ static void tcg_out_brcond_i64(TCGContext *s, TCGCond cond, TCGReg arg1,
     tcg_out_nop(s);
 }
 
-static void tcg_out_movr(TCGContext *s, TCGCond cond, TCGReg ret, TCGReg c1,
+static void tcg_out_movr(TCGContext *s, int rcond, TCGReg ret, TCGReg c1,
                          int32_t v1, int v1const)
 {
-    tcg_out32(s, ARITH_MOVR | INSN_RD(ret) | INSN_RS1(c1)
-              | (tcg_cond_to_rcond[cond] << 10)
+    tcg_out32(s, ARITH_MOVR | INSN_RD(ret) | INSN_RS1(c1) | (rcond << 10)
               | (v1const ? INSN_IMM10(v1) : INSN_RS2(v1)));
 }
 
@@ -711,9 +711,9 @@ static void tcg_out_movcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
     /* For 64-bit signed comparisons vs zero, we can avoid the compare.
        Note that the immediate range is one bit smaller, so we must check
        for that as well.  */
-    if (c2 == 0 && !is_unsigned_cond(cond)
-        && (!v1const || check_fit_i32(v1, 10))) {
-        tcg_out_movr(s, cond, ret, c1, v1, v1const);
+    int rcond = tcg_cond_to_rcond[cond];
+    if (c2 == 0 && rcond && (!v1const || check_fit_i32(v1, 10))) {
+        tcg_out_movr(s, rcond, ret, c1, v1, v1const);
     } else {
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movcc(s, cond, MOVCC_XCC, ret, v1, v1const);
@@ -788,6 +788,8 @@ static void tcg_out_setcond_i32(TCGContext *s, TCGCond cond, TCGReg ret,
 static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
                                 TCGReg c1, int32_t c2, int c2const, bool neg)
 {
+    int rcond;
+
     if (use_vis3_instructions && !neg) {
         switch (cond) {
         case TCG_COND_NE:
@@ -807,9 +809,10 @@ static void tcg_out_setcond_i64(TCGContext *s, TCGCond cond, TCGReg ret,
 
     /* For 64-bit signed comparisons vs zero, we can avoid the compare
        if the input does not overlap the output.  */
-    if (c2 == 0 && !is_unsigned_cond(cond) && c1 != ret) {
+    rcond = tcg_cond_to_rcond[cond];
+    if (c2 == 0 && rcond && c1 != ret) {
         tcg_out_movi_s13(s, ret, 0);
-        tcg_out_movr(s, cond, ret, c1, neg ? -1 : 1, 1);
+        tcg_out_movr(s, rcond, ret, c1, neg ? -1 : 1, 1);
     } else {
         tcg_out_cmp(s, c1, c2, c2const);
         tcg_out_movi_s13(s, ret, 0);
-- 
2.34.1


