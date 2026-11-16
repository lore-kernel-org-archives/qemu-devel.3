Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136C3606A33D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=iPBSbBtg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3Dt-0004Yk-QQ; Mon, 16 Nov 2026 15:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Da-0003u2-Ah; Mon, 16 Nov 2026 15:22:25 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3DY-0003Y2-FW; Mon, 16 Nov 2026 15:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860372; bh=j8B3TzZs8oyulpA9MaIVVWRohtN8E10aaXg7Qw6DBzc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iPBSbBtgkDrJnRZrDz7PFXN/Qa2qq3aI2eP3Isrq8qUwEfYezXfvyJ+CidkX4lbtw
 wpWU8wyzPm/DMSCd++T0uXhjAFczXKL6p5nJyBR1+wt8za5kzRa1ERukXJ2l46XuLf
 1l/zCkdk+Rrr9TUGBC5HUuW7hIhjt+Hrq6z8LX5uc3KabhoPQk37lbfv+CwpW3tUro
 QWmm5B38Y4E0rwkVulq1ZNL31wPB3yhNCp7W1EmiruNeUOovrDPz6fzK0jWqt4ulHH
 SyEzQ2QZN8P9hg5sCDTPE5GBp7izJrZVXaliDhGoDpb+WqnovGlKq7whK/rllGsLTK
 jT32VUdPohNvA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 99C081E7158;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9657F45FB91;
 Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5DCFEB8E12; Mon, 16 Nov 2026 23:19:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Xianglai Li <lixianglai@loongson.cn>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 34/59] target/loongarch: Fix memory access address
 with fldle
Date: Mon, 16 Nov 2026 23:18:38 +0300
Message-ID: <20261116201922.534306-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Bibo Mao <maobibo@loongson.cn>

With instruction fldle, similar with ldle instruction, address of accessed
memory should come from register rj rather than rj + rk,. The same with
instruction fldgt/fstle/fstgt.

Cc: qemu-stable@nongnu.org
Fixes: 34423c019419 ("target/loongarch: Extract make_address_x() helper")
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Reviewed-by: Xianglai Li <lixianglai@loongson.cn>
(cherry picked from commit 94c862925d3c0518209f8856031d3785fe87e2e6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
index 79da4718a56..0b48b08fac7 100644
--- a/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_fmemory.c.inc
@@ -82,7 +82,7 @@ static bool gen_fload_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtgt_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -100,7 +100,7 @@ static bool gen_fstore_gt(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtgt_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
@@ -116,7 +116,7 @@ static bool gen_fload_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtle_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_ld_tl(dest, addr, ctx->mem_idx, mop);
     maybe_nanbox_load(dest, mop);
     set_fpr(a->fd, dest);
@@ -134,7 +134,7 @@ static bool gen_fstore_le(DisasContext *ctx, arg_frr *a, MemOp mop)
     CHECK_FPE;
 
     gen_helper_asrtle_d(tcg_env, src1, src2);
-    addr = make_address_x(ctx, src1, src2);
+    addr = make_address_i(ctx, src1, 0);
     tcg_gen_qemu_st_tl(src3, addr, ctx->mem_idx, mop);
 
     return true;
-- 
2.47.3


