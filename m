Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81220C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6kKg-0006N8-Is; Wed, 16 Sep 2026 03:45:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kKZ-00066h-34; Wed, 16 Sep 2026 03:45:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1x6kKX-000520-8D; Wed, 16 Sep 2026 03:45:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1789544605; bh=9KSDexL2jFPWx8fQO4DDDN2LzRknMZSOyzdf5oS754I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JOUjQfPHfSkEa+q5+NOtp33hqdYa+cyZfEl8YNO5qDDOlUABVYnmEBirUayIoCti/
 wqZSTcjILVb+c1AunOlxoDiU4hi3ngw7NMG5wJKFIZZuTvo+WSbKN1sMyejOiDsoS2
 8dPkqfd2E7BnmimfTA8ntqwMMSngFaLzQTd5mXXPO+v0zIbLYyQVB/Uaelr/QIOdH+
 EvEe+3iBtQ3mW9em9Y3yYFbjk452GLA9CFxmPYYrnkzMQ8p1UQi+QvnlhAR930Im4+
 pP10mhPf1ocQf/XE19Z1cUCDMTMjfcWwi4Xn/zLoWGO5pBhW5MjNUM5hn25qlv2z2W
 cqCpACV4f4Wpg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6B4781D559D;
 Wed, 16 Sep 2026 10:43:25 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E716E429B31;
 Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C090D5A6E3; Wed, 16 Sep 2026 10:44:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 17/49] tests/qtest/ide-test: cover a CHS translation
 with zero sectors
Date: Wed, 16 Sep 2026 10:42:35 +0300
Message-ID: <20260916074346.671467-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260916104135@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Ask for zero sectors per logical track via INITIALIZE DEVICE PARAMETERS
and check that the command is aborted, that IDENTIFY DEVICE still reports
the translation that was in effect before, and that a CHS read then
completes normally rather than killing QEMU with SIGFPE.

Cc: John Snow <jsnow@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit 0905ef5b6d483da0e27831152fdde059595244b9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index b36b0f8875b..99aa5e039ca 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -95,6 +95,7 @@ enum {
 
 enum {
     CMD_DSM         = 0x06,
+    CMD_READ        = 0x20,  /* READ SECTOR(S) */
     CMD_DIAGNOSE    = 0x90,
     CMD_INIT_DP     = 0x91,  /* INITIALIZE DEVICE PARAMETERS */
     CMD_READ_DMA    = 0xc8,
@@ -1194,6 +1195,66 @@ static void cdrom_read_impl(int nblocks, unsigned flags)
     free_pci_device(dev);
 }
 
+/* Zero sectors per track has to abort (ATA-5 8.16.6), not divide by zero */
+static void test_specify_zero_sectors(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint16_t buf[256];
+    uint8_t data;
+    int i;
+
+    qts = ide_test_start(
+        "-blockdev driver=file,node-name=hda,filename=%s "
+        "-device ide-hd,drive=hda,bus=ide.0,unit=0 ",
+        tmp_path[0]);
+
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_INIT_DP);
+
+    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), ERR);
+    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_error), ABRT);
+
+    /* The refused request has to leave the default translation in effect */
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_IDENTIFY);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+    g_assert_cmpint(buf[55], ==, 16);
+    g_assert_cmpint(buf[56], ==, 63);
+
+    /* READ SECTOR(S) of CHS 0/0/1, which used to crash QEMU */
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_low, 1);
+    qpci_io_writeb(dev, ide_bar, reg_lba_middle, 0);
+    qpci_io_writeb(dev, ide_bar, reg_lba_high, 0);
+    qpci_io_writeb(dev, ide_bar, reg_device, 0);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_READ);
+
+    data = ide_wait_clear(qts, BSY);
+    assert_bit_set(data, DRQ);
+    assert_bit_clear(data, ERR | DF);
+    for (i = 0; i < 256; i++) {
+        buf[i] = qpci_io_readw(dev, ide_bar, reg_data);
+    }
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), ERR | DF | DRQ);
+
+    /* A supported translation is still accepted */
+    qpci_io_writeb(dev, ide_bar, reg_nsectors, 32);
+    qpci_io_writeb(dev, ide_bar, reg_device, 7);
+    qpci_io_writeb(dev, ide_bar, reg_command, CMD_INIT_DP);
+
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), ERR);
+
+    ide_test_quit(qts);
+    free_pci_device(dev);
+}
+
 static void test_cdrom_pio(void)
 {
     cdrom_read_impl(1, CDROM_PIO);
@@ -1265,6 +1326,7 @@ int main(int argc, char **argv)
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("/ide/read_native", test_specify);
+    qtest_add_func("/ide/specify/zero_sectors", test_specify_zero_sectors);
 
     qtest_add_func("/ide/identify", test_identify);
 
-- 
2.47.3


