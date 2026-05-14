Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEE3CD4F25
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNZWz-0001Tq-P8; Thu, 14 May 2026 13:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNZWx-0001TR-9D
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:07:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNZWv-0005Wr-HB
 for qemu-devel@nongnu.org; Thu, 14 May 2026 13:07:27 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so40720155e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2026 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778778444; x=1779383244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ynJUxiwZMXDrlWHLMI16YRWGtkhDsFSH198QrhKCWpQ=;
 b=y6WqcypzCOHfdmpcCogOM/fSYABtTBbuyv99NneLInEH/lK/+QJ5/eAPXhxJAN2HwP
 eV8B38yLJTDrba0A3NhZs+yrEc6zqfuFYBmMFR585YyTbX4lB1Z4RpHOakhWrwwlWR9B
 v+Qtjhgh8Uj1Dvttumvv7wTQJgtpcCgax5CZmAJ1YONpkzGM+xtHVPotIIL/+Yp1aMJq
 SM3Z+f+B6o7PzPLlLCqrKF7ylYZLzDbJqXMQRFHgdMnYH+mDj/5nkZkpiGYg6IJ+aE53
 jsLuJ6egcuQtn5Wy1vBJCFswlZzbN9xdxdCfCPTqDzF4NCM2nUW5nA1Y1MNWpYBwlFMu
 jQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778778444; x=1779383244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ynJUxiwZMXDrlWHLMI16YRWGtkhDsFSH198QrhKCWpQ=;
 b=NzDBmzv+OiWs/1nkkQaXCbv4MkXDUNOfz6Q/3vSc2TA+mPjLeFj+Ov4gPJwv+wm/ch
 hogJKuIK+9rgnqRnK1ARRr3z62m26ea+M4NM8MuAgkNm8CO9jahLw/R87ziMbo0RkINp
 f9hC7lvexgM4SiCzf4f92aoCe7R7L/GLdysUfJosrRL3wHQhFPnLRjB9Cu11hqmnTY8R
 Wy2pcTkJqzgtsFUyPzbuFJprtOq0zkmY6xpsnVefzbu78HtVqZYve+tREzUw7xjGSR0W
 B7AWPpdc1sFkK5oW2xIiQjZOdetwCE5CG250S31fleBEsWtaHkoUiLMyyrW0INtiX95f
 Pfgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ81Xu2JItBOsKqBBe+/37I6mE80SsgtoJ/n+1YUSqnKYJGrp5Tibfl/375hcKkzJId7U3zZorxBLbYz@nongnu.org
X-Gm-Message-State: AOJu0Ywwjh8V69/1OLzPPANv6X9jUiisZWtkZZemyWnEbiuezENtmJ3l
 8LB39xFknPrmR+EFPZQCgEQhhnMmNUOLw4EJ3/PtnfogR46dPapGRn2kf4Nrs5vuhuI=
X-Gm-Gg: Acq92OF1TU6K6mBlem/N4wetz5Me/5JrA8QNwJ/4Y7tB6mZMt+IreEN2S6vPRnzOOin
 y+HVI4ZbTTEIXjQlg8Du4C25Rfsp8Rsh8jEfuAoRP6UFdJ2AGYUCKHldqvm1NVib6SaqpssyXXb
 lW7siSlFWL+me8qUtm5k2ElOCm/FAz88FkNE4eZVQL2zxonUmdEnu/nLqGqOZbgsqJWe1pmH+ju
 Ef4EQtDou75+sazLkEdL7egL1t+okrahSxhnUlTUEpqgQVlLfbyokxcgseTD45H1cIwMVnGLKlP
 JCegFLW9fCDBmSbHZlAPA8qUcrXcEQQDrAeHLXYHT95v5OEWA2IiujrxIdscFNxqoeD1P9hUbxV
 QnuOqMMWbRUyRXbwR+yaRKBeazIgl1acQRsJ6YmR4elkOXRyx0l2WTgWeF5UIJflzwy7geU4JDA
 gB+9Wg4RaukYluuNbalHBkQ7u14oSLOX3LWphtwD7uNiMV1BHSA6MmWMNx15ub0K65+KX7ZnIdw
 nH+
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:c3f9 with SMTP id
 5b1f17b1804b1-48fe661df4dmr2519085e9.31.1778778443718; 
 Thu, 14 May 2026 10:07:23 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd76801f2sm29469375e9.7.2026.05.14.10.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 10:07:23 -0700 (PDT)
Message-ID: <98b867b8-a019-4fc3-be77-8320ae8c8737@linaro.org>
Date: Thu, 14 May 2026 19:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: misc: Implement Microchip mpfs ioscb PLLs and sysreg
 clock dividers
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, qemu-riscv@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>,
 Conor Dooley <conor.dooley@microchip.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>, qemu-devel@nongnu.org
References: <20260514-reference-overhand-749149e36a88@spud>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260514-reference-overhand-749149e36a88@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 14/5/26 17:23, Conor Dooley wrote:
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Minimal clock register configuration required to boot Linux
> without backtraces in the clock code.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> I added two more cases to the switch in mchp_pfsoc_sysreg compared to
> Guenter's patch, cos I still saw 2 backtraces with his patch applied.
> 
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Guenter Roeck <linux@roeck-us.net>
> CC: Alistair Francis <alistair.francis@wdc.com>
> CC: Sebastian Huber <sebastian.huber@embedded-brains.de>
> CC: qemu-riscv@nongnu.org
> CC: qemu-devel@nongnu.org
> ---
>   hw/misc/mchp_pfsoc_ioscb.c         | 47 +++++++++++++++++++++++++++++-
>   hw/misc/mchp_pfsoc_sysreg.c        | 12 ++++++++
>   include/hw/misc/mchp_pfsoc_ioscb.h |  2 ++
>   3 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/misc/mchp_pfsoc_ioscb.c b/hw/misc/mchp_pfsoc_ioscb.c
> index 05538d012a..1267d6ba4a 100644
> --- a/hw/misc/mchp_pfsoc_ioscb.c
> +++ b/hw/misc/mchp_pfsoc_ioscb.c
> @@ -53,6 +53,8 @@
>   #define IOSCB_MAILBOX_BASE          0x07020800
>   #define IOSCB_CFG_BASE              0x07080000
>   #define IOSCB_CCC_BASE              0x08000000
> +#define IOSCB_PLL_NW0_BASE          0x08100000
> +#define IOSCB_PLL_NW1_BASE          0x08200000
>   #define IOSCB_PLL_MSS_BASE          0x0E001000
>   #define IOSCB_CFM_MSS_BASE          0x0E002000
>   #define IOSCB_PLL_DDR_BASE          0x0E010000
> @@ -92,6 +94,16 @@ static const MemoryRegionOps mchp_pfsoc_dummy_ops = {
>   /* All PLL modules in IOSCB have the same register layout */
>   
>   #define PLL_CTRL    0x04
> +#define PLL_REF_FB  0x08
> +#define PLL_DIV_0_1 0x10
> +#define PLL_DIV_2_3 0x14
> +#define PLL_CTRL2   0x18
> +#define PLL_CAL     0x1c
> +#define PLL_PHADJ   0x20
> +#define SSCG_REG_0  0x24
> +#define SSCG_REG_1  0x28
> +#define SSCG_REG_2  0x2c
> +#define SSCG_REG_3  0x30
>   
>   static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
>                                       unsigned size)
> @@ -103,6 +115,22 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
>           /* PLL is locked */
>           val = BIT(25);
>           break;
> +    case PLL_DIV_0_1:
> +    case PLL_DIV_2_3:
> +        val = 0x01000100; /* return valid post divider values */
> +        break;
> +    case PLL_CTRL2:
> +        val = 0x00001110;
> +	break;
> +    case PLL_REF_FB:
> +        val = 0x00000100; /* RFDIV := 1 */
> +        break;
> +    case SSCG_REG_2:
> +        val = 0x00000001; /* INTIN := 1 */
> +	break;
> +    case PLL_PHADJ:
> +        val = 0x00000401;
> +	break;
>       default:
>           qemu_log_mask(LOG_UNIMP, "%s: unimplemented device read "
>                         "(size %d, offset 0x%" HWADDR_PRIx ")\n",
> @@ -113,9 +141,18 @@ static uint64_t mchp_pfsoc_pll_read(void *opaque, hwaddr offset,
>       return val;
>   }
>   
> +static void mchp_pfsoc_pll_write(void *opaque, hwaddr offset,
> +                                 uint64_t value, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: unimplemented device write "
> +                       "(size %d, value 0x%" PRIx64
> +                       ", offset 0x%" HWADDR_PRIx ")\n",
> +                       __func__, size, value, offset);
> +}
> +
>   static const MemoryRegionOps mchp_pfsoc_pll_ops = {
>       .read = mchp_pfsoc_pll_read,
> -    .write = mchp_pfsoc_dummy_write,
> +    .write = mchp_pfsoc_pll_write,
>       .endianness = DEVICE_LITTLE_ENDIAN,

Unrelated to this patch, this device model seems to lack
the .impl min/max = 4 fields initialized.

>   };

