Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548D3CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 03:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF0xK-0006if-1J; Thu, 08 Oct 2026 23:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prcups@krgm.moe>) id 1xF0vz-0004iD-Rb
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:13 -0400
Received: from krgm.moe ([103.47.186.116])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prcups@krgm.moe>) id 1xF0vy-0005of-2w
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 23:06:11 -0400
Received: from yuno-loong (unknown
 [IPv6:2409:8900:2684:b82:443b:7baf:6228:2a79])
 by krgm.moe (Postfix) with ESMTPSA id B26E9E002;
 Fri, 09 Oct 2026 08:35:57 +0530 (IST)
From: SignKirigami <prcups@krgm.moe>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>, SignKirigami <prcups@krgm.moe>,
 Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
Subject: [PATCH v5 20/23] target/loongarch: translate LVZ guest TLB
 instructions
Date: Fri,  9 Oct 2026 11:05:16 +0800
Message-ID: <626719625c086992885e28b019c0db2e33e2f79a.1791514848.git.prcups@krgm.moe>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1791514848.git.prcups@krgm.moe>
References: <cover.1791514848.git.prcups@krgm.moe>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=103.47.186.116; envelope-from=prcups@krgm.moe;
 helo=krgm.moe
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_PASS=-0.001,
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

Decode, disassemble and translate GTLBSRCH, GTLBRD, GTLBWR, GTLBFILL,
GTLBCLR and GTLBFLUSH for host LVZ execution.

Signed-off-by: SignKirigami <prcups@krgm.moe>
Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
---
 target/loongarch/disas.c                      |  6 ++
 target/loongarch/insns.decode                 |  7 +++
 .../tcg/insn_trans/trans_privileged.c.inc     | 60 +++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/target/loongarch/disas.c b/target/loongarch/disas.c
index 2436c9eec3..6425dea17c 100644
--- a/target/loongarch/disas.c
+++ b/target/loongarch/disas.c
@@ -700,6 +700,12 @@ INSN(tlbfill,      empty)
 INSN(tlbclr,       empty)
 INSN(tlbflush,     empty)
 INSN(invtlb,       i_rr)
+INSN(gtlbclr,      empty)
+INSN(gtlbflush,    empty)
+INSN(gtlbsrch,     empty)
+INSN(gtlbrd,       empty)
+INSN(gtlbwr,       empty)
+INSN(gtlbfill,     empty)
 INSN(cacop,        cop_r_i)
 INSN(lddir,        rr_i)
 INSN(ldpte,        j_i)
diff --git a/target/loongarch/insns.decode b/target/loongarch/insns.decode
index 4612af9433..cbcc30c31f 100644
--- a/target/loongarch/insns.decode
+++ b/target/loongarch/insns.decode
@@ -499,6 +499,13 @@ bgeu            0110 11 ................ ..... .....     @rr_offs16
   gcsrxchg          0000 0101 .............. ..... .....     @rr_csr
 }
 
+gtlbclr          0000 01100100 10000 01000 00000 00001    @empty
+gtlbflush        0000 01100100 10000 01001 00000 00001    @empty
+gtlbsrch         0000 01100100 10000 01010 00000 00001    @empty
+gtlbrd           0000 01100100 10000 01011 00000 00001    @empty
+gtlbwr           0000 01100100 10000 01100 00000 00001    @empty
+gtlbfill         0000 01100100 10000 01101 00000 00001    @empty
+
 iocsrrd_b        0000 01100100 10000 00000 ..... .....    @rr
 iocsrrd_h        0000 01100100 10000 00001 ..... .....    @rr
 iocsrrd_w        0000 01100100 10000 00010 ..... .....    @rr
diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
index 37b7ef13dc..ae481aa83f 100644
--- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
@@ -42,6 +42,12 @@ GEN_FALSE_TRANS(idle)
 GEN_FALSE_TRANS(gcsrrd)
 GEN_FALSE_TRANS(gcsrwr)
 GEN_FALSE_TRANS(gcsrxchg)
+GEN_FALSE_TRANS(gtlbclr)
+GEN_FALSE_TRANS(gtlbflush)
+GEN_FALSE_TRANS(gtlbsrch)
+GEN_FALSE_TRANS(gtlbrd)
+GEN_FALSE_TRANS(gtlbwr)
+GEN_FALSE_TRANS(gtlbfill)
 
 #else
 
@@ -339,6 +345,15 @@ static bool trans_tlbsrch(DisasContext *ctx, arg_tlbsrch *a)
     return true;
 }
 
+static bool trans_gtlbsrch(DisasContext *ctx, arg_gtlbsrch *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+    gen_helper_tlbsrch(tcg_env, tcg_constant_i32(1));
+    return true;
+}
+
 static bool trans_tlbrd(DisasContext *ctx, arg_tlbrd *a)
 {
     if (check_plv(ctx)) {
@@ -393,6 +408,51 @@ static bool trans_tlbflush(DisasContext *ctx, arg_tlbflush *a)
     return true;
 }
 
+static bool trans_gtlbrd(DisasContext *ctx, arg_gtlbrd *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+    gen_helper_tlbrd(tcg_env, tcg_constant_i32(1));
+    return true;
+}
+
+static bool trans_gtlbwr(DisasContext *ctx, arg_gtlbwr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+    gen_helper_tlbwr(tcg_env, tcg_constant_i32(1));
+    return true;
+}
+
+static bool trans_gtlbfill(DisasContext *ctx, arg_gtlbfill *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+    gen_helper_tlbfill(tcg_env, tcg_constant_i32(1));
+    return true;
+}
+
+static bool trans_gtlbclr(DisasContext *ctx, arg_gtlbclr *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+    gen_helper_tlbclr(tcg_env, tcg_constant_i32(1));
+    return true;
+}
+
+static bool trans_gtlbflush(DisasContext *ctx, arg_gtlbflush *a)
+{
+    if (check_plv(ctx) || !avail_LVZ(ctx) || is_guest_mmu_idx(ctx->mem_idx)) {
+        return false;
+    }
+    gen_helper_tlbflush(tcg_env, tcg_constant_i32(1));
+    return true;
+}
+
 static bool trans_invtlb(DisasContext *ctx, arg_invtlb *a)
 {
     TCGv rj = gpr_src(ctx, a->rj, EXT_NONE);
-- 
2.55.0


