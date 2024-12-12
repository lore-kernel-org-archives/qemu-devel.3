Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 439B4E77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkuf-0004J8-F8; Thu, 12 Dec 2024 10:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkto-0003Xv-UE; Thu, 12 Dec 2024 10:14:45 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktn-0003gR-19; Thu, 12 Dec 2024 10:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=F3Ht+P7WjzdroAbandXO2uGUjJDRBQRsz5euX/kuobI=; b=wP51QS0uzsvIIV+AEaFxVVieu8
 4ljWZXZN2la3zEXN/Vhse5GSQfRkR2jS7zvk96VZZJ5UaPz+eXdZDtd6yytRFLYWEG6rSoJoE7xLs
 g8gJITNU92mqZ/FyqOBfZgNb80bzXzZrLykdceMvchIuCNZUc/+mklMNOHeXQJbdhL1hsOrBPVoGW
 P908pLqwjPSq4kW3qIiqS1SRFNLqfa3NPQCaQXBPklAbtbr8U40BR2kAbv+GCuVERv7NTdKi7GtVt
 ULqJ4I8LpwwK+Ct5W095AMEcX9UbPcnhmmerV2aSztL0Uk/uTGAfhaD/2uJFerwq0bMS13qA1sJH1
 ri8CMickdwCypm8r14FSwePl+SchRvIJEcMPV0PJp46ciIo5PW3RipQzNXt+swKYQi4bG8HOJ4Dx3
 hro8auFBukNsdn+cKkvWZ/j0XJM5YlUWeKIWzu4QPTrfRgtI4Go77pElI022OYSKTchb2VTzQdf2k
 eLg4M4DaugCRSnm9/WlO9hNb1UkVikQX6A0yPwEOCD/V51hV2jg3hbim/D78GI2xLK9ufa2rW16EX
 8PMTxRmz5/RZIRHWMBOYPONxfE9h99Cgjnctjlc44k3r08UwglizRP7lcTiMHsIMeKv/opUlFjsFw
 joW3gHiNrogslo+VjJb6HdiPoU+ys5UFXI8hxy4iY=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkt4-0008Ue-GE; Thu, 12 Dec 2024 15:14:02 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:04 +0000
Message-Id: <20241212151412.570454-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 03/11] target/ppc: introduce gen_st_tl() function
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

This function is intended to be used for all memory store operations. Convert the
GEN_QEMU_STORE_TL() macro to use it as a starting point.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5fb0aa36ce..bf94f3a5de 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2616,12 +2616,18 @@ GEN_QEMU_LOAD_64(ld64,  DEF_MEMOP(MO_UQ))
 GEN_QEMU_LOAD_64(ld64ur, BSWAP_MEMOP(MO_UQ))
 #endif
 
+static void gen_st_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
+                      MemOp memop)
+{
+    tcg_gen_qemu_st_tl(val, addr, idx, memop);
+}
+
 #define GEN_QEMU_STORE_TL(stop, op)                                     \
 static void glue(gen_qemu_, stop)(DisasContext *ctx,                    \
                                   TCGv val,                             \
                                   TCGv addr)                            \
 {                                                                       \
-    tcg_gen_qemu_st_tl(val, addr, ctx->mem_idx, op);                    \
+    gen_st_tl(ctx, val, addr, ctx->mem_idx, op);                        \
 }
 
 #if defined(TARGET_PPC64) || !defined(CONFIG_USER_ONLY)
-- 
2.39.5


