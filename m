Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05293CD13D2
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 21:31:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYy0-00047n-CE; Thu, 30 Apr 2026 17:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIYxy-00047F-W3
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:30:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIYxx-0000iu-BD
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 17:30:38 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82faf871346so901298b3a.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 14:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777584636; x=1778189436; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=utwwsTeUYHXPvezKnGNpZ1mjpJP8rrklKpEbhTVFZMs=;
 b=tmQeupCg3XlzGrsAH4ZoGfDbbhjwb7vNdQrn3FfDtG54ad7Tajkcabub1QGkPK2z07
 xOaqVhaP0cDrfnkG4d4PCXtIj+gD1140txBWOlQMwMkNsCbcx6YQMh9GztwpOI/8QfhA
 tPyb2IyHNYge+aHN5zPwLzzeOy6hTm2jEwVI0QcAHgBc1hhc2e/igihLvWjrl7ngnu7K
 LuiKa2m+8utpq6oxtHLcCXlGsqD+Zq8V9DEgp2e8aIKahAUwLAzDXf2G4ANreGsA3r3r
 MrYCJstJKRmrqt6vzUNaUsFDbP6HyKestXqU5Y6HAGlsoDga1pDYpdp4YiFBhyaNlt/O
 0SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777584636; x=1778189436;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utwwsTeUYHXPvezKnGNpZ1mjpJP8rrklKpEbhTVFZMs=;
 b=s9yFSdEZQ1AuWMVwvP3qZmmeIWvy9NPEwpOsm9r1PaptXb/viluEba9bHyICVlASO7
 Y1jqvXI47RasgBLcx+8O3NsWbaVk53RSpgceMYIa64ffFt5IqdZx8J23Xc5A3Xk9tk2s
 ANF4Px+e/o6gl7I/WdvBT9YZk1Yly6H4Q5nC4Z7HVXrwTxYYk4DJmuRlcnxwuJpBxlDn
 lblgCdlld7X4t3eHUPfQvWSTWHHvuzQHrlR/b6QMq5aDrvgkd2SLQd6cE/+f6V9qtaYn
 I5+dF6xpwmFxBqH0qJ3Lr/n6mPXRtK+5YUW1yebkwPeoyunfrIqZ/EN/XNA+gwAHPBbc
 RKHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/IbR3qDZsEZaoFYlTnEeowxspNQdXUtgCZm5RrpXL9FHYkRoPtcI1p3qOAMgiXkHo9V8BmUx/XrrlJ@nongnu.org
X-Gm-Message-State: AOJu0YyILjk3iSxOPD7u8d/cqTF2OOEgFmserVTN5pJTzO33zklDfhGn
 HHlhRVokYXtl4lO87H+wQZfUsDUFr2/ngiEiw6/lXMcG9gr3d1JLG2AToCcXbqmW51g=
X-Gm-Gg: AeBDievjGb/M/0MEEBYEiO4P1oUi9v9uLDGDHU8wL+wxmo+cyCcCeuJQ40BHRq4nCZN
 626EzCfbTmYFuByWCXCFuFN5aJNfeGR3U+ssZ2B6wm6isdgsqM8wa1kCQxswrEirdp+hF7GFdO1
 sofA70Xd70q670P0oPEl8C01YjJxK9vZ5JAXXDjHrfxuFhdthMH3iebw0RHrkq+YNzia8FApKin
 9FMANEBDUbeFTzKw7Ld+C7N8rnEaBngvIrJlYB3+Iw38GuL6JpHGNKOJ3t3MF8oMEtVgisZJENU
 LOI9nvz6QVILnqL3X+idOUvxCX+CWp4N+S6C84/+yH4ksJ2lMfrOkKOWzFkR/UpIfi9QCr9zUgg
 pS140U9mQRX9DO/odTzZvGKtok3rtMcjYaepWRpkJvgogy0yC2WC6YwGuzK/eENXV9E99iyPVbD
 +DL3qbaIdDGRJLGtxTiKL/Z6pcGJBfdDfrYytNtEwD76oCxRedpaZd
X-Received: by 2002:a05:6a00:3e02:b0:82f:8a29:e3e0 with SMTP id
 d2e1a72fcca58-834fdc670d2mr5486091b3a.42.1777584635558; 
 Thu, 30 Apr 2026 14:30:35 -0700 (PDT)
Received: from [192.168.10.140] ([180.233.125.15])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351587db67sm620423b3a.13.2026.04.30.14.30.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 14:30:35 -0700 (PDT)
Message-ID: <13b0fb09-c634-4cd6-8566-4142508cbd67@linaro.org>
Date: Fri, 1 May 2026 07:30:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/40] fpu: Return struct from parts{64,128}_muladd
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-27-richard.henderson@linaro.org>
 <9796771d-4d8f-44f9-ba8c-49f0c39a5a51@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <9796771d-4d8f-44f9-ba8c-49f0c39a5a51@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 4/30/26 15:17, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> On 30/4/26 02:05, Richard Henderson wrote:
>> At the same time, export.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   include/fpu/softfloat-parts.h |  9 ++++
>>   fpu/softfloat.c               | 83 +++++++++++++++++------------------
>>   fpu/softfloat-parts.c.inc     | 38 ++++++++--------
>>   3 files changed, 69 insertions(+), 61 deletions(-)
> 
> 
>> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
>> index 77465cce6e..09b79f8d44 100644
>> --- a/fpu/softfloat-parts.c.inc
>> +++ b/fpu/softfloat-parts.c.inc
>> @@ -679,9 +679,8 @@ static FloatPartsN *partsN(mul)(FloatPartsN *a, FloatPartsN *b,
>>    * Requires A and C extracted into a double-sized structure to provide the
>>    * extra space for the widening multiply.
>>    */
>> -static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>> -                                   FloatPartsN *c,
>> -                                   int flags, float_status *s)
>> +FloatPartsN partsN(muladd)(const FloatPartsN *a, const FloatPartsN *b,
>> +                           const FloatPartsN *c, int flags, float_status *s)
>>   {
>>       int ab_mask = float_cmask(a->cls) | float_cmask(b->cls);
>>       int c_mask = float_cmask(c->cls);
>> @@ -719,10 +718,13 @@ static FloatPartsN *partsN(muladd)(FloatPartsN *a, FloatPartsN *b,
>>           }
>>           /* Narrow with sticky bit, for proper rounding later. */
>> -        fracN(truncjam)(a, &p_widen);
>> -        a->sign = p_widen.sign;
>> -        a->exp = p_widen.exp;
>> -        return a;
>> +        FloatPartsN r = {
>> +            .sign = p_widen.sign,
>> +            .exp = p_widen.exp,
>> +            .cls = float_class_normal,
> 
> It would be clearer if the float_class_normal change start appearing
> during previous reorganizative patch:
> 
>             a->cls = float_class_normal;

Before, we proved that a->cls was anynorm, aka in { normal, denormal }, and we simply 
re-used that.  Here, we're initializing a new structure, so we have to put something, and 
I choose normal.  I really don't think it's clearer in the previous patch.


r~


