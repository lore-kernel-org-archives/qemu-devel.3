Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E977C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcnm-0002cz-Ga; Thu, 30 Jan 2025 17:14:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcnY-0002Uo-6b
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:14:10 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcnU-0007Cq-Qp
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:14:07 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so735394f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738275243; x=1738880043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jdohv2h58n1LGauybYg54TJbRxP8v4XIJS7aqofxpsI=;
 b=tWGPb+s7KV6z9c6u8JQGb+D5JXFR8T8oqrAvemHPE09ZEed2Ab3JEFu3qU32/2PA2U
 qaB3YunH7ZQxcV3sz6QBtcCFxZQdanwGVFico78zJieTTaiCSwGki/Ow0rEU4goZhz2e
 n5BeFmzE5EEbXa7j6tsGQtAQ4Yx3aajinCiCvELxKzbKU4YH5V3Dzfm2uwL7uguwmXrk
 oUJtf/BBKhoKHq+vgS8aJp9WeUvO1sHGRe0Gy8fKpUH4809HWADkvAx9kaiEJ1lS2GQR
 lxxTmV+1SZWUqtcYxD+ipBiaW66c0w6kpgQw++WB0LBLEYTpvk0pOYIL4W6reGD+2NWP
 8v2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738275243; x=1738880043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jdohv2h58n1LGauybYg54TJbRxP8v4XIJS7aqofxpsI=;
 b=jLy7FUP0+6h1bR//HkrswIF2EyHFnOTAA/raE8GiQCHWK6K2F8BjLqVXpkanNCzLIE
 tqDgrY5USpdIobCcI0h4IcXB3fAlEO+P547GwZzTyWQCtwR+s70nDvKN3POR5Tp1g8J6
 X5cmGWVQ6vpgmXmh88kdKDTsM/+9HhYHTTPSEgebVUMA5vuSDIMkcmFc9hR7oDtj6JGo
 rG69EiHtZIc1mdcNxEpZufhaktPgKyyjRl+c+II0SFqkGJjsK7wN+NaOdoLPc7xcJdzi
 ps1a1VULZUYo6Ke0v18l8gnxSuRzjud7QGCRyMzNA5iLjr4vXYFbQYye0BSreT7g2HVe
 2h0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0TswORFnrKOTKDtN6BbU8gE1ycT/UGnbZJJAz3WvURIo1vrPZGfZkdMTY/FS5LDac+uDZLdISzyHr@nongnu.org
X-Gm-Message-State: AOJu0YwLALnqlxNTeGkFQvPKky4IZrP09Ema+4Zsdd02F4Qv4UzrUA9H
 S8PkBygfzMCgDaKv3QhGlAWdiTrh67j6FpA4BXa47NYBLjMMW/wAlrzKngP5xgA=
X-Gm-Gg: ASbGncuYb2XG95ByNuYXpkV0JUbogCX6e/L7KBvyy6622CPdPHMoz55R6cXe08g7ExD
 k6+WmUtlCv3aexHnnPdn9BZMr6lFDjUUZQRrwNJUw2N8jRnbJg1Q/r1MK4F1d/cLs6iBmZOyAY3
 6EP4/3gQ5gNFKHDEnZgoN6FWex/YKtDxDgr1k/SzjO6wDGXiFYUqs19H1sWS/1ws2Cq4CPb8Fsb
 LnhYdvL8e69uF9GLpmZJKnEeuJu6EM7gn2S7VtVcZJF8prDviyYPJgERp3bpA+rVv1ahlbABQ69
 +mRgbGULxDOP+wVjJRZq53lQ+1n2fVqt+c5EFV4VWCFURIl+UPqImNj4IE4=
X-Google-Smtp-Source: AGHT+IG+j5QA57o8ig8G98BQlRfL+I5a9Gm4byejoz6OyiuHONvCyf2rR4olGlrdtDyQ7eY1UpUqjA==
X-Received: by 2002:a05:6000:1864:b0:38a:a037:a517 with SMTP id
 ffacd0b85a97d-38c51960307mr7494435f8f.19.1738275243039; 
 Thu, 30 Jan 2025 14:14:03 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1cfa2fsm3138520f8f.91.2025.01.30.14.14.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:14:01 -0800 (PST)
Message-ID: <6b847b2d-dab4-438b-9e2b-e06985bed2f0@linaro.org>
Date: Thu, 30 Jan 2025 23:14:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/sd/omap_mmc: Remove unused coverswitch qemu_irq
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> The coverswitch qemu_irq is never connected to anything, and the only thing
> we do with it is set it in omap_mmc_reset(). Remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/sd/omap_mmc.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
> index dacbea13aad..07d47421bc8 100644
> --- a/hw/sd/omap_mmc.c
> +++ b/hw/sd/omap_mmc.c
> @@ -35,7 +35,6 @@ typedef struct OMAPMMCState {
>       qemu_irq irq;
>       qemu_irq dma_tx_gpio;
>       qemu_irq dma_rx_gpio;
> -    qemu_irq coverswitch;
>       MemoryRegion iomem;
>       omap_clk clk;
>       uint16_t last_cmd;
> @@ -325,7 +324,6 @@ static void omap_mmc_reset(OMAPMMCState *host)
>       host->transfer = 0;
>       host->cdet_wakeup = 0;
>       host->cdet_enable = 0;
> -    qemu_set_irq(host->coverswitch, host->cdet_state);

OMAPMMCState::cdet_state is now unused:

-- >8 --
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index d31456ad236..031a6f0d333 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -71,3 +71,2 @@ typedef struct OMAPMMCState {
      int cdet_enable;
-    int cdet_state;
      qemu_irq cdet;
---

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


