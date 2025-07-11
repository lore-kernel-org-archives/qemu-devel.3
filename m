Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063C2C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 16:18:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaGRI-0000GE-1V; Fri, 11 Jul 2025 12:17:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uaGPN-0006ic-4k
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:15:36 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uaGPK-0006RN-Ql
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 12:15:32 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-749068b9b63so1632583b3a.0
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752250526; x=1752855326; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6HBYgpqhq43kLP/CAjgQ8dfvFOzmWLdH7bSoaJLU9A=;
 b=E9NOa5L8/ke44hE1Mx1HAYa9yvEOxJHjmnUAIEQT1o7+BDYl48PwdSbiiAeWPPq1oV
 ZTVGWZyS/9LSmMrHAESgSgxWidqgwA+RGN7SFnA6PEPysU05LffvH9D5oF9wtmCO1FyQ
 qnnvxvPH6QP369F43qRRuOI+9O/uz8/GFoymUXJeL3txvcDWXkRW9hPispI6ricV9TjE
 itopIXJoMTRJoocsgdWL6ZSQVENl1sMLtF370Ie4fFKLfLsjJi5LZETJQthPUh4SYs6P
 a6iXwPkwmBof4+/4//Ar8PmUr5XShFLecLHbs8YHYWUIHAAiBj5uVulefv9JrCKXD7YQ
 wLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752250526; x=1752855326;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6HBYgpqhq43kLP/CAjgQ8dfvFOzmWLdH7bSoaJLU9A=;
 b=VDoxOB25MegF3X3LhC/e88ij1fXMyEI9KQbJnBPe0PmSydgiKXZ83I9voTOlkKK+D8
 RqYs7CVVN4If09YuwWTAHIvd1Yu6bkkFUSmMJ/cYwHDaGx1Mk0dcatbtBr7rTD0MyVlk
 24Ij7PXIHmjbjHGLDQjXMO0IQvGraodLfRzDul2YTkr53YNAIPib9ny3DS8XGExrudPu
 +KRs5PodcT/karChpnohozp1tXKfuC57ocFeOhQqDrSXyy7G61htQucJAAeFhJ7DIIW4
 A/dwVbCs5+WStu3Y4PGcngpdsZRnC7RCd/Fs/UIJDHXbtT7ruCUExhiWR5sUhanO5bux
 mGbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXkdbwyOO0A37dre9pH4OlhrF79MfxonuP2P3WvbgdgdJqwPYeA5riDNe5zVwAmgJRz0Z8h0yi3AEi@nongnu.org
X-Gm-Message-State: AOJu0Ywobf4HZCaLfoJx9tAmeFJaSG7LRApCwjZ04GT6Yavu8kIRYxEr
 xey7e2dOOobqoY2KyKWuRZ3qJvFOYt1DIZ859Vu7NO8piiDO4sQB9ymBLOMi8fqHNwg=
X-Gm-Gg: ASbGncuv1geDUTZtRJ51+aBsmJrjCiHFRj6N7wU0M+jiXXQ3lQW5mUUYSVHos0LSC1Q
 drHAalK7m7vFH60sevwctHpoitqI336ZMBisV1qxdfTjw678mJNJqkw+Fzyf60IYf7rZxH8Qvmp
 YYig17N66oVYFbq2idhSTaWVh23ZGYT0yN2K2R16mfjiBu1L39tullb9RfcU0ToX3Hnig8EDHlC
 rBX/jSLRI91uj1oN2ENC+38q0zxlk9qYyIA5eG/RawnFtKwhbi8hDaSX5eeIZFsCJ0cjASvY1qL
 Kw6FYT4jZjrYJWjHNNPqwRrPJ+yTq7h9x+npnQDIY/ysWpQUHOaIrbnFWVTMEU1zgWCibWuvySD
 QylHQD9DODmVPNt7gr+4FnTb8M2ffZ1Wpz/8=
X-Google-Smtp-Source: AGHT+IEH0TJ0IGqQC5mKu0bwf52NWNFjYMZCjL8FYQWrqLmizGzABahU5kJw6M6w2Yx38N79ed6zpQ==
X-Received: by 2002:a05:6300:6c09:b0:231:c295:136d with SMTP id
 adf61e73a8af0-231c29523bdmr2635525637.14.1752250525789; 
 Fri, 11 Jul 2025 09:15:25 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74eb9e06bd7sm5798268b3a.70.2025.07.11.09.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 09:15:25 -0700 (PDT)
Message-ID: <6d3cef20-9655-462b-8418-55e68caafea7@linaro.org>
Date: Fri, 11 Jul 2025 09:15:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/functional: Move tests into architecture
 specific folders
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250710094251.139514-1-thuth@redhat.com>
 <643f1db1-4a7a-4bc0-a187-9ff1561f8a3d@linaro.org>
 <8f90fbd7-1edd-45cc-9540-06fd9d0ee978@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <8f90fbd7-1edd-45cc-9540-06fd9d0ee978@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 7/11/25 4:55 AM, Thomas Huth wrote:
> On 10/07/2025 17.51, Pierrick Bouvier wrote:
>> On 7/10/25 2:42 AM, Thomas Huth wrote:
>>> This patch tackles two issues. First, the tests/functional folder has
>>> become quite crowded already, some restructuring would be helpful here.
>>> Second, we currently encode the target architecture twice in the test
>>> names since a lot of the test file names contain the target, too.
>>> This contributes to the very long output lines when running "make
>>> check-functional".
>>>
>>
>> I agree with the "crowded" aspect of functional tests, and subfolders are
>> definitely welcome.
>>
>> Concerning the long line, it seems that setup ("thorough" in this example)
>> is repeated 3 times on it, which is a bigger issue than having arch name
>> being repeated.
>>
>> A simpler solution for the "long line" issue would be to change
>> mtest2make.py to generate shorter test target names. This would not benefit
>> for using meson test directly, but from what I understood, this is not
>> recommended nor supported anyway.
> 
> I agree that this is a bigger annoyance here, but as far as I understood
> that that repeated "thorough" term is just a listing of all the test suites
> that the test is part of. I think this would rather need to be fixed on the
> meson test runner side - why does meson list all test suites here? The one
> that applies to the current should be enough, shouldn't it?
>

Meson is usually explicit (thus sometimes verbose) and unambiguous, 
which are two very nice virtues, especially for build systems and tests, 
at least for my personal taste. You don't want to spend time reverse 
engineering the test infrastructure itself when you try to understand 
why a fail happened or when writing a new test.

Another additional benefit of listing setup + suite + test in an 
exhaustive way is that your command line never change to run any 
specific test, whatever your current setup is.

If I had to choose between a wider terminal output and spending time 
with grep and find to understand what is running, I would pick the 
former any time.

Maybe the complexity comes from our usage of test setups here, to 
differentiate categories that will download, vs the one that will not. 
We already talked about that in another thread, and I still think that 
having a single setup (thorough), which could be the default, would make 
things easier, even if people should accept to connect to Internet from 
time to time to update their tests assets. They do it to download new 
versions of QEMU or interact with the mailing list anyway. That said, 
I'm not trying to open the can of worms again, just pointing that it may 
be related to this topic.

>    Thomas
> 

Regards,
Pierrick

