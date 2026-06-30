Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16775C43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegl9-0003f2-O2; Tue, 30 Jun 2026 18:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegl0-0003dn-SM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vK-KM
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:42 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A3C0E43F46;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 862A9C2BCFA;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=lDGvuDM8DAJsW/DzNUwEisoVzKi/rYIhCVLSaSTWVWA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=L4gQShB3IJYb24aGlvRf8iLgijVd2+iuFKRSUDG2ymqZseF2ly1dkeREexGF+nu2y
 aCcDe2/WZT6CY2vYvtU6Eu0D25Ir8VVk0XmrrA0z5TKLemSbENFbb+YoXoV6vaAwnF
 gFwrJrduh5Q37NoUB4f7nML9TntbU794qaOlDjfUd64YXJytmtA56k9Ss7qgag3inf
 buydDtsROBURq2WFYwpvnulJddiAJBIZtzXBj260vuBRChyJY++zSQ/MwRCzz0VbLc
 kKnLJNKDU/WeGhm7xVNHGPaCi3kL/JbvIgZ8z/Y49OdGXUvElc7qooph5Zx4C80+jU
 cSK+rLGoX5vpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB4CC43327;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 01 Jul 2026 06:16:00 +0800
Subject: [PATCH 6/6] target/loongarch: vstelm: Fix reading from vector
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-loong64-be-v1-6-9c7d65e00697@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
In-Reply-To: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3494;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=w1LZlKN7nRieAuFL85XuNkbOAVyXj/vQYFGAsWAwHMw=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAm+KaHKt/kouxKGKw9jj76gAyfCrcvqzSdC
 uUnMJMODL2JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAJgAKCRCwMePKe/7Z
 buCTEADOZVsQSrUuWrKrBlkJ2am0uEJoF3ECQoKshzh6St3B7xlPyWmc8rZEmcbPqcs75//lre1
 /INAdPyZ7PTwWdsTUi+HO0uEWF06qsoSXSpx7vPEPx9VbIMEgQ8TesQ+bKcNrnnrftumHfi76Ju
 67l0OtvkK4ZHPVVUgRsCBP+BI+f26kSGazoau7JecrR1BTIasXtqAF3njRRdg1Z7YMsuBI5u9Ti
 Ecmngloj1rVWKTSblbezlRjaRxvS7envmX42ewWR7CphL+jyCaCI6YZDx7VpOJ9Ogn+MgmzY5lQ
 MA48O7xm8W3yqSe9bnaQAC8FlgpAzIvpRC5GTcdBo1WVFXfV3bTzypEY+I059RZ31jAituK44aY
 l4btG34UX2UO0yvaLR592L/nF7pCDkSzysk2oRi0kRFNjmSw/cprGXkSHpCaRafVT3H1XSqSn2R
 Z4GMNJJFjr/ZMm2FMykKetlslEAAooA4tpqsSAH87is3buiGbzLKwRUn1MfIRFMHz0QPV/ceol8
 MzmddQINj3/TrE3f5Rv/l7b91pP+PO2gFT+TuKnRKb/UExct9AB/xka4aTPar2/L4x3ILR28tZW
 ZsxzZbqTFqjMsEOgjaXHBxY0wxVPqk2rKMWapvpODszCV5aRty+FA3QagseeRsRKUKMbxZBJzkJ
 NVSKsWVXk4XMHlA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FORGED_REPLYTO=2.095, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: shankerwangmiao@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Miao Wang <shankerwangmiao@gmail.com>

When reading data from vector registers, endianess should be in
consideration. Use tcg_gen_ld<len>_i64() functions to read a integer in
certain length at a certain offset from vector registers into an i64
temporary variable. tcg_gen_ld_i64() cannot achieve this on big endian
hosts. When writing data to guest memory, endianess should also be
declared using the MO_LE flag for tcg_gen_qemu_st_i64().

Fixes: 4a26512f01e0 ("target/loongarch: Implement xvld xvst")
Fixes: 843b627a395a ("target/loongarch: Implement vld vst")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 33 ++++++++++++++-----------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 91b1e15b61cac5d119892df1abd2ecf8a4c8e59d..3cac981be1dba11db46744f88e851838aea651cd 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -5423,7 +5423,8 @@ TRANS(xvldrepl_w, LASX, do_xvldrepl, MO_32)
 TRANS(xvldrepl_d, LASX, do_xvldrepl, MO_64)
 
 static bool do_vstelm_vl(DisasContext *ctx,
-                         arg_vr_ii *a, uint32_t oprsz, MemOp mop)
+                         arg_vr_ii *a, uint32_t oprsz, MemOp mop,
+                         void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
     TCGv addr;
     TCGv_i64 val;
@@ -5436,29 +5437,31 @@ static bool do_vstelm_vl(DisasContext *ctx,
     val = tcg_temp_new_i64();
 
     addr = make_address_i(ctx, addr, a->imm);
-    tcg_gen_ld_i64(val, tcg_env, vec_reg_offset(a->vd, a->imm2, mop));
-    tcg_gen_qemu_st_i64(val, addr, ctx->mem_idx, mop);
+    func(val, tcg_env, vec_reg_offset(a->vd, a->imm2, mop));
+    tcg_gen_qemu_st_i64(val, addr, ctx->mem_idx, mop | MO_LE);
     return true;
 }
 
-static bool do_vstelm(DisasContext *ctx, arg_vr_ii *a, MemOp mop)
+static bool do_vstelm(DisasContext *ctx, arg_vr_ii *a, MemOp mop,
+                      void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
-    return do_vstelm_vl(ctx, a, 16, mop);
+    return do_vstelm_vl(ctx, a, 16, mop, func);
 }
 
-static bool do_xvstelm(DisasContext *ctx, arg_vr_ii *a, MemOp mop)
+static bool do_xvstelm(DisasContext *ctx, arg_vr_ii *a, MemOp mop,
+                       void (*func)(TCGv, TCGv_ptr, tcg_target_long))
 {
-    return do_vstelm_vl(ctx, a, 32, mop);
+    return do_vstelm_vl(ctx, a, 32, mop, func);
 }
 
-TRANS(vstelm_b, LSX, do_vstelm, MO_8)
-TRANS(vstelm_h, LSX, do_vstelm, MO_16)
-TRANS(vstelm_w, LSX, do_vstelm, MO_32)
-TRANS(vstelm_d, LSX, do_vstelm, MO_64)
-TRANS(xvstelm_b, LASX, do_xvstelm, MO_8)
-TRANS(xvstelm_h, LASX, do_xvstelm, MO_16)
-TRANS(xvstelm_w, LASX, do_xvstelm, MO_32)
-TRANS(xvstelm_d, LASX, do_xvstelm, MO_64)
+TRANS(vstelm_b, LSX, do_vstelm, MO_8,  tcg_gen_ld8u_i64)
+TRANS(vstelm_h, LSX, do_vstelm, MO_16, tcg_gen_ld16u_i64)
+TRANS(vstelm_w, LSX, do_vstelm, MO_32, tcg_gen_ld32u_i64)
+TRANS(vstelm_d, LSX, do_vstelm, MO_64, tcg_gen_ld_i64)
+TRANS(xvstelm_b, LASX, do_xvstelm, MO_8,  tcg_gen_ld8u_i64)
+TRANS(xvstelm_h, LASX, do_xvstelm, MO_16, tcg_gen_ld16u_i64)
+TRANS(xvstelm_w, LASX, do_xvstelm, MO_32, tcg_gen_ld32u_i64)
+TRANS(xvstelm_d, LASX, do_xvstelm, MO_64, tcg_gen_ld_i64)
 
 static bool gen_lasx_memory(DisasContext *ctx, arg_vr_i *a,
                             void (*func)(DisasContext *, int, TCGv))

-- 
2.49.0



