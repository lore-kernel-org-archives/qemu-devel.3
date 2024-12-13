Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54055E7716A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 03:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLw6Z-0001r7-B3; Thu, 12 Dec 2024 22:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLw6X-0001qL-1G; Thu, 12 Dec 2024 22:12:37 -0500
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1tLw6V-0002gT-Ai; Thu, 12 Dec 2024 22:12:36 -0500
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
Subject: [PATCH v2 2/2] hw/sd/sdhci: Fix data transfer did not complete if
 data size is bigger than SDMA Buffer Boundary
Date: Fri, 13 Dec 2024 11:12:05 +0800
Message-ID: <20241213031205.641009-3-jamin_lin@aspeedtech.com>
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

According to the design of sdhci_sdma_transfer_multi_blocks, if the
"s->blkcnt * 512" was bigger than the SDMA Buffer boundary, it break the
while loop of data transfer and set SDHC_NISEN_DMA in the normal interrupt
status to notify the firmware that this SDMA boundary buffer Transfer Complete
and firmware should set the system address of the next SDMA boundary buffer
for the remained data transfer.

However, after firmware set the system address of the next SDMA boundary buffer
in the SDMA System Address Register(0x00), SDHCI model did not restart the data
transfer, again. Finally, firmware break the data transfer because firmware
did not receive the either "DMA Interrupt" or "Transfer Complete Interrupt"
from SDHCI model.

Error log from u-boot
```
sdhci_transfer_data: Transfer data timeout
 ** fs_devread read error - block
```

According to the following mention from SDMA System Address Register of SDHCI
spec,
'''
This register contains the system memory address for an SDMA transfer in
32-bit addressing mode. When the Host Controller stops an SDMA transfer,
this register shall point to the system address of the next contiguous data
position.
It can be accessed only if no transaction is executing (i.e., after a transaction
has stopped). Reading this register during SDMA transfers may return an
invalid value.
The Host Driver shall initialize this register before starting an SDMA
transaction.
After SDMA has stopped, the next system address of the next contiguous
data position can be read from this register.
The SDMA transfer waits at the every boundary specified by the SDMA
Buffer Boundary in the Block Size register. The Host Controller generates
DMA Interrupt to request the Host Driver to update this register. The Host
Driver sets the next system address of the next data position to this register.
When the most upper byte of this register (003h) is written, the Host Controller
restarts the SDMA transfer.
''',

restart the data transfer if firmware writes the most upper byte of SDMA System
Address, s->blkcnt is bigger than 0 and SDHCI is in the data transfer state.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/sd/sdhci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index f1a329fdaf..a632177735 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1180,6 +1180,18 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
                     sdhci_sdma_transfer_single_block(s);
                 }
             }
+        } else if (TRANSFERRING_DATA(s->prnsts)) {
+            s->sdmasysad = (s->sdmasysad & mask) | value;
+            MASKED_WRITE(s->sdmasysad, mask, value);
+            /* restarts the SDMA transfer if the most upper byte is written */
+            if ((s->sdmasysad & 0xFF000000) && s->blkcnt &&
+                SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA) {
+                if (s->trnmod & SDHC_TRNS_MULTI) {
+                    sdhci_sdma_transfer_multi_blocks(s);
+                } else {
+                    sdhci_sdma_transfer_single_block(s);
+                }
+            }
         }
         break;
     case SDHC_BLKSIZE:
-- 
2.34.1


