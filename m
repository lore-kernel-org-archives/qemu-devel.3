Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C1C87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 07:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugfE1-0004d7-9n; Tue, 29 Jul 2025 03:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugfDz-0004XT-L8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:58:15 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugfDx-0000uS-Fg
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 03:58:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4563cfac2d2so54536225e9.3
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753775891; x=1754380691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e3na7J+1bExZg3/yS04m4IPhlyG39AMzvxUmdDpRMiA=;
 b=Ypo4VIsTXWFXsG9cs0kpvIVwl8S+VePAB9YkQjWOpff3UdNU6yYzabQaHQKkEToVnA
 rMyzXJhFpcUR4jufZQr+IPddpcvLUCTtpusqp/xY0QDVGedPTSd0L/GXs4MUh7iL8Vln
 gCjsa3yhx8shc+jvsBwUxbrQA4s4V6d8tcjmSRBkRUd0ZfDuBA6TR4aNjUbVAmGIorZB
 LCoFuwmnmr8EnMvx/lfJ99mRBMI2bxzf/iKpcQ5vXjziHt+B5oxHGR5YTSHQpyI/4lw1
 W8uWqHIrxY+EASeoJrzIsUbrR50EaT3eJVg+BI83WEpTiXAClBKlLkHi5qB2RevQr8GF
 1ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753775891; x=1754380691;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e3na7J+1bExZg3/yS04m4IPhlyG39AMzvxUmdDpRMiA=;
 b=ResFLf4/gsE+yFPOXJdo59h7tYOHC9l2WD696BjW7eelqV9MdfAERhTm28YF7Z30Ns
 t8hvcYDy+6TggXUsFPcsDXaapmQyIDL/OWRB+PnoPK6pdX8DeX0pqn3nJaiMbiyoht8U
 10OCYDEwIUwiZhei+qgGjwEvIvee5BTKK0sITjMP7ltV+0SGYtjuXFY+/tjT715MOxDw
 LMEybJySGiFT9y2Dv+/x3dzfNzmbbmT5QS/7ekSa73KNT1t3+Yrq4LcqkThAO00aqv8n
 MG9ZfEYiK0P3DA+hQ3xlke8yMxS0Kk0Nwqgzd9+O/BWoED4r2LY6zEYTStMXH8B1pkeo
 Uvlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSLGDRd+cBx4Y96MTPVDrm3CmcVYeTWe8m0twqdNbtlZv7lRBgCxPd6IGkLsPYICIDLu7dGfZ/IEod@nongnu.org
X-Gm-Message-State: AOJu0YzMtf6rdwUlA4jV4lCt0dHFKHzzzcMdTpFAF3iltha3Z5Ty7sfS
 mNkZLd17hkPbF8iHf59gWccBcZ5mPNDMqsHQYD+dSG3g9D4Sf7at+C15q8LERUqqe2s=
X-Gm-Gg: ASbGnct7CUrgwl8MK/j6SXuDywnKEaFek0MYlnhZtxf1fCiLkdLG9mFU67Yc9A0mJ70
 GPSuh/GAjIG2Rt7Weloy+Ij9ZFoni3WYn+g38nImTHiT1cdFC+m9iS7k873xacvawvWwHkiDjC1
 AKEqZCxL6vREf1ykdiU/y2uEJvR44NjTAtdSl6o685LZ/H+guyHadE8MUIkKr38wRhCCCLpKIQg
 pd9Jjxgz+6BzYLCfblmnD/FcLoTZ0pcLgZAI0htLi+tmehCrvaPjxsvKhZLzuRUC4kLz2sGOpiA
 ZBP7PqXtNYwJhaE9HqWPlsggln3EbfYHcyJiTLMCW25xplc1NF0dx11eh2Je9AScJ2TgBj4vQQy
 +cT/xNbjIPmFYN9/LDJLLofjLrKIfhKeYyXSVJSEA6uRN7ojbdH8KHDxdUEgBPAWBFQ==
X-Google-Smtp-Source: AGHT+IH1Le8qag0svpTai204IMvIitvgVFJ0sHmglb6aoHPD10gnBJQbRCvnKu7xSLNn6k66vSS+1g==
X-Received: by 2002:a05:600c:4f4b:b0:453:81a:2f3f with SMTP id
 5b1f17b1804b1-4588004c1b9mr95455275e9.30.1753775891338; 
 Tue, 29 Jul 2025 00:58:11 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4588e5cdd20sm14267385e9.19.2025.07.29.00.58.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Jul 2025 00:58:10 -0700 (PDT)
Message-ID: <80ce73e7-d6ce-4e20-b902-dfb3d4c58065@linaro.org>
Date: Tue, 29 Jul 2025 09:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 10.1 2/2] roms/Makefile: build ast27x0_bootrom
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Hao Wu <wuhaotsh@google.com>, Havard Skinnemoen <hskinnemoen@google.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <2a89ad4c8f5665d07952a4f1749caa6ec0cd3d9c.1753654515.git.mjt@tls.msk.ru>
 <607a943a587248fbe0ff0897de80aee98a093caa.1753654515.git.mjt@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <607a943a587248fbe0ff0897de80aee98a093caa.1753654515.git.mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 28/7/25 00:19, Michael Tokarev wrote:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3052
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   roms/Makefile | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 6af68a922f..2691b935c4 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -68,6 +68,7 @@ default help:
>   	@echo "  u-boot.sam460      -- update u-boot.sam460"
>   	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
>   	@echo "  npcm8xx_bootrom    -- update vbootrom for npcm8xx"
> +	@echo "  ast27x0_bootrom    -- update vbootrom for ast27x0"
>   	@echo "  efi                -- update UEFI (edk2) platform firmware"
>   	@echo "  opensbi32-generic  -- update OpenSBI for 32-bit generic machine"
>   	@echo "  opensbi64-generic  -- update OpenSBI for 64-bit generic machine"
> @@ -200,6 +201,10 @@ npcm8xx_bootrom:
>   	$(MAKE) -C vbootrom/npcm8xx CROSS_COMPILE=$(aarch64_cross_prefix)
>   	cp vbootrom/npcm8xx/npcm8xx_bootrom.bin ../pc-bios/npcm8xx_bootrom.bin
>   
> +ast27x0_bootrom:
> +	$(MAKE) -C vbootrom/ast27x0 CROSS_COMPILE=$(aarch64_cross_prefix) CC='$$(CROSS_COMPILE)gcc'
> +	cp vbootrom/ast27x0/ast27x0_bootrom.bin ../pc-bios/ast27x0_bootrom.bin

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

(I only tested the bootrom builds).

