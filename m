Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEB0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLK-0003ZR-BE; Tue, 30 Jul 2024 05:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLH-0003SX-DF
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLF-0000Wv-JZ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:27 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3687fb526b9so1972703f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332423; x=1722937223; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B5RN4DpWdHMmOm58ODLLg2Ecn4bzdDrCkkEJlS4i1B8=;
 b=qxeZjrZsVJoU76K4CaH4t0OnjVm2j1b4chcBtQF5FzIjDM81FEo35UVH6st6FOVx9H
 xpBoOtkvY2fU1tdiM7XBjpC64wVu8xab2J8XL9oljSIZqnRgJ20FOzDzvD9R/t2VnG86
 WJbkYnfrs1kO+S06Khecw3eFZmWmbX40iAQglrmUZAPcEoNb1UuMMTFOMB/rhTg/8T2T
 ln5O6LJwq0CsrJjQp6t3TYaKiD8rwNKyS8ky/Ku0mgn8E9OKWWGl9XJ+FbdDPe0aSRH/
 wJftKdIFEznwPnwT31d7F0Cc4p4t+RvoTpw5GarodbEqfKLBCiBGxRW7Lvjbz1aj7YGi
 Ak1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332423; x=1722937223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5RN4DpWdHMmOm58ODLLg2Ecn4bzdDrCkkEJlS4i1B8=;
 b=C8/g2XlgzfJcgANdv5p0agsPvTn4RWDnCo7Yo3V0zEMKi8/LWDPlWXY0L0aiA9xAoL
 0iRwcSzMNV2Hzq/1XN09bwF0PiR541k7AAuXaAonVHE6peUpKlndEENCbhXRncibVvp6
 f6XEl8HYQ93aQpXUzXzhL5rM11mTrBxm3P4vUlsxihZrbxqu/KrscPahhBc9u//WxvpR
 rEKj6JXTwFikDR+olR9vwnbRP/N2uGrx9GrjAiaMZXz5QUT8RdQGCPySGF/m0wIkJj/q
 /i9kcicBAV3poIjSizvGXAHaAgwPllwVqe9AvtjT8Sv2Lze7Nisc6aGjdTFYY4JK8O6F
 8c5g==
X-Gm-Message-State: AOJu0YwSM7wRd6uWdddnqwz/K/gj1RfiU9H+grJ31QOR+PUQuUD3vHOc
 w4sK+n36TQV2SdNUp3XaO8Gw9HGUaikP75KZ1EgTOnGOb8l47CNmCnbroISmxt2E1XWC86n8SNX
 v
X-Google-Smtp-Source: AGHT+IEir56mfxnFhQi9ENEt2QckaifU7OkniU19hBlCkrVvND2JYw6JeRaGxumqRCmRHxsyrEOVZA==
X-Received: by 2002:adf:e60f:0:b0:368:3731:1614 with SMTP id
 ffacd0b85a97d-36b5cf243f2mr6704492f8f.32.1722332423335; 
 Tue, 30 Jul 2024 02:40:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/21] hw/char/bcm2835_aux: Fix assert when receive FIFO fills
 up
Date: Tue, 30 Jul 2024 10:40:00 +0100
Message-Id: <20240730094020.2758637-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Frederik van Hövell <frederik@fvhovell.nl>

When a bare-metal application on the raspi3 board reads the
AUX_MU_STAT_REG MMIO register while the device's buffer is
at full receive FIFO capacity
(i.e. `s->read_count == BCM2835_AUX_RX_FIFO_LEN`) the
assertion `assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN)`
fails.

Reported-by: Cryptjar <cryptjar@junk.studio>
Suggested-by: Cryptjar <cryptjar@junk.studio>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/459
Signed-off-by: Frederik van Hövell <frederik@fvhovell.nl>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: commit message tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/bcm2835_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 83990e20f76..fca2f27a553 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -138,7 +138,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
         if (s->read_count > 0) {
             res |= 0x1; /* data in input buffer */
-            assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
+            assert(s->read_count <= BCM2835_AUX_RX_FIFO_LEN);
             res |= ((uint32_t)s->read_count) << 16; /* rx fifo fill level */
         }
         return res;
-- 
2.34.1


