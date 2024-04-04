Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CD2CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:27:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO2h-0004Gm-My; Thu, 04 Apr 2024 10:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2c-000484-6R
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2a-000631-L1
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GJR0VoABK2pO+IUfMqLTfclvFyeI+D/uHHwE0C37uhw=; b=NLnCs+ffgQ/trKuMUSgU2qOQAn
 cDGijV2pd9gy4nAO+jsneQOZ6nTBFN7UBzbj4DsJl+Srw5skBDTqvU0PZ6BnRXDrX6YqX7xZn+EAQ
 gyOl0ko//Oo9tfyhBwVfCl7vlXoBOSjQt3/O95RwHCZOYT/me9fIxiWukRTvOqIghHW2aLHUKgktO
 PvyjiXhBG3uPfTsyAjZmwm4OGxEJugb02LQWE0nGfItfeBP/+MT32oUMRyr8aVJz/wYOd77JpX47D
 8qJDjfV6ae8yDTvJ7ilq9fSkkXF49f9QHmo1fTEm5d8uJxs4tinP3B5eM31Q/TcuBwkgZwQmObWH1
 Vo5ihHG3vRSNjVrAFYDRrZkiPDfhw4Y925sJZJN9QiUjsMqCSVKN2up7iPunTRnlv1uWpItzMuzzT
 JBvvA4nLmCsrH/zn3KznUAH2eusfP7ysydUknDbhKo4BVLWr2tdZeY2oqXbSLI1sX+LbMwr/XUtXl
 h+8Ej7j0ttNsgzfOY3OXjBkPi+n8ZOqO0LArMUcLUR7yl0LLoN63+j87FCPQAy9J3a6JH8zZKhml7
 tOw4J9DZVdMWIDgF1bwntR69M/G3yMqraeurlIWFHzQlOFrJh0/24gnxcNiwdIKgeUkL1VI38NOgd
 GqOAWegtsuqOvDHOxfcz0quWfeHyFpO30SJfYaDHo=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1c-000Bmt-GS; Thu, 04 Apr 2024 15:25:12 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:25 +0100
Message-Id: <20240404142539.711134-4-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 03/17] esp.c: replace esp_fifo_pop_buf() with
 esp_fifo8_pop_buf() in do_message_phase()
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

The aim is to restrict the esp_fifo_*() functions so that they only operate on
the hardware FIFO. When reading from cmdfifo in do_message_phase() use the
underlying esp_fifo8_pop_buf() function directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240324191707.623175-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index ff51145da7..9386704a58 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -325,7 +325,7 @@ static void do_message_phase(ESPState *s)
     /* Ignore extended messages for now */
     if (s->cmdfifo_cdb_offset) {
         int len = MIN(s->cmdfifo_cdb_offset, fifo8_num_used(&s->cmdfifo));
-        esp_fifo_pop_buf(&s->cmdfifo, NULL, len);
+        esp_fifo8_pop_buf(&s->cmdfifo, NULL, len);
         s->cmdfifo_cdb_offset = 0;
     }
 }
-- 
2.39.2


