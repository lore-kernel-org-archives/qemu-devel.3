Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7536C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXt-0001Iz-1A; Wed, 12 Aug 2026 18:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXq-0001Ej-RB
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXk-0001rd-GG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:34 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so156494a91.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574127; x=1787178927; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PZTcClv0fbGL6N5B5J0kHpX/Mfciqq+VEJptNDCdVnU=;
 b=yl716YaBi6zBHGQb3EJ9d0Z/6k8TGf3Kx9MsqHx4LBXYPMQxYVslpQTZOihdo4dwvg
 QEsvS/a/UzuYs6E+LbbJtHR32l8fzyYU6yipZAkIYUTXUo5akc0vp8gzhhIHZ0hp9esL
 4zpF1LjwkcMkwgMy5Bn5cYnmceaH+9aMMrfVDsBrwFkSadSgHdkVrSR50bGNJq+4BVhq
 6rJibNLO3G3SX6clqxvNQgozYSuRXRiBKAfdnWRR2+Ghj349B/NYwisAxBtfItzWY+Ns
 Rd81GVOjcvpwgJ3Gv3IiG92Dab9mxJMBssVZ6ylhGevBNWbOpKzD4mQUsF0hSB1/RQx+
 FYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574127; x=1787178927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PZTcClv0fbGL6N5B5J0kHpX/Mfciqq+VEJptNDCdVnU=;
 b=sphWaCusAmubVjbb61SEXrNNDRpDCG0nJTTBSGAkFhtjqU9AZnNjb61JGvunfE0vs0
 gQb49vIT4uL4bQzOelQGeg3AfWuzvSpf739S41YsdDnr6tElW18nBMKxLbXtjShLjn9X
 opKQiowbuvjKb7sS5ngqKxNFmXTQtMgM0qtwCboaGqYxm27l5xPvXJ8EZj6LQ7hYyso6
 P1snGpZYkg1AYxUKfPEjgOxzCtqctGtVzCmyqw0pzHqUBVU45smw+9B4s1RryAroQtOR
 3JbWK9kDmtk1o0YLmJFsSMVzmlh4NLzuolnUdf9052gWE7psYRKYvIUfttNh+hm1zLhU
 E7LA==
X-Gm-Message-State: AOJu0YzHdKxiOgWs6uVyenzDzxcC29HMOraYHdjRVHk8Aa24n72kCROO
 GrV0FP9jKOCC/g1TAPXfID+aR3wmYSiTmVYxlaoWUMuIIPZDZ8cVPqiYD4dB3G1/tWPhFUxUvx3
 3O/uV
X-Gm-Gg: AR+sD12vrPz4Xb0C+D0/Tb+CA6ggHQsjf6ZxLs/ewQHFf5DVgyk9hyno2+4+SeNj0J2
 yRTGDH0o51L1xmdKP4Q3qhNSsSOPEiSQvh6/uRfIJ//b5sZX8SrVuZ+j8uEvZn2BoKgb+DJG4mN
 ek8rc2LRfdTRbT0mgJtuJGmmWDmGisrHKq+7ZAzWpLJ1wBiZgu9wsBE3q2vXroYeXGo4nqvvqSl
 uJxeBWRasV5cj4OG/gs7RRzodEOzUl6ignUZpouuPhbzSdXRmwTH/aQ6gd8unekmqYdGCQ9K+NW
 erMNEHmdMjp4Sj3j52NbQsVrTNVYeut8dQEQPU71Vs1tvH0PsmDb+eRPujey/dQTBHmjhC9fajw
 JxS/C0e4CA76s6WPjFMN7dSd6i1haSBDRxKZ6/O3ZHsbxsWgoSo1Q4lnm1VS75oj4/fYYHzlPrE
 fMP9PNQY/VND/VKWcmqKUDC4Vs76By7c3tdEwIxOdrtlNyHIb4OCtYJgf1e0hpuvxikCW3qRW9w
 EvPOM4nSGWMg5fyj9dxzJFzucQiykI=
X-Received: by 2002:a17:90b:2790:b0:381:26f:8f05 with SMTP id
 98e67ed59e1d1-3931dfe502amr1997579a91.3.1786574126867; 
 Wed, 12 Aug 2026 15:35:26 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 47/52] disas/riscv: Merge all mop.rr.n to one pattern
Date: Wed, 12 Aug 2026 15:31:37 -0700
Message-ID: <20260812223142.349142-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

Avoid performing arithmetic on rv_op_mop_rr_0.
Treat the 'n' as an immediate.
Create a codec and format to match.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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
2.43.0


