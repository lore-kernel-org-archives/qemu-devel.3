Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87C4C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:12:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyzt-0003Y2-N0; Tue, 13 Feb 2024 15:03:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyy8-0001tJ-Gk
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:34 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyy5-0001su-UR
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 15:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eJ1paP8kPRvhyZEgQSLmYnxE9wIiYP8JdAt5y+q0tAc=; b=kqaz/UC/I7sJibyd6dqU9JPSbc
 QZO2glXTsiw8OwbELYWRBLZVGZw2TzQO6byCNBzxJzW90BRl06PmldY0gk8UoW9yLqy3HO6QdDJLX
 KG1UhBLIn1K9BHaRY05/6b1G8JKqdyhYBSHh7TYgFQUbHbgYsD/pTbQXVEE/t9KL3zQoCkYMJYdi3
 iDHfTRj2srhJ/Yp7iR2tTr7osoHn/IjW+xNP5tX3jYZktLQfyWyzYwZ/4ep+7eZIBG+baH0nfdfbW
 sEQTJoBre2yGEZ0oQXQqE+rMAF4jswNYs0s8f0nqS66VLICoOaEDCzGnmjnGr0cJlyKtHv5cojYAc
 EeSBMJRPpBUSdY586awvIZ2rWO/AxUxLFXvZCjv/8ZJRLMu4hWb2iPPEdHOyeZQa17g/gvvhQHPOk
 FPKpBH6L7g/nJYrBOaQ5f5XJCPUdHSMd2BG/dXf0ZeYtiXQx+SH/qmJ/S+LDlG3gYRanopuCd8y4M
 oqn+dK8p1bfcUOKvNUO6J9oHlxPTil1evE5HwN3Yqw4yHQEXcwya3hl6/BfixtfSZx03H9oVJ1/Qq
 KNwElBKGLgvjtMvdUA4CNAf1BJhTGQlLghj0I+bUHsA/U3dTxGk3MjnyJbcJfXzUD2z9EbYHyM+TQ
 vsTEzjgPAQW4foF6Zbk70Uy6RTfol7AbMDx2xfv1U=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyh9-0008m4-PK; Tue, 13 Feb 2024 19:43:59 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:40:31 +0000
Message-Id: <20240213194052.1162753-68-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 67/88] esp.c: replace get_cmd() with esp_do_nodma()
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

Now that the esp_do_nodma() state machine correctly handles incoming FIFO
data, all remaining users of get_cmd() can be replaced with esp_do_nodma()
and the get_cmd() function removed completely.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-68-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 54 ++++-----------------------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5bb8cc4ea7..277eb8647b 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -257,40 +257,6 @@ static int esp_select(ESPState *s)
 static void esp_do_dma(ESPState *s);
 static void esp_do_nodma(ESPState *s);
 
-static uint32_t get_cmd(ESPState *s, uint32_t maxlen)
-{
-    uint8_t buf[ESP_CMDFIFO_SZ];
-    uint32_t dmalen, n;
-    int target;
-
-    target = s->wregs[ESP_WBUSID] & BUSID_DID;
-    if (s->dma) {
-        dmalen = MIN(esp_get_tc(s), maxlen);
-        if (dmalen == 0) {
-            return 0;
-        }
-        if (s->dma_memory_read) {
-            s->dma_memory_read(s->dma_opaque, buf, dmalen);
-            dmalen = MIN(fifo8_num_free(&s->cmdfifo), dmalen);
-            fifo8_push_all(&s->cmdfifo, buf, dmalen);
-            esp_set_tc(s, esp_get_tc(s) - dmalen);
-        } else {
-            return 0;
-        }
-    } else {
-        dmalen = MIN(fifo8_num_used(&s->fifo), maxlen);
-        if (dmalen == 0) {
-            return 0;
-        }
-        n = esp_fifo_pop_buf(&s->fifo, buf, dmalen);
-        n = MIN(fifo8_num_free(&s->cmdfifo), n);
-        fifo8_push_all(&s->cmdfifo, buf, n);
-    }
-    trace_esp_get_cmd(dmalen, target);
-
-    return dmalen;
-}
-
 static void do_command_phase(ESPState *s)
 {
     uint32_t cmdlen;
@@ -376,10 +342,7 @@ static void handle_satn(ESPState *s)
     if (s->dma) {
         esp_do_dma(s);
     } else {
-        if (get_cmd(s, ESP_CMDFIFO_SZ)) {
-            s->cmdfifo_cdb_offset = 1;
-            do_cmd(s);
-        }
+        esp_do_nodma(s);
     }
 }
 
@@ -401,9 +364,7 @@ static void handle_s_without_atn(ESPState *s)
     if (s->dma) {
         esp_do_dma(s);
     } else {
-        if (get_cmd(s, ESP_CMDFIFO_SZ)) {
-            do_cmd(s);
-        }
+        esp_do_nodma(s);
     }
 }
 
@@ -425,14 +386,7 @@ static void handle_satn_stop(ESPState *s)
     if (s->dma) {
         esp_do_dma(s);
     } else {
-        if (get_cmd(s, 1)) {
-            trace_esp_handle_satn_stop(fifo8_num_used(&s->cmdfifo));
-
-            /* Raise command completion interrupt */
-            s->rregs[ESP_RINTR] |= INTR_BS | INTR_FC;
-            s->rregs[ESP_RSEQ] = SEQ_MO;
-            esp_raise_irq(s);
-        }
+        esp_do_nodma(s);
     }
 }
 
@@ -770,7 +724,7 @@ static void esp_do_nodma(ESPState *s)
             break;
 
         case CMD_SELATNS:
-            if (fifo8_num_used(&s->cmdfifo) == 1) {
+            if (fifo8_num_used(&s->cmdfifo) >= 1) {
                 /* First byte received, stop in message out phase */
                 s->cmdfifo_cdb_offset = 1;
 
-- 
2.39.2


