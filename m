Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48EFC83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 15:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugPyD-0007lw-AY; Mon, 28 Jul 2025 11:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugPyA-0007SS-2h
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:40:54 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugPy6-0002SE-W7
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 11:40:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3b7823559a5so982027f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753717249; x=1754322049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=clWmwPIvlE/uJUsDm2T1onrs09ie61Lz/tDRVg0acxg=;
 b=YeG+ckthrlgntRVLf31/r4Cu1ZHIAFb5SeZ4xq0nqPenh8oL5u9IZn9b1zQQbN/1hC
 nGpv38os/KomAUBMY0bsX/WHzc67rr2Ku5Z+zTfkMl8LWE+u4e+s5ljV8iHEU5gHEPI/
 l2MmFfGFaS4T3BOEPzxr+blvHlqvo+KiJdsKrMU9ITRts4MfiZit8n6XHLLACXpCl11J
 ttClWP58SeQRG8dm2wIgkx/oE7BCxX/dzIkkRJsdL9nD79R3va3vwJ40WBjRa9f6KhSJ
 EJChuMAjI2fmZVBsO1LV7NP++YfMScIIKUX1Zs8xZmW1QawSzhPVwp/pujZSJFf0jcJd
 5s6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753717249; x=1754322049;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=clWmwPIvlE/uJUsDm2T1onrs09ie61Lz/tDRVg0acxg=;
 b=S9mGTnWjvZNDBx4xij/fbMkdYqHQ8P60IXNFKVDfz4xjcQmcAmKvUK+VAL5q31EJIN
 flpJ8gBtvJH2fwL3Var28/BDNbQ1bkS5fWVSvq4wLGy481gYoeGUm8GQl2eEJLqiG+DC
 XPjR5WAZQKRJOAMaLFJCp+h9hCfj9jS4yjy91e0ken2QTY0W+i2lV593draQhUKobEIf
 QSgc71o9ka66yL3xxYE/V1PLn0mnY4VaUMCAncpTRze+DB+KyHVYF73H9qrHb6vyfTNP
 U33K+BLPBPXHyGxUUR+/XL5w5FJVKzkhfG72cej1N2YusOQHzVBtJNgTLzMahAN4A36W
 Oqow==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2xe4tGfBu8UFSIlIrPL5NtD2hwz5snB9MczFeZ9stDxrenZykQRxVChDIrmdwktYOKylYqcndBhoN@nongnu.org
X-Gm-Message-State: AOJu0Yz7ZXe8clkXPi7eHtMY8yzTnEB+x6SL/fTxIm/BnFR/vwdi1MQm
 yH/r+Jkw30IeV1Xb1LowMGyU0cgEASO6fSrI4O4lMiUlPQha1H9O3fDW+Rd55YHyxSA=
X-Gm-Gg: ASbGncuLzfOgPFPUimK2BsyZiu9erI903TvxAsSv/V7TJ2bA/idqareI7wF1PbewT0n
 j2icM6a2s+rIPlJ+wXf0y05Ezaf60VGjMATyx1qCdQE5OEvRgcwp8dHfgbFLaPPsDR90l4fe3jF
 DckH0jdnlL1BaGvKQVExjCdSHnehUYROb6lkoIp/UWUM7YqrlvyElWjRv8cn+qPIMXwMGH5I9Xh
 iHAgcfQafhyugPNEi5Md17MFB5BP3M6vtIQjRztNb7gXgl/JLcD62V0ykq8LrD+It8q0r5LVUld
 c+IgUQLQBfpBTUE/uzZgk/KUwJwvWaW96mFJEH2NWopL897GclwvcZ2h6nE9vM2ldHpFsCV6AwB
 wI4kL9imhhv3kOsg8LkzRfV3dd0fkelycmDab/2yYUxbE4TNoQ593d+jjv5+6/d5fdQ==
X-Google-Smtp-Source: AGHT+IHPcE+k/WmwZbRhgKMu43FdnjtR/zsViUUtbcX7mSUgjIwP2DkUsMia7dQ6Ay9g8fMZ9l7uWA==
X-Received: by 2002:a05:6000:2382:b0:3b7:8d80:e382 with SMTP id
 ffacd0b85a97d-3b78d80ea5bmr318913f8f.4.1753717248896; 
 Mon, 28 Jul 2025 08:40:48 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78cf1f571sm739366f8f.22.2025.07.28.08.40.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 08:40:48 -0700 (PDT)
Message-ID: <1adc2441-3522-43d4-ae04-973a1cf66010@linaro.org>
Date: Mon, 28 Jul 2025 17:40:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/malta: Silence warning from ubsan
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20250728115152.187728-1-thuth@redhat.com>
 <43b37539-e4eb-465c-85e8-b7c83324910f@linaro.org>
Content-Language: en-US
In-Reply-To: <43b37539-e4eb-465c-85e8-b7c83324910f@linaro.org>
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

On 28/7/25 15:25, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 28/7/25 13:51, Thomas Huth wrote:
>> From: Thomas Huth <thuth@redhat.com>
>>
>> When compiling QEMU with --enable-ubsan there is a undefined behavior
>> warning when using the malta machine:
>>
>>   hw/mips/malta.c:1200:32: runtime error: addition of unsigned offset
>>    to 0x7fb620600000 overflowed to 0x7fb6205fffff
>>   SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior hw/mips/ 
>> malta.c:1200:32
>>
>> To fix the issue, check the bios_size whether we really loaded the
>> firmware before trying to byte-swap the instructions here.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   hw/mips/malta.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/mips/malta.c b/hw/mips/malta.c
>> index cbdbb210568..47dd4016cfd 100644
>> --- a/hw/mips/malta.c
>> +++ b/hw/mips/malta.c
>> @@ -1190,7 +1190,7 @@ void mips_malta_init(MachineState *machine)
>>            * In little endian mode the 32bit words in the bios are 
>> swapped,
>>            * a neat trick which allows bi-endian firmware.
>>            */
>> -        if (!TARGET_BIG_ENDIAN) {
>> +        if (!TARGET_BIG_ENDIAN && bios_size > 0) {
>>               uint32_t *end, *addr;
>>               const size_t swapsize = MIN(bios_size, 0x3e0000);
>>               addr = rom_ptr(FLASH_ADDRESS, swapsize);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

> 
> What about:
> 
> -- >8 --
> @@ -1180,7 +1180,7 @@ void mips_malta_init(MachineState *machine)
>               } else {
>                   bios_size = -1;
>               }
> -            if ((bios_size < 0 || bios_size > BIOS_SIZE) &&
> +            if ((bios_size <= 0 || bios_size > BIOS_SIZE) &&
>                   machine->firmware && !qtest_enabled()) {
>                   error_report("Could not load MIPS bios '%s'", machine- 
>  >firmware);
>                   exit(1);
> ---
> 
> ?


