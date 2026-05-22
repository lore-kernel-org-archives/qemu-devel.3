Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C15CD5BB3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 18:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQUhq-0002XR-SN; Fri, 22 May 2026 14:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUhn-0002W4-45
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:34:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wQUhl-0001N0-J0
 for qemu-devel@nongnu.org; Fri, 22 May 2026 14:34:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ba6485d219so58804935ad.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779474880; x=1780079680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TlF2BebW9lGZY3igTqy4P2tedbTbEGuevX3gYEU6Yq8=;
 b=ZvMcFcTN74ECXFOaKzZCa8NKtTzMg1f6xgUohBqRaFVoaxJSEisNu4ipyImWw/rF1/
 i6cANkxGW7F0HPW9JZNA/qJtWp8Cz5m9Pt0K7hLLoDWxBFfBKFG7mnT9s0AWOa22eEpC
 Wu5TFowU4SciW111lkeLjZQarzInJVHax/VFgzHSJ/If2aenAZpz3Keo2QMvtB4zXcXS
 15hJCA3wWKtZoJxX5qe1gkjb3aTm6q1a+W50W5LruoICk4Le+AOjSfFyx5DjD6gZkbPZ
 YuhEtoQS6Y9WpKVdPp7HYyxTZxpZ38Cp7QXtJioewDypf8uFOUqEqmZmqmoJX64F6nmM
 ta1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779474880; x=1780079680;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TlF2BebW9lGZY3igTqy4P2tedbTbEGuevX3gYEU6Yq8=;
 b=pYCr9+yd5nZI7NLTrXUEvdsqSTiekV4wowU9/+qGgXp7/v/5ER0sJll3+FWN1yr/0B
 ZYuwNRwUz9bF0NtvffSRloOb/ex6Jr5rgb5FyRTRavOjxdv4rKMQUs2vU8S/XGxCnz+x
 MCjTffo9viPFM50sPd7EhP8bw3+KN+uzTv1Zblt3xSuj2oFr5mx9unNJ7dxIXowLxoTj
 tXQrPz1Engch2Ez7AFju53kh+moGMxzV2IiikY+ARiaikH/FVZagMo5wG2ee0UHx9ycR
 TPB1Mrlagtpe9eV7Acrh/ltxlySf/ubX5lpaBAjXXLx4AGt8HI9q/z6AOc+03U2f3hfo
 dP0Q==
X-Gm-Message-State: AOJu0YweXQaMlfMyNGzDC2qSqwcz1oe8hkrho+22N4P0Va21hFex0LdO
 VzRsYHLvWTCFSO1GZd61X7anGwK0SBsP0KoIc2VTW/lUyPcjAiPcYTytUGkdivlU8E8=
X-Gm-Gg: Acq92OEZ2yHRatgDPbkHKk4qD9Izv0DF5neOFXtsbyJSsYcoxPjFzUggE6IeheZxOlq
 s/nwTD2lKL2rdrkDEVwlPqX4FKF0Acz5xw2Eh7I7h0z0I+SbhAXIvqiWQ9vKp+oxa73lp3AhwEy
 b+dRxg8URIiwXfqO+XZETwYFYzZMV8mFFc5iVOiLgfSRCfL1jVS0qK8Arq3aGgwWo8YhYBYw8BT
 mg2vwytbhBg02z2/HfQWq/oVjBdgCM1afX9erQAKvG4oOoDOrZMEdH/LByg7TGuTFQJCiccEb+Y
 XFmTInzn5Sh+p/JQB0iJODh0oLE34y1k2xlJOiK/osS0izD3rQeLCt3rS7VndFNQpDbuFfKXa/O
 EKKsxIr7Ffpl30/yOJEqGK/lxOnNU63ts7p4vgHz3i0bVDL047ZQeuZgVTKspIqmnwIBpsVlPyQ
 dzk4YCQdppTucYeMCrUHp6TmU527xgwG1Bbg/howNM
X-Received: by 2002:a17:903:3c6d:b0:2b7:86be:7673 with SMTP id
 d9443c01a7336-2beb0366450mr51833775ad.6.1779474879582; 
 Fri, 22 May 2026 11:34:39 -0700 (PDT)
Received: from [192.168.64.111] ([50.78.183.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb591d102sm23030525ad.81.2026.05.22.11.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 11:34:39 -0700 (PDT)
Message-ID: <d19f76ef-487c-493c-8276-4526b7f96762@linaro.org>
Date: Fri, 22 May 2026 11:34:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/64] target/arm: Implement FEAT_FAMINMAX for AdvSIMD
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260520182213.872945-1-richard.henderson@linaro.org>
 <20260520182213.872945-3-richard.henderson@linaro.org>
 <CAFEAcA_F72LXF9kWVrU=mSt4=v19jRkDt9XkznpE+7DjVV94kw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_F72LXF9kWVrU=mSt4=v19jRkDt9XkznpE+7DjVV94kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/21/26 01:25, Peter Maydell wrote:
> On Wed, 20 May 2026 at 19:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
>> +/*
>> + * Use float_minmax_ismag to get the absolute value min/max.
>> + * Avoid float_minmax_is{num,number} so that we get normal NaN processing.
>> + * If the result is not a nan, take the absolute value.
>> + *
>> + * Note this operation squashes FZ, FIZ, and AH to 0.
>> + * Create a fresh status with default behaviour and propagate exceptions.
>> + */
>> +#define DO_FAMINMAX(NAME, TYPE, MIN)                                    \
>> +TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status *s)                     \
>> +{                                                                       \
>> +    float_status local = {};                                            \
>> +    arm_set_default_fp_behaviours(&local);                              \
> 
> This misses that we need to keep the default_nan_mode setting
> from 's', otherwise we stop honouring FPCR.DN. This will fix it:
> 
> --- a/target/arm/tcg/vec_helper64.c
> +++ b/target/arm/tcg/vec_helper64.c
> @@ -155,6 +155,7 @@ TYPE TYPE##_##NAME(TYPE a, TYPE b, float_status
> *s)                     \
>   {                                                                       \
>       float_status local = {};                                            \
>       arm_set_default_fp_behaviours(&local);                              \
> +    set_default_nan_mode(get_default_nan_mode(s), &local);              \
>       TYPE r = TYPE##_minmax(a, b, &local, MIN | float_minmax_ismag);     \
>       if (!TYPE##_is_any_nan(r)) {                                        \
>           r = TYPE##_abs(r);                                              \
> 
> (or we could go back to copying 's' into 'local').

I went back to copying s into local.  I should have known a blank slate was too good to be 
true.  :-)


r~

