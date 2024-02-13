Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAAD0C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhN-0003Hh-5Q; Tue, 13 Feb 2024 14:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh1-0001rf-2R
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygx-0006X1-Vy
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JXa+2Gs+6maY4QFvhNHnOxGTM8gMrR5n+minckNx8qc=; b=VXH4Bmp+DsnY395VsXOGUKt/28
 Mqf4HBIbIwmbcFjEPM7sSoE98BpcMPZPzuhkQ7MrMJjpntePNK6ck8aZUlb861VJu1Vn8Qlo3IzGr
 ow100fbdTRmmyYWUb872XOWA6ohowMpxWpRDX5XlAb1anvXFp0brXPTpgFYGmQMdUXkf12zKmkY8q
 KWUc9Rie6Frke5zsBqQ/cHYRJ+/5GAYG8Na7XcSbXZikpU6O6sgNfyMrINs0CULe5z7lRSMtUAkt2
 bpKtQw5+Q21AuY/iTNOeuszF+yzuJPdRYN/OHMjEWrcYH2Okl7b7K/b9woOyZfHViIvh7ksT4fOLu
 mjFZtlXia/kKPK8EEgnunPb7SpkbzmXd3EFODjSEh6xIJeHrM32erzqaXHIkmAHDcYBB92LfCmIHj
 GIv1ADW/6jR6RrURIbD8cZXTPQF+KEb6sYPMgYH692vMKMwNRf9SxzvKFi9sm1Xe4isKTzWEjSgqu
 usZKXRDt87CFyRByEPxroxCo+xgZ991x8svVVKHhG1EiRWRLA6fGbqOZdYvRz2J9BYvPLO8jUXo+m
 BJoID09wlrhdyvIEbLPk6wmnoqL/4B/mKWRRfzUi+3KBV8TKONK2lhiLmL8W3vS8Dx5hIyxEL6/c2
 MlsbK7Yd2chAOogBxYfP5lwjPuVvB25x2JEQPQ+hw=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfx-0008m4-7c; Tue, 13 Feb 2024 19:42:45 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:06 +0000
Message-Id: <20240213194052.1162753-43-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 42/88] esp.c: convert do_dma_pdma_cb() do_cmd path to check for
 SCSI phase instead
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

Currently do_cmd is used to determine whether MESSAGE OUT and COMMAND phase data
is being accumulated in cmdfifo. Update esp_do_dma() to check directly for these
two SCSI phases instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-43-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 22739d3875..b48e020689 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -546,7 +546,9 @@ static void do_dma_pdma_cb(ESPState *s)
     int len;
     uint32_t n;
 
-    if (s->do_cmd) {
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
         /* Copy FIFO into cmdfifo */
         n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
         n = MIN(fifo8_num_free(&s->cmdfifo), n);
@@ -578,10 +580,8 @@ static void do_dma_pdma_cb(ESPState *s)
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
         }
-        return;
-    }
+        break;
 
-    switch (esp_get_phase(s)) {
     case STAT_DO:
         if (!s->current_req) {
             return;
-- 
2.39.2


