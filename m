Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA5E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 09:52:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLJNP-0006A9-G5; Wed, 11 Dec 2024 04:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLJNN-00069a-9L; Wed, 11 Dec 2024 04:51:25 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLJNL-00057d-Oi; Wed, 11 Dec 2024 04:51:25 -0500
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 11 Dec
 2024 17:51:11 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 11 Dec 2024 17:51:11 +0800
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Bin Meng
 <bmeng.cn@gmail.com>, "open list:SD (Secure Card)" <qemu-block@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [RFC.PATCH v1 1/2] sd:sdhci: Fix boundary_count overflow in
 sdhci_sdma_transfer_multi_blocks
Date: Wed, 11 Dec 2024 17:51:09 +0800
Message-ID: <20241211095111.1421928-2-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241211095111.1421928-1-jamin_lin@aspeedtech.com>
References: <20241211095111.1421928-1-jamin_lin@aspeedtech.com>
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
   boundary was 0x80000.(512Kbytes). This SDMA buffer boundary the same as
   u-boot default value.
   The bit[11:0] is "001000000000", so the block size is 0x200.(512bytes)
2. The SDMA address was 0x83123456 which was not page aligned and
   "s->sdmasysad % boundary_chk" was 0x23456. The value of boundary_count was
   0x5cbaa.("boundary_chk - (s->sdmasysad % boundary_chk)" -->
   "(0x80000 - 0x23456)")

However, boundary_count did not aligned the block size 512 bytes and the SDMA
address is not page aligned(0x80000), so the following if-statement never be true,
```
if (((boundary_count + begin) < block_size) && page_aligned)
````

Finally, it caused boundary_count overflow because its data type was uint32_t.
Ex: the last boundary_count was 0x1aa and "0x1aa - 0x200" became "0xffffffaa".
It is the wrong behavior.

To fix it, it seems we can directly check the "boundary_count < blocksize"
instead of "boundary_count < blocksize && page_aligned"

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/sd/sdhci.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 37875c02c3..47d96b935b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -590,7 +590,6 @@ static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned size)
 /* Multi block SDMA transfer */
 static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
 {
-    bool page_aligned = false;
     unsigned int begin;
     const uint16_t block_size = s->blksize & BLOCK_SIZE_MASK;
     uint32_t boundary_chk = 1 << (((s->blksize & ~BLOCK_SIZE_MASK) >> 12) + 12);
@@ -601,15 +600,6 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         return;
     }
 
-    /*
-     * XXX: Some sd/mmc drivers (for example, u-boot-slp) do not account for
-     * possible stop at page boundary if initial address is not page aligned,
-     * allow them to work properly
-     */
-    if ((s->sdmasysad % boundary_chk) == 0) {
-        page_aligned = true;
-    }
-
     s->prnsts |= SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE;
     if (s->trnmod & SDHC_TRNS_READ) {
         s->prnsts |= SDHC_DOING_READ;
@@ -618,7 +608,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
                 sdbus_read_data(&s->sdbus, s->fifo_buffer, block_size);
             }
             begin = s->data_count;
-            if (((boundary_count + begin) < block_size) && page_aligned) {
+            if (((boundary_count + begin) < block_size)) {
                 s->data_count = boundary_count + begin;
                 boundary_count = 0;
              } else {
@@ -634,7 +624,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
             if (s->data_count == block_size) {
                 s->data_count = 0;
             }
-            if (page_aligned && boundary_count == 0) {
+            if (boundary_count == 0) {
                 break;
             }
         }
@@ -642,7 +632,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
         s->prnsts |= SDHC_DOING_WRITE;
         while (s->blkcnt) {
             begin = s->data_count;
-            if (((boundary_count + begin) < block_size) && page_aligned) {
+            if (((boundary_count + begin) < block_size)) {
                 s->data_count = boundary_count + begin;
                 boundary_count = 0;
              } else {
@@ -659,7 +649,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
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


