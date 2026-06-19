Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F54CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIV-0002NI-Mk; Fri, 19 Jun 2026 07:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIT-0002Ju-CG; Fri, 19 Jun 2026 07:22:05 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIQ-0005yC-H4; Fri, 19 Jun 2026 07:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=gt4p8QtaMsOIKIQguzcq7jwj2LlSFWoBjngk0uOOFws=; b=p8xq/cGBaoI3
 cUYHZam7w81c0cwhR9j6hk12FdiJGjVsT+wo61ZmV+27s8e5+9DpkkdjD+/1kF5jFPjic+hZIx0Yy
 142OYuqb/l1f9c+FAFwXSuFHs7wqoaxUGJCRQ7vq65mz1P4a9hG2lK18iGIcXtw9Pl05s7y3aASEr
 YESp3EHuXDtloxUjwh/S+owQLX/ayrV/QyW/EkM8GZ9kQQxYL1s0HezGI6v3L3gyagAQ19Vi3U/dc
 bBAjFI59hhPg9MCwggcMeQLVZPT9qsn3of0IvgQf3iCEcbqxBebxISm0DAGAEVKK8dVk8xmx4ztj/
 CQLj0AJJ0m6vOM2MiC716w==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHn-0089QU-36;
 Fri, 19 Jun 2026 13:21:55 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 2/9] tests/qtest/ahci: test ATAPI read completing after engine
 restart
Date: Fri, 19 Jun 2026 13:21:50 +0200
Message-ID: <20260619112158.304782-3-den@openvz.org>
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
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DIET_1=0.001, DKIM_SIGNED=0.1,
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
---
 tests/qtest/ahci-test.c | 67 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5c32ff2002..44799eea15 100644
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
2.53.0


