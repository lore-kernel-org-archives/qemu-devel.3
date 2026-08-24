Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D085C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbm-0006Rh-1T; Mon, 24 Aug 2026 01:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbb-0005ay-Kd
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:23 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNbZ-00037A-Gq
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:52:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ced3386430so31409725ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550740; x=1788155540; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LfQohlZt640C5GwVV70FzQC1fZ1dLJnvxGCO8xDnz0w=;
 b=DlShzqtfQ8BUq8fMkkadkTiTo7+SH4ebIp/21W1JMkJzN1YVWYAM2bzhf3vxjqp3r9
 ipjqafQrfSWAnVJbl30VJqHYBqEhtIkDmxGrDHI5lciomdIfLpiY/mTMftanKC5cn559
 ecoQNHD2tlpJILh5jfhDZAg9+Cx4VWhpxZP8D12mMxhi+1o9wEwDWkREJAB5Jgnw7Jnw
 hEcMligfM7BNjJjPvFqpA3uzs0iA6niLK6Gv24l5XCMgI1gD8w2LzLRhpFkeVZ178DDu
 upGOpQPu92l7nxdl06hBQlTrRkgxi2h5kuPjpVzWEh0RhV3i6jKZVewweekMK9uRnpaC
 tW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550740; x=1788155540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LfQohlZt640C5GwVV70FzQC1fZ1dLJnvxGCO8xDnz0w=;
 b=XXyS/RKWyAvW4yddU25UnSziTal8nMegHGNILCxHNQYnn5Wo1X46R2wAmaqJnvYxDO
 1G/lrnlr1vS839SqW6rJ8E7XBPNsQ3Yh3yagr+DjHu5IM99eDhrFxg4z4gIRXxnbT9fF
 0dWcuQ5Bcz6hHCPRL+NkKusahupxikaSZGdAOH4JoPPvOLGruN6TT0iG4BJoiISkaDc4
 8apy5tokfg/9KIf9/TwnBVPO4X90nqP7Kv3wtuK6JDlndWfxdV1wbQVj9Bnx78pL3cTb
 p+2s2AuwuGtMoJB8swznFBkGXH+qEhX1asZgyeaPq9AsOmO+EfyERewxRV1ce/Ka11gy
 i3tw==
X-Gm-Message-State: AFuF++lEVzMIgSmn+D/Xq86F04jtYxAZB5itrbaEiBW558CtV2V16se+
 3M/i8LHkaByUYFUnILvrRkZztgUEUI2F8PUpa1RSCG0KL5ZKXZnQWOeE5/D/rA==
X-Gm-Gg: AR+sD12/kI97zx+G+BwCHroSVeMAo8/TOYQ5fmr6DRmU1/k3xmvoElsx/hF555yJyF/
 9qvEtyMxdpHuxPN5yDkN0Y4NtQbbk1xSY+UPa0O4VjC6XHRsDqlNMJTrODYTznvXiPrGOj0i0RE
 wZ9rbcK5Xkf2z4m77LTa7SDVyQM4cl7uVijmfv1e2qj7dGV/u9UWFxtUv2MlAjD9sHZ0DFUshmK
 A+vj3FtrGVWPfZ6FnM5zrPHxLlwaOcFPo3jXbteltGCHVeW3Vk8ZDGLuX6xpBJQHpjALocR7U9Z
 52I1iW0Q9oKZwD3f5eEdIhsrwSj84hw3FRXtmIQoM/od/XmRS65/+rt8NHx7pk5S1jQGQ6DWp5r
 NSWgnWeXrwyBXBnCNfX8jwNrwtucGkKYhK13gh0XGVheIthP8sd9hyir4i1nE0w1Cnkqk+XnuyN
 Btzbz1k7j/zyJG5gUiCiiqVG3Yu3P2eZTx+TPXb8Iiet8pBmJPvffKSfKrI/RyKKz+cCsq1OYXg
 ra74A==
X-Received: by 2002:a17:90b:2d0e:b0:395:7fff:a08f with SMTP id
 98e67ed59e1d1-395c2f65bfbmr47401583a91.0.1787550740018; 
 Sun, 23 Aug 2026 22:52:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:52:19 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 80/96] disas/riscv: Merge all mop.rr.n to one pattern
Date: Mon, 24 Aug 2026 15:47:50 +1000
Message-ID: <20260824054806.2790041-81-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x633.google.com
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

Avoid performing arithmetic on rv_op_mop_rr_0.
Treat the 'n' as an immediate.
Create a codec and format to match.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-48-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.h        |  2 ++
 disas/riscv.c        | 13 ++++++++++++-
 disas/riscv-op.c.inc |  9 +--------
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index b47a7f0150..47647f750f 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -161,6 +161,7 @@ typedef enum {
     rv_codec_lp,
     rv_codec_cmop_ss,
     rv_codec_mop_r,
+    rv_codec_mop_rr,
 } rv_codec;
 
 /* structures */
@@ -286,5 +287,6 @@ typedef struct {
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
 #define rv_fmt_mop_r                  "O.i\t0,1"
+#define rv_fmt_mop_rr                 "O.i\t0,1,2"
 
 #endif /* DISAS_RISCV_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index 0751f1a841..22104638e1 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -650,6 +650,11 @@ static uint32_t operand_mop_r_imm(rv_inst inst)
            extract32(inst, 20, 2);
 }
 
+static uint32_t operand_mop_rr_imm(rv_inst inst)
+{
+    return (extract32(inst, 30, 1) << 2) | extract32(inst, 26, 2);
+}
+
 /* instruction metadata */
 
 static const rv_opcode_data rvi_opcode_data[] = {
@@ -2572,7 +2577,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                == 0b1000001) {
                         imm_mop3 = deposit32(extract32(inst, 26, 2),
                                              2, 1, extract32(inst, 30, 1));
-                        op = rv_op_mop_rr_0 + imm_mop3;
+                        op = rv_op_mop_rr;
                         /* if zicfiss enabled and mop3 is shadow stack */
                         if (dec->cfg->ext_zicfiss &&
                             ((imm_mop3 & 0b111) == 0b111)) {
@@ -3061,6 +3066,12 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
         dec->rs1 = operand_rs1(inst);
         dec->imm = operand_mop_r_imm(inst);
         break;
+    case rv_codec_mop_rr:
+        dec->rd = operand_rd(inst);
+        dec->rs1 = operand_rs1(inst);
+        dec->rs2 = operand_rs2(inst);
+        dec->imm = operand_mop_rr_imm(inst);
+        break;
     default:
         g_assert_not_reached();
     }
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 222d249a70..2100e54475 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -874,14 +874,7 @@ OP(amocas_w, "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(mop_r, "mop.r", rv_codec_mop_r, rv_fmt_mop_r)
-OP(mop_rr_0, "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_1, "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_2, "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_3, "mop.rr.3", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_4, "mop.rr.4", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_5, "mop.rr.5", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_6, "mop.rr.6", rv_codec_r, rv_fmt_rd_rs1_rs2)
-OP(mop_rr_7, "mop.rr.7", rv_codec_r, rv_fmt_rd_rs1_rs2)
+OP(mop_rr, "mop.rr", rv_codec_mop_rr, rv_fmt_mop_rr)
 OP(c_mop_1, "c.mop.1", rv_codec_ci_none, rv_fmt_none)
 OP(c_mop_3, "c.mop.3", rv_codec_ci_none, rv_fmt_none)
 OP(c_mop_5, "c.mop.5", rv_codec_ci_none, rv_fmt_none)
-- 
2.54.0


