Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 408E7E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkws-0007ba-Oi; Thu, 12 Dec 2024 10:17:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuF-0003va-7e; Thu, 12 Dec 2024 10:15:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuD-0003uJ-2V; Thu, 12 Dec 2024 10:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=wMWr+/32bt+QmZysuEMt/P2NvfOADfqTFHhlBuvcNBU=; b=gqcf4hCXKMEQHJOFo2hc0tTxS5
 NsYw+gpjX2QYbSjPu79CardpRN/YPuJvPYHHuQ6FrWmKPjXMX252L4NTwy6b4r47ARlikhwhwvogO
 mLL3lYviXCX8huiOfDu71ml+/CjDZl8leN1WXa0SkoxCos5noUqrFknrGyyrPsN8cwLvbNF05d72b
 ouqpW38SE/7Aq0Mt+IPHVXe0WxNCUPP2paMsxY/aBEBEC82w1Ja9nOLZ6bfxwoPNCAH8vFVGhcoP3
 umCmeSJTgceJFjAEhRh/rsEzJgUb+0Yw+gWttY/qqM2tniYbU22zZ+Wswwlxl92HAT72zkWhC1xmw
 QPdC/FVykAaqVm6jEGVZQr2YRhoEgC8fOSmGC/wDW5gPzIeo+I13/1lRYpDE9yaAQtOw1RoS25JPD
 Tn9clToGItdciBh3/PHNalbPs3EzkTSPZhb22aLx+yNpit5p9fBsdGPzD/zVlWrw/WimVlwN3il0R
 wynClSKmDnQUHCnOo8KGRajQwy/+kuhtz8S1jIVQGzj70as64FQ/nVtGYM2QWz7r9QI5PlCOPfZ2a
 wE8tYKLDWH/hSTDgZz4NnvWFLgvHYjckGGc7lz9O1F8flum9SjcOIO4llcaCmOorLHDfzhNfz5EnZ
 PPkBAIxl8atnhhTQ/5Dl+gFojlL4AEEWQxQWwrpJ4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktb-0008Ue-Jb; Thu, 12 Dec 2024 15:14:35 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:11 +0000
Message-Id: <20241212151412.570454-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 10/11] target/ppc: implement address swizzle for
 gen_conditional_store()
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

The gen_conditional_store() function uses tcg_gen_atomic_cmpxchg_tl() within its
implementation. Update gen_conditional_store() so that it implements the address
swizzle if required.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index fc44e3293a..e8ae96cd46 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3345,9 +3345,18 @@ static void gen_conditional_store(DisasContext *ctx, MemOp memop)
     tcg_gen_brcond_tl(TCG_COND_NE, EA, cpu_reserve, lfail);
     tcg_gen_brcondi_tl(TCG_COND_NE, cpu_reserve_length, memop_size(memop), lfail);
 
-    tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
-                              cpu_gpr[rs], ctx->mem_idx,
-                              DEF_MEMOP(memop) | MO_ALIGN);
+    if (!need_addrswizzle_le(ctx)) {
+        tcg_gen_atomic_cmpxchg_tl(t0, cpu_reserve, cpu_reserve_val,
+                                  cpu_gpr[rs], ctx->mem_idx,
+                                  DEF_MEMOP(memop) | MO_ALIGN);
+    } else {
+        TCGv ta = tcg_temp_new();
+
+        gen_addr_swizzle_le(ta, cpu_reserve, memop);
+        tcg_gen_atomic_cmpxchg_tl(t0, ta, cpu_reserve_val,
+                                  cpu_gpr[rs], ctx->mem_idx,
+                                  DEF_MEMOP(memop) | MO_ALIGN);
+    }
     tcg_gen_setcond_tl(TCG_COND_EQ, t0, t0, cpu_reserve_val);
     tcg_gen_shli_tl(t0, t0, CRF_EQ_BIT);
     tcg_gen_or_tl(cr0, cr0, t0);
-- 
2.39.5


