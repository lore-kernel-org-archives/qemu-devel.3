Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F61C47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 19:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roTLx-0007Qo-Dg; Sun, 24 Mar 2024 15:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLw-0007QS-2M
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:56 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTLu-0005Lg-P7
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 15:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bV0SiW0ZqgUWcyutbVsGP9R7fmr5ShlrUjw2Iwufomg=; b=HSmKiWUOZzX+66qe5unbai43dR
 PYCqUlAq6pUJyaoj5eg403FDGE9sN3lt84F3a6oBKn5aYwmPw1mOfCGa0/Gs8aUnfEIUelAE2OioK
 aK+jeD/V7Mj7fBlAyco8hJYUMn93oZhbW0hgdPgSHMVZGwLWgQ7VD/e+krm8FUO1u2LQBIqBkhksP
 IFm6zZQVEF+pRfuHOC3EIRs6cyKfvCS4On3Bv5AytMg3zM99q71OUgZkmDl0kkoO+KF7/8/ThS/V5
 HY68PqbphkYyRtNZNbSmNu9gth/zTN7Zkby6/PHZ8fguVK6jRmKi/uMzxOPHoyqn54h2s+Z+FhdaV
 fxDdVJmDDzmqRHrH6VZH+UW9p9zVIHn35ehs9Cv3AOCbzNeGJdJt1VGrdMgdvAbfm5GPhuBgIdBGF
 3+VD8h+XObUqpQ21icsSWLNyDqX2Muy7Sf6iyzUzcYx9TP9yLPI9lw5Pw4f3g1+740sn0TD64llxw
 L84CtLwVIaO1RqflsnXQqjvW+8B9L/rhmtQBDc7Njkmgf+yK5cKzt0cxkugiu9r7qj2UhkTEksMbn
 SPH5N2uqc9iQJB3eAQT25YiyzZ+cT8upUFpgku7Ys1pAifUHjUAvyTjQCF2Q0ilOKpHASnMaGYHgr
 dIq4hrBC8s4sMEctUajGhE9vG0+Q/AzBGv1nUjV7I=;
Received: from [2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1roTKx-0000dj-HT; Sun, 24 Mar 2024 19:16:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Sun, 24 Mar 2024 19:16:58 +0000
Message-Id: <20240324191707.623175-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
References: <20240324191707.623175-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:d8cc:63fe:ef32:8539
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 09/17] esp.c: introduce esp_fifo_push_buf() function for
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


