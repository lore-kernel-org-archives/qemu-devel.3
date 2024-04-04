Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73584CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO2m-0004Ks-4c; Thu, 04 Apr 2024 10:26:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2k-0004KT-Cu
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:18 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2i-00064e-Ky
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k79Btk0VrvQni/gl5EqJSRRpNN5BdF3rIq8LImrqPN4=; b=KTESSq7bffEWlIEZolF+w5lkF+
 7O0VzITkZukL6Yx6quFONhgeZ5oeokMOVlK9C1Dp9avA2W3SG/pVcOB4tR0Df5mLKo9alC6pCyRjX
 cRo+loKK/Nkgoqbt6UHN44h1gWjU5J/8MmQc94qHfZrL7Kta2CX6p2tl+MeBxPJ7Z0kyaIT3jJXoR
 deprd0RHStmt5hEd8VHdumvz3cWdx6XNJ0rUwzCcicJpaDrfyUsKga9UyKLNAjE6am/NQVWhNFT7E
 IMZqFeFjicKyo+dh1aIeptqb7haLQ0F7cOrqn5eUwKqhC65PtF5YHIrbX0nic+buRTCN8OaJJqYKQ
 5jtvyTfZD/Dn/zpHuLs+eYWQqXkxoKVmTfI4spfbgmFrcQTMq4UrjDK4o3H+4ie0OsOguHD+iS4mr
 /UlODlMSxtlHPZdvIsj82GicQ9ZZLvNumUOkm/E66rcdbA3cltMhFl+NQ8kN94cuUtdggVHupXWba
 A77iqxvM8P9v/lPTRpFNnNv2l7lAhsiHT9xnR8GBdgzQyEmLoclZ2ENKH6i+4ZAcJACpvVdcBoSFQ
 O8TOBJyzvT/ThScWoX3/AY1+TSJBFFIC8zBN47hn4i9oh8xiYdMCyC8m5LF1vdnCBXGhtf3mT04Ex
 4vv8nlrRnmXEKSXh43SVSzt+HUkueqcbwdkqWqkUA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO1k-000Bmt-A4; Thu, 04 Apr 2024 15:25:20 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:27 +0100
Message-Id: <20240404142539.711134-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 05/17] esp.c: change esp_fifo_push() to take ESPState
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

Now that all users of esp_fifo_push() operate on the main FIFO there is no need
to pass the FIFO explicitly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5b169b3720..7e3338815b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -106,14 +106,14 @@ void esp_request_cancelled(SCSIRequest *req)
     }
 }
 
-static void esp_fifo_push(Fifo8 *fifo, uint8_t val)
+static void esp_fifo_push(ESPState *s, uint8_t val)
 {
-    if (fifo8_num_used(fifo) == fifo->capacity) {
+    if (fifo8_num_used(&s->fifo) == s->fifo.capacity) {
         trace_esp_error_fifo_overrun();
         return;
     }
 
-    fifo8_push(fifo, val);
+    fifo8_push(&s->fifo, val);
 }
 
 static uint8_t esp_fifo_pop(Fifo8 *fifo)
@@ -229,7 +229,7 @@ static void esp_pdma_write(ESPState *s, uint8_t val)
         return;
     }
 
-    esp_fifo_push(&s->fifo, val);
+    esp_fifo_push(s, val);
 
     dmalen--;
     esp_set_tc(s, dmalen);
@@ -1240,7 +1240,7 @@ void esp_reg_write(ESPState *s, uint32_t saddr, uint64_t val)
         break;
     case ESP_FIFO:
         if (!fifo8_is_full(&s->fifo)) {
-            esp_fifo_push(&s->fifo, val);
+            esp_fifo_push(s, val);
         }
         esp_do_nodma(s);
         break;
-- 
2.39.2


