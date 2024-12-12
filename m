Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 693B6E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkxN-000865-5u; Thu, 12 Dec 2024 10:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLku1-0003nA-A7; Thu, 12 Dec 2024 10:15:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktz-0003iQ-Sn; Thu, 12 Dec 2024 10:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=dzeWK8x9CRHtbW2WAWCxYiM6pwOdIgA+XvJuHqKkk48=; b=r0Rj79oow/d5UQH5aB6cZfFZBy
 PKuWLREDDWP8WqGoHMyixMHYlhuz19MNYwHroC0rGVPDn51BWbM+psnf6plJ+YP96VdKvEQAZ5mTy
 NDJHPqHR5YjBv/+WHi5qp/0P+XbBt3fMAoRWAYBffj0mCByV+j3uXXvsfgpwcBFurNYJ86AACuyg7
 BCgnUSz1NF1Gs8/uNeZvErsZ9q2Zc+VHLAf3HV4op6UIDn8jJX8NUYoCQiMPxfnYxMOq02QivAAmo
 NXwM4F2FfChbyyIjhOpTzS9pn4wnyWuZJsRURddIuMggHlbMFaPIK5LmrprKo5km/YNTRJDnyM2Xd
 0HVwMa0EXYZ5Hbat1P20BomFdEtQYAszhYFLf+ah5Teq5mMybwaghucCpvBWroRou4FwL3vC6ic1a
 nUII6EwDMRBGd/l8JMpM93/+Xl7CcxPun2WxjqU+aCdgRsh9WYdUwP3ZCrDOo/ocbYa0UdfZxXXcR
 /ZaCD+nOYmK2XgxHF3ir7UUW4o9jTBuly82+j/XlzQWw6wetV/Tzjx2xvxadEMRfipJ+8QCQWGQqI
 Z1hO1q2inqpBXguESALMUdPPoYcAvhZdKU8EFx+udlj95UQVFRqA0vAKt7usBh/2ewS2m1JzA48Eg
 TQXKiHOTEceKvZeECECsNg8VAUhRzLibPKzyrIyBM=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktN-0008Ue-Mu; Thu, 12 Dec 2024 15:14:22 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:08 +0000
Message-Id: <20241212151412.570454-8-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 07/11] target/ppc: implement address swizzle for
 instruction translation
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

Ensure that the address swizzle is implemented when retrieving instructions from
guest memory for translation.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ddc0f85fb7..74aa398f25 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6600,7 +6600,11 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
               ctx->base.pc_next, ctx->mem_idx, (int)msr_ir);
 
     ctx->cia = pc = ctx->base.pc_next;
-    insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
+    if (!need_addrswizzle_le(ctx)) {
+        insn = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
+    } else {
+        insn = translator_ldl(env, dcbase, pc ^ 4);
+    }
     ctx->base.pc_next = pc += 4;
 
     if (!is_prefix_insn(ctx, insn)) {
@@ -6616,8 +6620,13 @@ static void ppc_tr_translate_insn(DisasContextBase *dcbase, CPUState *cs)
         gen_exception_err(ctx, POWERPC_EXCP_ALIGN, POWERPC_EXCP_ALIGN_INSN);
         ok = true;
     } else {
-        uint32_t insn2 = translator_ldl_swap(env, dcbase, pc,
-                                             need_byteswap(ctx));
+        uint32_t insn2;
+
+        if (!need_addrswizzle_le(ctx)) {
+            insn2 = translator_ldl_swap(env, dcbase, pc, need_byteswap(ctx));
+        } else {
+            insn2 = translator_ldl(env, dcbase, pc ^ 4);
+        }
         ctx->base.pc_next = pc += 4;
         ok = decode_insn64(ctx, deposit64(insn2, 32, 32, insn));
     }
-- 
2.39.5


