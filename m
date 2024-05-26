Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6018C25B75
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 23:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBN4k-0004Nv-Lf; Sun, 26 May 2024 19:14:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4j-0004MA-GH; Sun, 26 May 2024 19:14:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sBN4h-0003iO-Ed; Sun, 26 May 2024 19:14:49 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C9AD44E6509;
 Mon, 27 May 2024 01:13:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0VGhghv0XU5O; Mon, 27 May 2024 01:13:09 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D51774E64C1; Mon, 27 May 2024 01:13:09 +0200 (CEST)
Message-Id: <c30ddd4f433bbe60629d2be66c5214076f677fa9.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1716763435.git.balaton@eik.bme.hu>
References: <cover.1716763435.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 33/43] target/ppc: Remove single use static inline function
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Date: Mon, 27 May 2024 01:13:09 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The ger_pack_masks() function is only used once and the inverse of
this operation is already inlined so it can be inlined too in the only
caller and removed from the header.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/internal.h               | 9 ---------
 target/ppc/translate/vsx-impl.c.inc | 6 ++++--
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 20fb2ec593..8e5a241f74 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -293,13 +293,4 @@ FIELD(GER_MSK, XMSK, 0, 4)
 FIELD(GER_MSK, YMSK, 4, 4)
 FIELD(GER_MSK, PMSK, 8, 8)
 
-static inline int ger_pack_masks(int pmsk, int ymsk, int xmsk)
-{
-    int msk = 0;
-    msk = FIELD_DP32(msk, GER_MSK, XMSK, xmsk);
-    msk = FIELD_DP32(msk, GER_MSK, YMSK, ymsk);
-    msk = FIELD_DP32(msk, GER_MSK, PMSK, pmsk);
-    return msk;
-}
-
 #endif /* PPC_INTERNAL_H */
diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 0266f09119..62950d348a 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2819,7 +2819,7 @@ static bool trans_XXSETACCZ(DisasContext *ctx, arg_X_a *a)
 static bool do_ger(DisasContext *ctx, arg_MMIRR_XX3 *a,
     void (*helper)(TCGv_env, TCGv_ptr, TCGv_ptr, TCGv_ptr, TCGv_i32))
 {
-    uint32_t mask;
+    uint32_t mask = 0;
     TCGv_ptr xt, xa, xb;
     REQUIRE_INSNS_FLAGS2(ctx, ISA310);
     REQUIRE_VSX(ctx);
@@ -2832,7 +2832,9 @@ static bool do_ger(DisasContext *ctx, arg_MMIRR_XX3 *a,
     xa = gen_vsr_ptr(a->xa);
     xb = gen_vsr_ptr(a->xb);
 
-    mask = ger_pack_masks(a->pmsk, a->ymsk, a->xmsk);
+    mask = FIELD_DP32(mask, GER_MSK, XMSK, a->xmsk);
+    mask = FIELD_DP32(mask, GER_MSK, YMSK, a->ymsk);
+    mask = FIELD_DP32(mask, GER_MSK, PMSK, a->pmsk);
     helper(tcg_env, xa, xb, xt, tcg_constant_i32(mask));
     return true;
 }
-- 
2.30.9


