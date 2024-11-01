Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4DD4E6F092
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 22:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6zhg-0004LY-R9; Fri, 01 Nov 2024 18:01:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhd-0004KX-RJ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhZ-0002nn-CD
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 18:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=+d773DwhBknavPzpCmrrvLZ47FDvAPTWHJ8AGBcn2Ss=; b=Uers8bq6snMVzs2hw0jo49FpJR
 L3ska1TuvMetzciUTUAttZqgsU4hP/V4+XjFstycj0RI+qUcIpveES11HMlJ/0VBzPBBxzZZjTwwl
 T5L1YnJeT3NyJJS8eoQ0f1wvpwiAX/aLbE+m/8EX/RHoRAAlpR38nwTgOU+F0lGIwEFud1HpNi5h1
 RVJ1ZwLiUJQUAWyWYC/2TL/676LmmvmBYOn4MkJNKFuvg/4y97/OqTzzgA5fV9ls+XiVXbNRVRVmG
 Mvt3WPXFDS2hvwb8tWpCNEmAbBR/QkV74/k/gIROqWkb0spB+ifHfUkKjAZ4laXa3nCaToWE0XY07
 WQnSZKv0MwMVp9DsfaW4mmn3MxjihPMLURNvuXGC0XQYHov2W6bOEgngFMw93yeWHN3dQ4wadiAeZ
 rHTWgMGFg27d++QGOzys7kQKUUGaZEREhpH0bevuKIwNnrFgBQvvW6qHEcSFtWobwNEmlq/N6havW
 1KyUORZg9eg0Xeus677BJMD/HdE55vmPlZ6yADHoVkdAzBux0dGYAF69yXX+bbwXwh/S5TksVIbGN
 1AtH4JjvefYNbvSggA9TTWmwYBtwk5mWOx4SmjqST81CTvcDcn07IVZ4mGVWriKo4vQraw8IRCF2k
 +m/4kBOjUOzjFdIU8KauAz4RmG4ThMisOHzNnLbu0=;
Received: from [2a00:23c4:8bb8:f600:91a1:336d:3931:745]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t6zhC-0002pk-ER; Fri, 01 Nov 2024 22:00:42 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Fri,  1 Nov 2024 22:00:48 +0000
Message-Id: <20241101220052.1463805-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
References: <20241101220052.1463805-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb8:f600:91a1:336d:3931:745
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 1/5] esp.c: only raise IRQ in esp_transfer_data() for CMD_SEL,
 CMD_SELATN and CMD_TI commands
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

Clarify the logic in esp_transfer_data() to ensure that the deferred interrupt code
can only be triggered for CMD_SEL, CMD_SELATN and CMD_TI commands. This should already
be the case, but make it explicit to ensure the logic isn't triggered unexpectedly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ac841dc32e..5723290d62 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1015,6 +1015,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
              s->rregs[ESP_RSEQ] = SEQ_CD;
+             esp_raise_irq(s);
              break;
 
         case CMD_SELATNS | CMD_DMA:
@@ -1025,6 +1026,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS;
              s->rregs[ESP_RSEQ] = SEQ_MO;
+             esp_raise_irq(s);
              break;
 
         case CMD_TI | CMD_DMA:
@@ -1035,10 +1037,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
             s->rregs[ESP_CMD] = 0;
             s->rregs[ESP_RINTR] |= INTR_BS;
+            esp_raise_irq(s);
             break;
         }
-
-        esp_raise_irq(s);
     }
 
     /*
-- 
2.39.5


