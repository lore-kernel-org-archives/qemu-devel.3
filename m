Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B233FC531D0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 08:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpLtc-00076T-MY; Thu, 30 Jul 2026 04:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtZ-00073z-L1
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:38 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wpLtW-00017n-DF
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 04:13:37 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c1600d040e4so70843266b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 01:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785399210; x=1786004010; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yQ95Hp3xG7blxC3k2gZtENUvUyl9KF6zkriWUqkC8Bg=;
 b=bSZ1ARtTyv0qcN3w3OwNgNaK97Vbf5EmmV6vET4oqfHpPIzUUCtU7dHGBrg1AYJRn3
 VxiZeiunoF83YYdmiwxqXmuYX0ZrsqdEzyCymiRt5zACffPlChrCictV/oMUlLz+Uup2
 n5mm8UjV0yE3m1vSsFZmfKNdXgvxcGXt9Y8JKQ4RUaap2SRB3XiZ40+MkzJINHX0/tYJ
 lX+ovNR1vhEdL3uL6vK85nv+voCU7jnwWnPlGQ8xOYa7aRR5eQmuFmAfQAq2Ezo30UC2
 STf2hByLAJjJQ7oqQuxuW5k4TILrIt1kyk/zAxCGoStIIFj6899FDmOvFroulh/XYMOY
 Q2Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785399210; x=1786004010;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yQ95Hp3xG7blxC3k2gZtENUvUyl9KF6zkriWUqkC8Bg=;
 b=PbaFPHszqeRFOFXoG+pt8/diAOo7f/yGEBOiJ/ubNlT4WbO1F8i/7vpt98TFQDqlyr
 2dDyd7Sn6KqHzFhvySFihP1kXErx0HZ6sVU83OgMDNtGsIMYWpMu1AxjePNRtXEpRO5R
 vzZyQEmWk2ixL8VYLPxPDDQB6FmnQAt4Mgbu6TNWq6KNhVf2Jut0zpcsIaxLpO39BeIw
 nX12Emwjm5NXw4eT9ncAZFUMN9GrlPmfXlWDnJOYPtLPNgHtx4tMJe0ChphMusqbVuwX
 HBBAt6bCGIS34ijMJhbzGviBwBFkV0Fy6bxy9qlFIUilm93XodkXrX/dGN8ebZD9qbxV
 CX1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+X4um+Mou179IGGk54hMPM5ycEzeHcR3dAsiG01n3rhbdCTq0sE4DLmU07EbwDfAiopSOIJ8Gi2pE@nongnu.org
X-Gm-Message-State: AOJu0YzaRMs5FVpzGdmVx/RlwtxmTmzN72qzTqDWNvdG9iQGZ2YSbUta
 xNkzEYkw5vkCSQv2fdd9PXsLXpWzFP0bwW8pGt9qSBzgSWum76BMJl13+qYg+ff/ja0=
X-Gm-Gg: AR+sD10akUXL1QE/DQwuc6MTs/PkYvpRDGAhDSflf+dW+Lnlf9NkZdcJpYEqaQjiPGm
 J52mtyh5Od76CwxwLJO5I4f6ehEUajmJdTDSuxg5ddD1qHgqQHEvP+j//afQjaAge9HHDqh4qR+
 IXAJew6JJa/gvrdYQDk39eKySgGP4J4+us7tzBbHJ+hNziKf9l/XfJ3AX+2lxdlA7xegkECdbGf
 nUcswvEokz3ulVfPaMkZa34HKBNT/OmUArDqqMoFlXCon7w5gvzzFD7SIi5OQbwpETRDPOs1m77
 P1q9Wi2xMxRLxCXMKrPjQ4FRjmjUcw0g1ySTR0jrVKLIDi1Kkq1p98rBt0OO16U+O1Uabt4s81L
 rv5vgEnweiOaBmIz78LPaZEMj0jhmRZgsAOaq/W4n0J5dybPXvf/lU74+FVRITOlQTw3cr0oODZ
 TYmCpx/5D8r4NiubkOflP80bT11u/BtdF8siIXFxxgIkCz7RmIlA==
X-Received: by 2002:a17:907:a60b:b0:c1f:e5f:4d2d with SMTP id
 a640c23a62f3a-c1fad038c03mr57940266b.19.1785399210078; 
 Thu, 30 Jul 2026 01:13:30 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:871f:1fb4:356b:23d9])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1fa857c8e1sm38373466b.19.2026.07.30.01.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 01:13:29 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 2/8] tests/qtest/ide-test: parametrize the ATAPI CD-ROM read
 test
Date: Thu, 30 Jul 2026 10:13:18 +0200
Message-ID: <20260730081325.1816193-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730081325.1816193-1-den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=den@openvz.org; helo=mail-ej1-x632.google.com
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


