Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 139E3E7716A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLw6W-0001q8-2a; Thu, 12 Dec 2024 22:12:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLw6U-0001oa-Do; Thu, 12 Dec 2024 22:12:34 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLw6P-0002gT-Dk; Thu, 12 Dec 2024 22:12:33 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 13 Dec
 2024 11:12:05 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 13 Dec 2024 11:12:05 +0800
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v2 1/2] hw/sd/sdhci: Fix boundary_count overflow in
 sdhci_sdma_transfer_multi_blocks
Date: Fri, 13 Dec 2024 11:12:04 +0800
Message-ID: <20241213031205.641009-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241213031205.641009-1-jamin_lin@aspeedtech.com>
References: <20241213031205.641009-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

How to reproduce it:
1. The value of "s->blksie" was 0x7200. The bits[14:12] was "111", so the buffer
   boundary was 0x80000.(512Kbytes). This SDMA buffer boundary was the same as
   u-boot default value.
   The bit[11:0] was "001000000000", so the block size was 0x200.(512bytes)
2. The SDMA address was 0x83123456 which was not page aligned and
   "s->sdmasysad % boundary_chk" was 0x23456. The value of boundary_count was
   0x5cbaa.("boundary_chk - (s->sdmasysad % boundary_chk)" -->
   "(0x80000 - 0x23456)")

However, boundary_count did not align the block size 512 bytes and the SDMA
address was not page aligned(0x80000), so the following if-statement never be true,
```
if (((boundary_count + begin) < block_size) && page_aligned)
````

Finally, it caused boundary_count overflow because its data type was uint32_t.
Ex: the last boundary_count was 0x1aa and "0x1aa - 0x200" became "0xffffffaa".
It is the wrong behavior.

To fix it, change to check boundary_count smaller than block size if system
address did not page align

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/sd/sdhci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 37875c02c3..f1a329fdaf 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -618,7 +618,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
             }
             begin = s->data_count;
-            if (((boundary_count + begin) < block_size) && page_aligned) {
+            if (((boundary_count + begin) < block_size) && !page_aligned) {
                 s->data_count = boundary_count + begin;
                 boundary_count = 0;
              } else {
@@ -634,7 +634,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
             if (s->data_count == block_size) {
                 s->data_count = 0;
             }
-            if (page_aligned && boundary_count == 0) {
+            if (boundary_count == 0) {
                 break;
             }
         }
@@ -642,7 +642,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         s->prnsts |= SDHC_DOING_WRITE;
         while (s->blkcnt) {
             begin = s->data_count;
-            if (((boundary_count + begin) < block_size) && page_aligned) {
+            if (((boundary_count + begin) < block_size) && !page_aligned) {
                 s->data_count = boundary_count + begin;
                 boundary_count = 0;
              } else {
@@ -659,7 +659,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                     s->blkcnt--;
                 }
             }
-            if (page_aligned && boundary_count == 0) {
+            if (boundary_count == 0) {
                 break;
             }
         }
-- 
2.34.1


