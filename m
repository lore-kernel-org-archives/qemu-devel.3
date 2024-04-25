Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE1EC10F15
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWa-000277-Mm; Thu, 25 Apr 2024 06:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWW-00022m-KF
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:16 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWU-0007Dh-QI
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:16 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-41b6254a47cso1268565e9.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041613; x=1714646413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DC9SqOM/M/fO+YfMesu8LY8qeYkZJ02Q4hHEAc7RbS4=;
 b=Qi4WUPJJiHHmhe51nvauQDjTLKTJaOJU6OwMzEgqwR2cr6VwmkL4B7UsUzij8Hd3V+
 wHfPjpu6Eilh0ijoImC8DG5OzkHFAdRJvAiGZ7xqX7kF/Czqu4g72dwGdW5XXmiGx+Ss
 NFN7mGQzBh5DcuCw08Z9TSJCykQSl74ZDFwxblWjf1R4maCeKxupEtWtjgol/D4dMVWH
 h0mj/Ohyc1lPz/bK0TFL26iE82PdL/2EMRH0FquNM2uL7e2lEGk+W4n9FvHQHgbnLYU7
 ZS2CSfCF7/kjiGhaFisrnYNDtltgc/f3MlDXvcELcAJJff1mycV34oyp84rr+OV1xytM
 xQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041613; x=1714646413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DC9SqOM/M/fO+YfMesu8LY8qeYkZJ02Q4hHEAc7RbS4=;
 b=a3YTWjCzNXhcIuTyiTBx+rQrv0BKoMB7u/o24uM21mYPXG/HHQFJVTYHUwsnUqC/+a
 Rbh1KN9GiHLYDenm46RU+bCGTU2nt8R2fMPYqz1m01mRf9lxHi+ceXi94LFBhRLt9435
 4F86s6eSjw5Eewt/rm9vLVesv/pVhs+LDYPx/1u3kKmPUKrkmjaIjPCmHn2e/HXOlUeK
 //Ij9R2Thw6BCS8BtffnPBeRlCBJiziRR7O4pubmSyRzMzr9TekLkAWtaXS+2o5TlaBQ
 Wj3DaC8Tz4NW1NCp43BTWKZC+hIqnAxd04T+H6infIho01XcApRsedlXDlgINr3yiwvA
 Kg1g==
X-Gm-Message-State: AOJu0Yx1Jdm/thJS2/eGB9QH+6Cx1QIQ6jP/IafbhEX34cdC9v1GWbGI
 WWmHP4H/Mt3y/ZV8SkXZQbQQzjyl7TQ8NDWtmEu4wc63HUnWzFJ18gR7mV4vLvNa+Kjn1jCdzD0
 s
X-Google-Smtp-Source: AGHT+IEUVCA6B5iR4LoelrOcCZ5jaF36bsfDYTwDO3EZfOtDJfYwLX+od6GF1oUhChTuPd2/A6ng+w==
X-Received: by 2002:a05:6000:d87:b0:348:c2c7:9f13 with SMTP id
 dv7-20020a0560000d8700b00348c2c79f13mr4099675wrb.65.1714041613014; 
 Thu, 25 Apr 2024 03:40:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:12 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/37] hw/dma: avoid apparent overflow in soc_dma_set_request
Date: Thu, 25 Apr 2024 11:39:46 +0100
Message-Id: <20240425103958.3237225-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Anastasia Belova <abelova@astralinux.ru>

In soc_dma_set_request() we try to set a bit in a uint64_t, but we
do it with "1 << ch->num", which can't set any bits past 31;
any use for a channel number of 32 or more would fail due to
integer overflow.

This doesn't happen in practice for our current use of this code,
because the worst case is when we call soc_dma_init() with an
argument of 32 for the number of channels, and QEMU builds with
-fwrapv so the shift into the sign bit is well-defined. However,
it's obviously not the intended behaviour of the code.

Add casts to force the shift to be done as 64-bit arithmetic,
allowing up to 64 channels.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: afbb5194d4 ("Handle on-chip DMA controllers in one place, convert OMAP DMA to use it.")
Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
Message-id: 20240409115301.21829-1-abelova@astralinux.ru
[PMM: Edit commit message to clarify that this doesn't actually
 bite us in our current usage of this code.]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/soc_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index 3a430057f54..d5c52b804f8 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -209,9 +209,9 @@ void soc_dma_set_request(struct soc_dma_ch_s *ch, int level)
     dma->enabled_count += level - ch->enable;
 
     if (level)
-        dma->ch_enable_mask |= 1 << ch->num;
+        dma->ch_enable_mask |= (uint64_t)1 << ch->num;
     else
-        dma->ch_enable_mask &= ~(1 << ch->num);
+        dma->ch_enable_mask &= ~((uint64_t)1 << ch->num);
 
     if (level != ch->enable) {
         soc_dma_ch_freq_update(dma);
-- 
2.34.1


