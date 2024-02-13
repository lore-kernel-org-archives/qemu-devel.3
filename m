Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB911C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyhL-0002ua-G7; Tue, 13 Feb 2024 14:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh1-0001rN-1N
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:48 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygx-0006XX-W8
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6leqQy8il9T0BgowRDTi4peOmLDXSmBsnwCsxoyV74s=; b=sSDiG3lZ5hVUUM33A79WFzrjqs
 WGsrSipasZ8e58J+k/RONQJDWW0uiEXDtF+8c2iy22x+mT+tmY2dfF/TpGj1T/Kdsd5C46PfQ9YI9
 d104tO+HwdkUzpwcEC+XSN5T4yOOAV4LEYiNU4k1pU8XX4bVIBpNQbn5IqWanWCDY60o33NNgcmci
 VCE294afmoy3d5jQj5G7bRI7tMVqdKB9+jCzSZlnZYWPOMqS6yyEpiikXgJv/7tJ6AXTomns7PYYj
 Wt4K03aayvEWBYpe0cq94g77ftKXssOuV3G086x0MicaxofCGTQE3kexYCH5K4XN7uBXdsxpmg4P4
 MFYU8XVOLzyJeQtFMumVe2epQpfd2ZmuI9QpGQWiDFB1Uifes8xzW/nYMRuCwtifSQzK9H/TVhyim
 AHWBjWCIGKKFRun+ZLX+8WeCgd9FLxvjyDSyloHCg4uXCT/xC30B9icZsXIJCTJrlU4jfAaLlS5xl
 lttqlY+No8woUcjyQEfJHC5VCO8KKTTSKDD/Gdsn4zB8Rjlxn766pKP94SC3e1stWNp5o+Ht6WZay
 BOYCqmvTSbqRAh6xD7zIJqxSZiG3YBqICOjBtK4SzoQW9sV8Z8N5sa0DyUyh1wAEh7JBizs/+quYo
 A/1hDZKgByB+HX6/vayK2bpepa1WZxp1uswD0WCmk=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg5-0008m4-AU; Tue, 13 Feb 2024 19:42:52 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:09 +0000
Message-Id: <20240213194052.1162753-46-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 45/88] esp.c: remove do_cmd from ESPState
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

Now that the accumulation of the CDB is handled by SCSI phase, there is no need
for a separate variable to control it.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-46-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index e679b1c39b..1f7dff4ca6 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -380,7 +380,6 @@ static void satn_pdma_cb(ESPState *s)
 
     if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
         s->cmdfifo_cdb_offset = 1;
-        s->do_cmd = 0;
         do_cmd(s);
     }
 }
@@ -400,13 +399,11 @@ static void handle_satn(ESPState *s)
     cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
     if (cmdlen > 0) {
         s->cmdfifo_cdb_offset = 1;
-        s->do_cmd = 0;
         do_cmd(s);
     } else if (cmdlen == 0) {
         if (s->dma) {
             esp_raise_drq(s);
         }
-        s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
         esp_set_phase(s, STAT_CD);
@@ -428,13 +425,11 @@ static void handle_s_without_atn(ESPState *s)
     cmdlen = get_cmd(s, ESP_CMDFIFO_SZ);
     if (cmdlen > 0) {
         s->cmdfifo_cdb_offset = 0;
-        s->do_cmd = 0;
         do_cmd(s);
     } else if (cmdlen == 0) {
         if (s->dma) {
             esp_raise_drq(s);
         }
-        s->do_cmd = 1;
         /* Target present, but no cmd yet - switch to command phase */
         s->rregs[ESP_RSEQ] = SEQ_CD;
         esp_set_phase(s, STAT_CD);
@@ -453,7 +448,6 @@ static void satn_stop_pdma_cb(ESPState *s)
 
     if (!esp_get_tc(s) && !fifo8_is_empty(&s->cmdfifo)) {
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-        s->do_cmd = 1;
         s->cmdfifo_cdb_offset = 1;
         esp_set_phase(s, STAT_CD);
         s->rregs[ESP_RSTAT] |= STAT_TC;
@@ -478,7 +472,6 @@ static void handle_satn_stop(ESPState *s)
     cmdlen = get_cmd(s, 1);
     if (cmdlen > 0) {
         trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-        s->do_cmd = 1;
         s->cmdfifo_cdb_offset = 1;
         esp_set_phase(s, STAT_MO);
         s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
@@ -488,7 +481,6 @@ static void handle_satn_stop(ESPState *s)
         if (s->dma) {
             esp_raise_drq(s);
         }
-        s->do_cmd = 1;
         /* Target present, switch to message out phase */
         s->rregs[ESP_RSEQ] = SEQ_MO;
         esp_set_phase(s, STAT_MO);
@@ -567,7 +559,6 @@ static void do_dma_pdma_cb(ESPState *s)
             }
 
             /* Command has been received */
-            s->do_cmd = 0;
             do_cmd(s);
         } else {
             /*
@@ -669,7 +660,6 @@ static void esp_do_dma(ESPState *s)
             }
 
             /* Command has been received */
-            s->do_cmd = 0;
             do_cmd(s);
         } else {
             /*
@@ -805,7 +795,6 @@ static void esp_do_nodma(ESPState *s)
             }
 
             /* Command has been received */
-            s->do_cmd = 0;
             do_cmd(s);
         } else {
             /*
@@ -949,7 +938,6 @@ void esp_transfer_data(SCSIRequest *req, uint32_t len)
     int to_device = (esp_get_phase(s) == STAT_DO);
     uint32_t dmalen = esp_get_tc(s);
 
-    assert(!s->do_cmd);
     trace_esp_transfer_data(dmalen, s->ti_size);
     s->async_len = len;
     s->async_buf = scsi_req_get_buf(req);
@@ -1012,7 +1000,6 @@ void esp_hard_reset(ESPState *s)
     fifo8_reset(&s->fifo);
     fifo8_reset(&s->cmdfifo);
     s->dma = 0;
-    s->do_cmd = 0;
     s->dma_cb = NULL;
 
     s->rregs[ESP_CFG1] = 7;
-- 
2.39.2


