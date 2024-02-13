Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465EEC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyfY-0003V7-OX; Tue, 13 Feb 2024 14:42:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfT-0003KR-SJ
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:11 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfR-0006Kq-38
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=txS0EkWpqSoeHABEVeI8A4WFbirOC3ILO1uIwpoPXpY=; b=OJF/1Qb7W5/wfqDpp5Kh+7JZt4
 qkRvskThNGwGkTmu5szXNjFpSBAb585HTbiVsz/uHssPBDzh5deHPBhmiMSBu1g+W1NArec++7J5S
 TfERCPquBBGW9YPTYF5URfJ5x7SOeBIHaRCl9WUYEAhYzg+VOJ5sRqAxZN1tXy2ToWGJ/5RpL83Fc
 8uC9gti1JMWZWmXTqvApeZjigpkPDqIS/dUm+gxZTfLJBoT4RbuSvJUjQHDoSa8QhBojKwDyW7PqW
 B+RQwc9UiBPYJoCJULfaKWhLlAUOzC9elWpRLLVr8RzZlRxWyvuUnMvOe0rsa0KMB7xNGsi0PGSxz
 0T58Rif47ap3VJZpF1ULwnaNvCQ3KC26o7nt51s9tQ8SJYBhwbju6K00ELsH5izH55OTO19CO2csz
 uLVAJaJ+HkoK5RaTaSp8hX+lT4WIOl6O72+OIo4gDumBR46SRi6agwyT2dZGfvLAqppRKeTVKWkQz
 3o4Eoz080/UeeyTv9kCJLKnSR9V3LDdqcK/xRW95607yW1094qlwNfxJg1N/eBIKYWVVeXxxY1ysJ
 XCGeNSx64uXVTRU2LiMPXTqmTJShZzGKjWvUC6vh/ZDQI4h7E2b4NFzZuA9MsP9tNQ78bnyqZAffY
 8UPQC5lG7Cn7Phhxco9zu5AWSgTGccVrE/93nJ3qA=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyeY-0008m4-TT; Tue, 13 Feb 2024 19:41:18 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:40 +0000
Message-Id: <20240213194052.1162753-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 16/88] esp.c: remove MacOS TI workaround that pads FIFO
 transfers to ESP_FIFO_SZ
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

This workaround is no longer required with the current code and so can be
removed.

[Note: whilst MacOS itself can boot correctly, removing this hack prevents
a bootable EMILE CDROM from working. This is caused by a separate bug which
will be fixed by a subsequent patch]

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-17-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 6fd5c8767a..f41b2421f9 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -772,18 +772,6 @@ static void esp_do_dma(ESPState *s)
             s->async_buf += len;
             s->async_len -= len;
             s->ti_size -= len;
-
-            /*
-             * MacOS toolbox uses a TI length of 16 bytes for all commands, so
-             * commands shorter than this must be padded accordingly
-             */
-            if (len < esp_get_tc(s) && esp_get_tc(s) <= ESP_FIFO_SZ) {
-                while (fifo8_num_used(&s->fifo) < ESP_FIFO_SZ) {
-                    esp_fifo_push(&s->fifo, 0);
-                    len++;
-                }
-            }
-
             esp_set_tc(s, esp_get_tc(s) - len);
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-- 
2.39.2


