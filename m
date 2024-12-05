Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67464E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 17:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJG2S-00046Z-4g; Thu, 05 Dec 2024 12:53:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJG2M-00045t-1u
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:53:15 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJG2B-0002qR-A5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 12:53:06 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29e65257182so763162fac.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 09:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733421182; x=1734025982; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iC1owhw4u8rHdmSLqNP5QhlGPfLztqDhwTb6+8/D2/k=;
 b=CtlBYvJrI34wlfv5Qt9AQlKNb9S3vPPSanK6xMY29dxn/atPclgif2HrPxXaDY/W5R
 6IrEBQgTIwHpoZeO3/1QNECGfE5H2XnC+5mN4m6OlLEJibGAoCKEA4UMxKNOM9WC9Y+g
 tSGKi304eRf6+KRUKyBRk1ndwWaZ6DW/tLmAQyzT0mRCL+NflXkV1SmhQv8HoteoZIQ0
 3L2CTfD5gKg9G8Eebkfq8H4H132nCXZVVSM7fHJdjQDvYGA4aPWBjWuC48dp/aq9rXT8
 Q05fbfuQjbJ1kdV7a4eIZAv0tihmZ9sfxnPUH5FEKqYQ+nXNsp+yXiYkoohrZITBGvVU
 BFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733421182; x=1734025982;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iC1owhw4u8rHdmSLqNP5QhlGPfLztqDhwTb6+8/D2/k=;
 b=VvlhCUVh4Vjx+bmeJgbI2a3gfUO/MwxPsmGxNfvZ0mbbppFsaS5gycwn+NrhliwAQk
 p5EU+0U/NOeXe+O7VVw0B7uXemwaB2wNnTVTfcMaaCwoPJxFeNaiKhhL9uDx/elb1zvm
 nlGwNCqidH20KZoWjHJmTBE7SDNzl6T45thdRAVvqQABT2Gt7Fi4fDYe5CpuM+it/J26
 EsfXqCD0B399AvJZOwYZCyaF1OZqEJ8JuBnpDvUYsFmgsP1d2xcIZJXApG+NqdmIOTMM
 MeiUiofiE8EAyuXg6u+CJ+YoUUqWGJfbkxa3NP/ejIeNFZfKY7hDBlCeYoQ+9MMKSwU2
 9p9g==
X-Gm-Message-State: AOJu0YwOvU/6r6c4HXkrCORM/iyynuICu7Gptmtyby7W8yXXz/4NmR0A
 +PeUNjexDCGN82U0Ouh2blOuI391vq/eyyt4uArEx46Ip/zZo9FoG5LTVaPJVJ1egZf+2+7O/zX
 DTF1LYzcm
X-Gm-Gg: ASbGnctzTHt+3TKscgI0mWohVQA3ZByoKqATJYR73nB9pcLkgWVpxB+LKUiuCxCNplu
 MmWazak1O47Xv3umsyaw1gTmu1apuaA3dPJ8N1kp6nXvxsjrNe+KBTB4UxSU5mLF/jDQZF+Yv6V
 s13h5PXXhhenQesdmDwZTWHmxaZ4ZmTKoYU/s5Oqm6ZLUq5g7svArDj2p+0EjDq4RHFoEX5mGqB
 t9k3PQmNcaUwmBGrWqrtMOdrjxJp5zxy5Lo9VsIIHPmjbQN4Hp/ceYO6rteiaRIIVM5Nz4XIZ4b
 D8xrUQmF1LSYVfjMl6vneCs6YAEJ
X-Google-Smtp-Source: AGHT+IGQFjvNaaUb+F2DZRxShyp1AqlgSjF2aCSgv1A72qWYH3R2DZzAdPcIlWNTEgIiviwVS4MVoQ==
X-Received: by 2002:a05:6871:6011:b0:29e:547f:e1ec with SMTP id
 586e51a60fabf-29e888d6034mr12577519fac.41.1733421181930; 
 Thu, 05 Dec 2024 09:53:01 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f5675a94esm419173fac.22.2024.12.05.09.53.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 09:53:01 -0800 (PST)
Message-ID: <85606884-7677-4ada-9b24-d60abc5d9add@linaro.org>
Date: Thu, 5 Dec 2024 11:52:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] softfloat: Sink frac_cmp in parts_pick_nan until
 needed
From: Richard Henderson <richard.henderson@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-11-richard.henderson@linaro.org>
 <CAFEAcA9_HncJBCbEFb_804uZ0YCk18jz_9P54b74umWO8tPGSA@mail.gmail.com>
 <07fe05ac-4053-4efd-9dcd-0e1f101e0728@linaro.org>
Content-Language: en-US
In-Reply-To: <07fe05ac-4053-4efd-9dcd-0e1f101e0728@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 12/5/24 11:51, Richard Henderson wrote:
> On 12/5/24 07:48, Peter Maydell wrote:
>> On Tue, 3 Dec 2024 at 20:40, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> Move the fractional comparison to the end of the
>>> float_2nan_prop_x87 case.  This is not required for
>>> any other 2nan propagation rule.  Reorganize the
>>> x87 case itself to break out of the switch when the
>>> fractional comparison is not required.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>>> @@ -89,20 +84,24 @@ static FloatPartsN *partsN(pick_nan)(FloatPartsN *a, FloatPartsN *b,
>>>            * return the NaN with the positive sign bit (if any).
>>>            */
>>>           if (is_snan(a->cls)) {
>>> -            if (is_snan(b->cls)) {
>>> -                which = cmp > 0 ? 0 : 1;
>>> -            } else {
>>> +            if (!is_snan(b->cls)) {
>>>                   which = is_qnan(b->cls) ? 1 : 0;
>>> +                break;
>>>               }
>>>           } else if (is_qnan(a->cls)) {
>>>               if (is_snan(b->cls) || !is_qnan(b->cls)) {
>>
>> Pre-existing code, but isn't
>>     is_snan(X) || !is_qnan(X)
>> the same as
>>     !is_qnan(X)
>> ?
> 
> No, since X may not be a NaN at all.  We arrive in pick_nan knowing only that one operand 
> must be a NaN, but the other may be anything at all.

Alternately, and more, correctly, you're right.  :-}


r~

