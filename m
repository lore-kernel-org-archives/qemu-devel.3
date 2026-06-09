Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC7ACD98C5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:51:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWyit-000348-3z; Tue, 09 Jun 2026 11:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWyir-00033D-GN
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:50:37 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wWyip-0006jz-FI
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:50:37 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2bf2e8ccca1so40784625ad.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781020234; x=1781625034; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UmyYVA71jlMvI5AczbEHaGsMbq3mgwjXxuff5ch/snc=;
 b=Q4MD2xKgIg5Nf0nBnNfEGF5HwePAoJNVgQkGV2tJdXU4UiAWWcFt4upm7x0vsAEBW7
 78r0D9kKaLOZEkqXQ/GlD4eEs6vbslpniO2vSN/ctLGM7Zukzb0IojZmo33o7ao8biIA
 nk3c0ioWTqf4DG6ZMHCqfaaF2N6T2qYYifP965jygsOpsS8v40bLVx6XqjZtDObBQBS/
 8Y90V+iKhRKHyUG/bYUs6kV+y6+B95OzP7lNkR3CieG6cWjuoIrLr3n5wOTrs92cfRYl
 N0dVjvIUcCLsF1tSyGaKB+oF82nNX8IpN+QkqOJw8+ZQN8COkbESGCuL/ntVBuy6e/xs
 wNLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020234; x=1781625034;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UmyYVA71jlMvI5AczbEHaGsMbq3mgwjXxuff5ch/snc=;
 b=dySgpAC4o83fqqzPdBrw9lSwQmd11xjsy0xfWLUnpQYqQj6LYat9vDoou0YIwKqQdn
 6QkBVivTZdkGkrbsgfkUNxzvmJ+yewSXM7nMfOs87jf0A5v08CZAI+FYmZZimf8ZRNw9
 W2XBx5UYeikmwwXw3sz5Nyalt+xFuZ1VS/swX43l9Hu4zobOf4UypfosKFZkvII4VpNT
 LmB11gCVWHSa3gDNeet8oSKR31dSbBgfkEqMn5qb+CEmeHMDg739pcGxpmlKSC8uu83D
 IBQEUQ9WpUUkmMvWXX4+896R4Bcl/FGrtsTfcK0goTSHrYl6KpO6met72nI35UDiLGdK
 drNA==
X-Gm-Message-State: AOJu0Yyp3HA+AXzfw3qjUsxagEXPQcNfWXj9L6L3d8gERlo7YSGpGXty
 G1fYuiEZ90jnaUapf44QThesYraweG+1zdXym7g6ERKUHP7naYfS0N89Sci/sj3BxBc=
X-Gm-Gg: Acq92OEFeT18NkaXmyZnXbWxJBmddWHfnpiz96+9vdDK6kyAaM7beD/+QNLpidd2R+N
 DDhEElYKUhOvlTiVdAEgqaqtojnFBUqXRynD4uz5FJhtWMW4nvSd/evdXFRXfX5zn4SXMIkBG4i
 iR+cFc60xDA7FWauSTUr26Nto5x08OjQdSHV0iI8Ivlgt6Kf0/3YcgvMdWoI9jjFjXY+UdJF6lZ
 kFpb0VGTic5MFsWMqSHycJ/BofmmTo3TMgIky9st+i0BnPAaQJH6o9AFhmO0GasdsRYfLFkRzk/
 FaWoE+W6vSYfyZgifUrYni4WuxIghUKgEKIJPFHsO4EuPLnskv6rDmpgsyiBWXbkQVcECW+GFBb
 gnDOVqyyS13l/btbXlFXXVoIS7uNvLxvpAjrlaGov7RPTLWmjUoW1zPbMqhCejQ1XB7xsHRIb0t
 7GtjjGbV9thQa5l9PTcN2ay55TZpamUa1D7LQKChuv345Po0pmEswNkdcbXQ==
X-Received: by 2002:a17:903:3888:b0:2bd:606d:b339 with SMTP id
 d9443c01a7336-2c1e80ec394mr259498595ad.21.1781020233738; 
 Tue, 09 Jun 2026 08:50:33 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c16649fcdfsm284087845ad.78.2026.06.09.08.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2026 08:50:33 -0700 (PDT)
Message-ID: <c2ef2ce8-5c4a-4b8a-8928-b08058bdc8e4@linaro.org>
Date: Tue, 9 Jun 2026 08:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/45] target/arm: Use FloatParts64 in f16_dotadd
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
 <20260603032855.106930-4-richard.henderson@linaro.org>
 <CAFEAcA_jORCuOnt4oh_JB7ZdqmZeo2yjYwssoT+-3D8K8P1DEQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_jORCuOnt4oh_JB7ZdqmZeo2yjYwssoT+-3D8K8P1DEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 6/9/26 08:23, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 04:29, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Use softfloat-parts.h so that we can more naturally
>> perform the required operations witha single rounding step.
>> This happens to also simplify the NaN detection step.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Message-Id: <20260517002550.321291-11-richard.henderson@linaro.org>
>> ---
> 
>> diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
>> index 376fbd48d4..7ef6f5d71b 100644
>> --- a/target/arm/tcg/sme_helper.c
>> +++ b/target/arm/tcg/sme_helper.c
>> @@ -27,6 +27,7 @@
>>   #include "accel/tcg/helper-retaddr.h"
>>   #include "qemu/int128.h"
>>   #include "fpu/softfloat.h"
>> +#include "fpu/softfloat-parts.h"
>>   #include "vec_internal.h"
>>   #include "sve_ldst_internal.h"
>>       } else {
>> -        float64 e1r = float16_to_float64(h1r, true, s_f16);
>> -        float64 e1c = float16_to_float64(h1c, true, s_f16);
>> -        float64 e2r = float16_to_float64(h2r, true, s_f16);
>> -        float64 e2c = float16_to_float64(h2c, true, s_f16);
>> -        float64 t64;
>> -
>>           /*
>>            * The ARM pseudocode function FPDot performs both multiplies
>> -         * and the add with a single rounding operation.  Emulate this
>> -         * by performing the first multiply in round-to-odd, then doing
>> -         * the second multiply as fused multiply-add, and rounding to
>> -         * float32 all in one step.
>> +         * and the add with a single rounding operation.
>>            */
>> -        t64 = float64_mul(e1r, e2r, s_odd);
>> -        t64 = float64r32_muladd(e1c, e2c, t64, 0, s_std);
>> +        FloatParts64 tmp = parts64_mul(&p1r, &p2r, s_std);
>> +        tmp = parts64_muladd(&p1c, &p2c, &tmp, 0, s_std);
> 
> This change results in our incorrectly reporting an input-denormal-used
> exception when FPCR.AH=1 and some of the halfprec inputs are denormal.
> (For AH=1 we are supposed to set IDC for input-denormal-used only for
> single and double precision inputs, not for halfprec. We achieve that by
> having vfp_get_fpsr_from_host() mask out the input_denormal_used flag
> from FPST_STD_F16.)

Oh, right.

> 
> I think this worked previously because we did a float_to_float
> conversion using the f16 status (float_to_float consumes an
> input denormal, which we don't report because we use the f16
> status), and any f16 denormal is not a denormal in f64 and
> so the 64-bit ops never see an input denormal, so using s_std
> wasn't a problem ? 

That sounds right.

> (Also, for the operation using s_odd that
> is a copy of an fp_status so any exception flags set there
> never get copied back to the live version. Presumably we
> relied on it never being able to generate an exception?)

I didn't think we were relying on that, only avoiding swapping rounding mode for each 
vector element.

> I think it doesn't matter whether we use s_std or s_f16
> in the final round-and-pack step, because the only differences
> between the F16 and normal fpstatus are to do with input
> denormals (separate flush-to-zero control, and different
> denormal-consumed reporting), and that happens in the
> "unpack" and "do operation" steps; nothing cares in "pack".
> I went with s_f16 because we usually do the whole
> "unpack; operation; pack" sequence with a single fp status.

Yep, thanks.


r~

