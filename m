Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C509C27C78
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2024 12:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKzWK-0007zo-Vi; Sat, 22 Jun 2024 08:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWG-0007vp-VE
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:07:00 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKzWA-0000LH-M2
 for qemu-devel@nongnu.org; Sat, 22 Jun 2024 08:06:56 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-42108856c33so23050215e9.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jun 2024 05:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719058012; x=1719662812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WwqCJKx+EEHLRl2w5KthXnNV4TeYWMHzkPurEgLrTbU=;
 b=j117ZqU73RG9mgkA4m88kkRb1rdB1nKY9IlHhjXiv4q3VaLCr7qv2d1klwvWua87FY
 W5F+P3UiI0pLVTZbg4zN9SQKWOSc3G3y+YTBFMZRGrQSgJaiPjJil8honkCBQg64CIql
 x1LAWNmr+cBUn+pshlIlxJFUTfjJkgy2MtBTlTd1xBJ2ROmMF+t9xHr00PJIPNMEw90v
 PLnSiqZOqVg3A+t4Ahb3noY4BjItUowqylp6eaIu9ZUPlrYpWwO11jyBhvBcpZUyL6tk
 uw8GGApxh9RuRKypQ6AY76o9+vAQFsGgdyjYTAQeTRnBmQK21xhTZJn6Ll/1RunYCA5J
 Ppig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719058013; x=1719662813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WwqCJKx+EEHLRl2w5KthXnNV4TeYWMHzkPurEgLrTbU=;
 b=Cq/uKTPRRi9y0WMZYBV7bljpQHvmL5fJGmrm4d8F/MjH2tE40VsJoC/uUmC5MoaV05
 EIOGvRQheusINFHsfWGJxkuf4T6wOTdZvu/vzZuLSqvYyaX8mpdKfRZOJKtO5o6erCeO
 ZdePu3knOa9CnoZXA1bvCDyR/oTKLPE8Tsz7n4CmW3obe6jsId5SXKxJxiRF8v/Ilje7
 xkhEQGcGzX308LQ01c+AMOTF19R7L2npo6zJMKhB7GazCHrDStJZY9vgg3oWIMutgs6F
 RDQzbbPXKQUC3zJq5U2zLVBdxhhsapJAqeUQk91MEvp7Cy7F8C7wWeAXGI0TBxSf6Sqg
 ARcA==
X-Gm-Message-State: AOJu0YwWMVv4zb8mb5FOP0thOVdHTi1DMlwVgmL5yPJvpJZwUTPVKJ6V
 /2tW8BZ0NBmXSiQgU4ZUS9lfwvfua7WfI9TJyzXdAj6+KkOGjP7T9LkECZt+kyrpL4zmSrAWjfZ
 Fypo=
X-Google-Smtp-Source: AGHT+IFjkhJfLxQgFeS6oxglr9jNWDEzISf9RyqBxToUJBWUJeHIi9b6h3PjAr9ACBufFQI7VsoH1A==
X-Received: by 2002:a5d:4988:0:b0:362:f0a6:4d55 with SMTP id
 ffacd0b85a97d-366e3685c21mr743363f8f.18.1719058012703; 
 Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3663a2f698dsm4393006f8f.70.2024.06.22.05.06.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jun 2024 05:06:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/18] hw/misc: Set valid access size for Exynos4210 RNG
Date: Sat, 22 Jun 2024 13:06:41 +0100
Message-Id: <20240622120643.3797539-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622120643.3797539-1-peter.maydell@linaro.org>
References: <20240622120643.3797539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Zheyu Ma <zheyuma97@gmail.com>

The Exynos4210 RNG module requires 32-bit (4-byte) accesses to its registers.
According to the User Manual Section 25.3[1], the registers for RNG operations
are 32-bit. This change ensures that the memory region operations for the
RNG module enforce the correct access sizes, preventing invalid memory accesses.

[1] http://www.mediafire.com/view/8ly2fqls3c9c31c/Exynos_4412_SCP_Users_Manual_Ver.0.10.00_Preliminary0.pdf

Reproducer:
cat << EOF | qemu-system-aarch64 -display none \
-machine accel=qtest, -m 512M -machine smdkc210 -qtest stdio
readb 0x10830454
EOF

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Message-id: 20240618163701.3204975-1-zheyuma97@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/exynos4210_rng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/misc/exynos4210_rng.c b/hw/misc/exynos4210_rng.c
index 0756bd32059..674d8eece5f 100644
--- a/hw/misc/exynos4210_rng.c
+++ b/hw/misc/exynos4210_rng.c
@@ -217,6 +217,8 @@ static const MemoryRegionOps exynos4210_rng_ops = {
     .read = exynos4210_rng_read,
     .write = exynos4210_rng_write,
     .endianness = DEVICE_NATIVE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
 };
 
 static void exynos4210_rng_reset(DeviceState *dev)
-- 
2.34.1


