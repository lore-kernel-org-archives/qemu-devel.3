Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99257C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkKRx-0007dZ-FE; Wed, 13 Mar 2024 04:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRv-0007dH-Px
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:59 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKRu-0002Ga-FG
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CxDqHS9crhtz8sbTfN1gtZ311MXUlC4KQUJRPAGct8=; b=AhrvEHppl3Krw43NcOa4CUu/7p
 DmGVKT2qW8AsZJs6wWWu36VsexymkSpaydjeiAlgkIIS3JyhF/xap783Mnm6jLL1KjCnxfPfATwgk
 rwJrMWW9PYQO+Y76ZfsAvFqPl78vHtuSP8o7GgVnnuG7s45zwZ9NLZZ6UK2Ata/seYY/Z1e8Vxbxy
 WQVo6/KM6wzoIjyhfGYdH4qNusPvrcnvwjJxYOxKd7RUuKN4PAWyIQ/C9By5HeGIAVLeL+cM2fORJ
 57vCvNFikZysgRjh+xDST7TbO5KKK+5/zwe+Jy0exDLFJ9guW0uOM5Ne2BxSZOCv6GpuIyrjdKdOq
 cst/1/mD9h+pNDma2TOwu/4/1kKwn/RyqqNIMK6q7vbGDzSWDDRvtAiq+DOAzapdrP1SmQiqbmmyi
 Oioo3ue3Ki4Bu42IxkVXFeN7bBckl1vB7lLn9PKlGJY7Erdfip8JTrq7h2Et0HMByNtx3dLjYda5W
 66KlPvH1eOKTczblOH0TyU34iZkM48DDM5NV9RLdvMAEJfacZuIcIAh6Cp/EASOWrLcBPuWD+W8La
 5+YKzIWKRDfqzHISipM5fFvX7BkZC518ga3E20YUUtq54uUcCgMt1fA3SXwNcUr+q112cLHJV4wFr
 mD+rDcqxUsRWc1XwEZ3kq7YxKmKQcyNreHWxQ+ixI=;
Received: from [2a00:23c4:8bb3:1000:1218:d855:1998:7fa8]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rkKR0-000CUN-7n; Wed, 13 Mar 2024 08:58:06 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: pbonzini@redhat.com, fam@euphon.net, laurent@vivier.eu,
 qemu-devel@nongnu.org
Date: Wed, 13 Mar 2024 08:58:00 +0000
Message-Id: <20240313085810.2655062-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
References: <20240313085810.2655062-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb3:1000:1218:d855:1998:7fa8
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 06/16] esp.c: use esp_fifo_push() instead of fifo8_push()
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

There are still a few places that use fifo8_push() instead of esp_fifo_push() in
order to push a value into the FIFO. Update those places to use esp_fifo_push()
instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 0e42ff50e7..fb2ceca36a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -858,7 +858,7 @@ static void esp_do_nodma(ESPState *s)
             return;
         }
         if (fifo8_is_empty(&s->fifo)) {
-            fifo8_push(&s->fifo, s->async_buf[0]);
+            esp_fifo_push(s, s->async_buf[0]);
             s->async_buf++;
             s->async_len--;
             s->ti_size--;
@@ -881,7 +881,7 @@ static void esp_do_nodma(ESPState *s)
     case STAT_ST:
         switch (s->rregs[ESP_CMD]) {
         case CMD_ICCS:
-            fifo8_push(&s->fifo, s->status);
+            esp_fifo_push(s, s->status);
             esp_set_phase(s, STAT_MI);
 
             /* Process any message in phase data */
@@ -893,7 +893,7 @@ static void esp_do_nodma(ESPState *s)
     case STAT_MI:
         switch (s->rregs[ESP_CMD]) {
         case CMD_ICCS:
-            fifo8_push(&s->fifo, 0);
+            esp_fifo_push(s, 0);
 
             /* Raise end of command interrupt */
             s->rregs[ESP_RINTR] |= INTR_FC;
-- 
2.39.2


