Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFBDC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 18:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc7Y0-0001RS-H4; Thu, 08 Aug 2024 14:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sc7Xw-0001Qe-Jl
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:07:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1sc7Xt-0006DN-Bi
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 14:07:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723140447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M18L1j8mNWlebO8KE9S0gwOECqtwVPAsO9WF9zI1D5E=;
 b=P4GGX6ZAWclC+LKfoLZ3UhWSN7ZURwp/GQhi8sfL+OBh+4sGzMis6ro6mIRx/7UcKqjLxI
 HXoFzLV+ZwDuIwM9m1g1aFDLF2L8soeSuOHTs9XLle1xkVGCkelQRTOSLNlvHkMjfxdN0Q
 17uP/HzO0zxSjcMzTWf7UepSZqehLO0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-PnoMtDXRPMmqv9Ss0-qZZQ-1; Thu, 08 Aug 2024 14:07:25 -0400
X-MC-Unique: PnoMtDXRPMmqv9Ss0-qZZQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-36835daf8b7so936407f8f.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 11:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723140444; x=1723745244;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M18L1j8mNWlebO8KE9S0gwOECqtwVPAsO9WF9zI1D5E=;
 b=nMoPyDtMZBqG31hMqq6D8jwr3ZXWyRvgrUf45lpM1AwAqES/9JH2Nq7Q4gtsGcdQrh
 0J2Vi013/dBxAfzJQpDa8evlnEi+Xzitwr6NQAdpLWu1BV4LhGd4kqjaHTMROEiCZWtG
 R+TgYBZQLV74Vb/xzgb4QgpCrzZsGfmTCwTz/OW7uzCORFCIfW7mjh0BRcYSSDTOvfmC
 V0/2rugCY6OoAvOyQqTm+6WB2426lNBCdOhNo+w2vq3Snde+oSqp2VUQ8e+r2DsrzhES
 YYkXqUK2TGghHFa0fOxia7jRZeuLwsOV/J/LDSfNuRWJI76X+UXA+StQCKclgU9Ggjqy
 l+Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTYZ2/TOq/4xLyMMQyat3wH1ScNjbKkdVME0ZXMgWESKvJTknMSM0uYEEVNltDzBZ74s/xx95HviRcJ7jiKjbcxgJn/xQ=
X-Gm-Message-State: AOJu0Ywauc9/d7RTr9C5T21ENqptj6V91Mn75MvpXRZkZ4j+m3Gp/lXE
 kJiqnKNcmaa4R+uqvRwh8nH1KrFfuZG5HPtT5/5YKAWcGzugu+bwb1L6+CoF1ChhKV6/Q5t2Y9K
 37zZNyYtHNzT6nvDzhcVaZzDvorLgp8vTggI3adKtJBzYxNT2lill
X-Received: by 2002:a05:6000:e0b:b0:36b:3563:15f4 with SMTP id
 ffacd0b85a97d-36d27591d44mr2432972f8f.56.1723140444626; 
 Thu, 08 Aug 2024 11:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESql+pVxEmmwP7g6q/hGfiPUVh0YpL3T7rlDtM1n39JnH8WMwKxaQdp7gotNjZE/OWMtz6qQ==
X-Received: by 2002:a05:6000:e0b:b0:36b:3563:15f4 with SMTP id
 ffacd0b85a97d-36d27591d44mr2432951f8f.56.1723140444060; 
 Thu, 08 Aug 2024 11:07:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c713:2a00:f151:50f1:7164:32e6?
 (p200300cbc7132a00f15150f1716432e6.dip0.t-ipconnect.de.
 [2003:cb:c713:2a00:f151:50f1:7164:32e6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d271802fesm2664933f8f.56.2024.08.08.11.07.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Aug 2024 11:07:23 -0700 (PDT)
Message-ID: <c282b34b-8bc8-4203-a76d-09eaeafbcde1@redhat.com>
Date: Thu, 8 Aug 2024 20:07:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] reset: Add RESET_TYPE_WAKEUP
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org
References: <20240806160756.182524-1-jmarcin@redhat.com>
 <20240806160756.182524-3-jmarcin@redhat.com>
 <CAFEAcA9iCcmwkN2m9unjZskFHPg=DSDjC-SeNyskmjtkFJvFMQ@mail.gmail.com>
 <CAC2qdxDhfon3Xe7J4jCVyqx7VdR-CMbo2r7Vat=WOA0qWLoFMg@mail.gmail.com>
 <34840c40-1a54-4aa0-a424-defd93d3b2b2@redhat.com>
 <CAFEAcA9LNj1JENcCKHU+BvKE+K5_b3jUSS_prwAC2X084xvT8A@mail.gmail.com>
 <bf8d2172-ddd3-499c-a164-6b358c6496a7@redhat.com>
 <CAFEAcA_Zo-WmjMZwcecwgPAp_DOfaewV_nDx3QpCzYx7h2Kckw@mail.gmail.com>
 <841a1b53-7b43-4fb6-966b-1f9000292851@redhat.com>
 <CAFEAcA_MT+WMOdDt7qkywY9ZBvMxG7aH8_ztb-mYOtQGBFMFqA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAFEAcA_MT+WMOdDt7qkywY9ZBvMxG7aH8_ztb-mYOtQGBFMFqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08.08.24 19:30, Peter Maydell wrote:
> On Thu, 8 Aug 2024 at 17:29, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.08.24 18:17, Peter Maydell wrote:
>>> On Thu, 8 Aug 2024 at 17:04, David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 08.08.24 17:56, Peter Maydell wrote:
>>>>> Right, I guess that's my question -- is "WAKEUP" ever any
>>>>> different from "WARM" reset? I think the latter is a more
>>>>> common general concept.
>>>>>
>>>>> On the other hand it looks like we already have the
>>>>> concept in the runstate state machine of
>>>>> RUN_STATE_SUSPENDED versus RUN_STATE_RUNNING, and so if we
>>>>> define "WAKEUP" as "goes from SUSPENDED to RUNNING" that's
>>>>> quite a clearly defined condition.
>>>>
>>>> Right.
>>>>
>>>>> Whereas WARM reset would
>>>>> be a much wider range of things and ought to include for
>>>>> instance "guest triggers a reset by writing to port 92"
>>>>> and all the other SHUTDOWN_CAUSE_GUEST_RESET cases.
>>>>> (Side note: do we document all these runstates and transitions
>>>>> anywhere?)
>>>>>
>>>>> For virtio-mem, on a guest-triggered reset, should it
>>>>> (a) definitely not unplug all the hotplugged memory
>>>>> (b) definitely unplug all the hotplugged memory
>>>>> (c) we don't care?
>>>>
>>>> During ordinary system resets (COLD) where RAM content is not guaranteed
>>>> to survive:
>>>
>>> "COLD" isn't an "ordinary system reset", though -- COLD
>>> reset is more like "I powered the computer off and then
>>> turned it on again". A "WARM" reset is like "I pressed
>>> the front panel reset button, or the watchdog device
>>> fired and reset the system". We don't currently really
>>> model front-panel or watchdog reset properly, we assume
>>> that it's close enough to have it be the same as
>>> power-off-and-on reset (and there are some kludges in
>>> various places where it's not quite right).
>>
>> Agreed, there are many flavors of resets, even different flavors of warm
>> ones I'm afraid.
>>
>> To summarize, if a VM does an ordinary reset ("shutdown -r") we want to
>> unplug all hotplugged memory. Same with most external resets we
>> currently implement. In all other caes, we likely want to keep the
>> memory hotplugged and RAM content alive.
> 
> OK, if we want 'shutdown -r' to unplug hotplugged memory
> then that sounds like we do want a WAKEUP reset type.
> (Though I'm surprised that we want that -- my expectation
> would have been that the hotplugged memory should stay,
> because if you do real hardware hotplug of RAM then it
> doesn't all pop back out of the sockets when you press
> the reset button on the front panel :-))

:)

The main difference to ordinary RAM is that (virtio-mem) device memory 
is always detected by a guest OS driver, it's never part of the 
bios/firmware-provided memory map. And not all OSes support virtio-mem.

So one reason we added that handling in the beginning was if you would 
reboot from OS X to Y, whereby X suppors virtio-mem (and we hotplugged 
memory) and Y does not, then you would not leave that 
unusable-but-memory-consuming memory around for Y (possibly leaving 
customers paying for dynamic memory capacities angry).

Another reason was to force the fresh OS to effectively defragment 
hotplugged device memory (so we have less mixture of plugged and 
unplugged memory blocks that any previous OS might have left behind 
after unplugging memory).

Yet another reason was that one could have pending unplug requests 
(e.g., unplug 1 GiB, but only part of that request was fulfilled by the 
old OS), and this way we can easily enforce that once we get the chance to.

So to summarize, the idea was to "start from scratch" in all cases where 
it is safe. For wakeup, it apparently wasn't safe :)

-- 
Cheers,

David / dhildenb


