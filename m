Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 574DFCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO34-0004YA-Bt; Thu, 04 Apr 2024 10:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO32-0004W7-KS
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2v-00067g-KK
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TfdE4Mobss00wYl99ihXiVhrb1ht35On3qfAUQvS6h0=; b=M4nQ66gSRyNVYW9GDUQmEy4A+R
 6ozd7NMm1MU0R3w8bD609pcHYWFesuI5HmE9RdoReaj8fZ23xrVoKxJfXRQtuxtgVc2w5aGhzv9Uj
 BFmBG4bqpZyXPfDAo8C9K69caMR37pe1uVm6hJ8Rt0gpxF5hKuhi7gjSrr2uDmZU0fE5v2rWpnndf
 19EocN5u9uSZ//4YXL8gCjWlaMp2GZOaqUTt39QYtz0T0uDBdGHVB3CGqZTGOCYDh+kwUxvghze/R
 jmN5Is6HxbcwxsX9xeaA4T8z1ysIzgXUE+ocOex6YjDWdPs+XdcDsX6B/g8RhGWtpMQo6cgHfwRHJ
 iguHhzKiCrT2bUJ5JUagyGeEdfIUOnjhUCA2B7X5728LYEKo3IsaS6J0HPdBNHbopX3KactDfVVwb
 joQND9auvY9cX2FqILVWReXIciEMvceyHlvlJ+5aXYv7/8yO0ZTfgeaKslNZmSe3C5Redvhuz4gkK
 6KVVQkX1/48VCRAytbwqkNIOF4U9dbMVn1s2Ha4m9ycbXh2xs0KAzoWnBK3/8Yh+BBedUahgyP/zH
 9Npt9BZ7XFc8v+aF9xuG0FnCA5P5NY9R300kbjHL0zVBW7ftdIKKl5gXAsGZ3tS7zbUnJ+JEWZnAo
 YvuuRQbBsIly8Z9tBN+zVUQf143OxgusoQ2aZzLFs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1w-000Bmt-Nd; Thu, 04 Apr 2024 15:25:32 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:31 +0100
Message-Id: <20240404142539.711134-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 09/17] esp.c: introduce esp_fifo_push_buf() function for
 pushing to the FIFO
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of pushing data into the FIFO directly with fifo8_push_all(), add a new
esp_fifo_push_buf() function and use it accordingly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-10-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 83b621ee0f..1aac8f5564 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -116,6 +116,11 @@ static void esp_fifo_push(ESPState *s, uint8_t val)
     fifo8_push(&s->fifo, val);
 }
 
+static void esp_fifo_push_buf(ESPState *s, uint8_t *buf, int len)
+{
+    fifo8_push_all(&s->fifo, buf, len);
+}
+
 static uint8_t esp_fifo_pop(ESPState *s)
 {
     if (fifo8_is_empty(&s->fifo)) {
@@ -601,7 +606,7 @@ static void esp_do_dma(ESPState *s)
             } else {
                 /* Copy device data to FIFO */
                 len = MIN(len, fifo8_num_free(&s->fifo));
-                fifo8_push_all(&s->fifo, s->async_buf, len);
+                esp_fifo_push_buf(s, s->async_buf, len);
                 esp_raise_drq(s);
             }
 
@@ -650,7 +655,7 @@ static void esp_do_dma(ESPState *s)
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
-                    fifo8_push_all(&s->fifo, buf, len);
+                    esp_fifo_push_buf(s, buf, len);
                 }
 
                 esp_set_tc(s, esp_get_tc(s) - len);
@@ -685,7 +690,7 @@ static void esp_do_dma(ESPState *s)
                 if (s->dma_memory_write) {
                     s->dma_memory_write(s->dma_opaque, buf, len);
                 } else {
-                    fifo8_push_all(&s->fifo, buf, len);
+                    esp_fifo_push_buf(s, buf, len);
                 }
 
                 esp_set_tc(s, esp_get_tc(s) - len);
-- 
2.39.2


