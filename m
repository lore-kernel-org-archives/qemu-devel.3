Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681C1CD13DA
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISz8-00024h-6k; Thu, 30 Apr 2026 11:07:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISz5-0001w2-T8
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:07:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wISz3-0001wd-KH
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:07:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso9553455e9.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 08:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777561640; x=1778166440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMUFq8AmuEOAXbtPYxSXrSwF78SMceSmi5y4QsYpfvA=;
 b=K7xI9N+ZFipMGxb6Rq1k1/tZG3l/5tO0GYxWiX2dr5n5klWFE/N5zCTMPdS0S0SuZF
 hmvesSvwMubp3tCHL2XRO4mHjY05X2Hx38gDd7LJhqMeIuaR71u2nhBV2oXdV+m9GC7R
 lK49dIasMD66OaGNiPCMe4Z2UtmWFI/biIwd9stQlZ/mkkflSS73oozoiaGURUEPkhhj
 FVXmf0ZPUx2il2/AKWGTUykIzo9CvF90uRD9w2zNQv21p2zrQZ0DQWktsMlrDw9+13VL
 2k45cmLfvz3qJdl3X2eO9r1/XuXe7rGMnmRX5n5CAARdOiy+7xu1gRRArIvUouEhgDrU
 /t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561640; x=1778166440;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yMUFq8AmuEOAXbtPYxSXrSwF78SMceSmi5y4QsYpfvA=;
 b=OexrYuH2a3yr0tSUEJQOCCEzulbm2pXlyfQe32XgizTOPWo3Gv9TEmkavDZZFn6p1r
 M48Th7YGIjAbKe7ICDmLOPUpVRO7ImFsvfIgrwJLKs1Onfg4A4DA9BYH4682RVZ9P7qF
 u9AB4Va8uxeXwsAiRe6QvPcrouUYbZ5Wsrp12lGe9pUK1tVw8FQ6DBYDWzKueZgO6SjZ
 8UdE6+LCEGR0FtZs06VmuoY1Yp4V/Lm0pWrLx8Fli0pYIhGRsTsV+/S8Rldam755V5E9
 pGsKEGWhg3uSAbxI5ID+fxaAMrXlg2Y2VfvDpPlyOPppedUvZZ3dD6rfunj16gIvcR7m
 Rthg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BnvgJwS3OlK1UU7/+tI3Q/B2VyXMF7dyHboMIOay2kT+fJxWgyt+0SW//kKMjqp+3QZt9cfwHFkLA@nongnu.org
X-Gm-Message-State: AOJu0YysagNPAHW2/oCK/kxvsscB84y6Dv5q624rqyuWLS653QBO5rLY
 7U/iynZpFOEwn0p4a0rjdrqaN7h5WWB9frbvTU72JQ1HZOnkKYBUbytXJTqQGxgci5I=
X-Gm-Gg: AeBDieuX5Je2Im1d9lRqsRwN3KXXbQTGFoH5IwBiap2CvyaweiHKD7qMVxDzXEof4JT
 u0eaUBEwfAAcam0ofr2wAPEIBvwHlwRX8ZVcwutN4PVwdZ4BnJdKI9WtDVN9wvwPiOqnmY983jt
 lv/52S1atII0FORfbZpC+4QrvZS9P2/THiTp5m7bj8tMRAQn9o7yY7PSGiSbMdxAG+IGCqNuEdH
 lxBTL86IWUK9R3LATwt+RYnIwnXBBydNCy0DoWH0amTmSBoNuRLBqubdTRdU36qL/ciSsHb4x42
 JhenbKy4xup7J7R0HrHC5Qnw0WPKHgJvLB6WkBy6svy1M4/tob8F06KyFliCBXD//cBkQN2FL6W
 QQhAFWV1NNhusN+f7hUPcoCboUzjXXwfvNqV7jTbWP1Vh3wVGN5SxYvshn+ZnM/tdyLoRvE9nuM
 cliZUqLMXA44OM2qU5YqUiZTR8JYlQz+rJyw/sTxd+0jxw16wKHnbD8wTxNuV3EZBjmDs7OeopJ
 cnZ
X-Received: by 2002:a05:600c:64cd:b0:487:243f:dc3e with SMTP id
 5b1f17b1804b1-48a83d6e17cmr60481705e9.6.1777561640055; 
 Thu, 30 Apr 2026 08:07:20 -0700 (PDT)
Received: from [192.168.69.232] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7b8ce444sm70012675e9.0.2026.04.30.08.07.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 08:07:17 -0700 (PDT)
Message-ID: <7e4ec7d1-51d2-4587-8c2a-c85c21f01713@linaro.org>
Date: Thu, 30 Apr 2026 17:07:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/40] fpu: Return struct from parts{64,128}_silence_nan
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260430000524.56046-1-richard.henderson@linaro.org>
 <20260430000524.56046-14-richard.henderson@linaro.org>
 <d4bcf6ae-f5bb-41fc-941e-4d43d3cf9e88@linaro.org>
In-Reply-To: <d4bcf6ae-f5bb-41fc-941e-4d43d3cf9e88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/4/26 07:55, Philippe Mathieu-Daudé wrote:
> On 30/4/26 02:04, Richard Henderson wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   fpu/softfloat.c                | 10 +++++-----
>>   fpu/softfloat-parts.c.inc      |  6 +++---
>>   fpu/softfloat-specialize.c.inc | 20 ++++++++++++++------
>>   3 files changed, 22 insertions(+), 14 deletions(-)
> 
> 
>> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat- 
>> specialize.c.inc
>> index dd65432813..2723bf5e61 100644
>> --- a/fpu/softfloat-specialize.c.inc
>> +++ b/fpu/softfloat-specialize.c.inc
>> @@ -179,16 +179,24 @@ static uint64_t parts_silence_nan_frac(uint64_t 
>> frac, float_status *status)
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

Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


