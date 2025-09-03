Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E680BCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 03:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uteZQ-0006XY-5a; Tue, 02 Sep 2025 23:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uteZO-0006We-4q
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 23:54:02 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uteZM-0001u0-Ag
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 23:54:01 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b0428b537e5so477929766b.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 20:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756871638; x=1757476438; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uXSMscX104pBZOYxRdYnHVuYi9kScN946ebruDS8RIc=;
 b=AE0d6oKfJQQsgW6TP3bay27QSjKfXG06o9mlnHw2zm/pLlqtRjgFxLG5A5P2JruRfo
 LrX90pM/ZxH/AZIdGfuZ7vDxjLVgfENbZilIQtmDcY1Un5YSVkvUg7tlj9Fz+68tuKlY
 A77uiGilSHr8cmQwKGy5hTIm1w+tUkGXWfDLJnVaR5wCIaqwbLqv3pVrdClTY3KH5GMU
 6Lkl5nUngyH32QQgL0f2OEk//KZCgEQSXOrrs5JrkFT26yCQzjNhhaQ+7BAIfGN2GkWf
 hxacBnaGPafRfYbI/zLAbUsVmuzptmNoV3PL7mgyGCsCIC5Ti8Vjy5sQ+oiZbD3lcZ8/
 Y+ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756871638; x=1757476438;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uXSMscX104pBZOYxRdYnHVuYi9kScN946ebruDS8RIc=;
 b=mdFcfmUoJt6IwLebbEpb0/vPXh7O9mg15vUFfag3ByYnxW2C5b4IsyCxz2WblL5mdM
 iVeVF1abF/fmhdkj45EOvOkJ4WKfMyFkLApCgZuIuAviHs0hO+eJE44P8Rmp6+LFX0Sx
 tubKSdLb5cQGGOP/UlL2y8QaRCdHPC/ghiGVM28qzQn9LFkNItVuMkwiYUcpl/azCC6b
 +suMEuDrOTAHtFlwNlhXfIM461orUTbTsfGuc/GqFbZQ+kTzB4/J5F1pO3CSoeosC3et
 pIjNuXxOldQZHKyCQ6jC723vWfne9yYRsDIjV+dKfka0Q9EceozgxO2CSscoZLMXmY+X
 ePhw==
X-Gm-Message-State: AOJu0Yz3xSXSLX+YVzpToSFBfrSNVeK/psLZZ/HCewyA3htCIq07wyl6
 txBeoiSVGWg2MM9ip+DaI7TD09QtvpVs4oZJYWGxG57iPFR3+WOFNUJy1KAEh7cDlHIABobXeS1
 HH3EiTeo=
X-Gm-Gg: ASbGncuvTfrhsHj/50xjCgPE3dITRY8SqJGF9b3uBqqeAi2PdOCMCbviU5v76qwxR7B
 cI7q7+Dhl2ll/LeI9AvwcG+au2uVGvEwf2cOtBO5aiFK/kRVX1LwGf8/mdwuXMKQYyrgoKXGPh3
 TTjrvEA22NRmkmlXY7dFVMMmyV8Heoe0xrE4MS7JDnB4XfIxkvx8oiXwTUGgrK0HUJyuMTj93Ze
 3DneUCi6yiv1UojzSmBwrGTic/75zTPKIEtGQjnDuzCh450xlkcke1Uo4o77ZQrIo4crJgivw38
 HVQfGacvuoFn2uz4cxRV4B4tqvqhOVqFLL6C3iT/A9Cuc1/pKnnvRTrwtveydSzpLDLkP2z1UR0
 PEDPA+jYfPyKPyhPdqjNaCIXBgmXqY7bNbqjsqhQCm/bNZKqUv0sIjLn85km9zvLcF4Dl+0Zcnm
 YIn7acdg==
X-Google-Smtp-Source: AGHT+IHE7mTNUrNd5xMhLcMZAzi5qIh4jeuVR4vfMao/YEPiq3rrdxf4+MUV3cwnKhAtHUJ0mstqsg==
X-Received: by 2002:a17:907:7f0a:b0:af9:68d5:118d with SMTP id
 a640c23a62f3a-b01d97b5ab2mr1392005166b.58.1756871638229; 
 Tue, 02 Sep 2025 20:53:58 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b02152cc1b8sm973960066b.36.2025.09.02.20.53.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 20:53:57 -0700 (PDT)
Message-ID: <b8462152-9b81-4013-9170-0dee8e6313ea@linaro.org>
Date: Wed, 3 Sep 2025 05:53:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/arm: use g_autofree for filename in arm_load_dtb
To: qemu-devel@nongnu.org
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250901125304.1047624-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x633.google.com
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

On 9/1/25 14:53, Alex Bennée wrote:
> The function has quite a number of exit cases so lets try and clean
> things up with g_autofree. As the fdt hasn't be allocated yet we can
> return directly from the fail point.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/arm/boot.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index d391cd01bb1..56fd13b9f7c 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -528,20 +528,18 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>       Error *err = NULL;
>   
>       if (binfo->dtb_filename) {
> -        char *filename;
> -        filename = qemu_find_file(QEMU_FILE_TYPE_DTB, binfo->dtb_filename);
> +        g_autofree char *filename = qemu_find_file(QEMU_FILE_TYPE_DTB,
> +                                                   binfo->dtb_filename);
>           if (!filename) {
>               fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_filename);
> -            goto fail;
> +            return -1;
>           }
>   
>           fdt = load_device_tree(filename, &size);
>           if (!fdt) {
>               fprintf(stderr, "Couldn't open dtb file %s\n", filename);
> -            g_free(filename);
>               goto fail;
>           }
> -        g_free(filename);
>       } else {
>           fdt = binfo->get_dtb(binfo, &size);
>           if (!fdt) {


