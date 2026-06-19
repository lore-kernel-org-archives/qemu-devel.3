Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBD8CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:23:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waXIW-0002OA-Tf; Fri, 19 Jun 2026 07:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIV-0002M8-00; Fri, 19 Jun 2026 07:22:07 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1waXIR-0005yx-Hv; Fri, 19 Jun 2026 07:22:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=EcG7lwoKzbBQiYpzdtpESFE9NrMuxzb5KF9kimIPY54=; b=RB3X20Npl5bI
 auJLHKRzr85DHtsWv9wfnN+Z4W8YC4uiCH39sTt3jPHT0FnRYrV7DDNb8CYYkrgPJScebbcT+e++y
 W4gwyDH27mp/RGieT33qMNl+ZXcgnY1lb7zA/bK/vvTen2F5NaaR/BYChwnOmLBZ563OcfWB9HTdQ
 Vh+Liuv9I09lBo3zPKGK3i/XmiNv3iWzCcdHoLoMkfAP7D4gr0cJ0dyF/DEuCLIKcAY8tx3FqE8CQ
 BsoNt/scGvOHuPdWFfMbhJyJoNIRBNWoG3525YYcFmBXvbUNPaSDubgjJmN0467VFNUSFum9XVZV8
 gJLSB92zwKwm9NmsK1EXUQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=athena.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1waXHq-0089QU-1f;
 Fri, 19 Jun 2026 13:21:58 +0200
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 9/9] tests/qtest/ahci: regression test for ATAPI read vs. drain
Date: Fri, 19 Jun 2026 13:21:57 +0200
Message-ID: <20260619112158.304782-10-den@openvz.org>
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
---
 tests/qtest/ahci-test.c | 66 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 58bc04b3ef..71d23fe56a 100644
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
2.53.0


