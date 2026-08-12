Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA9FC5DF65
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHV6-0008Pb-4x; Wed, 12 Aug 2026 18:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUg-0007SJ-IX
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHUd-00016A-Da
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:32:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so20734495ad.2
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786573934; x=1787178734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKy04xWnqxJ/w1mEDaTYOnGDnsSA7zl91xsEylOSPqI=;
 b=ONTz5EvXN8N6zer3BJp/8V3zhWm0lWnZGD+8fFHuZgZozExevJBOCzjfINMPMMQcBa
 aFp6aKWil0RyHkMNnjYjHVLLdE7DnMIcUE38r5g5D0N3XyjcOcKH20Vr6YEuZZb0Vbcf
 d9oMVxZ7aXJbQHGeFScHozpB1sDDQXicOcpMOo1vCA0dAzEFnDLel76RituRTmqGufEk
 5dKWf1oASt7lLkeAryo3kYMtgDwq3lobC9erZG3MKGA2/zz4ZX1jO7ErzPZ8ZyMUdby1
 lBibrAciD5Qnc3gky0uURp6+tGVLZJO4fva9RDJ3zViTUklkKIFL30x5mEUtPmQtSuVu
 9eCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786573934; x=1787178734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NKy04xWnqxJ/w1mEDaTYOnGDnsSA7zl91xsEylOSPqI=;
 b=pgoSlMdRlBSGKztKo9T99K73R6Q1uZebkHzXxl59Cc19GvqSbRioDpwD91rjh7NV0b
 Y3atrlg1o2j7ElK1t4H3VP0yRzSqzGvGTxecTCloyE1eKE+9bLfZmSdDD7oOglHlWxJK
 mL4IkCZ5tW7wRQmNjXV/aKZrXvupDn/+LsYhS5DDJoSbb5zqb080kkdnu9EW/Zcr7XIv
 s9C4gPssEenBeT7N/zeOM3YBvyc1UNott8KGAAvJ/6W19YCh/u8tPZQy241zElJLUzDF
 xiknrw8B2xSk8HCFf8RZgARpVRDnchLi0vwWipbPzx2KcZ4Q2aOY16qBFF9aZ1lp75bK
 jRAg==
X-Gm-Message-State: AOJu0YxaBuAp5eqiUWCHW1g3h1JDg045kI3UMGwMyH7OwPcGdZByEqM2
 fI3HonIdL4SUwVKTHPIXCr9uKyN3WipQZMkmlgZXcq2tvtzsVoluMVzHfb3ByPoW1eC4ai9qvYv
 XALYs
X-Gm-Gg: AR+sD12S/s8nR4YvV5D7/AMUmI0My/P3eXoUKKGjAZwl1Tek9/0TlKajANr9xGIpoXD
 Rc0YKNsXsd/Ox2wm9fK7zM/wVxVKG4tofTmPKvtdr9cc17t+DvqIQTawGmlT1quN+W5DAYsQJhq
 h4bxJCoqtQvxcRi7gdXt7O5HbzCawWncxEPo0uoj8cmFQauZHuXEiD6GY+ZVTdVgKgEj+6lLOBx
 p78xUxzoZeEvAWX+lCT2oZob8YowAlAV+21mS+lT3kHCGq0ID+CShSDVgb5gMKoG64QTz8diBy2
 bFPGT5i6e6+kNU3+nIuWuCNhFSCJge8SRQxcHHtt7p5Wa66Rghc84CMnNU8Bn/18IY0JLH5Hz26
 TJLfXc2zq3U14iykI8YsdEOZQjr7uRzRn9rfnp/6WXPxR6hSHEk60ToBjLZz9JDZ7hN0k5EJhxP
 nzEc3W0sUitw1shM8UKZ7PoK40DDPZYU+NC+hdxEuC7ND+QICQ7/rGp7i3zy8TIYFZ58B6m4me4
 kECZRXpdhnGxZ28QzFj
X-Received: by 2002:a05:6a21:6f01:b0:3c3:7179:a640 with SMTP id
 adf61e73a8af0-3cc54f4b5femr2224639637.3.1786573933896; 
 Wed, 12 Aug 2026 15:32:13 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cbef721cb0bsm212031a12.26.2026.08.12.15.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:32:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 30/52] disas/riscv: Chain "ret" pseudo off "jr" pseudo
Date: Wed, 12 Aug 2026 15:31:20 -0700
Message-ID: <20260812223142.349142-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

"jr" has already checked two conditions that apply to "ret".

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index f3c9213fd1..91f6d9e4af 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1061,8 +1061,7 @@ static const rvc_constraint rvcc_bgez[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bltz[] = { rvc_rs2_eq_x0, rvc_end };
 static const rvc_constraint rvcc_bgtz[] = { rvc_rs1_eq_x0, rvc_end };
 static const rvc_constraint rvcc_j[] = { rvc_rd_eq_x0, rvc_end };
-static const rvc_constraint rvcc_ret[] = { rvc_rd_eq_x0, rvc_rs1_eq_ra,
-                                           rvc_end };
+static const rvc_constraint rvcc_ret[] = { rvc_rs1_eq_ra, rvc_end };
 static const rvc_constraint rvcc_jr[] = { rvc_rd_eq_x0, rvc_imm_eq_zero,
                                           rvc_end };
 static const rvc_constraint rvcc_true[] = { rvc_end };
@@ -1076,12 +1075,16 @@ static const rv_comp_data rvcp_jal[] = {
 };
 
 static const rv_comp_data rvcp_jalr[] = {
-    { rv_op_ret, rvcc_ret },
     { rv_op_jr, rvcc_jr },
     { rv_op_jalr_ra, rvcc_jalr_ra },
     { },
 };
 
+static const rv_comp_data rvcp_jr[] = {
+    { rv_op_ret, rvcc_ret },
+    { },
+};
+
 static const rv_comp_data rvcp_beq[] = {
     { rv_op_beqz, rvcc_beqz },
     { },
@@ -1896,7 +1899,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { },
     { "j", rv_codec_uj, rv_fmt_offset },
     { "ret", rv_codec_i, rv_fmt_none },
-    { "jr", rv_codec_i, rv_fmt_rs1 },
+    { "jr", rv_codec_i, rv_fmt_rs1, rvcp_jr },
     { "rdcycle", rv_codec_i_csr, rv_fmt_rd },
     { "rdtime", rv_codec_i_csr, rv_fmt_rd },
     { "rdinstret", rv_codec_i_csr, rv_fmt_rd },
-- 
2.43.0


