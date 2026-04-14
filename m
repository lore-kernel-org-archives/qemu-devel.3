Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9050F9D0D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfHr-0001kL-K9; Tue, 14 Apr 2026 11:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCfHq-0001k5-Aa
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:02:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCfHn-0007kt-Jq
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:02:45 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso53663435e9.3
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 08:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776178957; x=1776783757; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tz/4vUIMP10DDMNiOy4QZPaEX12h2s2ROTRljbT+BTY=;
 b=CuyNUF8PMRSYPIGOTFGbyT+386HmIQu+dom6/hbbzOg14kaajmlsUrBUCUx2st9ygA
 IjSkdrvw+fRRPyXiHPHHbMXH3OfnbwWMCIbkPD05r0TxVb0p0q1mZs4XFUv3xGdd4EIg
 6/pDvrFLE3gaDjO9kl0VtdPK7ePVEIvN9DIOEcnma83oiV/323dCMbylWBIZj2zJJYSQ
 VAV/8gZfDwHSbmrLXX7hmy3GdSaMskVKL0l/EndBrcezQvmD7kouy2k8gPy6OD2UV6W8
 LDIxLOASZqttI7avMWrq+pGzz5JcSn5qvb2aM6tFhAPWUZNAPPw5NnIxd3Rd6y+FNydV
 bLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776178957; x=1776783757;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tz/4vUIMP10DDMNiOy4QZPaEX12h2s2ROTRljbT+BTY=;
 b=srkSv8je8nj6pinKKQTMxkBtpT3+FxAIWFrR9j8eIkEgNo5lz8DkRKAurXGRFeTYto
 LKdDdRPT5vhiDxNusrMZ6itQ1VqENWuhcq/Eu+uaSw8dmzSPigpXV0F1aq/X03iyvSB9
 rVVmqOT9Sbz2HTi3TwuT6TFVv7n/ZsHkgSIMnfrdn7XYRVBjdBz/fclL1wGvy06+4FOg
 +IFEu/GYpIOFE0nxNCRflAPFrZ4oPMeQEqPV/9MQR7KhArm7zA2dKUbd7V5Kkd3ffiwf
 usqC4IvOERh2cqSbZg2h1OxB++E3j6FjLMbZ/G7Uw6uwAqazpjh1jQAeC0wYKpsXmIQo
 8HNg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ulmAM4OLc7Tvhdq6uT3IhzLodgut3rZRc0+heiyRq0WOIk/Hmct3RRgsRgxLH+SNfjXJINaOLJOVB@nongnu.org
X-Gm-Message-State: AOJu0YywodZD4r3sOMFhM3+DSuFY95th91GkvhT+vVZb7Z6Qkm63QEo5
 RdtX7BDSjSH178rMCQJBCpadaYnoJbdTrGu8ll1mPYI0y8/jbRTKe/cwA15Qg8daoi8=
X-Gm-Gg: AeBDieta6mmVBShylT0ORrDb69cYp6pfqxd6I/RZOUXey2gMm8mTmiIIS6wvDxsqsIu
 K4BRtQRaiVJ5Gw2GoeOq5IeVDuj7IBjcgbZanhfKLbS1IAu1pkjP2VcFdqQQIrvQD3NiLrLLbYd
 NBUC1g+nM7BFlC3aUkdfV1JqmS6LHsbDHPza8CmOAzDUrw6YTwWlWjm6SGtT4nlMq4a4GXPpUNz
 6Wq84+LxjX7aPwPkNuwG3hn3RoUiF7h4AgsLnAFyS/k/YYH3oXtgoruLTRI+z91PoaZ+f8lQAfo
 JeHIB5GSztgye24yAxEUUwAilk8tmJ25YMNY/ytABGMCEMSiYp7oVcePAnMGqmMy24IwAtDRKQ/
 UgGu+9GWls+nazhN7a5Gd385XHnKUyqU9604tzOb1GHraHLhX70AsWkphKIbjznoxllTVCBTvQh
 VnDGGXaO3sDiL95KswW46HLGcOyJbdzo8YpAuQHGfud1NnDzGkM9Tu4iBXBdFlmSkbFqVpvwRuM
 gUB
X-Received: by 2002:a05:600c:46cb:b0:488:c51f:e04e with SMTP id
 5b1f17b1804b1-488d67f3a0fmr249223415e9.13.1776178956826; 
 Tue, 14 Apr 2026 08:02:36 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ee042ff9sm65430185e9.14.2026.04.14.08.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2026 08:02:35 -0700 (PDT)
Message-ID: <8d358e4b-d6a0-417f-b357-99a0ae06164e@linaro.org>
Date: Tue, 14 Apr 2026 17:02:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] hw/sd/sdcard: Add erase-blocks-as-zero option.
Content-Language: en-US
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org
References: <20260204-sdcard-performance-b4-v3-0-dc1cf172ee57@avm.de>
 <20260204-sdcard-performance-b4-v3-5-dc1cf172ee57@avm.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260204-sdcard-performance-b4-v3-5-dc1cf172ee57@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/2/26 14:22, Christian Speich wrote:
> Currently, erased blocks are filled with 0xFF. However SCR Bit 55
> (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
> them is wrong.
> 
> This patch does two things.
> 
> First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
> correctly reflect the content of erased blocks. We also increase the
> Product Revision (REV in CID) to indicate to the guest that
> DATA_STAT_AFTER_ERASE is now reliable.
> 
> Secondly, we introduce a erase-blocks-as-zero option, which allows the
> user to choose if erased blocks should contain 0xFF or 0x00. The default
> is still 0xFF to remain compatible with current users.
> 
> Signed-off-by: Christian Speich <c.speich@avm.de>
> ---
>   hw/sd/sd.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index c9cfd3620b563fbe7520cfe361e14b57cd8f7472..5ddaa08d77b6b7606005fb59f42f107d254d6e5c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -162,6 +162,7 @@ struct SDState {
>       /* Static properties */
>   
>       uint8_t spec_version;
> +    bool erase_blocks_as_zero;
>       uint64_t boot_part_size;
>       uint64_t rpmb_part_size;
>       BlockBackend *blk;
> @@ -439,6 +440,9 @@ static void sd_set_scr(SDState *sd)
>       sd->scr[0] |= 2;            /* Spec Version 2.00 or Version 3.0X */
>       sd->scr[1] = (2 << 4)       /* SDSC Card (Security Version 1.01) */
>                    | 0b0101;      /* 1-bit or 4-bit width bus modes */
> +    if (!sd->erase_blocks_as_zero) {
> +        sd->scr[1] |= (1 << 7); /* DATA_STAT_AFTER_ERASE: Erase produces 0xFF */
> +    }
>       sd->scr[2] = 0x00;          /* Extended Security is not supported. */
>       if (sd->spec_version >= SD_PHY_SPECv3_01_VERS) {
>           sd->scr[2] |= 1 << 7;   /* Spec Version 3.0X */
> @@ -456,7 +460,7 @@ static void sd_set_scr(SDState *sd)
>   #define MID     0xaa
>   #define OID     "XY"
>   #define PNM     "QEMU!"
> -#define PRV     0x01
> +#define PRV     0x02
>   #define MDT_YR  2006
>   #define MDT_MON 2
>   
> @@ -1363,7 +1367,12 @@ static void sd_erase(SDState *sd)
>       sd->erase_end = INVALID_ADDRESS;
>       sd->csd[14] |= 0x40;
>   
> -    memset(sd->data, 0xff, erase_len);
> +    if (sd->erase_blocks_as_zero) {
> +        memset(sd->data, 0x0, erase_len);
> +    } else {
> +        memset(sd->data, 0xFF, erase_len);
> +    }
> +
>       for (erase_addr = erase_start; erase_addr <= erase_end;
>            erase_addr += erase_len) {
>           if (sdsc) {
> @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, Error **errp)
>   
>   static const Property sdmmc_common_properties[] = {
>       DEFINE_PROP_DRIVE("drive", SDState, blk),
> +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, erase_blocks_as_zero,
> +                     false),
>   };

Keep it enabled for previous versions adding in hw/core/machine.c:

GlobalProperty hw_compat_11_0[] = {
     { "sdmmc-common", "erase-blocks-as-zero", "true" },
};

(Although I wonder about the PRV bit).

Otherwise LGTM.

