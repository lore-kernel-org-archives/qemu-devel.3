Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF4CCD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO34-0004X8-5s; Thu, 04 Apr 2024 10:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO32-0004WJ-K9
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:36 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2z-00067w-6y
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oKWH6eQrfAJaf+JSRJJa+vY+/duho+xeGgHU0OeZdrw=; b=PDewGj71JNTQngcNpcuz6/1ddY
 MsnLEKbzAJOafCoaXVVkvYJJ+LBTMXYLcMa8I5rG8fECyWq+VYGtSexnzDdQoT024w2y4/U7XGp2U
 YUPZM6vVnbqgOjQ9tLsnLbmvrEyFSQkX+25SatZqWjNFWaurU2Xf3Otx1sDGlfYTlECDKl8piUpk0
 JwbM46JVUqHY7MVpPzI4bUmWcIHQ13k46GVAVJTPmo4Lw0DdJp0vyVtbXeNP/KWT192blub8TNqs7
 T6cwlZ+lMCGfdmyBQFSJfwAMoU7jEBO6YUBN9dVLxNfJ/y386dSM3XwnkibdY4aUIXA08AO2EIXKw
 3fYANkBgt06x6qPypMzbFXyPI3WibDfTtJdJ1kYBnwCFp0gTfrk2i6XanUtNz95QUtf93Mw48i4gr
 rLivWCtIl+lS6hdGyQicmor+zAfWbfKsoLUyTY7iyB6EH7m9jphNOb1pUUED+GjvUdkBpszM+5F5O
 JUZAnfDUzkzyxpjBhZt0dFYvSC62gfKTugDbF5Pcx3AYnSknLLXcmtn9SkaB7AkLB3uEyhCTAi/HB
 ccAwOboABkHnGma+wVyMeHbebcmLbH2fWoOhEjRyAeZRrFgjxhsU9D+enNze7S+THvRCkz5nMoLbq
 XZ5Aqct7bXjbmEQCgm8B7X0P9jLiRr7Pc0rl+RoMs=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO20-000Bmt-Qx; Thu, 04 Apr 2024 15:25:36 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:32 +0100
Message-Id: <20240404142539.711134-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 10/17] esp.c: don't assert() if FIFO empty when executing
 non-DMA SELATNS
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

The current logic assumes that at least 1 byte is present in the FIFO when
executing a non-DMA SELATNS command, but this may not be the case if the
guest executes an invalid ESP command sequence.

Reported-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240324191707.623175-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 1aac8f5564..f3aa5364cf 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -762,7 +762,8 @@ static void esp_do_nodma(ESPState *s)
 
         case CMD_SELATNS:
             /* Copy one byte from FIFO into cmdfifo */
-            len = esp_fifo_pop_buf(s, buf, 1);
+            len = esp_fifo_pop_buf(s, buf,
+                                   MIN(fifo8_num_used(&s->fifo), 1));
             len = MIN(fifo8_num_free(&s->cmdfifo), len);
             fifo8_push_all(&s->cmdfifo, buf, len);
 
-- 
2.39.2


