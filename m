Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266D8E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkvL-0005Uo-FH; Thu, 12 Dec 2024 10:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktr-0003ex-Jl; Thu, 12 Dec 2024 10:14:51 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktn-0003gt-1H; Thu, 12 Dec 2024 10:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=cAQZTLK6BzAysn+TUWjXmmrwVyYjM7uScooDVo5CvNI=; b=KJexrUf8LTUrOM8ONh+psdb0zs
 tfcvXKa9lL+GrOCFsj+EJz60OXX8bADTjz1jd0WL6gIzYc2Ho0bml5lG0zdPWCt+ZeOWZ2RloqOU2
 DhhgYse0RcHkhkZk6q+gNAlxIB8rLly0gLRIoeRdB9Lv1DcRJ2c6m037Pa+Kg+canRIboOmdb6zkZ
 I0rwb+J4f+RqmY9nyJ9Q1vPbhhZGqYZBWGie51Bz9n4RhTaJe7Wf4GXZxES47pukzz7YRjxShgj7h
 /4y4+nx21QpYOax2QOERtygwE/zfIXWny3eIzeytTrpCqLz60rVQyUdbWqxshGISJPytNYYIb+Kff
 Fm/bZW2abPKh2RSnsoy/Ulb2cJ3BwZMCTgJM8oJ8XR86Rbtq/CiUFsL4OcEUGF9/UhaggGXlNKvgi
 +McgreK0lnm5/u+K3ahLh+0XxIpMookvlaUFVX+HNpJg8oQGpfqqCN2VavlD1834A+BDkeRGU5ogG
 1T5UNuqBIEBeWQ53YkwQ1MEgYKygOp/Y4WVTwbBTebdb8yiyEhrTlj8QZzQNjNnYGoCneezIQUhMH
 JjV6iAMZ3GX/tHdELo6g0dTgRTorCOOvuDcv0rK81mcAf1XBJJEima5+/+ce9hKV1zKwbHEYPo3vy
 s7t5XAGA4CbyqSt/RoyRe+wYrzE4UAVtTk1ZoimnY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkt9-0008Ue-Vo; Thu, 12 Dec 2024 15:14:04 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:05 +0000
Message-Id: <20241212151412.570454-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 04/11] target/ppc: replace tcg_gen_qemu_st_tl() with
 gen_st_tl()
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

To ensure that all memory stores are performed by gen_st_tl(), convert all
remaining users of tcg_gen_qemu_st_tl() with gen_st_tl().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c                     | 10 +++++-----
 target/ppc/translate/fixedpoint-impl.c.inc |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index bf94f3a5de..4c47f97607 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2724,7 +2724,7 @@ static void glue(gen_, name##epx)(DisasContext *ctx)                          \
     gen_set_access_type(ctx, ACCESS_INT);                                     \
     EA = tcg_temp_new();                                                      \
     gen_addr_reg_index(ctx, EA);                                              \
-    tcg_gen_qemu_st_tl(                                                       \
+    gen_st_tl(ctx,                                                            \
         cpu_gpr[rD(ctx->opcode)], EA, PPC_TLB_EPID_STORE, stop);              \
 }
 
@@ -2980,7 +2980,7 @@ static void gen_fetch_inc_conditional(DisasContext *ctx, MemOp memop,
     /* E.g. for fetch and increment bounded... */
     /* mem(EA,s) = (t != t2 ? u = t + 1 : t) */
     tcg_gen_movcond_tl(cond, u, t, t2, u, t);
-    tcg_gen_qemu_st_tl(u, EA, ctx->mem_idx, memop);
+    gen_st_tl(ctx, u, EA, ctx->mem_idx, memop);
 
     /* RT = (t != t2 ? t : u = 1<<(s*8-1)) */
     tcg_gen_movcond_tl(cond, cpu_gpr[rD(ctx->opcode)], t, t2, t,
@@ -3045,7 +3045,7 @@ static void gen_ld_atomic(DisasContext *ctx, MemOp memop)
             }
             tcg_gen_movcond_tl(TCG_COND_NE, t1, t0, t1,
                                cpu_gpr[(rt + 2) & 31], t0);
-            tcg_gen_qemu_st_tl(t1, EA, ctx->mem_idx, memop);
+            gen_st_tl(ctx, t1, EA, ctx->mem_idx, memop);
             tcg_gen_mov_tl(dst, t0);
         }
         break;
@@ -3149,8 +3149,8 @@ static void gen_st_atomic(DisasContext *ctx, MemOp memop)
             gen_ld_tl(ctx, t2, ea_plus_s, ctx->mem_idx, memop);
             tcg_gen_movcond_tl(TCG_COND_EQ, s, t, t2, src, t);
             tcg_gen_movcond_tl(TCG_COND_EQ, s2, t, t2, src, t2);
-            tcg_gen_qemu_st_tl(s, EA, ctx->mem_idx, memop);
-            tcg_gen_qemu_st_tl(s2, ea_plus_s, ctx->mem_idx, memop);
+            gen_st_tl(ctx, s, EA, ctx->mem_idx, memop);
+            gen_st_tl(ctx, s2, ea_plus_s, ctx->mem_idx, memop);
         }
         break;
     default:
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 717e3f122f..6b2265bd8f 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -35,7 +35,7 @@ static bool do_ldst(DisasContext *ctx, int rt, int ra, TCGv displ, bool update,
     ea = do_ea_calc(ctx, ra, displ);
     mop ^= ctx->default_tcg_memop_mask;
     if (store) {
-        tcg_gen_qemu_st_tl(cpu_gpr[rt], ea, ctx->mem_idx, mop);
+        gen_st_tl(ctx, cpu_gpr[rt], ea, ctx->mem_idx, mop);
     } else {
         gen_ld_tl(ctx, cpu_gpr[rt], ea, ctx->mem_idx, mop);
     }
-- 
2.39.5


