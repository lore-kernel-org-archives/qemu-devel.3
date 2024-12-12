Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8B88E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkvC-0005CV-Em; Thu, 12 Dec 2024 10:16:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuF-0003wL-WF; Thu, 12 Dec 2024 10:15:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLku3-0003ik-HP; Thu, 12 Dec 2024 10:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=rlvoZT+6+Va2hBWLqrFSaLkap8KQtdDfAf3TILXFvjQ=; b=gIWdg3kyG0cAzdXDhnp2CMkvxr
 7q7eVtxO4juFfaB7A2YwTxdmAmdAUMNtwpYgFWrlDfsLE5zo4ZHt6OV9a3QN+8ExPM2Svu3MSdizf
 TPzvOmfVGWfi3KtnXp4GT4ZTuWdkYorvPvNk3M6PA7Wp6SZRLXz8yWYtxQ3h9NZu/PxQaquKtZweT
 n+BLvU4WQqdOpMtcKSX5ai43ktz7/Y09HMizP221DcXr1xZSLUjhS8y5f67WIbXzomPua1Mn6vfdg
 FkN0YHQaGPvh7c+7u6Zku9NI73Q4NeYl6is2Qn1I/QpRxaPnVpGGhpgjIbwG1MAVHuJ4v3dk2MCoA
 tyOlJWaj4Vh/11Y0k68y9AQyL2ZGo57aJaXbngYAMqJ6MbsJFFr1WCcRNbjSRXl4yZzQj8qKbKEh2
 vpnyAIg+9/hYdMiCL+Ydv5J7F5ykpUURnjICCy5lTIG9o1Q+ZsjC1YbTYSxcMF4dtOM2cP09losHx
 o1um7MhYuj1If3XkYeOGRGGXJU5nW9T+Cx7dHZHyrkvRdB5BrN1K//LR5pLC8d62dFykcgEa/XzF5
 7hP6hLQpkc4qisZ9baK/Uz0nQ4zGAdR5qNUIdZUJzLpSvoWYpQxYp+l/FL0k7ELXxzbMjs/0uhRuO
 BZFblVto+Kyo7AqgBv7kL0xg3leIwRY4z4ZDeTzJI=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktS-0008Ue-Vn; Thu, 12 Dec 2024 15:14:27 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:09 +0000
Message-Id: <20241212151412.570454-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 08/11] target/ppc: implement address swizzle for
 gen_ld_atomic()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The gen_ld_atomic() function uses a number of TCG atomic primitives within its
implementation. Update gen_ld_atomic() so that it implements the address swizzle
if required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 81 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 9 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 74aa398f25..b549525bb6 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3039,31 +3039,94 @@ static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
     memop |= MO_ALIGN;
     switch (gpr_FC) {
     case 0: /* Fetch and add */
-        tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_add_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_add_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 1: /* Fetch and xor */
-        tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_xor_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_xor_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 2: /* Fetch and or */
-        tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_or_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_or_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 3: /* Fetch and 'and' */
-        tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_and_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_and_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 4:  /* Fetch and max unsigned */
-        tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_umax_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_umax_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 5:  /* Fetch and max signed */
-        tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_smax_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_smax_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 6:  /* Fetch and min unsigned */
-        tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_umin_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_umin_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 7:  /* Fetch and min signed */
-        tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_fetch_smin_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_fetch_smin_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
     case 8: /* Swap */
-        tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
+        if (need_addrswizzle_le(ctx)) {
+            TCGv ta = tcg_temp_new();
+
+            gen_addr_swizzle_le(ta, EA, memop);
+            tcg_gen_atomic_xchg_tl(dst, ta, src, ctx->mem_idx, memop);
+        } else {
+            tcg_gen_atomic_xchg_tl(dst, EA, src, ctx->mem_idx, memop);
+        }
         break;
 
     case 16: /* Compare and swap not equal */
-- 
2.39.5


