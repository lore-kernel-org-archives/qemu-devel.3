Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328D3C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 12:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzc8d-0002na-Gp; Wed, 24 Apr 2024 08:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rzc8b-0002n2-2N; Wed, 24 Apr 2024 08:54:13 -0400
Received: from new-mail.astralinux.ru ([51.250.53.164])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1rzc8Y-0007U8-SA; Wed, 24 Apr 2024 08:54:12 -0400
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.236.253])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VPf7S5hhRzqSQj;
 Wed, 24 Apr 2024 15:53:56 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Alistair Francis <alistair@alistair23.me>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
 "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH v2 RFC] fix host-endianness bug and prevent overflow
Date: Wed, 24 Apr 2024 15:53:24 +0300
Message-Id: <20240424125324.1628-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAFEAcA9JXOxkbQP6-1uTK+hG5yvYRcO31PYFZSxGjfrPis1nYA@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeefkedufedvkeffuedtgfdugeeutdegvdffffejfffgleffieduhfejvdelffdvudenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefiedrvdehfeenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvfeeirddvheefmeefjedufeekpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeekpdhrtghpthhtoheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhrtghpthhtoheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohephfhrvgguvghrihgtrdfmohhnrhgrugesrghmugdrtghomhdprhgtphhtthhopegvughgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomhdprhgtphhtth
 hopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsughlrdhqvghmuheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB;
 Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12628564,
 Updated: 2024-Apr-24 10:54:44 UTC]
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
Also fix host-endianness bug by swapping desc fields from guest
memory order to host memory order after dma_memory_read().

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d3c6369a96 ("introduce xlnx-dpdma")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 hw/dma/xlnx_dpdma.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index dd66be5265..d22b942274 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -175,24 +175,24 @@ static uint64_t xlnx_dpdma_desc_get_source_address(DPDMADescriptor *desc,
 
     switch (frag) {
     case 0:
-        addr = desc->source_address
-            + (extract32(desc->address_extension, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address
+            + (extract64(desc->address_extension, 16, 16) << 32);
         break;
     case 1:
-        addr = desc->source_address2
-            + (extract32(desc->address_extension_23, 0, 12) << 8);
+        addr = (uint64_t)desc->source_address2
+            + (extract64(desc->address_extension_23, 0, 16) << 32);
         break;
     case 2:
-        addr = desc->source_address3
-            + (extract32(desc->address_extension_23, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address3
+            + (extract64(desc->address_extension_23, 16, 16) << 32);
         break;
     case 3:
-        addr = desc->source_address4
-            + (extract32(desc->address_extension_45, 0, 12) << 8);
+        addr = (uint64_t)desc->source_address4
+            + (extract64(desc->address_extension_45, 0, 16) << 32);
         break;
     case 4:
-        addr = desc->source_address5
-            + (extract32(desc->address_extension_45, 16, 12) << 20);
+        addr = (uint64_t)desc->source_address5
+            + (extract64(desc->address_extension_45, 16, 16) << 32);
         break;
     default:
         addr = 0;
@@ -660,6 +660,24 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             break;
         }
 
+        /* Convert from LE into host endianness.  */
+        desc.control = le32_to_cpu(desc.control);
+        desc.descriptor_id = le32_to_cpu(desc.descriptor_id);
+        desc.xfer_size = le32_to_cpu(desc.xfer_size);
+        desc.line_size_stride = le32_to_cpu(desc.line_size_stride);
+        desc.timestamp_lsb = le32_to_cpu(desc.timestamp_lsb);
+        desc.timestamp_msb = le32_to_cpu(desc.timestamp_msb);
+        desc.address_extension = le32_to_cpu(desc.address_extension);
+        desc.next_descriptor = le32_to_cpu(desc.next_descriptor);
+        desc.source_address = le32_to_cpu(desc.source_address);
+        desc.address_extension_23 = le32_to_cpu(desc.address_extension_23);
+        desc.address_extension_45 = le32_to_cpu(desc.address_extension_45);
+        desc.source_address2 = le32_to_cpu(desc.source_address2);
+        desc.source_address3 = le32_to_cpu(desc.source_address3);
+        desc.source_address4 = le32_to_cpu(desc.source_address4);
+        desc.source_address5 = le32_to_cpu(desc.source_address5);
+        desc.crc = le32_to_cpu(desc.crc);
+
         xlnx_dpdma_update_desc_info(s, channel, &desc);
 
 #ifdef DEBUG_DPDMA
-- 
2.30.2


