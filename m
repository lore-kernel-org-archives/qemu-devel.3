Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC82C02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 09:14:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfxxQ-0001NG-G7; Thu, 06 Feb 2025 04:14:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxxP-0001Lx-HX
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:13:59 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfxxN-0000X0-G2
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 04:13:59 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-436202dd730so4035075e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 01:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738833235; x=1739438035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pDgcAlMNyQ4DG4dpdetfZlMlYqvYugdreSuwKZVFsk0=;
 b=aH/ti4Or8ioU6ujSpXydv2XNntDpPF10rb3gLwU+GGgH88xDLxqo+A269YNv4eMiSN
 K+vtnc57fTx69LXvP7viTk9+Jacl2pjcl6+Wd4xbIOIWcFKC+lXh0/yluGhEsTx+9YRu
 cuJXdTGWkXQ3Wi4WV0d6n9oweDMH4Siz/fkoM1tehegvpXm4zEMrSARACH8Wve2XfrJX
 pooA6dQRybHfuYhzLprIfamxBqMgmOemJFiSiyTKK9yywEAZSQduFDyhnunh0ttRe1U4
 y/z/Yo7nh+Gtvi8QZci1M/S4MJT0EC19P7+BANOhSEh5jUHlRJsHGapEfEMb4OMeZIun
 TtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738833235; x=1739438035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pDgcAlMNyQ4DG4dpdetfZlMlYqvYugdreSuwKZVFsk0=;
 b=Q9Tv0ntTFjSBw8IuQvg6RngYcU2aONBoj7P0/y2qb7H//wEJOmKNjw0ZxBUrny94jj
 D7w7aWm12yAcCPCav9eD6Xq/1QztV+S7bcmi3/ul/7PhnmZwOnneQndisnIjn7PNXk0c
 UQPt2s2cY1Pppjo+NTzFkhPwLT0p40Z8xyn1M0Soz6r4y3Yx+Y9QoFSyFgAuUmv4Ibzl
 SlDauQErZ+y3NN5YGO+bp1OgEV8F89j7AzOCX/0+PPpmFbMTIEpA6SSyRb+w4hCCzaxi
 8bd5U4pT4/ZcDvVg3jghj+aEPmxR/pw3AqFDUgLfG/stEoHc61mtOr58139N0ebFQAYA
 +SVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQk2hcy8k2mGEKmeaUZOSdq95AJ9y+1AS2OZMZwAIdJl2djUwr/QJwAPwChSuxSmelZph4Lq0Wfdbn@nongnu.org
X-Gm-Message-State: AOJu0YweZskq7rg/MiX0sj81KFiVZcJnDYtrvwzM/duAyrdpQfa/hjWE
 gnJWv+jrDscxLRNgx/qzZ3Fa0Oa43x8/KFrOXEbThqmW64/quw6Noc4Ws1g7uOg=
X-Gm-Gg: ASbGncuZuNDdRFeYESwW9bZX+p4NY51NJv38B8zapOXUDWtYEDCcXmsO9JOMIIVUL+I
 EWjyBXJoNde9DgnBLSjinJyhKPGRwp3EQm8Kli0Q/yYunFi/mz/MJz08E5XQaxfSr289SXdnXbD
 mA8FAlWimG8EbAdQScvn+oOXAhLSAK0ct4neRpuC1g0OtuwBHhnr9A3h9DzwrqXXgdwIEAjfPbP
 3iMBc7aInXKuOkQCGR7VqEmWmEBNjD8ClIF5wJW068rpWTYPBp2LJ6mz530jec5QLpa+a4/Fns8
 V77lZJXpcyAgU9/tJw0KDEV1LnMoih8Ao3ngpcmMomm4lKIAem/gYBVdjkU=
X-Google-Smtp-Source: AGHT+IGu2T91K1g7bG+QsXBwgAe6I0azewRvCCeOjyzY11KGdwMniswMJd4Z1rtJSkVa5UzQmoanmA==
X-Received: by 2002:a05:600c:4f8e:b0:434:f8e5:1bb with SMTP id
 5b1f17b1804b1-4390d43451fmr55130735e9.12.1738833235484; 
 Thu, 06 Feb 2025 01:13:55 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390d933523sm49453965e9.1.2025.02.06.01.13.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 01:13:54 -0800 (PST)
Message-ID: <cd16b620-2611-402f-ba2c-e1ebe0745c2d@linaro.org>
Date: Thu, 6 Feb 2025 10:13:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/17] hw/misc: Add support for NPCM8XX GCR
To: Hao Wu <wuhaotsh@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, venture@google.com,
 Avi.Fishman@nuvoton.com, kfting@nuvoton.com, hskinnemoen@google.com,
 titusr@google.com, chli30@nuvoton.corp-partner.google.com
References: <20250206013105.3228344-1-wuhaotsh@google.com>
 <20250206013105.3228344-8-wuhaotsh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250206013105.3228344-8-wuhaotsh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Hi Hao,

On 6/2/25 02:30, Hao Wu wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>   hw/misc/npcm_gcr.c         | 131 ++++++++++++++++++++++++++++++++++++-
>   include/hw/misc/npcm_gcr.h |   6 +-
>   2 files changed, 134 insertions(+), 3 deletions(-)


> +    NPCM8XX_GCR_WD0RCRBLK,
> +    NPCM8XX_GCR_WD1RCRBLK,
> +    NPCM8XX_GCR_WD2RCRBLK,
> +    NPCM8XX_GCR_SWRSTC1BLK,
> +    NPCM8XX_GCR_SWRSTC2BLK,
> +    NPCM8XX_GCR_SWRSTC3BLK,
> +    NPCM8XX_GCR_TIPRSTCBLK,
> +    NPCM8XX_GCR_CORSTCBLK,
> +    /* 64 scratch pad registers start here. 0xe00 ~ 0xefc */
> +    NPCM8XX_GCR_SCRPAD_00       = 0xe00 / sizeof(uint32_t),
> +    /* 32 semaphore registers start here. 0xf00 ~ 0xf7c */
> +    NPCM8XX_GCR_GP_SEMFR_00     = 0xf00 / sizeof(uint32_t),

Alternatively:

        NPCM8XX_GCR_GP_SEMFR_31     = 0xf7c ...

> +    NPCM8XX_GCR_REGS_END        = 0xf80 / sizeof(uint32_t),

Then no need for NPCM8XX_GCR_REGS_END, we have NPCM8XX_GCR_NR_REGS.

> +};
> +
> +static const uint32_t npcm8xx_cold_reset_values[NPCM8XX_GCR_NR_REGS] = {
> +    [NPCM8XX_GCR_PDID]          = 0x04a35850,   /* Arbel A1 */
> +    [NPCM8XX_GCR_MISCPE]        = 0x0000ffff,
> +    [NPCM8XX_GCR_A35_MODE]      = 0xfff4ff30,
> +    [NPCM8XX_GCR_SPSWC]         = 0x00000003,
> +    [NPCM8XX_GCR_INTCR]         = 0x0010035e,
> +    [NPCM8XX_GCR_HIFCR]         = 0x0000004e,
> +    [NPCM8XX_GCR_SD2SUR1]       = 0xfdc80000,
> +    [NPCM8XX_GCR_SD2SUR2]       = 0x5200b130,
> +    [NPCM8XX_GCR_INTCR2]        = (1U << 19),   /* DDR initialized */
> +    [NPCM8XX_GCR_RESSR]         = 0x80000000,
> +    [NPCM8XX_GCR_DAVCLVLR]      = 0x5a00f3cf,
> +    [NPCM8XX_GCR_INTCR3]        = 0x5e001002,
> +    [NPCM8XX_GCR_VSRCR]         = 0x00004800,
> +    [NPCM8XX_GCR_SCRPAD]        = 0x00000008,
> +    [NPCM8XX_GCR_USB1PHYCTL]    = 0x034730e4,
> +    [NPCM8XX_GCR_USB2PHYCTL]    = 0x034730e4,
> +    [NPCM8XX_GCR_USB3PHYCTL]    = 0x034730e4,
> +    /* All 32 semaphores should be initialized to 1. */
> +    [NPCM8XX_GCR_GP_SEMFR_00...NPCM8XX_GCR_REGS_END - 1] = 0x00000001,

        [NPCM8XX_GCR_GP_SEMFR_00 ...
         NPCM8XX_GCR_GP_SEMFR_31] = 1;

> +};
> +
>   static uint64_t npcm_gcr_read(void *opaque, hwaddr offset, unsigned size)
>   {
>       uint32_t reg = offset / sizeof(uint32_t);
> @@ -263,6 +375,18 @@ static void npcm7xx_gcr_class_init(ObjectClass *klass, void *data)
>       c->cold_reset_values = npcm7xx_cold_reset_values;
>   }
>   
> +static void npcm8xx_gcr_class_init(ObjectClass *klass, void *data)
> +{
> +    NPCMGCRClass *c = NPCM_GCR_CLASS(klass);
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    QEMU_BUILD_BUG_ON(NPCM8XX_GCR_REGS_END > NPCM_GCR_MAX_NR_REGS);
> +    QEMU_BUILD_BUG_ON(NPCM8XX_GCR_REGS_END != NPCM8XX_GCR_NR_REGS);

Not sure these checks are useful, but as you prefer.

> +    dc->desc = "NPCM8xx System Global Control Registers";
> +    c->nr_regs = NPCM8XX_GCR_NR_REGS;
> +    c->cold_reset_values = npcm8xx_cold_reset_values;
> +}


> @@ -54,8 +54,9 @@
>    * Number of registers in our device state structure. Don't change this without
>    * incrementing the version_id in the vmstate.
>    */
> -#define NPCM_GCR_MAX_NR_REGS NPCM7XX_GCR_NR_REGS
> +#define NPCM_GCR_MAX_NR_REGS NPCM8XX_GCR_NR_REGS
>   #define NPCM7XX_GCR_NR_REGS (0x148 / sizeof(uint32_t))
> +#define NPCM8XX_GCR_NR_REGS (0xf80 / sizeof(uint32_t))
>   
>   typedef struct NPCMGCRState {
>       SysBusDevice parent;
> @@ -78,6 +79,7 @@ typedef struct NPCMGCRClass {
>   
>   #define TYPE_NPCM_GCR "npcm-gcr"
>   #define TYPE_NPCM7XX_GCR "npcm7xx-gcr"
> +#define TYPE_NPCM8XX_GCR "npcm8xx-gcr"
>   OBJECT_DECLARE_TYPE(NPCMGCRState, NPCMGCRClass, NPCM_GCR)
>   
>   #endif /* NPCM_GCR_H */


