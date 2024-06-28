Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A6C30658
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 18:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNFvL-00047s-0B; Fri, 28 Jun 2024 14:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFvG-00047T-FY
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:02:10 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sNFvE-0001y2-Gb
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 14:02:10 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7067435d376so674225b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719597726; x=1720202526;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4UNuLrnsqrqpceV4ps+gzasQN/xbW2gCCwaF7vdPSQE=;
 b=Frx+mgg60F8pQZfc58qDOvmzY9IkV4/sLWMMxQ1OOhNd5BBU0ahS6+985iB2yHcCiu
 85av1NeKArD1G6rOMB5JWiC5JytMsqZ6v1V0bp3fzEKT+SqduosrwSaRw0uHrRiGLgW0
 hw0elFZTQv5iLbpkaJ2M2OuWMvcitRtLBcwft37slXh9qn3qcg3flo+kK8EDYv9Tvo/p
 fd7CPeaVtPYA7UcCGQKevAZzBJNDTiT/3zGEvo8czfrYD55zitURXzTkLAj0MDWECr6a
 3X0R17J2xgmCV4ye7g6IEKOffy5ax/0KkIfbD6ZDFbsEKR88Omz7RyI98rZF42eRMEmo
 2dIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719597726; x=1720202526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4UNuLrnsqrqpceV4ps+gzasQN/xbW2gCCwaF7vdPSQE=;
 b=M/GRnI30iI+kQt1/NZNJKA/XRg6sTFi31d6zD5zMVsWHzRzk70/5FoUmoZSQl1b+eg
 dYIDRR4qGIn/RrC2en5uUzdtQmhZ39eGI+UApyTJgKJDQttIeDWsFLj7Qt3o6t4gGvSn
 o5G+mYt5wzIWRjgbWhBLRyjinNib+Al2Paigg7ojszqShtt12zFNLkD6/DAXtE86SmdA
 thNI404F9cuzO5qit32OqyqtLPBO5jW5Yytk95mEMHChoaq9uCluZbg081n8Ss0C6xfb
 MDkRGH11z6MNsqdfUcvzBRqYWfimC3CPsSJbAoXPhWdb6CrIEKt/EbZsyxDm53DyrEJX
 begQ==
X-Gm-Message-State: AOJu0YwAZ4FR+trpk1MbW1P2v4chqBeOrHhmTKzqGVbmhQ6YtkXPObA6
 X9zeSiLVXlvR2ZPNIK6ViodHWpzpKN57D/6Ulx4vDDm7YYSHQXAtoz+3SR6HYRD0qKYo+oZ0tdh
 w
X-Google-Smtp-Source: AGHT+IGmw0vs8ADXXSdmG+ZXSSRdptWXJo+l+SNlyiRYlyMPAExughHuPA35xxj8sA9sWSPBP3ZjgQ==
X-Received: by 2002:a05:6a21:10f:b0:1bd:2216:eafe with SMTP id
 adf61e73a8af0-1bee497c50dmr3014556637.24.1719597726105; 
 Fri, 28 Jun 2024 11:02:06 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70842036d13sm1752053b3a.98.2024.06.28.11.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 11:02:05 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Deepak Gupta <debug@rivosinc.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs)
Subject: [PATCH 2/3] target/riscv: zimop instruction encoding and its
 implementation
Date: Fri, 28 Jun 2024 11:01:53 -0700
Message-Id: <20240628180154.597919-2-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240628180154.597919-1-debug@rivosinc.com>
References: <qemu-riscv@nongnu.org>
 <20240628180154.597919-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch adds assigned codepoints for decoder for 32bit instructions
and provide implementation for instruction. If extension is present,
then moves 0 to `rd`.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 target/riscv/insn32.decode                 | 15 +++++++
 target/riscv/insn_trans/trans_zimops.c.inc | 50 ++++++++++++++++++++++
 target/riscv/translate.c                   |  3 ++
 3 files changed, 68 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_zimops.c.inc

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index f22df04cfd..fca3838a9f 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -167,6 +167,21 @@ csrrwi   ............     ..... 101 ..... 1110011 @csr
 csrrsi   ............     ..... 110 ..... 1110011 @csr
 csrrci   ............     ..... 111 ..... 1110011 @csr
 
+# zimops (unpriv integer may be operations) instructions with system opcode
+# zimops_r and zimops_rr are two code points assigned to zimops
+# Any new extension that claims zimops encoding should be placed above mop.r
+# and mop.rr
+
+# mop.r
+{
+  zimops_r   1-00--0 111--     ----- 100 ..... 1110011 %rd
+}
+
+# mop.rr
+{
+  zimops_rr  1-00--1 -----     ----- 100 ..... 1110011 %rd
+}
+
 # *** RV64I Base Instruction Set (in addition to RV32I) ***
 lwu      ............   ..... 110 ..... 0000011 @i
 ld       ............   ..... 011 ..... 0000011 @i
diff --git a/target/riscv/insn_trans/trans_zimops.c.inc b/target/riscv/insn_trans/trans_zimops.c.inc
new file mode 100644
index 0000000000..b5ad7bded8
--- /dev/null
+++ b/target/riscv/insn_trans/trans_zimops.c.inc
@@ -0,0 +1,50 @@
+/*
+ * RISC-V translation routines for the Control-Flow Integrity Extension
+ *
+ * Copyright (c) 2024 Rivos Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2 or later, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+static bool trans_zimops_r(DisasContext *ctx, arg_zimops_r * a)
+{
+    /* zimops not implemented, raise illegal instruction & return true */
+    if (!ctx->cfg_ptr->ext_zimops) {
+        gen_exception_illegal(ctx);
+        return true;
+    }
+    /*
+     * zimops implemented, simply grab destination and mov zero.
+     * return true
+     */
+    TCGv dest = dest_gpr(ctx, a->rd);
+    dest = tcg_constant_tl(0);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
+static bool trans_zimops_rr(DisasContext *ctx, arg_zimops_r * a)
+{
+    /* zimops not implemented, raise illegal instruction & return true */
+    if (!ctx->cfg_ptr->ext_zimops) {
+        gen_exception_illegal(ctx);
+        return true;
+    }
+    /*
+     * zimops implemented, simply grab destination and mov zero.
+     * return true
+     */
+    TCGv dest = dest_gpr(ctx, a->rd);
+    dest = tcg_constant_tl(0);
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 2c27fd4ce1..b7fd3456c8 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1115,6 +1115,9 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 /* Include decoders for factored-out extensions */
 #include "decode-XVentanaCondOps.c.inc"
 
+/* Include decoder for zimop */
+#include "insn_trans/trans_zimops.c.inc"
+
 /* The specification allows for longer insns, but not supported by qemu. */
 #define MAX_INSN_LEN  4
 
-- 
2.34.1


