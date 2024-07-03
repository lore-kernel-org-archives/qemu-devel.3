Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6950C3065C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 01:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOp9Z-0007bD-KI; Tue, 02 Jul 2024 21:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOp9Y-0007au-G1; Tue, 02 Jul 2024 21:51:24 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sOp9R-0005La-0f; Tue, 02 Jul 2024 21:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719971471; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=0wPsBrD35wauTRFhducDNBmSO5QKrmpP4VmzH4XvJBU=;
 b=plzM3Nqx3DsYs6XW+A/vxwY7i+c9LT1fz07FrgQpdUkgR0jDPH6l+tiIrGcZzNhirUgf9yHBYEwLlEonlPriBLE9Y2B5tFuOD7zA3/3HJw96vBnh9m8cnMAOjAEr2PTImh25plQ8rSec7uc0Mm8a6YQTKaulhpdh85ZxgpVQ7Zs=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067113;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9kB2St_1719971469; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9kB2St_1719971469) by smtp.aliyun-inc.com;
 Wed, 03 Jul 2024 09:51:10 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v3 06/11] target/riscv: Move gen_amo before implement Zabha
Date: Wed,  3 Jul 2024 09:46:30 +0800
Message-Id: <20240703014635.1020-7-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
References: <20240703014635.1020-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.130;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-130.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn_trans/trans_rva.c.inc | 21 ---------------------
 target/riscv/translate.c                | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
index eb080baddd..39bbf60f3c 100644
--- a/target/riscv/insn_trans/trans_rva.c.inc
+++ b/target/riscv/insn_trans/trans_rva.c.inc
@@ -96,27 +96,6 @@ static bool gen_sc(DisasContext *ctx, arg_atomic *a, MemOp mop)
     return true;
 }
 
-static bool gen_amo(DisasContext *ctx, arg_atomic *a,
-                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
-                    MemOp mop)
-{
-    TCGv dest = dest_gpr(ctx, a->rd);
-    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
-
-    if (ctx->cfg_ptr->ext_zama16b) {
-        mop |= MO_ATOM_WITHIN16;
-    } else {
-        mop |= MO_ALIGN;
-    }
-
-    decode_save_opc(ctx);
-    src1 = get_address(ctx, a->rs1, 0);
-    func(dest, src1, src2, ctx->mem_idx, mop);
-
-    gen_set_gpr(ctx, a->rd, dest);
-    return true;
-}
-
 static bool trans_lr_w(DisasContext *ctx, arg_lr_w *a)
 {
     REQUIRE_A_OR_ZALRSC(ctx);
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 8a546f4ece..133550d6e2 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1077,6 +1077,27 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
     return gen_unary(ctx, a, ext, f_tl);
 }
 
+static bool gen_amo(DisasContext *ctx, arg_atomic *a,
+                    void(*func)(TCGv, TCGv, TCGv, TCGArg, MemOp),
+                    MemOp mop)
+{
+    TCGv dest = dest_gpr(ctx, a->rd);
+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+
+    if (ctx->cfg_ptr->ext_zama16b) {
+        mop |= MO_ATOM_WITHIN16;
+    } else {
+        mop |= MO_ALIGN;
+    }
+
+    decode_save_opc(ctx);
+    src1 = get_address(ctx, a->rs1, 0);
+    func(dest, src1, src2, ctx->mem_idx, mop);
+
+    gen_set_gpr(ctx, a->rd, dest);
+    return true;
+}
+
 static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
-- 
2.25.1


