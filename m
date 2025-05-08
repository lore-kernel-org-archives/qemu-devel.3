Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BFBC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD7j1-0006Vb-95; Thu, 08 May 2025 16:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7j0-0006VK-DB
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:20:10 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD7ix-00053P-RE
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:20:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso1742756b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746735605; x=1747340405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cb0YDNe/2wg2OVbQIugya6VOwjI344me+nQ0nKho4tU=;
 b=ZwLglYd0C0DebZ7QKADJad2NukumIHmlXpCf6tByLLuHUBtmnfKn/Q/lXmNd8J3CpU
 NszidnrYTR05CcJvR6a7h+jgzvpS1OOfKhL8Vv1EptCdx3R/nIAyJERXrpi7IWJMiYMM
 UgnHEQ1u5T/s+cvSL9a6/QD4gk5D1b8nj8S0ncw0fr5Q7cE/8DKUepITx+3w6QROk2lc
 IpDudZQFVq9zscbG2j/0xVJqAivmiFhZzqs3zWIf8Q35s8jaYP+DYm0vqrlhz9PskNVg
 +3225a5WvLGQ3AKtGy2NMgzC07Tw7U/5Q1WUmjw5nv6yxFyxgH10iN/ESkWAuNShbhrL
 RFIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746735605; x=1747340405;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cb0YDNe/2wg2OVbQIugya6VOwjI344me+nQ0nKho4tU=;
 b=i2/qjp9p1xpj4rK9KKlrKetPc7XK0lyVILgEO3Poq7wLGrLn1qSyKPDqMq4rhCV7ph
 qncoJq7pOBICitF9riHmNoLG8GZEvJ33X64Ueos3U9MuLeB8FhVer+6DSMThHWn/QxnG
 reWY8eZ0SIce+AJAWQ/uRhZZo+jDfTah14ERPzPHkObqVfM+gmw4l+dTrgR8HQPNB53f
 AFNohknuVLIke1PqzktPixfdefiKwQLaCIonL526loceFfWqczTEmBjqSWcHQUh66Kfw
 7s3VFiHGcCtFqV4+ys15RckKY5HlfSLCFwljfQvihlF33QVmYdvITNuDO8xT0GTiWDKa
 3szQ==
X-Gm-Message-State: AOJu0YxRd0U3sqCvJXbvVo7t7Gdx1Z4xoPcKx1gBcS1EYXTuh248T7dR
 Eop9sdiUxJcfcAgIQ8BhngAtwmZWAsHas+S3BkM2Dqqd7SBiETvoq5q38CpjZC0=
X-Gm-Gg: ASbGncsr6vE285Sp+LMljzh1XlGSnfPg5O3TQh4Imt65UgADFGUIMHbEzn7h0+2fWmx
 cOtX0D7sEfuIhLhY79EMKIvCztTsu2rl4sQvys9L53/SWT2f9EvqBQ3Ixu97pbfypti+TtzfWPT
 tOFEz0xnU96aXuyGpEXB64oGKmh0u7AyC0JBVc6g9EvQDbNAhA92Ju/j0zXQuatUHoa+R7MU/Zm
 k8SG/PsaNQCzMsZSMZIGcEzcPOT/QmPvze31NNjuErXl/akBINgf3HmJG+xahsoIH+ec2ZzgkgY
 8GLHsxQjJRtVVLPOcGh4uIXcAxB6oHWDJuGhl3KWXSjYGmxWO6bctw==
X-Google-Smtp-Source: AGHT+IFxfedK+OrmGZ/sPX2yazD1WVJ9rxL2oeJs4YinKu69lXupMn9+yw5BEgQgPlVmNxcOvr7WLA==
X-Received: by 2002:a05:6a00:1488:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-7423ba87372mr1194252b3a.3.1746735605269; 
 Thu, 08 May 2025 13:20:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2351b7a6bdsm237359a12.69.2025.05.08.13.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:20:04 -0700 (PDT)
Message-ID: <1dcff322-02d4-4191-893f-4b3178aeea92@linaro.org>
Date: Thu, 8 May 2025 13:20:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
 <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
 <aBsISp5UvOLzFhqn@redhat.com>
 <51c4e997-8ae4-43a5-81b7-561c035ba85c@redhat.com>
 <0657578e-3825-407b-9837-1e29717f94e2@linaro.org>
 <13eda815-02a9-4bf3-8892-3225a27c0691@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <13eda815-02a9-4bf3-8892-3225a27c0691@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 5/8/25 3:05 AM, Thomas Huth wrote:
> On 07/05/2025 20.45, Pierrick Bouvier wrote:
>> On 5/7/25 12:39 AM, Thomas Huth wrote:
>>>>>> Then I don't understand the previous argument from Thomas to not make
>>>>>> thorough the default: "The thorough functional tests download a
>>>>>> lot of assets from the internet, so if someone just runs "meson test"
>>>>>> without further parameters, I think we should not trigger these
>>>>>> downloads in that case". It's what precache-functional is doing.
>>>>>
>>>>> precache-functional is *only* called when you run "make check-functional",
>>>>> i.e. when you know that you want to run the functional tests that might
>>>>> download assets from the internet. It's not called when you run the normal
>>>>> "make check".
>>>>
>>>> Are you sure ?  If that's the case it was *not* my intention when i
>>>> added precaching - I thought that "make check"  would call
>>>> "make check-functional" and thus trigger precaching ?
>>>
>>> "check-functional" is not part of the normal "check" target - on purpose
>>> since we don't want to trigger downloads by surprise when people just run
>>> "make check". That's also why we have separate "functional" CI jobs in the
>>> gitlab CI, since otherwise this would be handled by the normal "check" jobs
>>> already.
>>>
>>
>> `make check` calls build/pyvenv/bin/meson test --no-rebuild -t 1, which
>> triggers func-quick by default, triggering associated downloads, since
>> QEMU_TEST_NO_DOWNLOAD=1 is not set for this target, except if I missed
>> another hidden hack somewhere.
> 
> You missed the fact that the "quick" functional tests do not download any
> assets :-)
>

Hum...... (fact push -f on my brain).... ok.

> I know it's confusing since the name of the suites rather indicate something
> about the runtime of the tests and not about whether they trigger a download
> or not, but the suite names are so deeply glued into the "mtest2make" logic
> that I was not able to come up with a better solution. Maybe Paolo or some
> other Meson expert could clean that up, but for the time being, for the
> functional test we have:
>

I understand there is sometimes a rationale reason behind things, and 
most of the time, historical reasons.

> - quick tests that can always run (also run during "make check")
> 
> - thorough tests that download assets from the internet (only run during
> "make check-functional")
> 
> I tried to document it in docs/devel/testing/functional.rst in the "Asset
> handling" section already, please have a look whether that's sufficient, or
> whether you have some ideas how to improve the situation.
>

Indeed, and I remember reading this when I started working on QEMU, but 
not really after spending time to craft the "right" command and keep it 
in my aliases.

In general, having documentation is great, but I would still favor 
intuitive commands and defaults over a lengthy explaination or this 
email thread, but as "good defaults" and "intuitive command" is 
definitely a personal judgment, and not something objective, I'll simply 
accept the current situation and move on.

>    Thomas
> 

Thanks for the insights,
Pierrick

