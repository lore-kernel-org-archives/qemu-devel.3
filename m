Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76528C282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:35:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdX0-0007Qk-SQ; Tue, 04 Mar 2025 20:26:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUs-0003I7-En
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:32 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdUp-0007FL-9Z
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:24:29 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-38dcac27bcbso214315f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137865; x=1741742665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+D8Q/imAfZSFEdzdeEp7YKtJwoNb8wSIJ5VcE+KtEw=;
 b=ObWajPzYb8NyjiQGt9bWgVN8PMi27kjctpKp/t9Ba9KwNfhp2OGg5giStA9BHmfJ4b
 DGaEBcZp6LEZOYqc3TEXrgnRDrRvNFA8oQVlLov0ykpymivFSy3WVXFopsbxPWiu75Ne
 MrKUTVoielG5rcb6JLX9+PDLLUF7DxhpBb38H5wCYR68Mx0dq978sEds+kV7HRsf8L0o
 69lCVY+hVilsJ5tAAwqe3b+o9/mJ2HLTpCMzW7wPtt7ucmKo7WhmwBvqknvzrrRQNGDc
 xkGDZ8/BBkh8RO0VGf6ASI4MCthLafF9lkUlNgrUYf+XFwkpAYSlAXbVmaVX3geNZ0cX
 7uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137865; x=1741742665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G+D8Q/imAfZSFEdzdeEp7YKtJwoNb8wSIJ5VcE+KtEw=;
 b=jptaVwxmMojk8sOih4uONbDTPnjKcYqAF7vModdn9UAGISBVTBrzvPAwRUNzzBHFBt
 iOsHMRdYsT+Rn9hxxT7XLrF8nDENncIRhkZ5GaV/tQsUi5nZpv31RWBE8txYlQxZ0FIR
 Qunov5HHdbO0qrL1i70Yn/HqwKPWqjASMxuGrRmbrEkrXwW4ydy+0xAY0juHv3nI23Em
 ZF1VXz4KfmZYkQbMGCqAi1lbgZ0wPHNLbiOAUqd2y8xlM7t63EjueF8swaAGh6HFWhxb
 /sJSjArqp3smiLcyu/LeDb+ZlZVuxKYam+OSTV1ZNPeJz47QAXn72R1xwf+z4zDYyhPm
 vDqw==
X-Gm-Message-State: AOJu0Yx3JrL6h4PCCLvSTmSSz25PBDmeNqaEXKu42LRjygzc3RcdQjn4
 /I1db25qaL3vHWtGeYLR3U3Rt0/XCefPxMQQdVrfiOZHO2AomvNjq49fKECTFLFyvMb1scS1zvZ
 CwNI=
X-Gm-Gg: ASbGncvbyluZMsThh/HyLj01svkQuFfAz/kg08DbHG21xq58oCJcIt3XpaexTF8Kx/z
 iOG/dwHm+Buv80oxi5mIXhJ7/Ygyb7BpOydBWhOWDE1nIIGBgYOmOT0kV4KQJtWYN1LaiQa53vl
 WsgiS5lhWjT5D/bSZS8xCanqT83dne3wO/z9zjCBRdIT/gPw/ToZc6w+xPQI+hrcJTefj3lCM8I
 uZkGqzfdRMti/Oi0LZvxcEj/oso0+kZ7fswqX8mFyEzUWpNOHaBtJLBUXq2SBBxPzPuM/eagfw+
 D2vSNFnzf3gnq7et82BZhoS4jGoHCkfUKMhrXqlkRD3UiFKNjjIptGqYgM8NGoTQGCb9M4Yz645
 J6QLOGutyKkbAtF3RBCo=
X-Google-Smtp-Source: AGHT+IHc1/Te3utdhIsd+vjEaXcSmQGoITPS4ZJrrV/K6IAt3ScpXxEGd2yh7cFTDUJct+syxt3hkA==
X-Received: by 2002:a5d:5848:0:b0:390:ef45:1a36 with SMTP id
 ffacd0b85a97d-3911ea413a4mr867739f8f.19.1741137865454; 
 Tue, 04 Mar 2025 17:24:25 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4844514sm19327572f8f.76.2025.03.04.17.24.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:24:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 30/41] hw/misc/macio/gpio: Add constants for register bits
Date: Wed,  5 Mar 2025 02:21:45 +0100
Message-ID: <20250305012157.96463-31-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Add named constants for register bit values that should make it easier
to understand what these mean.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20250224141026.3B36C4E6010@zero.eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/macio/gpio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/gpio.c b/hw/misc/macio/gpio.c
index 4364afc84af..e87bfca1f5d 100644
--- a/hw/misc/macio/gpio.c
+++ b/hw/misc/macio/gpio.c
@@ -34,6 +34,11 @@
 #include "qemu/module.h"
 #include "trace.h"
 
+enum MacioGPIORegisterBits {
+    OUT_DATA   = 1,
+    IN_DATA    = 2,
+    OUT_ENABLE = 4,
+};
 
 void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
 {
@@ -41,14 +46,14 @@ void macio_set_gpio(MacIOGPIOState *s, uint32_t gpio, bool state)
 
     trace_macio_set_gpio(gpio, state);
 
-    if (s->gpio_regs[gpio] & 4) {
+    if (s->gpio_regs[gpio] & OUT_ENABLE) {
         qemu_log_mask(LOG_GUEST_ERROR,
                       "GPIO: Setting GPIO %d while it's an output\n", gpio);
     }
 
-    new_reg = s->gpio_regs[gpio] & ~2;
+    new_reg = s->gpio_regs[gpio] & ~IN_DATA;
     if (state) {
-        new_reg |= 2;
+        new_reg |= IN_DATA;
     }
 
     if (new_reg == s->gpio_regs[gpio]) {
@@ -107,12 +112,12 @@ static void macio_gpio_write(void *opaque, hwaddr addr, uint64_t value,
 
     addr -= 8;
     if (addr < 36) {
-        value &= ~2;
+        value &= ~IN_DATA;
 
-        if (value & 4) {
-            ibit = (value & 1) << 1;
+        if (value & OUT_ENABLE) {
+            ibit = (value & OUT_DATA) << 1;
         } else {
-            ibit = s->gpio_regs[addr] & 2;
+            ibit = s->gpio_regs[addr] & IN_DATA;
         }
 
         s->gpio_regs[addr] = value | ibit;
-- 
2.47.1


