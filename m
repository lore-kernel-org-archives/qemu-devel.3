Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFE9CD1299
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:26:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsO35-0004ce-9s; Thu, 04 Apr 2024 10:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO33-0004Wq-JU
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:37 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO31-000689-BX
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=h31Zpv7yg0qEAoRsfBy+KqmU//6SKT+ar2XpdfNd3Ho=; b=c340n4rFrTSVIfq1Zzp8IygWAB
 VVcgQ3XrdgPOlCy94C+A+i3pKyXDrYGv0sNoxhz6PcZnXzEdO9qNI90AAirIrRWI0viKXQ5wH4Nu/
 k1nf1RuhifqndZQVe6vX46z1gudRSDdvjeRpW8hns4TBdq9hOyXN3/RJAzwfjKVRJiXZlIJPsND6+
 CQ2s/TXnKKB160qK/fI3jClLI1W1bzTZT2Jag+0g8BwSsSlugdpbPzbt9qCXdPf7IIV2n5m73jIJD
 VVbXpmW5WD7kwuPL8O3sQ3E5olkdtFdxjwA9ucijT3JmJ69TRi94giHRKu41e9nmLDHD6LYB+n4Qu
 Vl7Wnb5nZmQnesj3AOSr/lPYytAHX0CfFc+oNc/wI6mu4jfFdkNImmTOp7HVCB+tUqWOkzmgOlJuv
 MYIQ8cAkcZtsiaMo22LiRTt+qnVhqhZor/WJoYy56aHfeWSbOAh+8NeIcz6oU0+6pEQX9Of+LigDm
 lnyUhm0pvRRQDJFBeT+kZntZGXafnYtw+k9h8bEYdf9wfkfxAU3ohJk9LCY6llYnpXD5qfc44pgMZ
 t6QlBVE0kGH3A9MVio4KP51z8vrdZ851mgZKy2FU08Iddc+5czQAe2B+x6rMfaVVccTKLBDEFt5Q8
 /zqW8vlgNfRNU/v3dwd2lt9mj65fPZiIZluxpVuHk=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rsO24-000Bmt-Vc; Thu, 04 Apr 2024 15:25:38 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Apr 2024 15:25:33 +0100
Message-Id: <20240404142539.711134-12-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
References: <20240404142539.711134-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 11/17] esp.c: rework esp_cdb_length() into esp_cdb_ready()
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

The esp_cdb_length() function is only used as part of a calculation to determine
whether the cmdfifo contains an entire SCSI CDB. Rework esp_cdb_length() into a
new esp_cdb_ready() function which both enables us to handle the case where
scsi_cdb_length() returns -1, plus simplify the logic for its callers.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240324191707.623175-12-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f3aa5364cf..f47abc36d6 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -425,20 +425,20 @@ static void write_response(ESPState *s)
     }
 }
 
-static int esp_cdb_length(ESPState *s)
+static bool esp_cdb_ready(ESPState *s)
 {
+    int len = fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset;
     const uint8_t *pbuf;
-    int cmdlen, len;
+    int cdblen;
 
-    cmdlen = fifo8_num_used(&s->cmdfifo);
-    if (cmdlen < s->cmdfifo_cdb_offset) {
-        return 0;
+    if (len <= 0) {
+        return false;
     }
 
-    pbuf = fifo8_peek_buf(&s->cmdfifo, cmdlen, NULL);
-    len = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
+    pbuf = fifo8_peek_buf(&s->cmdfifo, len, NULL);
+    cdblen = scsi_cdb_length((uint8_t *)&pbuf[s->cmdfifo_cdb_offset]);
 
-    return len;
+    return cdblen < 0 ? false : (len >= cdblen);
 }
 
 static void esp_dma_ti_check(ESPState *s)
@@ -806,10 +806,9 @@ static void esp_do_nodma(ESPState *s)
             trace_esp_handle_ti_cmd(cmdlen);
 
             /* CDB may be transferred in one or more TI commands */
-            if (esp_cdb_length(s) && esp_cdb_length(s) ==
-                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
-                    /* Command has been received */
-                    do_cmd(s);
+            if (esp_cdb_ready(s)) {
+                /* Command has been received */
+                do_cmd(s);
             } else {
                 /*
                  * If data was transferred from the FIFO then raise bus
@@ -832,10 +831,9 @@ static void esp_do_nodma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
 
             /* Handle when DMA transfer is terminated by non-DMA FIFO write */
-            if (esp_cdb_length(s) && esp_cdb_length(s) ==
-                fifo8_num_used(&s->cmdfifo) - s->cmdfifo_cdb_offset) {
-                    /* Command has been received */
-                    do_cmd(s);
+            if (esp_cdb_ready(s)) {
+                /* Command has been received */
+                do_cmd(s);
             }
             break;
 
-- 
2.39.2


