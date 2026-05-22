Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21B3CD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 21:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQXn8-0005PA-4i; Fri, 22 May 2026 17:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXn5-00057c-Ie; Fri, 22 May 2026 17:52:23 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wQXn3-0004Gl-T2; Fri, 22 May 2026 17:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1779486561; bh=BLo6PwJEyhEPInm/QTZQEjyFLJO3xe8Y3s6kNzquDL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gxen5VcOd9R3KtfYjGB7Y0UsVB/SQBEHiLeLVoZGtXzKOoMv0mMXsD2SRCtItMEZg
 NJqgIJKexpB87r4KX/LJks4GeIGM5P0Cv/SvkMCxG0i2ClM/rbZlgHObDiLGAAHM8y
 jSvKGi50wDX72YovGP2eQQmOC/3yc2mBhN1k/YeirdQcO+jcek+HMSWv5zuf42AfNa
 N73xf58XoynX4YKjNLO72neTdUdkodm0XnxVz6YqW6fFQKDV4k59puJz1onOeCNo4n
 eFzil/8dv8fXFmQS/dFmKOOZfBPzaF9/7nFpv9l0Q95SqNrYJzJ4ADYc8VzUlSa0B6
 KAdNTJmKtuBsw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3883E1AFB7A;
 Sat, 23 May 2026 00:49:21 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 608EF3B71C9;
 Sat, 23 May 2026 00:49:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Andreas Hindborg <a.hindborg@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 132/149] hw/nvme: fix admin cq msix setup
Date: Sat, 23 May 2026 00:49:04 +0300
Message-ID: <20260522214923.807017-33-mjt@tls.msk.ru>
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

From: Klaus Jensen <k.jensen@samsung.com>

If MSI-X is not enabled when the admin completion queue is created,
msix_vector_use() is not called. But, if MSI-X is subsequently enabled,
msix_notify() will fail to fire the interrupt because the use count for
the vector remains at 0.

msix_vector_use/unuse should be called if MSI-X is *present*, not
*enabled*. Fix this.

Cc: qemu-stable@nongnu.org
Reported-by: Andreas Hindborg <a.hindborg@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 2293d8b4bd88d3f29730cfd608935f77247919b6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index be6c7028cb..8463fd3e9a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -5517,7 +5517,7 @@ static void nvme_free_cq(NvmeCQueue *cq, NvmeCtrl *n)
         event_notifier_set_handler(&cq->notifier, NULL);
         event_notifier_cleanup(&cq->notifier);
     }
-    if (msix_enabled(pci) && cq->irq_enabled) {
+    if (msix_present(pci) && cq->irq_enabled) {
         msix_vector_unuse(pci, cq->vector);
     }
     if (cq->cqid) {
@@ -5558,7 +5558,7 @@ static void nvme_init_cq(NvmeCQueue *cq, NvmeCtrl *n, uint64_t dma_addr,
 {
     PCIDevice *pci = PCI_DEVICE(n);
 
-    if (msix_enabled(pci) && irq_enabled) {
+    if (msix_present(pci) && irq_enabled) {
         msix_vector_use(pci, vector);
     }
 
-- 
2.47.3


