Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56763C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtL6-0008WE-6k; Mon, 17 Aug 2026 05:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtKX-0007Y2-Pi; Mon, 17 Aug 2026 05:08:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtKV-00026Y-RW; Mon, 17 Aug 2026 05:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=wpJ4qwOWfLctFNt+c0h25wbMLhJ2gqRgoIhDsjkq738=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Cu7LB7r8qosY1d7kPH9a2RJF/M7Q/B/Xvso1Ysei9jbrpGksZnYPuF+a4ux2jioMg
 yEB1phixRfCoizdbBTB/E0zDQehyO08/0Fpn3ZIlyKSvIPZfQv+XiEYClcwKbj9zC0
 kF90XQVSa1olJtCo5PTDNKxieeY/8+OizF3zlkM/3FzXyE/tNwu2fHqwk6OI8yjT5U
 Ypnl0LAEZ5c6KsjVNeZ8oCtbEFqRmEy7YHy6SPnwUP9cG5A2Za38XDY2wKvr7BgZHA
 b4fP1iGv16JNCPntoI8VSwlbGcHksJpt8W8IVmPM9VIekHupOHuiL/6gCBZyDZrHBV
 hWFVN8kG3CSvQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 928361CBA56;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 724E340D038;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 0F4E130D24; Mon, 17 Aug 2026 12:05:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 34/42] tests/qtest/ahci: cover raw (2352-byte) ATAPI
 CD reads
Date: Mon, 17 Aug 2026 12:04:39 +0300
Message-ID: <20260817090453.2034156-34-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
References: <qemu-stable-11.1.1-20260817111826@cover.tls.msk.ru>
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

Add /ahci/cdrom/{pio,dma}/raw: read several sectors with READ CD in
raw mode (atapi_raw), so the ATAPI 2352-byte unpack path is exercised
through the AHCI delivery, which IDE coverage does not reach. Each
sector's 2048-byte payload is verified at its in-sector offset.

The PIO case uses a byte-count limit of one raw sector per DRQ burst:
libqos asserts a one-sector PIO transfer, and the multi-sector unpack
loop is already covered by the IDE raw test.

Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit 31f13e71afd1cfb55b02c6977c829f0813ab439c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 44799eea153..58bc04b3efb 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1565,6 +1565,31 @@ static int ahci_cb_cmp_buff(AHCIQState *ahci, AHCICommand *cmd,
     return 0;
 }
 
+static int ahci_cb_cmp_raw(AHCIQState *ahci, AHCICommand *cmd,
+                           const AHCIOpts *opts)
+{
+    unsigned char *tx = opts->opaque;
+    unsigned char *rx;
+    unsigned i, nsectors;
+
+    if (!opts->size) {
+        return 0;
+    }
+
+    nsectors = opts->size / ATAPI_RAW_SECTOR_SIZE;
+    rx = g_malloc0(opts->size);
+    qtest_bufread(ahci->parent->qts, opts->buffer, rx, opts->size);
+    /* Each raw sector carries its 2048-byte payload past a 16-byte header. */
+    for (i = 0; i < nsectors; i++) {
+        g_assert_cmphex(memcmp(rx + i * ATAPI_RAW_SECTOR_SIZE + 16,
+                               tx + i * ATAPI_SECTOR_SIZE,
+                               ATAPI_SECTOR_SIZE), ==, 0);
+    }
+    g_free(rx);
+
+    return 0;
+}
+
 static void ahci_test_cdrom(int nsectors, bool dma, uint8_t cmd,
                             bool override_bcl, uint16_t bcl)
 {
@@ -1625,6 +1650,47 @@ static void test_cdrom_pio_multi(void)
     ahci_test_cdrom_read10(3, false);
 }
 
+static void ahci_test_cdrom_raw(int nsectors, bool dma)
+{
+    AHCIQState *ahci;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    AHCIOpts opts = {
+        .size = (uint64_t)ATAPI_RAW_SECTOR_SIZE * nsectors,
+        .atapi = true,
+        .atapi_dma = dma,
+        .atapi_raw = true,
+        .set_bcl = true,
+        .bcl = ATAPI_RAW_SECTOR_SIZE, /* one raw sector per DRQ burst */
+        .post_cb = ahci_cb_cmp_raw,
+    };
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * (nsectors + 1);
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+    opts.opaque = tx;
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,file=%s,format=raw "
+                                "-M q35 "
+                                "-device ide-cd,drive=drive0 ", iso);
+
+    ahci_exec(ahci, ahci_port_select(ahci), CMD_ATAPI_READ_CD, &opts);
+
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_cdrom_dma_raw(void)
+{
+    ahci_test_cdrom_raw(3, true);
+}
+
+static void test_cdrom_pio_raw(void)
+{
+    ahci_test_cdrom_raw(3, false);
+}
+
 /*
  * Regression test: a buffered ATAPI read completing after a command
  * engine restart must not dereference the cleared cur_cmd. Cover both
@@ -2100,8 +2166,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/dma/single", test_cdrom_dma);
     qtest_add_func("/ahci/cdrom/dma/multi", test_cdrom_dma_multi);
+    qtest_add_func("/ahci/cdrom/dma/raw", test_cdrom_dma_raw);
     qtest_add_func("/ahci/cdrom/pio/single", test_cdrom_pio);
     qtest_add_func("/ahci/cdrom/pio/multi", test_cdrom_pio_multi);
+    qtest_add_func("/ahci/cdrom/pio/raw", test_cdrom_pio_raw);
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
-- 
2.47.3


