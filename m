Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BEFC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtLL-0000Xk-PP; Mon, 17 Aug 2026 05:09:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtKb-00082W-BB; Mon, 17 Aug 2026 05:08:33 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvtKZ-00029a-Ax; Mon, 17 Aug 2026 05:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786957506; bh=aeVqwZDYR8in3AsS7dcZFP/bkX0h7xx7YfnL2FW+WSE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=l3Gq/hfp0AL29m0xeUmoNJPwljVLznaXR02Yc5ZJtMZXWSXNBXFZLQc9ug9la0dmV
 mkp6kHsSwkkFD4pnVJfXCy2S0mkbrKdmi4kGMrtw4SAJQlkSRPxJqy6H8i7lR/Yy4Y
 7QRi51IaYAzn3q2Im6oB8n/ZLG660qXKJgaX4J6HTHuYDpuaO37ggWSSQZSFIjEOhX
 mKx+sgGqnpmPY4XHnF2pWW3tsimqZBUDXAwTNZvBH9OrQ8pXCIqDNDnk8ocnDmytPG
 Dz0WynEtIJmHCFFCTSv+Et3jQsCOEm5v5YbqrxkXbiVdkqmilXjT+nyVmcoqcmMG8Z
 5xULevRiU9hVg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C7101CBA58;
 Mon, 17 Aug 2026 12:05:06 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7BC2340D03A;
 Mon, 17 Aug 2026 12:05:27 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 1530330D28; Mon, 17 Aug 2026 12:05:01 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.1 36/42] tests/qtest/ahci: regression test for ATAPI
 read vs. drain
Date: Mon, 17 Aug 2026 12:04:41 +0300
Message-ID: <20260817090453.2034156-36-mjt@tls.msk.ru>
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

Add /ahci/cdrom/drain/{pio,dma}: issue a multi-sector ATAPI read whose
byte-count limit spans two sectors so the device must rebuffer in the
middle of the DRQ burst, hold the backend read in flight with a
blkdebug delay, and fire x-blockdev-set-iothread -- which runs
bdrv_drain_all_begin() exactly like a guest reset does through
virtio_blk_stop_ioeventfd().

On the unfixed PIO path the nested sector fetch is queued behind the
drain and the main loop wedges, so the test hangs. The DMA variant
never rebuffers and serves as a sanity twin.

Signed-off-by: Denis V. Lunev <den@openvz.org>
(cherry picked from commit be1ee6a8f6e3b7192d57e900497b81a048f8d193)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 58bc04b3efb..71d23fe56af 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1754,6 +1754,70 @@ static void test_atapi_engine_restart_dma(void)
     test_atapi_engine_restart_in_flight(true);
 }
 
+/*
+ * Regression test: a multi-sector ATAPI read fetches its later sectors from
+ * inside the first read's completion; a concurrent drain (as a guest reset
+ * triggers via bdrv_drain_all_begin) must not wedge on that nested read.
+ * blkdebug keeps the read in flight across x-blockdev-set-iothread.
+ */
+static void test_atapi_drain_in_flight(bool dma)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    uint8_t port;
+    uint64_t buffer;
+    uint16_t bcl = ATAPI_SECTOR_SIZE * 2;
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * 3;
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+
+    /* 1s read delay: a wide margin so the drain starts before it completes */
+    ahci = ahci_boot_and_enable(
+        "-blockdev driver=file,node-name=file0,filename=%s,read-only=on "
+        "-blockdev driver=blkdebug,node-name=cd0,image=file0,read-only=on,"
+        "inject-error.0.event=none,inject-error.0.iotype=read,"
+        "inject-error.0.errno=0,inject-error.0.delay-ns=1000000000 "
+        "-M q35 "
+        "-device ide-cd,drive=cd0 ", iso);
+    port = ahci_port_select(ahci);
+
+    buffer = ahci_alloc(ahci, bcl);
+    qtest_memset(ahci->parent->qts, buffer, 0x00, bcl);
+
+    cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, bcl, dma);
+    ahci_command_adjust(cmd, 0, buffer, bcl, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Drain (all nodes) while the delayed read is still in flight. */
+    qtest_qmp_assert_success(ahci->parent->qts,
+        "{ 'execute': 'x-blockdev-set-iothread',"
+        "  'arguments': { 'node-name': 'cd0', 'iothread': null,"
+        "                 'force': true } }");
+
+    /* Round-trip through the device to confirm qemu is still alive. */
+    ahci_px_rreg(ahci, port, AHCI_PX_TFD);
+
+    ahci_command_free(cmd);
+    ahci_free(ahci, buffer);
+    g_free(tx);
+    ahci_shutdown(ahci);
+    remove_iso(fd, iso);
+}
+
+static void test_atapi_drain_pio(void)
+{
+    test_atapi_drain_in_flight(false);
+}
+
+static void test_atapi_drain_dma(void)
+{
+    test_atapi_drain_in_flight(true);
+}
+
 /* Regression test: Test that a READ_CD command with a BCL of 0 but a size of 0
  * completes as a NOP instead of erroring out. */
 static void test_atapi_bcl(void)
@@ -2177,6 +2241,8 @@ int main(int argc, char **argv)
                    test_atapi_engine_restart_pio);
     qtest_add_func("/ahci/cdrom/engine_restart/dma",
                    test_atapi_engine_restart_dma);
+    qtest_add_func("/ahci/cdrom/drain/pio", test_atapi_drain_pio);
+    qtest_add_func("/ahci/cdrom/drain/dma", test_atapi_drain_dma);
 
     ret = g_test_run();
 
-- 
2.47.3


