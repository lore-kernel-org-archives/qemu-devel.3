Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B688EC83F34
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucUz3-0008Ph-PE; Thu, 17 Jul 2025 16:13:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucSQH-0004Bw-Ga
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:29:33 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ucSQG-0005LA-04
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 13:29:33 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-313154270bbso1290823a91.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 10:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752773369; x=1753378169; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I1NIMHEzPaeVtAhclNb6RsWyjRAIprTJbPcgd9kY5BY=;
 b=mnbWxhPI3xu2Gtpw7yq7hgXyNZjze3McLeYLlMwk9YZDJ9KaWwzdtqKTqso0Tqp1/J
 olH/0fhG5+4NbSOt48QxloaKi2H2JrYUBVzFGdQWSMqJ1Ev5Ah6K+HlJ0fjwB3ih3qk3
 TIQMJzrNao4LPjSB6bFrcF9rdpSVjMgKPuskx53hxJzrxZ3ii5ulBGMjZQbRt1vFJQ1I
 DK6bnklwa3iwLebmhRuoWWzff2FeYnnDbAQVp2i6ACmNU1kYhLpwlPckMHqW2SS4J0OG
 UeC6qynpvI3i8GrxO8J7Qd7iGVi52iItmcSuwPxsN8pe5cNIU8RRPjQLiUF0J3p2ckk/
 D2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752773369; x=1753378169;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I1NIMHEzPaeVtAhclNb6RsWyjRAIprTJbPcgd9kY5BY=;
 b=GulJyPlhsQ3F/hTHZ5iLWk5N0ujMqJiO1u9TOlvFufzRZBf3LSQsdwA9YFoqSLnV1d
 YSTglAhlCe+vf/8Hrt36qjYf1lL7o+LGWYw8mr19d8FuoVcZk9qpWH3crHqYCXJqUb6O
 K7TrTVhsZG82d+HQUr09rmN2nIYKl2ygLMPVi/J/VVtKBmdzXaGOIsh/LXs9ruM1kRzI
 7YZ3Ann2mrnLSnSGgJI1gnr779EIfOGTpPoSdPUPwF8i86S9eYoR1GKJTihKQyjOrwPm
 kucGoC84ew5B1mt769b+RZDhWqEMyoKehANkVw1qaq2ZnJdYk3Q9MaJlb29mfBAK8Fj7
 jeaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEMg4g1xx2vNZzA2dzO2MI5DL50zBzh2yBtqFwNcRNFTAIoU6HgaWKL3NcDkZd/CGNtdq0xkxK0ySd@nongnu.org
X-Gm-Message-State: AOJu0Yw4FBJ7q88oZg3aj4XBsqZqhMXtRVa3Ezw0mRVH7ceSOtM2B/T1
 eOTanGjV/glM7ky+zxIP+u+0/+jLPSUl6mMBbuG0Q7c6xjD7Wkfaf+m/8cZ1bWeavPE=
X-Gm-Gg: ASbGncskA8IS4Z4eyPhYpVsNgkksuLIIiXwje/9dmLk8x4H0NIKS4I2XZyz/rOzzCMG
 fjyWUR6kh2GzfvABs8gJArg62wqZWZqHNYKGGeqQWPxTDSkltDBnvHjHh8LbhzKfYagLgDAg4Qi
 oCaaaY4RHlMv0ME21vfzB82IIo6kDr3J3hKXO82EzgW5rb5HCnYqtVMRl/gD55CMAdm1sMHepuR
 j1zwBc7yQxPC0klA8Xm6/SZwWPcm7RUOoJibZnnHFRrvfY/T5y4SAIEMl2s4bT8wOiWoxbLjZq3
 EWvkzOJNzmbbs0bURjGPi45diDXmnGrWnxi6B20Lr94aTFo2s3B9Sm7h6PJEMuxn0vMVrc/CguY
 bGTi248QXEtjvBV2USBlHT3CeyPyorTWr7WYcabITSaXS2Q==
X-Google-Smtp-Source: AGHT+IHucWk8VA5x8opxjh3AOcuNZRQ/IjjxkruJsUEPOY1EarzB8ih9PJ5g8tIS8A4tHUG69cRUCw==
X-Received: by 2002:a17:90b:4d11:b0:311:f05b:869a with SMTP id
 98e67ed59e1d1-31c9f3fbc53mr11106859a91.8.1752773368791; 
 Thu, 17 Jul 2025 10:29:28 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31caf7aa6d2sm1860600a91.7.2025.07.17.10.29.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 10:29:28 -0700 (PDT)
Message-ID: <2142f49e-d184-464b-ab39-7e291d436402@linaro.org>
Date: Thu, 17 Jul 2025 10:29:27 -0700
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
 <3ca15207-c4af-4cf8-8502-b78bf95bd5f8@linaro.org>
 <CAFEAcA_VSkK18twpmgQQHu+bQy2KPPzb4Ca0baoxBJ4KPiy=iA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA_VSkK18twpmgQQHu+bQy2KPPzb4Ca0baoxBJ4KPiy=iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 7/17/25 10:12 AM, Peter Maydell wrote:
> On Thu, 17 Jul 2025 at 18:05, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> On 7/17/25 9:56 AM, Peter Maydell wrote:
>>> I'm not really a fan of relying on the compiler to fold stuff
>>> away -- it's fragile and there's no guarantee the compiler
>>> will actually do it. In this example it would be really easy
>>> for somebody coming along to tidy this up later to put the
>>> nested if()s back into a single if() condition and reintroduce
>>> the problem, for instance.
>>>
>>
>> There are various places where we already relied on that, including
>> before the single-binary work ({accel}_allowed).
>>
>> For the fragile aspect of it, that's why CI exists. Building all
>> binaries with clang --enable-debug should ensure no regression can be
>> introduced.
> 
> But our CI can't check all versions of gcc and clang at
> all optimisation levels. The reason it's fragile is because
> there's never a guarantee that the compiler does it or what
> situations it will work vs not work. It's not a feature
> provided by the language or the compiler that you can fold
> away references to functions that don't exist; it just
> happens to work.
>

Sure, it's always a compromise, and it's overkill to try to cover all 
the {os, compiler, version} possibilities.

That said, checking debug builds with available clang version in latest 
ubuntu LTS + latest clang version published should already cover a lot 
of cases, including new warnings that might appear.

I would be happy to help contribute on QEMU CI side, but in my personal 
experience trying to approach concerned developers, either I didn't have 
any answer, or received a "No, our minutes are precious".
I know your point of view (Engineers are already paid, minutes are not), 
but it still doesn't make sense to me. I hope one day we can move away 
from this paradigm, and really make a good usage of cpu time instead of 
people time for testing things.

> I know we already rely on constant-folding in various
> places: I'm not super enthusiastic about those either.
> 
> -- PMM


