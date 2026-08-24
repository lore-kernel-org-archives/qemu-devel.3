Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19873C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNbY-0005TP-9v; Mon, 24 Aug 2026 01:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNak-0004S9-1O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:30 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNaS-0002ai-PP
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:51:16 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2ceaf8a1265so34609825ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550668; x=1788155468; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YtA6CjFYKwQR207w18iiKRkmLC1dp+/klVeKoHfdRLU=;
 b=lmZatTgMJRBCD9ulVgXD6iIh783WHR55THQUX01xkGvXd+cpu8sAoCLV2pQA9DxaSx
 qpy3TdNI9ln61tZxfa4jbL1yFwYRjxxVUru7pUT/QHnfmIFFKJET2e+X3nZaXmwMtLW9
 ziP00h1nX3upsQIEKpJsnu9pUwEE06GNzS/+IYMjqg9PVXAh4ROegIpgazDmYREfQyDO
 s1zO/e3+8duiHGQSLHq4Ki3Gbigynu6Ovg8Q+1eTnyf1CVSeWfVK0dLBcQ0vAsDp9PMl
 NGt4P9BxIdEV8Ir3VMdi2vvamaFWHA+q35Tv74KlTELjG0zl9X+iiXlJ05zO2M4idhBM
 DxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550668; x=1788155468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YtA6CjFYKwQR207w18iiKRkmLC1dp+/klVeKoHfdRLU=;
 b=dd4IQOkKz1Ay/sBnzpySCMTJwZAqHI/CuB+v6cBMz92W1UwCEjivheWm40bW0IrV9z
 pbtA4JppA5Nhsdl13XjpS8pPJ17JaF0Gx/eNrN73A8kZ9kCY1Iztd4Y2O29ltl1yVtUC
 tNzNmfb/XYGT7Hz+IRvQPAQJ2hLGFxFtGGJ1GT2SOEtFMsA3ngvB9Knzghvoj8sXbFTN
 7NLMPtoSaPj1YCHOp7PgPIc5dxASBdEBqWq0YSGZEqgAlZbGgBuZci2Ho+pgfWuhQ+zJ
 7ke73sGP7E9pEDrks7L0kh04K5X/iOnSkqcL1qm7nk9PYZfa7InfbNPuH05axfeIUPwV
 abLA==
X-Gm-Message-State: AFuF++lg/kxOaL0xndAVnynkHYcGyWINv7/+kmaH2TmUFaRVqtDDCVKQ
 8eL0NR6mUa7srfU5XWvFUeD6vBlsSSF+SdMpuTwMeGdP/YyE6FBYFJcB73WhuQ==
X-Gm-Gg: AR+sD13/6gyqr6p2iQX6WBxNv69Bfqhixxi1QvuaizziWSUGJOwq+Ad4cjEPqpXocyY
 vcwRdZOyR9bRhdcNZT9+Qb0GZjRL5xzt4GCVTVjJYlqU6uvTU/ZfZP+CdILv9pPjEL7SvMQwPZ0
 4oPjJx680238UWMCoEw5YlyA74mptpG9wUKCTEEJ/GZF272t/g13cz0VqErUDWCJMgwiHDBwn4L
 ruHPQgUz5uyZGXo+XWg7fNIk6hJk83sCGJHch9bpDVHFGtYwnUmYHDmBuh5EdoSg/BVCuqgnGkM
 vMV/CE8YWcjjNXGXajILHe33MUZwYNxAPfFlrouxZ6hWTq0/icu44siExy3KN9U52MSfJqKMlqa
 W9CO7ou1t+yfj5KPay+Nca0CT5HwfcrMt9IsvSaaBV5Y3YUGc5tnLeiriJkwYxsAhneROENLjrx
 gdKexx8FWy5RjIg84cpSNsPivki0xSJDyjz3t+Q6FVaTbnXtNgdbhOz/xq9fad9VFSvKq2xLxMb
 E0TTQ==
X-Received: by 2002:a17:90b:33c8:b0:38f:57f0:1f5d with SMTP id
 98e67ed59e1d1-395c397f4ecmr38569031a91.15.1787550667581; 
 Sun, 23 Aug 2026 22:51:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.51.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:51:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 55/96] disas/riscv: Handle aliases of csrrw during decode
Date: Mon, 24 Aug 2026 15:47:25 +1000
Message-ID: <20260824054806.2790041-56-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x631.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-23-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index bde1cc6e62..e464b8b075 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -1081,9 +1081,6 @@ static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002,
                                             rvc_end };
 static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001,
                                                rvc_end };
-static const rvc_constraint rvcc_fscsr[] = { rvc_csr_eq_0x003, rvc_end };
-static const rvc_constraint rvcc_fsrm[] = { rvc_csr_eq_0x002, rvc_end };
-static const rvc_constraint rvcc_fsflags[] = { rvc_csr_eq_0x001, rvc_end };
 static const rvc_constraint rvcc_fsrmi[] = { rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_fsflagsi[] = { rvc_csr_eq_0x001, rvc_end };
 
@@ -1166,14 +1163,6 @@ static const rv_comp_data rvcp_subw[] = {
     { rv_op_illegal, NULL }
 };
 
-static const rv_comp_data rvcp_csrrw[] = {
-    { rv_op_fscsr, rvcc_fscsr },
-    { rv_op_fsrm, rvcc_fsrm },
-    { rv_op_fsflags, rvcc_fsflags },
-    { rv_op_illegal, NULL }
-};
-
-
 static const rv_comp_data rvcp_csrrs[] = {
     { rv_op_rdcycle, rvcc_rdcycle },
     { rv_op_rdtime, rvcc_rdtime },
@@ -1761,7 +1750,7 @@ static const rv_opcode_data rvi_opcode_data[] = {
     { "sfence.vm", rv_codec_r, rv_fmt_rs1 },
     { "sfence.vma", rv_codec_r, rv_fmt_rs1_rs2 },
     { "wfi", rv_codec_none, rv_fmt_none },
-    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrw },
+    { "csrrw", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrs", rv_codec_i_csr, rv_fmt_rd_csr_rs1, rvcp_csrrs },
     { "csrrc", rv_codec_i_csr, rv_fmt_rd_csr_rs1 },
     { "csrrwi", rv_codec_i_csr, rv_fmt_rd_csr_zimm, rvcp_csrrwi },
@@ -4443,7 +4432,14 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
                     break;
                 }
                 break;
-            case 1: op = rv_op_csrrw; break;
+            case 1:
+                switch (operand_csr12(inst)) {
+                case 1: op = rv_op_fsflags; break;
+                case 2: op = rv_op_fsrm; break;
+                case 3: op = rv_op_fscsr; break;
+                default: op = rv_op_csrrw; break;
+                }
+                break;
             case 2: op = rv_op_csrrs; break;
             case 3: op = rv_op_csrrc; break;
             case 4:
-- 
2.54.0


