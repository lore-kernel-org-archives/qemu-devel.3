Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCE7C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:44:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLR-00041p-3V; Tue, 30 Jul 2024 05:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLM-0003jL-NZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLK-0000aW-EY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:32 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4281d812d3eso19863145e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332429; x=1722937229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=720J6Fnn90LCfDNzvb5BOYvjsNm2pz0pQOgxMBS+Hs0=;
 b=jjASWuXjK6MJvGeTE7ennWdmCRDst+YkyOvgKIGip+pLtW4cm1GvfYsJuZVo4qUqZx
 G4gAfPtn4BpxhSvnNRrCnCKpb1aB58d0NFAlZdQDhyj5ORp25GzmktYu9BAHahT9H1JV
 GUecfskkf34nRdrCtFV/6P0HTCKDhs9MbcY7JVFxKbbrxyun2jmP81bxCIZjtgMknupb
 fo4VLZ0VpF9ygSojVjMlZx07sdwv8qgaxGELuLJERj+Xt8df+WU7lk70SeJsmpV4H9ys
 6v5k+WD+sURzX1k16hXwNizuTE9yBILZ+qyXHtU1oNer4kzN1d0WTqtZosoUOicBj91Q
 nK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332429; x=1722937229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=720J6Fnn90LCfDNzvb5BOYvjsNm2pz0pQOgxMBS+Hs0=;
 b=BUq4QS/Fzy1G61Eulu+UZ/geZatWvn7uwu71usD1NaQN8STDZ/SBWsdUP74Of+hVPf
 zL48ivAdZaQRPyczKLJx/s6VRUgDDXJd342fPI5IHOa1YO1F72QYWYevlz+f3cdUMez0
 EqMpsOfJNjGFlLtn2NwU7qthr0xpf96lHmgtCdtnwFct0oyHOhd5HoTd3mrD2tPbl0KV
 hAPhZe38lGrn0/Q/HNlKS9EOsak2RMuDWCGB6l0OOtRdhWx9wuyORK3CUtt4ZRg3leBY
 3Q77ArLQFLhwRuOdcn1MoTyINAM9TjeUWuWrmn0QbRVrw5ghoI2wYtUf2WdesVf7Dqtx
 Jinw==
X-Gm-Message-State: AOJu0Yxmiwy6L1uMAUdKeK5BXphatzjZz3ztmSX/OcvvT71KZ+tNUUzk
 2hAvwaILr10XYT+WuQYbGtKQ8+ouVVK2xWwlXfd6VIdmdEkUnfFiuFfev9aw0fDHeNhyy5hT2zI
 E
X-Google-Smtp-Source: AGHT+IHdh7qmWnQffjQPs4VGVXveUUmmJmzvdKUq+eCiUa2DWeKPR681d/BlFu6hZNpzC4Su7Fic7g==
X-Received: by 2002:adf:f00c:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-36b5d0d0f9dmr8965034f8f.43.1722332428734; 
 Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/21] hw/misc/bcm2835_property: Reduce scope of variables in
 mbox push function
Date: Tue, 30 Jul 2024 10:40:10 +0100
Message-Id: <20240730094020.2758637-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

In bcm2835_property_mbox_push(), some variables are defined at function scope
but used only in a smaller scope of the function:
 * tag, bufsize, resplen are used only in the body of the while() loop
 * tmp is used only for RPI_FWREQ_SET_POWER_STATE (and is badly named)

Declare these variables in the scope where they're needed, so the code
is easier to read.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723131029.1159908-5-peter.maydell@linaro.org
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


