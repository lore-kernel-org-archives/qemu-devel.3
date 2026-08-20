Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D601DC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtkr-0005Dp-OH; Wed, 19 Aug 2026 23:47:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkb-0004A6-Jh
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:33 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkZ-0004Bh-Th
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:33 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2d032846c95so22147605ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197650; x=1787802450; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7JzAABpt44ci1D0IHFkbgQn/cNbaYvxZwjC8pfV0xrY=;
 b=WSnVVDMqNR2QGVwMeeIf5k0gHG90cP0d3pRRJPw6SFowbac30OYAqoPVSnWCbIzOMX
 j5jELgBhEnZXdJ8grSJfMaPXrbyqb4dVqKvlxAWtjty9HF1zYrFmVJl5NfsiEJGLcPwb
 GlJXOf22dahneEQ1GjeCyoklPbJRfKyrI2Hbvi+oTEW0N0tkU8/WCmmXAj1tDbNuXXjX
 mbFACATPUyupfAbbOH1S1J0Q9qKHLVQt1mn3/vZu/leOwaVu1JBcHH7tmapL/SwQt8cT
 WqL0aZE/L4ScXvZXuBhEbNNtxH05z9GWq6ShfO4LOVtyVCjYuQiSIkiQXaacZSoIlhpY
 iTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197650; x=1787802450;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JzAABpt44ci1D0IHFkbgQn/cNbaYvxZwjC8pfV0xrY=;
 b=fbjN0dFTlWvqfZqL8CB3GoQBYbQ3WVvc0aheNoA32wimvj++vN3W9GiUgrekGB3tA1
 yuxX/aq+ZlgcKy4EtoCZdXhSiMvdeV10uCaJh6mMHI6Ma0h2dF77yz/fqbVmzGQ1k6br
 9OdAJ4En8GceZiLoDPZDxqskAfwazrQi++O6CRCphnUl2hLIEddlYGKWRGsFsohz3PZI
 M0sF3FPUuHL3TqsTFNI/iiTSLyDBNfzHFhBAfsYPovs6aquNk2R7goHhagQHjUb0uXtW
 SOnwuW6R9/2iJ7cIcSdkCXngpguHaTY/rHPm50E9ZdgBiJ3b7XJJ0Kwh1GtOMDZx368A
 GCSg==
X-Gm-Message-State: AFuF++llk6dcQ8GE50X2C9iipRxDmjBdT9TX95UeNxpqXTG+ph76Puam
 Mm0VdbQsB6/0OQdeXg60goAsap0SDvfTV8rPaS3fPjawMOJmd4eJqLXbevOqGg==
X-Gm-Gg: AR+sD112wIbkC8fctJd5SPdLbyvCIOuKakKiUqTAxBN2dqGIZrC9p/l2PGTl13leCJI
 Bao7l7hKSP2umKtX4xnQAzTFD/kCKdfiipVZb+/1T44fwo6yEwecUt2QykL/hTtKSlnFVH/SKIR
 n4kD0fOUjnn468RL/+qOUVpNa6ae4NBUGsUTGf5Ai5NdxCKzKI7Anee4+12kJLf09ZXc+ukpaF5
 1DwGdoyXwTzPsyvXHRF3jbxFods3o9bnj6PlRUaJmnzji16KqlgUr91U8s7kC/D7dJGNacXbLJs
 411eGhKY/ceOvCyy/2PdiHN7sh2XTDKyEeCJLzIVGYrPXGFWz5qbwPtb3SJSd2Vmc/DJJFqpAMn
 ukHyVPPcCTY55HgKE/lrMWRFn2Qi+k5ofmIrwMZSxzRhEAE+5TkHn9boe6UwLoSU0wG2yvgpSIh
 qrxuo/KPmghc6m4jTqv7e5Cd/cDDcqxVgpH6jmjpWbm+/IUDLle9CeADHjaW5oHGk9GDatyYbBR
 th5hA==
X-Received: by 2002:a17:90b:4e8f:b0:392:ca3b:370a with SMTP id
 98e67ed59e1d1-39580a50d67mr19152386a91.2.1787197650223; 
 Wed, 19 Aug 2026 20:47:30 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:29 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 57/93] disas/riscv: Drop always true branch pseudos
Date: Thu, 20 Aug 2026 13:43:54 +1000
Message-ID: <20260820034430.1186695-58-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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


