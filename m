Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74C66C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 04:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtks-0005Ij-E8; Wed, 19 Aug 2026 23:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkl-0004PW-PD
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:44 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtkk-0004Cr-9X
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:47:43 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so1758645a91.1
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197661; x=1787802461; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9sf58UgizOO2O3vOdLTpSVW7MW2OkpGmmaGS8aJxPcE=;
 b=RcJ5/q2yqdUFnGgetJty89hYRfVqhdm44whfdGlXmGtPdI9uS5dVsu5bZrSJxhD8cU
 1P/2giLPOfRtWgV/Vazui9FFkMxLJsz9pcwDyPLri7PjtWJA87eXPrLkYcuj8B9Qpc6I
 YLr14qVqbJVFkoq+0orHmmcKVVAOWIQwp/oOFm8DgBXCPL3Ta+GP0GxpLr4UhbGDQlXu
 0443Fn6Gj9RjMOB7ptCR9AKH3/wzKoUd4K7qjtuipIfnWBQ/fFMsLPd9VOHVI+ciNFX4
 zLhQSH2ABU3fC+YxC9vldbkABZmXBCK3Tp6OXftRxs7sGT03xxSzRiNeVz6jnzf0uuo5
 LsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197661; x=1787802461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9sf58UgizOO2O3vOdLTpSVW7MW2OkpGmmaGS8aJxPcE=;
 b=XgE1i8M64+juMpPD8o72lhMFLsV8FmI0Jh6AKfa2w14jEU/kpy9vz0YuVtrGzhrbel
 979T84Es3IYFh2dTmxr4awfXbu+1cZDhIAdxqU+SXMHOWw4TR3cNjJ2IjpCf/PsUDAki
 dKSYyIvD8yua+2+z3e4f93XqISs7mV1oPdaTGI0oVgTZXWzmirqOcqtqWXAluViZrcxn
 XOjKdyj+i8ZbfxKxW+PP3VVnahsgQPOXvlwCw3Po1shJOy0J3OuNUwXEGi40nB5x0HLR
 gjrz6uMkUwDY7y/0MA4wQ87Zo2sRNow+d81bmpSKqOZqc05jMI0L/OScGlErABmaJKAU
 iJ0w==
X-Gm-Message-State: AFuF++mpaXv+JIm9S74swICwrHx3kzThBHZ0oqEsf1YE1B6uwBpeWAwb
 j7T0CbAnmoBFSNDUKbF6l57FJ0o8tXSS/RiatMAG+yqmxwBkcOMPiZ0C42TbIg==
X-Gm-Gg: AR+sD13Z/EKLgPUtRqQ8sq9tNeghHV1M8BhrEf4RiZgvTPBmD0uOisjmy+hIlkK+CZO
 XRRepieDZCd4xCWLROq2MO2nDQwdjjyaAfTt+0aztdi3P67CNLnUaE1r/K95XVxijCflpYUebzC
 TOZTvuITDi8OM0eoZgD2tNiOT3cK12Brek3X78w8/fVEBE59Zk8jlMEmTlku9bVpnxBlTAS0lcl
 h3NPheJsoIEO3r4lggQWqSgOBv/HACU3FFHBCfPjHd0iUQsadXvl/5ZoeXEABRfxtiaV0FDSfIy
 lbeo+43DGfZvBiOkjH74xer46OhlZigdDAH0Bdi9h/efwBeaJCMkr8I/ALri4ArJem2JlZXZFcE
 7cMSJjL+pYL3HZ9GSi6swsgb7awTZio5yXTCPKw5zW1w5hFRDBKbUNNewLcZKZe/l1sbsKYIJqG
 cGjPE4loh5TmDfm1g0x7v27xb2P3qfRz4/f8GeUqeSzaz12rMNZ1N5ZEXvz1QNMvuZdUVIsRJvp
 pTFEg==
X-Received: by 2002:a17:90b:39ab:b0:38e:fea2:df53 with SMTP id
 98e67ed59e1d1-39580ed4567mr15742282a91.4.1787197660657; 
 Wed, 19 Aug 2026 20:47:40 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:47:40 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 61/93] disas/riscv: Break pseudo loop for jal and jalr
Date: Thu, 20 Aug 2026 13:43:58 +1000
Message-ID: <20260820034430.1186695-62-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1029.google.com
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

These were clearly intending to simplify
	jal	ra, foo
to
	jal	foo
and similarly for jalr, but the pseudo expansion looped
back to the original jal/jalr with the full format.

Add new opcode expansions dropping the implied ra.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-26-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index d3cbfb86ac..fe503b6cae 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -326,6 +326,8 @@ typedef enum {
     rv_op_bgez = 295,
     rv_op_bltz = 296,
     rv_op_bgtz = 297,
+    rv_op_jal_ra = 298,
+    rv_op_jalr_ra = 299,
     rv_op_j = 302,
     rv_op_ret = 303,
     rv_op_jr = 304,
@@ -1029,9 +1031,9 @@ static const char rv_fli_name_const[32][9] =
 
 /* pseudo-instruction constraints */
 
-static const rvc_constraint rvcc_jal[] = { rvc_rd_eq_ra, rvc_end };
-static const rvc_constraint rvcc_jalr[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
-                                            rvc_end };
+static const rvc_constraint rvcc_jal_ra[] = { rvc_rd_eq_ra, rvc_end };
+static const rvc_constraint rvcc_jalr_ra[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
+                                               rvc_end };
 static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
                                            rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
@@ -1068,14 +1070,14 @@ static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
 
 static const rv_comp_data rvcp_jal[] = {
     { rv_op_j, rvcc_j },
-    { rv_op_jal, rvcc_jal },
+    { rv_op_jal_ra, rvcc_jal_ra },
     { rv_op_illegal, NULL }
 };
 
 static const rv_comp_data rvcp_jalr[] = {
     { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
-    { rv_op_jalr, rvcc_jalr },
+    { rv_op_jalr_ra, rvcc_jalr_ra },
     { rv_op_illegal, NULL }
 };
 
@@ -1884,8 +1886,8 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "bgez", rv_codec_sb, rv_fmt_rs1_offset },
     { "bltz", rv_codec_sb, rv_fmt_rs1_offset },
     { "bgtz", rv_codec_sb, rv_fmt_rs2_offset },
-    { },
-    { },
+    { "jal", rv_codec_none, rv_fmt_offset }, /* rv_op_jal_ra */
+    { "jalr", rv_codec_none, rv_fmt_rs1 }, /* rv_op_jalr_ra */
     { },
     { },
     { "j", rv_codec_uj, rv_fmt_offset },
-- 
2.54.0


