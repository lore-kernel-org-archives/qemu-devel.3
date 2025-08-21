Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A68CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 15:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up7SU-00026r-P2; Thu, 21 Aug 2025 11:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7SO-000254-W4
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:44:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1up7SM-0007Cf-4l
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 11:44:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-45a1b05a49cso8855765e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 Aug 2025 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755791040; x=1756395840; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/AzTf/xWvIeqoZkGmoHWUfi46nOpYZt1vimtFvfD5Jw=;
 b=gj4+HCw12Zrn/Yz/k7dRy+e1t3w+Tr6HqDOz8sxRJnj+nI08bow8GfQbZ7nlvgFDqC
 HizQ05JpdzUrD1Zvw8rC7bo1ZIHASrqRUyhf8SM+xS0zcu8t+rswBVannYHP8joNp0Oy
 4nup4uWrju+EQHoMDGmVqnALQIjJUz7kY5G8SBvtWM4ZXUQIKIEByWBPOVh6iy1RUu0z
 lmynEJs1pcUH8PiIe85+hkaBRQJRaruWBOE1tqVFAUMDy2jrBjQpRS6JXYu9XJvq5Jrn
 Ku6WdTFoXnDO90+wkGluYHnc/CGpyt8LxyyKUqsTOty5vieQAn1HX5riQG7cFp9xFJa/
 E/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755791040; x=1756395840;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/AzTf/xWvIeqoZkGmoHWUfi46nOpYZt1vimtFvfD5Jw=;
 b=Oj0RJCccW30MaRFeI+tc0rXDlQ4imx0oXwXTpdK7MC8yrbBEM/0XphqG6KTWyAOEFA
 btzslsFRXO+n+vqom63LGOjVh38DTWTDl276896HtD6M0n9gcoc5fqcCnQ48xs//Y6Qs
 8gNPycVQcBCMvTJ5/yK80O6IfjXbGM6FqzG4XBZTQZQb9EOZJLXyST15hlZWyV6+udLk
 cEIwR6on2C6FSt+nPUn0Zx5n31Eyx8cL0CegrSXH6qxHXJFFF5KuHB3X2SOCZLoiaDeP
 Si9nOzv2D4e21/jK2qdLzYoNQNaqMnCclJJFkkXOhFv0lUfPeppt5DvtWeC3NDY6WRIj
 g8Sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8CrgWx2zHjxYLoetc9QlVoonQKUKn/DhQ9XUApEQ4HzoxsmPliVowZ3Djl+eqNZSy/fcmtRWJ6rdc@nongnu.org
X-Gm-Message-State: AOJu0YweEzV8zrrQh4iB2tn/KwMS8ETef0BDBfrZDxmdJYUgqAY8R0EG
 V/9mvzcCJIzUH/3coQ2mrFO2kTy5lu7oPyPz7WImH4QxPNrWLnd0VVz6LT+Rb9CKU2E=
X-Gm-Gg: ASbGnctK5R8G/MAaGR3MEhQzUdwIygOV4Dv+emcKvEhfbwJplC7LxvqIjzXdk8D1gms
 btgxbICnI7+u3Xv4GFrT0BFOHOlXcRiwEPYJcXwzngbgtILGMbrr34bTepPcL3US8Jl7K5sxM0G
 JONJ0frqGogO2QkNns11euVimtcJJg42TuOsx8gWJMooW05kwAf2QXnmqEdlOYFkU4xnCT72nOk
 6zlGfDiwaA/5kJfmuSEGCra0oQAl+8SHQhODiYZVFC/Ms1Yzg/5BgfAD4UzUbg1KzxK+wlssaHQ
 L7mLQ1WYw3ddB14jIkWOz/Yrd3i6HtEt0GXJXXgBuQW2HIqvjFctFmbMoqlHRGu157/FGEGzvRx
 HPDYGylIV46Uc49f+nD9G/iI4yujv
X-Google-Smtp-Source: AGHT+IH8vR1gO6sKYtu42Mq6dVzSqA4Ed+k+TGjwfZR5v+SZqoHyjDrEzMemp8FRdarzIaxzOrIHFw==
X-Received: by 2002:a05:600c:4f87:b0:458:add2:d4b4 with SMTP id
 5b1f17b1804b1-45b4d7e813amr28319035e9.12.1755791040188; 
 Thu, 21 Aug 2025 08:44:00 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b50d5dd4asm2148925e9.0.2025.08.21.08.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 08:43:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jackson Donaldson <jcksn@duck.com>
Subject: [PATCH] hw/char/max78000_uart: Destroy FIFO on deinit
Date: Thu, 21 Aug 2025 16:43:58 +0100
Message-ID: <20250821154358.2417744-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

In the max78000_uart we create a FIFO in the instance_init function,
but we don't destroy it on deinit, so ASAN reports a leak in the
device-introspect-test:

    #0 0x561cc92d5de3 in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/qemu-system-arm+0x21f1de3) (BuildId: 98fdf9fc85c3beaeca8eda0be8412f1e11b9c6ad)
    #1 0x70cbf2afab09 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x62b09) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x561ccc4c884d in fifo8_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../util/fifo8.c:27:18
    #3 0x561cc9744ec9 in max78000_uart_init /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-asan/../../hw/char/max78000_uart.c:241:5

Add an instance_finalize method to destroy the FIFO.

Cc: qemu-stable@nongnu.org
Fixes: d447e4b70295 ("MAX78000: UART Implementation")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/char/max78000_uart.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
index 19506d52ef9..c76c0e759b6 100644
--- a/hw/char/max78000_uart.c
+++ b/hw/char/max78000_uart.c
@@ -247,6 +247,12 @@ static void max78000_uart_init(Object *obj)
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
 }
 
+static void max78000_uart_finalize(Object *obj)
+{
+    Max78000UartState *s = MAX78000_UART(obj);
+    fifo8_destroy(&s->rx_fifo);
+}
+
 static void max78000_uart_realize(DeviceState *dev, Error **errp)
 {
     Max78000UartState *s = MAX78000_UART(dev);
@@ -274,6 +280,7 @@ static const TypeInfo max78000_uart_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(Max78000UartState),
     .instance_init = max78000_uart_init,
+    .instance_finalize = max78000_uart_finalize,
     .class_init    = max78000_uart_class_init,
 };
 
-- 
2.43.0


