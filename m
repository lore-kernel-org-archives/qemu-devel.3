Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4DACCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 14:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGefh-0001mx-0O; Wed, 05 Nov 2025 09:39:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torin@tcarey.uk>) id 1vGcTg-0006Rs-U5
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:19:06 -0500
Received: from mail-4317.protonmail.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <torin@tcarey.uk>) id 1vGcTd-0002Ut-56
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 07:19:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tcarey.uk;
 s=protonmail; t=1762345134; x=1762604334;
 bh=NJpXhThC/8vNKP5T7Z+rI9xvRGOlHJhQgOvZi8kjh/Q=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=BewZvjgRoOUpk5id1Opp83MhvfkM1RrADZ8lHtVd9WDq27XOLzP3FnRvcGrSqnIWH
 y0WnBIfiOB6kb0+/78SOcrV+IBXWTHJRq9ClV6rT2p0lXFY60hv+AKxqznHqm9/W/0
 W8iVX6ZYqrOFdq46ljDBb9ukIAbtLlSuAOqNV517nV+KBBEZS0M0h6zQS4W6+LpIZ5
 5WD638sGN+fDIKkw1VrKdtC8KMUTQAww6TnXC64vGKOljfsalvyPnx1p7q7CkUz8hK
 9Wl7ClhZM+ch1sOf45kZs4XGJlG9o+Xry9e9cK3KmrekyXB4Hj+RHg8c11eoBRaquM
 0j8//YgM+yFvQ==
Date: Wed, 05 Nov 2025 12:18:48 +0000
To: qemu-devel@nongnu.org
From: Torin Carey <torin@tcarey.uk>
Cc: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH] hw/misc/edu: restrict dma access to dma buffer
Message-ID: <aQtAotYvzFY0Vpft@tcarey.uk>
Feedback-ID: 43460779:user:proton
X-Pm-Message-ID: 521294dec7ede59e705f8180f01ed51fa4f0a4b2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=torin@tcarey.uk;
 helo=mail-4317.protonmail.ch
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Nov 2025 09:39:32 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The EDU device doesn't enforce any bound checks on the addresses provided,
allowing users of the device to perform arbitrary reads and writes to QEMU'=
s
address space.

Signed-off-by: Torin Carey <torin@tcarey.uk>
---
 hw/misc/edu.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index cece633e11..a4b01269e8 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -103,7 +103,7 @@ static void edu_lower_irq(EduState *edu, uint32_t val)
     }
 }
=20
-static void edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
+static bool edu_check_range(uint64_t xfer_start, uint64_t xfer_size,
                 uint64_t dma_start, uint64_t dma_size)
 {
     uint64_t xfer_end =3D xfer_start + xfer_size;
@@ -115,13 +115,15 @@ static void edu_check_range(uint64_t xfer_start, uint=
64_t xfer_size,
      */
     if (dma_end >=3D dma_start && xfer_end >=3D xfer_start &&
         xfer_start >=3D dma_start && xfer_end <=3D dma_end) {
-        return;
+        return true;
     }
=20
     qemu_log_mask(LOG_GUEST_ERROR,
                   "EDU: DMA range 0x%016"PRIx64"-0x%016"PRIx64
                   " out of bounds (0x%016"PRIx64"-0x%016"PRIx64")!",
                   xfer_start, xfer_end - 1, dma_start, dma_end - 1);
+
+    return false;
 }
=20
 static dma_addr_t edu_clamp_addr(const EduState *edu, dma_addr_t addr)
@@ -148,16 +150,18 @@ static void edu_dma_timer(void *opaque)
=20
     if (EDU_DMA_DIR(edu->dma.cmd) =3D=3D EDU_DMA_FROM_PCI) {
         uint64_t dst =3D edu->dma.dst;
-        edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE);
-        dst -=3D DMA_START;
-        pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
-                edu->dma_buf + dst, edu->dma.cnt);
+        if (edu_check_range(dst, edu->dma.cnt, DMA_START, DMA_SIZE)) {
+            dst -=3D DMA_START;
+            pci_dma_read(&edu->pdev, edu_clamp_addr(edu, edu->dma.src),
+                         edu->dma_buf + dst, edu->dma.cnt);
+        }
     } else {
         uint64_t src =3D edu->dma.src;
-        edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE);
-        src -=3D DMA_START;
-        pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
-                edu->dma_buf + src, edu->dma.cnt);
+        if (edu_check_range(src, edu->dma.cnt, DMA_START, DMA_SIZE)) {
+            src -=3D DMA_START;
+            pci_dma_write(&edu->pdev, edu_clamp_addr(edu, edu->dma.dst),
+                          edu->dma_buf + src, edu->dma.cnt);
+        }
     }
=20
     edu->dma.cmd &=3D ~EDU_DMA_RUN;
--=20
2.47.3



