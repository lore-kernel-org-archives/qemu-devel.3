Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B5C28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trHBp-0005Nl-1w; Sun, 09 Mar 2025 09:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trHBc-0005KF-Dt
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:59:26 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trHBZ-0004n5-Cc
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:59:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso605212f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741528759; x=1742133559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eEye8vaZimNT5jRX+iC386YXLN7uRDLdkTdEWySggws=;
 b=csXMd/pUWRptVqnM6kGWh5kz1KsEp8cYSRoNajWL4mQtLDCr2utAqH8ohi4E7tJ5dZ
 AehF0dRniA/oUKXsIG3NWR989mGa7RrX5Ts7nbqnL4KrB9UgVthxVk9ZOo5Sq+TsHZFA
 AScB/chz0NMyLMvp5ChhcKBN28HdsWO66+qHCr9FHc1Cp+jdzgonOSq938Lu6X8n6Tm4
 DKq2OFpfRstPbDWyc31C5H6garWDYza4gIdeCnezcbuZ/G3F70Vo7YLRc6OARzK+tBET
 Wbf0lHLojsw9p1uhSP3Ui5ggwZ5m4yCpD/3a0uBesxpdubfqXS+35SathU6uLssCAuDx
 LegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741528759; x=1742133559;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eEye8vaZimNT5jRX+iC386YXLN7uRDLdkTdEWySggws=;
 b=ZfCBHouQ++ZBGL7wWl30Q/mvOoCrcLOs2oy1C9l0wAujEH0UQPaAgGRJUG9iubVm8n
 9VXe6DGcybeWl2zhcY1nK9oSyqmwt+VYHstU85F9jZB2KJWSs2a25zwEQf9FRoMIrv2X
 TtCg4R6y05ksbqTqHT9ibw47UFSxsnIuZl1Grus9lSFaCs7gpFCfXHd3Ur2Nx4XFl+4X
 OiMbp32jWfb0cwhNrtXoDQdCzq9cRXuAiFLah5JMq+D8VEz4FYpldWeaMlQxg/JOBb+D
 4ri9xAOlwCYQjEm9nhlFCZGpdd2nj3SQxbCS1lDGL0mdS84uP805Vp+8Q2boKDOnD5Xm
 cTGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzMw+R7ewGn8wTK0236jlb44lKp3QiP/UvzvTu+VxUJhk7hmZTNHvaZ+64sopx2xfh3DbPIgNBFBpp@nongnu.org
X-Gm-Message-State: AOJu0Yw3NHO/cOks7JAly9A6Dgbnvv0wtLt4NMzxavsGeTIl8SuaWg9o
 UgQzigXCQ8R3QX93mqkU+ji2p5avPglAT7nMHhXt66kteFWNL1JjJO/btsmMLkM=
X-Gm-Gg: ASbGncsNrAgIXaCSdDlWsnvLpMyq7voX7b2ooU6ogIlbuRI9gFyXaMeZ/N+3x+k59dX
 jZDn1NHDZOgZjzlUHWu3kEaQW9Oazx2SDMkkAkZOghDVEggB9R15XwseX/J46/dpXmFx+4r7pGQ
 599tSmzgk+ThPuOyOrGUM7wvnG6IBd0dnpZg3pi4265AXAecNl1l05Eu54FSJxd67+ZiWbISia+
 euC8WrEAwivpP78Z3D4M/oZiRJAC/grzA6IqxGHaTXx1Ciy2Zq5/Wuq9NOrj8nobGdrrfYFLdOz
 ztILSacIFYUsCcKAeliWgzZkLKxJ1a+Wbhg9u1jxr71lnuemeVSPbdmjg4MucR98o049KodfYpO
 c+YN+gH5FvcJVw/7Ng2y3Fd0=
X-Google-Smtp-Source: AGHT+IFkFNZPwZREw8TrMPksQhlQ5osUnxIpHSE8WUWEIUi2RHjtnwRZr0PyxLkGR/lMXB7ovfsuqw==
X-Received: by 2002:a05:6000:1567:b0:391:1199:22b5 with SMTP id
 ffacd0b85a97d-3913aeeee27mr3360514f8f.10.1741528759090; 
 Sun, 09 Mar 2025 06:59:19 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdfbb4sm12143142f8f.30.2025.03.09.06.59.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 06:59:18 -0700 (PDT)
Message-ID: <72466d9b-7395-4253-b4e9-de551afb05ac@linaro.org>
Date: Sun, 9 Mar 2025 14:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/14] hw/ppc/e500: Replace generic SDHCI by Freescale
 eSDHC
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-15-philmd@linaro.org>
 <6C65764B-E579-4361-94B5-5D217363AC05@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <6C65764B-E579-4361-94B5-5D217363AC05@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 9/3/25 09:31, Bernhard Beschow wrote:
> 
> 
> Am 8. März 2025 21:36:40 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>> As Zoltan reported, some U-Boot versions seem to expect
>> correctly initialized registers before expecting interrupts.
>>
>> Now than we have a proper Freescale eSDHC implementation,
>> use it.
>>
>> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/ppc/e500.c | 10 +---------
>> 1 file changed, 1 insertion(+), 9 deletions(-)
>>
>> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
>> index e85e000f054..7d15c926887 100644
>> --- a/hw/ppc/e500.c
>> +++ b/hw/ppc/e500.c
>> @@ -1027,20 +1027,12 @@ void ppce500_init(MachineState *machine)
>>
>>      /* eSDHC */
>>      if (pmc->has_esdhc) {
>> -        dev = qdev_new(TYPE_UNIMPLEMENTED_DEVICE);
> 
> "hw/misc/unimp.h" include is now unused and should therefore be removed.

Good catch.

> 
> With that fixed:
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>

Thanks!

