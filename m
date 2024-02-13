Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F405C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyh0-0001hv-Fs; Tue, 13 Feb 2024 14:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygw-0001HA-ME
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:42 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygv-0006Wb-58
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FAt0pCq8njB+6+50rTsiZHlccpr9qzd45MqpAKHkmm0=; b=J6Hd3MQ0kDl5ECo3Jv77nNJOY9
 /DXDNOxpN5ppfEDlXIdSKqKGNtohLV/dxVcdpxUfIzoW30wSZufmnM4VYv7NLMeBpCPA60QoA01yG
 kTJpbxsHTenxyS3OZhUEFsFsF5GOnIxQHJFMlE6OmKhNgZZH8EeYUZsb6R2qE92LDVGp7HXYhYuDP
 nlO3gODjK6CZKDxbe3C5BLjLqKVGjwwOeFRg76sWZQVDJWgG8iFc3YJM8DbPn7+/X+qKmtMm12KCD
 SQi1qUVvTXbfkoRNvsPdAtRN+r4Uj01sCNS5TyVw3QqPxsIKoffmrp0VJFaP1SZTM64dW0iXBSMsW
 IkHclMwkQTYKl9gQB7EhII6DRjdJOgRTaTkXGn86drmW+60pABVj2QiguBecrBt40OpaiL3mTyAXL
 u79BZ4uqRMZRPHtazEm91H/Yl1KD2541lTnANLTNehu5/rqTxyVbo/UJ6dF2Y3RD2xRhK9ZdAMbF7
 bmqDSwoBPeqsNBHpC+FpJapuS5dibQT/9l8LHKQs0+OGqY4FJTUzJqwhRZl435Tz2cUii1kq0Psjp
 Rsxwzl2tC13xO+hCC5ds11ox1RwB4eM1PEWasQD+eDG5A4MpdLo+XrGw6b9wC0LwQFD6tMwp9AqH1
 /4QgU/K+PR2U8UEBjXUWt360NGQer3GYuLm4Yzf5A=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyft-0008m4-L4; Tue, 13 Feb 2024 19:42:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:05 +0000
Message-Id: <20240213194052.1162753-42-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 41/88] esp.c: convert esp_do_dma() do_cmd path to check for
 SCSI phase instead
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

Currently do_cmd is used to determine whether MESSAGE OUT and COMMAND phase data
is being accumulated in cmdfifo. Update esp_do_dma() to check directly for these
two SCSI phases instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-42-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index c1b44e5f18..22739d3875 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -635,11 +635,10 @@ static void esp_do_dma(ESPState *s)
     int n;
 
     len = esp_get_tc(s);
-    if (s->do_cmd) {
-        /*
-         * handle_ti_cmd() case: esp_do_dma() is called only from
-         * handle_ti_cmd() with do_cmd != NULL (see the assert())
-         */
+
+    switch (esp_get_phase(s)) {
+    case STAT_MO:
+    case STAT_CD:
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_do_dma(cmdlen, len);
         if (s->dma_memory_read) {
@@ -683,10 +682,8 @@ static void esp_do_dma(ESPState *s)
             s->rregs[ESP_RINTR] |= INTR_BS;
             esp_raise_irq(s);
         }
-        return;
-    }
+        break;
 
-    switch (esp_get_phase(s)) {
     case STAT_DO:
         if (!s->current_req) {
             return;
-- 
2.39.2


