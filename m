Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B451F483C8
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4iXs-00063b-KG; Mon, 23 Mar 2026 12:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXn-0005dl-OG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:24 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w4iXm-0000e4-AI
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 12:54:23 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so33748455e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 09:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774284860; x=1774889660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6zkZ4KurA30gv8kMnOhTH3jotd7NQGbvuL8HbdwSYNs=;
 b=zVgr9DeKcfhOXVZC2RLNtJIZqFnn0jLEG4x1ZU89cnXhYkswp5zjtpkaw0XP7wXXl/
 oTup11sz8w9GUP9tf41upAEvlD8w9huj9u1O45I5w7vMa9Euy+xFIQWr/aPft7qpaj0N
 IaGoo71LbEBKEXN93wZJ9ZZ6hilmkdDW3wLofFpps++GRGaHxCEhiFNtxG7bUy+2tiFF
 eXrlCgcMf2JuXnwR+XDAk15yrubakaakzm9rDnqJjvlpRPH5TkNLu+jD1yBPq/8XkDtj
 kXNkddGXvcfuF1sbA6NoegXYY55vVlHrkm1Z6H3k7d7ptaSao0UObEFjcmP07Mz3ZIvF
 lh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774284860; x=1774889660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6zkZ4KurA30gv8kMnOhTH3jotd7NQGbvuL8HbdwSYNs=;
 b=GwQG4UpnztgeMvFdGHeEfCM8dczFMD/7tz6uk3T5p03sBzF6ff7HQLjftyx3xitEAZ
 Sp/6EmYpFUNBQMEJEfKsTuKtDtr5TZRQKn2aBuMBxo0pCcam5Tlk+00hTEmFJb5Xvrg/
 nshjF6soUzZ5QnOwCqswaf8xIvK7xJdNjuHMVBi8w2CcwRC3jT5xMOgYocfuIJkXgeTe
 Zti+yJR1k6DKifF0bPxgcnknrMeGuK3j7TPctUv0Ktlj4KHGf2UBua9tN3TlL5Qt7E0u
 IDY1aXRHDwdcnteG27tawKqsS+mXjYh21GXbwdul8fAIh4eiNwoMZHFe8y0qsRZ4nsms
 xkKw==
X-Gm-Message-State: AOJu0Yw7CR+FMm713P0YNEHYtJqwdDtGPUlmWmyHdWJgzK+v7E0jnkxN
 y3u1F5cBn7UPBlOHdabikt3mKlC6jbFERlZ9sQOYxT65EC3Xun2KWO0oINoqC9ViWeqe2uSWmD8
 zKhRTXSk=
X-Gm-Gg: ATEYQzwU6Mp8JGk6kHydY1w6j6Q4V4vjdAVaaGevDr/fmrW3Fkabu6XSPKKhXNp6FY5
 +7P1ddwdcydpsv4oyhdy9hbz9nhoNnKP0RFBqqAdT+GaYo5C8I7N3aYT+qG9qqyndoNfmMyxDcR
 qL4Af/PaVG4ZXrSj6EdR8xQbxh1EDTuWd3ULMo9usvZzn/leHEJ79FvAu/MoEnzOSK1aBAkLoz6
 MoHGO5MlkUPZCszGDs6/lYqou1+HTchi7tLnAa96mEajZGDOfGR6yO5BqorXq7rBBF97Z4Qt3Y/
 dmpyXV72NU6u2sElOm2qq+CEJMhGHbs0KICBlGh88czddaozpwOWpaWIRF7HjKXCfS+GvCJs3/N
 9IJzTlTf3PlwsgVHf2M29Woz5a5Qvpfucqh4wXb0zo2FTuXclAu35wydporGEN4xbpfmyh8u5xy
 YzpjFv2H+7xLIjmec9KL3Fm/mEPZaF1Hi0x9wyLJD896d/Fu9cRHJJZvYKoJQgLKvpxZZ+5U2Y
X-Received: by 2002:a05:600c:530f:b0:485:2ce2:4c87 with SMTP id
 5b1f17b1804b1-486febb455dmr192118995e9.4.1774284860457; 
 Mon, 23 Mar 2026 09:54:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1e6029sm149301815e9.9.2026.03.23.09.54.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Mar 2026 09:54:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/27] ati-vga: Also switch mode on HW cursor enable bit change
Date: Mon, 23 Mar 2026 17:52:09 +0100
Message-ID: <20260323165218.96607-19-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323165218.96607-1-philmd@linaro.org>
References: <20260323165218.96607-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

This does nothing for most drivers but works around issue and fixes
output with the Solaris R128 driver that only sets display parameters
after enabling CRT controller which we would miss otherwise.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Tested-by: Chad Jablonski <chad@jablonski.xyz>
Reviewed-by: Chad Jablonski <chad@jablonski.xyz>
Message-ID: <ad3f415749178984c764f4ba810c663d1299ddfd.1774110169.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 05cf507bd47..1a6a5ad4fd6 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -617,6 +617,7 @@ static void ati_mm_write(void *opaque, hwaddr addr,
         ati_reg_write_offs(&s->regs.crtc_gen_cntl,
                            addr - CRTC_GEN_CNTL, data, size);
         if ((val & CRTC2_CUR_EN) != (s->regs.crtc_gen_cntl & CRTC2_CUR_EN)) {
+            ati_vga_switch_mode(s);
             if (s->cursor_guest_mode) {
                 s->vga.force_shadow = !!(s->regs.crtc_gen_cntl & CRTC2_CUR_EN);
             } else {
-- 
2.53.0


