Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BA7CF9C6D
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHg-0001iG-Bd; Sun, 22 Sep 2024 08:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHG-0000vD-Sg
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:31 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHC-0002Mp-IP
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:20 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cbface8d6so43740145e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006477; x=1727611277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4LfLCCfd77AE3gIUDkv8zMuzeAX8OHemsoCsp4r7PY=;
 b=RSn+J0wvmayXtIcVp/+A6jmihR0qEOjB3jhZa3pnMpCydvZW+n3PTOxHGixwLwwC6o
 3X2DpD0g4Z380ePz+lHdoBS7YgXfjr3RDGEmsmemI+kVXpyhxhk+L/fWY+S02Zs75vBx
 3cBBg4qCO8lhJHLutuuRd6mg/cLjExjaNqQLSl95wB/hVLEuwVNMAGE6T07zCv4TsbY9
 8U6tesy5L68YVCMWWA2sUQycsO36h7HEcnD5WxdhHB7/Rsjg470Tq1u6Na1xuehibmR1
 v2t7jKnjVlJd4PJrd8mPSvOMcqfzjpj4AhDAEjZC9ERJGL5eUqTpA/y1+2HJ3S7VBShK
 DzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006477; x=1727611277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E4LfLCCfd77AE3gIUDkv8zMuzeAX8OHemsoCsp4r7PY=;
 b=K7zNd09ktyoUP0TDeP64lRlWxyF5zWjKbeOEsix4lg4n2ozW5vuNh2GT35eKRjRAWC
 Wv/Ds6h4ZMLe+AUHoJWOOWR/XOPVAeFMVR3ihIxfLonaG1vMN5W0wPv1NChjlCbfrO2r
 0Y5XXn1pohIuZRyEMw7L5R0QuODwJYJYFVzLNzOGsUHtpaZmdE4KKq5oWXqGBPWg59h+
 IBShPQQtrfMdLBEHLeIg70U1w5VOJHrpHgGN6EZ7t7MwQriZfmatvRdcrh0Ime03XAij
 IYNeOKfUHhAZZ5R1AZH1VDKa3J19EFUV/1CDigkRptS8IyDhL8t0p69JQ2H3wYed6X8d
 FB0Q==
X-Gm-Message-State: AOJu0Yw2W8FpxHhUneQl09lHFjopIMYdwpNKs6h5j4ZCSPDgZvfZnUK1
 aAfVQE9i0aE6UPDd3Uh4w26z89cpJQsmVsieeqtQXSkRG18/9GQxxY2rQ/GPt42wAg+EDbaH5y7
 ormI=
X-Google-Smtp-Source: AGHT+IFGYW8cXvb9mXW9jh1HKztncYyO59Y4INdXdrOnPP0e0/R88hObKtFRVxhkMDAXjeFBwrMj3g==
X-Received: by 2002:a5d:4fc5:0:b0:374:c8eb:9b18 with SMTP id
 ffacd0b85a97d-37a422c63acmr6655461f8f.24.1727006476698; 
 Sun, 22 Sep 2024 05:01:16 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 05/31] tcg/i386: Split out tcg_out_vex_modrm_type
Date: Sun, 22 Sep 2024 14:00:46 +0200
Message-ID: <20240922120112.5067-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Helper function to handle setting of VEXL based
on the type of the operation.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target.c.inc | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 9a54ef7f8d..af71a397b1 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -711,6 +711,15 @@ static void tcg_out_vex_modrm(TCGContext *s, int opc, int r, int v, int rm)
     tcg_out8(s, 0xc0 | (LOWREGMASK(r) << 3) | LOWREGMASK(rm));
 }
 
+static void tcg_out_vex_modrm_type(TCGContext *s, int opc,
+                                   int r, int v, int rm, TCGType type)
+{
+    if (type == TCG_TYPE_V256) {
+        opc |= P_VEXL;
+    }
+    tcg_out_vex_modrm(s, opc, r, v, rm);
+}
+
 /* Output an opcode with a full "rm + (index<<shift) + offset" address mode.
    We handle either RM and INDEX missing with a negative value.  In 64-bit
    mode for absolute addresses, ~RM is the size of the immediate operand
@@ -904,8 +913,7 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg r, TCGReg a)
 {
     if (have_avx2) {
-        int vex_l = (type == TCG_TYPE_V256 ? P_VEXL : 0);
-        tcg_out_vex_modrm(s, avx2_dup_insn[vece] + vex_l, r, 0, a);
+        tcg_out_vex_modrm_type(s, avx2_dup_insn[vece], r, 0, a, type);
     } else {
         switch (vece) {
         case MO_8:
@@ -3231,10 +3239,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_simd;
     gen_simd:
         tcg_debug_assert(insn != OPC_UD2);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, insn, a0, a1, a2, type);
         break;
 
     case INDEX_op_cmp_vec:
@@ -3250,10 +3255,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     case INDEX_op_andc_vec:
         insn = OPC_PANDN;
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a2, a1);
+        tcg_out_vex_modrm_type(s, insn, a0, a2, a1, type);
         break;
 
     case INDEX_op_shli_vec:
@@ -3281,10 +3283,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
         goto gen_shift;
     gen_shift:
         tcg_debug_assert(vece != MO_8);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, sub, a0, a1);
+        tcg_out_vex_modrm_type(s, insn, sub, a0, a1, type);
         tcg_out8(s, a2);
         break;
 
@@ -3361,19 +3360,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 
     gen_simd_imm8:
         tcg_debug_assert(insn != OPC_UD2);
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, insn, a0, a1, a2, type);
         tcg_out8(s, sub);
         break;
 
     case INDEX_op_x86_vpblendvb_vec:
-        insn = OPC_VPBLENDVB;
-        if (type == TCG_TYPE_V256) {
-            insn |= P_VEXL;
-        }
-        tcg_out_vex_modrm(s, insn, a0, a1, a2);
+        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, a0, a1, a2, type);
         tcg_out8(s, args[3] << 4);
         break;
 
-- 
2.43.0


