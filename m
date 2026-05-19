Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE996CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 15:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPMXM-0002Tt-8P; Tue, 19 May 2026 11:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPMXK-0002TY-VP
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:39:14 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPMXJ-0004Cl-1T
 for qemu-devel@nongnu.org; Tue, 19 May 2026 11:39:14 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c80167f56cdso1656201a12.3
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779205151; x=1779809951; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2GX01AdvA2zAfcvhLJFZRVp3l+TaA6eSkbrN/UeZnNA=;
 b=VgnI/d0b16gWL1+591rp5tsgwQIj0kv1Vpt4XML6aaB2tTq9LRKxIzqV0YwExGBUFb
 ZqvJYJ6yRS091O0Vo+9Gj6UVm0wwRS+VZV4L/6wLFF0ffAeiB9X6GWzA2IeGVhtKF1uV
 ENQVCL014ugoTf/2OXXSbmAGeqHYMU51RsUm0s965gV1SVAdbBj6CHWi816QwkJ98rGz
 LLQseOaPfRDvoWtg5ddxzbYeSpPW8oCuBSYjOCHCY/2zTUcuV+IGJ3C+Doz9AjACAI2q
 Wczo4fV3fvVpxTxnyWvwXSdCrWymlaFa/hPbnrvpGbwNpO1abF2cN06YkPJID/rbASQs
 iR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779205151; x=1779809951;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2GX01AdvA2zAfcvhLJFZRVp3l+TaA6eSkbrN/UeZnNA=;
 b=JdhEgqZbjoQ4uDDemQwtziAei60TfZA8cdblVtYqop44RTtvVx15mGjURcJ/Z2U4Zt
 9mSGMWmSpqjr0sn9ewnOoDjI/UohKaCJGwgoMjdnQsb7jM1YlYjZYaXaU6Z85ZX6fU8l
 JQvdQHWLQrfKdv4zg9m99+g3L8qkMIUo5qf6J+5zUX+2ZH580rBfCqlu9tI/3ikq0dDr
 8z8nFI5jNo6lKws9q2YBtzZdUPVkutmCYPmBZT9R1MHv5ORTpEfvknKinNVvXnSQdEX9
 aLx47Z/8UZ3TPJimptxqvBJBtPsjHiQjUHWaNbq5slZ9DxOkvTKUYA7ggrQmRWZ7wXAv
 eHvw==
X-Gm-Message-State: AOJu0Yxfcw0ilO2KTcT+WOcK8fpxrBc3VQTYJYhH/8ExMkIMB/0SpHb3
 P9f1SZ4qoRoD7D1vEmErEcU0H9Rjk3gkjMS7fBubqJkwbu0slwSa+lphgw3RnVzJ/ZI=
X-Gm-Gg: Acq92OHp9elw5EJfQ44XRnc68N9RnP3dwPl1CcMFZSSFWKgbKJoBl+tbIwj1reQgxdc
 0+2n2ekkawy9nQRu0oyd74BsBQ4sUzTWKOPK+J9G0R2u3vn2pJZPINVsKfWoCEcXxSEr4arjIWF
 0MMXYy8a91FwXRKQoiz9YkZ91lnMpzl3HUwmGhVGKtWqGrc+tI+9DgI33ndFV88WGjwf3Ll9tJH
 LGKf8TbNIih/VNzK5Y8giidDfHmzbj9+Wn1h3+8DjTOR/8kpampqQ16GdYBy/cKzo672OSxqkYM
 wwrAdaFtj1hiSnvVWZOF8smS7nrIgoGWn792XX7uu4rip4Q4AFyFwYLxAQsc7pLlB+OpRvjVM4k
 pG4PZUc1g/iRl9u5NuBneH5wFcamrnsXfwiSxz8ajWS2gaYTWxOHexKSq5dKQ2iftB20IQjGW/D
 vxc2YI9BVOaYlIRO+GAeMbmX3Rcqu02ROwEttW
X-Received: by 2002:a05:6a20:6716:b0:3b2:a809:ff7 with SMTP id
 adf61e73a8af0-3b2a8093e2amr5553849637.10.1779205151002; 
 Tue, 19 May 2026 08:39:11 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82bb07d2fesm16938614a12.9.2026.05.19.08.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 08:39:10 -0700 (PDT)
Message-ID: <e8df74d9-6744-4ba8-bf40-d348d2c073e5@linaro.org>
Date: Tue, 19 May 2026 08:39:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/12] fpu: Saturate the exponent in uncanon_normal
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-12-richard.henderson@linaro.org>
 <CAFEAcA9ni3_c83Ex+Oc73yTxvUm2GkF=CFcqf5gv4VhD3uTJ2A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9ni3_c83Ex+Oc73yTxvUm2GkF=CFcqf5gv4VhD3uTJ2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/19/26 02:57, Peter Maydell wrote:
> On Sun, 17 May 2026 at 01:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Notice the conflict between saturation and rebias_overflow,
>> which should never happen.  Otherwise, saturate to INT32_MAX
>> and allow the usual overflow to max, infinity, or dnan.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   fpu/softfloat-parts.c.inc | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/fpu/softfloat-parts.c.inc b/fpu/softfloat-parts.c.inc
>> index 45606f8402..914e588ec8 100644
>> --- a/fpu/softfloat-parts.c.inc
>> +++ b/fpu/softfloat-parts.c.inc
>> @@ -341,7 +341,17 @@ static void partsN(uncanon_normal)(FloatPartsN *p, float_status *s,
>>           g_assert_not_reached();
>>       }
>>
>> -    exp = p->exp + fmt->exp_bias;
>> +    /* Because exp_bias is positive, we can only overflow past INT_MAX. */
>> +    if (sadd32_overflow(p->exp, fmt->exp_bias, &exp)) {
>> +        /*
>> +         * rebias_overflow wants to compute a modulo exponent, which
>> +         * conflicts with saturation.  That said, saturation can only
>> +         * happen with scalbn, which is not a PowerPC operation.
>> +         */
>> +        assert(!s->rebias_overflow);
>> +        exp = INT32_MAX;
> 
> As mentioned in the review comment on one of the Arm patches,
> I think that if we set exp to INT32_MAX here then the
> "round up" code below can increment it, overflowing to INT_MIN,
> and then we won't correctly spot that it is too large for the format.

Right-o.  I'm going to drop this one and constrain exp during scalbn et al to something 
smaller than INT32_{MIN,MAX}, so that we don't have to consider overflow everywhere.


r~

