Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC905D75E27
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 11:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tERVh-0003lN-7b; Fri, 22 Nov 2024 06:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERVe-0003l3-ND
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:07:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tERVb-0004DK-3k
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 06:07:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3825a721ae5so1053671f8f.1
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 03:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732273649; x=1732878449; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=anOS8QocaR0OCKjNiH6aG49X20RUHy2nUb8Z15SronI=;
 b=G4dPIxcXcYFGZzxED+WwuNidZ0qGdRQbD4ee/zCc3feazaCYqJfwyjDXqyjovDbv6v
 ma+SXfQCH656KNVwRmWE/XfVPc1yuImy9brSe0ANUR7avaJ+TN1PwMSMQUyRQRv1gMgO
 He7xA6voBg2nIASUyGVMvoE0I/GiNDRGsw//NvDuACvCwpiZL1yHDWNQ3jTY0hN2eVbJ
 NqP8ZmqrrA0//3ZESc5PRu+Wwc65gwsi9V9GD2RttkifruM5jfTLPUvMWsUwsUFZdctU
 S7EVBaKx6PzwkvgHluq8XyfRpefk0QvZiewQsMnM72c3w9wUu+m7kS4ghzZlyf601Z4E
 GLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732273649; x=1732878449;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=anOS8QocaR0OCKjNiH6aG49X20RUHy2nUb8Z15SronI=;
 b=b1z2CAGB+E9hT6HhLUR64lMMb8yq70/2UR5uVB2JC2/85RmrzX78ju+djdF7iPRhq5
 yxQ17V7aUCL9rICQC5ti/0ike6askrv3XZqnc6FKMaVWr624KzhcLoGPN+q4GdaV/Znn
 ONoRcjB7wCk5EV/oEdwDjwn6SIeFjgun0x68f4dMIsGEpuk8G4XQrvowfNssaVhNccma
 CvSNfc2yfG+2REBWQ0GhD+4YFVJanvYkNF1ArfiJfPQUq+VDyuCOu1TsO/30VkcIIPzW
 b+J3FNZlKv8Vcq4gBeTAJQb/TPZdGrBbWIZxYdYGpmzBl9xfdDcChIDkN/pBwxBBsoTL
 4tuA==
X-Gm-Message-State: AOJu0YyGDOgzJnLrwwe6br2garM/WN+k7/M31BQuVkmvG0kbqCeJZpOO
 dcvlU9a3pZi4lR946rD0yMYtPGi8/uA81TxJkjUOPCX2UhhkVNiPhDQEUUBIY9Y=
X-Gm-Gg: ASbGncs28YjeXufN5zSei1SBW+jLoBz7WF7OYit2GkdiOgpXZTF1ZyMxwnoOBTMC45Q
 3FC5eua68oVllV24RrKCMHIzPUqZqbWzJO18m2es6Q45+7MiZ2EwbZUh0+U2wGoQC4gedv/CA23
 oZ9GDJ0/OTpemDA5RzV9gMzxPEl2qFGfT+XlHtnmHKf3rPmdD8LnylZJZvz4Yt9erWlY0O+hZOf
 UlFnTcuiMyWr6DI1yTYMlcWa9ULWx9uMMRqsGrbwz/2oQpZ3XAlAB/LsVGJugRLLbLbHA==
X-Google-Smtp-Source: AGHT+IFQInw4h8zAQ+hzpa/UrA/c/eLGQYD6uNPPPxHEjGavy3W4zIlBCoi2Qpbp/v0GpcxEKruBkA==
X-Received: by 2002:a05:6000:184d:b0:382:4abd:c3c9 with SMTP id
 ffacd0b85a97d-382604ec13bmr2368173f8f.7.1732273649253; 
 Fri, 22 Nov 2024 03:07:29 -0800 (PST)
Received: from [192.168.69.146] ([176.187.211.33])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fcff017sm2064231f8f.108.2024.11.22.03.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2024 03:07:28 -0800 (PST)
Message-ID: <218ddf9d-6e2e-4935-8f59-bd67b7f69892@linaro.org>
Date: Fri, 22 Nov 2024 12:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: add bindings for interrupt sources
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, zhao1.liu@intel.com,
 qemu-rust@nongnu.org
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-3-pbonzini@redhat.com>
 <70f44731-6879-4adf-a71b-a781af48fe99@linaro.org>
 <CABgObfbOj8FCvjXOM_AF8=jyFMi1bs-gfsRu+_GH3802hLhM1A@mail.gmail.com>
 <fff34325-203e-4138-a795-27a45b20e6ab@linaro.org>
 <90f9f6b1-f590-43cb-b71d-dc73992bd82a@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <90f9f6b1-f590-43cb-b71d-dc73992bd82a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 22/11/24 11:53, Paolo Bonzini wrote:
> On 11/22/24 11:30, Philippe Mathieu-Daudé wrote:
>> On 22/11/24 09:32, Paolo Bonzini wrote:
>>>>> +/// Interrupt sources are used by devices to pass changes to a 
>>>>> boolean value to
>>>>> +/// other devices (typically interrupt or GPIO controllers).  QEMU 
>>>>> interrupt
>>>>> +/// sources are always active-high.
>>>>
>>>> So 'always active-high' = true below? (Wondering about pulsation, if 
>>>> the
>>>> true -> false transition is always correct).
>>>
>>> Yeah, I mean that raise uses true (or 1 :)) and lower uses false.
>>> an example?
>>
>> I was thinking of an active-low line where you want to pulse 1 -> 0.
>> Just chiming in, not to worry about.
> 
> This is not happening at the device level, so I assume that such a line 
> would not use raise/lower.  Rather, the board (which is on the interrupt 
> sink side) would install a qemu_irq_invert() between the device and the 
> interrupt controller or GPIO controller.
> 
>>>> Is this deliberate to restrict the Rust binding to boolean? (Maybe you
>>>> envision a VectoredInterruptSource implementation for that).
>>>
>>> No, I simply wasn't aware of that.  I'll adjust; do you have
>>> an example?
>>
>> I am having hard time to find one, in particular because I
>> removed one in c264c074d8 ("hw/intc: Remove TYPE_ETRAX_FS_PIC device"):
> 
> Ok, then we could put the type as a generic parameter, and use that 
> parameter in InterruptSource::set().
> 
> pub struct InterruptSource<T = bool> where u32: From<T> {
>      inner: BqlCell<*mut IrqState>,
> 
>      // this is only needed top ensure that T appears somehow in the
>      // struct.  Random Rust type theory stuff. :)
>      _marker: PhantomData<fn(&Self, T)>,
> }
> 
> ...
> 
> /// Send `level` to the interrupt sink.
> pub fn set(&self, level: T) {
>      let ptr = self.0.get();
>      // SAFETY: the pointer is retrieved under the BQL and remains valid
>      // until the BQL is released, which is after qemu_set_irq() is 
> entered.
>      unsafe {
>          qemu_set_irq(ptr, level.into());
>      }
> }
> 
> and then only implement raise/lower/pulse for InterruptSource<bool>.
> 
> This is backwards compatible so we can do it either now, or later when 
> needs arises.  You tell me. :)

If there are no more vector uses, personally I'd convert qemu_set_irq()
to use an explicit boolean level. If vector need arises then I'd
add it using a new explicit method, i.e. qemu_set_irq_vector(); so
the arguments are obvious when we review qemu_set_irq*() uses.

Otherwise I'll defer to Peter who raised that point first.

> 
> Paolo
> 
>> See Peter's comment in https://lore.kernel.org/qemu-devel/ 
>> CAFEAcA9cObnb11cSS_StbSHdP0aB6sDeqSHfjb3-qRBfy7K9Kw@mail.gmail.com/
>>
>>>>> +/// Interrupt sources can only be triggered under the Big QEMU 
>>>>> Lock; they are
>>>>> +/// neither `Send` nor `Sync`.
>>>
>>> Oops, this is incorrect.  BqlCell *is* Send/Sync, but checks the
>>> BQL state at run-time.
>>>
>>> Paolo
>>>
>>
>>
>>
> 


