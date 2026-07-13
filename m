Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7909C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 03:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj7i4-0006uV-1C; Sun, 12 Jul 2026 23:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7i1-0006ty-UU
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:57 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1wj7hz-0001NG-VT
 for qemu-devel@nongnu.org; Sun, 12 Jul 2026 23:51:57 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84864086bfeso2630707b3a.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1783914714; x=1784519514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l24jeh6mL402UPS1PQ1PqKY5L+GWjbvAW1P9ttSr/yU=;
 b=DUoUDm4uIzUPTwWXg0/Uw1WVgucBOkJRhVC61H+lBTMosKw4BzqnI2T5Ap0JKNjeJe
 x9peaXXPxnGJvesnyGZ9zoM7L1k3qVpInx/+nk/fzyFaJwK6pXSUS/aH3ClRzh/p/Zty
 TmrECvV0DI2PQumoH1ueKy1ewjlhK78O2CnubfYQik47bgr/AJA92CgkmPpHXeU1ppMt
 D8nAGnApFyP1IaVSo3M2KOMhPcgb5zfSp+2AazX5Jeu2Dc8Nzea7zHDl3FGQhpUl33R5
 iq+iRcc5Ri35HZbIgTgrhxfJ29cpBa7bD3fOeWUTA2EvGlr5QeZT+BM1u37FMeMT9gtL
 QlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783914714; x=1784519514;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=l24jeh6mL402UPS1PQ1PqKY5L+GWjbvAW1P9ttSr/yU=;
 b=J9i/YNpxEu1Xot6vapAFO7InOsaQgBmJswTOqceqevZHSubBuLl7OPrxFMnhE/bQrT
 6oV/iSK+XJgDsi5IZCMv0/oBWKg8tK3fDg2BkfAecmAvO8JchsI1T34B6XqYx/fMuh3B
 c+TI82ZoL+qoJv8HLfh9aH32i/RH+kNMusbbcCiS/HwgUs8a7BHaSg3FgUvKk1RDQ6mf
 V4KQChH996iH1LoxPpp5CujdF/HGEpfiS6ZpxdXwQ3zVKo4q82CkGRXgWq5aL4X22zer
 QW+/CDmfdAN3vXMKuZINy6vcvxjbdBxMrMaf0nvPu7RJ8xho10crVUBs09RFIj8l6imT
 ogjw==
X-Gm-Message-State: AOJu0YyP8DAPCcgx7dsdg6keUTe5IsZMSJIKd395YLoN/JblT53VrDOs
 yUePVSzKI6Vv8lVKJNY/TCtKY3EdabV51n/uL8pLKe4RAOBThdBEQ6IKZNd2MGvwcvYCB0/Mz8f
 /tif+2gmQpNzZlpjyCgEen8srGwprqTAiYtCuTmZWJGJrqW6x6ikG5AhUYkTE6mbtrJf36Yn2mj
 d6ICeBVSN2zqzy0zt8quhCWtQ2FG9VF7MamlXF5dBKEwuwMyCZ
X-Gm-Gg: AfdE7ckFIjmxVzLQ19o1iCuvgH0ZOT1+HBW8IQnDpPXvd4LqRDPWcDdWGTvigQOCcVX
 zR4uqjndDfV3HqcS8Vi684ZzmMLZ9puA7H6BqyjAO9VHQFMKIR8/PzKvzHKxKqiN+YO55+RUBHs
 LAuXJaP3gUsjOPHRnuSOMiBwVV4QKJF4GYzTdu3uB0cEXo4I+ga7PnCYV9Bm2vUmDsu55QwyWr3
 Zynx5qOaFzr8Azn8ywhOcjoJXJW+ggDOdXJX733D49EbDAzZFqWor1vealCxBlcbh4MGdsHgjUV
 /etZcCmGLY9B94mG587M6bYyj9F4h41JHb+3w3FGmyC+4Rs5uOw0mjuLastR3SdoZ4iwloz4Jt3
 hcWydSTwgo8nefMqN9DDCyDwuwg/yPHGc7VfFjrsfYd0X9Hs4PmgfVDjGLBVmqNAJUi9DxzcqNz
 yizc4y4rMJnmugT5gMniA2UP3+qyzAjslf6m4jlLs=
X-Received: by 2002:a05:6a20:2d22:b0:3bf:ba48:ca88 with SMTP id
 adf61e73a8af0-3c1107650dbmr9019582637.15.1783914714118; 
 Sun, 12 Jul 2026 20:51:54 -0700 (PDT)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ca5b3162d3csm7739884a12.18.2026.07.12.20.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 20:51:53 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 qemu-riscv@nongnu.org (open list:SiFive Machines),
 Frank Chang <frank.chang@sifive.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 4/6] target/riscv: Support raising misaligned exceptions
 for scalar loads/stores
Date: Mon, 13 Jul 2026 11:51:33 +0800
Message-ID: <20260713035135.3996990-5-frank.chang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713035135.3996990-1-frank.chang@sifive.com>
References: <20260713035135.3996990-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x436.google.com
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
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/tcg/insn_trans/trans_rvi.c.inc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/tcg/insn_trans/trans_rvi.c.inc b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
index e47b16a7fa2..cc1b5dbbadc 100644
--- a/target/riscv/tcg/insn_trans/trans_rvi.c.inc
+++ b/target/riscv/tcg/insn_trans/trans_rvi.c.inc
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


