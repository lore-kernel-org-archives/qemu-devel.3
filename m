Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AF6C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 11:54:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruA3A-0006AF-GJ; Tue, 09 Apr 2024 07:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1ruA38-0006A6-V5
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:54:02 -0400
Received: from new-mail.astralinux.ru ([51.250.53.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abelova@astralinux.ru>)
 id 1ruA37-0005M6-5M
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 07:54:02 -0400
Received: from rbta-msk-lt-106062.astralinux.ru (unknown [10.177.20.58])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VDPVz1TcMzlVmL;
 Tue,  9 Apr 2024 14:53:47 +0300 (MSK)
From: Anastasia Belova <abelova@astralinux.ru>
To: qemu-devel@nongnu.org
Cc: Anastasia Belova <abelova@astralinux.ru>,
 Andrzej Zaborowski <balrogg@gmail.com>, sdl.qemu@linuxtesting.org
Subject: [PATCH] hw/dma: prevent overflow in soc_dma_set_request
Date: Tue,  9 Apr 2024 14:53:01 +0300
Message-Id: <20240409115301.21829-1-abelova@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: 0
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheptehnrghsthgrshhirgcuuegvlhhovhgruceorggsvghlohhvrgesrghsthhrrghlihhnuhigrdhruheqnecuggftrfgrthhtvghrnhepffdvvdeuheevvdfgiedvuedvudetueelgfefheeifffgheetuddtgfevfedvieehnecuffhomhgrihhnpehlihhnuhigthgvshhtihhnghdrohhrghenucfkphepuddtrddujeejrddvtddrheeknecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqddutdeitdeivddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudejjedrvddtrdehkeemfeeikeeftddpmhgrihhlfhhrohhmpegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeegpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrsggvlhhovhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohepsggrlhhrohhgghesghhmrghilhdrtghomhdprhgtphhtthhopehsughlrdhqvghmuheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB;
 Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12586508,
 Updated: 2024-Apr-09 09:39:37 UTC]
Received-SPF: pass client-ip=51.250.53.244; envelope-from=abelova@astralinux.ru;
 helo=new-mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

ch->num can reach values up to 31. Add casting to
a larger type before performing left shift to
prevent integer overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: afbb5194d4 ("Handle on-chip DMA controllers in one place, convert OMAP DMA to use it.")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
---
 hw/dma/soc_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 3a430057f5..d5c52b804f 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -209,9 +209,9 @@ void soc_dma_set_request(struct soc_dma_ch_s *ch, int level)
     dma->enabled_count += level - ch->enable;
 
     if (level)
-        dma->ch_enable_mask |= 1 << ch->num;
+        dma->ch_enable_mask |= (uint64_t)1 << ch->num;
     else
-        dma->ch_enable_mask &= ~(1 << ch->num);
+        dma->ch_enable_mask &= ~((uint64_t)1 << ch->num);
 
     if (level != ch->enable) {
         soc_dma_ch_freq_update(dma);
-- 
2.30.2


