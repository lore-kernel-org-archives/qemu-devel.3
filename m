Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92494E7717F
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 15:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLkv2-0004wD-UP; Thu, 12 Dec 2024 10:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuF-0003vZ-7A; Thu, 12 Dec 2024 10:15:14 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLkuD-0003uV-Dc; Thu, 12 Dec 2024 10:15:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=Px9HUwsmu6zWLJ+nb6mDRAmYsNBhD0kHW7MypdC0u48=; b=ZYZKJ0Pel6kSELakO4meoOuvEU
 ww69jLW7GoCpiFPzUSh6W9lyEpNZYJg3EGsmo/VlFJ9h7PWg77/mda7AmYxiDYl7D/GXxCrFfjSFQ
 /yQa5F4aR5AzHaZrO/xK6STMiUNNw+DeZWqK65bkhhoBBEtLDOX7CbH4ob17u87B96l2kQxerm3F9
 KbV+qxdPHZ0D49uV/Kemc+uCrpNizpFxmiV8AUdOCp8g8HvMf56H9pKkCvzNU2cnAYlwmX+/tOBHK
 7KsW7lw60lW7lb0kPIU8Xs2ywa0m1NLHMC7bCXjbpahD9akZG3+sS8PmR3gwyG38LRpM9cL73so4S
 bDhSrnotWWUS7o72K8PtOWJ8Vz5/URStn27dXF+uGaHice5lOO3gH3Xr8rTdMBq0hj0YZheWd1t9Y
 pdr6CYPgDzgVYzr4Ku3RGKIWsCbipgEWbuJBFwtrQxSBSfk13vv0lrSirhWdCuWYrkvZ9a0AdOQ10
 XDMdlJdhlVOfx/1bqRZyAn6rddE5/hHkSUxFMxAqqgA6mkBYUrd2iX+nfzrWG11ygZhQSbDHjViyY
 VUo3Y8k1g5J0K96/bmahdQ35soqNpkQgTwvwkPVchWr0v//r7NFQIWuclmTS+xHcd6E5SH0euWX6b
 BH2Q+3THmn7xR2wxC5/Y38ImaZBkJewpC10amKNEc=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tLktf-0008Ue-Pw; Thu, 12 Dec 2024 15:14:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: npiggin@gmail.com, danielhb413@gmail.com, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Date: Thu, 12 Dec 2024 15:14:12 +0000
Message-Id: <20241212151412.570454-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
References: <20241212151412.570454-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [RFC PATCH 11/11] target/ppc: update DisasContext
 default_tcg_memop_mask value
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

If address swizzling is enabled for little endian accesses, don't use little endian
memory ordering. This is because the conversion is performed by swizzling the
physical address lines as opposed to reversing the memory storage order.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/ppc/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e8ae96cd46..4a0be4d70c 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6664,7 +6664,8 @@ static void ppc_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->access_type = -1;
     ctx->need_access_type = !mmu_is_64bit(env->mmu_model);
     ctx->le_mode = (hflags >> HFLAGS_LE) & 1;
-    ctx->default_tcg_memop_mask = ctx->le_mode ? MO_LE : MO_BE;
+    ctx->default_tcg_memop_mask = (!need_addrswizzle_le(ctx) &&
+                                   ctx->le_mode) ? MO_LE : MO_BE;
     ctx->flags = env->flags;
 #if defined(TARGET_PPC64)
     ctx->excp_model = env->excp_model;
-- 
2.39.5


