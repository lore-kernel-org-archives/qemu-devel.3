Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3722C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:48:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygx-0001P4-Jz; Tue, 13 Feb 2024 14:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygp-0000zD-3j
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:35 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyga-0006Us-OK
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TJHBiJkh3bmcyNfBAoMhEkxZc4TXoXWWwMTukArRF8A=; b=tgSnx751buvdE4b+9R3TczMsvO
 rjgRhP/QiJwWDTarFhOfmeOoQ3Mhad2fpzhpJv01MfdExUM+ID4y5fDxY3dsnUalgyXISHC1Eup9V
 MoYmCicBbu1cZJGgTVbE/aKH0JBDryFsrO4/2q44YG4STEtf5T1MndABFpEJcpudeUwkWHFkZFinJ
 pjHCyFFjmYdcoDvdEJY3hft1WNh1beYssI3nAMRbTP6I2+HvVMK7oIfdvqULURmxDclO1LdaB61rs
 4L6P2pvsgc6q8IT6rlI7KYeP/qyGfoHDtK1biR+8MExLEwCHpUS+/SGESgowjwaYdoEGhz45etTMj
 rlfHyrMVN4WPEtnpiEUnRPuIW9zDshQ1+sZoZpd7ysIDHqeG5I66EiZDuwPJ9KxYza0Qjx9nMDQHw
 DdaTo/i6dJwvtyiVSxX5wh2l24fRYecqq+v+qIkjp24PIJRaJV92yT3QxGCuc0BOu7ssN0ozz4o10
 bqHKU5yVdQYsbvQPthOkM++X/616Tq9F7cgHC9zNy4+7T5T3TYlb147D4QoG4qUoVEqLzvF84jelE
 ZcpMXh1+v3HTiCU/HP7gYNd2/dV1/Kkl1xs/o+YSob8wgtL9koK3FINQWQTHYkZ8XKIRQGX2OgNXL
 egRtlvgEwhdsNKUMazQeEgTUNIulUI/yidxwOD0AU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfi-0008m4-2c; Tue, 13 Feb 2024 19:42:30 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:01 +0000
Message-Id: <20240213194052.1162753-38-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 37/88] esp.c: introduce esp_get_phase() function
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

Make use of this new function in all places where the SCSI phase bits are
manually masked from the ESP_RSTAT register.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240112125420.514425-38-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 16cb6c72fd..de8d98082a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -196,6 +196,11 @@ static void esp_set_phase(ESPState *s, uint8_t phase)
     trace_esp_set_phase(esp_phase_names[phase]);
 }
 
+static uint8_t esp_get_phase(ESPState *s)
+{
+    return s->rregs[ESP_RSTAT] & 7;
+}
+
 static uint8_t esp_pdma_read(ESPState *s)
 {
     uint8_t val;
@@ -537,7 +542,7 @@ static void esp_dma_ti_check(ESPState *s)
 
 static void do_dma_pdma_cb(ESPState *s)
 {
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int len;
     uint32_t n;
@@ -554,7 +559,7 @@ static void do_dma_pdma_cb(ESPState *s)
         }
 
         s->ti_size = 0;
-        if ((s->rregs[ESP_RSTAT] & 7) == STAT_CD) {
+        if (esp_get_phase(s) == STAT_CD) {
             /* No command received */
             if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
                 return;
@@ -621,7 +626,7 @@ static void do_dma_pdma_cb(ESPState *s)
 static void esp_do_dma(ESPState *s)
 {
     uint32_t len, cmdlen;
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_CMDFIFO_SZ];
     int n;
 
@@ -654,7 +659,7 @@ static void esp_do_dma(ESPState *s)
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if ((s->rregs[ESP_RSTAT] & 7) == STAT_CD) {
+        if (esp_get_phase(s) == STAT_CD) {
             /* No command received */
             if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
                 return;
@@ -762,7 +767,7 @@ static void esp_do_dma(ESPState *s)
 
 static void esp_do_nodma(ESPState *s)
 {
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint8_t buf[ESP_FIFO_SZ];
     uint32_t cmdlen;
     int len, n;
@@ -776,7 +781,7 @@ static void esp_do_nodma(ESPState *s)
         cmdlen = fifo8_num_used(&s->cmdfifo);
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-        if ((s->rregs[ESP_RSTAT] & 7) == STAT_CD) {
+        if (esp_get_phase(s) == STAT_CD) {
             /* No command received */
             if (s->cmdfifo_cdb_offset == fifo8_num_used(&s->cmdfifo)) {
                 return;
@@ -856,7 +861,7 @@ static void esp_pdma_cb(ESPState *s)
 void esp_command_complete(SCSIRequest *req, size_t resid)
 {
     ESPState *s = req->hba_private;
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
 
     trace_esp_command_complete();
 
@@ -909,7 +914,7 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
 void esp_transfer_data(SCSIRequest *req, uint32_t len)
 {
     ESPState *s = req->hba_private;
-    int to_device = ((s->rregs[ESP_RSTAT] & 7) == STAT_DO);
+    int to_device = (esp_get_phase(s) == STAT_DO);
     uint32_t dmalen = esp_get_tc(s);
 
     assert(!s->do_cmd);
@@ -1103,7 +1108,7 @@ uint64_t esp_reg_read(ESPState *s, uint32_t saddr)
             qemu_log_mask(LOG_UNIMP, "esp: PIO data read not implemented\n");
             s->rregs[ESP_FIFO] = 0;
         } else {
-            if ((s->rregs[ESP_RSTAT] & 0x7) == STAT_DI) {
+            if (esp_get_phase(s) == STAT_DI) {
                 if (s->ti_size) {
                     esp_do_nodma(s);
                 } else {
-- 
2.39.2


