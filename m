Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B25C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKSp-0001Ps-CH; Wed, 13 Mar 2024 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSa-0000xA-A4
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:40 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKSY-0002Me-HI
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:59:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HKxA34eftxuciJ72XV/d/Ny5Ajj9BUiqdu6fSQNsew4=; b=n/MsKff3peisfhnFilSS74YAED
 SgQMvUdpFLUZ17cLDQBnleH7nHPMX6nV3nvX3sprewppOc6aLK144Apn/vC2ItmwkM6hjW5bxeduc
 2/BQAv7ebwAq2f5rfYv8olgO2iuHPtbfOCVPt7pDN9oc1ZBPGQI7WS9VKdBBBvXrMjF4hvywYgow3
 acfUBGdYzBKQLAIMay/6TqZcRKCvbJ/dej1JkBo5zdkJX8OI/zZ+i1Pm7DrH4/yHSEJGBP/1KjSG2
 q5HArD4cbWyJK8am5P0lXwuo4gM4M0u2DdYTCm8z+10Zt1AM5EEqwt3lRpB0NizABqQ5PuHTp9lya
 MO6IL6+lBbMtudiNTq0HAIPW4V3CdeO1NLLxz0zVWNTzDuKPHkX6nkRUjOVUbIj03Z3SZaoJI0S+p
 WfFS+bylIcQKccBI6RQHAbVHDNN4eCHte1vVf9/XGxKkZnLnoPm5Dk/Xgm9x1Cr8MRopcW/1qtrom
 Ix4yZs2pDI+3CBEWXsjeRzxctPhpSbZT9HGq3pN5OcwBPKWvAXR8i6it0j1DK/EGVgyuDoVKr+8ID
 SSQigfTE9vbm1jIaDNi1WML2rsA6f+SNYhdrNyLMonawNd6MoaE3mv8pcQtwub5Ty1R2NYpzbK3cH
 y9apfVH5uMmw2QJ2GY4tgHbfV/HiJb38oqZZFOdvo=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRU-000CUN-Nd; Wed, 13 Mar 2024 08:58:36 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:10 +0000
Message-Id: <20240313085810.2655062-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 16/16] esp.c: remove explicit setting of DRQ within ESP
 state machine
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

Now the esp_update_drq() is called for all reads/writes to the FIFO, there is
no need to manually raise and lower the DRQ signal.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/611
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1831
---
 hw/scsi/esp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 68346ceaeb..2b479b1b5a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -496,7 +496,6 @@ static void esp_dma_ti_check(ESPState *s)
     if (esp_get_tc(s) == 0 && fifo8_num_used(&s->fifo) < 2) {
         s->rregs[ESP_RINTR] |= INTR_BS;
         esp_raise_irq(s);
-        esp_lower_drq(s);
     }
 }
 
@@ -516,7 +515,6 @@ static void esp_do_dma(ESPState *s)
         } else {
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
-            esp_raise_drq(s);
         }
 
         fifo8_push_all(&s->cmdfifo, buf, len);
@@ -573,7 +571,6 @@ static void esp_do_dma(ESPState *s)
             len = esp_fifo_pop_buf(s, buf, fifo8_num_used(&s->fifo));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
-            esp_raise_drq(s);
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
@@ -605,7 +602,6 @@ static void esp_do_dma(ESPState *s)
                 len = MIN(s->async_len, ESP_FIFO_SZ);
                 len = MIN(len, fifo8_num_used(&s->fifo));
                 len = esp_fifo_pop_buf(s, s->async_buf, len);
-                esp_raise_drq(s);
             }
 
             s->async_buf += len;
@@ -657,7 +653,6 @@ static void esp_do_dma(ESPState *s)
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
                 esp_fifo_push_buf(s, s->async_buf, len);
-                esp_raise_drq(s);
             }
 
             s->async_buf += len;
@@ -723,7 +718,6 @@ static void esp_do_dma(ESPState *s)
             if (fifo8_num_used(&s->fifo) < 2) {
                 s->rregs[ESP_RINTR] |= INTR_BS;
                 esp_raise_irq(s);
-                esp_lower_drq(s);
             }
             break;
         }
@@ -1013,9 +1007,6 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     s->rregs[ESP_RINTR] |= INTR_BS;
     esp_raise_irq(s);
 
-    /* Ensure DRQ is set correctly for TC underflow or normal completion */
-    esp_dma_ti_check(s);
-
     if (s->current_req) {
         scsi_req_unref(s->current_req);
         s->current_req = NULL;
-- 
2.39.2


