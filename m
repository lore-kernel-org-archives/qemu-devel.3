Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12279C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7m9-0007ct-Gw; Thu, 23 May 2024 08:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sA7m7-0007aq-50; Thu, 23 May 2024 08:42:27 -0400
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sA7m4-0001at-S9; Thu, 23 May 2024 08:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1716468139; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=NmCWHDJ45R0Q1JsWlKs5SJu2/camQSDEZQGGLvLg5cw=;
 b=PXsJO0t0bQRJE/jeyw1yjUiIZOkZNcWLQ3FCrBgFxAYO/Qp/Jf5BMjJbHGsN0hkKwC3/Up5TrO95d2l+ZLrdj6sy0WiIS9jTaeW3qtZrFKaICh3mcZIyMv81F0wDzBZ+4ARVCg1but1j9d8Ch+7oOBvu1uW/ZyrSqDIY+MVs9C4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037067111;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W72zXTn_1716468136; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W72zXTn_1716468136) by smtp.aliyun-inc.com;
 Thu, 23 May 2024 20:42:18 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com
Subject: [PATCH 1/6] target/riscv: Move gen_amo before implement Zabha
Date: Thu, 23 May 2024 20:40:40 +0800
Message-Id: <20240523124045.1964-2-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
References: <20240523124045.1964-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.118;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-118.freemail.mail.aliyun.com
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
index 51dfb03685..b160bcbfe0 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1075,6 +1075,27 @@ static bool gen_unary_per_ol(DisasContext *ctx, arg_r2 *a, DisasExtend ext,
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


