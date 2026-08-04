Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B2FDC5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIVJ-0008WN-1O; Tue, 04 Aug 2026 13:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV6-0008Ts-KX
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV3-0000gN-RB
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:24 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47fd4531020so4053f8f.3
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785862820; x=1786467620; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F2xBTzfUJPYodvc2TaugF6oZDBuV9NLPBQJx1TnV3Es=;
 b=gCPkih+SgAzrV7Iy1P33lXbZ0LrjV4d4NGC/KUybAlO/26dBR4q4n+eTHcAkCfgYcT
 NjuQmuuykKPimCsv4JWyhvYhQCBI64ZzPx/9MIcMXOmH7/Y5C/74yX2xaWCdTNVzlb6I
 lK3uojTN5d4SHiXsP0p1WYCgeBqZfcK2V/T6KkefJMvG9pSM4QHPdO7pHj3gof5YqwUI
 5MpXWN7Z0khnNLKWxb+l4zY9X2mbiLWjLW6KIqtM+1Q4TVtlBIN+i5pOquOKgX4Uou5r
 Gha8y6jokguD2Y8Vg87bezIFW55O3QqM2NL41GpDCgJjJ9JEXtMUgTT6KOXuHaqC7ts6
 sCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785862820; x=1786467620;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F2xBTzfUJPYodvc2TaugF6oZDBuV9NLPBQJx1TnV3Es=;
 b=Y6Ty9JWEmcvxKbMn2N13NH7nR7rUrtuM9ydxEsXT9jofOeDA0Gqr6AqB9PxmV96zFO
 scTS1TFwL9RSVsrovPXDszSXIUPbbUIx8iDoSrqe2cyRNWqbx9dYBod/igopURbG1U25
 /PvGoQUakjoIH56ay9MnmwHyYpjfgzVsEXXYE72I1PoL7Rxj6RdYfXFNwcMMbLKWWj4p
 /kR5uXQs95oYP9FvWo2Y0pVxejCuqOH6H84Hvh4p24VtE5y3mjGijp3DQ/H7n8chfG2v
 Odtgj5RfXZhh/iWE6rYQ+mfOPGjVDHJaO8iLncv/Y1KjRJuVM0cTa54QJMVb8i0QTjrq
 9PVQ==
X-Gm-Message-State: AOJu0Yx8bU2vJCyDte/g7bzU+ZAWxBPRHoNi1tmkT4CuFB+wMtk3h0VP
 1mirl5RDL9eVMcnTU0LO8vclC88Cnc/ThU3yL48vfwfp9hBi26KqnsnbzGHYoEnR0No0Ggjq9n+
 WaYVU
X-Gm-Gg: AR+sD107X/i7c3Okw24qa3KrMhec0q0Bm44srEz/LK+rT5kV1UwsugMTUBWQ5wA4scu
 Sbo52OybFtaUsbXU0R1m5dCmOMfbIh2pLgmy7BpdByIQLBre1xoVbMZkRmXgvBa/XGO0c9eC3NO
 1TZd/KTRf6FRFzf1lnkBQK/92xUc7N3vkpiw12jiBZRx5mJuZwkm22az2tE6Un4XUDAB4t8+VaW
 Q2/1qpap9Gxm2mNyqN2xqKQQuHTa8qCTkLifWeVbdawbtNNDVKRa9UXNjx4Gvo4/hO2L27iyGjL
 wmcs0ZpSOlw+75Ni9jQ83JEj4Mc2Te2JFTHSGsaNQoXiDggo86Z1tN/SLgnUyIIIxXVW7EE4G7M
 O03kDq5nGJd0PSbQiVGqYMsLD/vMTKtLfZUf6X7piHW8wc6fIz2srmqErVJ3J482PPvF89B6Clg
 AQM/3GE5fohYRawAFrHlXoQ7uH9zWwN1wKibzvYGM6lKuu1lcy3Yz9FqxZ
X-Received: by 2002:adf:e010:0:10b0:47f:8ce7:8684 with SMTP id
 ffacd0b85a97d-47fec509a94mr1025169f8f.6.1785862819613; 
 Tue, 04 Aug 2026 10:00:19 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ec3asm1234116f8f.31.2026.08.04.10.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:00:19 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 1/7] tests/qtest/ide-test: parametrize the ATAPI CD-ROM read
 test
Date: Tue,  4 Aug 2026 19:00:08 +0200
Message-ID: <20260804170015.3128363-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
References: <20260804170015.3128363-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=den@openvz.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

cdrom_pio_impl() and test_cdrom_dma() duplicate the same image setup
and data-integrity check around two different transfer mechanisms.
Fold them into a single cdrom_read_impl(nblocks, flags) helper, with a
CDROM_PIO/CDROM_DMA flag selecting the transfer, so further read
coverage can be added once for both paths.

No functional change: /ide/cdrom/pio, pio_large and dma run exactly
as before.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ide-test.c | 145 +++++++++++++++++++----------------------
 1 file changed, 67 insertions(+), 78 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index 721e78170b..c97bc17b67 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1034,8 +1034,12 @@ static void ide_wait_intr(QTestState *qts, int irq)
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
@@ -1063,57 +1067,75 @@ static void cdrom_pio_impl(int nblocks)
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
+
+        send_dma_request_dev(qts, dev, bmdma_bar, ide_bar, CMD_PACKET, 0,
+                             nblocks, prdt, ARRAY_SIZE(prdt),
+                             send_scsi_cdb_read10);
 
-        /* HP2: Check_Status_B (and clear IRQ) */
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
@@ -1122,51 +1144,18 @@ static void cdrom_pio_impl(int nblocks)
 
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


