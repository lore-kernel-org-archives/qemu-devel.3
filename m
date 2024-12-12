Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8B5E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkuA-0003mt-Nj; Thu, 12 Dec 2024 10:15:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktc-0003Do-Aa; Thu, 12 Dec 2024 10:14:32 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktX-0003fa-7o; Thu, 12 Dec 2024 10:14:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=WbUDXGEhxSHrpkWM3eyUyp6+0TyshM70AN1M+d/Yjvo=; b=ODCtMQ+A365gCQ7k5LiBYegvTa
 vtk1PE/asUchTCUuT2Uv+P8irV6RRA+sX6ulUVHTjiKYu4HAhDBWuSph3ELVqIerv1tX/j00XOrLH
 ZYRASV8dQS+Xjv0zzW1o5RreuX9T8dg8zO+98t+OxG0BCMOV3ut9Sh/1kYGZgBXrAEiQTEySFLTam
 1TIY750dMUrMnyA7u2l6hZhyuyAFmjRHVGQfuERK1JMXUyXwUA840P+T3MJBh8QLvWOyk0oHqT4hw
 NoKwvvS82noM2POWXaRESJQYWqp3acaAmOhJ/snMg9s9vFPbu2toikjFxd4WDirDncJAk5YrGftQm
 WurCOTMvrWv1QtFeCDoW2xYLdUhzFtz16skDfh5WgQfN02HLN5Qw58FDls4ORTn8yKB8DcyJvf6Kx
 Yw1zfA1Bm6+GUtu+PMcmXCE8gZIO7YPvu0/YcpECdnY3zJ20PV3OA6aj0B+PdRSxtfBLrP5+4Rrsx
 4BZ3TswY6OAtBdKtUTxY3MCXDzFlXAqFrXNOkb+DRjO0Gsy3jFbsbamcGXVK3d7eGilAUj9zHqevy
 sam9U4+6PR65VIoSAVoF7sz1yCCYBU0qWmqV9XxadrovUtqJLsG2RpdZPqvv4MPsyu3IR3sHV1HwF
 xN8wy+y/pxfGSENY74mD1/uAMbF7VKOM1hBde13+I=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLksv-0008Ue-Qc; Thu, 12 Dec 2024 15:13:53 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:02 +0000
Message-Id: <20241212151412.570454-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 01/11] target/ppc: introduce gen_ld_tl() function
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

This function is intended to be used for all memory load operations. Convert the
GEN_QEMU_LOAD_TL() macro to use it as a starting point.

Signed-off-by: Mark Cave-Aykand <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 47ca50a064..5ddaf69599 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2575,12 +2575,18 @@ static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
 #define DEF_MEMOP(op) ((op) | ctx->default_tcg_memop_mask)
 #define BSWAP_MEMOP(op) ((op) | (ctx->default_tcg_memop_mask ^ MO_BSWAP))
 
+static void gen_ld_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
+                      MemOp memop)
+{
+    tcg_gen_qemu_ld_tl(val, addr, idx, memop);
+}
+
 #define GEN_QEMU_LOAD_TL(ldop, op)                                      \
 static void glue(gen_qemu_, ldop)(DisasContext *ctx,                    \
                                   TCGv val,                             \
                                   TCGv addr)                            \
 {                                                                       \
-    tcg_gen_qemu_ld_tl(val, addr, ctx->mem_idx, op);                    \
+    gen_ld_tl(ctx, val, addr, ctx->mem_idx, op);                        \
 }
 
 GEN_QEMU_LOAD_TL(ld8u,  DEF_MEMOP(MO_UB))
-- 
2.39.5


