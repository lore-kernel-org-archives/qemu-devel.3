Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C28E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 23:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLVlL-0003YB-GB; Wed, 11 Dec 2024 18:04:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVl9-0003LT-Og
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:49 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tLVl7-0002Ff-7x
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 18:04:47 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3863703258fso705231f8f.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 15:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733958283; x=1734563083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+71ZOpdVAG9B9l+7/FqsTNfCtOJJsIHhAT40qDCr+hM=;
 b=p1ZWY7xkla3DXjQ2g68P2igLCFqO3MLeBEFavRFoJGRHqyWYrJyNvdjO/8aVleAlt6
 /APUezHJ9mtF+7vQLRK0Evvo22DlLjJ0wISNzi9ED7CUQDfXN96VQO28GwkZGIKKD4Zg
 f7CDEw2Ing6WhvdpFj5kEkYKXgGOOdAJnSjKbGC7evsOyMl1qY2eX9CGuFlx2JleLN6I
 P9TNAhP1o1BtbuaSfm5tIg1buvkSsys5/IQNle8L+WKkATnqtFXVI8nJ12vCjlomp8Ez
 EHKZd8Z2tDxTM1+ryjVUIXSJsAmeAfpU9KblT0XTzDPjIUtiPYe8hRhx0jFrN2DT1hGt
 MBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733958283; x=1734563083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+71ZOpdVAG9B9l+7/FqsTNfCtOJJsIHhAT40qDCr+hM=;
 b=r8dfhlEMbyxen93xY+MtDL/3hiVv7QaMrT4FXUz2ICEFruMPuXAqJnxglwVq/fR4sE
 alm+yESYtFrUALTt4u94zyUrqV2hEyxj4n2MzrY4JvQZgvtH/H8oUNQiqw+G38IuRKlk
 fB0N9z6HAxWpcHcQhrfu5B3i/BbFq4LJdAFcWTYQ8boQseAUtyeHRxBWICU0ZJef4eFe
 BUXEQ/OI4oT8r0xuXMw+7sa2sy+jyrLWObQYYSkl0vezXpwk6nXbRBc3/R73Vu4Fpzye
 fKidxjEx3LnbyvtedY8RdguEEVhwnw1v3N91awBCymjhhGBMvwG6lfTo+0fkkiSfa7ZW
 KzHw==
X-Gm-Message-State: AOJu0YztTCXOi9NRH1uOUsZijaOa7tN/BAH/4dN7lKUWXtV9x9F0GEpK
 r7XC/WGBlZ0NqQnH/t34RdCY1Oi3kTMoY0Y73dtbc7kSCkzvvNW0S/J2GW4t3bIlNCw+F/HFYB0
 D
X-Gm-Gg: ASbGncswebuh7GcrP4DFhmFo8A4OOxQt4sEXXACR5gwcDZFMN9a08zUCF53FqBHB9Mh
 1V6tTSSZo1VMJNUWjJJ9dEVT8bae+es+vAnLv5po+rTcg+diNBfPT5Xnt4cCTeZoiRHwFREGsmP
 8MeH308aldsASD7t6FnHfjeRBVLu/eVxUmxnKjpPjRHIcmj0vRsNPx4LXk4wZ0c1KCb96Mzf3kZ
 Bsit6deg64orN5Z8MnpIYOQO8Tz2li91sNmwo10aS8MF7QKijJLwr9cT/PCA8W9/xDAQnl11MP9
 /9PLMEzwGZexaEl/07FhVPq5++w4BXcqDw==
X-Google-Smtp-Source: AGHT+IEe6dwlE3rKQ3ehwUu/JJmDhcTIUXRgm4CPz2wR2Px26X3yPZt8sxZ/CCCrwsGPC7Xrs/pwyg==
X-Received: by 2002:a05:6000:a07:b0:385:e10a:4d97 with SMTP id
 ffacd0b85a97d-38788825765mr681479f8f.21.1733958282175; 
 Wed, 11 Dec 2024 15:04:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a4a25sm2330451f8f.27.2024.12.11.15.04.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Dec 2024 15:04:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 8/9] hw/xtensa: Include missing 'exec/tswap.h' header
Date: Thu, 12 Dec 2024 00:03:56 +0100
Message-ID: <20241211230357.97036-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211230357.97036-1-philmd@linaro.org>
References: <20241211230357.97036-1-philmd@linaro.org>
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

Some files indirectly get "exec/tswap.h" declarations via
"exec/cpu-all.h". Include it directly to be able to remove
the former from the latter, otherwise we get:

  hw/xtensa/bootparam.h:40:16: error: call to undeclared function 'tswap16'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     40 |         .tag = tswap16(tag),
        |                ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/bootparam.h | 1 +
 hw/xtensa/xtfpga.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index f57ff850bcb..4418c78d5bb 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -2,6 +2,7 @@
 #define HW_XTENSA_BOOTPARAM_H
 
 #include "exec/cpu-common.h"
+#include "exec/tswap.h"
 
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
 #define BP_TAG_INITRD           0x1002  /* ramdisk addr and size (bp_meminfo) */
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 398e6256e1d..2e264c61988 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "elf.h"
 #include "exec/memory.h"
+#include "exec/tswap.h"
 #include "hw/char/serial-mm.h"
 #include "net/net.h"
 #include "hw/sysbus.h"
-- 
2.45.2


