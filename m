Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35F07C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:42:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZyg9-00071N-5M; Tue, 13 Feb 2024 14:42:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg6-0006y3-Fb
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:50 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyg5-0006Pm-0S
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=m1ImFGpa7DxWE0DTTuWjbOMbJeHgbQNvbOZuqOrXhag=; b=nWFBzRYJlg3ysCW+PlmnbbmF3o
 XWw/ho76lNRnFA9jxEsG8lEqJldFUUHzDyexT1qy9HHtWSD1ynOzkLbz1Y3EO8+2QG09w8xj5g9n8
 1rlGCdgvBSMlTI4rqpODJ1R+tbboSbxP/Kianex8zH5v/4LS/0lWOnfM0O9qXAgDETmwZP9se7Zsw
 FlIGJhbrpWMr73LfdKVXDx2z5fkscZQQdPIkb8GRKfGawq5ExFLCk+ZkKkHIwsnjIE+afkilo9g8J
 8fzkoU9PkEObHEvgnDKtGxBEYEMw7O1ml+QMNZGrem1K9Ac10bcnx/516H2o/oeE2mvWK6tZmuo/m
 Bxj28qlipaViiEuRcyaImch1Z4RgLD+JBK5uFhu9G00SShmLhWHmJ4Fh8lGpvtRBMNIzKHsvf/mPy
 izbf+sM4/qzHUQVK/rqD5gM4iZHfhSXXB1l9tn1Upyja8xokaGQWDnWgEHTlvB6d/44nh8D/6t3tr
 ag95aTR/IdP0B1696drk/ffnx9uy+tp+KWNrW+1mqxWjL07pN8clWEMbA4OXUh7GjdAuH0ZAKGcOf
 uuhB/dFG9tvfjmcUbK65248zD59R7swOz4uc/vyQvYtDzis0wTnkmSUQ2rAKx2qgckcY/I1VPrrs6
 CRO4Rls4CkagZKGD8OjSyOiNIubs40rv88no7X9SU=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfF-0008m4-N5; Tue, 13 Feb 2024 19:41:57 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:53 +0000
Message-Id: <20240213194052.1162753-30-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 29/88] esp.c: fix premature end of phase logic
 esp_command_complete
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

There are two cases here: the first is when the TI command underflows, in which
case we raise INTR_BS to indicate an early change of phase, and the second is
when the TI command overflows because the host requested a transfer for more
data than is available. In the latter case force TC to zero so that the TI
completion logic executes correctly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-30-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index f20026c3dc..c6151d306e 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -887,7 +887,6 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
         if (s->ti_size != 0) {
             trace_esp_command_complete_unexpected();
         }
-        s->ti_size = 0;
     }
 
     s->async_len = 0;
@@ -897,13 +896,26 @@ void esp_command_complete(SCSIRequest *req, size_t resid)
     s->status = req->status;
 
     /*
-     * If the transfer is finished, switch to status phase. For non-DMA
-     * transfers from the target the last byte is still in the FIFO
+     * Switch to status phase. For non-DMA transfers from the target the last
+     * byte is still in the FIFO
      */
+    esp_set_phase(s, STAT_ST);
     if (s->ti_size == 0) {
-        esp_set_phase(s, STAT_ST);
+        /*
+         * Transfer complete: force TC to zero just in case a TI command was
+         * requested for more data than the command returns (Solaris 8 does
+         * this)
+         */
+        esp_set_tc(s, 0);
         esp_dma_done(s);
-        esp_lower_drq(s);
+    } else {
+        /*
+         * Transfer truncated: raise INTR_BS to indicate early change of
+         * phase
+         */
+        s->rregs[ESP_RINTR] |= INTR_BS;
+        esp_raise_irq(s);
+        s->ti_size = 0;
     }
 
     if (s->current_req) {
-- 
2.39.2


