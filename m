Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF443C5AD5A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHV6-0008Pk-6W; Wed, 12 Aug 2026 18:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUj-0007XR-RD
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:21 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUg-000187-En
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:21 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so1408585a12.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573937; x=1787178737; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2IYq9jETUxHredYsfkkW097bX1nAbnLjYqz0/8fmjYM=;
 b=EILdF9eP4pUSdddIAhQvEuzp5dt2T7z7xWP52r+3IXJsITvvfMBBegqG2Ad8ZGiYF5
 sEgGoJj4js8U4DNCNq0JQGux6W/2ey/vCZLr+fwg671ZQAiRjkqD/sNlnTTJa4swL8ZM
 Y979RYn+Uno7ByHEehuu1FykaXl8i82b6s8Sf/JRMcgCR5ORUIXs9Tqy9dzpMeiQXdPN
 yR8nbRg/PyKDoTJhAL/JIxjdtuwkbC2D3h9jcM7YTgwHt/vTeQaEsstIgLjRgoUFw9hU
 ytdtW4GHbtCmMmNU9qJoGKIOHZQJOH2hO+HzkbXix9Awo22KqRyxCfRJhMw+QS87gdfB
 SZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573937; x=1787178737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2IYq9jETUxHredYsfkkW097bX1nAbnLjYqz0/8fmjYM=;
 b=qEywlgkiy4uzU+qDgxW+KaMktJ2hoYtAgMN2QqTWaogtOhZycjXsK6w4KXKXGvKqhp
 4kLwsqMBFuTF71rCntH3ajDqRE4TH+qjL7bsHsOKxliAtUbtLLM0r4mlRA9RYsqBsWnx
 3SMtjKkXlI0YhvkDLSnYMyxGelrBTPL0lgS0lzVSJGHgx8B/NHPVvCC9UiBN8P5rs9dU
 t468HnX0/YZM8zlVhi7+WMI+rww4QmsNTp0B6QvNbjnvW45Ftxr+AydeQ83O+IwqQbtE
 qUNCGNFvJDc1Lg3o0oB6twKTdhmDLyNKLdYUEy9xBOwpBogQ25Lwxq35zvV0osLrUyW1
 D8/w==
X-Gm-Message-State: AOJu0Yyhrcpa9KMDHb1sNnp5Wbq1nF40rLCngZH1R0WGxKPyP1xqMIc8
 cWbdPxOqF3LBbVD3nUP2DvA2tCiSqDVgf25nzHqcaefOUOmw+RU9aFzrmp0zQ0mr3F20pA/EjYY
 FBAeA
X-Gm-Gg: AR+sD11OV8PW61lzFas/kR0eb2qKXo0Ph9eu6YMlk4Wc2VdZrRP4XqmqhZ0/6vv9xu8
 i5yhoBc30PZJdIkXFc/XqrwZ2D1CvRJRSPdYq2cJV70GTptAZ68f9toE2Zu0lhgf3SFG32h+ACu
 tSsC+USzVSqLz+qouu7DKBB80TsEdRWnHkOTAKrbDj+5CabymDXswDwFUKx1okeP2X1C4LOA5Fp
 SNqKwmwwiLbu2UKRRejs0A7v3uqiWaTvhozqFVtYpwdPRI733rmrXT8J1RjGtJZYccQCgezmeM7
 yAP8ypWnmXUGTfDISMMN0eg11UAxhHcvN9ZONkJ70FQi3Ppln8vzjImL+VOS4m9zRRzgT13qQ5l
 wdxU4gw23+P74Idyny1JJL1eppDnNP9bwUwf2piAOaVJQWCqGVU6aMRTdpBbjIsqzQ4emb+TOTd
 NSvYFFOYzS9Scmo/cEGMJJK15AfNXNq/nBosYq2PEhqFM0EKy9M718hzSedrldcYgvh7YXO7STQ
 JCXJqr8R7Wgp0RHiaSm
X-Received: by 2002:a05:6a21:4c85:b0:3c3:8ead:6df0 with SMTP id
 adf61e73a8af0-3cc5534579amr2253431637.28.1786573936922; 
 Wed, 12 Aug 2026 15:32:16 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 34/52] disas/riscv: Store op pointer in rv_comp_data
Date: Wed, 12 Aug 2026 15:31:24 -0700
Message-ID: <20260812223142.349142-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

Store a pointer instead of an array index.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.h |  8 +++---
 disas/riscv.c | 69 ++++++++++++++++++++++++++-------------------------
 2 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/disas/riscv.h b/disas/riscv.h
index ea7141d3b5..ab62c0db94 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -164,17 +164,19 @@ typedef enum {
 
 /* structures */
 
+typedef struct rv_opcode_data rv_opcode_data;
+
 typedef struct {
-    int op;
+    const rv_opcode_data *op;
     const rvc_constraint *constraints;
 } rv_comp_data;
 
-typedef struct {
+struct rv_opcode_data {
     const char *name;
     rv_codec codec;
     const char *format;
     const rv_comp_data *pseudo;
-} rv_opcode_data;
+};
 
 typedef struct {
     const RISCVCPUConfig *cfg;
diff --git a/disas/riscv.c b/disas/riscv.c
index 342e2db3cc..9d05e86c09 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1068,138 +1068,140 @@ static const rvc_constraint rvcc_true[] = { rvc_end };
 
 /* pseudo-instruction metadata */
 
+static const rv_opcode_data rvi_opcode_data[];
+
 static const rv_comp_data rvcp_jal[] = {
-    { rv_op_j, rvcc_j },
-    { rv_op_jal_ra, rvcc_jal_ra },
+    { &rvi_opcode_data[rv_op_j], rvcc_j },
+    { &rvi_opcode_data[rv_op_jal_ra], rvcc_jal_ra },
     { },
 };
 
 static const rv_comp_data rvcp_jalr[] = {
-    { rv_op_jr, rvcc_jr },
-    { rv_op_jalr_ra, rvcc_jalr_ra },
+    { &rvi_opcode_data[rv_op_jr], rvcc_jr },
+    { &rvi_opcode_data[rv_op_jalr_ra], rvcc_jalr_ra },
     { },
 };
 
 static const rv_comp_data rvcp_jr[] = {
-    { rv_op_ret, rvcc_ret },
+    { &rvi_opcode_data[rv_op_ret], rvcc_ret },
     { },
 };
 
 static const rv_comp_data rvcp_beq[] = {
-    { rv_op_beqz, rvcc_beqz },
+    { &rvi_opcode_data[rv_op_beqz], rvcc_beqz },
     { },
 };
 
 static const rv_comp_data rvcp_bne[] = {
-    { rv_op_bnez, rvcc_bnez },
+    { &rvi_opcode_data[rv_op_bnez], rvcc_bnez },
     { },
 };
 
 static const rv_comp_data rvcp_blt[] = {
-    { rv_op_bltz, rvcc_bltz },
-    { rv_op_bgtz, rvcc_bgtz },
+    { &rvi_opcode_data[rv_op_bltz], rvcc_bltz },
+    { &rvi_opcode_data[rv_op_bgtz], rvcc_bgtz },
     { },
 };
 
 static const rv_comp_data rvcp_bge[] = {
-    { rv_op_blez, rvcc_blez },
-    { rv_op_bgez, rvcc_bgez },
+    { &rvi_opcode_data[rv_op_blez], rvcc_blez },
+    { &rvi_opcode_data[rv_op_bgez], rvcc_bgez },
     { },
 };
 
 static const rv_comp_data rvcp_addi[] = {
-    { rv_op_mv, rvcc_mv },
+    { &rvi_opcode_data[rv_op_mv], rvcc_mv },
     { },
 };
 
 static const rv_comp_data rvcp_mv[] = {
-    { rv_op_nop, rvcc_nop },
+    { &rvi_opcode_data[rv_op_nop], rvcc_nop },
     { },
 };
 
 static const rv_comp_data rvcp_sltiu[] = {
-    { rv_op_seqz, rvcc_seqz },
+    { &rvi_opcode_data[rv_op_seqz], rvcc_seqz },
     { },
 };
 
 static const rv_comp_data rvcp_xori[] = {
-    { rv_op_not, rvcc_not },
+    { &rvi_opcode_data[rv_op_not], rvcc_not },
     { },
 };
 
 static const rv_comp_data rvcp_sub[] = {
-    { rv_op_neg, rvcc_neg },
+    { &rvi_opcode_data[rv_op_neg], rvcc_neg },
     { },
 };
 
 static const rv_comp_data rvcp_slt[] = {
-    { rv_op_sltz, rvcc_sltz },
-    { rv_op_sgtz, rvcc_sgtz },
+    { &rvi_opcode_data[rv_op_sltz], rvcc_sltz },
+    { &rvi_opcode_data[rv_op_sgtz], rvcc_sgtz },
     { },
 };
 
 static const rv_comp_data rvcp_sltu[] = {
-    { rv_op_snez, rvcc_snez },
+    { &rvi_opcode_data[rv_op_snez], rvcc_snez },
     { },
 };
 
 static const rv_comp_data rvcp_addiw[] = {
-    { rv_op_sext_w, rvcc_sext_w },
+    { &rvi_opcode_data[rv_op_sext_w], rvcc_sext_w },
     { },
 };
 
 static const rv_comp_data rvcp_subw[] = {
-    { rv_op_negw, rvcc_negw },
+    { &rvi_opcode_data[rv_op_negw], rvcc_negw },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_s[] = {
-    { rv_op_fmv_s, rvcc_fmv_s },
+    { &rvi_opcode_data[rv_op_fmv_s], rvcc_fmv_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_s[] = {
-    { rv_op_fneg_s, rvcc_fneg_s },
+    { &rvi_opcode_data[rv_op_fneg_s], rvcc_fneg_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_s[] = {
-    { rv_op_fabs_s, rvcc_fabs_s },
+    { &rvi_opcode_data[rv_op_fabs_s], rvcc_fabs_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_d[] = {
-    { rv_op_fmv_d, rvcc_fmv_d },
+    { &rvi_opcode_data[rv_op_fmv_d], rvcc_fmv_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_d[] = {
-    { rv_op_fneg_d, rvcc_fneg_d },
+    { &rvi_opcode_data[rv_op_fneg_d], rvcc_fneg_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_d[] = {
-    { rv_op_fabs_d, rvcc_fabs_d },
+    { &rvi_opcode_data[rv_op_fabs_d], rvcc_fabs_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_q[] = {
-    { rv_op_fmv_q, rvcc_fmv_q },
+    { &rvi_opcode_data[rv_op_fmv_q], rvcc_fmv_q },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_q[] = {
-    { rv_op_fneg_q, rvcc_fneg_q },
+    { &rvi_opcode_data[rv_op_fneg_q], rvcc_fneg_q },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_q[] = {
-    { rv_op_fabs_q, rvcc_fabs_q },
+    { &rvi_opcode_data[rv_op_fabs_q], rvcc_fabs_q },
     { },
 };
 
 /* Convert compressed insns into normal insns via pseudo expansion. */
-#define DECOMP(X)  &(const rv_comp_data){ X, rvcc_true }
+#define DECOMP(X)  &(const rv_comp_data){ &rvi_opcode_data[X], rvcc_true }
 
 /* operand extractors */
 
@@ -5270,9 +5272,8 @@ static const rv_opcode_data *decode_inst_lift_pseudo(rv_decode *dec,
     if (comp_data) {
         while (comp_data->constraints) {
             if (check_constraints(dec, comp_data->constraints)) {
-                const rv_opcode_data *new_op = &dec->opcode_data[comp_data->op];
-                assert(new_op != op);
-                return decode_inst_lift_pseudo(dec, new_op);
+                assert(op != comp_data->op);
+                return decode_inst_lift_pseudo(dec, comp_data->op);
             }
             comp_data++;
         }
-- 
2.43.0


