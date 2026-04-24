Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482DCFE5202
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 10:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGDlh-0005Ny-St; Fri, 24 Apr 2026 06:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDle-0005Mu-9z
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:15 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wGDlc-0006Pa-QT
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 06:28:14 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2b25cf1b5f0so42614175ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 03:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1777026491; x=1777631291; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSw8kImgt+V5S5xBZme5dHEoqer3BY93L/cOLcV0R+Q=;
 b=IRPiZdwsxVV9LnGoDcDhg/zLbFk67nktZe6XPDv/+aYhnEvU3Rnw16psiUMMt+H2co
 nAjeOiwvglnpeA1kr/rmnZUWY1SN9HU1296seRaNZsz/diSFZTEZ3vBRNEpy2wJNbv6B
 0gYwvTTtBUoCOkYVD+1nVhIRLTagRPmeu3DeDapHN3g/CwuKndTiVz3AKQhEjAewyJZ3
 EJkESIKoGjKwR6x0ujB106eaugVkslaixuhB87wgzP0h+GPA2RkHvGajl2fqxg6GY3CU
 pKARNMcvy5zG5MqTuBoKdXh62DzsukHPq262NLwEei6NosCVeRFJXBqXC/1mlWbu7vDm
 lBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777026491; x=1777631291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pSw8kImgt+V5S5xBZme5dHEoqer3BY93L/cOLcV0R+Q=;
 b=cGHrVD9thTNu8+flHsl0e6E4wGdvLTJoXZkarmjNFdbi1//hvaiKKSv4BHu5xYS2vM
 QM+0KUQ3ZwnluhPWbQUKJwd3oylsR/zGVoj6+U6BJRB8YOI9oKrw4jyho2UvybXuS1o9
 DgSxE2valvOMm6J4m6BuokIgFb3KHkYCvIQ8ar5jtMONxbAKjzO+eGx3PBbwhkaeU1xd
 3kMnfZQOim6iFkNMMfFTcQmD7sLCPjxswPnBqd4iS/36QA5bl1Z9oufaBCAvZhs9sKyA
 V7KBhZ5rueRjyYQma0IdSJc2Ya+kBTmjFewMmpov+s+PzhPtS7mPf0RKyqYImsfJNWv0
 xS1g==
X-Gm-Message-State: AOJu0YxxBctltA5dHYXutzG+q1ohvS6EUrZ6d6R6Ug/9zdXLljcQQPtS
 Pu9/LlWSbYSvq9mhqNnHstIiL+hLLU/sWm4AVTzld7djgz46NwstaE7bCwR3o1G1dfJ2gq68GSB
 d+CQ83CHjnzF7s07hDsBSg37sbrbgXSlqhYCWd7dN2ykhwIpt8t6XXmAtzsVMtUNKIvF40cJ4aa
 mRHJ3ObCSz+u5A18pdD5eipNcyqK197/enrXuBbiwA1Ai1kKfC
X-Gm-Gg: AeBDievUB7k2eRpMLJEBIHBOdcwf8qlKLL1AQM4u99OKN9Fg5zDgS7C/SssgT3s4CCF
 A9Qr/jJfe9C49K9tFAuNmdJkqCcPI4yag0e1GdhpB6YZVZGDn6ZKGj+x9KgdplbLD6QG4QI6n7a
 4D3avAIPTmhWLOaJu+Q1BJIaZEpJZLw3lAMh7dl0LlZrWIVfxN15qW3LQq8r0zxi2oH2TpxnobW
 26eyjNte5RZB18Gcmghw63pGh+taIdluDUFZFuxnC5YS13tUeui99zbknwckN3JfXTQArXafv6n
 +E+qyBy4OXk19sZLcavP2sW3fNNfiqSPwMLU6/u4tT9+gBfiV2c7P9bIOk6X0Y9l60S0huLtUJ8
 pfhQklq5KhJCAlCNKestpC0EI3vlh6YrOiArZ1i4YldWSum8HpVHcaxxnamxY3hKPdJkn9D/PAT
 eIZogoWU++bCFwALL8rdblvPr79IYrRCQcuPkz/Qk0Tdb4w3SLQ1B35UBTupte
X-Received: by 2002:a17:903:2291:b0:2b4:678c:5f27 with SMTP id
 d9443c01a7336-2b5f9f3c5cbmr339255175ad.34.1777026490702; 
 Fri, 24 Apr 2026 03:28:10 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0c17esm218889585ad.41.2026.04.24.03.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 03:28:10 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 qemu-riscv@nongnu.org (open list:RISC-V TCG CPUs),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>
Subject: [PATCH 2/4] target/riscv: Support raising misaligned exceptions for
 scalar loads/stores
Date: Fri, 24 Apr 2026 18:27:58 +0800
Message-ID: <20260424102800.24022-3-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424102800.24022-1-frank.chang@sifive.com>
References: <20260424102800.24022-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=frank.chang@sifive.com; helo=mail-pl1-x632.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When the Zicclsm extension is not enabled, raise misaligned load/store
exceptions for misaligned accesses from scalar load/store instructions.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/insn_trans/trans_rvi.c.inc b/target/riscv/insn_trans/trans_rvi.c.inc
index 2c82ae41a77..2662fc5c2a2 100644
--- a/target/riscv/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/insn_trans/trans_rvi.c.inc
@@ -413,6 +413,9 @@ static bool gen_load(DisasContext *ctx, arg_lb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         out = gen_load_i128(ctx, a, memop);
@@ -524,6 +527,9 @@ static bool gen_store(DisasContext *ctx, arg_sb *a, MemOp memop)
     if (ctx->cfg_ptr->ext_zama16b) {
         memop |= MO_ATOM_WITHIN16;
     }
+    if (!ctx->cfg_ptr->ext_zicclsm) {
+        memop |= MO_ALIGN;
+    }
     decode_save_opc(ctx, 0);
     if (get_xl(ctx) == MXL_RV128) {
         return gen_store_i128(ctx, a, memop);
-- 
2.43.0


