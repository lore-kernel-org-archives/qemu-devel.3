Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AECE77182
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkuy-0004n1-18; Thu, 12 Dec 2024 10:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktx-0003hl-9u; Thu, 12 Dec 2024 10:14:56 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktt-0003hv-LQ; Thu, 12 Dec 2024 10:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=yovBj1qlakfYrQHjfPcke/rhqmtrlh6vU+RcUZL1nn8=; b=wodgdZ71QOBiUS789AuGqyWVg/
 PGhrFUUUhrGuxWcGGih/WpOqAWEATHrf8t1kMm3mDR1n88CbtYw1xjX2soysoWmDM5LSvMI7E8wYY
 P5jCATVEjIkAfORn8Zn5xItALBERtA6KsnGsDdhnfx1ZekgksrzPlwQBxAg4NXx4gMAzQ5IYNILIR
 2Z95W+bRZ5N0OH3FHKoUGkp21GImfO2318l+BZuUkNnhyXhIBVuSW1kHUWMePMEvPdBv5iJrb7KQX
 OBP5GFMhZfpHk8V+d1iqU8f53gzjiJRJTqzFo/7SfAGtW5FIMA5TtBAMLJBRFLtMOynOstQngW9zj
 pDPAuS8QLA/34e2pnEuA9zq3j+lcQXA016XAenl0OZoJ+p9XjJBongUsDrOw41bo6sfoWMcsJdbDs
 9dqlQxCN44C1vaHZw8R0p/KyqPUNJA0P7ukMcvRO45jwK+kkimleYYKzQz8PYexKtrbkxVu1OH/6A
 0Y4Z5M3xSj3SyfrV/jDheyjeoiiuEe/HWVCRQeg4VChLjtGugEMLMXDwr8gGNBY9cwlZukpcvQoB2
 7/Rw1arDfXc9DVpzIvpG02GFC4Vu8yek9WuqdxcFIyujQRy3x3o3eruSbw/mBigfzaKHLwL3y/8wI
 r8oOh0Nn6AUE1NOPAR6cbIoCfCrYak4zqcuPh2J18=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktH-0008Ue-Oq; Thu, 12 Dec 2024 15:14:16 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:07 +0000
Message-Id: <20241212151412.570454-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 06/11] target/ppc: introduce gen_addr_swizzle_le() function
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

This function is used to swizzle the address lines to implement little endian
accesses as used by older CPUs. Add the address line swizzle to the gen_ld_tl()
and gen_st_tl() functions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1211435039..ddc0f85fb7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2561,6 +2561,24 @@ static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
     return ea;
 }
 
+/*
+ * Swizzle the address lines for little endian accesses as used by older
+ * CPUs. The bottom 3 address lines are exlusive-ORed by a constant to
+ * generate the correct address for a little endian access. For more
+ * information see https://wiki.preterhuman.net/images/f/fc/Endian.pdf
+ */
+static inline void gen_addr_swizzle_le(TCGv ret, TCGv addr, MemOp op)
+{
+    MemOp size = op & MO_SIZE;
+    TCGv aoff = tcg_temp_new();
+    static int c_swizzle[MO_SIZE] = { 0x7, 0x6, 0x4, 0x0 };
+
+    tcg_gen_andi_tl(aoff, addr, (1 << size) - 1);
+    tcg_gen_andi_tl(ret, addr, ~((1 << size) - 1));
+    tcg_gen_xori_tl(ret, ret, c_swizzle[size]);
+    tcg_gen_sub_tl(ret, ret, aoff);
+}
+
 #if defined(TARGET_PPC64)
 /* EA <- (ra == 0) ? 0 : GPR[ra] */
 static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
@@ -2586,6 +2604,10 @@ static void gen_ld_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
 {
     if (!need_addrswizzle_le(ctx)) {
         tcg_gen_qemu_ld_tl(val, addr, idx, memop);
+    } else {
+        TCGv taddr = tcg_temp_new();
+        gen_addr_swizzle_le(taddr, addr, memop);
+        tcg_gen_qemu_ld_tl(val, taddr, idx, memop);
     }
 }
 
@@ -2629,6 +2651,10 @@ static void gen_st_tl(DisasContext *ctx, TCGv val, TCGv addr, TCGArg idx,
 {
     if (!need_addrswizzle_le(ctx)) {
         tcg_gen_qemu_st_tl(val, addr, idx, memop);
+    } else {
+        TCGv taddr = tcg_temp_new();
+        gen_addr_swizzle_le(taddr, addr, memop);
+        tcg_gen_qemu_st_tl(val, taddr, idx, memop);
     }
 }
 
-- 
2.39.5


