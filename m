Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B60C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtll-0007DX-Hk; Wed, 19 Aug 2026 23:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlk-0007D5-U6
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:44 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtlj-0004R8-8P
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:48:44 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-3811f512167so2525135a91.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197722; x=1787802522; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LfQohlZt640C5GwVV70FzQC1fZ1dLJnvxGCO8xDnz0w=;
 b=JAfKJLTS4UyusjZcIDzn7G6xa9LKiW+vCSV7CoECCg3Z/4yF5Ad8jrc6G6tkWrp4tT
 934SdjB9cnH/YtHzpsyzMRqntvevc6NMqR3dAg9UdXq5dtDK+4Mrz/OOhkXdRGIYgdXY
 RScBJysICrtZBxYZ1ZbjWP7WZQ4YD0qLG0QDn2DVjJ2NL+kkReK44U3vA9SBMh+OixzP
 iXzuauxA9IIDjp+JCOD6Rq1pL12XxTpXJD3Nkdm5C6QYOFvTYF/7PDEbQIT0HFBJWnpu
 3MRHXjUNI5TMEyXRvMXyNaIGFFj7SrQcuhHNU+Dj/5CJm+srg6LZHiX4sGPv5xlySrt5
 jWrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197722; x=1787802522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LfQohlZt640C5GwVV70FzQC1fZ1dLJnvxGCO8xDnz0w=;
 b=Z2EBgsSGHYo/1hBxbrMqAFwB89hDT94kYFqK3SUl7zOxuPmRaCKB3flf2cXyNoLCin
 I4T7w/hgJHSjOphUeRgMj8jSpgq2Is77gtEzvRXjziwapBdfVUatIMjOjf2KG+JPYpvZ
 LvHtxZ93MnSEF1b0imvvfM+rnwGHE48KoEIt8UWLRYLYJWLQlF0viD5NAv7rgcYlTGxc
 Fp7EpwE6PSvaQSuiwOjV+zvQAKGLUA8wLFkmYmFd4FwcSq08xbIP0u2tE4AcYpFmYArm
 JVfP+whD05RiweoSgMGnSQnZTjn4+DZ8Btnj+hojas6Jcl32pViRilOE7l1afhdQlyRX
 1QFg==
X-Gm-Message-State: AFuF++mdbsBZSvqN2zkfQrnGodhcZOcLhaykvh8R1HjVLYMGORqWFEE4
 oUfjErde09CvUBmTUDo72XTAZMaj4nXmbauUAcyBfwJm5Z5KyAQFURaSGo1phw==
X-Gm-Gg: AR+sD12hIujEHwt/Bnp86Y2vTVhgTq4Ifs4tbI1YLfOyDLypPL+2vvVPpjAofiAy8+A
 V/yyLU8Njud5JrVTymnCikBICj72S4i6fXUyR0tGQLIy7njzoMBcq8pCD/kohdfVRvp+vSywJeo
 TYN5vdBRyv3sB7rsM+dYg0QpjC6DYZTyms1JxAMFq1C2h1CDCGLRqll6xd7iGOyl8VSLY9L1+77
 Q0udgleglEz7cb40jmxb+iL+Av0YSwWPI+Q8bN+NN1Azgjx1nRkOdFZbvu3cqL/xjXHlPMavBwI
 S7JLdsGGETvpxIzn6ZsQQwGKiA/Le/sLoPc4eRDtntODNcvA1o+weslqxc+gCp5h4KM1TbA0Ikp
 e0T5pslGPd7Nfexo1tZ6pl2uK3e2p2SeESHisZNckmRiWcsnEgABUJtrmQPrbEn31J8/c5KOvqa
 yG3ScydYhIGCfS8XdfQ9K5tqDboai9xCMnQvKilnUFa9rzADh7fRT9FJbK0s7eVZtg/nGCv+kYf
 1/2ag==
X-Received: by 2002:a17:90b:57e4:b0:383:5a16:bd70 with SMTP id
 98e67ed59e1d1-395810f999amr18654315a91.16.1787197721979; 
 Wed, 19 Aug 2026 20:48:41 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:48:41 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 83/93] disas/riscv: Merge all mop.rr.n to one pattern
Date: Thu, 20 Aug 2026 13:44:20 +1000
Message-ID: <20260820034430.1186695-84-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
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


