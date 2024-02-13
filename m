Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981EBC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxl-00016y-9q; Tue, 13 Feb 2024 15:01:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxg-00011U-T0
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:02 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxb-0001qY-R8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OFphqt2kaDocqz1MJe/EF9OApPTK3lUJ59fjH/qFx2E=; b=ojHVr8Vm7pTmTMYl/W2/sKswX9
 c0tA0MlCzHRzKw2tNeynwE9IdU8q100u3VIOe8IrV43bt3Zb+ymw1MElTKL3ToqdEXwK352TmmH4P
 grX19qyh8chKnxlHzJGZV9qME1gFmjctiugfrOjRE4WKugfuGDqoNJhZb43N/T69UJjRSgog3TMQU
 sSoXzIGqsqiFepMk1pOXLZjWeSfJdK/vpSeSZTpeTY+2k2IlLdl1M8dX83Cnzq6YPGJWIoTC2/yLU
 24zidMh37Yx1ygyxHHirxIvEQ1i98N8YgDz9srpBIeghJqdJmdplLCi2/qXEoX22To1AhDi42JdIi
 IAxGcrikml9Piatil7PqQ7bij8px2t0bQM5nyU0gL8g4vI7r/OwBdGEWaaviNhmhJ4qdFcx8B1uZE
 vFDA/X+TdJxe50QTz/QK97Jka5gxC5cbWJLlzd+nPNCIKdf8Tv01KFoySka2lqi9m6x64DIcFN0Cx
 O8ry+lGigVx6kzK7/jAJOWm/ceJS5Mx/AHQux5KmDo4sIxBGOk0CVbptMZk1J4r64ltFmgbw7q802
 3ihgXc9EDgsNNcVPH5rI6qLMNy5xejZDuZfz+/PORZE8B9jvLbMy5WrRJWgKTaXJxJ3aXLiZVWer7
 9KMHX2VXQL0oXul7oRHg9W0/9EGdEOt5nBW1/sQWI=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhm-0008m4-J9; Tue, 13 Feb 2024 19:44:38 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:43 +0000
Message-Id: <20240213194052.1162753-80-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 79/88] esp.c: consolidate DMA and PDMA logic in DATA IN phase
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

This allows the removal of duplicate logic shared between the two implementations.
Note that we restrict esp_raise_drq() to PDMA to help reduce the log verbosity
for normal DMA.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-80-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 51 +++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 394774c379..49fc059eaa 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -557,51 +557,34 @@ static void esp_do_dma(ESPState *s)
         if (len > s->async_len) {
             len = s->async_len;
         }
+
         if (s->dma_memory_write) {
             s->dma_memory_write(s->dma_opaque, s->async_buf, len);
-
-            esp_set_tc(s, esp_get_tc(s) - len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size -= len;
-
-            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
-                /* If the guest underflows TC then terminate SCSI request */
-                scsi_req_continue(s->current_req);
-                return;
-            }
-
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
-
-            esp_dma_ti_check(s);
         } else {
             /* Copy device data to FIFO */
             len = MIN(len, fifo8_num_free(&s->fifo));
             fifo8_push_all(&s->fifo, s->async_buf, len);
-            s->async_buf += len;
-            s->async_len -= len;
-            s->ti_size -= len;
-            esp_set_tc(s, esp_get_tc(s) - len);
             esp_raise_drq(s);
+        }
 
-            if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
-                /* If the guest underflows TC then terminate SCSI request */
-                scsi_req_continue(s->current_req);
-                return;
-            }
+        s->async_buf += len;
+        s->async_len -= len;
+        s->ti_size -= len;
+        esp_set_tc(s, esp_get_tc(s) - len);
 
-            if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-                /* Defer until the scsi layer has completed */
-                scsi_req_continue(s->current_req);
-                return;
-            }
+        if (s->async_len == 0 && s->ti_size == 0 && esp_get_tc(s)) {
+            /* If the guest underflows TC then terminate SCSI request */
+            scsi_req_continue(s->current_req);
+            return;
+        }
 
-            esp_dma_ti_check(s);
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
+            scsi_req_continue(s->current_req);
+            return;
         }
+
+        esp_dma_ti_check(s);
         break;
 
     case STAT_ST:
-- 
2.39.2


