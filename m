Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB95C5AD5A
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 22:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtCBM-0005zm-OL; Sun, 09 Aug 2026 18:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBK-0005xp-7L
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:50 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtCBH-00085y-Jo
 for qemu-devel@nongnu.org; Sun, 09 Aug 2026 18:39:49 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-381c51fde6bso1426868a91.2
 for <qemu-devel@nongnu.org>; Sun, 09 Aug 2026 15:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786315186; x=1786919986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fuCBO3c4KkU6IdYL03w0f8q0GHaTcRVrzjmCPJRXmnY=;
 b=qg9pLhgzrieVjd/59RZjw/ESWPhe9obPOVnDQopCr/Q1Ze915acl+nDNsfKYrnLrgZ
 7Er8zKvkCLMlmm2053JVYDWBdn6ZWjBP+khFT1URy0Fc6Qm1w608VWKOhAVWKPaau7fA
 Q5xlMvQmhJfBrVXjqeNIiXtEBhfAhk6WOz3mlQYRS+vDbW1ufBixS9xCz5bh8r0bhkix
 VRNoEAWr9HE7DbX1wYJJ2ifQmR383i/5kEhNd4ov6u6uhPG4bhhHCWq1f3rQwTuQTnlq
 QqcBbwfJkQKNtz08Gn2bTz1ES6fKBliBjmUCBCn7kXTYTwH5kFpHLq8ZlFH4DSai7ASz
 P6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786315186; x=1786919986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fuCBO3c4KkU6IdYL03w0f8q0GHaTcRVrzjmCPJRXmnY=;
 b=FZtHzY+TWYwq61IR87WgOTahH4sLnk+47YMSVow6Ivz+t9Q3b79Y1ysGYZeQE8uxIm
 2HXLJ+L8aatofZXSyYC9zT04feG+u2TFshjv7tWUsp02XwMaXZ+amgWKQd4lbsEYKUCV
 XSFCsITguneGa8g3KIPQiCxZfBcdkT23aXg2RxX6XGPRYLA+gE0zQp+j+LWxPCpP8ZMX
 M8RuZ3kQYCkVjxnC7q4RibjbjWOo5fqwFRp52gvf7gZEkvfWpIz7oRL/sGFgh9Zbdg4h
 cwBSGxf3YiQeMYyih/WASbXJlnseSsNV/rqyjaktWykOKKE7LT8B71due6f3G7mrqg0E
 o3cQ==
X-Gm-Message-State: AOJu0YwgpEJKITSVmcoxLcMRWLqx3mpeRnhVEj/jhU3eqPXhu27qQips
 I0XNDlipachmQDMZGqsop8AxnwNC8n9a8Vw69XAyOsHqnnyyeA2X6zs6hf9iE04Vnd/upAAEaf2
 5pCKl
X-Gm-Gg: AR+sD13XTPn3C1+m9F1Z8LzRFKZKTWfT2YjBPp1ZhXTiYrdymW7gkWCn8ePYbWjcniN
 rI/nxwzF5hoD0jjHdmb4B7X9Yx5Imth7NcLPU/JrKnS6dKSTBF9QdJIojjfHUoHMMAllysDHkAa
 xjeMC60sfVL2s5ZufC5vlHOXFL9cad/hgJMn3UKc/PziuuwYy9Hb6im85NpvwHAX2wIAnuGIEyC
 ZjkLIb7mNtN2FbfTa5InxQ5Sx0jgEe8r15uX+CmXu7LXZNCGnewGwKHxuBFP3UN2h/KXCBiOhwQ
 F3jucHCxst07IBkXXsrWcp6dXEzwTo9yLczKokOyHgML7CiyELZYuWsEEn4bj9aMbbQfJghHBIi
 ktwnICe3gnQ/rvlPqY0Mw4n6uqpo147PW/+eCFRL1lDtXTq2LLuJFgreBpFNdtPsIsYN6nTDXPh
 AAZlhQk5sZMCwPywR+kLA9J8W8Fhw1aVsZMVlo5weIs0pwySnTzimxb+M42Q3vXCvqcRFWJCUVF
 Qu2mK6X2NjGMBVM+9Gy3My3KaI/nNhM
X-Received: by 2002:a17:90b:2748:b0:380:7688:fbe9 with SMTP id
 98e67ed59e1d1-392823a4a2bmr16578023a91.8.1786315186229; 
 Sun, 09 Aug 2026 15:39:46 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-390b1573defsm4264430a91.1.2026.08.09.15.39.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Aug 2026 15:39:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Subject: [PATCH 51/56] disas/riscv: Merge all mop.rr.n to one pattern
Date: Sun,  9 Aug 2026 15:35:40 -0700
Message-ID: <20260809223545.730664-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809223545.730664-1-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
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
index 450a5c8142..6ec62a5830 100644
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


