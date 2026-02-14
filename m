Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4469EEF99F2
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr59U-0003dK-2v; Fri, 13 Feb 2026 21:12:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59R-0003bN-Pf
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:12:53 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59Q-0004Vd-9r
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:12:53 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so1045999f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035170; x=1771639970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UW54D3jaK4/hOnhFU88FxBB/FWP9ogaH9ApScZzAiAU=;
 b=Ig0PCF4uSz+14+C5YHx7ambnsPAt42wI9f9ergufYPT+gdaU5DwNWXt6W8kYd4M5bH
 M+o7sn5ClZCFeV3MNTvQNm/EHuauf+7SQk26sAI8FT+KjXF/CLUn1IrhIfugQLZvadaD
 GTloQIyr2t7dIMncFG3EvDQ14M3VWYvO/DZQOBB8WVMg+bAsHnpPh/cuqxh4u7ytKON3
 M3XgMb0FcPGTeflqfw3msXcDu8r852JrUoMbRErLkcV24LR83WMh2NE4s2y2HpkCHhU8
 XARqOt4mA+mwm8ppH1xellVhHC4HEnXulXVZiYNxmN2mV8JEgwgDCne27SW/kVD4qi3s
 8pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035170; x=1771639970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UW54D3jaK4/hOnhFU88FxBB/FWP9ogaH9ApScZzAiAU=;
 b=HzLrPdiZAdb6ITeBj81GF+RTT7wiY0CB1WzesoTgYmtWDn5NW66bTUite1ZRY0IhWG
 pLn/XHzZeaKOK3oJJ8u0H1r41Ztha7Tr40zz7wJ6XslOEk9q356p4u7wcJtggR0UCCbn
 oAp34HSjQlYVqi9uEXtS4/Pu3IJ0HbydaEQygYplT9hYJ23KwikJstf+sKSF8pHx9roT
 WW+xjdGZ0+wXhLJO3nsG5yOe1Zjw3dPpn1jSvd/AuomxtDz1x5blRq8ezZFXZNhpy54i
 xAi0DC4SaA83dGZZmsaLVNvp/euEaNkUasY0+TLJldwt83er3Jh1MLS0zYXOJ+p3Bv+3
 8LiA==
X-Gm-Message-State: AOJu0YzCQDUY6JFuxWW+bLwFn00DB3CBfPdtYVat2babDhwqsrh8/K5F
 tJIgo80qFUrw2dZcrAufP4LxWLHrUGIJiZ4aHz0PqxCLT02EYftnLjmkCcEt+PbmS+A5nQOxwav
 CdABvkG0=
X-Gm-Gg: AZuq6aLHisCaa45OdrRFCL9V3mfGnruMYuepO+FKiFN0/MpkgfDipIMYyzVXZ4o4ZnP
 T6g3zK8D5Y6/83UJeNoG/theFGw9TlTbb/1WQkCIbNKY85SI2C441B6dDtFBqhi/91yALnVwIF2
 rplQ1meVE+PPpcXk1STivZHoQu/NolqpSmMJkNXbVqHVqHF9VRZs5bLgKQrgVTd74D+CYcNWXfa
 OqwwigomCGD8UfA+wqwvTo+7/R+cqVov0lFCdDh9qWzkUClhg47McVcE4S2NoyHfFhruSxqMj2o
 s2IBt3JlD9ULpekYhniod10w7DRtE5XPi5QU6EaszLb294+oMCyZ6TW/MNnFmFkIXU0SyhA8pbd
 8fhMob+uazKR4IHQ/tRkBCfeYerTHdxMwS+C5swuexwjGoCiZTPP/N/iuosdmW2p/qzyHrf0ist
 9BwnsTxBzL6dNNxDFo2CRBUYG4LIqLOO4GeUVRNMVop/ZXHuPXSPGfjUj3TazmTbarDxofCnvtJ
 2vfps2HxbY=
X-Received: by 2002:a05:6000:2dc6:b0:436:145a:e54f with SMTP id
 ffacd0b85a97d-4379db66af5mr2632969f8f.24.1771035170355; 
 Fri, 13 Feb 2026 18:12:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc8b1sm9981348f8f.23.2026.02.13.18.12.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:12:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/8] hw/display/macfb: Constify macfb_sense_table[] array
Date: Sat, 14 Feb 2026 03:12:32 +0100
Message-ID: <20260214021240.58657-2-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214021240.58657-1-philmd@linaro.org>
References: <20260214021240.58657-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

macfb_sense_table[] is only read, never updated, so can be const.

Update the single call site, macfb_sense_read().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/macfb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index 388f8de5070..57ad8ad5587 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -82,7 +82,7 @@ typedef struct MacFbSense {
     uint8_t ext_sense;
 } MacFbSense;
 
-static MacFbSense macfb_sense_table[] = {
+static const MacFbSense macfb_sense_table[] = {
     { MACFB_DISPLAY_APPLE_21_COLOR, 0x0, 0 },
     { MACFB_DISPLAY_APPLE_PORTRAIT, 0x1, 0 },
     { MACFB_DISPLAY_APPLE_12_RGB, 0x2, 0 },
@@ -342,7 +342,7 @@ static void macfb_invalidate_display(void *opaque)
 
 static uint32_t macfb_sense_read(MacfbState *s)
 {
-    MacFbSense *macfb_sense;
+    const MacFbSense *macfb_sense;
     uint8_t sense;
 
     assert(s->type < ARRAY_SIZE(macfb_sense_table));
-- 
2.52.0


