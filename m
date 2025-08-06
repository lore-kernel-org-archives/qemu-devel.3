Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A578C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 20:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujkix-00052M-Fj; Wed, 06 Aug 2025 16:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujkis-0004sh-F4
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:26:56 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ujkiq-00015M-5f
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 16:26:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-74264d1832eso477511b3a.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 13:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754512010; x=1755116810; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aoS1iXqFbikl/ZKjVvQn0U0lExDSvkthfBM0pQOPI1U=;
 b=mlxzEFIWJ0hw2a8LqUnqaBxTX5fVlAyU1D67UtW1qnvMEhb9OxD/ZVmp2wiW+OwHvh
 /G2Dhh8wFFFnKLDJF6iec6GtY8lH2rrdWYVnu6XV0Yw3RG5cLhl2GHM3kAPIGHuc161h
 NNP33s3hTxLxvUPXeq/IqutUsvJhqH7GBWdArQjUHyvqLXk5Rlo2h5joHTa8uxEhgL8k
 D8+dfdI1zzwsqL8rkGpLKUur9N/Z13kVgt7skc27JE8ff/mf5vKRxBlgcUPIvTXfTECe
 GkBnWBzrkzDLie1HLDu/hPG1SAp9tuE0tizExoVujd94w88a4wyz0dSRQ3BvVjPknHr6
 z//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754512010; x=1755116810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aoS1iXqFbikl/ZKjVvQn0U0lExDSvkthfBM0pQOPI1U=;
 b=SdS8h5fnBSjZa6houS3V5V5vwyEJXh3fil0xUn12a81cfUcf4ahXAQzFHPVrpP8d+5
 Py5oyZH6HIqVC+Jho+9zUcv61U5P8IUS3c/WVoHSRaKWRGvG7QBV01IghZGnLZVzOKNy
 m8o7uAdCtCkHbzcuu33FS8wkXTYipV6RhLMdMspaEp+MF4soQ8e/CAQ5Rr9NmEaR86gX
 8t8o391iX430Nv3w6/W2yTMC4u6wgQDo7I3UzJK49OXpdJuLTH5Rpvi9Sj4UeVqXBqIL
 sZjgfP1Qan5W6hTayaQHAsljod6qvvuPs5/x8dCAzAZ0eB1SiGktYXRLRzpIV+H4hEpT
 w7Kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgS+PPGEM7ordFMBJj2eZnExZf5iA/bqZ0G6ExQ7wXM6pagCx1E0X1DfS1mo53WUYuz6F0tNV5NHZA@nongnu.org
X-Gm-Message-State: AOJu0Ywy858t2fWJPM5EVmQEqRTTo5mcvykoceEZo2z71uRgS1YBjtXe
 +gTtqtUTfnTlJ6cIPUooXraYRXtgnw6/5x2XwKT6kdlSJkgHoDstStxDeltaw1oUquk=
X-Gm-Gg: ASbGncuNxQHD/66634qh8hWKIZ6mLwnvv6N+QzA9ScK0bjJepV/LTn/3zBXsm65vzrY
 fcMYrnboemC+itiCxIdlJkuwdAJCVt7WdJ6If6VxF46caEUN5aGNiLv7wPo0x/13CdUNnqfw/uI
 sI2oWQalGgOGNB1gdsUBh9RKP1jLPpZd+xmpRl7tSg0ANfOCPfVnOQjjxOiueCXub/M7xj+Ew/v
 dSpLz5KcNKbPXB0tjZMVtAIRsUZB/AfDn+1evtmjpnE6O8JXfxkdAB7gRPPRi+1V5WNOwQTHyKO
 tyChbTGSIg7F36GY+a6bW2XqZESuQSyA7DyW9yw0Cc+ExKCIABdjspt0uXozEAGllMxnYtsH3+7
 JrzQZfabV5Dd3I9itVReSKkf5DsIri10AThQ7+Jc6cHg3Vw==
X-Google-Smtp-Source: AGHT+IH4vbmiPLTx69G4be6rZLwQHJuF+SFfXHfWY0GONOWXq8yf3U0JzrMDFnKvasWiHopOnSj1SQ==
X-Received: by 2002:a05:6a20:7faa:b0:240:1e97:7a19 with SMTP id
 adf61e73a8af0-240331091ccmr6246531637.22.1754512010033; 
 Wed, 06 Aug 2025 13:26:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd18c9sm16144642b3a.91.2025.08.06.13.26.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 13:26:49 -0700 (PDT)
Message-ID: <62284106-30c9-4e30-8b97-ef38f920d237@linaro.org>
Date: Wed, 6 Aug 2025 13:26:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] util/error.c: Print backtrace on error
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20250805-backtrace-v1-1-d189d09b1e92@linaro.org>
 <aJIqdQSYXO4K6lCJ@redhat.com>
 <CAAjaMXY1ytnhp+APdwM39-K=Mu=5p8W=MEUVvLers3M=rLS6Qw@mail.gmail.com>
 <aJI18an38eBkVL-Q@redhat.com>
 <CAAjaMXZhFM7keE1abmhQqehsZn7LaJXwYvUAuOvd-MdNTYtw1Q@mail.gmail.com>
 <aJJGvL8feHr7Wme7@redhat.com> <87h5ykzout.fsf@draig.linaro.org>
 <aJM9v0ASQOPWzcQ9@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aJM9v0ASQOPWzcQ9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 8/6/25 4:34 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 06, 2025 at 12:11:38PM +0100, Alex Bennée wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>>> On Tue, Aug 05, 2025 at 07:57:38PM +0300, Manos Pitsidianakis wrote:
>>>> On Tue, Aug 5, 2025 at 7:49 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
>>>>>
>>>>>
>>>>> Was there a specific place where you found things hard to debug
>>>>> from the error message alone ?  I'm sure we have plenty of examples
>>>>> of errors that can be improved, but wondering if there are some
>>>>> general patterns we're doing badly that would be a good win
>>>>> to improve ?
>>>>
>>>> Some months ago I was debugging a MemoryRegion use-after-free and used
>>>> this code to figure out that the free was called from RCU context
>>>> instead of the main thread.
>>>

I ran into something similar recently [1], and it was a pain to 
reproduce it. Luckily, I caught it using rr and could debug it, but it 
would have been much easier to just get a backtrace of the crash.

In this case, it was a segmentation fault, which is not covered by 
current patch. Which brings me the thought I share at the end of this email.

[1] 
https://lore.kernel.org/qemu-devel/173c1c78-1432-48a4-8251-65c65568c112@linaro.org/T/#

>>> We give useful names to many (but not neccessarily all) threads that we
>>> spawn. Perhaps we should call pthread_getname_np() to fetch the current
>>> thread name, and used that as a prefix on the error message we print
>>> out, as a bit of extra context ?
>>
>> Do we always have sensible names for threads or only if we enable the
>> option?
> 
> I was surprised to discover we don't name threads by default, only if we
> add '-name debug-threads=yes'.  I'm struggling to understand why we would
> ever want thread naming disabled, if an OS supports it ?
> 
> I'm inclined to deprecate 'debug-threads' and always set the names when
> available.
> 
>>> Obviously not as much info as a full stack trace, but that is something
>>> we could likely enable unconditionally without any overheads to worry
>>> about, so a likely incremental wni.
>>
>> The place where it comes in useful is when we get bug reports from users
>> who have crashed QEMU in a embedded docker container and can't give us a
>> reasonable reproducer. If we can encourage such users to enable this
>> option (or maybe make it part of --enable-debug-info) then we could get
>> a slightly more useful backtrace for those bugs.
> 
> The challenge is whether this build option would be enabled widely
> enough to make a significant difference ?
>

For developers working on crashes/bug fix, it's definitely a good 
addition (could come with --enable-debug for sure). It's something we 
could enable in CI by default too. Usually, with sanitizers, the 
reported stacktrace is enough to get a rough idea of what the problem 
is, without having to use any debugger.

> I don't think we could really enable this in any distro builds, as
> this is way too noisy to have turned on unconditionally at build
> time for all users. Most containers are going to be consuming
> distro builds, with relatively few building custom QEMU themselves
> IME.  We might have better luck if this was a runtime option to
> the -msg arg.
>

Regarding the outside world and users, I share Daniel's opinion that it 
would be too verbose if a backtrace is emitted with every fatal error 
message.

However, I think it could have *incredible* value if we reported this 
backtrace when QEMU segfaults, which is always something exceptional.
In this case, we could always enable this.
It's not covered by the current patch, maybe it could be a great addition?

Regarding binary size increase due to -rdynamic, I already know some 
people won't like it, so I'm not sure how we can ensure to have useful 
symbols in distributed binaries, which is a harder debate than enabling 
backtraces on segfaults or not.

> With regards,
> Daniel


