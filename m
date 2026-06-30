Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 137D3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weglA-0003fW-FT; Tue, 30 Jun 2026 18:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkz-0003cy-A6
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:41 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <devnull+shankerwangmiao.gmail.com@kernel.org>)
 id 1wegkv-0000vO-PE
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:16:41 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C31CB60103;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F74C2BCF4;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1782857768;
 bh=9jtdAJLDhsYuDncra+S57koe5yikmfUxAXGVK0hCzSM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=lVXRirijbWideMPpIhs+LHGPghvChFBcrCm4VeI3tZapi0AXZ7/v6qSaM+puqT97V
 KrkXRe1so0TPU4BsCYmwWpZoINlAy8+ORKVZmPqX8IlO+iSLvbLmUxk0e0AfSuxk1e
 uOnsP2GFP9oKM4EJi1aSXkeU8EeGDqZz20ZrCvUmzcxNpviBzswnUcDckaoJU2yOcq
 /j6Eeq93fWf4+zztIHV2mkEyLFT+r7heDbBVBjYqoat3ASa1fJb+G8NCtj4Y0yfVEj
 QQPqLvtQE2LGoDtg77I2RnqiakkqZ5l7wzeENUYX+C8ZQn8X7hoRZRDQpM7jNrOSmf
 ms59fNVo7sPXg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 7223AC43458;
 Tue, 30 Jun 2026 22:16:08 +0000 (UTC)
From: Miao Wang via B4 Relay <devnull+shankerwangmiao.gmail.com@kernel.org>
Date: Wed, 01 Jul 2026 06:15:59 +0800
Subject: [PATCH 5/6] target/loongarch: do_vldrepl_vl: Fix endianness when
 reading from guest memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-loong64-be-v1-5-9c7d65e00697@gmail.com>
References: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
In-Reply-To: <20260701-loong64-be-v1-0-9c7d65e00697@gmail.com>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 Miao Wang <shankerwangmiao@gmail.com>, b4-sent@kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181;
 i=shankerwangmiao@gmail.com; s=20250715; h=from:subject:message-id;
 bh=RtvkqLT2lF+j/y7Kk8Hb/ToTorcK/6EJPDqknnL+4/4=;
 b=owEBbQKS/ZANAwAKAbAx48p7/tluAcsmYgBqREAlrK6i6XyJdiKWN0toYUEKqq9Qyr+VysqGL
 zUe31NoKo+JAjMEAAEKAB0WIQREqPWPgPJBxluezBOwMePKe/7ZbgUCakRAJQAKCRCwMePKe/7Z
 bvmSD/4kJL6SmlcOLBv8kQ5R8OZd9I2aWBFLDh5a14cMLJSc8AxZdHkkadnzRXpPs8iDtWVb8jG
 duGxzhg053VSNUStLotWDxGwPm51dvE+ofkE29ukogp0F7gWlmAtHrdgLXn3itSAT3NEu7KeOVv
 OUELvLQkpq+s2w65Sb7StmYYc9mvHdA7O0TAF1igVf0j9awZEulh0Ti/GO42djHauQSCUUBdVO9
 ZhA8XFiXe55dL3n0DJYqu3gn5da/DyVEx/N316VTJd1BQDf6Rz1TWGcekkNUlzQI09v93WPJ5zG
 G6gmx+AH9DKvyZYZ75OMY/UBlyyi9eCSwwEr/lWqVEaSYpf+19vmprNmwkSZnopD4kwKemp+PLC
 udJ5JMnsq3Bx3lVjmdgF8y1eGwWc33eSdsO1whCiVK2uq4DnOa6e2lMsJc71FCSMBafq67HswMs
 4UHX105nrUpVp6VqxWB66XXUORI7yvLzYxm+dB47t84M5xWSeqetXnszXtzHL+72pu0hJqPiyMZ
 tUz6jQByQVFU+uSqQBlYkV4Eb8bfrbmMEZV/AHjKhT1fAvnfzmjoEmGxS+C3LvTET/cqAsPBUUo
 +fEuWOa5wUPZJfm4Jn/bMm0XUe5TOiNoo/Xdn2Va/n457c0MOplCr8BBr6l9hSwyEPpEtaYyPXO
 oKBUCaW5Dxs6lJA==
X-Developer-Key: i=shankerwangmiao@gmail.com; a=openpgp;
 fpr=6FAEFF06B7D212A774C60BFDFA0D166D6632EF4A
X-Endpoint-Received: by B4 Relay for shankerwangmiao@gmail.com/20250715
 with auth_id=462
X-Original-From: Miao Wang <shankerwangmiao@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=devnull+shankerwangmiao.gmail.com@kernel.org;
 helo=tor.source.kernel.org
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



