Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C0EC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 09:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uirn9-0008Bb-IN; Mon, 04 Aug 2025 05:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uirbw-00034r-1Z
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:36:07 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uirbs-0005cd-Ge
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 05:36:02 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7e346ab53d8so350732885a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 02:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1754300158; x=1754904958; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=sSGViVqk8tYm1Hl4rf3sipWjZp79oeSys3OXdOq7qQ0=;
 b=D5o2Q/xEj4lV654nohcA8BNEwOIwQO8ZHMJdmNPYhQi74sRTsm7SdLrAuqsiJMMI/3
 JXeOPpNrJcg7KIFYQmeG0X/yIHGQi0z7zQe23SKZEuixq6+4XxODWcKml3BYMKhUd4zR
 GoS/JRzkondC6AGATqztvlU85oZzQ9RtEf9mO/iKXKwJMwWWsM2Lv3EA+ZA502KNGAfS
 Me187JaHvSHOTLtj43ovCOjE7E54DVhOB+6C/E+2rdiaGpUhocVVfdYh8ZPW3W2PUM9/
 rD7sjYeIBhVRWE4qI0iEpTmxJsu4iLNj9n7fEN6IAfof+d+F6zVYa3jQGdvV/i7kC3+a
 +ecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754300158; x=1754904958;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sSGViVqk8tYm1Hl4rf3sipWjZp79oeSys3OXdOq7qQ0=;
 b=nK6IFY1xTsT3qatl6vaVhQ+MC5ZIlteK+5TdhTmAjNSmEB6JGr5VagXCHBkUnfffvt
 Y3ZcH5ARyFEW8LiM3wRzCxnWegqjOhrSBBsFj7+eEMUCyV7yLanKeSdlY+E1Rfibilmg
 2T9OmYbFK/3/4OTsf4J6u6fP3vVOdE4jnOs9DC3HIVGM5VoDwJPkDbJRtrENktDPQBTo
 uufRbD6TfvAS9aG2q63vVVpaq5zdF5/GjJG4a78z66JdKFD1MgSOue/aKxcRSAe0YLYJ
 A7lVm0dRbms9Tx9Mr+C2MT+uu0CT69Pse3cOeGb56SpPqETos99O01YHMLP4tps+KFYg
 hQ5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjbOtqNKpF8kcdYZfDJqyu1JG9/PCT6Hz8gQwDVKyV/vs7lgXG0TsDeJzT8BCw13woPjeaRTOWE0F8@nongnu.org
X-Gm-Message-State: AOJu0YzN9oY/J2I2o4uoUok4HNrOnmztI0ko+jpXtwIwD2G+UYmT7gyf
 0BgWe5pNMVncKHOLByay18Lmj4R7/MJowYQozJzfKTMd1F1ODUHBamyiJYPR9kYTqkE=
X-Gm-Gg: ASbGncuG+b/WY/tOtTKQMi3buTwTh0lzAuu3yp7rhx6gmTXptOMdpjHJv8sWJ2fwOSS
 9nPF+vuXmtWeRlbg7qoEc4I/XwzjKPa6nI1BkPmLVr8pgncKgnwGWrYWm4qTmrvfz62AWaqchST
 Z3Lrdc0t6eQve7E1MOv8kgVtlmyrdzeIXuxTL8N6Z/NJhTbqvldgf26VJmjLGiGhSTiq+oMTbzt
 /c4elNyz1JNGMewswfLCow/j7MVYl6ukzmXkJY5tbCRaE7uqGEvFq2Vj5poefG4saoazX6An8nN
 gbb9UmckT3O7DRaT8W35WUaIcpPKiKcV0j+ZDTvrpd74D0ZWuaMY9Y75woqr+aqQJ0/AvhAxU8A
 qYI9GvrDnF7dfIG7mhMaWKbtA6HFZzf0bItQzSKLejHxQOuoixVSv94FYVDDZ4YAw0xWjd8ivEk
 phJn4L81cYuk8Oo0SsoweLTz5Rs4OIiA3k2hjHnvKp8SGFT2/JVF8mpDybZ6ooWXZj0g==
X-Google-Smtp-Source: AGHT+IGbM9Mk6uhLMIfQkTcN7oqrD3mx+58S38TYJ9YZp0XYWcvPrm86ys90AFtGU4ZHqA92/ooSxw==
X-Received: by 2002:a05:620a:21c6:b0:7e3:4678:aae with SMTP id
 af79cd13be357-7e6963543e9mr973213885a.41.1754300157937; 
 Mon, 04 Aug 2025 02:35:57 -0700 (PDT)
Received: from ?IPV6:2003:fa:af22:cf00:2208:a86d:dff:5ae9?
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f594206sm521802385a.4.2025.08.04.02.35.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 02:35:57 -0700 (PDT)
Message-ID: <b0179d3d-d36a-4ae8-b32c-5659794995db@grsecurity.net>
Date: Mon, 4 Aug 2025 11:35:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i386/kvm: Disable hypercall patching quirk by default
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250619194204.1089048-1-minipli@grsecurity.net>
 <271351582cbe88731098bd4fbdd8f7ef522f20f6.camel@infradead.org>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <271351582cbe88731098bd4fbdd8f7ef522f20f6.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-qk1-x736.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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

On 23.07.25 11:26, David Woodhouse wrote:
> On Thu, 2025-06-19 at 21:42 +0200, Mathias Krause wrote:
>> KVM has a weird behaviour when a guest executes VMCALL on an AMD system
>> or VMMCALL on an Intel CPU. Both naturally generate an invalid opcode
>> exception (#UD) as they are just the wrong instruction for the CPU
>> given. But instead of forwarding the exception to the guest, KVM tries
>> to patch the guest instruction to match the host's actual hypercall
>> instruction. That is doomed to fail as read-only code is rather the
>> standard these days. But, instead of letting go the patching attempt and
>> falling back to #UD injection, KVM injects the page fault instead.
>>
>> That's wrong on multiple levels. Not only isn't that a valid exception
>> to be generated by these instructions, confusing attempts to handle
>> them. It also destroys guest state by doing so, namely the value of CR2.
>>
>> Sean attempted to fix that in KVM[1] but the patch was never applied.
>>
>> Later, Oliver added a quirk bit in [2] so the behaviour can, at least,
>> conceptually be disabled. Paolo even called out to add this very
>> functionality to disable the quirk in QEMU[3]. So lets just do it.
>>
>> A new property 'hypercall-patching=on|off' is added, for the very
>> unlikely case that there are setups that really need the patching.
>> However, these would be vulnerable to memory corruption attacks freely
>> overwriting code as they please. So, my guess is, there are exactly 0
>> systems out there requiring this quirk.
> 
> I am always wary of making assumptions about how guests behave in the
> general case. Every time we do so, we seem to find that *some* ancient
> version of some random network applicance — or FreeBSD — does exactly
> the thing we considered unlikely. And customers get sad.
> 
> As a general rule, before disabling a thing that even *might* have
> worked for a guest, I'd like to run in a 'warning' mode first. Only
> after running the whole fleet with such a warning and observing that it
> *doesn't* trigger, can we actually switch the thing *off*.

Looks like I was overly optimistic. There are, of course, use cases that
rely on the hypercall patching, even if it's just for testing purposes.
One of these are the KUT tests. I tried to fix these[1], however, there
are probably more such mini-kernels, so I reverted back to not changing
the default behaviour and only provided a knob to disabled the quirk,
making users to manually opt-in to it[2].

> 
> Can we have 'hypercall-patching=on|off|log' ? 

I'd like to have the 'log' option as well. But as KVM does the patching
on its own, this would require QEMU to analyze and react to related #UD
exceptions (and possibly #PF to handle currently failing uses cases with
read-only code too) further, I'd rather not want to do.

Another option would be to do a WARN_ON[_ONCE]() in KVM if it does the
patching. But, then, existing use cases would suddenly trigger a kernel
warning, which used to work before. Again, something users probably
don't want to see. :/

I guess, we have to stick around with the default but make users aware
of the option to disable the patching themselves.

Thanks,
Mathias

[1]
https://lore.kernel.org/kvm/20250724191050.1988675-1-minipli@grsecurity.net/
[2]
https://lore.kernel.org/kvm/20250801131226.2729893-1-minipli@grsecurity.net/

