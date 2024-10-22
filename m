Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A99CDD0F4
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 21:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3MDx-0001Qu-QZ; Tue, 22 Oct 2024 17:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3MDr-0001ND-LT
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:15:23 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3MDo-0004Wk-Mw
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 17:15:23 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2cc469c62so4117548a91.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729631718; x=1730236518; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kKkgM7dsASqeo0rihYPTWcYYx5ZQ3vX4lLAfjVj1vOM=;
 b=TDqlsz6aoxYz7vA91VdBtmeA4JD1SGtvnjFdeRNv8tCKoWxu2KxNjoyH5SgUXdYA91
 OOC7SOcHTKZeXzwDtmvxmE4mgeRZJbxgj0Hpaz1l+1M2IHoPLgGbUC5sbxJkOPI+Eh4q
 B1j/YvqovhMjt76i6KbVvklHAM3mUjBF25godTuBgfSy4CrdhHkGzlKaMt/VBag0Hpgk
 zo0LlcoB+5lc1xwmTiKS3oFqyABopRqnTabScKlnD5PGrLHmCQN6VfMHCk5wgX1j0SZ2
 DIuOTBgvASywh1vjBaWeaByDyJ0NhCMfr2L4X6azVQhz/1brWEGElYBLJ5UEztRhkWHs
 8HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729631718; x=1730236518;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kKkgM7dsASqeo0rihYPTWcYYx5ZQ3vX4lLAfjVj1vOM=;
 b=UTg/eyWW/kqK4Xcl66RIspjruUEhPrQCcgBdRc87pvvnnbmSpvSD1U3wldwEIfRule
 AMejB7vLWsyXz7hadtPRjGAKAxLNhALQtk7KLOmhya5kfGwY4ZJKHUV/sotMPCbO58i/
 wNWJVsHdF00zgkF86OnSpJPBIFOD5mIrjjXGSC/raEcAnLV94czWK0Eu67Ko3o5BPtZj
 ukwoOVXxQ9iRZxSQhJzgbHraUIQvB3dOUFZUbQKcIe6PfklLfVc8jC2bo1AWesTEZJVK
 5SLN1qcxx9Mm+c7vZ9u5eze7x0iSx4OPsZVr3EbOZjEbNq5L1e0BBqsaDlF6EwKSfr4m
 kY+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrk+AMnZE3DurQeJbcK4i8vexue1wHo2cK7qFuuOe2j8LEdN4ZDIwhQzMdANC6v4QxGsrt6LYNCaAL@nongnu.org
X-Gm-Message-State: AOJu0YwEBNFH2hDgBY7IOxz3ks8pJ3P5InKeD4CvJ7KRWXUpKXfXxtKe
 gXyIwrpLdzMUl65xb9SIcUg7OjlmPswQ+UQSDhvHWmEda3iKN5JVQxP/zTxNwQM=
X-Google-Smtp-Source: AGHT+IEK4R4jYsewpCXwohjaUiw6hnNQPY7OkYycaDDuZOgsz1YqEJtoIuEPs/fa/PCtIFw8MVZS/A==
X-Received: by 2002:a17:90a:e7c2:b0:2e2:dcea:2b8d with SMTP id
 98e67ed59e1d1-2e76b5b56e5mr374786a91.1.1729631718057; 
 Tue, 22 Oct 2024 14:15:18 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5df40bf66sm1802649a91.0.2024.10.22.14.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 14:15:17 -0700 (PDT)
Message-ID: <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
Date: Tue, 22 Oct 2024 14:15:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Content-Language: en-US
To: Julian Ganz <nenut@skiff.uberspace.de>, Julian Ganz <neither@nut.email>,
 qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 10/22/24 01:21, Julian Ganz wrote:
> Hi, Pierrick,
> 
> October 21, 2024 at 11:59 PM, "Pierrick Bouvier" wrote:
>> On 10/21/24 14:02, Julian Ganz wrote:
>>>   The motivation for this API is a plugin that simulates a RISC-V tracing
>>>   unit (and produces a trace). For that we actually also needed to
>>>   track the "regular" control flow, i.e. find out whether a branch was
>>>   taken or where a jump went. That wasn't hard, especially considering
>>>   that the TCG API already gives you (more or less) basic blocks. Still,
>>>   we ended up tracing every instruction because that made some of the logic
>>>   much simpler and easier to reason about.
>>>   We realized that we need a trap API because they:
>>>   * can occur at any time/point of execusion
>>>   * usually come with additional effects such as mode changes.
>>>
>> Thanks for sharing your insights.
>> I think there is definitely value in what you offer, and I'm trying to think how we could extend it in the future easily, without having another callback when a new event appear. In my experience on plugins, the least callbacks we have, and the simpler they are, the better it is.
>>
>> Maybe we could have a single API like:
>>
>> enum qemu_plugin_cf_event_type {
>>   QEMU_PLUGIN_CF_INTERRUPT;
>>   QEMU_PLUGIN_CF_TRAP;
>>   QEMU_PLUGIN_CF_SEMIHOSTING;
>> };
> 
> I have considered such an enum, as an input for the callback, as a
> parameter of the registration function, and both. Of course, if you were
> to add a selection parameter for the registration function, you likely
> want OR-able flags.
> 
> An additional input for the callback type would obviously require a new
> function type just for that callback. Since the callbacks are somewhat
> similar to the VCPU init, exit, resume, ... ones it felt appropriate
> to use the same function type for all of them.
> 

I tend to disagree on that. IMHO, it's better to reduce number of API 
entries instead of callback types.
It's easy for a user to understand how to implement a given callback, 
while it's hard to understand which API you need for which thing.

For the syscall cbs, we already have a specific callback. So why not here?

I tend to see init/exit/resume events as different because you can't get 
useful information attached, except the cpu id. But for control flow 
related stuff, you can be interested in having more.

I understand you're focused on those "events" for now, but while digging 
into this, it seems like the initial need was to track the control flow. 
So I would like to push more in this direction, and offer a more 
extendable solution. Do you think the end goal for a plugin using this 
information may be different? (beyond a plugin counting 
trap/interrupts/semihosting event).

> As for the registration, it may make the registration a bit more
> convenient and maybe keep the API clutter a bit lower, but not by that
> much.
>

It's ok for the user. But I think it's more complicated to extend, when 
we'll want to introduce control flow API in the future. Do we want 5 or 
6 different callbacks when people want to track fully control flow from 
a plugin?

> 
>> /* Sum type, a.k.a. "Rust-like" enum */
>> typedef struct {
>>   enum qemu_plugin_cf_event_type ev;
>>   union {
>>   data_for_interrupt interrupt;
>>   data_for_trap trap;
>>   data_for_semihosting semihosting;
>> } qemu_plugin_cf_event;
>> /* data_for_... could contain things like from/to addresses, interrupt id, ... */
> 
> I don't think this is a good idea.
> 
> Traps are just too diverse, imo there is too little overlap between
> different architectures, with the sole exception maybe being the PC
> prior to the trap. "Interrupt id" sounds like a reasonably common
> concept, but then you would need to define a mapping for each and every
> architecture. What integer type do you use? In RISC-V, for example,
> exceptions and interrupt "ids" are differentiated via the most
> significant bit. Dou keep that or do you zero it? And then there's
> ring/privilage mode, cause (sometimes for each mode), ...
> 

I didn't want to open the per architecture pandora box :).
I don't think the plugin API itself should deal with per architecture
details like meaning of a given id. I was just thinking to push this 
"raw" information to the plugin, that may/may not use architecture 
specific knowledge to do its work. We already have plugins that have 
similar per architecture knowledge (contrib/plugins/howvec.c) and it's 
ok in some specific cases.

But having something like from/to address seems useful to start. Even if 
we don't provide it for all events yet, it's ok.

> It would also complicate call sites for hooks in target code. You'd
> either need awkwardly long function signitures or setup code for that
> struct. Both are things you don't want, as a hook call site should
> never distract from the actual logic surrounding them. You could
> probably have something reasonable in Rust, using a builder/command
> pattern. But in C this would require too much boiler plate code than
> I'd be comfortable with.
> 

We can have one "builder" function per data type, with fixed parameters 
(no varargs), it's reasonable and would scale well with new entries/data 
information.

> Regards,
> Julian

