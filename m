Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D232CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScfO-0006uC-Vv; Thu, 28 May 2026 11:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScfN-0006tM-Ec
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:29:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wScfL-0004T4-3N
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:29:01 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso54319595e9.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 08:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779982137; x=1780586937; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ni1ZZ38evYDjUc2aiSCs5aWGdwGPh/14vFb7jqtkHNo=;
 b=AnDLCzBQDWGcnV/0UUTEQppl19bsjhvE4bla9bhLbYFSJwVOp3K/v6gblAmmz1cmHh
 /6TE+3sLSN7UtmjEsXEmSYpFAVY0osEBxtFqtXHruVDqtMQfTJkLk5XdE3a6YZ4Ec7Hx
 RnsSfh/4aaQ2DeplWl2jRnGCblLxg0s0JqvPqkVMVV8g+InGYOo9feWiUvLMztFjFAn/
 D7XlsyuJS0R3pzKaau/iM9gt3uGN+Dh6Y6/cm6IxoJI3g+RX6q34Gg3YoF2XeEMoQ5dN
 zEcOk6cO7HrKaBPx3k71bRq31Bjei64j5Y1ZQ68C8XbtnzW+ZEXuQ7GXhb+HrZ0b9VCW
 GQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779982137; x=1780586937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ni1ZZ38evYDjUc2aiSCs5aWGdwGPh/14vFb7jqtkHNo=;
 b=qeXtn3aoUjxB60agOvNMMUcyoDOV18aqorISigWQGTGMlDes/c0OErQnwSooHef8N6
 5YLv1/D9TzU9Z7T4uX81IOT9pdfP+crHqt0OIXaf61xZYhPuYTgqxooXFnCRGQnL7rr3
 hCVXnliDJnHgj5bd7/Fl911ZK5WWiqsaENIKBxSM7E7zEUeMdMSqnvieRW7ewIASQvid
 xa9WKlZYf6glmRuBliRuFMlKOWA2Ca1cNACWRvRhC/vZ0mqUl0wbXXTiR6OCEQ9TFkL/
 EjP7QJ4chN6u3GISDBcIUZqEHnVfSPIEvEQMJWLSVwH6+KyG106OcIGYBgxFJgIGmc97
 apZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bItQl2zoTOPkdTF6NN04Yvm6ABdZ1m7eeZuFNLDTPggDeVMtMdi6XJxv7edSxEUI3ot4+6pZdD4ur@nongnu.org
X-Gm-Message-State: AOJu0YzDaatca3Ynivq9T8e2S1rJT24gTo3cskVcNvrO2MEprT4iGT20
 YkhJrSUICTChs/0iy7q0GEpT03NbDfclU3QpuTZANyPBVFKoYw7T2SbVVAWik4cqtfg=
X-Gm-Gg: Acq92OF4svQ0VGFeqllOBtLhoYIbPsxjY9lJVLbCjMdbv5zy6BY2sSNflLVQ9amAAJf
 atvcEzqKeGFal5vO52Pvzvp4V2HmVsF7KLpF9OOn4kc0YxgGHZXib2kxQYt7p/T9H+NIfbaNS11
 3rG7kMLH9XayrifOP7Ab8fTae29fmVk1FM8v37H/nhLYcGRmC6Wbt5dN8XY7d8VtgvnyXecFBrC
 Nu0BdGJQqKJAVMmsLt1BSXUWHr8WofmfIaKB0c1HveTuMJKoyFjVK1WwJ73rZIQxdNeD9gpCriY
 X7FtlpbIzfhSuGKiYnGp8MVc66PUPT2LEn0E0JW7wvUSZQEJ9LJioJCXL/I8UM+PRZ+5DNF6CqX
 g93NOMpZ7DUoT0LNRqHK47nD2oWc+p/faTSy0dIKaXWjsy/ByI/F6QSWYcepvDUh8APh5d/4lCq
 CvRNVOUscJyjIEu3cLd7pTxB44/orsn9Zlqi8EpS5pm0dShgTQr63gSAX/RUyumwDoH78gSPhBW
 Z/eFeqyZJceWO+wj2CMeYzs5iwzfPSWC58psU2hEw==
X-Received: by 2002:a05:600c:8210:b0:490:4663:691b with SMTP id
 5b1f17b1804b1-490466369f4mr452921045e9.7.1779982137526; 
 Thu, 28 May 2026 08:28:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4908b7a70b9sm19116605e9.12.2026.05.28.08.28.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:28:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/dma/omap_dma: Fix coding style in
 omap_dma_transfer_setup()
Date: Thu, 28 May 2026 16:28:51 +0100
Message-ID: <20260528152852.3349928-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528152852.3349928-1-peter.maydell@linaro.org>
References: <20260528152852.3349928-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We're about to fix indent in a section of the
omap_dma_transfer_setup() function, which will make checkpatch
complain.  Since we're touching the code anyway, fix the uses of if()
with no braces and wrongly formatted multiline comments.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/omap_dma.c | 51 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 18 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index a93d9ad196..b8bbb707c4 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -471,49 +471,59 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
 
 
         /* If the channel is element synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_element_sync])
+        if (min_elems == elements[omap_dma_intr_element_sync]) {
             omap_dma_deactivate_channel(s, ch);
+        }
 
         /* If it is the last frame, set the LAST_FRAME interrupt */
-        if (min_elems == elements[omap_dma_intr_last_frame])
+        if (min_elems == elements[omap_dma_intr_last_frame]) {
             ch->status |= LAST_FRAME_INTR;
+        }
 
-        /* If exactly half of the frame was reached, set the HALF_FRAME
-           interrupt */
-        if (min_elems == elements[omap_dma_intr_half_frame])
+        /*
+         * If exactly half of the frame was reached, set the HALF_FRAME
+         * interrupt
+         */
+        if (min_elems == elements[omap_dma_intr_half_frame]) {
             ch->status |= HALF_FRAME_INTR;
+        }
 
         /* If a full packet has been transferred, set the END_PKT interrupt */
-        if (min_elems == elements[omap_dma_intr_packet])
+        if (min_elems == elements[omap_dma_intr_packet]) {
             ch->status |= END_PKT_INTR;
+        }
 
         /* If the channel is packet-synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_packet_sync])
+        if (min_elems == elements[omap_dma_intr_packet_sync]) {
             omap_dma_deactivate_channel(s, ch);
+        }
 
         /* If the channel is frame synchronized, deactivate it */
-        if (min_elems == elements[omap_dma_intr_frame_sync])
+        if (min_elems == elements[omap_dma_intr_frame_sync]) {
             omap_dma_deactivate_channel(s, ch);
+        }
 
         /* Set the END_FRAME interrupt */
-        if (min_elems == elements[omap_dma_intr_frame])
+        if (min_elems == elements[omap_dma_intr_frame]) {
             ch->status |= END_FRAME_INTR;
+        }
 
         if (min_elems == elements[omap_dma_intr_block]) {
             /* End of Block */
             /* Disable the channel */
 
-            if (!ch->auto_init)
+            if (!ch->auto_init) {
                 omap_dma_disable_channel(s, ch);
-            else if (ch->repeat || ch->end_prog)
+            } else if (ch->repeat || ch->end_prog) {
                 omap_dma_channel_load(ch);
-            else {
+            } else {
                 ch->waiting_end_prog = 1;
                 omap_dma_deactivate_channel(s, ch);
             }
 
-            if (ch->interrupts & END_BLOCK_INTR)
+            if (ch->interrupts & END_BLOCK_INTR) {
                 ch->status |= END_BLOCK_INTR;
+            }
         }
 
         /* Update packet number */
@@ -522,8 +532,10 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
             a->pck_element %= a->pck_elements;
         }
 
-        /* TODO: check if we really need to update anything here or perhaps we
-         * can skip part of this.  */
+        /*
+         * TODO: check if we really need to update anything here or perhaps we
+         * can skip part of this.
+         */
         if (dma->update) {
             a->element += min_elems;
 
@@ -534,11 +546,14 @@ static void omap_dma_transfer_setup(struct soc_dma_ch_s *dma)
             a->dest += min_elems * a->elem_delta[1] + frames * a->frame_delta[1];
 
             /* If the channel is async, update cpc */
-            if (!ch->sync && frames)
+            if (!ch->sync && frames) {
                 ch->cpc = a->dest & 0xffff;
+            }
 
-            /* TODO: if the destination port is IMIF or EMIFF, set the dirty
-             * bits on it.  */
+            /*
+             * TODO: if the destination port is IMIF or EMIFF, set the dirty
+             * bits on it.
+             */
         }
 
     omap_dma_interrupts_update(s);
-- 
2.43.0


