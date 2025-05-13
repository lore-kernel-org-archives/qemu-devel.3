Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C3CC3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEyUT-0005Ea-9u; Tue, 13 May 2025 18:52:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyUP-0005EN-5J
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:52:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEyUN-0003MY-JO
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:52:44 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7415d28381dso5273582b3a.1
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747176761; x=1747781561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gdKsNg5FkFc8M09aSO0bo8M5ouf3s2GYvRUg59sTK50=;
 b=d2r4HsIb7T4jlDZYBeL1W53e4KPho0BlVU91zgWDj6Diue7Dn71eKS+5ZUU3j+asUv
 6cCYB4+zXcIzpM/xbVlntx9gJl1QmLPxtFIV7q/7qPvKx4ARoV/GdBPC/EUYhdtFlGbV
 fitbN+9YyKrxOzc27RCXHFdpGJVyhqUyEXCDQZp3M6o9uQbFGQQZESJ8Ee/Racwz/QdC
 yuxjjgnG/p1ha3Js6EA1q6rG3kyVhxBq2cjn9Ngrmf5+GyZH+vRtHctKf+vOt6my38g8
 fFKK5XXicvoTlUxZthv3sbZE3m+G2HwmI5S75VLpOGKoGe5X4EDKg4tZ8gyMr8e+kdyi
 hftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747176761; x=1747781561;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gdKsNg5FkFc8M09aSO0bo8M5ouf3s2GYvRUg59sTK50=;
 b=mYEDwTT1Yd8tV/uC17qXVa62GFBWctyh54CNUpGXQWynBPlCTwYXgSRiJd+ygcAAsJ
 fJwI8Ef1qHxY8Qg3p17UekqiyPTJTlb4cT9cR86qilYFh7ANB+pXxWD/GuwoCfliCF4n
 MFzwAge7GSTZ8wVOouMgzN/mCd6usrtI8NlyeU+GfYfDtnwoccLr1EcEkA6tBc/PKGWa
 uEXz7Fh2EQoq5uHC3VuDuk+ApyIhda4B2DiNPo0dmsufnCgYm/lYMrLRSl2dkSHLdfnP
 GUyAI1HAbzPPSo3P/yMx375dWnIZvf59T1PlzuEFUcCGM0RKdQaPd+RL7OLBJODmenNR
 E9qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdvbda3/mYyjT707DdLfEEKr10sQjXltJCxxBL+0Bw8qTZ9JwjG87Oh7KXqZ8/+4JoOF07Nal6KPqk@nongnu.org
X-Gm-Message-State: AOJu0YzlOLLvse778IuPzQYZAoKcHzc+1AD1fxz9tKYf/z0nlVIZ06Fm
 NTtVWpad/uNDdD65S5xnReEfyXjtHiZeBCJB10kZ5IO5gwBUZUrk2D0OadGfIto=
X-Gm-Gg: ASbGnctqOaQMk7Oa+npqnLiH7boFFDHtGIu39qPh8U9Sah/aXnOzijc+9WkrrPHkxYs
 jOakqgFHxMuiyZ3aK6ndwf5Hu5+azq/0O4wDlAUAXa8FJalw4G/zH4SRK6ABN3HcLDuwgl2PAkv
 K1mW+gTzE4opcrSG/G2uMjtIFwiwJpWlLdz12kM4YJHInvOBj0aHZ3mi3nz0Jd26MznHo9SW8X5
 w0wSf90kHZRi267Nhz9Aex7upy50Ea32b5749PqFD7tAUJJ8e6b/1QuvaSEEfWUjS+pKmkg/cUZ
 nUN/6Rs/fKlmTbKQm/Kbfowf9pfaHiOr23fKrQG7ePRhIlGGkwQ6POGb6YbtBJD6
X-Google-Smtp-Source: AGHT+IE0rTzpup4IYYmjD+SospHbxjN4TM4IJTV12OD2IPMReHdceEX8h45b/qIC/3t7lfaITuI/nw==
X-Received: by 2002:a17:903:41c1:b0:224:de2:7fd0 with SMTP id
 d9443c01a7336-23198154a76mr15915545ad.25.1747176761110; 
 Tue, 13 May 2025 15:52:41 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc774134fsm86819375ad.56.2025.05.13.15.52.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 15:52:40 -0700 (PDT)
Message-ID: <e33c5751-6db2-4ca7-9a6e-b992a399e696@linaro.org>
Date: Tue, 13 May 2025 15:52:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] qapi: transform target specific 'if' in runtime
 checks
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, stefanha@redhat.com,
 peter.maydell@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 jsnow@redhat.com, philmd@linaro.org, thuth@redhat.com,
 Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-10-pierrick.bouvier@linaro.org>
 <aBzCXNTebh8B5sQ_@redhat.com> <87msbl0x7f.fsf@pond.sub.org>
 <cb2adbec-d098-4211-8781-c3027de59e69@linaro.org>
 <87h61phttb.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <87h61phttb.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

On 5/13/25 12:08 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:
> 
>> On 5/9/25 11:57 PM, Markus Armbruster wrote:
>>>> The build system would need generate an input document for the
>>>> QAPI visitor that defines whether each constant is set to true
>>>> or false, based on suitable CONFIG/TARGET conditions from meson.
>>>
>>> I think the conditions that are evaluated at build time in handwritten C
>>> code (with #if) should also be evaluated at build time in generated C
>>> code.
>>>
>>> Certain conditions are evaluated at build time in target-specific code,
>>> and at runtime in target-independent code.  Again, I think handwritten
>>> and generated code should work the same way.
>>>
>>> Thus, to eliminate target-specific QAPI-generated code, we either
>>> evaluate them at runtime, or simply eliminate them.  Elsewhere, we've
>>> come to the conclusion (I think) that the latter should do at least for
>>> now, likely forever, so we should try that first.
>>>
>>
>> I'm not sure if you mean you'd prefer to eradicate #if completely.
> 
> I do not!
> 
>> We have to keep in mind that some config host #if have to stay there, or
>> they expose things that the rest of QEMU code is not supposed to see
>> (hidden under those same CONFIG_ ifdef also).
> 
> Letting people configure their QEMU build is useful and must stay.
> 
> We provide this via conditional compilation, of complete source files
> (done in meson), as well as within source files (#if in C and 'if' in
> QAPI).
> 
>> So we would need both if and runtime_if.
> 
> I don't understand the need for runtime_if.  Can you give an example?
>

That is the point of this whole series, which explores introducing a 
'runtime' if in the schema, to keep it as it is today, while removing 
target specific compile time defines.
It is another approach that one Daniel followed on his series.

I invite you to give a quick read to this series, especially the related 
commit introducing 'runtime_if' 
(20250507231442.879619-2-pierrick.bouvier@linaro.org).

As well, I would appreciate if you could state clearly where we are 
going with all this (or at least, where you *don't* want this to go), so 
we can avoid spending time in the wrong direction.

I am ok to pursue Daniel's approach, or continue the approach in the 
current series, no strong opinion in my side, I am just trying to move 
QAPI generated code out of the way for the single binary goal.

Thanks,
Pierrick

