Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FBCC5AD4E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtC81-00011P-H9; Sun, 09 Aug 2026 18:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7z-0000yW-JQ
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:23 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtC7x-0007RC-TB
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:36:23 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c99eaa1f020so1292156a12.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786314980; x=1786919780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfQHJoEEIiTQiyEPxCHv2+ERgDSbxAoN8nfDjMt2Yi8=;
 b=ew5NDDbY8Ud9ZXekiR/OFRVgwJF57hesXuF7voPMyGHGG/aa2II7NNys5aR8yA+3SW
 0kebX/erQJDQan4qzuPAwR+3hd934l246umeiUyoyAjzbB/hQwi0h7m1gulp0kp9pko7
 jK5zSUYUZbPAzWoFCoDI/2CJGPwyuTeLIQhJLLQbL3FlPeOY1Ilz1JEOit82Z3zI/ATa
 OLfJmZEPv6sWB1nKKp1HQ4VoEIU+HPBRSq4oGhbcckVIRUxS4F45ErcbC1tPuOy+Pbea
 BC3ZnKp/Uy+rB//iSr6T2tnsEsr9VC5YR8KeAKyLanVWpfs4YKVpLM1x+n/uNpx+UW4P
 DzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786314980; x=1786919780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OfQHJoEEIiTQiyEPxCHv2+ERgDSbxAoN8nfDjMt2Yi8=;
 b=birJWnH6BMDbL/Tp/TOLpG2oNL1MU0HDAO59ZNRCqrRNYRtHOyxviUF0GU7PUMS6CT
 E78adj+4T3LILAXQp8MQLikgwi4UFbml2z8NNpx7y0jC3mkWlNqvSw/1BwFoUozw6wma
 Hd/aKYwy44VaUjCmrWCPf+7Pvk39hTxz5KJ7KJyRroLYnSO3L72L8jOdoHVLvpdY7cRa
 hQgISdPTL920rs4NX4oQBN3kzq0k+xCaZwYFvoySYnv4x2lt6VlgA+WejLsKPfiqS7AS
 QPpqLaHkmWxqemJoZ83RB8BMPSuJeLqpWx8J+5rH3bND3tUHE+hDdSeeFbDKWV6rzNor
 DZ8Q==
X-Gm-Message-State: AOJu0YxlsMo8O2KBKhwhJ7YnZfQC8e1fKnJVYwE+NOpyC8/2Bdq1efc2
 nJpwT/b9eW+kl6Q/FXS2LcRhyRSZSnS8YzBb+Q1M8WjQwu7hyZHeVQ14yMKNg7cSLUbzZRzr3Q7
 /Km6z
X-Gm-Gg: AR+sD125KoeXHSWFUU/7RChCf1mvhRY3t4MayIsDctUmO7saEOe7anbUi5kvJmqZ0I4
 4zEESBsakZWWABHFtmBC14IZ07P2dmTmOT38+wVNzmjCyygRLkv5HMqYbbAJ2Cj6HZLIDveUNVK
 TzdXcZh4RU5blzUDEHY0F52gjgrNN52wa8q2gQkueUIIRm1aWx/tNKG7E/xHueQBfl1V61STB1f
 PANZWvEiU4OZPs/feO7bkElK49uAjL55FGVK9pKplI9ANplo3McSQ6bw4brSyPgBRfEXADw2ZN6
 TOhQraqx4ySCS7cSblemvlLBUIP8WJzpI7AyqnSGCOQbe2Uy2eHUURx4gGr7LXyinat+93fG/ZL
 cgFCZbfiqd5zoH6A52pCEOx+x32n0fI0+noXf4CyXoQCwDLSW8B5d+NzpaHv+J6HSpVWkpQR99F
 d6UpihS0g4pCiW7zMNoR8nRu9ZSpypdL/Gx+6iqrcx1JWJ7g1gtfta8O9FNDOXTqJldl7Cu7MgN
 DUJ4sheUx/IpK6U+b3v
X-Received: by 2002:a05:6a20:cf82:b0:3c3:8440:f6da with SMTP id
 adf61e73a8af0-3cbc043c129mr23411528637.29.1786314980557; 
 Sun, 09 Aug 2026 15:36:20 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbe8f19ace6sm2998102a12.2.2026.08.09.15.36.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:36:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 26/56] disas/riscv: Drop always true branch psudeos
Date: Sun,  9 Aug 2026 15:35:15 -0700
Message-ID: <20260809223545.730664-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

The real insns are blt, bge, bltu, bgeu.  Do not include
psuedos that unconditionally swap operands.  That's fine
for an assembler but not a disassembler.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


