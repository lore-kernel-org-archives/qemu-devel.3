Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC17C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbc-0005cC-8V; Mon, 24 Aug 2026 01:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNb4-0004nh-2K
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:51 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaz-0002rn-3I
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:49 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38e08baf860so3374156a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550701; x=1788155501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mS5lH+O6u6AC0cF1efiMr/IZgg9QvygUsI4yMDEJpC0=;
 b=S9lpARbPDQYfFcybVEA6ne8jCApLejZFWufkg35JFHMy9Ago+9BaLAnjJTjY+97orI
 vbgX+J6Rtz5T3jXWUf2PoSaniE08ERPbQ+kAdmNRDPuC5zuVpbnCsXz2eEDGE6hrGDEi
 8IVsO+D93EClCmHNnaVXnXg0Xp6iX/CDXcFVQjL/mc1edNrCO0OPWrc0Gf2oG4/bgKfe
 94dLFO+qMZIAl7XjUXiWENkzoeK3GXEmxyilxGXrRAT+J44zilRAhVtQxJnvCfR7iolm
 BKVzlAX3bYQOv863MknoIqVTZVZTZcnknSeLm8xawlWC5pRNYmTEE8Mj2IjXDyEe2J8T
 B6Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550701; x=1788155501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mS5lH+O6u6AC0cF1efiMr/IZgg9QvygUsI4yMDEJpC0=;
 b=DIEDcz0IWJGPlNplnLufAhS2Kg698fdoNAxyCJWZkZFOjTPPIXhKRbR+WNsly7d01R
 gA1lK0V5mUKS44hszaflP+EeVIMJYH9huZohsy0zOUHKlbQ9lfmM86Oel9DGltP9cD2/
 S6jXBPkRkTRDdf/WFUGsBHj98aoI/Gre9OU56QXDYV0CKq1aadubaOyfOkv3QqQAT55n
 klpa09bVLQqQDQ4wK556yXQZqVwhULMx8SLtIe3HSKbR2I3L4sZynw3j7foOx4oEJ2Ym
 1P7eXvWCGINsW+vMMM0ln9oNyjBLgNYsVXUyPNvaAbRA2HuVXWUob92oqrJMlzligCoy
 Rrcw==
X-Gm-Message-State: AFuF++mj3CEXexvJcG7NInSXazdZmoDbqZGjc5a4+KR7dmLV0nh2cPHt
 AcnxhSpKVsp7279ExiKYhUGhnxMOYuiZJhzAzrjaOXOKiG3gHUqX6OHmCGkZtg==
X-Gm-Gg: AR+sD103H2qvqdjcGhnVGqgpgtf1yIbYwcXlj0gNuiBhMJgRTsx1LROtsVfc3IWQ4j2
 31otWG4+zoKcFR34ZoqJahamphhVhYHP+p5OFAQa3dlqU/y+UFPZD3gI5l8zy9cJoAJZoOTR0/C
 eRiASGcDDRN96UebJletUuKbAMsPceNpnxBPVIvctwWu6g7owisdXRukTe0pT61xPxkZbG+fRAc
 cB9ypMrPMnLVrBIX0+0v4SDnttCglfFpt3LbisRWDofHa/Ltj14O2l39VWe+mybmROslAIR3xXf
 1U5Zu54F9jspiLbfIGf5WMRCjfM1b8KwpZlS9U8KIRRb7d+0PH92JbhGj4tEbdKaWOcBHZBlnjh
 forcNlW5VajTeh+DdParOV8NIVodEQhGylYTCLkWm+67LV42RXl7lp0jCKtgNJv1KdeX+WHJdCj
 msCzWrPWSWlA+n22JnO0xSidQplmBZUOHJEmsbpn/yaIIzx5NT7GMblaxLd5Lw2837kVbYzPj3m
 M+FlA==
X-Received: by 2002:a17:90a:d605:b0:38e:5964:97a8 with SMTP id
 98e67ed59e1d1-395df5e8fefmr29846249a91.16.1787550700850; 
 Sun, 23 Aug 2026 22:51:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 67/96] disas/riscv: Store op pointer in rv_comp_data
Date: Mon, 24 Aug 2026 15:47:37 +1000
Message-ID: <20260824054806.2790041-68-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102d.google.com
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

Store a pointer instead of an array index.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-35-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


