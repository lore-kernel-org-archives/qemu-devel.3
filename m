Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64A7CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 17:04:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPNrG-00084V-0d; Tue, 19 May 2026 13:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNrA-0007zq-0a
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wPNr6-0004EL-V8
 for qemu-devel@nongnu.org; Tue, 19 May 2026 13:03:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779210224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u08sXbsTytnmzswbd8VB8r41OWHdyyA5LD7RL28Hhjk=;
 b=Z17ZNZpD1UIYjX+fDeTBQ8wHo0Um1C/YOfbboJO82gpKI6soiV18sPbtvwvavemAWCst/S
 dHmwyp8izTsg1zLSRwyCvairaemM16JpONuwBGVFpXtOFKXKdqAHzWlNTfJ89SLGrBTS7L
 +a394t7Vk9KcedV+NTXOTRjtEY13nu8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-EO0IATVzMYmEQbrQQcQNGA-1; Tue,
 19 May 2026 13:03:40 -0400
X-MC-Unique: EO0IATVzMYmEQbrQQcQNGA-1
X-Mimecast-MFC-AGG-ID: EO0IATVzMYmEQbrQQcQNGA_1779210220
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E271A19560BB; Tue, 19 May 2026 17:03:39 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.49.113])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D68A41687; Tue, 19 May 2026 17:03:37 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 06/18] ide-test: Factor out wait_dma_completion()
Date: Tue, 19 May 2026 19:03:05 +0200
Message-ID: <20260519170317.345032-7-kwolf@redhat.com>
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20260421161132.99878-7-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qtest/ide-test.c | 48 +++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index ceee444a9ec..c6dcb2c0745 100644
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
2.54.0


