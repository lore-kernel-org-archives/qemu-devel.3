Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66769C48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:49:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygR-0008BC-6C; Tue, 13 Feb 2024 14:43:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygO-0007y7-Uh
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:08 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygN-0006T7-FO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cwET+lM8NWpH3LaH5ZhywFZDErG/NIsZyk1qq6PTdLM=; b=Ufr8RSccRMJMgycphDnEnF9Us2
 IeIPddI9AhHABPSEO42rkXEZ1xOOX5YZSTrbGDxYiqADSmnkARMXeML4uhHMAWdUb7Mo3cH4/+VCa
 f95v5y5gaPqTyq0mVNVVD1BuYyYj40Hxp2egAEwcu3bBLiX+2VD8nQoWT0hPepu5gYsxJ2ivx2rVh
 vycZiEnOV0UvX1fTD3WSxNiEWOknxn4jbS9iY3FLAjc/PpF0W+00ZMna6iBhLBX1N4vcaL/ViQrK3
 9RiDNQLWim34YhtaPWVsi3zX56jI5zQ1TAggFTVczGdE5IWKnS3M3ldxlXnPaLgk1xhqQoia3MFOJ
 XH5G6L0zNGzK73MOiiAWQVA64Mv/MJzc5QuhwIviorXKh/sP0916B2v9fjW+pCiXZLKAEyQF2A20x
 cHXQQiyeGRw6bnXdrJ7qFVtRWHEx8XKWgP66QvRuSAiqvPTBNlHlyEOadKJfZzgPpmouKtXTI6e80
 S23uPwn/ghgQfy0ShJlttBNv6n+jWFccNQ5VYlCL6cYUqO4DqX7b7disIShPYqELNVZ+tL9+O99fN
 xfscGgs7xINGm9s6Cz3lRtoyGG76fxo9Q48xtl8pePC07IPCG//piZJdNvMyINkm6xl8fw5TmNoMl
 7FHwRXHyQ07r1YkrwkOEcsduyioOrQ3OmlajNGO6Y=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfR-0008m4-Pp; Tue, 13 Feb 2024 19:42:13 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:57 +0000
Message-Id: <20240213194052.1162753-34-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 33/88] esp.c: copy logic for do_cmd transfers from
 do_dma_pdma_cb() to esp_do_dma()
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

This is so that PDMA transfers can be performend by esp_do_dma() as well as
do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-34-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 65b4baab83..14284ef54a 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -656,9 +656,18 @@ static void esp_do_dma(ESPState *s)
             fifo8_push_all(&s->cmdfifo, buf, len);
             esp_set_tc(s, esp_get_tc(s) - len);
         } else {
+            n = esp_fifo_pop_buf(&s->fifo, buf, fifo8_num_used(&s->fifo));
+            n = MIN(fifo8_num_free(&s->cmdfifo), n);
+            fifo8_push_all(&s->cmdfifo, buf, n);
+            esp_set_tc(s, esp_get_tc(s) - n);
+
             esp_set_pdma_cb(s, DO_DMA_PDMA_CB);
             esp_raise_drq(s);
-            return;
+
+            /* Ensure we have received complete command after SATN and stop */
+            if (esp_get_tc(s) || fifo8_is_empty(&s->cmdfifo)) {
+                return;
+            }
         }
         trace_esp_handle_ti_cmd(cmdlen);
         s->ti_size = 0;
-- 
2.39.2


