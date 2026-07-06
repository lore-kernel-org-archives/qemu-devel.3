Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67A8DC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWb-0007g9-QJ; Mon, 06 Jul 2026 16:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWa-0007f4-Gz
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:40 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hj-Km
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 72FBE43D62;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5901CC2BCFC;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=/+aw3KY94YQLZRUTZtKQep0hejmqgJPAahDnbK29mBQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tMmc+3YzYOHLiEYQvgfnlbuF8Q2msXyLHWuqL7nJnQallFzhuoCzr2iLSmC30pRUu
 J2J9Cgtxm1q0ZmFboGsVwzIXY6nHAjTcdKE/gCby6aVQbW6L+0ZbFuLn9Brd4ZfhcI
 8qvTdRXO0prRqC+2y0IFZizZpO8yIixQCFmqqPVgmu2lo99B9Wg0+1sF8eqM9okwWM
 pmpuEs42HGhPTBXiCPRmJ2ELk3y9ay2XQZJ45/mnE+bitYtTOt6geMRCu/pbdE1KP7
 2yiqcRVE32G/Zv6lNg8vVD269Um1u3JvilHLfPX8fzcuxu3z+5my09mFfgt3m3GSIB
 FCGa8QyJiST4Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4802EC43602;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 07 Jul 2026 04:02:06 +0800
Subject: [PATCH v2 6/6] target/loongarch: vstelm: Fix reading from vector
 registers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-loong64-be-v2-6-8634f93c1dc9@gmail.com>
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
In-Reply-To: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3495;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=2iuxs5risliYf2dBgG2FUXCXbQZaaq0rhiN1iTetazE=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnYQ2//ZPQz0sCn6Kt+i4UQWMvWeLUaa0kCz
 qpXjNKgVg2JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJ2AAKCRCwMePKe/7Z
 buDfEACiHGv8hm5H9imnVFk6uM1MX/2A9+udugFDce0onU8pQHccJUFWLNJ8PvteKMh6v+3pAzS
 dx0f3LttNqvXV1MsY5H+RHsHaEo/NrdxsK6BstDanvR7tv6CidZVo/kih/NElfS/CziC5R8Eys6
 qsSuzAbn6rdg1ce/6Fi0mu3HVR0sXnB6tYgHhy2G1oAB+yOAk+iO7lPHiA3Rjt/+ZTqQuDfYDox
 CD0QfLpPG/kLhB3ztSG2dwcLwvlreBspYjjJP1A+N4/R3hW5MHPO7Mmj7TEI9OkS40xYy2L2ycj
 4Ccu6UHVRY0EfvdSUMlnL4r19TqZqjsJZ5bskJFcuimXuh1pyBOtloTsXrynK3QVtaEOw0w8cGy
 4fRIWnaujOd/RQBt25z/Gq4VZ8E7Gex5fPRWr8snTntfoEWs9JRB+9UfSc3Q4ptFBmoqOwSaRiN
 XYCCaGYsAu8sP76MM3fTZn8PYG2ccx+7Ac0o+eNe8orw2HnibmzVDPU8PQvSLlNIppmEaBc3p0s
 yOjHAriTrwzAufyk1fwNCydpqcgaphSH9fKA9vZbfVNGsEP134kxwSj9Gc5p2bafGJHKHOvLeqI
 TpP+K8rueFGBlNC0vdz2p+OhHD7jyb+gj+C/+g+l/IbjElpHw8hgRn6kuYMz85asOQ2bdp+4ROs
 KCb2aCpl2hLMR+Q==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
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
consideration. Use tcg_gen_ld<len>_i64() functions to read an integer
in certain length at a certain offset from vector registers into an i64
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



