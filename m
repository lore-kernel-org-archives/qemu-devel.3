Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601C9C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilgK-00008w-Hc; Sun, 12 Jul 2026 00:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfr-0008Kh-1P; Sun, 12 Jul 2026 00:20:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfo-00070R-28; Sun, 12 Jul 2026 00:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=ePzxAoLhO6DGp9DA26gIEJ0w+f878SHmY7UHPwbdxu4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZA0vpMxtCWs8WMcujVLv+rF/rTvjvCJLjfMyHWEJoTdmgIg6sseFjI2QrLAupsIEw
 6nlJkGGfii0+cVpzNvpkJZh95N6RNu8jHCpr/ggsOrUf2MaIsnAHlBFsr9WaH3XOF1
 DBZfBi17uxQMLL3oER2alXG3zn7rJWC+GGtA5ReLcIMR3WAzfBjNZA+hYsPwwUwD3y
 xoAYv84FCjuCFNwlWLRtfngj88ZipcMjomPjPsMvCVwN7KTcU8M2QJpR2wo5C1GUrS
 ytXA+vPPg5W2D/5p/dRyCieibzdl+bpiWPg+wfhhQWId3DMsNz9KQ8dnAcTQRUdV9L
 nAc65nUj9LZ8w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6ADC1C0C07;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EAADB3EB967;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7C81013411; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Torin Carey <torin@tcarey.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 44/75] hw/misc/edu: restrict dma access to dma buffer
Date: Sun, 12 Jul 2026 07:15:02 +0300
Message-ID: <20260712041539.108341-44-mjt@tls.msk.ru>
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
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
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

From: Torin Carey <torin@tcarey.uk>

The EDU device doesn't enforce any bound checks on the addresses provided,
allowing users of the device to perform arbitrary reads and writes to QEMU's
address space.

Signed-off-by: Torin Carey <torin@tcarey.uk>
Cc: qemu-stable@nongnu.org
Fixes: 7b608e5d6c1 ("hw: misc: edu: use qemu_log_mask instead of hw_error")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3852
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <aQtAotYvzFY0Vpft@tcarey.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
(cherry picked from commit 42f599172ae023924f288e20af0ceed681674747)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 504178b4a22..41f1fe99499 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -103,7 +103,7 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
 
-static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
+static bool edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
                 uint64_t dma_start, uint64_t dma_size)
 {
     uint64_t xfer_end = xfer_start + xfer_size;
@@ -115,13 +115,15 @@ static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
      */
     if (dma_end >= dma_start && xfer_end >= xfer_start &&
         xfer_start >= dma_start && xfer_end <= dma_end) {
-        return;
+        return true;
     }
 
     qemu_log_mask(LOG_GUEST_ERROR,
                   "EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
                   " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
                   xfer_start, xfer_end - 1, dma_start, dma_end - 1);
+
+    return false;
 }
 
 static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
@@ -148,16 +150,18 @@ static void edu_dma_timer(void *opaque)
 
     if (EDU_DMA_DIR(edu->dma.cmd) == EDU_DMA_FROM_PCI) {
         uint64_t dst = edu->dma.dst;
-        edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
-        dst -= DMA_START;
-        pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
-                edu->dma_buf + dst, edu->dma.cnt);
+        if (edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE)) {
+            dst -= DMA_START;
+            pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
+                         edu->dma_buf + dst, edu->dma.cnt);
+        }
     } else {
         uint64_t src = edu->dma.src;
-        edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
-        src -= DMA_START;
-        pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-                edu->dma_buf + src, edu->dma.cnt);
+        if (edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE)) {
+            src -= DMA_START;
+            pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
+                          edu->dma_buf + src, edu->dma.cnt);
+        }
     }
 
     edu->dma.cmd &= ~EDU_DMA_RUN;
-- 
2.47.3


