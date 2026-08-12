Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BC8C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:36:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXu-0001MS-KW; Wed, 12 Aug 2026 18:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXs-0001Gf-8H
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXl-0001s1-2B
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:35 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2cf27856f9cso15336935ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574128; x=1787178928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQULInA+M5WqXEN53pzaAESWjpBuJD19rKsMNS6v2d0=;
 b=ooASxZS1CAZ2IijxU6YBhLmnH5KZYw+ArSqedanhjSOZkINS38nGXLMT05Xf50xW8z
 lXs/rHRlvYtEW491tTxIARTJBHgflDx5ZtJTgOL+6mbl7M6bUDoNCmTA2Upgx6k9JIsh
 LSzYMizQFR7jY/s724sBJM/Gb8poUnRocBOhxHtcaaM24e6+x8yLFdQgitogOtHxd6b8
 MkXQnYA8lpJ4Q4FFjJZpbDRkOaiSge12QOHHk6AxBfuPUN1R3bPlokdDQ1GbJNFtq+wI
 gZY3puoHt3P6xQ45xWdBB7FCfhnOrVqqZqarQLMR8hnewqpYsZycbtaRtxxytB1FmsfF
 aPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574128; x=1787178928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SQULInA+M5WqXEN53pzaAESWjpBuJD19rKsMNS6v2d0=;
 b=NQvWO4OEjlSKZBeh/b9V0z1s2MCRd9yFkvYu2k3WuYX6M7ndz62qWgCM932GE0xnL/
 4bUTOx1Mm66lrClYmEylICEeeQHm+GF8qIfvL+QUvdvp/QLtrH0345f5GLiW9yjRXxzQ
 4QZo16Iy7ALUW5r+p06r9USMixWei6chP4m2tQwetK0e2gzvex9CGZO6szURhrfwKuLB
 EnbIxrVKeJFzToLLfWW7ND2lAaAnX54ZjthjjQ+G/HROAtR6tV+1811IeJc9MNcgWIfw
 2HlguFhQlYUEkUWoAXh841ELWbp+QGrGfwgLkHkr8NGb5nMRlS3TS5MIhZu34UFp97ig
 zuMQ==
X-Gm-Message-State: AOJu0YwaZqMfAdbdIl0UnqUPU0NHjuRvBNLc+wNQT1hJTTlkbrFJsGuB
 gA1js9A0k7w9VpYf9ralJuPwWWQs2VoX6F38LOHnfzZtOGxp7wyc0zQj8blObgtKb7Bcc3M4wO1
 qmDJX
X-Gm-Gg: AR+sD10oFAFAOGc53pwB/X8xSTHrKBWRQck2AfXaZydC5Fg+jAwrc+r7xOXHhqmwJ94
 DZlJ5Eq8OKrhi/Feeu2055jZGKfO+p8UbiJMOYpd8vYCxkoQbZCqMZAcUAgst/O/LW3Mt+0febq
 +OoCybvOHlB3nIegILsKU54tAg72MB0Cc/QzI8obPGKhJnEJLWbdqyQUF2d59qxMHGC4G7VsNPB
 XIels8e/+bF8rIq76JfSydxAWuLLm/5VeCLMwsnDpcc1ll0L1gpNOkaqaEfQ4kwqXXkNOWjEDZ6
 cBkpO2ncghaWa734+xoXkr+mYsKXlx+jIgSBidvpPSzeCAcWgfV5P/PEqr7Be0zDpKpnkjF0Tpb
 oQKeWNuYD3ZXq5zEBH0ySzN9wDMbLJ88BXDIQAuJaJQaMPzwN5FaXSQa+UTwbUVdlRVbTdmrPNE
 YHua7iM/EtxG6xbQloFP75SoFlRkemJ3Z3Ffzh/0jZ7qyMfwS2MWqFVElj0H35HowSoOaVcFxVL
 LwxyixGrTCD7wpCat0S
X-Received: by 2002:a17:90b:270e:b0:393:194d:5366 with SMTP id
 98e67ed59e1d1-3931e0f6145mr1738476a91.10.1786574127552; 
 Wed, 12 Aug 2026 15:35:27 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 48/52] disas/riscv: Merge all c.mop.n to one pattern
Date: Wed, 12 Aug 2026 15:31:38 -0700
Message-ID: <20260812223142.349142-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Avoid performing arithmetic on rv_op_c_mop_1.
Treat the 'n' as an immediate.
Create a codec and format to match.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h        |  2 ++
 disas/riscv.c        | 10 +++++++++-
 disas/riscv-op.c.inc |  9 +--------
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 47647f750f..b0269bb709 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -159,6 +159,7 @@ typedef enum {
     rv_codec_r2_imm2_imm5,
     rv_codec_fli,
     rv_codec_lp,
+    rv_codec_cmop,
     rv_codec_cmop_ss,
     rv_codec_mop_r,
     rv_codec_mop_rr,
@@ -286,6 +287,7 @@ typedef struct {
 #define rv_fmt_rd_rs1_immh_imml_addr  "O\t0,(1),i,j"
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
+#define rv_fmt_cmop                   "O.i"
 #define rv_fmt_mop_r                  "O.i\t0,1"
 #define rv_fmt_mop_rr                 "O.i\t0,1,2"
 
diff --git a/disas/riscv.c b/disas/riscv.c
index 22104638e1..39235e5bc7 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -643,6 +643,11 @@ static uint32_t operand_lpl(rv_inst inst)
     return extract32(inst, 12, 20);
 }
 
+static uint32_t operand_cmop_imm(rv_inst inst)
+{
+    return extract32(inst, 8, 3) * 2 + 1;
+}
+
 static uint32_t operand_mop_r_imm(rv_inst inst)
 {
     return (extract32(inst, 30, 1) << 4) |
@@ -1027,7 +1032,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     (((inst >> 11) & 0b11) == 0b0)) {
                     unsigned int cmop_code = 0;
                     cmop_code = ((inst >> 8) & 0b111);
-                    op = rv_op_c_mop_1 + cmop_code;
+                    op = rv_op_c_mop;
                     if (dec->cfg->ext_zicfiss) {
                         op = (cmop_code == 0) ? rv_op_c_sspush : op;
                         op = (cmop_code == 2) ? rv_op_c_sspopchk : op;
@@ -3056,6 +3061,9 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
     case rv_codec_lp:
         dec->imm = operand_lpl(inst);
         break;
+    case rv_codec_cmop:
+        dec->imm = operand_cmop_imm(inst);
+        break;
     case rv_codec_cmop_ss:
         dec->rd = rv_ireg_zero;
         dec->rs1 = dec->rs2 = operand_crs1(inst);
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 2100e54475..802a521bca 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -875,14 +875,7 @@ OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(mop_r, "mop.r", rv_codec_mop_r, rv_fmt_mop_r)
 OP(mop_rr, "mop.rr", rv_codec_mop_rr, rv_fmt_mop_rr)
-OP(c_mop_1, "c.mop.1", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_3, "c.mop.3", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_5, "c.mop.5", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_7, "c.mop.7", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_9, "c.mop.9", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_11, "c.mop.11", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_13, "c.mop.13", rv_codec_ci_none, rv_fmt_none)
-OP(c_mop_15, "c.mop.15", rv_codec_ci_none, rv_fmt_none)
+OP(c_mop, "c.mop", rv_codec_cmop, rv_fmt_cmop)
 OP(amoswap_b, "amoswap.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amoadd_b, "amoadd.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amoxor_b, "amoxor.b", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
-- 
2.43.0


