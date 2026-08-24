Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34BCFC5DF8C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 06:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbN-000599-03; Mon, 24 Aug 2026 01:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaR-0004N6-KQ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:18 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaM-0002aA-9V
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:07 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso4594965a91.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550665; x=1788155465; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7JzAABpt44ci1D0IHFkbgQn/cNbaYvxZwjC8pfV0xrY=;
 b=p69+/jacK3sRcDguQQ3WVRZYY80u1Q/pOHpCkmfZQkY0K48kluF5eLyG+ooyO6HIs8
 KCqqOlWmAKiEgm5+3Uj8lMbasGl+ed0323b89hhqYyl/3qKTHb6eyw5oG2YE2RNrdYql
 AnGmh8rsYqlERrWHc4MNs/XHJ86AerP8yJKCmNLrfj/RNIP0X6tpQQGEh65FSI2mnl5Y
 cv6gb+/8faD4AMFNPkYNLPr0OFAvZZgYGIhHhevmKJeMo+MlFfYU2j8dUI/9s6EGuXAF
 5nA5TLvKvg+dECPChqr4O4s90VpAjBUmUbCOtf1267Uzbvd2MjfaS3RBs9OBje/5TR7a
 nkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550665; x=1788155465;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JzAABpt44ci1D0IHFkbgQn/cNbaYvxZwjC8pfV0xrY=;
 b=pLIyu6Q7LTdDdnVbUcAP/2rB4P1kTGObXjzIH9qkaf1Wwg3RCcqLrFzif4k9GSCGSo
 q1JcY8pOtqf/MoaBblUpf1R/3zTvAuwPj7BT5Bs27+l2uiVWG3U6xmNAoJgGPihodlKI
 jwtlWYT3OKwd2nSDRkMD5oFlY7C400jGJ1RL9vWwOJDRqdW7krcrG4U9UdtzAVWGpdGT
 Eo21CQqq+DbBXmAbVXdeLjHRWbAf+yxHJYUtaskj9wi//jyJpOqR7rnL2YcNpxVYRmzX
 dgbjQrURjh5KZromiKqzFERmZljkPFDfESkqU7rKbp2dsvuVHSTTJH8EMjEfeguxSwth
 id4Q==
X-Gm-Message-State: AFuF++nvYUMt3MHFhKMdsp6Bji83vfOBocz25U9De5QL9JbSNORsyqhD
 Bt+EMdSUC3IYImfEdNHh25TZ97lfXycFlzmfYQ5OMoGgft4S0b7ft886Ze/nvw==
X-Gm-Gg: AR+sD13KRFbDAqmPT/MKRlPaFtj1YjkUPdAG2PZosTeb2kvHfb5BUl6zR2mem8c5b1X
 77A8vVjf/yPGchRsQ5EIW1Fml688EcGCgBXPOYFtaUdaCs9EQb+qiXx8tE9e1+c1Tk23TU5VINx
 5kCD829e6NXwZCV92FR8y3ckKRP8HPzCWBAKeQYAAXCWFxNxcOJjuWAkTY1eOUqFqF8nREfdcXx
 McIRkFbTF2oySEaN2nqICkd0McmMzIM1lcF3rCVyKQqOKg1yDs+Uat2zE2vjlB+C+N/jsUddj9v
 ChTfxoh1Z3EdGOB42trGyuCXgNhBLzFrKcHInwWyiNU0zVacKSLnIDnCjnE71XMyYduzVg9i+ql
 eHiAMXzSjfg8N7ECpC5wsmoGPqwDsJeXoI64YNPehOCrAtI2c0l1+OSRC0v9ZIsP7UFCp3BPMJJ
 w8jgp4Aldfe6dZSDvn0pIL+EoWIL9mzzcstA9Chfeqqo2yWFXTATT2BI+/0B964Ea23xojkB6Rs
 gQshBTkVUb2dGAl
X-Received: by 2002:a17:90b:50c3:b0:395:5eec:b932 with SMTP id
 98e67ed59e1d1-395c39e6433mr46678797a91.11.1787550664956; 
 Sun, 23 Aug 2026 22:51:04 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 54/96] disas/riscv: Drop always true branch pseudos
Date: Mon, 24 Aug 2026 15:47:24 +1000
Message-ID: <20260824054806.2790041-55-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

The real insns are blt, bge, bltu, bgeu.  Do not include
pseudos that unconditionally swap operands.  That's fine
for an assembler but not a disassembler.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-22-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 2e891f509e..bde1cc6e62 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -326,10 +326,6 @@ typedef enum {
     rv_op_bgez = 295,
     rv_op_bltz = 296,
     rv_op_bgtz = 297,
-    rv_op_ble = 298,
-    rv_op_bleu = 299,
-    rv_op_bgt = 300,
-    rv_op_bgtu = 301,
     rv_op_j = 302,
     rv_op_ret = 303,
     rv_op_jr = 304,
@@ -1062,10 +1058,6 @@ static const rvc_constraint rvcc_blez[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgez[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bltz[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgtz[] = { rvc_rs1_eq_x0, rvc_end };
-static const rvc_constraint rvcc_ble[] = { rvc_end };
-static const rvc_constraint rvcc_bleu[] = { rvc_end };
-static const rvc_constraint rvcc_bgt[] = { rvc_end };
-static const rvc_constraint rvcc_bgtu[] = { rvc_end };
 static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
 static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
                                            rvc_end };
@@ -1123,24 +1115,12 @@ static const rv_comp_data rvcp_bne[] = {
 static const rv_comp_data rvcp_blt[] = {
     { rv_op_bltz, rvcc_bltz },
     { rv_op_bgtz, rvcc_bgtz },
-    { rv_op_bgt, rvcc_bgt },
     { rv_op_illegal, NULL }
 };
 
 static const rv_comp_data rvcp_bge[] = {
     { rv_op_blez, rvcc_blez },
     { rv_op_bgez, rvcc_bgez },
-    { rv_op_ble, rvcc_ble },
-    { rv_op_illegal, NULL }
-};
-
-static const rv_comp_data rvcp_bltu[] = {
-    { rv_op_bgtu, rvcc_bgtu },
-    { rv_op_illegal, NULL }
-};
-
-static const rv_comp_data rvcp_bgeu[] = {
-    { rv_op_bleu, rvcc_bleu },
     { rv_op_illegal, NULL }
 };
 
@@ -1665,8 +1645,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bne", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bne },
     { "blt", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_blt },
     { "bge", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bge },
-    { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bltu },
-    { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset, rvcp_bgeu },
+    { "bltu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
+    { "bgeu", rv_codec_sb, rv_fmt_rs1_rs2_offset },
     { "lb", rv_codec_i, rv_fmt_rd_offset_rs1 },
     { "lh", rv_codec_i, rv_fmt_rd_offset_rs1 },
     { "lw", rv_codec_i, rv_fmt_rd_offset_rs1 },
@@ -1954,10 +1934,10 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
     { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
     { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { "ble", rv_codec_sb, rv_fmt_rs2_rs1_offset },
-    { "bleu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
-    { "bgt", rv_codec_sb, rv_fmt_rs2_rs1_offset },
-    { "bgtu", rv_codec_sb, rv_fmt_rs2_rs1_offset },
+    { },
+    { },
+    { },
+    { },
     { "j", rv_codec_uj, rv_fmt_offset },
     { "ret", rv_codec_i, rv_fmt_none },
     { "jr", rv_codec_i, rv_fmt_rs1 },
-- 
2.54.0


