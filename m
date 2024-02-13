Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C37C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxL-0000qS-Az; Tue, 13 Feb 2024 15:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyx9-0000hj-12
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:31 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyx4-0001hQ-Mf
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LWOTl987PIcH80dpnfqtbG3+CxPjlNs17wDfO2QvnWM=; b=IgDwwzeicle1YoU1IjzinSsmXc
 gLeIKNBHDg4FS+KmoKWxxNH8ti9bgtn0y4edkbZs6aveOkGfsUhmZTMga/ilYmWBuWqmcGvm8FjZY
 wOI0NN//TfOw+r8v6yp3Pv+c0uzC1/2FS851BqLy4wJUEBH2ZMgtllee8RkmDp7jUEkj11hWROA/3
 2Tyac2fjxp5A4L4kIfX2Q+qiq/HK1b+2WoVCeGp8dMUDMYAinaX737lyEB/Fec3UfDOxw3ZreP9lL
 X6W7zXPEzXdVPNE/WeJFr6wZajBAUpcMlpblS5k8phxwH4Ky2vOM+rW1dpJ1t+4eHTjHVVBJDIHCe
 ykm33Ef0pw6bU0vQ5/ob0Ou0lIxE8THKHeriGj8HzHzi8cM4q4mUGX4zb9QVOw21OU9B4q0FYX1dh
 u+FkBVorrl+TwtArGpnpvQ929xY8CvJNPFViMrnXvxsDRXn9jWhN0pdBOXL+YtyirbIXnerAiKYWh
 hqW5W3h/h8yKwdJDyIhNGGvhgnSTuh7xA79D7kh2VwbGUS7L0h2R5g7Zga3p2uNIsz8TDJdfSNAri
 nIQFSmlxFYyur/8D0b1Mc2G27fzdzDI5AQW5pOspJbMRon2gSfmBPyrymzPzra6oTZ0purKqZDMRk
 xxsx+N/bVebivcaLt8VRN7iMda6x54ESXhsy82M3k=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhH-0008m4-Ew; Tue, 13 Feb 2024 19:44:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:33 +0000
Message-Id: <20240213194052.1162753-70-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 69/88] esp.c: consolidate end of command sequence after ICCS
 command
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

The end of command sequences for the ICCS command are currently different
between the DMA and non-DMA versions, and also different from the description
in the datasheet.

Update the sequence so that only INTR_FC is asserted in both cases, and keep
all the logic in esp_do_dma() and esp_do_nodma() rather than having some of
it within esp_run_cmd().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-70-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 824ebe9ff0..6c62417985 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -650,8 +650,7 @@ static void esp_do_dma(ESPState *s)
                 }
 
                 /* Raise end of command interrupt */
-                s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-                s->rregs[ESP_RSEQ] = SEQ_CD;
+                s->rregs[ESP_RINTR] |= INTR_FC;
                 esp_raise_irq(s);
             }
             break;
@@ -825,6 +824,8 @@ static void esp_do_nodma(ESPState *s)
         case CMD_ICCS:
             fifo8_push(&s->fifo, 0);
 
+            /* Raise end of command interrupt */
+            s->rregs[ESP_RINTR] |= INTR_FC;
             esp_raise_irq(s);
             break;
         }
@@ -1056,8 +1057,6 @@ static void esp_run_cmd(ESPState *s)
     case CMD_ICCS:
         trace_esp_mem_writeb_cmd_iccs(cmd);
         write_response(s);
-        s->rregs[ESP_RINTR] |= INTR_FC;
-        esp_set_phase(s, STAT_MI);
         break;
     case CMD_MSGACC:
         trace_esp_mem_writeb_cmd_msgacc(cmd);
-- 
2.39.2


