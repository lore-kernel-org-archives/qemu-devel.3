Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA1CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 10:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi8wz-0006VP-W6; Fri, 10 Jul 2026 06:59:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8ws-0006Rz-Gb
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wi8wq-0001NW-QQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 06:59:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493ec555a26so5428175e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 03:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783681151; x=1784285951; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q3wpaFTLm6nOZdl3we8uo+58Jj19P/ToBCyD+56rgIM=;
 b=tEGdPw49XGQpn4yyFflndaJN1jJX1/Nsht7F9N9m+76JsH7z8uWWLEkJUHpvz1sA9y
 B/t+BawlrksBtuHfm3n8dEdE3oUXrn8ys5ADQQW7jNiLNeYylfq1PRdDYvgoftcYuf8O
 S70RkUuZNXMVGOEiq260Zcg3TCz7TyqFHeoonSGThAbvSZQiRUIZlXNVuigOX3DBoj6b
 U+cjY1g+526qxTjG+7pUoZZqrrpiU0lG5GSr2Pb41/pO8KBReROSupQZ2H9z7XHT7rm+
 FrX5EKVeXbmReXRYHTqaVin6g6LD8/44YyJUkOZiv71KU8nmjvODSVGqDg7wXmX6KT18
 JWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783681151; x=1784285951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q3wpaFTLm6nOZdl3we8uo+58Jj19P/ToBCyD+56rgIM=;
 b=ODsqCz4/qS6JsxFL6DNnkrAiWl7bol6WNd6ol/e6W7UQR+/rRDm+W4zJ+XICv71hUV
 ZezxP4RuzuAQR+cExRQA4+3Zh1iV+7AY2c/P8MrPEekEJ4dkBvQ/i0OhMmVab1BDhIPW
 owmRPFOm4hAwVB438oQp6rAEEwuESkVtooGmsoUeQjR62O1sFwUAcnDLoRibUl3tbZae
 aDGJcaoA5kBODGjitGXsBHfPQuL+JSQWl1mlY/VygZE43nZwQRTnfmpLkc6STbJ7To2w
 t2MxLaXSC5ya0lBwX1rcG0OHMylRD1W+WclBLr4zrZGSCcmdpBom1JmZk6kD9p6ahAOq
 czCw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGTfyt1YlLW0+YCVcViAZaWGsBPEnswDCR8mfT/ZG4+ba3R+VrYV9qLxNjuPLYyzhlnDpO5HdeUpcD@nongnu.org
X-Gm-Message-State: AOJu0Yyczw6ZYc20Ey1zuwe55SXwYzkmzF5NsVv6Owo0OL+m9eWZkuAe
 zzmW9sXeD8ZuAn3xbJSIrGmxxe3zmEJk2q7ditG0a36OOLUD6UX2O+i2BwrAVNqp4qQ=
X-Gm-Gg: AfdE7cmh0YHs0D8J+aX0JUrHfYsXbR5KTKi9AyV58EWGRERakKPBF/UAmDLyYfjgiBB
 CPGy6xdd/8VXV2YLdUYqLdpyBHTYY8ldFMxM9Z0K9f62wqF+8A97Z2Ilw63W8SHn4e3scyNCdEs
 ECFTbgv9flDPZN03m1/XAWIxBp7G6IlzDzu1NZUEjmfRJFm9Sdw19PZct++EQMZ5k3MrhB1GcuR
 GU6UqLgiKsr1nuVeVkBE9gg1pEcyTYGtopLUk+KCqLITyHQ8aXqkgf2mLoCatBE5n2Ddv6290yU
 xBagDOhXVerKOjK7RyXwIGUTWyIB96bOufr270jBYArfA3VyBwTxa1UbodyfBrU9Z3RFVrlNnTQ
 21Dg2xr6xrxdErwQ7AJW/K1zC3jRbS8ZGRuYjxziHfjrzj2x7xT4R73YKae4z6+le/Vv42y07Bo
 c1hasbr4cjTKQ8LqPrgIW5121Ic1MguMiE/lSCN1Urb7uUCktwG8suUXP5qVPp50qRDSTvLW2c5
 UXROLlvLeRtqC8uMa92AQ==
X-Received: by 2002:a05:600c:3e0c:b0:493:c548:87fb with SMTP id
 5b1f17b1804b1-493f536ceb3mr17085525e9.36.1783681150936; 
 Fri, 10 Jul 2026 03:59:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm51946175e9.1.2026.07.10.03.59.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 03:59:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
Subject: [PATCH 2/9] hw/dma/soc_dma: Simplify soc_dma_ch_update()
Date: Fri, 10 Jul 2026 11:59:00 +0100
Message-ID: <20260710105907.2570621-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710105907.2570621-1-peter.maydell@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Now we only have "mem" and "other" as soc_dma_port_type values, we
can simplify soc_dma_ch_update(): either both src and dst are mem, in
which case we use transfer_mem2mem and set update to 1 to tell
omap_dma_transfer_setup() to update all the guest-visible
src/dest/count information to indicate a completed transfer; or else
we use the omap_dma_transfer_generic() function, and we set update to
0 to tell omap_dma_transfer_setup() that the transfer function will
be updating the src/dest/count.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/soc_dma.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 8ba531feea..ff51338388 100644
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


