Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EB3E7718B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Dec 2024 11:28:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQPYk-0005SB-97; Wed, 25 Dec 2024 06:28:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQPYh-0005RJ-KC
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 06:28:11 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tQPYf-0008Cg-Qz
 for qemu-devel@nongnu.org; Wed, 25 Dec 2024 06:28:11 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso60754235e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Dec 2024 03:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735126088; x=1735730888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xY3AelCfFa56nMqxO27r1LoFMTGTx90cLHeWano2z54=;
 b=DgXiQhBP+TGjdoBqKedrtjGK/5/+LVxwHKQmgLG/2ajJE5ILLTFOjfG36zRurbi+Ye
 NdRNMNFMYirQRFNw2GfiRXqmdl9utDhUnwVgNgxj7IPCyJyOu+OrR0vAAVb1Pr6+kw/J
 pjy+mLAu8oKCnJ7OXlAx9O/fj9s6k09uaYX4zgfPmyMCSFT1qXIpzhZo50nwNEU/v/xe
 B/aacLF24T7HpQY4JDs2LFdDw46pHLFNRO365JUZqtIeP37nNHEfD+W8CfpENT++ziwP
 9NCyw14H/bJSL/1S1+4+HdZGXwYlTXNfjL+nSv24CD1b2BpYqkj4pBmRU6j4cBO2DpJq
 Ctmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735126088; x=1735730888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xY3AelCfFa56nMqxO27r1LoFMTGTx90cLHeWano2z54=;
 b=Z+CZTzd0z0mkx3A6BtlZl+pNMlYvuXLdhDY9OIkjTJflUxTneF/6lid9vsY6k5kxjy
 Qk00xdl0ouBqvoTRYsuCl64k41ENaqT+A9hu2Uvrykh4dBpJC2X05zoCs0+vRIfBSJ3f
 HSgMbSb4JCHbd1IHZUELf0Xmz6eyQeXadqXILNTFlt2jPxu+YMtUJALcq71h9JM+sUOy
 JX+3j+Mi1WVxYnbDngEH1qVrru7OLqsWNg1zRG46Y/lP3ugQLb+fxlZTs14/UzEoAMBf
 f5s0X3wSmE4j9vBZrX+Z1PCAFvImTqMLeenp0Ih0uL9qnnVQiMFXfB0WaVQPe4cz8lJZ
 GPAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfQoNy8hlPP3iJirj748qUzKeNCBIvEwG5N7oykSJ512P1IXBUrhc5X3a5VdaFZYek0CV1R+f4PTil@nongnu.org
X-Gm-Message-State: AOJu0YxnXg8VDS3/wwnhdH4uYeIc5J97OcuToihDvzQgKUjpoC6EK0+d
 5VTyb4rURH55GAwNRTfPzcOWCUIwy+QkYPpe/Lu7L/1IIy0ngbN6S9RCZqRV4JQ=
X-Gm-Gg: ASbGncuDTe8tjDCpoVwNg1TKbD1VjFU5Zxd4a2oV9YWuLHjpT6c8Vb6LGqJX66yx1Pv
 /AsxodRKhnokKilPZ/7Acl6IfzN8EZSz+M0OET40fkmOVWnPIRNgUclxWM84lRuU38BUuxfEeZn
 0MFmzIokqlikiF28M/cIAmr+JqyXZS3z7/CFWJM2FVNrkyy0s7UR8RPdyVIDTX545v98aS1xao0
 clRqBkq2bqcje/OXq9ZRU+5XVeZoaOWBL+wGC0LJ4dU+ti/0EmCiZoYNFmbNauOwyQ=
X-Google-Smtp-Source: AGHT+IE2/DHS4xCtm3JgSsMr+rB0qeNyMgJwhbAGvcW5MhKGVDyR59Z8YpKX+noO8ynTVBIjnJ70jA==
X-Received: by 2002:a05:600c:4f8a:b0:436:488f:4d8 with SMTP id
 5b1f17b1804b1-43668643a47mr161523085e9.11.1735126088052; 
 Wed, 25 Dec 2024 03:28:08 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8288b8sm16594965f8f.11.2024.12.25.03.28.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Dec 2024 03:28:07 -0800 (PST)
Message-ID: <6ac5dae8-db32-4275-9570-da1696a8764b@linaro.org>
Date: Wed, 25 Dec 2024 12:28:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] aspeed: Make sdhci_attach_drive and write_boot_rom
 public
To: Steven Lee <steven_lee@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20241225020311.3718080-1-steven_lee@aspeedtech.com>
 <20241225020311.3718080-2-steven_lee@aspeedtech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241225020311.3718080-2-steven_lee@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 25/12/24 03:03, Steven Lee via wrote:
> sdhci_attach_drive and write_boot_rom functions may be used by
> the aspeed machine supporting co-processors.
> 
> Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
> ---
>   hw/arm/aspeed.c         | 4 ++--
>   include/hw/arm/aspeed.h | 6 ++++++
>   2 files changed, 8 insertions(+), 2 deletions(-)


> diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
> index cbeacb214c..bba224c357 100644
> --- a/include/hw/arm/aspeed.h
> +++ b/include/hw/arm/aspeed.h
> @@ -10,7 +10,9 @@
>   #define ARM_ASPEED_H
>   
>   #include "hw/boards.h"
> +#include "hw/sd/sdhci.h"
>   #include "qom/object.h"
> +#include "system/blockdev.h"
>   
>   typedef struct AspeedMachineState AspeedMachineState;
>   
> @@ -41,5 +43,9 @@ struct AspeedMachineClass {
>       uint32_t uart_default;
>   };
>   
> +void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
> +                               bool boot_emmc);

Indent is off.

> +void write_boot_rom(BlockBackend *blk, hwaddr addr, size_t rom_size,
> +                           Error **errp);

Ditto.

Pre-existing, functions taking Error as last argument should return a
boolean indicating whether error occurred or not.

Fixing indentation:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


