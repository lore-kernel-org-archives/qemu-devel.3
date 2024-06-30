Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BCAC30658
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 03:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNkyZ-000225-4V; Sat, 29 Jun 2024 23:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkyX-0001wy-2l; Sat, 29 Jun 2024 23:11:37 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sNkyT-0003fb-E0; Sat, 29 Jun 2024 23:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1719717087; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=JRkqR6/eZRMlTs55tGZLATZUWldX16TVXcbCs7HC4VM=;
 b=kzAVHvuyFSel5eNnTu7qiinnJGodWnxS9zOXXBhDBCn7ekH0iEtBbfe0uXdBYVYXqOIgPR7KEWouPdgoAd9aY+93+IxlSX7Vghfar3G2R0LNKNTIXJtvqUr5Slwh79BVM3P54eVuf8y3B462gaHaQX62vk88bvUmRcr5/sdvvQE=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033032014031;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0W9UUhmG_1719717086; 
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W9UUhmG_1719717086) by smtp.aliyun-inc.com;
 Sun, 30 Jun 2024 11:11:27 +0800
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH v2 07/11] target/riscv: Add AMO instructions for Zabha
Date: Sun, 30 Jun 2024 11:05:55 +0800
Message-Id: <20240630030559.877-8-zhiwei_liu@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
References: <20240630030559.877-1-zhiwei_liu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
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
 target/riscv/cpu_cfg.h                      |   1 +
 target/riscv/insn32.decode                  |  20 +++
 target/riscv/insn_trans/trans_rvzabha.c.inc | 131 ++++++++++++++++++++
 target/riscv/translate.c                    |   4 +-
 4 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzabha.c.inc

diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
index ddbfae37e5..120905a254 100644
--- a/target/riscv/cpu_cfg.h
+++ b/target/riscv/cpu_cfg.h
@@ -84,6 +84,7 @@ struct RISCVCPUConfig {
     bool ext_zaamo;
     bool ext_zacas;
     bool ext_zama16b;
+    bool ext_zabha;
     bool ext_zalrsc;
     bool ext_zawrs;
     bool ext_zfa;
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 972a1e8fd1..8a4801d442 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -1021,3 +1021,23 @@ amocas_q    00101 . . ..... ..... 100 ..... 0101111 @atom_st
 # *** Zimop may-be-operation extension ***
 mop_r_n     1 . 00 .. 0111 .. ..... 100 ..... 0111011 @mop5
 mop_rr_n    1 . 00 .. 1 ..... ..... 100 ..... 0111011 @mop3
+
+# *** Zabhb Standard Extension ***
+amoswap_b  00001 . . ..... ..... 000 ..... 0101111 @atom_st
+amoadd_b   00000 . . ..... ..... 000 ..... 0101111 @atom_st
+amoxor_b   00100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoand_b   01100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoor_b    01000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomin_b   10000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomax_b   10100 . . ..... ..... 000 ..... 0101111 @atom_st
+amominu_b  11000 . . ..... ..... 000 ..... 0101111 @atom_st
+amomaxu_b  11100 . . ..... ..... 000 ..... 0101111 @atom_st
+amoswap_h  00001 . . ..... ..... 001 ..... 0101111 @atom_st
+amoadd_h   00000 . . ..... ..... 001 ..... 0101111 @atom_st
+amoxor_h   00100 . . ..... ..... 001 ..... 0101111 @atom_st
+amoand_h   01100 . . ..... ..... 001 ..... 0101111 @atom_st
+amoor_h    01000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomin_h   10000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomax_h   10100 . . ..... ..... 001 ..... 0101111 @atom_st
+amominu_h  11000 . . ..... ..... 001 ..... 0101111 @atom_st
+amomaxu_h  11100 . . ..... ..... 001 ..... 0101111 @atom_st
diff --git a/target/riscv/insn_trans/trans_rvzabha.c.inc b/target/riscv/insn_trans/trans_rvzabha.c.inc
new file mode 100644
index 0000000000..9093a1cfc1
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzabha.c.inc
@@ -0,0 +1,131 @@
+/*
+ * RISC-V translation routines for the Zabha Standard Extension.
+ *
+ * Copyright (c) 2024 Alibaba Group
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
+
+#define REQUIRE_ZABHA(ctx) do {           \
+    if (!ctx->cfg_ptr->ext_zabha) {       \
+        return false;                     \
+    }                                     \
+} while (0)
+
+static bool trans_amoswap_b(DisasContext *ctx, arg_amoswap_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_SB);
+}
+
+static bool trans_amoadd_b(DisasContext *ctx, arg_amoadd_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_SB);
+}
+
+static bool trans_amoxor_b(DisasContext *ctx, arg_amoxor_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_SB);
+}
+
+static bool trans_amoand_b(DisasContext *ctx, arg_amoand_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_SB);
+}
+
+static bool trans_amoor_b(DisasContext *ctx, arg_amoor_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_SB);
+}
+
+static bool trans_amomin_b(DisasContext *ctx, arg_amomin_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_SB);
+}
+
+static bool trans_amomax_b(DisasContext *ctx, arg_amomax_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_SB);
+}
+
+static bool trans_amominu_b(DisasContext *ctx, arg_amominu_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_SB);
+}
+
+static bool trans_amomaxu_b(DisasContext *ctx, arg_amomaxu_b *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_SB);
+}
+
+static bool trans_amoswap_h(DisasContext *ctx, arg_amoswap_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESW);
+}
+
+static bool trans_amoadd_h(DisasContext *ctx, arg_amoadd_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_add_tl, MO_TESW);
+}
+
+static bool trans_amoxor_h(DisasContext *ctx, arg_amoxor_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_xor_tl, MO_TESW);
+}
+
+static bool trans_amoand_h(DisasContext *ctx, arg_amoand_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_and_tl, MO_TESW);
+}
+
+static bool trans_amoor_h(DisasContext *ctx, arg_amoor_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_or_tl, MO_TESW);
+}
+
+static bool trans_amomin_h(DisasContext *ctx, arg_amomin_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smin_tl, MO_TESW);
+}
+
+static bool trans_amomax_h(DisasContext *ctx, arg_amomax_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_smax_tl, MO_TESW);
+}
+
+static bool trans_amominu_h(DisasContext *ctx, arg_amominu_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umin_tl, MO_TESW);
+}
+
+static bool trans_amomaxu_h(DisasContext *ctx, arg_amomaxu_h *a)
+{
+    REQUIRE_ZABHA(ctx);
+    return gen_amo(ctx, a, &tcg_gen_atomic_fetch_umax_tl, MO_TESW);
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 133550d6e2..4a3e786560 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1083,8 +1083,9 @@ static bool gen_amo(DisasContext *ctx, arg_atomic *a,
 {
     TCGv dest = dest_gpr(ctx, a->rd);
     TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
+    MemOp size = mop & MO_SIZE;
 
-    if (ctx->cfg_ptr->ext_zama16b) {
+    if (ctx->cfg_ptr->ext_zama16b && size >= MO_32) {
         mop |= MO_ATOM_WITHIN16;
     } else {
         mop |= MO_ALIGN;
@@ -1118,6 +1119,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvb.c.inc"
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzacas.c.inc"
+#include "insn_trans/trans_rvzabha.c.inc"
 #include "insn_trans/trans_rvzawrs.c.inc"
 #include "insn_trans/trans_rvzicbo.c.inc"
 #include "insn_trans/trans_rvzimop.c.inc"
-- 
2.25.1


