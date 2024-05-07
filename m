Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574EDC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:45:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GQZ-0005cU-6k; Tue, 07 May 2024 04:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPl-0003yQ-Ep; Tue, 07 May 2024 04:43:09 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPg-0003Gk-Oi; Tue, 07 May 2024 04:43:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 58C5664BD1;
 Tue,  7 May 2024 11:42:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 48DFAC85BA;
 Tue,  7 May 2024 11:42:30 +0300 (MSK)
Received: (nullmailer pid 1026552 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alexandra Diupina <adiupina@astralinux.ru>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 13/16] hw/dmax/xlnx_dpdma: fix handling of
 address_extension descriptor fields
Date: Tue,  7 May 2024 11:42:12 +0300
Message-Id: <20240507084226.1026455-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandra Diupina <adiupina@astralinux.ru>

The DMA descriptor structures for this device have
a set of "address extension" fields which extend the 32
bit source addresses with an extra 16 bits to give a
48 bit address:
 https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/ADDR_EXT-Field

However, we misimplemented this address extension in several ways:
 * we only extracted 12 bits of the extension fields, not 16
 * we didn't shift the extension field up far enough
 * we accidentally did the shift as 32-bit arithmetic, which
   meant that we would have an overflow instead of setting
   bits [47:32] of the resulting 64-bit address

Add a type cast and use extract64() instead of extract32()
to avoid integer overflow on addition. Fix bit fields
extraction according to documentation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: qemu-stable@nongnu.org
Fixes: d3c6369a96 ("introduce xlnx-dpdma")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
Message-id: 20240428181131.23801-1-adiupina@astralinux.ru
[PMM: adjusted commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 4b00855f0ee2e2eee8fd2500ffef27c108be6dc3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index dd66be5265..06e187e99c 100644
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
-- 
2.39.2


