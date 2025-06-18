Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39CFC7115B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 06:14:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRm2l-00022v-5C; Wed, 18 Jun 2025 02:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2h-00021k-1l
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:03 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm2f-0003x6-8K
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 02:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=q8LLQNq5WuHGwbudB5H8PvV8YdTw969EMv9g174ty7k=; b=G3NKYmhLgvkdK0yhMZL9lsGQ7e
 ScCl2KQdOlGK2PwFjwrPCf3ZHTRwz2PDGLXHPiAIzND09EkwfOf3J+9nXXJO9toOVnx92FVOV6wpF
 n1JRn/LtPYaedJBfSeRBKusXTjfDzIYavC/UUodypVnbJd/La7kOiY7dAUr5PvfM5AXRsMH6btCN6
 72sMaooH14LV6oULSgyN/lqIyFtEzqCEKfSxWbTZla8LT29D2juUGr36mNPkWzuFgcCfdwDXgQ5yb
 FdR2Z4pQ8zAjGzLkZiBhYVKb5XhqJinfL1OVxjwDG3Bkg1Eyf8JfG1DT/FvPXQXEfSimt+0qFdPi9
 9+2L3GCfSPVu5/aLbfuvrM145HWaS8lGvC7/ZfJk8n/QewXG7d6dkTowZ16BQEcYf538njSU17vPr
 zH3LCaYmB3Fs8jkexqhtn6gu4omclmz8KgCDK6LuK5AfU8DyQ061LJjhmdr9kvpxKCGkE4BscIkl9
 itRpAuiB9yzNUOlQI26nPx8SIW2uRyXENEGuFgI+JuD1FCE/U7enpCXXiKaDY7ZB86VXu6R4Ki9iy
 C6ObesQrJE27k1ddEjqsBJeg2UUyzxOtjW6YcnMdMd3Cicydmd+LryFjMjhkKjfkuKrxwKe+Ujq++
 LB74QRKrmckc5i/pFSXrXmGo/pnvr9SKqAO5OeHYc=;
Received: from [2a02:8012:2f01:0:737f:96a4:fe2:308c]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uRm18-0007ok-Gj; Wed, 18 Jun 2025 07:11:26 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com,
	fam@euphon.net,
	qemu-devel@nongnu.org
Date: Wed, 18 Jun 2025 07:12:43 +0100
Message-Id: <20250618061249.743897-2-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
References: <20250618061249.743897-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:737f:96a4:fe2:308c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 1/7] esp.c: only raise IRQ in esp_transfer_data() for
 CMD_SEL, CMD_SELATN and CMD_TI commands
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
index f24991fd16..9181c8810f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -1012,6 +1012,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
              s->rregs[ESP_RSEQ] = SEQ_CD;
+             esp_raise_irq(s);
              break;
 
         case CMD_SELATNS | CMD_DMA:
@@ -1022,6 +1023,7 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
              */
              s->rregs[ESP_RINTR] |= INTR_BS;
              s->rregs[ESP_RSEQ] = SEQ_MO;
+             esp_raise_irq(s);
              break;
 
         case CMD_TI | CMD_DMA:
@@ -1032,10 +1034,9 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
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


