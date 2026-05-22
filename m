Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFA2CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXcg-0005f0-3s; Fri, 22 May 2026 17:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXbz-00041Z-14; Fri, 22 May 2026 17:41:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXbu-0004p0-8Q; Fri, 22 May 2026 17:40:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779485684; bh=3muA5MuiaqixstxYyQMlrapQZkF0eE2rkgCoHkfsYPs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g8Yi7XYmfn6JDKgGslZIOwol8OnwcTaVJO/u9136ZaslHuzv1Yjt20YUXScKtePiu
 IMzBhiAbOD+kp9Y9y9LJ9NIw+Zp/r6mUAeU98ZVHHMHOcbLAnOZx3m5hJRciXe3kn6
 Tm2FDUCwm163fRf/g9wONCC8sLGPGO/ILbC+wHS3FSTyxvjUUJbkqExmuW2pCifd4E
 RXTPDFCD4BzitrFZKfFlFqMKDT7RS2Hvmbm3Dne4vw3nLSxKOtcci/eTBa/EvImVZS
 1EO4Yq8fQHPFIw70UrlueL4wysf85oDPTdi9Tv8NgqWaVg2sKLuauMTYkUCPUqq/M3
 MzfGOa0LhpgpA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 065321AFB13;
 Sat, 23 May 2026 00:34:44 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2AEE03B7193;
 Sat, 23 May 2026 00:34:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 130/136] ide-test: Test reset during TRIM
Date: Sat, 23 May 2026 00:34:38 +0300
Message-ID: <20260522213446.806182-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260522213601@cover.tls.msk.ru>
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

From: Kevin Wolf <kwolf@redhat.com>

This is a regression test for the bug fixed in the previous commits, a
deadlock between the drain issued by an IDE reset and the TRIM state
machine.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-8-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 2fa24e9755994f76f08ea2452215eb50f26f4c21)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index c6dcb2c074..721e78170b 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -41,8 +41,11 @@
 #define IDE_PCI_FUNC    1
 
 #define IDE_BASE 0x1f0
+#define IDE_BASE2 0x3f6
 #define IDE_PRIMARY_IRQ 14
 
+#define IDE_CTRL_RESET 0x04
+
 #define ATAPI_BLOCK_SIZE 2048
 
 /* How many bytes to receive via ATAPI PIO at one time.
@@ -99,6 +102,7 @@ enum {
 
     CMDF_ABORT      = 0x100,
     CMDF_NO_BM      = 0x200,
+    CMDF_NO_WAIT    = 0x400,
 };
 
 enum {
@@ -228,21 +232,21 @@ static uint8_t wait_dma_completion(QTestState *qts, QPCIDevice *dev,
     return status;
 }
 
-static int send_dma_request(QTestState *qts, int cmd, uint64_t sector,
-                            int nb_sectors, PrdtEntry *prdt, int prdt_entries,
-                            void(*post_exec)(QPCIDevice *dev, QPCIBar ide_bar,
-                                             uint64_t sector, int nb_sectors))
+static int send_dma_request_dev(QTestState *qts, QPCIDevice *dev,
+                                QPCIBar bmdma_bar, QPCIBar ide_bar, int cmd,
+                                uint64_t sector, int nb_sectors,
+                                PrdtEntry *prdt, int prdt_entries,
+                                void(*post_exec)(QPCIDevice *dev,
+                                                 QPCIBar ide_bar,
+                                                 uint64_t sector,
+                                                 int nb_sectors))
 {
-    QPCIDevice *dev;
-    QPCIBar bmdma_bar, ide_bar;
     uintptr_t guest_prdt;
     size_t len;
     bool from_dev;
     uint8_t status;
     int flags;
 
-    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
-
     flags = cmd & ~0xff;
     cmd &= 0xff;
 
@@ -308,8 +312,28 @@ static int send_dma_request(QTestState *qts, int cmd, uint64_t sector,
         qpci_io_writeb(dev, bmdma_bar, bmreg_cmd, 0);
     }
 
+    if (flags & CMDF_NO_WAIT) {
+        return 0;
+    }
+
     status = wait_dma_completion(qts, dev, bmdma_bar, ide_bar);
 
+    return status;
+}
+
+static int send_dma_request(QTestState *qts, int cmd, uint64_t sector,
+                            int nb_sectors, PrdtEntry *prdt, int prdt_entries,
+                            void(*post_exec)(QPCIDevice *dev, QPCIBar ide_bar,
+                                             uint64_t sector, int nb_sectors))
+{
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar;
+    uint8_t status;
+
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+    status = send_dma_request_dev(qts, dev, bmdma_bar, ide_bar,
+                                  cmd, sector, nb_sectors, prdt, prdt_entries,
+                                  post_exec);
     free_pci_device(dev);
 
     return status;
@@ -457,6 +481,60 @@ static void test_bmdma_trim(void)
     test_bmdma_teardown(qts);
 }
 
+static void test_bmdma_trim_reset(void)
+{
+    QTestState *qts;
+    QPCIDevice *dev;
+    QPCIBar bmdma_bar, ide_bar, ide_bar2;
+    uint8_t status;
+    const uint64_t trim_range[] = {
+        trim_range_le(0, 2),
+        trim_range_le(6, 8),
+    };
+    size_t len = 512;
+    uint8_t *buf;
+    uintptr_t guest_buf;
+    PrdtEntry prdt[1];
+
+    qts = ide_test_start(
+        "-blockdev file,filename=%s,node-name=img "
+        "-blockdev blkdebug,image=img,node-name=dbg,discard=unmap,"
+        "inject-error.0.event=none,inject-error.0.iotype=discard,"
+        "inject-error.0.errno=0,inject-error.0.delay-ns=1000000 "
+        "-device ide-hd,drive=dbg,bus=ide.0",
+        tmp_path[0]);
+    qtest_irq_intercept_in(qts, "ioapic");
+
+    guest_buf = guest_alloc(&guest_malloc, len);
+    prdt[0].addr = cpu_to_le32(guest_buf),
+    prdt[0].size = cpu_to_le32(len | PRDT_EOT),
+
+    dev = get_pci_device(qts, &bmdma_bar, &ide_bar);
+    ide_bar2 = qpci_legacy_iomap(dev, IDE_BASE2);
+
+    buf = g_malloc(len);
+
+    /* TRIM request with two segments */
+    *((uint64_t *)buf) = trim_range[0];
+    *((uint64_t *)buf + 1) = trim_range[1];
+
+    qtest_memwrite(qts, guest_buf, buf, 2 * sizeof(uint64_t));
+
+    send_dma_request_dev(qts, dev, bmdma_bar, ide_bar, CMD_DSM | CMDF_NO_WAIT, 0, 1, prdt,
+                     ARRAY_SIZE(prdt), NULL);
+
+    /* Reset the device while the first segment is in flight */
+    qpci_io_writeb(dev, ide_bar2, 0, IDE_CTRL_RESET);
+
+    status = wait_dma_completion(qts, dev, bmdma_bar, ide_bar);
+    g_assert_cmphex(status, ==, BM_STS_INTR);
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), DF | ERR);
+
+    free_pci_device(dev);
+    g_free(buf);
+    test_bmdma_teardown(qts);
+}
+
 /*
  * This test is developed according to the Programming Interface for
  * Bus Master IDE Controller (Revision 1.0 5/16/94)
@@ -1138,6 +1216,7 @@ int main(int argc, char **argv)
 
     qtest_add_func("/ide/bmdma/simple_rw", test_bmdma_simple_rw);
     qtest_add_func("/ide/bmdma/trim", test_bmdma_trim);
+    qtest_add_func("/ide/bmdma/trim_reset", test_bmdma_trim_reset);
     qtest_add_func("/ide/bmdma/various_prdts", test_bmdma_various_prdts);
     qtest_add_func("/ide/bmdma/no_busmaster", test_bmdma_no_busmaster);
 
-- 
2.47.3


