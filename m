Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E4FCD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:04:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrG-00084U-19; Tue, 19 May 2026 13:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrB-00080m-EB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr8-0004Eo-PO
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Im6ugsy0Zg1kKOU/OXPyWYsPJt9DPoFm6c+xryieC9w=;
 b=ddyAQe3bZLg+KZLorR1GGq3yI9idfwKvpN85LjW3HJfhUjdtoEb6SalDHoBH9f9AqEBGL8
 rZ/Ft2GtvRRq7EoDsuOdZYuWz6cy+Mgpp9axT3WHoM6vLwmlBXBZlE04wUF8gFVElmr+1i
 oGSojuuzE2ekCruZLJWB+6Gx/Cl3N+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-25-2uhkS721MESheI0fI1RsSw-1; Tue,
 19 May 2026 13:03:42 -0400
X-MC-Unique: 2uhkS721MESheI0fI1RsSw-1
X-Mimecast-MFC-AGG-ID: 2uhkS721MESheI0fI1RsSw_1779210221
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9470195609D; Tue, 19 May 2026 17:03:41 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5658E1681; Tue, 19 May 2026 17:03:40 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 07/18] ide-test: Test reset during TRIM
Date: Tue, 19 May 2026 19:03:06 +0200
Message-ID: <20260519170317.345032-8-kwolf@redhat.com>
In-Reply-To: <20260519170317.345032-1-kwolf@redhat.com>
References: <20260519170317.345032-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is a regression test for the bug fixed in the previous commits, a
deadlock between the drain issued by an IDE reset and the TRIM state
machine.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-8-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qtest/ide-test.c | 95 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 8 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index c6dcb2c0745..721e78170bc 100644
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
2.54.0


