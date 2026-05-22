Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A9CD4F3D
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXo7-0000FO-HC; Fri, 22 May 2026 17:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXo1-0008S0-6T; Fri, 22 May 2026 17:53:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXny-0004v3-QT; Fri, 22 May 2026 17:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=j6nKCgrUfzNJ3OObA9atGhYMdqhQy3xF0zUtaJNQB1I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=werJObn/UphJQknkLca/Oqd92eTT3TfyWN5DsRipIqRyVnz+JDe2iXfDh0dVTVB6+
 +JyamjisFpgascQSRzq6Slou0GRYCUMs7IUnHeYlWJdA0vgaxDq/lQDCttezhMGQLM
 X1+8gJ1k3uYXSYKjGh/JnkzjDiu2JvA3w73Zv6gEBcT2txmMF7jDhlRPIl5fo9FJXc
 xkSuAENNuzKj3L3+giqN0SHOYNOkH2APlDkfCN2K+3eywvDbx94sjfxkAJhaXhd7l5
 T4VVeXC2cfT7R8kG4Wl4jpYIPZ05rOkiEp7hAndSqGDXAYDjYshJoFSKQb4q+QUWmu
 ej9ZweFpmqwyQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B73B81AFB83;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E1AF63B71D2;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 141/149] ide-test: Factor out wait_dma_completion()
Date: Sat, 23 May 2026 00:49:13 +0300
Message-ID: <20260522214923.807017-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260522213553@cover.tls.msk.ru>
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-7-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 92854c9c7539bdbf4f9c1abb33dd3ba59ff91e58)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index ceee444a9e..c6dcb2c074 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -200,6 +200,34 @@ static uint64_t trim_range_le(uint64_t sector, uint16_t count)
     return cpu_to_le64(((uint64_t)count << 48) + sector);
 }
 
+static uint8_t wait_dma_completion(QTestState *qts, QPCIDevice *dev,
+                                   QPCIBar bmdma_bar, QPCIBar ide_bar)
+{
+    uint8_t status;
+
+    /* Wait for the DMA transfer to complete */
+    do {
+        status = qpci_io_readb(dev, bmdma_bar, bmreg_status);
+    } while ((status & (BM_STS_ACTIVE | BM_STS_INTR)) == BM_STS_ACTIVE);
+
+    g_assert_cmpint(qtest_get_irq(qts, IDE_PRIMARY_IRQ), ==,
+                    !!(status & BM_STS_INTR));
+
+    /* Check IDE status code */
+    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), DRDY);
+    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), BSY | DRQ);
+
+    /* Reading the status register clears the IRQ */
+    g_assert(!qtest_get_irq(qts, IDE_PRIMARY_IRQ));
+
+    /* Stop DMA transfer if still active */
+    if (status & BM_STS_ACTIVE) {
+        qpci_io_writeb(dev, bmdma_bar, bmreg_cmd, 0);
+    }
+
+    return status;
+}
+
 static int send_dma_request(QTestState *qts, int cmd, uint64_t sector,
                             int nb_sectors, PrdtEntry *prdt, int prdt_entries,
                             void(*post_exec)(QPCIDevice *dev, QPCIBar ide_bar,
@@ -280,25 +308,7 @@ static int send_dma_request(QTestState *qts, int cmd, uint64_t sector,
         qpci_io_writeb(dev, bmdma_bar, bmreg_cmd, 0);
     }
 
-    /* Wait for the DMA transfer to complete */
-    do {
-        status = qpci_io_readb(dev, bmdma_bar, bmreg_status);
-    } while ((status & (BM_STS_ACTIVE | BM_STS_INTR)) == BM_STS_ACTIVE);
-
-    g_assert_cmpint(qtest_get_irq(qts, IDE_PRIMARY_IRQ), ==,
-                    !!(status & BM_STS_INTR));
-
-    /* Check IDE status code */
-    assert_bit_set(qpci_io_readb(dev, ide_bar, reg_status), DRDY);
-    assert_bit_clear(qpci_io_readb(dev, ide_bar, reg_status), BSY | DRQ);
-
-    /* Reading the status register clears the IRQ */
-    g_assert(!qtest_get_irq(qts, IDE_PRIMARY_IRQ));
-
-    /* Stop DMA transfer if still active */
-    if (status & BM_STS_ACTIVE) {
-        qpci_io_writeb(dev, bmdma_bar, bmreg_cmd, 0);
-    }
+    status = wait_dma_completion(qts, dev, bmdma_bar, ide_bar);
 
     free_pci_device(dev);
 
-- 
2.47.3


