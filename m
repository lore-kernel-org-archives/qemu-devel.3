Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE135CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:32:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgJC-00005N-NC; Thu, 28 Aug 2025 13:21:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1urdpm-0001qI-Sr
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:42:39 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1urdpk-0000xH-9M
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:42:38 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3cd59c5a953so673653f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392152; x=1756996952; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XlIA4USyAQE65RJp1YZjEvdIlB4v9w1UDqYnJWiMLo0=;
 b=wM4/FdnmJvNSsnYCZhu5yrMc59cw7bP0GDsjJOJPpavFeXOy2cX5mCl6NKqFY7bJxA
 CzcsnUdCHukUT/QglfWBt6G+p43UP+AxzEMxOaQJLqfVpFgK+yA4t1JLI/MQ8HVVTyMz
 n2b8G/q3XwUh/PkPVmIEPkfO8rImmd+OuRJIi1sedBplIZNMx2D43AgC18LRJOEx7UaK
 1qR1m2beJRlpFW2hwzY6a4/4+b162GALjHJyM36XAB8XhAwD5DVMnFscoIWAx4ycogfO
 jtxaOLP0UdSeyXw4dd/j+J7sPazoNxVYCbSnybSkuK32TlZPkf01eCUxyQHmU4MQj0VV
 Hi0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392152; x=1756996952;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XlIA4USyAQE65RJp1YZjEvdIlB4v9w1UDqYnJWiMLo0=;
 b=t5/Pjj3pY9JYQNqZZezTp9u58z2A6rm0/zLLh4YYzztfZGdaGNaccGY2PfSBZb3F/C
 +4SC6CRaZlGThYMBId5wIlAzn4mvcN9p+PDw/AEPGAPnG1Tzd+vFU/PNo7pMdXe+roGl
 c+I60O+YB5DTQwbpRq7cqMAIDi4TV1l+jJoTiwWOoRe3zlu0fyDL9c7vB3gtOD6wpdeu
 C7+us/8Egj5VJdEOAClKEpZ7kms8Q4TFnT0LGm+Nz3g1cGK6gkcfOqia5rPVdVdLeez0
 XSk/+BKHVdFNhiSz/4a4jPrQh/O6rirc9k4sycNKNeLdodBInbTm/7VkZC3DI4BW/b4Z
 //5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFZqjZ+euTLG6z6IAylfDJrkzJ6mVfdO0/w2cUPctFyLwvSXq+uIH6fBQlV/djOrTR7BwrB3G8/CDI@nongnu.org
X-Gm-Message-State: AOJu0YzD/v91LRfJlJuN9ddjYZWUrZqYSgQ/C2aJ9w+wIXW9Gmo2fs4/
 WkwaX0jTuSm/NEk3aJFEDt3M7YdRAgs8YY0zCXw0+zKs6IWJZv5hiS11ab8nGCyaKqc=
X-Gm-Gg: ASbGncvaHeRfLTYVKzS0017YIPeS1waxEBTMmDAV5yb565464K1XhAS6tu9gKty+UpS
 fZujzmvTdJueGeHYBavcOgtyPvc6Zj89j2URTOsnxFi9zJP3kpg9adGneh9550Vm01F8T4ONwyD
 deyWJ+58Q4GG3rX9x58PbV8j2U7bzckWWfGHQ4XMKOyp0MQS5tUM70c8AFZswso96zSv+UPdzsZ
 V1zV8e0Eamj0DudP+ko5fs60Mr4wxeZKo6TDj9u7Ui0S2L1FebJs073u9Ac0PcNFgwNG1YbsSV9
 yFt0K+9/7dPVvLkFUtbLwe4n8ll3eu0TszDbSM1KuJUYfSnSzKasV4KF76Mx+IzfJcC8Vb6Fr9U
 QPh0Yknt1TuMDmRTPhHpcvCVp78z5FWsehJKnnfbd5mkqQi+gLijUlLdMgcg3aIzPLXBvdcgQs2
 /P7RB/hp2ZutUt1erYXAGnPrsRi3/f78m6WHGz6ngJVbHJVUY3hT+4V+N1cS8Y+tj1BT2m6tHLf
 ZlMXwkD30TinkY=
X-Google-Smtp-Source: AGHT+IFhU0RjfxzQX4gyiUiU2u/z7+mj3ER82ZBafxLsUk5C+WMMU7+rsozf/bDZtt8oBKi1jUBBUQ==
X-Received: by 2002:a05:6000:188e:b0:3cd:9794:cbcf with SMTP id
 ffacd0b85a97d-3cd9794cc94mr3646605f8f.60.1756392152425; 
 Thu, 28 Aug 2025 07:42:32 -0700 (PDT)
Received: from ?IPV6:2a01:cb09:d021:8fd6:94b3:f1b:6ece:2fef?
 (2a01cb09d0218fd694b30f1b6ece2fef.ipv6.abo.wanadoo.fr.
 [2a01:cb09:d021:8fd6:94b3:f1b:6ece:2fef])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cbf1f5fc1bsm10014291f8f.54.2025.08.28.07.42.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Aug 2025 07:42:32 -0700 (PDT)
Message-ID: <c0acee85-eabc-4093-a74d-f54ecd6e4335@linaro.org>
Date: Thu, 28 Aug 2025 16:42:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/6] tests/functional/test_aarch64_rme: update image
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20250727074202.83141-1-richard.henderson@linaro.org>
 <20250727074202.83141-3-richard.henderson@linaro.org>
 <CAFEAcA_ZQ13qMRUQsieJiEPV=ULrDbz8=EJaW4_kw=yEysob0w@mail.gmail.com>
 <87349s4kfz.fsf@draig.linaro.org>
 <3d59d45f-79f1-4701-ad3b-402513ce4e72@linaro.org>
 <CAFEAcA9ryysJQK8hxNxpF=00yC=t3==aFqt2pubD3CjM9T+WLg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA9ryysJQK8hxNxpF=00yC=t3==aFqt2pubD3CjM9T+WLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42c.google.com
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

On 2025-08-28 10:27, Peter Maydell wrote:
> On Sat, 16 Aug 2025 at 01:09, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/15/25 9:29 AM, Alex Bennée wrote:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Sun, 27 Jul 2025 at 08:42, Richard Henderson
>>>> <richard.henderson@linaro.org> wrote:
>>>>>
>>>>> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>>
>>>>> TF-A needs to be patched to enable support for FEAT_TCR2 and
>>>>> FEAT_SCTLR2. This new image contains updated firmware.
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>> Message-ID: <20250719035838.2284029-3-pierrick.bouvier@linaro.org>
>>>>
>>>> I see this test failing in local runs of 'make check-functional'
>>>> sometimes, complaining that it can't create the scratch/out/EFI
>>>> directory because it already exists:
>>>>
>>>> stderr:
>>>> Traceback (most recent call last):
>>>>     File "/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/tests/functional/test_aarch64_rme_sbsaref.py",
>>>> line 49, in test_aarch64_rme_sbsaref
>>>>       os.mkdir(efi)
>>>
>>>     os.makedirs(efi, exist_ok=True)
>>>
>>> would solve that.
>>>
>>
>> Yes, probably safer to add that if we can't guarantee correctly that
>> scratch folder gets deleted everytime. I wrote the test assuming this
>> behaviour.
> 
> I folded the os.makedirs() fix into my copy of this patch in
> target-arm.next.
>

Thanks Peter, you did well.

Pierrick

> -- PMM


