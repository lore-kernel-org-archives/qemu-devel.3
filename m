Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6BA2CCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYh9-00083k-Dw; Thu, 30 Apr 2026 17:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIYh5-00082g-OX
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:13:13 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIYh3-0004Pb-32
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:13:11 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c7973bbc16dso823382a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 14:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777583587; x=1778188387; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7Nsai2albiqcEfbfQj2W4D9BBX02/q6qOSdrAAUtI0=;
 b=erhikneK7NHExU6tFZBYb/X+v04kkHiRR9kGWiKMLYQZ41K3I60/SK8/8biYrQVbMb
 9nF/G846Q5UgaY0KIjIIFIZq3mH0a15Dj2adVQrwqjwUARVSxdGr9vTKtrbKx6k2WREV
 qHf0qsI8awcOHBRLS33wx9P/KmMb+0BWzKQbrULmLZC2H6MUfH97mBFloQR1ddf6FfD9
 5ob5zkQ63T6F19roDepchvDxYJE+K6O+9F1ECi6/sRZjCvWFZUkDu8rs+AMG1cQgt8jl
 ZONraEZG/d1N6muIe9j2OrAN9bDhPLpa9C+zN9FPl3dKofjibW5Squeg5uPrRxQGenRM
 v57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777583587; x=1778188387;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m7Nsai2albiqcEfbfQj2W4D9BBX02/q6qOSdrAAUtI0=;
 b=hj/lbxvtJI8KSD36Os9i+Fed4kCMWPztDPHfZ0mdgvlCZRWw09nHQyIEtDjesjJCQh
 tFbtQzVRhHn3QwpaTNGEZ6YLxPQDMH7qV/O3dxjtTu/Pl7gfDKSxwnQES2w7/m6935Ai
 /7Hcy6ANaKbzVDYkmYjZwX1sOU3BFyxlAenkdZbK0Ar+fW26GTv57whfM9MK8kTlhyx9
 cIrMcaI2+AlYrFAZD1b9O2WtU80AMZ5bGmoN1LmjbHxO9kiC8LHaSyy96FD3O3vEpkXM
 f16TjTS/+F5C2iVhw7lkIB/EsfPOxzEfoM89Ti8uqw0ux+u7OexMlgCkhBTdG0b0pLPc
 +hfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jxKsEF8YLdNjBK8nNNWgnUKXeuSFf+N6RGaQIpQ4ZqtIF27Gvs0QJtQoFv9fhHCnRMU6dPY5PCK9u@nongnu.org
X-Gm-Message-State: AOJu0Yz4VbKMyjulyQokGm/06GDyBiXtLuHSL44i+0qxCRxsD6g7fOpE
 yCqkkDVk2bD2g2WppJjkpnm8VMrt8h3CNvd5wHrpWraGq0SOTt6k67DZW2eDwTIm/AdL5uptJY0
 0JDHp2I0=
X-Gm-Gg: AeBDieuJxWk8kBDyawV7dCb7kOzco3WogE4oJ5hTjsWulqHfqgZRuWf3w+a25dq1m0N
 KxIfH1ETmJZ6m37NY0BlgeLVgHWEAib6km29GL6ej8DcfHSEeHP7KiwBBNOEaiSh1nfMenJs7ss
 +CFk87vUh7rhq/4Z7vYlueFUmkH+sIKA6aU0NoO7bTbhRwG3n1W6m944RLuWLKDfSGPIRG0/+FF
 dLxAXiMjTRGvL8EWMqPG0KyNoqAE2+BHloq0guwlu0BJewsjhSk5zEOHW9gQkK02qglTHe/GcC9
 ONS+4NAlCkJfge7jtEl8z5dOvZp2zwBDkRtMK4HBK/BJxZPcBmPRWwiPMjh9fA7Rmg7Dy0Gnom1
 ofBWxZVDFGDr0K3hcUOhi7KQqP8T7wFBR+U6B4734zdPOara/Heng24l+wfWFTwdMDdYeyBkt8p
 L6BQHowNrDhdhULUrOEoVJWickQq+6C/+ShOYhlHm/CJmQkD2dULc1
X-Received: by 2002:a05:6a00:a15:b0:82c:21b8:4a1f with SMTP id
 d2e1a72fcca58-834fdb0ab80mr5270726b3a.5.1777583587009; 
 Thu, 30 Apr 2026 14:13:07 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83515b57d3fsm534729b3a.52.2026.04.30.14.13.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 14:13:06 -0700 (PDT)
Message-ID: <35b14bcb-b0b6-459b-83c9-7269ea7fbdef@linaro.org>
Date: Fri, 1 May 2026 07:13:01 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/40] fpu: Return struct from parts{64,128}_silence_nan
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-14-richard.henderson@linaro.org>
 <d4bcf6ae-f5bb-41fc-941e-4d43d3cf9e88@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <d4bcf6ae-f5bb-41fc-941e-4d43d3cf9e88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 4/30/26 15:55, Philippe Mathieu-Daudé wrote:
> On 30/4/26 02:04, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   fpu/softfloat.c                | 10 +++++-----
>>   fpu/softfloat-parts.c.inc      |  6 +++---
>>   fpu/softfloat-specialize.c.inc | 20 ++++++++++++++------
>>   3 files changed, 22 insertions(+), 14 deletions(-)
> 
> 
>> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-specialize.c.inc
>> index dd65432813..2723bf5e61 100644
>> --- a/fpu/softfloat-specialize.c.inc
>> +++ b/fpu/softfloat-specialize.c.inc
>> @@ -179,16 +179,24 @@ static uint64_t parts_silence_nan_frac(uint64_t frac, float_status 
>> *status)
>>       return frac;
>>   }
>> -static void parts64_silence_nan(FloatParts64 *p, float_status *status)
>> +static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
>> +                                        float_status *status)
>>   {
>> -    p->frac = parts_silence_nan_frac(p->frac, status);
>> -    p->cls = float_class_qnan;
>> +    FloatParts64 r = *p;
>> +
>> +    r.frac = parts_silence_nan_frac(r.frac, status);
>> +    r.cls = float_class_qnan;
>> +    return r;
>>   }
>> -static void parts128_silence_nan(FloatParts128 *p, float_status *status)
>> +static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
>> +                                          float_status *status)
>>   {
>> -    p->frac_hi = parts_silence_nan_frac(p->frac_hi, status);
>> -    p->cls = float_class_qnan;
>> +    FloatParts128 r = *p;
>> +
>> +    r.frac_hi = parts_silence_nan_frac(r.frac_hi, status);
>> +    r.cls = float_class_qnan;
>> +    return r;
>>   }
> 
> Why not use compound literal like the rest?
> 
>      static FloatParts64 parts64_silence_nan(const FloatParts64 *p,
>                                              float_status *status)
>      {
>          return (FloatParts64) {
>              .frac = parts_silence_nan_frac(p->frac, status),
>              .cls = float_class_qnan,
>          };
>      }
> 
>      static FloatParts128 parts128_silence_nan(const FloatParts128 *p,
>                                                float_status *status)
>      {
>          return (FloatParts128) {
>              .frac_hi = parts_silence_nan_frac(p->frac_hi, status),
>              .cls = float_class_qnan,
>          };
>      }
> 

We also need to copy the exponent, sign, and frac_lo for FloatParts128.  I thought it was 
easier to emulate the existing path and simply modify the two fields.


r~

