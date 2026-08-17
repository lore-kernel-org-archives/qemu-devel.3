Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EACDC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxX5-0007Rx-R5; Mon, 17 Aug 2026 09:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWz-0007HF-K6; Mon, 17 Aug 2026 09:37:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxWx-0007ce-Ji; Mon, 17 Aug 2026 09:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=/AivCAJzVHHIwM7Ich4GKCuYDzoXBR9wL0S1Bfvgdo4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TqSmLGNadhMQP/dVlKTO0eVCj4/7JizYXyhSaI22/MUqLtksLpPNnSkAs6IkiDZPA
 /rdv71LG5FoK862J6dvxUNzqWWGr9XvMQt21C7FIsh2tAtFbajY1F+uX/3HJAWjyH2
 O1loTdmWtbOph75VO/dzvBz3sL+XTDhaQTckWN00eDYF1yfC/cyD4fyA5arI2qCKON
 VolGObzV2+PTF31QC1ZAbl4DsPO5FAFFHMdzKyk/Nff1+fAcpi63v6GJrECktAOSqo
 8krBNFgzwzb+HPjGqbkrE3Mk6Kj164PcmY0IY/BOR+OLZRkDkIgAIAjWGr4Vn7fgjm
 Y0TMoJx9WQBag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 716511CBCCD;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AC55240D42A;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id CDD2030FA4; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 126/135] tests/qtest/ide-test: cover raw
 (2352-byte) ATAPI CD reads
Date: Mon, 17 Aug 2026 16:34:36 +0300
Message-ID: <20260817133451.2384630-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Denis V. Lunev" <den@openvz.org>

READ CD with the field-selector set to 0xf8 returns full 2352-byte
raw sectors (sync + header + 2048 data + EDC/ECC), driving the ATAPI
raw read path that READ10 never touches. Add a send_scsi_cdb_read_cd()
helper and a CDROM_RAW flag to cdrom_read_impl(), then exercise both
PIO and DMA. The PIO case uses a byte-count limit spanning several
raw sectors so the device must rebuffer mid-burst, and each sector's
2048-byte payload is verified at its in-sector offset.

Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit 502dbdfd9687e967dfe5eefce7123ecf9baa798c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 6e59197566c..b36b0f8875b 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -48,6 +48,10 @@
 
 #define ATAPI_BLOCK_SIZE 2048
 
+/* Raw READ CD sector: 12 sync + 4 header + 2048 data + 288 EDC/ECC. */
+#define ATAPI_RAW_SIZE   2352
+#define ATAPI_RAW_DATA   16
+
 /* How many bytes to receive via ATAPI PIO at one time.
  * Must be less than 0xFFFF. */
 #define BYTE_COUNT_LIMIT 5120
@@ -982,6 +986,41 @@ static void send_scsi_cdb_read10(QPCIDevice *dev, QPCIBar ide_bar,
     }
 }
 
+typedef struct ReadCDCDB {
+    uint8_t opcode;
+    uint8_t sector_type;
+    uint32_t lba;
+    uint8_t length[3];
+    uint8_t main_channel;
+    uint8_t sub_channel;
+    uint8_t control;
+} __attribute__((__packed__)) ReadCDCDB;
+
+static void send_scsi_cdb_read_cd(QPCIDevice *dev, QPCIBar ide_bar,
+                                  uint64_t lba, int nblocks)
+{
+    ReadCDCDB pkt = { };
+    int i;
+
+    g_assert_cmpint(lba, <=, UINT32_MAX);
+    g_assert_cmpint(nblocks, >=, 0);
+    g_assert_cmpint(nblocks, <=, 0xffffff);
+
+    /* Construct SCSI CDB packet */
+    pkt.opcode = 0xbe;
+    pkt.lba = cpu_to_be32(lba);
+    pkt.length[0] = (nblocks >> 16) & 0xff;
+    pkt.length[1] = (nblocks >> 8) & 0xff;
+    pkt.length[2] = nblocks & 0xff;
+    pkt.main_channel = 0xf8; /* sync + headers + user data + EDC/ECC: 2352 */
+
+    /* Send Packet */
+    for (i = 0; i < sizeof(ReadCDCDB) / 2; i++) {
+        qpci_io_writew(dev, ide_bar, reg_data,
+                       le16_to_cpu(((uint16_t *)&pkt)[i]));
+    }
+}
+
 static void nsleep(QTestState *qts, int64_t nsecs)
 {
     const struct timespec val = { .tv_nsec = nsecs };
@@ -1036,10 +1075,12 @@ static void ide_wait_intr(QTestState *qts, int irq)
 
 #define CDROM_PIO 0
 #define CDROM_DMA (1 << 0)
+#define CDROM_RAW (1 << 1)
 
 static void cdrom_read_impl(int nblocks, unsigned flags)
 {
     bool dma = flags & CDROM_DMA;
+    bool raw = flags & CDROM_RAW;
     QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
@@ -1047,8 +1088,11 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
     int patt_blocks = MAX(16, nblocks);
     size_t patt_len = ATAPI_BLOCK_SIZE * patt_blocks;
     char *pattern = g_malloc(patt_len);
-    size_t rxsize = ATAPI_BLOCK_SIZE * nblocks;
+    unsigned xfer = raw ? ATAPI_RAW_SIZE : ATAPI_BLOCK_SIZE;
+    size_t rxsize = xfer * nblocks;
     uint16_t *rx = g_malloc0(rxsize);
+    void (*send_cdb)(QPCIDevice *, QPCIBar, uint64_t, int) =
+        raw ? send_scsi_cdb_read_cd : send_scsi_cdb_read10;
     int i, j;
     uint8_t data;
     uint16_t limit;
@@ -1075,8 +1119,7 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         prdt[0].size = cpu_to_le32(rxsize | PRDT_EOT);
 
         send_dma_request_dev(qts, dev, bmdma_bar, ide_bar, CMD_PACKET, 0,
-                             nblocks, prdt, ARRAY_SIZE(prdt),
-                             send_scsi_cdb_read10);
+                             nblocks, prdt, ARRAY_SIZE(prdt), send_cdb);
 
         qtest_memread(qts, guest_buf, rx, rxsize);
     } else {
@@ -1093,8 +1136,7 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         assert_bit_set(data, DRQ | DRDY);
         assert_bit_clear(data, ERR | DF | BSY);
 
-        /* SCSI CDB (READ10) -- read n*2048 bytes from block 0 */
-        send_scsi_cdb_read10(dev, ide_bar, 0, nblocks);
+        send_cdb(dev, ide_bar, 0, nblocks);
 
         /*
          * Read data back: occurs in bursts of 'BYTE_COUNT_LIMIT' bytes.
@@ -1134,7 +1176,17 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
         assert_bit_clear(data, DRQ | ERR | DF | BSY);
     }
 
-    g_assert_cmpint(memcmp(pattern, rx, rxsize), ==, 0);
+    if (raw) {
+        /* The 2048-byte payload of each raw sector sits past its header. */
+        for (i = 0; i < nblocks; i++) {
+            uint8_t *sec = (uint8_t *)rx + i * ATAPI_RAW_SIZE + ATAPI_RAW_DATA;
+
+            g_assert_cmpint(memcmp(sec, pattern + i * ATAPI_BLOCK_SIZE,
+                                   ATAPI_BLOCK_SIZE), ==, 0);
+        }
+    } else {
+        g_assert_cmpint(memcmp(pattern, rx, rxsize), ==, 0);
+    }
 
     g_free(pattern);
     g_free(rx);
@@ -1163,6 +1215,16 @@ static void test_cdrom_dma_large(void)
     cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_DMA);
 }
 
+static void test_cdrom_pio_raw(void)
+{
+    cdrom_read_impl(4, CDROM_RAW);
+}
+
+static void test_cdrom_dma_raw(void)
+{
+    cdrom_read_impl(4, CDROM_DMA | CDROM_RAW);
+}
+
 int main(int argc, char **argv)
 {
     const char *base;
@@ -1223,6 +1285,8 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
     qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
+    qtest_add_func("/ide/cdrom/pio_raw", test_cdrom_pio_raw);
+    qtest_add_func("/ide/cdrom/dma_raw", test_cdrom_dma_raw);
 
     ret = g_test_run();
 
-- 
2.47.3


