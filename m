Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ABBC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 13:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWFHt-0006Ai-Ss; Tue, 23 Jul 2024 09:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWFHr-00062I-Up
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:10:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sWFHn-0000I1-8p
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 09:10:39 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-367940c57ddso2873350f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 06:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721740232; x=1722345032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W5/2nCZDxS1NroX7MRC4z7mOFdk6Q7iI8dAfdB9mODo=;
 b=P/WUR4qm+m0EkC+N6rdpGohoCRsrOlnsKZKNYm0rudJ7NemCMtVEnnvcvSEyzHLqYt
 nv4slL99TDft0Qf2bexkuDepajoB4kFIc8wbqjDZVv88+lMVke43RXxD2BtHQoeNPgXb
 Ph7bYBz79QYwddQ1S9jtDnKhqa1AfBHFnumUX976Ik772u8iwEMhj8lvnjyy66FCntEq
 ETNjGCWd6ef4R2S3cr/LehcJlgBFbvUbgtglOQqjgXsjvdTP6TJNXK9O2WuTji+vNipz
 ge5aYPyBdc9e+R4/qJZ8zbjLdabsLUUNKoTudF4jFOjhhske8KQxJ7guuTw6oTmrAebR
 0t+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721740232; x=1722345032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5/2nCZDxS1NroX7MRC4z7mOFdk6Q7iI8dAfdB9mODo=;
 b=A5Z+jNBOpBigLnfu5V28YWkeuAEXYNh5f0HvAQfzE33zJ7ktaHv2x8sROSt7woRGyH
 rDHswr8mb8IgmNdon08LGJA2VRIRKmmQlCAWVgMDKg6NRXQarXIgNZvhs0uxwiPq8eyh
 smVLtpZmpVKHFoAHFBNFE7nN1U+69781ZJnQHw0THZwApQIwyN7fp0gOFWOaIVlwB+yV
 ruEzJkHQcRIPafX4sFmV3oAzmnzAJF7aRJcE4cIxYMB2uAq0/zSt1Kw8HBMc59V65IEl
 a4M9iHUDh4pFcqdiFkWHfioyc3HM0rVWJ4uh3ww3vPWlSxMU6bDQ3rWWCOwDTFzsGWRf
 E3tw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrEicnbdq2wYQ9g/PdALZq9IFCx19inQs76sCYX0TJPvXRsY+aEyveBHQmZejOPjrIN0KWSFFKe1MMJDZd1T9Y/kvVyE0=
X-Gm-Message-State: AOJu0YzE9vvJKZ1f4M17u4P9nclxo4Smpl8oSWK0OWO+kiuGjyKC2N8F
 1gTraKtDCWeEQub59wKS7KkO9WuZGR2FLe0CWHRd0KdO76US+dNSM7Cpu3mLNVo=
X-Google-Smtp-Source: AGHT+IHV51C2yixg0ReZM1mT0U6xpxPtF15tJcc6kgrv77EMF3QrwhowO4fprc2RwYcNKWW5bG3Ydw==
X-Received: by 2002:a05:6000:114f:b0:368:6911:6758 with SMTP id
 ffacd0b85a97d-369bae25123mr6857565f8f.40.1721740231928; 
 Tue, 23 Jul 2024 06:10:31 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36878684773sm11560157f8f.7.2024.07.23.06.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 06:10:31 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/4] hw/misc/bcm2835_property: Fix handling of
 FRAMEBUFFER_SET_PALETTE
Date: Tue, 23 Jul 2024 14:10:26 +0100
Message-Id: <20240723131029.1159908-2-peter.maydell@linaro.org>
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

The documentation of the "Set palette" mailbox property at
https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface#set-palette
says it has the form:

    Length: 24..1032
    Value:
        u32: offset: first palette index to set (0-255)
        u32: length: number of palette entries to set (1-256)
        u32...: RGBA palette values (offset to offset+length-1)

We get this wrong in a couple of ways:
 * we aren't checking the offset and length are in range, so the guest
   can make us spin for a long time by providing a large length
 * the bounds check on our loop is wrong: we should iterate through
   'length' palette entries, not 'length - offset' entries

Fix the loop to implement the bounds checks and get the loop
condition right. In the process, make the variables local to
this switch case, rather than function-global, so it's clearer
what type they are when reading the code.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/bcm2835_property.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
index 63de3db6215..e28fdca9846 100644
--- a/hw/misc/bcm2835_property.c
+++ b/hw/misc/bcm2835_property.c
@@ -31,7 +31,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
     size_t resplen;
     uint32_t tmp;
     int n;
-    uint32_t offset, length, color;
     uint32_t start_num, number, otp_row;
 
     /*
@@ -274,19 +273,25 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
             resplen = 16;
             break;
         case RPI_FWREQ_FRAMEBUFFER_SET_PALETTE:
-            offset = ldl_le_phys(&s->dma_as, value + 12);
-            length = ldl_le_phys(&s->dma_as, value + 16);
-            n = 0;
-            while (n < length - offset) {
-                color = ldl_le_phys(&s->dma_as, value + 20 + (n << 2));
-                stl_le_phys(&s->dma_as,
-                            s->fbdev->vcram_base + ((offset + n) << 2), color);
-                n++;
+        {
+            uint32_t offset = ldl_le_phys(&s->dma_as, value + 12);
+            uint32_t length = ldl_le_phys(&s->dma_as, value + 16);
+            int resp;
+
+            if (offset > 255 || length < 1 || length > 256) {
+                resp = 1; /* invalid request */
+            } else {
+                for (uint32_t e = 0; e < length; e++) {
+                    uint32_t color = ldl_le_phys(&s->dma_as, value + 20 + (e << 2));
+                    stl_le_phys(&s->dma_as,
+                                s->fbdev->vcram_base + ((offset + e) << 2), color);
+                }
+                resp = 0;
             }
-            stl_le_phys(&s->dma_as, value + 12, 0);
+            stl_le_phys(&s->dma_as, value + 12, resp);
             resplen = 4;
             break;
-
+        }
         case RPI_FWREQ_FRAMEBUFFER_GET_NUM_DISPLAYS:
             stl_le_phys(&s->dma_as, value + 12, 1);
             resplen = 4;
-- 
2.34.1


