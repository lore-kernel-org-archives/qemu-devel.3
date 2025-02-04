Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F1DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 13:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfJA2-00031E-L1; Tue, 04 Feb 2025 08:40:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfJ9z-0002zb-5w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:40:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfJ9x-0001nw-7z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 08:40:14 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso55961315e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 05:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738676411; x=1739281211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4abu7DgodGgrUEXih3A/ZeH1z0OLewVueM3xF7MKAsI=;
 b=NQHe2YcOrnIg+Bgt41uaOW82zEwzlQ15v3n1R1cHQys9cYsk3JBNBvZ3xT/4mhNr2L
 snW5q17j3LliwbkwhoL69IXOjduUMlZf4woinV4k7VdJ7aVZa0X5GfDK+q2O7eK2y+tf
 Qe6mdzfcvxzmWmSnWw5i6Y/qy25uuVQTB2rBEzJT7bTUPIJp3JzC5ouydpeZ4vU69UUa
 /AVIt11gG3l5vZhI6OWh6SJC0PmKSGokJiVcO7w8+pbZYez7CE38RIFl1SUlcaVJiQDX
 NIBSEMjRZvakZXOD4gZH3Qwcd5oxQlj58f25HfauTuAAd7NC8uGe3puZOTWvTwtb/3Ay
 U3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738676411; x=1739281211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4abu7DgodGgrUEXih3A/ZeH1z0OLewVueM3xF7MKAsI=;
 b=P8mLhSrFytAOCeRudc1VHcIH6a6f1wenymivouyd/h7p/KwiTZmaCsO6Y3JMR6ac4b
 nlgXXczaj0Zk0AZuW+Xdbk9F+IAECAWJgyjrUi4cHLZ7YwC/F8Y9grWKDWL/QDyDQXTp
 J9G2K5JzGY47cK/2vfNIB/yamtyGs+Vu64ilxXwS7rY2XMWIKZ6JFGs13+nK/VBAEUgY
 s7Kw2zmyHkzNR/b8fiC9h7XKxx3cjvsV7fXCFtE+XHLJ7vIR3NGbF5HawLnOWXtlHdbF
 DPcfw6S5B70pMl0z5kUKbnJF8dIrgiEbH55ZdkCFLMcg7wUMmhTBtbPFxuvwFKqGmHIQ
 long==
X-Gm-Message-State: AOJu0Yyg0BypFhu8ReVjYVOFonXM02FlpqMjuMLdT7kv9vINdqHj/Pav
 YXNgCcFXLWVk8tJ9YveZ+To1zvEUTA2lQK5BRUynnIi1yhqWrOnO6JLZ8X6dT40=
X-Gm-Gg: ASbGncsAEHxnbW2s40hM+MQzaCTOoNMUA12DShN7zHEeCJQr7gm9T7lj/zztNvXnhRj
 8HPfUuyHmBr0GicC+gBD4BZZ8hPV6JsE+iFAlG2fjMCdaEaCFdeEnqCWB7vWbdWU9sJ1pBDo1xC
 +oRIXN1CDGtEG3xxgN52ft0zqK7SCU7ikJQgND2ieHfLI+MIK2z2IxYCfKZ5V2Jmc97s9InTmu5
 +KzMU7+W0Qj+J4VBV5g7i1jw1QG5ZwC93Csnc7p1IygFPLqKcYbqW7RT/XVFpphYRQS5BOxI+l9
 OjqPo09BNGIzhiF1simsgmqc49V6+9t+74tmo/vu8aBxpEBLcJd5kZCAYHc=
X-Google-Smtp-Source: AGHT+IEeJDWMdGayWk7JCYoXQIneANAogcQLAXjc6zdz8z0r5MNgtUPRr0BH/wOzOgyk+Ggt2TjPbQ==
X-Received: by 2002:a05:600c:4f83:b0:436:713b:cb31 with SMTP id
 5b1f17b1804b1-438dc3a904cmr216578035e9.3.1738676411275; 
 Tue, 04 Feb 2025 05:40:11 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc27125sm223275395e9.15.2025.02.04.05.40.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 05:40:10 -0800 (PST)
Message-ID: <8616891b-9747-4388-99dc-d6e53e090001@linaro.org>
Date: Tue, 4 Feb 2025 14:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
 <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
 <Z6HklNsu0Mzgh7bC@redhat.com>
 <CAFEAcA9m8g=K-0RU31kswbNSKWnUqA78KxNkcXEAqR=BhWc9bA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9m8g=K-0RU31kswbNSKWnUqA78KxNkcXEAqR=BhWc9bA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 4/2/25 12:13, Peter Maydell wrote:
> On Tue, 4 Feb 2025 at 09:57, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Feb 04, 2025 at 10:51:04AM +0100, Philippe Mathieu-Daudé wrote:
>>> On 4/2/25 10:22, Peter Maydell wrote:
>>>> On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>>
>>>>> All previous raspi machines can be created using the
>>>>> generic machine. Deprecate the old names to maintain
>>>>> a single one. Update the tests.
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>
>>>>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>>>>> index 4a3c302962a..c9a11a52f78 100644
>>>>> --- a/docs/about/deprecated.rst
>>>>> +++ b/docs/about/deprecated.rst
>>>>> @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
>>>>>    Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
>>>>>    CPUs. Big endian support is not tested.
>>>>>
>>>>> +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and ``raspi4b`` machines (since 10.0)
>>>>> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>>>>> +
>>>>> +The Raspberry Pi machines have been unified under the generic ``raspi`` machine,
>>>>> +which takes the model as argument.
>>>>> +
>>>>> +    - `raspi0`` is now an alias for ``raspi,model=Zero``
>>>>> +    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
>>>>> +    - `raspi2b`` is now an alias for ``raspi,model=2B``
>>>>> +    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
>>>>> +    - `raspi3b`` is now an alias for ``raspi,model=3B``
>>>>> +    - `raspi4b`` is now an alias for ``raspi,model=4B``
>>>>
>>>> This is not how we typically handle "we have a bunch
>>>> of different devboards in one family". What's wrong with the
>>>> existing set of machine names?
>>>
>>> Zoltan and you don't want to add more machine names, then you
>>> don't want a generic machine. This is very confusing.
>>
>> IMHO we can have distinct machines for each model, but
>> *NOT* have further machines for each RAM size within a
>> model.
> 
> Yes, this was what I was intending to suggest. Apologies
> if I was confusing with what I said the previous time round.

OK, let's see if we understand each other correctly as developer,
before explaining to users, taking the 4B model as example.

The 4B come in 4 physical variants, depending on the amount of
DRAM: 1G, 2G, 4G and 8G.

We can not allocate 2G on 32-bit hosts, so to have a reproducible
guest behavior on 32/64-bit hosts, it makes sense to takes the
model with 1G of DRAM as default for the 'raspi4b' machine.

If an user specify -m 2G ... 8G, we can adapt the 'board_rev'
register to expose the corresponding amount of ram. Now, how /
where to tell the users 1/ the default is 1G, and 2/ they can use
2/4/8G?

