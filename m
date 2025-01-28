Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE0BC0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 15:55:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcnum-0001Xs-1p; Tue, 28 Jan 2025 10:54:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcnui-0001Xd-Te
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:54:08 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcnuh-0008Ux-5q
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 10:54:08 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so10232000a91.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 07:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738079645; x=1738684445; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w08lruw+sO/cuLE2CKI8wsZW9X6HG2fUkfIx/gONmDw=;
 b=z8mFC+sYofahNmquvuz+Udm/7LkmXNz63lBS7HzXAgFgdsKSFbMjgB9y3epfAkLoLz
 +NpjGLDUwwBCWUlLUPnjK39UjNo6z64cvX5n6Yq3+JJApJZls76Ah/5hCdPRfOZhQOAm
 vSXbLIDF0v99VTmTfiBXp+Nuo2C4FA9ANVVDnGEIYovcOcWfg2QqC0K+o6H7TAGnNb1O
 t84ClqTHIUcKjZIdKaIuBd/qvMAgE/p7uYGvxKXjVX/SbaEmeZud1vN6PQiN/5DGU4PW
 N7MPQAgy3gEF+wf+82hGNtJzK4eAnc4k1OrCupn+w/4rgAA04HhLMJRyyDRVkZP/ck3x
 xu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738079645; x=1738684445;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w08lruw+sO/cuLE2CKI8wsZW9X6HG2fUkfIx/gONmDw=;
 b=dUQKhAHHrD1hGJCpgowzm8x13q1oV3/Lji5TmTshKJO1+1qGU/QKQuizhV/tEv9+95
 B0IM0iWk26xM1+qy4yuJAHL9b2nWr4V4IGD2M30W5KljIEN0xU1J4MyTVWWAvg/umaOb
 tFRvZWeyYURjW0yZconENquVMexwZxIeE7vy/85yHCnDTQNLosniJ94Ndd6z5oONWqUy
 ZoeSywbQ3+/IuHWKb2ljOy6BeFI1R/fy3UK7oEVtwSDl3OUoeS06YwhPG7m2c3mIwg0p
 ggci4f30Zfhs3GZB4DT9ENZ7zPwXATskcbp9XhxZCHHWs3L0h7WLRJ3bVlDZLjsIFztu
 Gkig==
X-Gm-Message-State: AOJu0YzxgAxNQlwvmzEueMoe4GGq869AapCErNXUGrLvcDpnCfegtYjv
 pu2kxCZb2A4rI4W/TGAr218KLw/SFImmo1q00Kk+x8Ld8IOG7ycLQRt5tbNSvzs=
X-Gm-Gg: ASbGnctibeWCPIXycvrgY8h1OsG6t+fsJpU35M35RzLKeUfeISTq/wE1KS1YbYt92Mo
 61WGe6NC9iX2Iht2W1cMFZTL24iDa1dvszWLLkIzsSPa/nSOnrSOAYt5MqJA7Zf5k3mzAglrjO7
 hUAktXw1Hse8gNc2IlAl+hbLpWQPRNBTDgVCTi8gyQx2Ievpxkd2yD0t7CxbSfV6SwspAeZxeR2
 6rcq9TIfcnauN5aAohM3l5ilK63EIXhf6MLkqyHeW8+1C9lu5kvBbwpv68zKIwF15+lTm4Cb+Qh
 8nGszPJgRRVI1g4tsrSBB83FSOIUv9fWSunJ2feqj1CMi4Hma0WbneVgNA==
X-Google-Smtp-Source: AGHT+IHkmJhR7pL04fva+Qhs+xjqbQUO0LJKrjmPOwyMIhxfDFWQ7xzU3JfcYPZwxfcvY6G4oskAYA==
X-Received: by 2002:a05:6a00:330b:b0:724:59e0:5d22 with SMTP id
 d2e1a72fcca58-72dafba2625mr65301155b3a.20.1738079644619; 
 Tue, 28 Jan 2025 07:54:04 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6b2ce8sm9437175b3a.42.2025.01.28.07.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 07:54:04 -0800 (PST)
Message-ID: <a6d8272d-9ed3-45fe-8d74-44b836c076c1@linaro.org>
Date: Tue, 28 Jan 2025 07:54:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/76] target/arm: Use vfp.fp_status_a64 in A64-only
 helper functions
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-8-peter.maydell@linaro.org>
 <05ed4583-704a-492c-896a-71bbd4a63a12@linaro.org>
 <CAFEAcA-qC_osUrdhFzsd7bjv1R54UwiZXrF3sQ=aFHm8k=NkQw@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA-qC_osUrdhFzsd7bjv1R54UwiZXrF3sQ=aFHm8k=NkQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/28/25 04:35, Peter Maydell wrote:
> On Sat, 25 Jan 2025 at 15:16, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 1/24/25 08:27, Peter Maydell wrote:
>>> @@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status *statusp, float_status *oddstatusp)
>>>         */
>>>        bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
>>>
>>> -    *statusp = env->vfp.fp_status;
>>> +    *statusp = env->vfp.fp_status_a64;
>>>        set_default_nan_mode(true, statusp);
>>>
>>>        if (ebf) {
>>
>> Is this really correct?  !ebf includes aa32.
> 
> Whoops, yes. I'll drop this hunk of the patch and put in this
> patch afterwards:
> 
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Tue Jan 28 11:40:13 2025 +0000
> 
>      target/arm: Use fp_status_a64 or fp_status_a32 in is_ebf()
> 
>      In is_ebf(), we might be called for A64 or A32, but we have
>      the CPUARMState* so we can select fp_status_a64 or
>      fp_status_a32 accordingly.
> 
>      Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> 
> diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
> index 011726a72d4..2ba1f7cb32e 100644
> --- a/target/arm/tcg/vec_helper.c
> +++ b/target/arm/tcg/vec_helper.c
> @@ -2808,7 +2808,7 @@ bool is_ebf(CPUARMState *env, float_status
> *statusp, float_status *oddstatusp)
>        */
>       bool ebf = is_a64(env) && env->vfp.fpcr & FPCR_EBF;
> 
> -    *statusp = env->vfp.fp_status;
> +    *statusp = is_a64(env) ? env->vfp.fp_status_a64 : env->vfp.fp_status_a32;
>       set_default_nan_mode(true, statusp);

That'll do.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

