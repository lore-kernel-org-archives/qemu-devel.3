Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1CDC4829F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 19:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZygW-0000BK-0E; Tue, 13 Feb 2024 14:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygV-000071-79
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:15 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZygS-0006Tj-KL
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 14:43:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mJr37RlinPGRhEfpEIyzgMlMfF6VqeJF3dO28hs/Om0=; b=fjouwqiIzI8Qm5lUkYiNVeTW8g
 53NMu/xqOjmw1xW1aPl+9D57UtPtSkyJspei5aiwZg+O5VM2J8Pvss429kVa+CjeLVrUtBUhe3WtI
 QOVJZlBrX937BOLBQJ/FejBgg62GcTFTvth5og26tnQ6jmZxl7OrTdj7hGOtVlU4JmoKOqzIzc/MH
 UzDyIVqzSBlV56Mb+gyX2VzGWcyTetQwNWgsR0AiW5Jkw8DQEElp1+6UIEcU5icEEyAkk+NRqIkFu
 sI1U5PBXBRJUAUB64h8bT1BR9d69a8uL/NXhtGQ4uHsOEuJ2Y897s2q84q4qZjOEPF/QfaxDTEVzp
 wPPm2/S1JF73yd8ig1Z2Q4k4dvmnQvEl5CiaEbyjkcK/Rt9fEAAZcIsLPZdr3LRBPr7PxMClF80VD
 0o0WgTOCipY7FmIjpojtwGRXq+6QAaGK3msdneB+5KxjanJ+vXhueo8u6dtHj6bHH4BXyRwgq8N1q
 hT38JLSw/7Jnvd5W74DciLqlk8jPyz2H1hW+e03hjNDmGwdoAmXFbLoGU3J6UgQqxxS9bOmkCMwBt
 ck37h9Oufn/nIkQP6D+y+Vf4D2xVwCX3i4PcJh+jE0fQNkIvFweixyWt4QWrHfIgakzpHfK6QRJpK
 olOT/mdGM+h4n798h9C16nEYXks6zLNjtkXt+sa88=;
Received: from [2a00:23c4:8bb2:1300:c500:f104:bc51:e670]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1rZyfZ-0008m4-Sw; Tue, 13 Feb 2024 19:42:21 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Date: Tue, 13 Feb 2024 19:39:59 +0000
Message-Id: <20240213194052.1162753-36-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
References: <20240213194052.1162753-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb2:1300:c500:f104:bc51:e670
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PULL 35/88] esp.c: move end of SCSI transfer check after TC
 adjustment in do_dma_pdma_cb()
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

Now it is possible to move the end of SCSI transfer check to after the TC
adjustment in do_dma_pdma_cb() when transferring data from the device
without triggering an assert() in the SCSI code. This brings this check in
line with all the others in esp_do_dma() and do_dma_pdma_cb().

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Helge Deller <deller@gmx.de>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240112125420.514425-36-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/scsi/esp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 9647be4cc3..df4d5f8811 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -615,15 +615,6 @@ static void do_dma_pdma_cb(ESPState *s)
 
         esp_dma_ti_check(s);
     } else {
-        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
-            /* Defer until the scsi layer has completed */
-            scsi_req_continue(s->current_req);
-            s->data_in_ready = false;
-            return;
-        }
-
-        esp_dma_ti_check(s);
-
         /* Copy device data to FIFO */
         len = MIN(s->async_len, esp_get_tc(s));
         len = MIN(len, fifo8_num_free(&s->fifo));
@@ -632,6 +623,15 @@ static void do_dma_pdma_cb(ESPState *s)
         s->async_len -= len;
         s->ti_size -= len;
         esp_set_tc(s, esp_get_tc(s) - len);
+
+        if (s->async_len == 0 && fifo8_num_used(&s->fifo) < 2) {
+            /* Defer until the scsi layer has completed */
+            scsi_req_continue(s->current_req);
+            s->data_in_ready = false;
+            return;
+        }
+
+        esp_dma_ti_check(s);
     }
 }
 
-- 
2.39.2


