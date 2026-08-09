Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4628AC5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBK-0005y1-Iy; Sun, 09 Aug 2026 18:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBI-0005wu-On
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:48 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBH-00085W-0H
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:48 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-384930ca5e2so1305324a91.3
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315185; x=1786919985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XZk94/hutZsJsFOXvZC1U6d3u/tHUT3CS8c9j5uIMOA=;
 b=oyUZw0wgbRvdwAed4jtCsGBIvoUTEV0Tn9IFkn6434Ao27E3O5v2Lhn0iWfpXiz4HP
 P7cQW4j+ZJSRX/w9kTdUnQm+nFoeNt4rBo6HnqwrJQ6cK8i4SxConZhE3SJxm14BfuR8
 GjEZ+ajLDGGcCwW9VrKaxClzARp+++Cb5s2KHkb9pkvtTCefDA/o5dJhgFsw4D7nQH3B
 jJJ7TvC9fboAwnpmlYUYcqj3tMBbmHVxjCtbb5+aPstrsyIN1Mxk9nJMuy1UJ7X8FbxB
 G/HGr8xBAit/e+raFI7HTtfeW3zRUISsXxi8+VCLADWEswLN2eX8EVf0hOlJAIXTtf2K
 ZEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315185; x=1786919985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XZk94/hutZsJsFOXvZC1U6d3u/tHUT3CS8c9j5uIMOA=;
 b=l6Rr2p7RRZdOoS2T4eqGPm203xcDcIBzotz1eXlNaqy3pM0EvDKN77TyrMZy9rAFQs
 xg1QlE9g1Nti5SCDQMcy0SXLBbfd9yep0dpE6KWpnOuwm2ihqliPmN7O6wK7J32Jt6ru
 qnosY/s14XypE62AfxbzPDPLUM1wXf6tGemLIejmKU1pjTvZ+JNIhnI/wNWCRBioAkvU
 eOO8bdyMlbsOSZCAFXzmNdK/JKxqZ2QmZMPWP8QLX+yLGpbiHbYd2GkKJS2LFE+ABN2n
 cZjTU/IzxqD3BExtLd3unWFmxwP5Z0kuenBB/AVn2ZHvm2fyfS5CqF4sfKFWosHPcQ15
 8iug==
X-Gm-Message-State: AOJu0Yzz2NFulkwS7gIQzHdsGMlDQdLX9Jugc/CdROWXLiIseSp2+DNq
 JOZG1lr6FyPPF581VaizwatcgDfunnOKb1rnSphR4VoMyMQlpkTHPz2BYhh6iGdCiavNcqc3bt5
 57O0g
X-Gm-Gg: AR+sD12HMzfjqKkGBpS/6m6qG4cFaE4LJY7vjofkT+RJLL7sLkmLvviTfp4GLsJg0XP
 ZNnFIFCvwJtmremRBBAxRgiOtKcHYhQEjl5mk2Mk4n4cqOnEDr85BRO5k1CCMQxn0wpFKgCyPnk
 LYX5kNBXCQ+SZEg4tfh/i4XC8ZAUBs56nIr8Ltt11c/T/RNFy+Mz8xvNHJ6kF5A7YZ33T698fVL
 gGHZe1xUMbVj1cgMnVbjKKikgHBtGj4g6U7Im2SEmQU7NSXxeajumH0otbQDUAhW5WB31rVZ+7y
 LuLooC1jdX7wwuOq8mbIU4ZKhnVD+l0JB+b8vejJCY8pswqNZc8FWaIe+M2PZA0bvDMx+DYsq8A
 5cfBbxS8zmPatKk1VFcAKYLrFOPccsrHy1ECQsTHuvidoUnCdoEBzWyDqoyfryjjtbcB/iQOc3x
 N7n+PmcUD3V2ZGaIrbdNLeWxV9+uCLDsSLLd5AEh0hTafS3+M7Qj7gksIwu2GchLVZmuelrfLTY
 M4MZASgb7JyMi3R6tre
X-Received: by 2002:a17:90b:4b81:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-3903c582798mr37987768a91.11.1786315185362; 
 Sun, 09 Aug 2026 15:39:45 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 50/56] disas/riscv: Merge all mop.r.n to one pattern
Date: Sun,  9 Aug 2026 15:35:39 -0700
Message-ID: <20260809223545.730664-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Avoid performing arithmetic on rv_op_mop_r_0.
Treat the 'n' as an immediate.
Create a codec and format to match.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h        |  2 ++
 disas/riscv.c        | 15 ++++++++++++++-
 disas/riscv-op.c.inc | 33 +--------------------------------
 3 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index 5ac8c41616..b47a7f0150 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -160,6 +160,7 @@ typedef enum {
     rv_codec_fli,
     rv_codec_lp,
     rv_codec_cmop_ss,
+    rv_codec_mop_r,
 } rv_codec;
 
 /* structures */
@@ -284,5 +285,6 @@ typedef struct {
 #define rv_fmt_rd_rs1_immh_imml_addr  "O\t0,(1),i,j"
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
+#define rv_fmt_mop_r                  "O.i\t0,1"
 
 #endif /* DISAS_RISCV_H */
diff --git a/disas/riscv.c b/disas/riscv.c
index 9dad56b486..450a5c8142 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -643,6 +643,13 @@ static uint32_t operand_lpl(rv_inst inst)
     return extract32(inst, 12, 20);
 }
 
+static uint32_t operand_mop_r_imm(rv_inst inst)
+{
+    return (extract32(inst, 30, 1) << 4) |
+           (extract32(inst, 26, 2) << 2) |
+           extract32(inst, 20, 2);
+}
+
 /* instruction metadata */
 
 static const rv_opcode_data rvi_opcode_data[] = {
@@ -2546,7 +2553,7 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                                                        2, 2,
                                                        extract32(inst, 26, 2)),
                                              4, 1, extract32(inst, 30, 1));
-                        op = rv_op_mop_r_0 + imm_mop5;
+                        op = rv_op_mop_r;
                         /* if zicfiss enabled and mop5 is shadow stack */
                         if (dec->cfg->ext_zicfiss &&
                             ((imm_mop5 & 0b11100) == 0b11100)) {
@@ -3049,6 +3056,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa,
         dec->rs1 = dec->rs2 = operand_crs1(inst);
         dec->imm = 0;
         break;
+    case rv_codec_mop_r:
+        dec->rd = operand_rd(inst);
+        dec->rs1 = operand_rs1(inst);
+        dec->imm = operand_mop_r_imm(inst);
+        break;
     default:
         g_assert_not_reached();
     }
@@ -3134,6 +3146,7 @@ static GString *format_inst(size_t tab, rv_decode *dec,
             g_string_append(buf, op->name);
             break;
         case '(':
+        case '.':
         case ',':
         case ')':
         case '-':
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 3fe934688e..222d249a70 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -873,38 +873,7 @@ OP(vwsll_vi, "vwsll.vi", rv_codec_v_i_u, rv_fmt_vd_vs2_uimm_vm)
 OP(amocas_w, "amocas.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_d, "amocas.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(amocas_q, "amocas.q", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
-OP(mop_r_0, "mop.r.0", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_1, "mop.r.1", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_2, "mop.r.2", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_3, "mop.r.3", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_4, "mop.r.4", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_5, "mop.r.5", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_6, "mop.r.6", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_7, "mop.r.7", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_8, "mop.r.8", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_9, "mop.r.9", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_10, "mop.r.10", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_11, "mop.r.11", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_12, "mop.r.12", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_13, "mop.r.13", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_14, "mop.r.14", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_15, "mop.r.15", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_16, "mop.r.16", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_17, "mop.r.17", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_18, "mop.r.18", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_19, "mop.r.19", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_20, "mop.r.20", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_21, "mop.r.21", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_22, "mop.r.22", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_23, "mop.r.23", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_24, "mop.r.24", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_25, "mop.r.25", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_26, "mop.r.26", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_27, "mop.r.27", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_28, "mop.r.28", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_29, "mop.r.29", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_30, "mop.r.30", rv_codec_r, rv_fmt_rd_rs1)
-OP(mop_r_31, "mop.r.31", rv_codec_r, rv_fmt_rd_rs1)
+OP(mop_r, "mop.r", rv_codec_mop_r, rv_fmt_mop_r)
 OP(mop_rr_0, "mop.rr.0", rv_codec_r, rv_fmt_rd_rs1_rs2)
 OP(mop_rr_1, "mop.rr.1", rv_codec_r, rv_fmt_rd_rs1_rs2)
 OP(mop_rr_2, "mop.rr.2", rv_codec_r, rv_fmt_rd_rs1_rs2)
-- 
2.43.0


