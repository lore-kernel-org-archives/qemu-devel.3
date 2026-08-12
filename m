Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331DCC5CFEB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHUq-0007dY-I2; Wed, 12 Aug 2026 18:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUg-0007SN-Mw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:19 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUe-00016w-El
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:18 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-ca80d708489so267645a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573935; x=1787178735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uT2u9egUYWf+3WyYYmk+YoTZEeWMXCwBh9JSzni8R3c=;
 b=NKKXIq6u4cCA2J/lbrrfqgtq+vKhDXLSPImtJaF2NNnqiU2dmZUWJvZiD5OVJ+nJIN
 SzjMCn9/R1js+NC79cB7yYJV/Aobr5+69aP17cbs/JANdmzs5KQKzvY7T+rtjhu70Gue
 WPo8Yt93tikVZzJiXCMUEH6YR/oofDOTUKJdNnftw71Ge7N72Mc6J1urui8UEW0YKY2K
 HLzFi6/1jPMzuyahVseY0hH3ZQKwuFswa2u8J10kh3wj4qYfu1PMb6HyIo94aEa9AiAj
 Fd6qz0Ex9/Kq3AEqvmf3slsF9nR2+DgCg+hTcHt/BYo0557IHlxn8E0ZKNx7pl1a3zh2
 Iy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573935; x=1787178735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uT2u9egUYWf+3WyYYmk+YoTZEeWMXCwBh9JSzni8R3c=;
 b=TpZcHDHNDVLGulaZL1Ug7Jl7VHr78Emavem56jXnx6MPLwn/1SM1/ilH1aOK4H0Ctj
 ZtLn87WtPZsKyzz07dL9RSF+WmhrlWagmLY1P88Wu817NDp6Sgopuo5/pJ4nKkQuzLV8
 NUE+pxf4ayaAONiOoseCJ/rTRJj16W8HGJalhZ0wL9OGr6jwQtO1u0quMCrDb4Pfw8lG
 YKJK6+QQUb4flbF+7nxMddZ+CvjLh6eCZrf5FMoBNLGRKkI9lAHvVX4hw3MXa+p2RE7b
 IggFeh9xao2ej9/qowQANxC3ghubRnE05McrYstdo1T398PsEBXPGo/XMjKsZ8BqlVyx
 C8NA==
X-Gm-Message-State: AOJu0YyOS1Nht/2X0UD0Jlv7hDBfj+H+E4fr75hlrJwqosUcQ52INFW8
 mWiIcaPcauchIM2Ccg4zfyRgB5Y5wpGsqiZiEdf8shQ+06r1E1d6bnJ2UkQjNoWRtS3KmGEOEol
 08JqA
X-Gm-Gg: AR+sD12RnrrEkM7EgfiY5fUATZyVlkKXuC9OSybES5a8p8oXY2XBTgZWaPxVNVf2gyA
 87AMyQvBXr2KU5k6XHaLgyg/QfY4421ivR5A1AC5yZRJGQACg6eith210gUbsOtGo3Ubn9PxkFw
 21hR+6Zv8wjGSTOCc3sI6FV2zTh+0LZZhlQyr9ZFgtvZgwdqtfCJmhoufnoegvKgsiCuj7CymDg
 yuIK9kFuTJtmMtcEu0Z8XYCj3g3xkjRx0MoNo7YlQSxFGMrj8cqiezlmV4A3TRH7863+Wd4vDIC
 A5cDxany0IB13doVZiy5p1hURm+Yey4sNTRj4OEMkIkTLVl9gAd4EvCT5qwrzXEDaQQkj2jwvaz
 ID7pT+FAjrIif0eRTMcGJZSqQXDtjG5EXlbJVriqiyvdtXl2T0RVPDqGbXrYoJHhrVCiNuLF191
 rJxfQZBonWkRgWAwr5Y1m5NcEOzcl11nH2PDArfPOwIPGTMmwMtmIIqw4bGdoha+flMzu/HJ8ax
 RHIZ54XbPGOmKjWQDGE
X-Received: by 2002:a05:6a21:9203:b0:3b4:661d:8405 with SMTP id
 adf61e73a8af0-3cc57b0879emr1133514637.4.1786573934645; 
 Wed, 12 Aug 2026 15:32:14 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 31/52] disas/riscv: Chain "nop" pseudo off "mv" pseudo
Date: Wed, 12 Aug 2026 15:31:21 -0700
Message-ID: <20260812223142.349142-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

"mv" has already checked a condition that applies to "nop".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 91f6d9e4af..7fa76b2d15 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1035,7 +1035,7 @@ static const rvc_constraint rvcc_jal_ra[] = { rvc_rd_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jalr_ra[] = { rvc_rd_eq_ra, rvc_imm_eq_zero,
                                                rvc_end };
 static const rvc_constraint rvcc_nop[] = { rvc_rd_eq_x0, rvc_rs1_eq_x0,
-                                           rvc_imm_eq_zero, rvc_end };
+                                           rvc_end };
 static const rvc_constraint rvcc_mv[] = { rvc_imm_eq_zero, rvc_end };
 static const rvc_constraint rvcc_not[] = { rvc_imm_eq_n1, rvc_end };
 static const rvc_constraint rvcc_neg[] = { rvc_rs1_eq_x0, rvc_end };
@@ -1108,11 +1108,15 @@ static const rv_comp_data rvcp_bge[] = {
 };
 
 static const rv_comp_data rvcp_addi[] = {
-    { rv_op_nop, rvcc_nop },
     { rv_op_mv, rvcc_mv },
     { },
 };
 
+static const rv_comp_data rvcp_mv[] = {
+    { rv_op_nop, rvcc_nop },
+    { },
+};
+
 static const rv_comp_data rvcp_sltiu[] = {
     { rv_op_seqz, rvcc_seqz },
     { },
@@ -1869,7 +1873,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq) },
     { "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq) },
     { "nop", rv_codec_i, rv_fmt_none },
-    { "mv", rv_codec_i, rv_fmt_rd_rs1 },
+    { "mv", rv_codec_i, rv_fmt_rd_rs1, rvcp_mv },
     { "not", rv_codec_i, rv_fmt_rd_rs1 },
     { "neg", rv_codec_r, rv_fmt_rd_rs2 },
     { "negw", rv_codec_r, rv_fmt_rd_rs2 },
-- 
2.43.0


