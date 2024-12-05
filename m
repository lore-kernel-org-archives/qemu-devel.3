Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094D8E7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 21:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJJaR-00017F-QJ; Thu, 05 Dec 2024 16:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJaP-00016R-Vd
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:40:37 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJJaO-0003Wd-E5
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 16:40:37 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4349f160d62so10385025e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 13:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733434835; x=1734039635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7admLnVga+aMBSTdF0Z8IiIiO+Ke+EcBhtp2YD86ye0=;
 b=T08BPVNmnJ2UR3APZhaK1akFc4fnzb7DxKOGz/FoJFlx2AtskRoLas1s8FNefjqYZq
 +ZFRnTV5un6XTqy9mLmwyByY5JtRBW9XQ250vE6+VmBi1rNPfMBV3aI4Pb6cYQyymQgw
 7mXL07FAb5PYVszLjakGc4H7EZ/c++CtCAibcanz8po4QJeUfMmgjhbzsO6uT78fGVfT
 Sjtf+wQJNn+l5npl5GihJWZASknz6TmqZ4qH3LkCj2DYg8qoOel0Ii3Kd92lXu4YSDkY
 BB280OAiZVcsQ0wSVEmvG427o/bHPWELNRYjXIgZSZOGvemujxtMBqI0Nz1BRXNZCb7J
 vWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733434835; x=1734039635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7admLnVga+aMBSTdF0Z8IiIiO+Ke+EcBhtp2YD86ye0=;
 b=FOl9MK9tgaC3tOWWOWJpeG/Z0Ibdb1/BjhqG+yZX4H/yZpasEQzcPuBhwFGPdZ//k6
 jjWZRx+og3ZzVLd21d+DTId1UBi6vCry2dR7HvL4gYUS72HPLBpsPWBSuwQqpq+hCMED
 uP2PwvJinMZprqU6Qx0UJD+t+TzQ9cZSMbAjH67F5/NqxsL4teKhdDo75R0agouD7uuw
 +SZUNBj9AO4scSG5q/ETrr4D7EO3ouLMuJo21tortayqkMBlLNU0q3etFGew8npiSn58
 aBJwGOWF9e50zOJAoxiuiirJREr1l1N1XZzcdpo8wzPQSRSsbj1wJN/gM2GdqJZXhaag
 Vv2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJSgVroFf0CR1xwqjP+l6eQ/x2iAmoRjrxeATp17OZ3aQgRpITc/RLuqzzCW8/iS0haQfJlT/L0kPc@nongnu.org
X-Gm-Message-State: AOJu0YxpVEKch1jfrAD38afzve8b/NbmHl8zFMA/JCLiHZ4EKoLRSASJ
 pCruATb3hg+hoOCe3qOavblxnPtMz/KFCwNfeM3RIt+byWP68oEGbM1KY26WJVa7Ks9e+PHxIP0
 d
X-Gm-Gg: ASbGnctAU9GENXPg+SoQPFrBLn9fmh/T/l7iQFHAiYw7kK+QcreE7UfyYmoVOnz2Fty
 DHLIdi/c083UefEMzMuBn/JCxbwGyksSD/kE78a35i7teC48CAbUKth+/VtRfgs7xT2AF3hYxd7
 DA4+wHWcNZuTTOAOtXDNROh24Kz3nTt+h+jPMxd2qLa26WGKrNkX5wmeGaRjCwfPAb7AqN6i36v
 wGPGNPqDmK1mKu+JcFJ/UYm2wfVphtKlEqeNcnqikE5dPHoBadN9bZjz4O78POtAyYRAf19zeSG
 fOsHtv4QbQSVEOsAgQ==
X-Google-Smtp-Source: AGHT+IFJFi+Aib/Y6hcSv4B21Z7VEhgw+on8UmxgQ1nm/LQpWfULza91RL2ahzo+x1AKK5vl67vX/Q==
X-Received: by 2002:a05:600c:1c1d:b0:434:a39b:5e43 with SMTP id
 5b1f17b1804b1-434ddeb49f3mr6697095e9.8.1733434834719; 
 Thu, 05 Dec 2024 13:40:34 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5273199sm73301125e9.14.2024.12.05.13.40.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 13:40:34 -0800 (PST)
Message-ID: <4570d427-6115-4cd0-af5a-119e0010c993@linaro.org>
Date: Thu, 5 Dec 2024 22:40:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/67] target/arm: Pass fpstatus to vfp_sqrt*
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-25-richard.henderson@linaro.org>
 <d02f5bc5-87b6-465e-871f-521a49a27b22@linaro.org>
 <CAFEAcA_dxY-mtq8Ys2ZWHQ9ugMnamhno3cUMcGUVpHMK2gAzEw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_dxY-mtq8Ys2ZWHQ9ugMnamhno3cUMcGUVpHMK2gAzEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 5/12/24 22:38, Peter Maydell wrote:
> On Thu, 5 Dec 2024 at 21:21, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 1/12/24 16:05, Richard Henderson wrote:
>>> Pass fpstatus not env, like most other fp helpers.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    target/arm/helper.h            |  6 +++---
>>>    target/arm/tcg/translate-a64.c | 15 +++++++--------
>>>    target/arm/tcg/translate-vfp.c |  6 +++---
>>>    target/arm/vfp_helper.c        | 12 ++++++------
>>>    4 files changed, 19 insertions(+), 20 deletions(-)
>>
>>
>>> @@ -10403,6 +10401,7 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
>>>                handle_2misc_fcmp_zero(s, opcode, false, u, is_q, size, rn, rd);
>>>                return;
>>>            case 0x7f: /* FSQRT */
>>> +            need_fpstatus = true;
>>
>> Should this change be in a different patch?
> 
> No, this is correct. It tells the common code in this function
> that it needs to set up tcg_fpstatus, because in the next change
> in a later switch() in this function:
> 
>                   case 0x7f: /* FSQRT */
> -                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_env);
> +                    gen_helper_vfp_sqrts(tcg_res, tcg_op, tcg_fpstatus);
>                       break;
> 
> we will now want to use it.

Oh now I see, not obvious. Thanks for the explanation!

Phil.

