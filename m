Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD0DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilgQ-0000Nt-La; Sun, 12 Jul 2026 00:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgE-0008S9-CP; Sun, 12 Jul 2026 00:20:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilgC-00070m-Gf; Sun, 12 Jul 2026 00:20:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=eCdtIr4LxAwGMaOuVeEnmMgBDQGsxQQWflW0QRuga8c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fQhP3tFVH1HqjgC7nqY0dim7kLV95Hrau/5Qi8mlazkZneDIvS5jL763Km2kF/a+5
 pafLBvIGDUrp/CsvmWUta8IJNAfoRzajmGq5vR0Zqh+m5iPywq0p4V7AMlmwvFxpOR
 otVRPRtZvMV4hfsi9mn8Vvxq+lr/nGYKPQ3+DTLjSSmvpMjocIuiwtFZVZCxxRE+Ev
 FTg7U4UnFWmeZpRaqJDUsnjO+OWEjxtiMx0GBVNVLNf8ed5ok7g7ACwLr39cxl0SnL
 sVGvTIKzLWHHdGMkW+vnqJ6A7bePDBuKnyn1Rahz+ASH7SjFJ7v7mdlNsA/7lyPpBQ
 u1Bzli5nWfGEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C92911C0C09;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 020F33EB969;
 Sun, 12 Jul 2026 07:16:32 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8164213415; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 46/75] tests/qtest/ahci: test ATAPI read completing
 after engine restart
Date: Sun, 12 Jul 2026 07:15:04 +0300
Message-ID: <20260712041539.108341-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DIET_1=0.001, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a regression test for the crash that occurs when a buffered ATAPI
read completes after the command engine has been restarted. Issue an
ATAPI READ_10 against a blkdebug-backed CD, suspend the backend read so
it stays in flight, stop and restart the port's command engine (which
re-maps the command list and clears cur_cmd), then release the read.

The PIO and DMA reply paths fault in different AHCI helpers
(ahci_pio_transfer() vs ahci_dma_rw_buf()), so cover both. The DMA
variant is the reliable guard: on engine restart check_cmd() can re-arm
cur_cmd before the old read completes, so the PIO variant does not fault
in every build.

The test only asserts that qemu survives a subsequent register access;
if the blkdebug breakpoint ever failed to park the read it would pass
without exercising the bug, as with the existing break/resume tests.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Message-ID: <20260619112158.304782-3-den@openvz.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit cb7bc10385f365c0792b77fc73b1d17a16cbaefd)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 88ac6c66ce3..9bebc0e9577 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1625,6 +1625,69 @@ static void test_cdrom_pio_multi(void)
     ahci_test_cdrom_read10(3, false);
 }
 
+/*
+ * Regression test: a buffered ATAPI read completing after a command
+ * engine restart must not dereference the cleared cur_cmd. Cover both
+ * PIO and DMA; the DMA variant is the reliable guard.
+ */
+static void test_atapi_engine_restart_in_flight(bool dma)
+{
+    AHCIQState *ahci;
+    AHCICommand *cmd;
+    unsigned char *tx;
+    char *iso;
+    int fd;
+    uint8_t port;
+    uint64_t buffer;
+    uint64_t iso_size = (uint64_t)ATAPI_SECTOR_SIZE * 2;
+
+    fd = prepare_iso(iso_size, &tx, &iso);
+
+    ahci = ahci_boot_and_enable("-drive if=none,id=drive0,"
+                                "file=blkdebug::%s,format=raw,readonly=on "
+                                "-M q35 "
+                                "-device ide-cd,drive=drive0 ", iso);
+    port = ahci_port_select(ahci);
+
+    buffer = ahci_alloc(ahci, ATAPI_SECTOR_SIZE);
+    qtest_memset(ahci->parent->qts, buffer, 0x00, ATAPI_SECTOR_SIZE);
+
+    /* Suspend the next backend read so the ATAPI read stays in flight. */
+    g_free(qtest_hmp(ahci->parent->qts,
+                     "qemu-io drive0 \"break read_aio rd\""));
+
+    cmd = ahci_atapi_command_create(CMD_ATAPI_READ_10, ATAPI_SECTOR_SIZE,
+                                    dma);
+    ahci_command_adjust(cmd, 0, buffer, ATAPI_SECTOR_SIZE, 0);
+    ahci_command_commit(ahci, cmd, port);
+    ahci_command_issue_async(ahci, cmd);
+
+    /* Stop and restart the command engine to re-map the command list. */
+    ahci_px_clr(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+    ahci_px_set(ahci, port, AHCI_PX_CMD, AHCI_PX_CMD_ST);
+
+    g_free(qtest_hmp(ahci->parent->qts, "qemu-io drive0 \"resume rd\""));
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
+static void test_atapi_engine_restart_pio(void)
+{
+    test_atapi_engine_restart_in_flight(false);
+}
+
+static void test_atapi_engine_restart_dma(void)
+{
+    test_atapi_engine_restart_in_flight(true);
+}
+
 /* Regression test: Test that a READ_CD command with a BCL of 0 but a size of 0
  * completes as a NOP instead of erroring out. */
 static void test_atapi_bcl(void)
@@ -2043,6 +2106,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
+    qtest_add_func("/ahci/cdrom/engine_restart/pio",
+                   test_atapi_engine_restart_pio);
+    qtest_add_func("/ahci/cdrom/engine_restart/dma",
+                   test_atapi_engine_restart_dma);
 
     ret = g_test_run();
 
-- 
2.47.3


