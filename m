Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108F8C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:06:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifo4-0001oj-T7; Sat, 11 Jul 2026 18:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifo4-0001nU-3q; Sat, 11 Jul 2026 18:04:20 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifo2-0000Gm-7v; Sat, 11 Jul 2026 18:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807181; bh=YlCOYq8LtBNuwHcN41KnBzTECRMnmu4Pc2G3A0ypwDU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bU98D8Wt3zK/kDf3Ou+WpQShxe8V7WAsLoL9O/rhAo/RTY1pqJ1BrAxQLZqEva/a7
 I1rUax3mZBabpl2hAJ9UhwTJEsKJIgAKzjqrvc7dqqOOsW1VsoajMXf8ul1iEERQmt
 lWQZL7Jr8JFOXU+2HEDBVRXPDnayf65cYvkKOiuYgQ14B4oRvLA0+FMYmKdwjQiR2D
 g22d6bLsDPSKJgpRIHdcz6Xvfxa7hYC3ON5D0UNb6/UloAUwMQAGN+MRRTWriG1eCt
 7N9Hrs0fhGhBbdre+VVa4PchetGyg9lBCpLFTa9LSL7N7NhT2+BlhIUIApN7XGT2qH
 YsaVfQxKAJsBg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3EFB61C0ABC;
 Sun, 12 Jul 2026 00:59:41 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E9AD13EAF47;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id AD83E13345; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 49/81] tests/qtest/ahci: test ATAPI read completing
 after engine restart
Date: Sun, 12 Jul 2026 00:58:27 +0300
Message-ID: <20260711215904.3757-49-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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
index 5c32ff20029..44799eea153 100644
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
@@ -2042,6 +2105,10 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ahci/cdrom/pio/bcl", test_atapi_bcl);
     qtest_add_func("/ahci/cdrom/eject", test_atapi_tray);
+    qtest_add_func("/ahci/cdrom/engine_restart/pio",
+                   test_atapi_engine_restart_pio);
+    qtest_add_func("/ahci/cdrom/engine_restart/dma",
+                   test_atapi_engine_restart_dma);
 
     ret = g_test_run();
 
-- 
2.47.3


