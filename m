Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64211C83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 17:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uduK5-0003of-BJ; Mon, 21 Jul 2025 13:29:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uduJY-0003Tw-0J
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:28:50 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uduJT-0002Ef-91
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 13:28:34 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3190fbe8536so4008458a91.3
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 10:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753118908; x=1753723708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SYUEsc7uOnRYYLbS1OL1gBCrJB4f0fgeoK/uvkLJMfA=;
 b=dBq4GQjojVBM25ihe5BGvEhSxUcJTEi/86r7CbL+YmS45kzySGG+WDoh4R845vcJrs
 Bx/+ewu435xuvz8UbyYcVHaNIpiuNm8zr3DRZDvzZn7vYrGqUWQk7XY6FjYtiM9T9sQW
 NbxpLrFekU3P8u85HBo6282b2UIG7JLWupm0DD0HYiHy3O3O/sP1SdSWxnJ5bsBi9HpA
 tYvs1/kuNE+xje3Emr3gyQ/YEkGHYvo+1FDmnwA/c44h/BllYSdFQInlPpOh5U96Lt+p
 XRcwHfteIeSbhvAzCu11KKGW2cXP5H5C9U5mO4Jk7QK24I7sUnUVjdu6CEkTFRQYMnef
 NmHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753118908; x=1753723708;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SYUEsc7uOnRYYLbS1OL1gBCrJB4f0fgeoK/uvkLJMfA=;
 b=UrKJznaqtr1qOQtvcJZbVhVE/uPxApEnFSI4ax7XmiLWT0rzkNho0ppalmNlkHc6TA
 idXO1bE6zZWCCZJdr/U4zjcUHzP1aXwuHspdKIr8y/13Wn3FVLPqpkwPiKXVQtE5Pqx1
 F64onkHbzfhqz95XNoofPgCxialquu/URqu5w1antR/NicXF8D0dnhnrPFs70d9biCCb
 T08RwoT0Hill77zADcolqLCHD4T3wslxCgB5zhqP1K7NCJWAnVD8o0FCcF29A1xTqtQE
 coO81u7a5yWuL/JkxqzqiEJbI+1pzk5UAreiH5v4zN2aTN2FYKZZLitIO3RoKfT2LIP8
 b98A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfMLXfy3tdKKox3QJtwzLJI5StGrzgXUSK9DRTHQ3NaujBsg2Vur/Ni8cXLX5wTldsNPZ3rQHAk7/0@nongnu.org
X-Gm-Message-State: AOJu0Yzxyv+M3QGyTmoi2nl3oEWmOatgh1YPPmY0DFMEs/+p3J9wkQvu
 WqE5EVDFzVa2dHhttAilnhtoDjDWR2Al1rC1bxIcQRWLMTbzVoRvFoN/yAN8cVk0RCQ=
X-Gm-Gg: ASbGnct5Cejo91WCsc3JAO8uSmmRE7Uk9urKc3bgvr8nYHrFnbqheRkfVxJyEEvFTWX
 BH5bNh9jSQreun5YfwC8tn0zeSw8rCu0RImvJFJnKrQ83IEC/TbVZFn7i4AeQS8X85HS9OTZvUj
 iRMGR1zjvANbfjIyoC59joyZFYqTSz2JCtfRexBhUrP9H3aAaJPovniUfrRv9Lo36UsP2tE1VYX
 S3ORlp73c9pFdJ9tBC80mMbMxwryb0+ub88a5tI6FhY44drFvlJQ45D/pC3LQDveY6u+iffbzR2
 uDo45NVO2Hj9QmIo5ujJElAO/bEjsf5FjgsL8DGKT3AlriZUTCSzTN8SsGBrmJNZdOw6iSFjUb0
 7zRjaAkhigpxVxgfaxBpo1XVa7kM+2cecmqM=
X-Google-Smtp-Source: AGHT+IHYDyHengtERQdY+dko4YqbzX39gpmzVr/9Ha70Oj9LNxeL+45laxNPPJxsOmhp4L42iJEp8w==
X-Received: by 2002:a17:90b:1fc7:b0:311:df4b:4b82 with SMTP id
 98e67ed59e1d1-31c9f45e1afmr32553722a91.4.1753118907792; 
 Mon, 21 Jul 2025 10:28:27 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f29dde6sm10302349a91.34.2025.07.21.10.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 10:28:27 -0700 (PDT)
Message-ID: <f50b74c1-24c7-4e48-9f42-b6ce721f70d3@linaro.org>
Date: Mon, 21 Jul 2025 10:28:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: apparent race condition in mttcg memory handling
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 QEMU Development <qemu-devel@nongnu.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <abe00af4-3af5-4c6b-8443-b7350a4d9349@tls.msk.ru>
 <96201a23-784b-4268-b011-a6912175d237@linaro.org>
 <c0878723-62e3-47cc-810e-6ba8a0bd30cd@linaro.org>
 <8a50f07d-ef0b-43b1-b49c-335ca6a7ff70@linaro.org>
 <bd3c403c-6aa2-4583-a50a-5cc5fcaca2b8@tls.msk.ru>
 <e1272431-f38d-46ee-8140-38e2c3418399@linaro.org>
In-Reply-To: <e1272431-f38d-46ee-8140-38e2c3418399@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 7/21/25 10:25 AM, Pierrick Bouvier wrote:
> On 7/21/25 10:14 AM, Michael Tokarev wrote:
>> On 21.07.2025 19:29, Pierrick Bouvier wrote:
>>> On 7/21/25 9:23 AM, Pierrick Bouvier wrote:
>> ..
>>>> looks like a good target for TSAN, which might expose the race without
>>>> really having to trigger it.
>>>> https://www.qemu.org/docs/master/devel/testing/main.html#building-and-
>>>> testing-with-tsan
>>
>> I think I tried with TSAN and it gave something useful even.
>> The prob now is to reproduce the thing by someone more familiar
>> with this stuff than me :)
>>
>>>> Else, you can reproduce your run using rr record -h (chaos mode) [1],
>>>> which randomly schedules threads, until it catches the segfault, and
>>>> then you'll have a reproducible case to debug.
>>>
>>> In case you never had opportunity to use rr, it is quite convenient,
>>> because you can set a hardware watchpoint on your faulty pointer (watch
>>> -l), do a reverse-continue, and in most cases, you'll directly reach
>>> where the bug happened. Feels like cheating.
>>
>> rr is the first thing I tried.  Nope, it's absolutely hopeless.   It
>> tried to boot just the kernel for over 30 minutes, after which I just
>> gave up.
>>
> 
> I had a similar thing to debug recently, and with a simple loop, I
> couldn't expose it easily. The bug I had was triggered with 3%
> probability, which seems close from yours.
> As rr record -h is single threaded, I found useful to write a wrapper
> script [1] to run one instance, and then run it in parallel using:
> ./run_one.sh | head -n 10000 | parallel --bar -j$(nproc)
> 
> With that, I could expose the bug in 2 minutes reliably (vs trying for
> more than one hour before). With your 64 cores, I'm sure it will quickly
> expose it.
> 
> Might be worth a try, as you need to only catch the bug once to be able
> to reproduce it.
> 
> [1] https://github.com/pbo-linaro/qemu/blob/master/try_rme.sh
>

In this script, I finally used qemu rr feature (as QEMU was working 
fine, but there was a bug in the software stack itself, that I wanted to 
investigate under gdbstub). But I was mentioning the same approach using 
rr (the tool).

>> Thanks,
>>
>> /mjt
> 


