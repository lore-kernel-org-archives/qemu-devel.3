Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 613C5C5B552
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 07:55:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMixo-0003yN-IK; Wed, 04 Jun 2025 03:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMixm-0003xZ-FJ
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:55:06 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uMixd-00037f-LX
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 03:55:04 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45024721cbdso52120855e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749023675; x=1749628475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q9rH8N/xktzUuTF8pff0+zIPZHrX9JYdkAgmd3Na818=;
 b=FFhM1sWwePi6D528XtFg19+FzOE/rwm5+ER+GqytHV8X4L91hQxfEReevthqaKq/Hi
 UGbu8ieRrpu0JcZ7toerH1mV4uqBAWpgthrhtADHIBzRpGZIyf2keyxZMvw4U2Xl8tcs
 T/5q+dQ9eGP3loPKj0prOTdjRG7mdczbCF18x/SFX0f2Tllt+jUQxBJPV9KXyFQOr6xB
 M1c1q082B1niqaiGlXSZL+/+DpPVtedNYQt3JNLzdgdt0OQuwxf7BL1661ZPQXq8oOhI
 on0/ha48+ib18u7cbh4BUdXuo8z/dSft1nia+YH3cahYM3AIGappd9u3I7hQjyPpEtr6
 C+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749023675; x=1749628475;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q9rH8N/xktzUuTF8pff0+zIPZHrX9JYdkAgmd3Na818=;
 b=B8CEnFSdmYyvZf2amGdw3DZsyaCX6GRM1OLhUbWDItJnOltYC2+0RfYDFzIopD0Lnh
 cLUMVZVH/1Y2M+yvoelzGnU9c35Oi0yQlWtYkAIyRI3lrbUEnavYc+yuCGgVXWWHf00s
 b89zuv89c/ejLGYCkqKsyGxdUHgz6uUAF/7s+Oj7RUHm71TVVscSK2PbTBWkc1onMJr1
 JUbnsKT3g5TtDtV+zZIwCIJIQKAnghL7b+JfXfquvYsCb/8A5QDqm2WB1ZcEECdpGlv5
 VN+T+9mGOxFC7HF07/QExJ6wY6Ne4kn4339J2IOiYlMdYzCmh7/hDlvP6L3gl9hkDwWR
 HS1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0OAE70R+4/FSHFl5FdP3Ma/DaC83BTG0Gx7VfN5cgtbKo9TtrC4cWcY9MSx9j1t5rh8JwHSgLgl0D@nongnu.org
X-Gm-Message-State: AOJu0YyV2SEsbQo43a15xAMieHNp23hv0q/6ZSHCSWPBYjt8C7At2Bb/
 OSVjJakvEAfFMfeV60WxMFUJ0bT0Dz4d/hieFEW3VY69+HCHnU/LS/TW9ZQkEjW1ZHM=
X-Gm-Gg: ASbGncuV9/VvrXfuUmU3Xw5T+7wnW37vSFALP86IQS7b3j1DrYeXbL6mLhE09kga5bF
 CVz2oF/Nmvpqb2edExpkAug+AKvuCSqIejeTvTUqgfAARJAlLN9glHtiXCfRn7+wsISOEhlXbHQ
 HGP/KktiO9DFDl/pVUADcQB3G/WVpdV2teHHFHXikYQ7UsX3gfilA8opVApiL9onwhfAl6L952O
 ALY2+Ln/HTHdX2ZHGObYwn+EYOh9tMe/FnOhBlaYxsPkAeh00GZ9LyYvKdptXZNqjv6ORiu7SOn
 1TmvsptV3VhD7WVcBWke8LF4E5YgNlABQTRWt3wy/gXn390qVLFTl9ujyhvvXrmzBi4X4Rr8C2i
 BErw2QU4kur+bMFPov8zgwlh94ZNNqon/4jOXmb6F
X-Google-Smtp-Source: AGHT+IGjcJbgrZ275gtggEojUk3WRYhVxr3hKoHBStsbuEphPpRXnAE31WfGZzfN2B+WdMNPuMqLpA==
X-Received: by 2002:a05:600c:190f:b0:43c:e7a7:aea0 with SMTP id
 5b1f17b1804b1-451f0b2c2edmr11515515e9.26.1749023674993; 
 Wed, 04 Jun 2025 00:54:34 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7f8f1basm192241075e9.6.2025.06.04.00.54.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Jun 2025 00:54:34 -0700 (PDT)
Message-ID: <3df2ae5d-c1c6-45ee-8119-ca42e17a0d98@linaro.org>
Date: Wed, 4 Jun 2025 09:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <CAJSP0QUGaQEwhVh_w6Wbdm-Nqo_2kHcb+eS2Simq-x9J=-7qkg@mail.gmail.com>
 <87a56o1154.fsf@pond.sub.org> <aD_yhelX-w4Vdm8Z@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aD_yhelX-w4Vdm8Z@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 4/6/25 09:15, Daniel P. Berrangé wrote:
> On Wed, Jun 04, 2025 at 08:17:27AM +0200, Markus Armbruster wrote:
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>
>>> On Tue, Jun 3, 2025 at 10:25 AM Markus Armbruster <armbru@redhat.com> wrote:
>>>>
>>>> From: Daniel P. Berrangé <berrange@redhat.com>
>   >> +
>>>> +The increasing prevalence of AI code generators, most notably but not limited
>>>
>>> More detail is needed on what an "AI code generator" is. Coding
>>> assistant tools range from autocompletion to linters to automatic code
>>> generators. In addition there are other AI-related tools like ChatGPT
>>> or Gemini as a chatbot that can people use like Stackoverflow or an
>>> API documentation summarizer.
>>>
>>> I think the intent is to say: do not put code that comes from _any_ AI
>>> tool into QEMU.
>>>
>>> It would be okay to use AI to research APIs, algorithms, brainstorm
>>> ideas, debug the code, analyze the code, etc but the actual code
>>> changes must not be generated by AI.
> 
> The scope of the policy is around contributions we receive as
> patches with SoB. Researching / brainstorming / analysis etc
> are not contribution activities, so not covered by the policy
> IMHO.
> 
>>
>> The existing text is about "AI code generators".  However, the "most
>> notably LLMs" that follows it could lead readers to believe it's about
>> more than just code generation, because LLMs are in fact used for more.
>> I figure this is your concern.
>>
>> We could instead start wide, then narrow the focus to code generation.
>> Here's my try:
>>
>>    The increasing prevalence of AI-assisted software development results
>>    in a number of difficult legal questions and risks for software
>>    projects, including QEMU.  Of particular concern is code generated by
>>    `Large Language Models
>>    <https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> 
> Documentation we maintain has the same concerns as code.
> So I'd suggest to substitute 'code' with 'code / content'.

Why couldn't we accept documentation patches improved using LLM?

As a non-native English speaker being often stuck trying to describe
function APIs, I'm very tempted to use a LLM to review my sentences
and make them better understandable.

>> If we want to mention uses of AI we consider okay, I'd do so further
>> down, to not distract from the main point here.  Perhaps:
>>
>>    The QEMU project thus requires that contributors refrain from using AI code
>>    generators on patches intended to be submitted to the project, and will
>>    decline any contribution if use of AI is either known or suspected.
>>
>>    This policy does not apply to other uses of AI, such as researching APIs or
>>    algorithms, static analysis, or debugging.
>>
>>    Examples of tools impacted by this policy includes both GitHub's CoPilot,
>>    OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are less
>>    well known.
>>
>> The paragraph in the middle is new, the other two are unchanged.
>>
>> Thoughts?
> 
> IMHO its redundant, as the policy is expressly around contribution of
> code/content, and those activities as not contribution related, so
> outside the scope already.
> 
>>
>>>> +to, `Large Language Models <https://en.wikipedia.org/wiki/Large_language_model>`__
>>>> +(LLMs) results in a number of difficult legal questions and risks for software
>>>> +projects, including QEMU.
>>
>> Thanks!
>>
>> [...]
>>
> 
> With regards,
> Daniel


