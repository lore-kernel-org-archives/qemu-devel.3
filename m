Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79074C83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 19:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUdf-0008AX-2x; Thu, 17 Jul 2025 15:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucS2d-0005TW-IZ
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:05:10 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucS2b-0001ti-Mu
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:05:07 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso1615148b3a.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752771904; x=1753376704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XMqEN3QsE6wJqklujGilDAGpGh9DttXjTTF21J4POrg=;
 b=EHpN5/7Au+20Vk5Pj1KtcZxKNYPFcVw/Sadtq7qZPqaRzJeHXGc/sXW4OMoYs2Y9Cy
 nL6dLaXxnCzhO+nksXj+AMljfSlWoeqSO1aSMgd3pp+6rPbIgZ3EwbBpFQbE48SCatu0
 lRnPj+5k1e7eTK8L645dgiob/4zqRGUskazst3BCDfquiLPEb1d2YRPsHUKd1d9UmYDa
 CodVe6oxUcLNNg38ClrkZ5JdEXFPkgLkspElP8Lwwdh/OywZTE+AgaUEmJNaPsAyGLrw
 1ck6pnJoWKwBcagc1lO1oMyqQSGjc8hq8vSDGZGz4z05GYmf6TYHKCz56i2IJTjlzXYi
 7Xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752771904; x=1753376704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMqEN3QsE6wJqklujGilDAGpGh9DttXjTTF21J4POrg=;
 b=wikB0qXPZTG3raRmdRRaQ4jJpDCJ7PBEVMIMVvYtMJrapPYnuICb5XVTIqMpgY9Szp
 Rgr0+l7f6t8Eyc5WSW6DFCEpmF03tKEnaal+iSyVjgQbkYRd5A9ezszC2xLH36YJHxS2
 dzlzbWZuhUuefYupHEQPiyxhQodl+hZJ1VQ13UK3Tx6JpjiqB1HuUnTc/6S8GOCxe0p2
 dRiOEfuPSUR+JvGSao0nQ0lA/Gc3LOfmr4UJ+kk8lBU8JRrgrxSQHmQp4vGnlzUD4k40
 k3ZV+W7Wayz1lQJjbD8TXnKOXncUqhRVoLIvacx5FGbjPXMoTM8GaymgB0HDFmB7IY4R
 O/xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7iqNpaygDBGjgGEzubE8dX/aYQr63IjIibWIOuLpJpgz8Gw7NFhfbaQM9nQk5/eY1riPFmGnoON7u@nongnu.org
X-Gm-Message-State: AOJu0YxAN1a6UtYTEXLufZaaI9MbOPSI+lvL8ystylNrP7LDZhQE/B/0
 qjDs2GxmH7UargI5OSA3SJ2b+FQmSjJlz1cwfriiiuAbmWsGYYR4Ff3GPwgys8pWxvQ=
X-Gm-Gg: ASbGncuedDNNsLDu5yrPLVkdyox3NxuQ2wZMig1NAiKdPuiK3LklVrosnR6YF4diEb9
 AnflaOjLWBhtKPGaEjI3bpE47FdW0ZWx5XJyBZQ3+GtTNYEzXjRRRkZrZ/aG4KYZgQXkHwS46k3
 pJypw2ktMDm7uYtd+5WJaurGiuAHr35uqJNolWjR5LVNGbzkNunoqVZ15nrMmWme/UJjB9c6iUm
 jKy/p/1bgbxkOmiToXclmfiVdm5x+Jrgfa18wzT+mdVJjfFOYqdX92kTZxHQ5tDdkHInWiY4hrD
 8dRPHWlcQmIEWbqtL9s7/bp9Wg/UVhYBG4TyzcYYpbJJQac5hHj+HGDMaUFJSeL400wQdOMokEr
 HyvnT4T6vO2XvskE2dQaaMJ7UniRetIy4BOQ=
X-Google-Smtp-Source: AGHT+IF/qH0tAxtwrPSw5eViUD90I+vxFsBCBqhCn7MD+oqEztGNU4QkwIEtyGL8TXpKDWzberbZVg==
X-Received: by 2002:a05:6a00:3392:b0:740:9e87:9625 with SMTP id
 d2e1a72fcca58-7572267d1f8mr10444044b3a.4.1752771902960; 
 Thu, 17 Jul 2025 10:05:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe345f2esm15810423a12.0.2025.07.17.10.05.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 10:05:02 -0700 (PDT)
Message-ID: <3ca15207-c4af-4cf8-8502-b78bf95bd5f8@linaro.org>
Date: Thu, 17 Jul 2025 10:05:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Provide always-false kvm_arm_*_supported()
 stubs for usermode
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250714135152.1896214-1-peter.maydell@linaro.org>
 <0b438773-01b9-42e1-8edf-2330e50387f8@linaro.org>
 <95b00393-bdd2-4db3-ac39-02a09f83b4d7@linaro.org>
 <CAFEAcA_Hbpg0wkQ9frt+MUj7x7uR+p7+8o4SLLx=GwhWvfCzaQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_Hbpg0wkQ9frt+MUj7x7uR+p7+8o4SLLx=GwhWvfCzaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/17/25 9:56 AM, Peter Maydell wrote:
> On Mon, 14 Jul 2025 at 16:41, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> As folding is not guaranteed by C standard, I'm not sure it's really
>> possible to file a bug. However, since we rely on this behaviour in
>> other parts, maybe it would be better to rewrite the condition on our side.
>>
>> By changing the code to this, the folding happens as expected.
>>
>> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
>> index 26cf7e6dfa2..af5788dafab 100644
>> --- a/target/arm/cpu64.c
>> +++ b/target/arm/cpu64.c
>> @@ -318,9 +318,11 @@ static void cpu_arm_set_sve(Object *obj, bool
>> value, Error **errp)
>>    {
>>        ARMCPU *cpu = ARM_CPU(obj);
>>
>> -    if (value && kvm_enabled() && !kvm_arm_sve_supported()) {
>> -        error_setg(errp, "'sve' feature not supported by KVM on this
>> host");
>> -        return;
>> +    if (value) {
>> +        if (kvm_enabled() && !kvm_arm_sve_supported()) {
>> +            error_setg(errp, "'sve' feature not supported by KVM on
>> this host");
>> +            return;
>> +        }
>>        }
>>
>>        FIELD_DP64_IDREG(&cpu->isar, ID_AA64PFR0, SVE, value);
>>
>> If you prefer keeping your patch, I'm ok, but fixing the condition looks
>> better to me (as we already rely on constant folding in other places).
> 
> I'm not really a fan of relying on the compiler to fold stuff
> away -- it's fragile and there's no guarantee the compiler
> will actually do it. In this example it would be really easy
> for somebody coming along to tidy this up later to put the
> nested if()s back into a single if() condition and reintroduce
> the problem, for instance.
>

There are various places where we already relied on that, including 
before the single-binary work ({accel}_allowed).

For the fragile aspect of it, that's why CI exists. Building all 
binaries with clang --enable-debug should ensure no regression can be 
introduced.

> I've applied this patch to target-arm.next; thanks for the review.
>

Thank you Peter.

> -- PMM

