Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF88C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZz0F-0003yT-Nb; Tue, 13 Feb 2024 15:03:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyD-0001we-EY
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyyA-0001tR-Bi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FxqkEyFdghhzUVVrJhMt3r//ymnaPjWR4IuvQZuvoH0=; b=DOILSh1B7I4UkcBtHuatvWcV2p
 eOYcXGgyE5o7QxziLqLr9Y4KA7Y26xahFS6EUGIHZrRIInR50YqT82qUBLfkljMUSBw9dMDGl8IwW
 65wp/u1najC95n92DUwoIodlXmnv1HYxAIFpzUcUJWrpSJ6vJ4cfFVSG7OnLGrRvINemxUzVo9P3Q
 WN93P0z7cLgxSmmgQ1AYDZ1FkfRBSlBc57oHui+GTP8e5Fgu9pAE4xLn5pAbi8xCsnAuUb2VQQ0q2
 Z9n/Hgxqw9rfXI3iwc44uB8UGqW95x2vEsZ0kXGhQwbyRAN0BYyrbWAAZp3GcNzvoTDVBvTP/qWqL
 3yNmzqtlqYGAOMDg/V2tRhfuO2EFWAxC10kI8cIIK0dN49Jj34QRAQY/abuamdhdDEP59VhNi3V9X
 OIb8dSypfds8WsNr0o6MwaaJfdf7DS7ZnmPrLQJWS7bHFBN8086a67vxSoVUauOTohgVuhjTXwSOx
 ZTdcRSRi4t8VNN3GsoUMhsmhLSnx2A9qatWbF76JM46GkKEIhfXzTqF+WsGPgPLK1TSXVveOD1lkP
 two52e4NuXCUj+NEGkiaJYC6izMVgDCdr86NTWjyopI0R+Hi5iIrnzWPKW1rKt4UisBiQGpSHth3U
 vzfE6IdXw4bj84721zbFoHAVBETHZDT3UZSSvQAsM=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygz-0008m4-15; Tue, 13 Feb 2024 19:43:46 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:25 +0000
Message-Id: <20240213194052.1162753-62-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 61/88] esp.c: remove DATA IN phase logic when reading from FIFO
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

Whilst the FIFO is used a storage buffer for both DMA and non-DMA requests, the
loading and unloading is managed directly issuing commands to the ESP. As a
result there is no need to manually invoke the non-DMA command handler.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-62-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d71465718c..4c1ca63a57 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1067,17 +1067,6 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
             qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
             s->rregs[ESP_FIFO] = 0;
         } else {
-            if (esp_get_phase(s) == STAT_DI) {
-                if (s->ti_size) {
-                    esp_do_nodma(s);
-                } else {
-                    /*
-                     * The last byte of a non-DMA transfer has been read out
-                     * of the FIFO so switch to status phase
-                     */
-                    esp_set_phase(s, STAT_ST);
-                }
-            }
             s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
         }
         val = s->rregs[ESP_FIFO];
-- 
2.39.2


