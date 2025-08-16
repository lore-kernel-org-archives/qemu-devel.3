Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1848ECA0ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Aug 2025 00:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1un4Uq-0003km-06; Fri, 15 Aug 2025 20:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1un4Ui-0003ew-CG
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 20:10:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1un4Uf-0006Vt-Ae
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 20:09:59 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-244580536efso17349135ad.1
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 17:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755302994; x=1755907794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WXwsAdoT+c2Spv1JkS7kJneaoND8aLvJH3TerPNRWl8=;
 b=HYS19JhMFG++RJGPoIbACR9E9HWHUHV77pwaza73LTeBm4O/jp37bRTVtYjELg8kB3
 yUz+E/l7XZlMuovqzaoTExx9NXl4bSXtKLhqgNID7a1izs1k0nLMfwMtedWii/JTKOEC
 VtBZfB/+K/Zg8FqeWy4Q1D+pka2iz5o2APjc0H2OfRVIAzA02vgFoQRz1H/NidVxcZYB
 AApL6ST0FFdZC5NbPmbYRfBb9oLAkcu7O8U9bm7KOKgCf/SLg7JETjmbOx+TyAu4RITH
 bkn+S5DoCj+jQf76cMVxO/SzeZ0niPPeiZSF2XlB6u3hNuKxh6JsYcaMqqoysmR8kB/k
 dqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755302994; x=1755907794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WXwsAdoT+c2Spv1JkS7kJneaoND8aLvJH3TerPNRWl8=;
 b=a3TWELb4TrRiUcmlse64GldIFBuAj+JtxifshvW3r+UZqhwcqh6k5CsIgqp+qnOrL1
 6D/TC1gu2YXes77jstCXaGTsNRnrWe1FibIF04semj+6CfmRPoEdcvKMw7tY2CzKtR2O
 1a8KraWWPFld1E/2iMaZLJMpmLiDTHhIsthxg+UAivKFTNjQOH+D6gbLkJz6Zwdm7Mmd
 RJWjrlfKvWLc2QEbl9jOQJpcWcHSXcYqz7uVeiwaX6M59RlI9D/3V3yDksfN/8+t++QX
 5OHWjf2JRyqH+gcKs9Ouej3yccZ//0agk7VQywYMIfuYeFKmRd2GwI/knn/fnkXmVvXO
 t2sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQQE07RsLGY45kvmuXbh+JuSvJgw0QF85mweVdohQwuuxsW/Yr/scOsUjX7i9anH3KEdJT1g2giQNW@nongnu.org
X-Gm-Message-State: AOJu0YysTcNWXEJQvwnOrfRtCVXEeLvIB9nOzlYT1q4hK/ziX/QXoFBI
 Ht8cubECMRQZueOEmrZv/cUYd76MY3ZX0t7FSdN5jLvKORAZFQjO4L5g0GcePYGQTPw=
X-Gm-Gg: ASbGncsbvAVICpfYk9aLssRafIPWPsan7CdeRnOcifVy4aPXdIFH96tGpaD3rAnWNn+
 MrhPseMXrHwKh5OuO3vjp0/Yw7K0o5KaTTFcxN29I9vVHhRZ0/AV7esp9cbIFLqTrCz9KxOIeow
 CDhmgXVV/E7EIK7/V75tTzt47LzKs9Gh4tJKKieggOQZNYjPSr7zapRdG2ieWZqLCR5zzYIz/Dr
 NMmH/lQQpAZIuX0zIs+3+jWp22oosvS2j9ZgUrm6KF4JnJegM2Ku0kUr2OOUC/16kBXcDLeZdRZ
 3sUZjlTXPrkVTwHN5oPubn0EMRGMMT93czcxGwdQW3YtZVpFq0zCKU+wd1zlhg6bC5uWtt9pyUN
 m3kofpdIYz1Q6gM4T1zkr1aFa/dfpH16dRpU=
X-Google-Smtp-Source: AGHT+IESwf6YI2+zbSymJiEA5NS+c9IGj/L1y7wyaRwaeclRkWVw7W78nhgEw65vl9xayLMGWh8njQ==
X-Received: by 2002:a17:902:c409:b0:240:66ff:b253 with SMTP id
 d9443c01a7336-24478fbf60cmr15036795ad.46.1755302993675; 
 Fri, 15 Aug 2025 17:09:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2446d5536c3sm23065695ad.137.2025.08.15.17.09.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Aug 2025 17:09:53 -0700 (PDT)
Message-ID: <3d59d45f-79f1-4701-ad3b-402513ce4e72@linaro.org>
Date: Fri, 15 Aug 2025 17:09:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] tests/functional/test_aarch64_rme: update image
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-3-richard.henderson@linaro.org>
 <CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com>
 <87349s4kfz.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87349s4kfz.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/15/25 9:29 AM, Alex Bennée wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Sun, 27 Jul 2025 at 08:42, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>
>>> TF-A needs to be patched to enable support for FEAT_TCR2 and
>>> FEAT_SCTLR2. This new image contains updated firmware.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
>>
>> I see this test failing in local runs of 'make check-functional'
>> sometimes, complaining that it can't create the scratch/out/EFI
>> directory because it already exists:
>>
>> stderr:
>> Traceback (most recent call last):
>>    File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_aarch64_rme_sbsaref.py",
>> line 49, in test_aarch64_rme_sbsaref
>>      os.mkdir(efi)
> 
>    os.makedirs(efi, exist_ok=True)
> 
> would solve that.
>

Yes, probably safer to add that if we can't guarantee correctly that 
scratch folder gets deleted everytime. I wrote the test assuming this 
behaviour.

>> FileExistsError: [Errno 17] File exists:
>> '/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functional/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref/scratch/out/EFI'
>>
>> More information on
>> test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref
>> could be found here:
>>   /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functional/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref/base.log
>>   /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/arm-clang/tests/functional/aarch64/test_aarch64_rme_sbsaref.Aarch64RMESbsaRefMachine.test_aarch64_rme_sbsaref/console.log
>>
>> (test program exited with status code 1)
>>
>>
>> Is this something where we need to blow away any old output
>> directory for robustness ?
> 
> Generally scratch is cleaned out once a test finishes (unless you
> preserve it via QEMU_TEST_KEEP_SCRATCH=1). But I guess there may be
> cases when it isn't cleaned out properly - does Ctrl-c get caught?
> 
>>
>> thanks
>> -- PMM
> 


