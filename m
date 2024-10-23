Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBEABCDDE7F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3d62-0000Qw-Cb; Wed, 23 Oct 2024 11:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3d5i-0000Nz-HE
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:16:08 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3d5f-0003lC-Uf
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:16:06 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e59746062fso3136746a91.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 08:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729696562; x=1730301362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ros+bs8D3SiE7lWqALAlBlhEtzPEvmegLFTudfIHiok=;
 b=MawiV9ObxrOobtMe+xOpo3VEWhkarzDti7SJH6/QPuKhcayF0+gbRaGkAClOnmz0dq
 XegERRnaFOcQUbW3NueHdD8ZEwjnUOoJh8UrihCloVVGTRP01IkCdbcJmdc+zor+c6+X
 8ZWHDUezePmmIGscI4U9tuP7sMvuSJ2cLmTsw6r+oWA6aNQe1fg/bwJUl+PtEInxoNd/
 LJSICHxRPdxb8f2ei60DFiAOspeIIVYQ7TXmwdGq/jBs9J0zzmVTHSrY9b0Svf8rAZ/z
 xQWXKo3W01LMbAKX03II15AcZNfKrFQgYYwJMbDw3NHzYDX9aD2jk5T4XHROZF0plAfe
 deiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729696562; x=1730301362;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ros+bs8D3SiE7lWqALAlBlhEtzPEvmegLFTudfIHiok=;
 b=nyINn6RMwN/VMwnqRSkFFvnS0TLgRZ1LSIKxwm6F/lCB9Pa0Qhds0th1FavaKR7x6I
 YgQYulodTgXvfEO8KLb3KpqkFK6InuOKWtBIdEYyI6tvaTlDzRt8WtyZej8zpCEsxkDY
 d1iKNyfF21SQ5eqPq8gor9NyZ4VddqKI5F7mNUQRaYW6hEamajkVomVUVW6Gjly1Drdv
 tgsZOOEzPyiHizV1FCxkJkRQZRX6WzJzTAjlDPyN4AKHAS4EQIarSglR22mHX0Djks3a
 dUv60dfdHLq6odHINgDX1M3FZzUnHInbYWeM7yr5I3PCNe2DgBZCFyIvSg+kSDvvi5M4
 rFaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWowBC6yo7YZ4n/a/8PSNvzTyCqJy7AEGVC0QdvrUXiXkrVR33RU22HZG//gqoUA//kCVK5MdgsT7MN@nongnu.org
X-Gm-Message-State: AOJu0YwubZRflyLUXEeeis/Tgf8IAunJCsMLhblqUMZXt6XTANSFUmSL
 xnb44xyTl8tQenHdOgqNtIuiCNSIp9KU1TJWV2Lpb5MulysMdWK4DFxpfe1CnVQ=
X-Google-Smtp-Source: AGHT+IFhuGy8o28j77UlzTMqWGnSl+OcuyhcpY0mXxtL0XRZjU001K+CYBcHt3hEnNdwwdkxSBxiow==
X-Received: by 2002:a17:90a:1bc6:b0:2e2:bb02:4668 with SMTP id
 98e67ed59e1d1-2e76b722988mr2384964a91.40.1729696561878; 
 Wed, 23 Oct 2024 08:16:01 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e76e05b775sm1539645a91.46.2024.10.23.08.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 08:16:01 -0700 (PDT)
Message-ID: <28f647ca-0b88-4a01-90d3-4cc4450e0d1d@linaro.org>
Date: Wed, 23 Oct 2024 08:16:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: Julian Ganz <nenut@skiff.uberspace.de>, Julian Ganz <neither@nut.email>,
 qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

Hi Julian,

On 10/23/24 05:56, Julian Ganz wrote:
> Hi, Pierrick,
> 
> resent as I was too stupid to hit reply instead of reply-all.
> 
> October 22, 2024 at 11:15 PM, "Pierrick Bouvier" wrote:
>>
>> On 10/22/24 01:21, Julian Ganz wrote:
>>
>>>
>>> Hi, Pierrick,
>>>   October 21, 2024 at 11:59 PM, "Pierrick Bouvier" wrote:
>>>
>>>>
>>>>   Maybe we could have a single API like:
>>>>
>>>>   enum qemu_plugin_cf_event_type {
>>>>   QEMU_PLUGIN_CF_INTERRUPT;
>>>>   QEMU_PLUGIN_CF_TRAP;
>>>>   QEMU_PLUGIN_CF_SEMIHOSTING;
>>>>   };
>>>>
>>>   I have considered such an enum, as an input for the callback, as a
>>>   parameter of the registration function, and both. Of course, if you were
>>>   to add a selection parameter for the registration function, you likely
>>>   want OR-able flags.
>>>   An additional input for the callback type would obviously require a new
>>>   function type just for that callback. Since the callbacks are somewhat
>>>   similar to the VCPU init, exit, resume, ... ones it felt appropriate
>>>   to use the same function type for all of them.
>>>
>> I tend to disagree on that. IMHO, it's better to reduce number of API entries instead of callback types.
>> It's easy for a user to understand how to implement a given callback, while it's hard to understand which API you need for which thing.
>>
>> For the syscall cbs, we already have a specific callback. So why not here?
> 
> <snip>
> 
>>> As for the registration, it may make the registration a bit more
>>>   convenient and maybe keep the API clutter a bit lower, but not by that
>>>   much.
>>>
>> It's ok for the user. But I think it's more complicated to extend, when we'll want to introduce control flow API in the future. Do we want 5 or 6 different callbacks when people want to track fully control flow from a plugin?
> 
> Ok, I'll introduce an enum and combine the three callbacks in the next
> iteration then.
> 
>>>> typedef struct {
>>>>   enum qemu_plugin_cf_event_type ev;
>>>>   union {
>>>>   data_for_interrupt interrupt;
>>>>   data_for_trap trap;
>>>>   data_for_semihosting semihosting;
>>>>   } qemu_plugin_cf_event;
>>>>   /* data_for_... could contain things like from/to addresses, interrupt id, ... */
>>>>
>>>   I don't think this is a good idea.
>>>   Traps are just too diverse, imo there is too little overlap between
>>>   different architectures, with the sole exception maybe being the PC
>>>   prior to the trap. "Interrupt id" sounds like a reasonably common
>>>   concept, but then you would need to define a mapping for each and every
>>>   architecture. What integer type do you use? In RISC-V, for example,
>>>   exceptions and interrupt "ids" are differentiated via the most
>>>   significant bit. Dou keep that or do you zero it? And then there's
>>>   ring/privilage mode, cause (sometimes for each mode), ...
>>>
>> I didn't want to open the per architecture pandora box :).
>> I don't think the plugin API itself should deal with per architecture
>> details like meaning of a given id. I was just thinking to push this "raw" information to the plugin, that may/may not use architecture specific knowledge to do its work. We already have plugins that have similar per architecture knowledge (contrib/plugins/howvec.c) and it's ok in some specific cases.
> 
> But how would such an interface look? The last PC aside, what would you
> include, and how? A GArray with named items that are itself just opaque
> blobs?
> 

I was not thinking about a new interface for this. Having the "raw" 
interrupt id is enough for a plugin to do useful things, by having 
knowledge of which architecture it's instrumenting.

> And what would be the benefit compared to just querying the respective
> target specific registers through qemu_plugin_read_register? Which btw.
> is what we were going to do for our use-case. Even the example you
> brought up (howvec) uses querying functions and doesn't expect to get
> all the info via parameters.
>

You're right, but it's because it's querying instruction data.
I may be wrong on that, but at translation time, we may or may not be 
interested in accessing tb/insn data.

However, for control flow analysis, beyond a simple counting plugin, we 
probably want to access further data almost everytime.

I see it closer from syscall instrumentation, which pushes the syscall 
id, and all register values, instead of letting the user poke it. Makes 
more sense compared to that?

>> But having something like from/to address seems useful to start. Even if we don't provide it for all events yet, it's ok.
> 
> Yes, I certainly see the advantages of having either the last PC or the
> would-be-next PC as they are sufficiently universal. You can usually
> retrieve them from target-specific registers, but that may be more
> complicated in practice. In the case of RISC-V for example, the value
> of the EPC differs between interrupts and exceptions.
> 

To the opposite of interrupt id, a PC is something universal by 
definition, and with a single meaning across architecture. However, 
accessing it by name varies per architecture, and even per sub events, 
as you are stating for RISC-V.

> That PC value should also be easy enough to obtain at the hook call
> sites. We only need to store the (old) PC before doing the setup. The
> "to-address" is the current PC at the time the callback is invoked.
> Anything else would be a bug. I was going to write that you can
> already query that in a plugin through a dedicated helper function
> but apparently I misremembered.
> 
> I'll include this in the next iteration.
> 
>>> It would also complicate call sites for hooks in target code. You'd
>>>   either need awkwardly long function signitures or setup code for that
>>>   struct. Both are things you don't want, as a hook call site should
>>>   never distract from the actual logic surrounding them. You could
>>>   probably have something reasonable in Rust, using a builder/command
>>>   pattern. But in C this would require too much boiler plate code than
>>>   I'd be comfortable with.
>>>
>> We can have one "builder" function per data type, with fixed parameters (no varargs), it's reasonable and would scale well with new entries/data information.
> 
> I'm still not on board on preparing a more complex data type. For the
> next iteration I'd rather stick to a simple function receiving the
> "type" of event and the PCs. That may not be extensible, but I don't see
> any benefit in shoehorning inheritelntly target-specifc information into
> a complex struct.
> 

It's a good compromise for now, and avoid introducing a more complex 
data type.

> If this is a hard requirement, I'll of course still do so.
> 

My goal was not to hijack this series, or put the burden on you, but to 
talk about which direction we want to go.
As long as we start with a single callback (vs one per event), I'm fine 
to go slowly and iterate in the future.

> Regards,
> Julian

Thanks Julian!

