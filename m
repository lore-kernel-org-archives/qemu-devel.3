Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDE7C87FC5
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 19:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uf1V8-0003j0-At; Thu, 24 Jul 2025 15:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uf1V4-0003eM-D2
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 15:21:06 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathias.krause@opensrcsec.com>)
 id 1uf1V1-0001ck-VC
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 15:21:06 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so1003591f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 12:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=grsecurity.net; s=grsec; t=1753384861; x=1753989661; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kaRVeMq7pLWHIA7qWwBst0OckDzOp/vP4d84uEpDEhc=;
 b=KQEEh/K42ZXs8JiBMRKh3WfUQsGJ7bxCS39BkW9I2Jw0D8aXuI5/mIBeFk6LyIghrH
 EWYd2OvrHz1zKmd2ElMmkaPD4nZ7DEfMwTEMpTRI0DfFpwcesjzEqXRCO0RHk4X+C3lF
 S9YaWKTYLLFZVrW60QL9T5eaQTOJ+ic5A48Vuv5yBOzT3qR2ZHdr4n2UKSKbquiVM0l0
 4ivHCINyFZw/0uAWi1HwaeRHXh/L4k2x57VEjZaDOREGM3xpYbo+fgmFu4zJHHTeS1JS
 osAmvGVg/nDs7f0zuYehmqECsScpsEUr+SGWeiTpbcwcamkmqh+qIpwTqWqe+jPoeCk3
 yo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753384861; x=1753989661;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kaRVeMq7pLWHIA7qWwBst0OckDzOp/vP4d84uEpDEhc=;
 b=NajR2btzLRO8QHnzklD80unBrT/3yOGOd5JH9WRmhLGlNt/qeJjXdA4yP010Bo6rei
 +Gcmcs7D365p+OpmRTCIvYMgTntBNT7FeuRwHzWcwGHLE4ottk/C3WoDS9tx6z+Vyg9p
 CWUEdoZrdDt3LY+EDr3vb+g0rmXw4Qh6pEUNztpy0jj3fzYC57EqAy6EfdwK/uGYXKEv
 uAYv4RREoC9PsCn5jFyW8DwQV8jigY65nd7Y8wZ+Zz+GnSzy7/sqr4qjD4nBL5IRTOQK
 Dz0G9y0J1+fNtQF8ZsKN/H7xG/7hzsuKbRcPSas5hSOTfPoNviChKLWVlqsrr2WmH16o
 GXXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHWBHSP/WsN2rg8X5sDdOXfC2pETo1BPkigEcdlzGn1tidrp9h5x+Ob7wo+IsZxoAIJC+JdfN+zZ5V@nongnu.org
X-Gm-Message-State: AOJu0YxrqGlhsJgb2JqJACtVTBbl/glq9nj0qqbX6pBhUafNpSESHkeL
 sxJIAGEU0QkAh5Rtlk0ml4jOMhTPkxZXq5Xc4cE9I2Mges6NjTZ03F91ZhE0RP+F/O4=
X-Gm-Gg: ASbGncu61CxdRNVqEAgqJnlFdMHt0wn5H4evVNrndIBZzbs2cfH3m9XacdR69crCM7a
 3NtArmEsYaiq+4Wm5AJsdEcnvm7AT4tE8UJgLLCUG2FfvFQOo+oJh+mwc34/7cjoum1LN4tBfXm
 4mDkBMgfPeicqLWC+TzFhtHGNlremF5jQvQwzRLFBXXVx21kfxwsEUNdw3dSy8f3rkh/lCcTnvi
 N4krPW9LST2eocFpRqpo7/9LhTUXHLnDWJlaZHVvJil59QqaUAbnI41TcCJr1VwiwjtaJg4KFQL
 CXPMj4Zc+d1YfV5K1T3xC+f3AlvZvLZnE4gF6BloezjduVux/CkYhspNkSMCwc7a7ua24KqUeJK
 Pmth2T/BjPXrMUE0rDB56y9fkGFEtk98fYNL/UugbpNJs/8EeoRHTTqQIK5C09++jL1a/JbiaoI
 lfPijN4OUWLV6D9K1U6JJZadtOIH9pR2jhp4ixrDa3buA2yKCiQ1hZGao=
X-Google-Smtp-Source: AGHT+IEjaunwQ1qaC+EQ3PKNVtIHt/6K0qOKkxoQK+HCUV6COwxPQg3KI7Wd6GomKtufpv+bJgFTag==
X-Received: by 2002:a05:6000:1a89:b0:3b4:9721:2b1b with SMTP id
 ffacd0b85a97d-3b768caa22fmr6793972f8f.9.1753384861431; 
 Thu, 24 Jul 2025 12:21:01 -0700 (PDT)
Received: from ?IPV6:2003:fa:af22:cf00:2208:a86d:dff:5ae9?
 (p200300faaf22cf002208a86d0dff5ae9.dip0.t-ipconnect.de.
 [2003:fa:af22:cf00:2208:a86d:dff:5ae9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705d42b0sm29233505e9.33.2025.07.24.12.21.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Jul 2025 12:21:00 -0700 (PDT)
Message-ID: <9ded729d-dc4a-4550-92d1-98beebccb9de@grsecurity.net>
Date: Thu, 24 Jul 2025 21:21:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] i386/kvm: Disable hypercall patching quirk by default
To: Xiaoyao Li <xiaoyao.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Oliver Upton <oliver.upton@linux.dev>,
 Sean Christopherson <seanjc@google.com>
References: <20250722204316.1186096-1-minipli@grsecurity.net>
 <206a04b9-91cb-41e4-b762-92201c659d78@intel.com>
 <ebbb7c3c-b8cb-49b6-a029-e291105300fd@grsecurity.net>
 <fbd47fb6-838e-47bf-a344-f90be06eed99@intel.com>
 <c787981c-dc21-4b74-b219-03255781f927@intel.com>
Content-Language: en-US, de-DE
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <c787981c-dc21-4b74-b219-03255781f927@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=mathias.krause@opensrcsec.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.158,
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

On 23.07.25 10:50, Xiaoyao Li wrote:
> On 7/23/2025 4:42 PM, Xiaoyao Li wrote:
>> On 7/23/2025 3:53 PM, Mathias Krause wrote:
>>> Bleh, I just noticed that there are KUT tests that actually rely on the
>>> feature[1]. I'll fix these but, looks like, we need to default on for
>>> the feature -- at least for existing machine definitions 🙁
>>
>> You reminds me.
>>
>> There is also even a specific KUT hypercall.c, and default off fails
>> it as well.
>>
>> enabling apic
>> smp: waiting for 0 APs
>> Hypercall via VMCALL: OK
>> Unhandled exception 6 #UD at ip 00000000004003dd
>> error_code=0000      rflags=00010002      cs=00000008
>> rax=00000000ffffffff rcx=00000000000003fd rdx=00000000000003f8
>> rbx=0000000000000001
>> rbp=0000000000710ff0 rsi=00000000007107b1 rdi=000000000000000a
>>   r8=00000000007107b1  r9=00000000000003f8 r10=000000000000000d
>> r11=0000000000000020
>> r12=0000000000000001 r13=0000000000000000 r14=0000000000000000
>> r15=0000000000000000
>> cr0=0000000080000011 cr2=0000000000000000 cr3=000000000040c000
>> cr4=0000000000000020
>> cr8=0000000000000000
>>      STACK: @4003dd 4001ad
> 
>>> Looks like I have to go the compat property route.
> 
> BTW, the compat property doesn't fix KUT issues actually.
> 
> Since KUT doesn't use versioned machine, instead of it always uses the
> latest machine.

KUT should be good with [1]. However, other similar mini-guests probably
still want the patching. :/

Thanks,
Mathias

[1]
https://lore.kernel.org/kvm/20250724191050.1988675-1-minipli@grsecurity.net/

