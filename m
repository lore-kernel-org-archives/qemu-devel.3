Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7247C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 13:12:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWFHv-0006H1-B2; Tue, 23 Jul 2024 09:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWFHt-000680-7T
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:10:41 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWFHp-0000JM-9F
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:10:40 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3685afd0c56so1241480f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 06:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721740235; x=1722345035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9KvsvCHEGhZpad6dixP1T8PrskYUM3EAVWT0geUExQ=;
 b=ug0xCqAt8eSQNeZWAGoHnUNtpN68RNML7fAaZlCxHHxT7q+6n0Jhe+VsDV6IaYVgFf
 dHyNhy44zO5XMzYPYA7S9lWZTXFXk5OXxCcv+74aikdgknQfJ5FpNP/pWHb5qJQAwtri
 +soepWP7W5n3YS9gnM5vlB6xlCUP9MTPtTa4magj6kSzz1DTqEspe6Toy/vunxlGl1R5
 qn0rlXWanCzFLdRgQkVPMevYl5QClWItq/8FcEQAJTSkRRyycsQfA4De7QApn3+VJ1NP
 tJqfVAs5WqaIWZYFVFSyhs6cMJzh5SsF7tE0L73ZdTXxGBghiQ8rii9/x5ST9DtGc80q
 cCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740235; x=1722345035;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+9KvsvCHEGhZpad6dixP1T8PrskYUM3EAVWT0geUExQ=;
 b=ORrZPxE/rmXFVkxYBhW5yz8M73dC60ZJfLbot/duI10NfZKW8BEB9FXgex241wxK29
 Taq6//bjzFd8r33gQhBm4oRz/OVvCoyx57Lm0gdtdine9WL+/8OwwFpbPGqiLecoOPbp
 fRi5cYDkqzzeSGwu008zey8AWwXj6e8UcooqS+Zldtjp75xg5Yx05v/RUCp2qTJbe8dC
 yX86LWeriZ6E2K+lq2nSOjDiooteZb85YWCAw19MfMhtETa4/CzBwaQW76B41RNouwuG
 Rwwj1CqGPr2PzD/Zd0tCudDTTIenvhf+ksassVO6EF0bCM1g5ZUGNdv2WRh/NHdlbUoH
 Fr4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8XfzRoFDaTxyo5N7LzZDYGjEkKpzfZWswwQoUjQ5BSeFHqU8mRJPqpx4smb0Ul+NfjX3/JHP5K6ij/7is2H7PXNTvypc=
X-Gm-Message-State: AOJu0YwEd0DEeFWwsBGROR9wQya9PjUwH9/RNtBfyl0hB3PvhYGBaiV+
 /uQs41nmPTI6xc3SoOgJYqIZUypoX4i+N/445y0diQvohButZeGQC7i+amxCInA=
X-Google-Smtp-Source: AGHT+IHnneHMJzfHbnhqLtrMriByvPyY9qDHzF0wXdcCnfRUWJOL9+T2+LYVdsVAbfUxlF/nGnOi4w==
X-Received: by 2002:a05:6000:1b08:b0:367:4e1a:240e with SMTP id
 ffacd0b85a97d-369bb2a1bc4mr5642881f8f.50.1721740234887; 
 Tue, 23 Jul 2024 06:10:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm11560157f8f.7.2024.07.23.06.10.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:10:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 4/4] hw/misc/bcm2835_property: Reduce scope of variables in
 mbox push function
Date: Tue, 23 Jul 2024 14:10:29 +0100
Message-Id: <20240723131029.1159908-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723131029.1159908-1-peter.maydell@linaro.org>
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

In bcm2835_property_mbox_push(), some variables are defined at function scope
but used only in a smaller scope of the function:
 * tag, bufsize, resplen are used only in the body of the while() loop
 * tmp is used only for RPI_FWREQ_SET_POWER_STATE (and is badly named)

Declare these variables in the scope where they're needed, so the code
is easier to read.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_property.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 443d42a1824..8ca3128f29b 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -25,11 +25,7 @@
 
 static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
 {
-    uint32_t tag;
-    uint32_t bufsize;
     uint32_t tot_len;
-    size_t resplen;
-    uint32_t tmp;
 
     /*
      * Copy the current state of the framebuffer config; we will update
@@ -48,10 +44,10 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     /* @(addr + 4) : Buffer response code */
     value = s->addr + 8;
     while (value + 8 <= s->addr + tot_len) {
-        tag = ldl_le_phys(&s->dma_as, value);
-        bufsize = ldl_le_phys(&s->dma_as, value + 4);
+        uint32_t tag = ldl_le_phys(&s->dma_as, value);
+        uint32_t bufsize = ldl_le_phys(&s->dma_as, value + 4);
         /* @(value + 8) : Request/response indicator */
-        resplen = 0;
+        size_t resplen = 0;
         switch (tag) {
         case RPI_FWREQ_PROPERTY_END:
             break;
@@ -95,13 +91,16 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 8;
             break;
         case RPI_FWREQ_SET_POWER_STATE:
-            /* Assume that whatever device they asked for exists,
-             * and we'll just claim we set it to the desired state
+        {
+            /*
+             * Assume that whatever device they asked for exists,
+             * and we'll just claim we set it to the desired state.
              */
-            tmp = ldl_le_phys(&s->dma_as, value + 16);
-            stl_le_phys(&s->dma_as, value + 16, (tmp & 1));
+            uint32_t state = ldl_le_phys(&s->dma_as, value + 16);
+            stl_le_phys(&s->dma_as, value + 16, (state & 1));
             resplen = 8;
             break;
+        }
 
         /* Clocks */
 
-- 
2.34.1


