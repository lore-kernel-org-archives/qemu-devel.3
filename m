Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCB24C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbL-00057N-2A; Mon, 24 Aug 2026 01:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNav-0004f2-A6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNan-0002mK-Ta
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:40 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ccf2360620so25835025ad.3
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550692; x=1788155492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hk5GZbBPE9k/cD83hwQyRHgA+R2YMqa9HODNXp3uV+Q=;
 b=dumTJJtbPLBFzjT9jPyQcOJkxxtuv0a4xeMeTEgmsN+e2vMcL6qRyc0DhqapoiFoaR
 xTasldIctSHgwN7EUAes8QsU5zlp42zQZC9dGdIlCZDB1Q3NjItr8uPraGIzl7c3qEis
 pJXOhKo4EqPsJ1iI23M+fx4qdMlznZ0hd2/9xIk7E59OWc3JxDah8YWSO4a8px1UUwnn
 Ma6uKsATrUMsewaobSec8d5l7Xoogn/m4/EFPFg0jTuFkqrk+qmiFQV8ohMRwhYV7FGH
 sRlSMPpA615XX+l6MjHnsfjHHAHmY8J9ZYwQWd4nkt6ixxDL8xMaKbBd/pVfyhnp+TyI
 O7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550692; x=1788155492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hk5GZbBPE9k/cD83hwQyRHgA+R2YMqa9HODNXp3uV+Q=;
 b=eA0T8V8dsaWGHmWUt4GP9suWCAF4tdnt2OUuPBwsHAw9pG6ozq2Zvc8bf85uiNr5Hm
 ZaVqnzR6g3rvbBmJFsPKzaJ45mOm6Qrz5qIPbctvHQL4BkGx87Sv4nSqM7kwMeddsWrO
 t+dLEZMNmRN9n4TwUz/rJKfgBQ6h8jA1A6cR6mcz7+zBLkAb/PpRL7GyCp/T1oSqvLrb
 O0xytkkaeHm05onJpM+DdVMs9rlJrVqKl1mQkkDTsjBB27JKlYArBIaiwjXRikLFuYkA
 ghTcvkpjayN61KzQyRrVas4QuR8eOduCS+OjSvuzjZQYppop+VBpAhQgUSqUeZtVZ/DK
 +w7A==
X-Gm-Message-State: AFuF++mn7SGpv03mwdklfT5QBxdyqYLSJ5GnRal1JK6A5GWfIrs0LfNo
 BuhDpfNk3OVIARlyVqlRZPiUvJ5o0Iu8a7AucVl1W8Qd7UreWqTCGaJ67VMtRg==
X-Gm-Gg: AR+sD115aeL2sVEDzupchc33uYv0kan3Sa/Fk+NoHUmEVqz1GiaodhO/SGeTuOdRUi9
 MdIww3lZJumW+uHIVheCqumPDkpzj28kDvqUHEC1yXmiknK2wt3LG9uYP/fssHORw2qUtoBQQGe
 GseVFbWk9hXAXu4j1LwBYWL0c9M5gwcXdxgU32YKDIeEE0tXMx9ZbZGaTMFyhKbasxQxJnFHEvo
 qTEBj4qgtC2YZxvtfcCVosTwrO0JZrHQSKHly0XzXNMVrOohgXyh74e0LG3ZWn3OiJ3Xq/LYWwG
 T/0OqvdDhlbW4zIP4FNr3JjLzPQx80ymYacNFv5yU/C0SiIh+a8rMhMG82qaKk1DlTln/vOEYBt
 yGulx6jmHuYD6K3TvPo6nPlLyXsm9KclC6okkGPRW+DSnrMKyomH0LY46q40jvOEAI36XyM7C01
 b3uRiG5jg51u8gLO4klcHTIUT25U7v9+bzEm1fIv6BcNRWyC2T/8/189Nsbl5CidMbfTiHkK+ZO
 xoXwQ==
X-Received: by 2002:a17:90b:1b03:b0:38e:524:8797 with SMTP id
 98e67ed59e1d1-395c39cb2damr37511368a91.13.1787550692315; 
 Sun, 23 Aug 2026 22:51:32 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:31 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 64/96] disas/riscv: Chain "nop" pseudo off "mv" pseudo
Date: Mon, 24 Aug 2026 15:47:34 +1000
Message-ID: <20260824054806.2790041-65-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x635.google.com
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

"mv" has already checked a condition that applies to "nop".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-32-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
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
2.54.0


