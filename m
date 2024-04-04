Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEBECD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO3K-00055u-KC; Thu, 04 Apr 2024 10:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3H-00050X-Pf
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:52 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO3G-00068q-8L
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xGkCtyfhMgv5LN6nqN6/ElxC0odgNGKQ/Amx41/YI1M=; b=H3Cq90jXIzQ1JYN6lyrScVmAKn
 P/4FHUC8LUX9kHVVf0uEy3CbsiRW1y3P3pYbQuGbn95+6VaLrqnuSdb+OHJ8Bwh5pqwX0COFf3p5g
 EeseoWNl9TJ7y2dS3GUX2QFPmybNl+qbC7l+opbOLarougUNkrts2JWSgV+sJ1hzP7cvFaY+pG+Ta
 mYPmi4OYis7IqKyjVQy4vVGu/JpdP2FDVkdOMWGxi462mUT2J1tsZRub+K4r0MyGwgqU5PCnNoE+2
 gL475JnLipodALtF96p5+g8uXik9ud9DyJyw1yZMzEvO7Nfn00/WGA3XVTwmp0A3x+iVA/QlvjgN6
 /+k6xUfKx/nGk1NRvZ8wBAEZUKlM8NMRnge02GaGXJyzmLQnCUXq4kKcQX9Cfm7t8wtryDT8D61LP
 i6AbJgnaJTBVaduJcFRTln8FofgGDcJfsg6X6Zz3sy0I3xDkVn3T8BD6KJjP9hUb7mD82e5ZeXzvh
 gt3wiPi+eV0JiGN8SZxl2o4KtKHSHmNYAayTOsDXxxqGzGFKYISnAQ72Eg14yWC+2KU0j/odvw4HZ
 XK4jlT6/SZS8wAGdW8XPnFt52+vTJMiaYIF7NrVyziK1cZtLH/ESIKiDVEIOMETcD5d8ksc43lPVh
 snJq03iKDHL81ZJf1mE8HQuAcxGxn2FlyItgUdkF4=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO2A-000Bmt-NA; Thu, 04 Apr 2024 15:25:43 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:35 +0100
Message-Id: <20240404142539.711134-14-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 13/17] esp.c: move esp_set_phase() and esp_get_phase() towards
 the beginning of the file
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

This allows these functions to be used earlier in the file without needing a
separate forward declaration.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20240324191707.623175-14-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index d8db33b921..9e35c00927 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -79,6 +79,24 @@ static void esp_lower_drq(ESPState *s)
     }
 }
 
+static const char *esp_phase_names[8] = {
+    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
+    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
+};
+
+static void esp_set_phase(ESPState *s, uint8_t phase)
+{
+    s->rregs[ESP_RSTAT] &= ~7;
+    s->rregs[ESP_RSTAT] |= phase;
+
+    trace_esp_set_phase(esp_phase_names[phase]);
+}
+
+static uint8_t esp_get_phase(ESPState *s)
+{
+    return s->rregs[ESP_RSTAT] & 7;
+}
+
 void esp_dma_enable(ESPState *s, int irq, int level)
 {
     if (level) {
@@ -200,24 +218,6 @@ static uint32_t esp_get_stc(ESPState *s)
     return dmalen;
 }
 
-static const char *esp_phase_names[8] = {
-    "DATA OUT", "DATA IN", "COMMAND", "STATUS",
-    "(reserved)", "(reserved)", "MESSAGE OUT", "MESSAGE IN"
-};
-
-static void esp_set_phase(ESPState *s, uint8_t phase)
-{
-    s->rregs[ESP_RSTAT] &= ~7;
-    s->rregs[ESP_RSTAT] |= phase;
-
-    trace_esp_set_phase(esp_phase_names[phase]);
-}
-
-static uint8_t esp_get_phase(ESPState *s)
-{
-    return s->rregs[ESP_RSTAT] & 7;
-}
-
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
-- 
2.39.2


