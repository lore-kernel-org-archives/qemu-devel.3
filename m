Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4AFC3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHqi-0000TJ-53; Thu, 04 Jul 2024 04:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sPHqg-0000Ss-S2; Thu, 04 Jul 2024 04:29:50 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1sPHqf-0002HT-9N; Thu, 04 Jul 2024 04:29:50 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 4 Jul
 2024 16:29:23 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 4 Jul 2024 16:29:23 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC
 here" <qemu-devel@nongnu.org>, "open list:Block layer core"
 <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v3 4/8] hw/net:ftgmac100: update TX and RX packet buffers
 address to 64 bits
Date: Thu, 4 Jul 2024 16:29:18 +0800
Message-ID: <20240704082922.1464317-5-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
References: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_FAIL=0.001,
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

ASPEED AST2700 SOC is a 64 bits quad core CPUs (Cortex-a35)
And the base address of dram is "0x4 00000000" which
is 64bits address.

It have "TXDES 2" and "RXDES 2" to save the high part
physical address of packet buffer.
Ex: TX packet buffer address [34:0]
The "TXDES 2" bits [18:16] which corresponds the bits [34:32]
of the 64 bits address of the TX packet buffer address
and "TXDES 3" bits [31:0] which corresponds the bits [31:0]
of the 64 bits address of the TX packet buffer address.

Update TX and RX packet buffers address type to
64 bits for dram 64 bits address DMA support.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 hw/net/ftgmac100.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 68956aeb94..80f9cd56d5 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -175,6 +175,8 @@
 #define FTGMAC100_TXDES1_TX2FIC          (1 << 30)
 #define FTGMAC100_TXDES1_TXIC            (1 << 31)
 
+#define FTGMAC100_TXDES2_TXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
+
 /*
  * Receive descriptor
  */
@@ -208,13 +210,15 @@
 #define FTGMAC100_RXDES1_UDP_CHKSUM_ERR  (1 << 26)
 #define FTGMAC100_RXDES1_IP_CHKSUM_ERR   (1 << 27)
 
+#define FTGMAC100_RXDES2_RXBUF_BADR_HI(x)   (((x) >> 16) & 0x7)
+
 /*
  * Receive and transmit Buffer Descriptor
  */
 typedef struct {
     uint32_t        des0;
     uint32_t        des1;
-    uint32_t        des2;        /* not used by HW */
+    uint32_t        des2;        /* used by HW 64 bits DMA */
     uint32_t        des3;
 } FTGMAC100Desc;
 
@@ -531,6 +535,7 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
     int frame_size = 0;
     uint8_t *ptr = s->frame;
     uint64_t addr = tx_descriptor;
+    uint64_t buf_addr = 0;
     uint32_t flags = 0;
 
     while (1) {
@@ -569,7 +574,12 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
             len =  sizeof(s->frame) - frame_size;
         }
 
-        if (dma_memory_read(&address_space_memory, bd.des3,
+        buf_addr = bd.des3;
+        if (s->dma64) {
+            buf_addr = deposit64(buf_addr, 32, 32,
+                                 FTGMAC100_TXDES2_TXBUF_BADR_HI(bd.des2));
+        }
+        if (dma_memory_read(&address_space_memory, buf_addr,
                             ptr, len, MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to read packet @ 0x%x\n",
                           __func__, bd.des3);
@@ -1022,7 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
     uint32_t flags = 0;
     uint64_t addr;
     uint32_t crc;
-    uint32_t buf_addr;
+    uint64_t buf_addr = 0;
     uint8_t *crc_ptr;
     uint32_t buf_len;
     size_t size = len;
@@ -1087,7 +1097,12 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
         if (size < 4) {
             buf_len += size - 4;
         }
+
         buf_addr = bd.des3;
+        if (s->dma64) {
+            buf_addr = deposit64(buf_addr, 32, 32,
+                                 FTGMAC100_RXDES2_RXBUF_BADR_HI(bd.des2));
+        }
         if (first && proto == ETH_P_VLAN && buf_len >= 18) {
             bd.des1 = lduw_be_p(buf + 14) | FTGMAC100_RXDES1_VLANTAG_AVAIL;
 
-- 
2.34.1


