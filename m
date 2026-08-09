Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C096C5B560
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBN-00060a-Ep; Sun, 09 Aug 2026 18:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBL-0005yV-6n
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:51 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBJ-00086U-Di
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:50 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-3810c5d691bso1039920a91.1
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315188; x=1786919988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6qT6LtmVAN2lMvfWwnz6ndG9Sg0G69mfIJi66f9p1UE=;
 b=rM92JYb0RJykx5ru1qno8RA0tDIYwAQf/kjGku1hF+PpBI433uXRroxcYyHQ9sdsGh
 i1MXc9dIIc2/uws0+pdpTqrvrzPFgOEcSI8If3Vfd8wtb4bS3zjcF63CXMWxDy7jXBY6
 g9+rzSFSOU9x7I6h8+TwPe+3hhDpq3HeW2HrioYXk2JPVUZP2XTJtJMteojAqHc6dDsQ
 VQKPk6UYP8sSCwx+UZTLsfaQb3JIpBQcLL845SBSACMJkJWk9lPerAoGrtlhxG0epX1o
 q3UysGja8mFLM0YuiCwLVcpoRk3O3oepw29cOZyHONHJTiNPEkvu83J/tC5GANv/EubC
 5ySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315188; x=1786919988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6qT6LtmVAN2lMvfWwnz6ndG9Sg0G69mfIJi66f9p1UE=;
 b=g+2+9eJIUJQnkyQyO7tZnWig1zsZ0D1NbgDqRv03BveSx3ef89wJek5ya7EIdJ+V3s
 84SqqJypLDqOB72wIs50P/xakM7ChsqOQQLTPsuJxi4/4FyWfYhC856w3AdHkDDTGovU
 YMxLpc9qPP4cYxU6LwbbThdhaxQQ24KFy8B5/ewkvQSwW27ttu4YzEk0Qs5QeDffi0gW
 +Ofxrw8Lp/G7XEvvOrTgz8SQdoBrA+l0R/gpH/FluAJWyXbAudIV+FM9+rd1mctfwry4
 07fAL9bTI31QfOZENouUEnxutmCtH69PsG6hhWg01Um9Y7t3wQpjHIFImaPHIf+oMADn
 Fwvw==
X-Gm-Message-State: AOJu0Yzeb11+kAy4v17YbCgp1Xpu8uPaoJ0vcTZ4kLl1UAbjBSX+qQBU
 h+GAtUDSNTMcfdV4AnhvUv/iJPccd+akPSZKzP2Re8AyKQYiVEvyth5Na2uF0yEkNlLTKiODDF3
 +xWkt
X-Gm-Gg: AR+sD13vL7CGvk14+EbwfOXiJVFQ0K2mBdcvBOyM6XCrLUZ61Jyc4mkPx4zzymv5+LK
 kmO05Yg4H+lap4RzLES7D8c7AvnD/CfsgaATL5PH86uXQRVa41gPe17v57s/smPmw59X5LAO3Jh
 Jt3I6SalRi6wAmQPF6t3axkaaVkDQiBlyBTmCL2CLFAvlNRFJoR1LXsMr9fhdO/5rtmPYLBjPmE
 YxtZb0DD4W2fDKMCLZ+LyrKsaiYudwGHarb2+UKXr0H3ecRbysC9GHAnEHTNbgjJDSOXRrtMDiJ
 X+JpgTsx6ByvDzkMn71l+G+7qYh7PAMegdsRGAE6oEO5dSyoW3Z28Il9PdX1EV7gX7PqKsgsD+2
 QgYrKepmhBLZfn6WZSvvj//oznHRX0FTSlX/3ifmEJW6t9KlrzxRTjWsW/KTlrmilFtLQauLek0
 P0FS/HncEOlPN8HFFqVEvwfaxX3NdrJ+JvbKQIjpD/O0XjrcbdIclvcOTvFYv8Df7ooitIZ66AZ
 0nq9XSNqxYZWXi8waD/
X-Received: by 2002:a17:90a:ec8b:b0:38f:c90c:72d9 with SMTP id
 98e67ed59e1d1-3903c5b7238mr40263036a91.9.1786315187916; 
 Sun, 09 Aug 2026 15:39:47 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 52/56] disas/riscv: Merge all c.mop.n to one pattern
Date: Sun,  9 Aug 2026 15:35:41 -0700
Message-ID: <20260809223545.730664-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
index 6ec62a5830..89c2e63941 100644
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


