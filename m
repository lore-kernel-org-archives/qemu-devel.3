Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A01E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcoa-0000bO-9c; Fri, 06 Dec 2024 13:12:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJcoW-0000ac-3o
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:12:28 -0500
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tJcoT-0005HP-SC
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:12:27 -0500
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-29e644b3f6fso802615fac.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508744; x=1734113544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k6E3qAVznoEijWOtVEbkazIWLn1pMfIIPzCq5oKqgnE=;
 b=LDn2SldMQZ7VAle14DHmNymceOipgUaq1xrk0AWP2RNMz1bFekEo9854476DUfMJIa
 v2jhGF+6cbP3NUMI5TvozbcVQH/AkNGd3c8UPeCXLbMZ+lMznva7Ryy+v+68yix9udy6
 dm5Z6VzDZClSpcQ3XHeQI+BOHT8O0sWJzZ3uWwKDaWYCDB0GeBFailASr6dJAJVtKAoR
 oIvDxNIdJ4Xy3vsQRnKrUQbp7h15KlUbVXLL63ixbl8+SGiIRvlOdlLOFLBf0wYWfQU7
 w86RuTePRxUOFrw35+adHv39VYbdURroCFDVdderUIvP9x2cwTk7eaUADZECaslP+uPR
 lBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508744; x=1734113544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k6E3qAVznoEijWOtVEbkazIWLn1pMfIIPzCq5oKqgnE=;
 b=meZVdwX87AZ6XcZitpltS9d6cCGT5MNY4MIEHY6sY4AuFfV7dHPN13VbvgtX0tEsdP
 UuB4LSO9yd1P1hCWnXf4eO2x3+txI7YWszmkq+eatAVaZ8kD3LTNNhGPpfpOD3r4oBng
 qoiIHp9nJw56FQKILwkOaQzBdnN69AbWv71b+WtpDMZcuUHXysm/IvEXiIOrmleIg9Xa
 LiDhqR06kYZyWYfMpaNrOiEcogvPDj0a3XB8wgKZWgTQuMLOe2YtotxamXsZ8KjOdMvT
 QySoVIDwDTvSU+qIyf7n1OxJZGCZfpNqwL54VbuZ9Yuqolll/MBNqoInvhb+VQ17Fr/J
 77nA==
X-Gm-Message-State: AOJu0YwNr1HPbgvy4nT0ew1GoS3/rUm1R8N2x9xHqXk6JqhLRtO/4iFF
 9E2x9zy9H9Hp5NLoeX5oj3961G8WXeLt+Mb7d6aWhd2z0nWQAKfm0oi6zE311Ls=
X-Gm-Gg: ASbGnctA8iRYJdZTWd9REjp3EwyNsuegYOF4uLGpSHuhWSCXWsLntjEZIanlR2HeK24
 JsoDHeWlVL97ebo5Fz/VV8tiQDx1ecs92dxe8hF+UCVbMWg89/mSgYmP6CtLCT9LOAfxNkZGOnP
 CVWn7EVMYBAEgd1FzxFr4e3vaDtGWfDXmD2jqYKcSc8FAs2osSJOAvzK2pzyFNJ3DgsU2Ctf20v
 x4c1Gex8nX82/jUc+3HIfiZPJqCZFwKngJH+NFN+rCc/Luajh2KzYlkTCoo0hhRiKyEND+2VUPD
 yfP1gypu9Mqsj5sp0H2tfvG7mhOI
X-Google-Smtp-Source: AGHT+IFfjJ4/LZ/I5ExUcZkDq+WamA6wf74XMg/09IWvUzInSgYd/uOyQFwMNGIzZIykpK4Vvt3Lpg==
X-Received: by 2002:a05:6870:7e16:b0:29e:76d1:db3b with SMTP id
 586e51a60fabf-29f731b3772mr2283492fac.5.1733508742792; 
 Fri, 06 Dec 2024 10:12:22 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29f787f90d7sm452912fac.31.2024.12.06.10.12.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2024 10:12:22 -0800 (PST)
Message-ID: <9afbb53a-ab5a-44c4-b486-b947b7c3429e@linaro.org>
Date: Fri, 6 Dec 2024 12:12:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 55/67] target/arm: Convert FCVT* (vector, integer) scalar
 to decodetree
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-56-richard.henderson@linaro.org>
 <CAFEAcA8GO=NjWpoOM7mG5j-+4JXfx5qEK1_YwQHNmuFt3yH=Ag@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA8GO=NjWpoOM7mG5j-+4JXfx5qEK1_YwQHNmuFt3yH=Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

On 12/6/24 10:23, Peter Maydell wrote:
> On Sun, 1 Dec 2024 at 15:21, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Arm silliness with naming, the scalar insns described
>> as part of the vector instructions, as separate from
>> the "regular" scalar insns which output to general registers.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/tcg/translate-a64.c | 135 ++++++++++++++-------------------
>>   target/arm/tcg/a64.decode      |  30 ++++++++
>>   2 files changed, 87 insertions(+), 78 deletions(-)
>>
>> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
>> index 98a42feb7d..ad245f2c26 100644
>> --- a/target/arm/tcg/translate-a64.c
>> +++ b/target/arm/tcg/translate-a64.c
>> @@ -8678,6 +8678,16 @@ static void do_fcvt_scalar(DisasContext *s, MemOp out, MemOp esz,
>>                                    tcg_shift, tcg_fpstatus);
>>               tcg_gen_extu_i32_i64(tcg_out, tcg_single);
>>               break;
>> +        case MO_16 | MO_SIGN:
>> +            gen_helper_vfp_toshh(tcg_single, tcg_single,
>> +                                 tcg_shift, tcg_fpstatus);
>> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
>> +            break;
>> +        case MO_16:
>> +            gen_helper_vfp_touhh(tcg_single, tcg_single,
>> +                                 tcg_shift, tcg_fpstatus);
>> +            tcg_gen_extu_i32_i64(tcg_out, tcg_single);
>> +            break;
> 
> This hunk adds calls to the toshh and touhh helpers,
> but as far as I can see it doesn't remove any calls to
> those helpers that were in the old decode functions or
> any calls to the handle_simd_shift_fpint_conv() function
> which was the only one that did call them. Should this
> be in a different patch?

Removing those happens in patch 61, with FCVTZ* (vector, fixed-point).
Here we're only converting the scalar path.

> (Conversely, we remove calls to gen_helper_advsimd_f16tosinth
> and gen_helper_advsimd_f16touinth but don't have those here.)

With the conversion I'm sharing more code.  So we (eventially) remove advsimd_f16to*inth 
entirely and use only vfp_to*hh.  They both call the same float16_to_*int16_scalbn 
function in the end.


r~

