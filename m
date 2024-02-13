Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE7FC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyxs-0001Jy-HG; Tue, 13 Feb 2024 15:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxq-00019b-M3
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:10 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyxl-0001rZ-Ij
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xIQhiDMF5ShO7draXOu9AcwBlKFxzqVjZOPlxwEsOao=; b=FG8bFFnfmjsMgc1yi6EDYWgWrk
 OUfT18FFbj27BcVbNZIMAtAYwbt1DUdXPAQZfmRUkyzYKWel6qbdvtlMNXrr3Ja6PMZuR8vG+GWIr
 o01f2yS2J/zAz3D0ZWTNiuz7IT/TZ2pJZITI34DqWBZtbsfql/ke1DYfYYrV7mkLyDgQX1nUFNyQe
 ob4tpxfcq0ZpQa0NI39eseJ4DRAV/rhj/FPot0a62qX2fcZVn8uG16z2twYENsOX8CvbnqSYwPFnJ
 7RKXOAzSbI0FcLkK99S6vjid4N2sbe3GC86J9PBUXVlv6z3MrvKC6t3mC2uuUCn6T/PaB50zC3mBR
 Kb0nMFzk9of5hYJ8Y0PP5ODCIBf2MsBMicAcG6lqQxyy32fW9Gl2zrOVUN9cZAjRU7qHH+arMqkaK
 8s2V/aUs8O99yougEf/OGFpNytVuOPwOC56bpCZZQOkxRPaWjf6vRnr6vIfN6hotflu2F/Ru+0lcZ
 rGbNIFJNhGVLDpZJsLU4yMewjuWJ50HL26WgXGNDmnpyXs/2WqGo9UZwFyy2PphJLjYjE2cBHtDeJ
 h6BnMRJIZGOzrMJjVn+NDNd8/P0GHUEe4BGmQI/tL+ECNZ1/uLz5+7fiKyRTUeOYCi/FNwpOgynTB
 nWL2CvA4lZ94f7D0CB41e0pnZrP1f5B8Skr+OpEtY=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyhS-0008m4-Qn; Tue, 13 Feb 2024 19:44:18 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:37 +0000
Message-Id: <20240213194052.1162753-74-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 73/88] esp.c: remove restriction on FIFO read access when DMA
 memory routines defined
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The latest state machines can handle mixing DMA and non-DMA FIFO access for all
SCSI phases except DATA IN and DATA OUT. For DATA IN and DATA OUT phases, the
transfer is complete when TC == 0 and the updated logic will now handle TC
underflow correctly, which makes it just about impossible to manually manipulate
the FIFO during a DMA transfer.

Remove the restriction on FIFO read access when DMA memory routines are defined
which also allows the NeXTCube machine to pass its self-test.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-74-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index a3e18bb3d7..f9d848171f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1133,14 +1133,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
 
     switch (saddr) {
     case ESP_FIFO:
-        if (s->dma_memory_read && s->dma_memory_write &&
-                (s->rregs[ESP_RSTAT] & STAT_PIO_MASK) == 0) {
-            /* Data out.  */
-            qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
-            s->rregs[ESP_FIFO] = 0;
-        } else {
-            s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
-        }
+        s->rregs[ESP_FIFO] = esp_fifo_pop(&s->fifo);
         val = s->rregs[ESP_FIFO];
         break;
     case ESP_RINTR:
-- 
2.39.2


