Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A841CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIZ-0002Pl-Dp; Fri, 19 Jun 2026 07:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIT-0002KV-QC; Fri, 19 Jun 2026 07:22:05 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yE-Gu; Fri, 19 Jun 2026 07:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=HDmHPaxM6C21e+ZsQUic2L14EvzMb+/7ZwV5Ke4z/vU=; b=B+mLwiWjEoHw
 0NnGsbqZwsiB35dtytjSjm10HXgO3j7UB1POLiU/95XBnvAHHyjMdU3FWV77yMnQVR7q0MEmSSpSg
 xxv7IAdcg/LcJH1oKeFhSqQZF64MeIQiLC+amhtmvKpl9Vek4Dd6hatKqh3whfii6TkUclNrssRAr
 LYyXA0YJVWc2Vvs7O0oucRvnnWaH+amRCH1YFBQXO3McZ8s7gzyhOdNjt0kLnGWfjSeEILdgCPexM
 6SQTjas0+p/dX+zFBU+s8G7BMpy0bnNAJq33sJygeSovGeA7fhHPr5RJgIoGjFKm13I+e/ldOCsk2
 WoqUgtugk4c06gjEY61J0w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHo-0089QU-11;
 Fri, 19 Jun 2026 13:21:56 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 3/9] tests/qtest/ide-test: parametrize the ATAPI CD-ROM read
 test
Date: Fri, 19 Jun 2026 13:21:51 +0200
Message-ID: <20260619112158.304782-4-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619112158.304782-1-den@openvz.org>
References: <20260619112158.304782-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

cdrom_pio_impl() and test_cdrom_dma() duplicate the same image setup
and data-integrity check around two different transfer mechanisms.
Fold them into a single cdrom_read_impl(nblocks, flags) helper, with a
CDROM_PIO/CDROM_DMA flag selecting the transfer, so further read
coverage can be added once for both paths.

No functional change: /ide/cdrom/pio, pio_large and dma run exactly
as before.

Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 tests/qtest/ide-test.c | 146 +++++++++++++++++++----------------------
 1 file changed, 68 insertions(+), 78 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 721e78170b..0fcfd0688c 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -982,6 +982,7 @@ static void send_scsi_cdb_read10(QPCIDevice *dev, QPCIBar ide_bar,
     }
 }
 
+
 static void nsleep(QTestState *qts, int64_t nsecs)
 {
     const struct timespec val = { .tv_nsec = nsecs };
@@ -1034,8 +1035,12 @@ static void ide_wait_intr(QTestState *qts, int irq)
     g_assert_not_reached();
 }
 
-static void cdrom_pio_impl(int nblocks)
+#define CDROM_PIO 0
+#define CDROM_DMA (1 << 0)
+
+static void cdrom_read_impl(int nblocks, unsigned flags)
 {
+    bool dma = flags & CDROM_DMA;
     QTestState *qts;
     QPCIDevice *dev;
     QPCIBar bmdma_bar, ide_bar;
@@ -1063,57 +1068,75 @@ static void cdrom_pio_impl(int nblocks)
     dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
     qtest_irq_intercept_in(qts, "ioapic");
 
-    /* PACKET command on device 0 */
-    qpci_io_writeb(dev, ide_bar, reg_device, 0);
-    qpci_io_writeb(dev, ide_bar, reg_lba_middle, BYTE_COUNT_LIMIT & 0xFF);
-    qpci_io_writeb(dev, ide_bar, reg_lba_high, (BYTE_COUNT_LIMIT >> 8 & 0xFF));
-    qpci_io_writeb(dev, ide_bar, reg_command, CMD_PACKET);
-    /* HP0: Check_Status_A State */
-    nsleep(qts, 400);
-    data = ide_wait_clear(qts, BSY);
-    /* HP1: Send_Packet State */
-    assert_bit_set(data, DRQ | DRDY);
-    assert_bit_clear(data, ERR | DF | BSY);
-
-    /* SCSI CDB (READ10) -- read n*2048 bytes from block 0 */
-    send_scsi_cdb_read10(dev, ide_bar, 0, nblocks);
-
-    /* Read data back: occurs in bursts of 'BYTE_COUNT_LIMIT' bytes.
-     * If BYTE_COUNT_LIMIT is odd, we transfer BYTE_COUNT_LIMIT - 1 bytes.
-     * We allow an odd limit only when the remaining transfer size is
-     * less than BYTE_COUNT_LIMIT. However, SCSI's read10 command can only
-     * request n blocks, so our request size is always even.
-     * For this reason, we assume there is never a hanging byte to fetch. */
-    g_assert(!(rxsize & 1));
-    limit = BYTE_COUNT_LIMIT & ~1;
-    for (i = 0; i < DIV_ROUND_UP(rxsize, limit); i++) {
-        size_t offset = i * (limit / 2);
-        size_t rem = (rxsize / 2) - offset;
-
-        /* HP3: INTRQ_Wait */
-        ide_wait_intr(qts, IDE_PRIMARY_IRQ);
+    if (dma) {
+        uintptr_t guest_buf = guest_alloc(&guest_malloc, rxsize);
+        PrdtEntry prdt[1];
+
+        prdt[0].addr = cpu_to_le32(guest_buf);
+        prdt[0].size = cpu_to_le32(rxsize | PRDT_EOT);
 
-        /* HP2: Check_Status_B (and clear IRQ) */
+        send_dma_request_dev(qts, dev, bmdma_bar, ide_bar, CMD_PACKET, 0,
+                             nblocks, prdt, ARRAY_SIZE(prdt),
+                             send_scsi_cdb_read10);
+
+        qtest_memread(qts, guest_buf, rx, rxsize);
+    } else {
+        /* PACKET command on device 0 */
+        qpci_io_writeb(dev, ide_bar, reg_device, 0);
+        qpci_io_writeb(dev, ide_bar, reg_lba_middle, BYTE_COUNT_LIMIT & 0xFF);
+        qpci_io_writeb(dev, ide_bar, reg_lba_high,
+                       (BYTE_COUNT_LIMIT >> 8 & 0xFF));
+        qpci_io_writeb(dev, ide_bar, reg_command, CMD_PACKET);
+        /* HP0: Check_Status_A State */
+        nsleep(qts, 400);
         data = ide_wait_clear(qts, BSY);
+        /* HP1: Send_Packet State */
         assert_bit_set(data, DRQ | DRDY);
         assert_bit_clear(data, ERR | DF | BSY);
 
-        /* HP4: Transfer_Data */
-        for (j = 0; j < MIN((limit / 2), rem); j++) {
-            rx[offset + j] = cpu_to_le16(qpci_io_readw(dev, ide_bar,
-                                                       reg_data));
+        /* SCSI CDB (READ10) -- read n*2048 bytes from block 0 */
+        send_scsi_cdb_read10(dev, ide_bar, 0, nblocks);
+
+        /*
+         * Read data back: occurs in bursts of 'BYTE_COUNT_LIMIT' bytes.
+         * If BYTE_COUNT_LIMIT is odd, we transfer BYTE_COUNT_LIMIT - 1 bytes.
+         * We allow an odd limit only when the remaining transfer size is
+         * less than BYTE_COUNT_LIMIT. However, SCSI's read10 command can only
+         * request n blocks, so our request size is always even.
+         * For this reason, we assume there is never a hanging byte to fetch.
+         */
+        g_assert(!(rxsize & 1));
+        limit = BYTE_COUNT_LIMIT & ~1;
+        for (i = 0; i < DIV_ROUND_UP(rxsize, limit); i++) {
+            size_t offset = i * (limit / 2);
+            size_t rem = (rxsize / 2) - offset;
+
+            /* HP3: INTRQ_Wait */
+            ide_wait_intr(qts, IDE_PRIMARY_IRQ);
+
+            /* HP2: Check_Status_B (and clear IRQ) */
+            data = ide_wait_clear(qts, BSY);
+            assert_bit_set(data, DRQ | DRDY);
+            assert_bit_clear(data, ERR | DF | BSY);
+
+            /* HP4: Transfer_Data */
+            for (j = 0; j < MIN((limit / 2), rem); j++) {
+                rx[offset + j] = cpu_to_le16(qpci_io_readw(dev, ide_bar,
+                                                           reg_data));
+            }
         }
-    }
 
-    /* Check for final completion IRQ */
-    ide_wait_intr(qts, IDE_PRIMARY_IRQ);
+        /* Check for final completion IRQ */
+        ide_wait_intr(qts, IDE_PRIMARY_IRQ);
 
-    /* Sanity check final state */
-    data = ide_wait_clear(qts, DRQ);
-    assert_bit_set(data, DRDY);
-    assert_bit_clear(data, DRQ | ERR | DF | BSY);
+        /* Sanity check final state */
+        data = ide_wait_clear(qts, DRQ);
+        assert_bit_set(data, DRDY);
+        assert_bit_clear(data, DRQ | ERR | DF | BSY);
+    }
 
     g_assert_cmpint(memcmp(pattern, rx, rxsize), ==, 0);
+
     g_free(pattern);
     g_free(rx);
     test_bmdma_teardown(qts);
@@ -1122,51 +1145,18 @@ static void cdrom_pio_impl(int nblocks)
 
 static void test_cdrom_pio(void)
 {
-    cdrom_pio_impl(1);
+    cdrom_read_impl(1, CDROM_PIO);
 }
 
 static void test_cdrom_pio_large(void)
 {
     /* Test a few loops of the PIO DRQ mechanism. */
-    cdrom_pio_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE);
+    cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_PIO);
 }
 
-
 static void test_cdrom_dma(void)
 {
-    QTestState *qts;
-    static const size_t len = ATAPI_BLOCK_SIZE;
-    size_t ret;
-    char *pattern = g_malloc(ATAPI_BLOCK_SIZE * 16);
-    char *rx = g_malloc0(len);
-    uintptr_t guest_buf;
-    PrdtEntry prdt[1];
-    FILE *fh;
-
-    qts = ide_test_start(
-            "-drive if=none,file=%s,media=cdrom,format=raw,id=sr0,index=0 "
-            "-device ide-cd,drive=sr0,bus=ide.0", tmp_path[0]);
-    qtest_irq_intercept_in(qts, "ioapic");
-
-    guest_buf = guest_alloc(&guest_malloc, len);
-    prdt[0].addr = cpu_to_le32(guest_buf);
-    prdt[0].size = cpu_to_le32(len | PRDT_EOT);
-
-    generate_pattern(pattern, ATAPI_BLOCK_SIZE * 16, ATAPI_BLOCK_SIZE);
-    fh = fopen(tmp_path[0], "wb+");
-    ret = fwrite(pattern, ATAPI_BLOCK_SIZE, 16, fh);
-    g_assert_cmpint(ret, ==, 16);
-    fclose(fh);
-
-    send_dma_request(qts, CMD_PACKET, 0, 1, prdt, 1, send_scsi_cdb_read10);
-
-    /* Read back data from guest memory into local qtest memory */
-    qtest_memread(qts, guest_buf, rx, len);
-    g_assert_cmpint(memcmp(pattern, rx, len), ==, 0);
-
-    g_free(pattern);
-    g_free(rx);
-    test_bmdma_teardown(qts);
+    cdrom_read_impl(1, CDROM_DMA);
 }
 
 int main(int argc, char **argv)
-- 
2.53.0


