Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D70C4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bv-0005Qz-8j; Tue, 21 Jul 2026 04:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bt-0005QN-T5
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:05 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Br-0005hD-FV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:05 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so78317235e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623862; x=1785228662; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p2SdnMPSFNDw640OsqVyUvCx8izUmKjYNV5y9Iu1/e8=;
 b=ViJLz6cUceIDtsJQpvtkQO7iLUvj4b3I1PjeywNNd2YzQVwixwz5OMGDDz2pL3HJKJ
 g2ofNFG75I/+CVfdb45kmJm0jMuMNzP1yOuGNGbCaP2dSfHha7fiI13nvF+oIZvBhHB6
 M5Yuq4NEyNjZSHlDNtL2JX45Yn2dS+KO7Wu/ikSmIEHBhXstaZL0KsLduPjBUzHplE7+
 z+mgsksAZKytFJVW96GEuNN+8TQPrCP1WF9pmT0XiXL89U+BnhjMFwIZWWOh57yo53KP
 DMfBQ0rshy5XJ2BDbCUARBvrSZ6PS3VjOJmPcUuVP8VAifFFoIpiQPI+X5M339xKnmL8
 zZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623862; x=1785228662;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p2SdnMPSFNDw640OsqVyUvCx8izUmKjYNV5y9Iu1/e8=;
 b=CnIuSX6H0JHJ4D/VMxeF2Enzhu3MUVRQcHanu7PJ+u3pqf7MMi0z4DKRFBuKk30uD7
 h3RWhAf/s3jCk0A7K7VD915YPaOzKfLm/4IhxWaIXXg0akTDV5Ksy1MfGR8SAXQCuXIN
 tzdN37IU1B/YaX2M/PhemN3vZw/rJuNCpboMjQjcPBS117h/49UaiF605frXKb4qORts
 6O4zMABxj9YFXP/TB3jYLvzzGPepnP2uLeFumnX8NwvtTUJrqp9mcD897PKaturpSUNn
 TqbyRxoEdPAzYUC0QOk7fcbe8Qdd7j7bMQoY2FpsyazHR2bBf1WIzkq7IxxFFWMqANIz
 4jIA==
X-Gm-Message-State: AOJu0YyEeN9EvwJ5J4yTkKzz02Oi2Kg0SLx6uwrzmXTfkJAsstO2VuhY
 ZjuD6LGDtSGTGtWy0NVqiAjF2ddt+arWMveBo7+wy4Ose/TTlJWbgKC+++DDj3/EnNrs0791csH
 8NnCaxjUmIQ==
X-Gm-Gg: AfdE7cmuS6Fgt/fSwhWBKOxphIWMzdipEBpA3AnL78rNV8msh3dQ6F9IumU7pQOcOIc
 pQChlEK5joRnydokMWyGPdraCDHskv6ZuO5zhwlxUMyh1pFPElqNP4kuIRgpjGTBGS6zUngfwF1
 Fxwiw1Ga3k0/erY73815mJyYQlNhiePdUDZFGUGYpYISxzYtWy49DCVm89LReOMH5AybXAd8F+f
 k7JaxDXnI6X9fWxaXF+ORrU/qaxZgcu3REPxWXzQn20QRxH0bCSYCddHQQ7umxlefaQoWoWve6X
 ZjYz6Rf1xJAwW+EkvYSc5N8B5QVOX1rJovj833BMNFS+CJQ2SuFfHDpX4L5A9HKTP9CpbLu0JCU
 UmMsyeSUgyq+2MSkGwKa07BwMKuabhyWOTuAKpB1Q4p/R0V2CMEnW9uMD0u/kGImH41HeWOpCjp
 piVARPGNgSx0fUA/F7GwDrCp/6ROxgmG6iaVp/NXpqLRswqXMAmfVgFsjEqtDnDPj25ldeVuvwB
 CqAzLbY+Os=
X-Received: by 2002:a05:600c:4512:b0:493:bc4a:fb56 with SMTP id
 5b1f17b1804b1-4954a50e92bmr193757495e9.39.1784623861912; 
 Tue, 21 Jul 2026 01:51:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/16] hw/dma/soc_dma: Simplify soc_dma_ch_update()
Date: Tue, 21 Jul 2026 09:50:42 +0100
Message-ID: <20260721085050.421257-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now we only have "mem" and "other" as soc_dma_port_type values, we
can simplify soc_dma_ch_update(): either both src and dst are mem, in
which case we use transfer_mem2mem and set update to 1 to tell
omap_dma_transfer_setup() to update all the guest-visible
src/dest/count information to indicate a completed transfer; or else
we use the omap_dma_transfer_generic() function, and we set update to
0 to tell omap_dma_transfer_setup() that the transfer function will
be updating the src/dest/count.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260710105907.2570621-3-peter.maydell@linaro.org
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/dma/soc_dma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 8ba531feea4..ff513383886 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -121,19 +121,14 @@ void soc_dma_ch_update(struct soc_dma_ch_s *ch)
     enum soc_dma_port_type src, dst;
 
     src = soc_dma_ch_update_type(ch, 0);
-    if (src == soc_dma_port_other) {
+    dst = soc_dma_ch_update_type(ch, 1);
+    if (src == soc_dma_port_other || dst == soc_dma_port_other) {
         ch->update = 0;
         ch->transfer_fn = ch->dma->transfer_fn;
-        return;
-    }
-    dst = soc_dma_ch_update_type(ch, 1);
-
-    if (src == soc_dma_port_mem && dst == soc_dma_port_mem)
+    } else {
+        ch->update = 1;
         ch->transfer_fn = transfer_mem2mem;
-    else
-        ch->transfer_fn = ch->dma->transfer_fn;
-
-    ch->update = (dst != soc_dma_port_other);
+    }
 }
 
 static void soc_dma_ch_freq_update(struct dma_s *s)
-- 
2.43.0


