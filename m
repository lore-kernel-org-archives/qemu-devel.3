Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D721EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 18:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzh7z-0007LM-VP; Wed, 24 Apr 2024 14:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rzh7v-0007KB-IS; Wed, 24 Apr 2024 14:13:51 -0400
Received: from new-mail.astralinux.ru ([51.250.53.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rzh7s-0005QZ-S7; Wed, 24 Apr 2024 14:13:51 -0400
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.232.60])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VPnDS4tVszqSSK;
 Wed, 24 Apr 2024 21:13:44 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Alistair Francis <alistair@alistair23.me>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
 "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH] fix bit fields extraction and prevent overflow
Date: Wed, 24 Apr 2024 21:13:21 +0300
Message-Id: <20240424181321.20844-2-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAFEAcA-=kk_TQVRLLQvH96DC-ffmDqd_hU5=z=Og8ntYGxPUeg@mail.gmail.com>
References: <20240424181321.20844-1-adiupina@astralinux.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeefkedufedvkeffuedtgfdugeeutdegvdffffejfffgleffieduhfejvdelffdvudenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefvddriedtnecurfgrrhgrmhephhgvlhhopehrsghtrgdqmhhskhdqlhhtqdeftddvieeltddrrghsthhrrghlihhnuhigrdhruhdpihhnvghtpedutddrudejjedrvdefvddriedtmeehieegjedvpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeekpdhrtghpthhtoheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhrtghpthhtoheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohephfhrvgguvghrihgtrdfmohhnrhgrugesrghmugdrtghomhdprhgtphhtthhopegvughgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomhdprhgtphhtthhope
 hpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsughlrdhqvghmuheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB;
 Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12628730,
 Updated: 2024-Apr-24 16:23:42 UTC]
Received-SPF: pass client-ip=51.250.53.164;
 envelope-from=adiupina@astralinux.ru; helo=new-mail.astralinux.ru
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

Add a type cast and use extract64() instead of extract32()
to avoid integer overflow on addition. Fix bit fields
extraction according to documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d3c6369a96 ("introduce xlnx-dpdma")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 hw/dma/xlnx_dpdma.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 1f5cd64ed1..52e8c594fe 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -175,24 +175,24 @@ static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
 
     switch (frag) {
     case 0:
-        addr = desc->source_address
-            + (extract32(desc->address_extension, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address
+            + (extract64(desc->address_extension, 16, 12) << 20);
         break;
     case 1:
-        addr = desc->source_address2
-            + (extract32(desc->address_extension_23, 0, 12) << 8);
+        addr = (uint64_t)desc->source_address2
+            + (extract64(desc->address_extension_23, 0, 12) << 8);
         break;
     case 2:
-        addr = desc->source_address3
-            + (extract32(desc->address_extension_23, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address3
+            + (extract64(desc->address_extension_23, 16, 12) << 20);
         break;
     case 3:
-        addr = desc->source_address4
-            + (extract32(desc->address_extension_45, 0, 12) << 8);
+        addr = (uint64_t)desc->source_address4
+            + (extract64(desc->address_extension_45, 0, 12) << 8);
         break;
     case 4:
-        addr = desc->source_address5
-            + (extract32(desc->address_extension_45, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address5
+            + (extract64(desc->address_extension_45, 16, 12) << 20);
         break;
     default:
         addr = 0;
-- 
2.30.2


