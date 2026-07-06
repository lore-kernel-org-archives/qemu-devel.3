Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEF1C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgpWb-0007ft-DV; Mon, 06 Jul 2026 16:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWZ-0007eE-88
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:39 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wgpWX-0005hi-Kd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:02:38 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 681A14374A;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C4CDC2BCFA;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1783368155;
 bh=9jtdAJLDhsYuDncra+S57koe5yikmfUxAXGVK0hCzSM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=LE7Pc8c8RB7K8kM2eo7BYM7VWC816P88B/Jc7nu35gsr9CUnV/iTkNadPxES4h+Qy
 9lkXBFyQgQIWW4GPwhZaO/YEQ03tQDGWBUw04AXQiJAjzYPLSM/SDNBGfPi86d8uH1
 JYLZhwTPkd9WeoZVA0XpWdPveXRY/TIMj01wHeOTXh0iSniaDy2TRhcplhviDOCkl0
 Ss3BTC3dVedcbDaDDm56UtCQcVc+Bsyxxy+0SF64aih6pz/7fXHXGW4HNpjGAuIg1h
 4pgNGjNsKDDnCgy1rio+DBTLNwQJmVT+YKXI30vKFSyVR19A+TTxQBu3XLsb4JIaPU
 vlrXrK544hQgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 398EAC43458;
 Mon,  6 Jul 2026 20:02:35 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Tue, 07 Jul 2026 04:02:05 +0800
Subject: [PATCH v2 5/6] target/loongarch: do_vldrepl_vl: Fix endianness
 when reading from guest memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-loong64-be-v2-5-8634f93c1dc9@gmail.com>
References: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
In-Reply-To: <20260707-loong64-be-v2-0-8634f93c1dc9@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=RtvkqLT2lF+j/y7Kk8Hb/ToTorcK/6EJPDqknnL+4/4=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqTAnYI+bqkC6gGNAr40pvc+CXTiQU+Y5uUvjEr
 aN15vBtPxqJAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakwJ2AAKCRCwMePKe/7Z
 bvB/D/9bjkFMJ3sFx1LJDz9/e20Eo07D7IBG7qg7aporvf6hwXMrEkbMLUJimU+TboYwBxkn3WZ
 xzrgHOS9P5cXiE0YpV5hhDg7i45qGPaQLa1OQ2DWPDuXp0B5t7a0D/pXx8N8JskpzPTb4KB15Qv
 r+zcsusPN2p0K5xuSY3MAOnWpbNnI4VAx5VAr0jqJNtqRoo/zaK7OWl1QcZwUkgrRqv1cZ8DSj+
 fioLY5J8jaArYiHFat3zevtECDc71v6LGOXaGHVAK5FA3Ozp/mpUUJ7oQKZE9JyW/ahwFr8lg60
 PdVV4IsPvrbw7G1olH7JugCCwrbU6ZNrOK5HddxHNPaJLelK456nzLegiBdYDAC4XVQ1f2Pe8L1
 3ErYXEZQxd4p85OLw7UdRkcRaThY2LTPxBgNK79yAAMg64xuNhfXF7oYFTz7RpBiD8QoaHaIFt3
 CJmhTVtrCe6QUc+w8pj0+1zKaDbgp7xAtLeocGSvWS9uxj7tXs7YEl2NFIxIWKxdY6jZeO9+ACA
 Z5BWAh05zM70AvzOq3UmMNN7vy5+06agJj7uQ+m6Ta9gRCXJUZYUW+h589083iBHUDPDTh+bSkN
 6O2+CBxop8RmJF7MD5FIcUwN2SmWo25XPrt27BGdT18LzzlwQXHKrknly2JcNP2ogOhs3vQSH+s
 8mtdic388SRfaZQ==
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

When reading from guest memory into vector registers, endianness should
be considered since the data in guest memory is in guest endianness and
the values in vector registers is in host endianness. Add MO_LE flag to
tcg_gen_qemu_ld_i64() to fix this.

Fixes: 4a26512f01e0 ("target/loongarch: Implement xvld xvst")
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
---
 target/loongarch/tcg/insn_trans/trans_vec.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/loongarch/tcg/insn_trans/trans_vec.c.inc b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
index 03938b1f052335190cdc437fc2d453b4f4fe16a4..91b1e15b61cac5d119892df1abd2ecf8a4c8e59d 100644
--- a/target/loongarch/tcg/insn_trans/trans_vec.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_vec.c.inc
@@ -5397,7 +5397,7 @@ static bool do_vldrepl_vl(DisasContext *ctx, arg_vr_i *a,
 
     addr = make_address_i(ctx, addr, a->imm);
 
-    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop);
+    tcg_gen_qemu_ld_i64(val, addr, ctx->mem_idx, mop | MO_LE);
     tcg_gen_gvec_dup_i64(mop, vec_full_offset(a->vd), oprsz, ctx->vl / 8, val);
 
     return true;

-- 
2.49.0



