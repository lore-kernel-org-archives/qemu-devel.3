Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79262C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygL-0007nX-5I; Tue, 13 Feb 2024 14:43:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygH-0007cZ-Rf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygG-0006Sm-EK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3PlvwSfea5jNKUmo4ddcBd6qzlhvJkQiXyTHLU10kQk=; b=FkFl6BQzuv9mM4x9nQ123GPBEe
 52sVO3di7zB4A5qFUuMV6n0ztH/O1UK6ZBZ+4ZjD0AXcgXzeCtiOrvhgRAP8BR8DxJxmjph97kf88
 j7QVUtbmyUJVS8ZmOg8N+yZFd9AsUzaUz9ZMA8/cfQSmF2yqcmEg5tORVPm9GLB1XDIIQ+xwrMHyr
 kYEzH2oDbtNZ3EX49YHyuVrSuqujKZ+XWpIrHFwoSBToeyTdcBHZICtmZoWSs1p9/PRp6mn1w/Fx+
 eE0QKr7xKpqDyQLwDxSN0ifih8qGnX3d0lXhuvmsbkERE+EEJyKHYtkCQYsWRe1GXKWb4Hni+zRUH
 67saqCSwa5RZmc+ZRWEA05vtcuhRJlRhX4w9DXUwJpfOtkFBDlzvLuuifaRRhjUgaYrCJYTeZQFJH
 BAB+6OW4okVs5Y+7v4GUqH+gmwW2daDH6cMVUIAM0P5E5m4RoGcSj11Pold8Xwh/Z5+4jZqEyHM5y
 HEnVn6yJv4JYKrrbOqyC/ELkeBudKyRDjPeyQEYlXpmN8mJSzlK1mTmdb3fbdI4yFtDWCMNliVHG1
 eajh3WkCdgcpRuqQJSjIaavV3rvy+IHNQQf5AQMBVKHbd3/wQ+96OSbhwSpKaXGdZg7ediNDSM8Sk
 npQSp/2QdRQeCcYawvhel9R53XYvKWWRsP+7ebiPQ=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfO-0008m4-77; Tue, 13 Feb 2024 19:42:09 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:56 +0000
Message-Id: <20240213194052.1162753-33-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 32/88] esp.c: copy PDMA logic for transfers to device from
 do_dma_pdma_cb() to esp_do_dma()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

This is so that PDMA transfers can be performend by esp_do_dma() as well as
do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-33-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 14c6d05253..65b4baab83 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -640,6 +640,7 @@ static void esp_do_dma(ESPState *s)
     uint32_t len, cmdlen;
     int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
+    int n;
 
     len = esp_get_tc(s);
     if (s->do_cmd) {
@@ -710,6 +711,14 @@ static void esp_do_dma(ESPState *s)
 
             esp_dma_ti_check(s);
         } else {
+            /* Copy FIFO data to device */
+            len = MIN(s->async_len, ESP_FIFO_SZ);
+            len = MIN(len, fifo8_num_used(&s->fifo));
+            n = esp_fifo_pop_buf(&s->fifo, s->async_buf, len);
+            s->async_buf += n;
+            s->async_len -= n;
+            s->ti_size += n;
+
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
 
-- 
2.39.2


