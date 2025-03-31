Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2695AC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL97-0003gT-TL; Mon, 31 Mar 2025 15:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8f-0002Wt-Tj
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:51 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8d-0003R7-Tj
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-399749152b4so2011220f8f.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450578; x=1744055378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7DpG1j0l2crn6m64hQcn/HA4bp5z0J1QxJNTGXkaR0=;
 b=zlZWvxTqVIlWvaIgPaECkImSOTlhb/z02Me7p0wW25UgIscov5n7QgmTJw1XYzQEIZ
 6baCP2rajjmS8X/9N/mwqbE8nY0z6jhcTcNaMrMK6teI+/WDT746+oVce2hCDVL/KzpR
 dilFHpVD4+5MykE3mnRsOeY2vA0jOLdpUA2iufL7U+cWnWhx+0PkNceGfSYxDHfVhdvi
 RXVRIfKlBRi/kzPyd4SuZWaP1P2cHJMLpFfDpGjJcyIkkhwF5CZm7RfxJQHkVQeNGTEr
 slGT4NbdAxshEJPnOMmMutvvghMI3gZGIonMWD71d7rQRHaRkPxUyBc9kMD7sQkSoiby
 /Sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450578; x=1744055378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e7DpG1j0l2crn6m64hQcn/HA4bp5z0J1QxJNTGXkaR0=;
 b=go/INrDjy4PIAUMj/TmfGLpNrjoGShSDfvGVYapeF7O9flf5krRjr0cdFyGgP8ShVc
 RiGxlm3vdrTPyCCIXmnHc0HN5tK/l+kqkBBKPOiz+GN4n1oesFdWNky5jYQXv93wRs4b
 LX9YTNwq7CJQ3boLMVadxLUnBerfQWh6l54xrg6cwJ3C6EnfihEUlfGp9OSUc3KPdJg/
 dJXKd2Q6VigmqgsQyOK7YNy/7PG5+4iHVyL9MaV2QpZQ9WUwEbewK8VxfGsRQi20NIUo
 YSPsArQRY4unylo0hJdVLrluhvMOnANCG24I5acuGTTsZtfROXCLGayEIGMcyDrj1HiE
 XUjQ==
X-Gm-Message-State: AOJu0YxP2h5cwrDHGsYNlnvtZJA+iqMfNst1N89hjO70hq8wcXmJMzP3
 L8cm9fErqDZaNowwI41JD5vVjSSqGlSyAtkGViYY1vbrXYmdIW/6grFG8gUpTtfdnD38YXOiy0b
 o
X-Gm-Gg: ASbGncsXfLc9ugnNdwMLxDaJtLSnyEf1NBb21u4sQYVb7NZAtFLJJSHTOviRo+/Mdsk
 hYT5FX5XaA+Bneg9X//QJOljWx4OgqrAJx6L1R/o5Z7QTqjpeHmlFBMGK2lJj8/bZErX4zu9i7E
 zE8hPPkIPRF3I6iKVdGVRaSP+cdqR/GmlX3mUODyvqX3Ua0vBef7Nc8g7dv4a6QlwmfGQDux9w8
 U8J8aRHqndaJGaVc2eybOd0Rtf2oPvPTw0HjH5JxZxvVl2QILjx9o5NA/Wz9eup8YMYwlIKhg/M
 4OITOthwdRuv3s7HF6Fox0skXA2OTEunlBb6oD4+HMkmPcT4KYa/jkQO9Sz8zQWkEnREkgXAQ7L
 S+qXB6LVSWRtpIa0UVno=
X-Google-Smtp-Source: AGHT+IEWRXZXU9m2OrNLMJy3vLYS+wgKV7TyyNhWGIiqZlYRKszNjJSSNUITLl5v0FH3/Z/YBFBUow==
X-Received: by 2002:a05:6000:240c:b0:391:ab2:9e80 with SMTP id
 ffacd0b85a97d-39c2364b666mr239869f8f.24.1743450577995; 
 Mon, 31 Mar 2025 12:49:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663860sm12251119f8f.39.2025.03.31.12.49.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chung-Yi Chen <yeechen0207@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/23] hw/char/bcm2835_aux: Fix incorrect interrupt ID when RX
 disabled
Date: Mon, 31 Mar 2025 21:48:13 +0200
Message-ID: <20250331194822.77309-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

From: Chung-Yi Chen <yeechen0207@gmail.com>

Fix a misconfiguration issue in the read implementation of the
AUX_MU_IIR_REG register. This issue can lead to a transmit interrupt
being incorrectly interpreted as a receive interrupt when the receive
interrupt is disabled and the receive FIFO holds valid bytes.

The AUX_MU_IIR_REG register (interrupt ID bits [2:1]) indicates the
status of mini UART interrupts:

    - 00: No interrupts
    - 01: Transmit FIFO is empty
    - 10: Receive FIFO is not empty
    - 11: <Not possible>

When the transmit interrupt is enabled and the receive interrupt is
disabled, the original code incorrectly sets the interrupt ID bits.
Specifically:

    1. Transmit FIFO empty, receive FIFO empty
        - Expected 0b01, returned 0b01 (correct)
    2. Transmit FIFO empty, receive FIFO not empty
        - Expected 0b01, returned 0b10 (incorrect)

In the second case, the code sets the interrupt ID to 0b10 (receive FIFO
is not empty) even if the receive interrupt is disabled.

To fix this, the patch adds additional condition for setting the
interrupt ID bits to also check if the receive interrupt is enabled.

Reference: BCM2835 ARM Peripherals, page 13. Available on
https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf

Fixes: 97398d900ca ("bcm2835_aux: add emulation of BCM2835 AUX (aka  UART1) block")
Signed-off-by: Chung-Yi Chen <yeechen0207@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250328123725.94176-1-yeechen0207@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/bcm2835_aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index c6e7eccf7dd..9b073fc3308 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -98,7 +98,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
          * interrupts are active, besides that this cannot occur. At
          * present, we choose to prioritise the rx interrupt, since
          * the tx fifo is always empty. */
-        if (s->read_count != 0) {
+        if ((s->iir & RX_INT) && s->read_count != 0) {
             res |= 0x4;
         } else {
             res |= 0x2;
-- 
2.47.1


