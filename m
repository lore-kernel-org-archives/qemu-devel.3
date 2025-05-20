Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F29C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 07:37:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHHWD-0002jP-1c; Tue, 20 May 2025 03:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uHHW7-0002TN-GU; Tue, 20 May 2025 03:36:03 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1uHHW5-0003tR-AA; Tue, 20 May 2025 03:36:02 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 20 May
 2025 15:35:41 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 20 May 2025 15:35:41 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>
Subject: [PATCH v1 3/3] hw/arm/aspeed_ast27x0: Fix RAM size detection failure
 on BE hosts
Date: Tue, 20 May 2025 15:35:39 +0800
Message-ID: <20250520073540.2014240-4-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250520073540.2014240-1-jamin_lin@aspeedtech.com>
References: <20250520073540.2014240-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On big-endian hosts, the aspeed_ram_capacity_write() function previously passed
the address of a 64-bit "data" variable directly to address_space_write(),
assuming host and guest endianness matched.

However, the data is expected to be written in little-endian format to DRAM.
On big-endian hosts, this led to incorrect data being written into DRAM,
which caused the guest firmware to misdetect the DRAM size.

As a result, U-Boot fails to boot and hangs.

- Explicitly converting the 32-bit portion of "data" to little-endian format
  using cpu_to_le32(), storing it in a temporary "uint32_t le_data".
- Updating the MemoryRegionOps to restrict access to exactly 4 bytes
  using .valid.{min,max}_access_size = 4 and .impl.min_access_size = 4.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: 7436db1 ("aspeed/soc: fix incorrect dram size for AST2700")
---
 hw/arm/aspeed_ast27x0.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 1974a25766..7ed0919b3f 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -335,24 +335,34 @@ static void aspeed_ram_capacity_write(void *opaque, hwaddr addr, uint64_t data,
     AspeedSoCState *s = ASPEED_SOC(opaque);
     ram_addr_t ram_size;
     MemTxResult result;
+    uint32_t le_data;
 
     ram_size = object_property_get_uint(OBJECT(&s->sdmc), "ram-size",
                                         &error_abort);
 
     assert(ram_size > 0);
 
+    if (size != 4) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Unsupported write size: %d (only 4-byte allowed)\n",
+                      __func__, size);
+        return;
+    }
+
+    le_data = cpu_to_le32((uint32_t)data);
+
     /*
      * Emulate ddr capacity hardware behavior.
      * If writes the data to the address which is beyond the ram size,
      * it would write the data to the "address % ram_size".
      */
     result = address_space_write(&s->dram_as, addr % ram_size,
-                                 MEMTXATTRS_UNSPECIFIED, &data, 4);
+                                 MEMTXATTRS_UNSPECIFIED, &le_data, 4);
     if (result != MEMTX_OK) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "%s: DRAM write failed, addr:0x%" HWADDR_PRIx
-                      ", data :0x%" PRIx64  "\n",
-                      __func__, addr % ram_size, data);
+                      ", data :0x%x\n",
+                      __func__, addr % ram_size, le_data);
     }
 }
 
@@ -360,9 +370,10 @@ static const MemoryRegionOps aspeed_ram_capacity_ops = {
     .read = aspeed_ram_capacity_read,
     .write = aspeed_ram_capacity_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
     .valid = {
-        .min_access_size = 1,
-        .max_access_size = 8,
+        .min_access_size = 4,
+        .max_access_size = 4,
     },
 };
 
-- 
2.43.0


