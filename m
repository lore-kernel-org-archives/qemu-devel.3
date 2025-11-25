Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B505D10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:50:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0vG-0003Vj-3B; Tue, 25 Nov 2025 16:50:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0uS-0002pP-LO
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0uQ-0005Km-Pv
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:49:16 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-477632b0621so40584775e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107352; x=1764712152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dmTD8Lm1Ik0C912Tu/eoR015Q1kbSP/lIxEJnzSa3u0=;
 b=iwRJicheey5ERCpt0IqlxPiElScgv2wR42nBqfkVAQQfS1Gzizm3HXMZ5bqq9QsloK
 HoVVDo5lUQr1tQ+EB32pPfORHQkXc6NRcTgt6a59X+2i+vshqoVCZI7UsaSMIJsR3iGK
 tJZoREvM+gwL9pNg4daJIsG6NYmvv2+DtBAlQrgkxJ8LlfgJroEGpDh9LzjmSyryrEhY
 77NoHPcdKB7Bwh/RjWxLyhFe/1Be17vJkegduXcjHHLG+8bxZJ9AiH6HJv/TWekZjkzU
 VLyb/KakBL/KTRPk2/vv8pqIMviyqfjDxss1/hZT0VJsXsxvKrqArcWjfgGXw62oqZwO
 Vz9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107352; x=1764712152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dmTD8Lm1Ik0C912Tu/eoR015Q1kbSP/lIxEJnzSa3u0=;
 b=BeZBBF+h3l/NvIqoPaFR+bE+SBODyj7pdAp8EqsKa74mjvjW7/6i3vE8OLEuMywfEe
 hzW1U+7WOoXt2neyJ28OyKsykS2RO9le3IUVFPsT1LtDCgWBkEIEIqfv0cDsiNlQsVc3
 l3aN5GRZTGteM/AH9NCh1Trir6/YIJoWCGp7ZvAWvQRLJ7t1t7iZSX3dyKyU3JFgjKVd
 0jI7wgom6vM6tKcH/EjoSHLnMwjNW4/ykJzZbViknRrhpSjGG4KP/mIcXwHHwO7ns4t9
 2BkgwuZIl7lBRCC6/CvOQufWElNHKhNXfy3o9+DpEB2A9XJ8XBR1D1sAtFzvxIMoPGkE
 72lg==
X-Gm-Message-State: AOJu0YySGPe2pBZX33KFhOWedt+tJuO79LJ4kWWDhIL5xclTRDqdqoZd
 HchxAA1cJkuq0XoxdKRImprqH9SEgf3/Be60yWqlD163yYMd86srhycz+vxtK+4xXaSzHWN4LxY
 JMY5v+1BJzg==
X-Gm-Gg: ASbGncu+5D0YvyfOySTgymO10JBfuUct4OWQPjAc/QwrXcLI3eOZP3Q33mbg48uHJC4
 UeBHo+04/wPSzzP7N8myqOv1O2yJ19DvwWcU9T8VIc3F5HXWfkcW1vBTX8NJ8+7WuyTYU9yjFHu
 nuPlJ5YkvCYAvaEMlcEzuDb+LvzOfxtN9ZN36rCEIdkc9R1FgkYSXhSdjVSyNcZtRFe8vvOCXzC
 5SPVAG5aClqlzQ4kZBcfyLHUXRpa0kVuJ/u9jOvoA9572hNkBnTZy7wGER0Em1JRtWtGUCOftG4
 W94Nh6gSAWkXIkb/ONIEiQCChf/5WZahpNQGNfpdY6N4RKyElPdsir9Lux6jIk4XKs53n6DCHeO
 GjYVHHM1vterjGh61R1IE2b44feklk3w0+bUixWiUR6UEGlue/u0ut/UTZ4sP8NwzgFvtBg7FJC
 h9H/NBr1lMgnodA3lZErxnHeqNBHdwnzor/gaj8agckEhvuD5PxtAqmVh4zPVufg0iGGH7M1M=
X-Google-Smtp-Source: AGHT+IE9BwDlniSAF7UdiSk+WUl4iRjFhUKWrqXlfmdt7R9v0u5oLkx86O2PjBxx9mY5/7gJ1bElDg==
X-Received: by 2002:a05:600c:1c20:b0:477:9d54:58d7 with SMTP id
 5b1f17b1804b1-477c1131d60mr179336655e9.29.1764107351952; 
 Tue, 25 Nov 2025 13:49:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479052cfd9dsm25113205e9.7.2025.11.25.13.49.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Nov 2025 13:49:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 9/9] hw/aspeed/{xdma, rtc,
 sdhci}: Fix endianness to DEVICE_LITTLE_ENDIAN
Date: Tue, 25 Nov 2025 22:48:01 +0100
Message-ID: <20251125214802.1929-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251125214802.1929-1-philmd@linaro.org>
References: <20251125214802.1929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

From: Cédric Le Goater <clg@redhat.com>

When the XDMA, RTC and SDHCI device models of the Aspeed SoCs were
first introduced, their MMIO regions inherited of a DEVICE_NATIVE_ENDIAN
endianness. It should be DEVICE_LITTLE_ENDIAN. Fix that.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251125142631.676689-1-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/aspeed_xdma.c | 2 +-
 hw/rtc/aspeed_rtc.c   | 2 +-
 hw/sd/aspeed_sdhci.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_xdma.c b/hw/misc/aspeed_xdma.c
index cc03c422b0e..c448ad32ff2 100644
--- a/hw/misc/aspeed_xdma.c
+++ b/hw/misc/aspeed_xdma.c
@@ -113,7 +113,7 @@ static void aspeed_xdma_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps aspeed_xdma_ops = {
     .read = aspeed_xdma_read,
     .write = aspeed_xdma_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
diff --git a/hw/rtc/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
index c4feea23a0b..6793e253f47 100644
--- a/hw/rtc/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -131,7 +131,7 @@ static void aspeed_rtc_reset(DeviceState *d)
 static const MemoryRegionOps aspeed_rtc_ops = {
     .read = aspeed_rtc_read,
     .write = aspeed_rtc_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
 static const VMStateDescription vmstate_aspeed_rtc = {
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index fc38ad39ce1..f5c0c4956aa 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -124,7 +124,7 @@ static void aspeed_sdhci_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps aspeed_sdhci_ops = {
     .read = aspeed_sdhci_read,
     .write = aspeed_sdhci_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
 };
-- 
2.51.0


