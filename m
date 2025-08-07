Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 245C2C87FCF
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 08:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujw7C-00063b-Tw; Thu, 07 Aug 2025 04:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujw75-0005wZ-Dj
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 04:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1ujw71-0008Sc-Bp
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 04:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754555792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=41z+kQGAhb7bAU/ZVAUZpWuuuYsDgzT56u1gqlrpLvU=;
 b=Sz2HfnYw0EIXVQv2+0Bh0JPp8rZ16Ut21pnc3OoNdlj9bbPenHjrICd6Prv2pQIuh05WRx
 JjDyS18HIo/NlXvwwYawR3Wk2W1n0aJEMCMdo4/XdE8DEzqe8IBCXViVKBKfU7mZbSAYVE
 FOMFvrNwolVNZCvkAxXmhBoQISUcNvE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-EAiEZJ5rOO6NnDT7SxnWUQ-1; Thu, 07 Aug 2025 04:36:28 -0400
X-MC-Unique: EAiEZJ5rOO6NnDT7SxnWUQ-1
X-Mimecast-MFC-AGG-ID: EAiEZJ5rOO6NnDT7SxnWUQ_1754555788
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5cd0f8961so191669085a.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 01:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754555788; x=1755160588;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=41z+kQGAhb7bAU/ZVAUZpWuuuYsDgzT56u1gqlrpLvU=;
 b=GJnf1eEs2HYzmQlZO7bXZke1rNvUF5WDKrhrvrkhksafKMoUtLoEIjqMGUPw9oVtX0
 bpFfr2nwJ1qP5qG1g1dIHsRuq5p8MOVqgJcY8gNML26AG3+X6Ytzmg/ktUxDYxIcBOTB
 +u6aYY9Gj+yXXRAXHfkgIar0NhZGVW/NSFRAVI6fxU5bhvbkDCk8zUwK9cWjW1fLQrF2
 DlaB6Q8RjRUwZW60xLWR/uUph8Udznd5DRif3jGV7PPHRVFN3NNO0VRZSLQ08EmoAzUY
 8jU9av2FMvXDMuP2KmaHHp72scNkFZ+m4cL9KC7CsnP0nGXP7bY5c+31SXeh0echsOrY
 wHZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYPJkEyVfgkAl0q+rIpDbMvhMTyQDaH9uc65NAbROpWJbHjH4sq58sb8pDXFosf90DA4GabWOBu3jt@nongnu.org
X-Gm-Message-State: AOJu0Yw4M46oUSd+7xua4wrOBJonHxQi2WFyfgXOEn4rXnS/jx+zSZQ8
 yfRYJ97hAEbdIph194fjZIRfMnX8x4kdQKOzqXDneRjLSjmuUtoW6ncq2uayLqnK3ef8Z2RZm7e
 jwPaDDnGEnI/aUAiPLynBDe+qpLqFZNUCHo75ADO1LibzIISm1NqANbgG
X-Gm-Gg: ASbGnctYS86Qqh+qwSYI2Bo7BIbWKBezvUc/vEVowFs0KeCTA0kBNXVt36dmUpik0ti
 qfC9CdSt7mf9TdVrtMfMvNny9FOLa9ZPRTysCc6GCbXCfD1za9xHzAbQUWYJCvv/17AB8gN1rhj
 DqpvM7aAGOYwh3plcPfT/+TP1X/ppVrhH2F/JsgbNz7OnsgH7IomAPzWTXRFIPOActRVjhO8aTN
 dF8a+Lfnf38DTftSmNZArW8Z9ebynomnF2+LDojgkbVh107RxtBOKlU4R5lyLHruif72G5fbA0B
 WwMgJl9KkHY6yiHyGfWPbiNh21eqay/XmrPAKaQ/4rPcBg4Lefbev+UlhC8FjwLneYiKM4Nqns8
 hAnZIiV1m
X-Received: by 2002:a05:620a:4513:b0:7e8:848:64c1 with SMTP id
 af79cd13be357-7e8165f603dmr835189285a.12.1754555788047; 
 Thu, 07 Aug 2025 01:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcABAE2okNzrbH3X9V6B7IqZzKo4EmRMZ/uJAKsfgYwwbR2wS/wRPYUttyKmdsZoAJGdsbCw==
X-Received: by 2002:a05:620a:4513:b0:7e8:848:64c1 with SMTP id
 af79cd13be357-7e8165f603dmr835187085a.12.1754555787578; 
 Thu, 07 Aug 2025 01:36:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f72a47esm919406085a.61.2025.08.07.01.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 01:36:27 -0700 (PDT)
Message-ID: <36d5da25-8cae-40e0-bea4-47c6020b4f92@redhat.com>
Date: Thu, 7 Aug 2025 10:36:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] e1000e: Prevent crash from legacy interrupt firing after
 MSI-X enable
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250806152940.362418-1-lvivier@redhat.com>
 <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <cd941b5f-c969-4d31-8153-1237fa0d0538@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/08/2025 19:44, Akihiko Odaki wrote:
> On 2025/08/07 0:29, Laurent Vivier wrote:
>> A race condition between guest driver actions and QEMU timers can lead
>> to an assertion failure when the guest switches the e1000e from legacy
>> interrupt mode to MSI-X. If a legacy interrupt delay timer (TIDV or
>> RDTR) is active, but the guest enables MSI-X before the timer fires,
>> the pending interrupt cause can trigger an assert in
>> `e1000e_intmgr_collect_delayed_causes()`.
>>
>> The function's assertion (`assert(core->delayed_causes == 0)`)
>> incorrectly assumes that it's impossible for a legacy delayed interrupt
>> to be pending once the device is in MSI-X mode.
>>
>> This behavior is incorrect. On a physical device, a driver-initiated
>> mode switch would mask interrupts, reconfigure the hardware, and clear
>> any stale interrupt states. The legacy delay timers (TIDV/RDTR) are not
>> used for moderation in MSI-X mode; the Interrupt Throttle Rate (ITR)
>> mechanism is used instead. Therefore, any pending interrupt from the
>> old mode should be ignored.
> 
> It is true that triggering assertion is incorrect as per: docs/devel/secure-coding- 
> practices.rst
> 
> However, I don't see statements in the datasheet that says mode switch will clear stale 
> interrupts.

The datasheet doesn't say "stale interrupts are cleared." but it describes two 
fundamentally separate and mutually exclusive hardware paths for generating interrupts:

Intel® 82574 GbE Controller Family Datasheet
https://docs.rs-online.com/96e8/0900766b81384733.pdf

See 7.4.1 Legacy and MSI Interrupt Modes

Legacy/MSI Path: An event (like a packet transmission completing) sets a cause bit in the 
ICR (Interrupt Cause Register). The legacy delay timers (TIDV/RDTR) can delay the 
propagation of this cause. When the timer expires, if the corresponding bit in the IMS 
(Interrupt Mask Set) is enabled, the hardware asserts the INTx pin to signal the CPU.

See 7.4.2 MSI-X Mode

MSI-X Path: An event on a specific queue (e.g., Rx Queue 1) is mapped via the IVAR 
(Interrupt Vector Allocation Register) to a specific MSI-X vector. The ITR (Interrupt 
Throttle Rate) register for that vector then determines if an interrupt should be 
generated. If allowed, the hardware performs a memory write to the address specified in 
the PCI MSI-X table, delivering the message to a specific CPU core.

Only non-queue causes are reflected in ICR (so not TIDV/RDTR).

The key here is that a TIDV timer expiring is only connected to the legacy ICR->IMS->INTx 
path. There is no described hardware path for a TIDV timer expiration to trigger an MSI-X 
memory write.

Therefore, if a guest enables MSI-X, it reconfigures its interrupt controller (APIC) to 
listen for MSI-X messages, not legacy INTx pin assertions. So, even if the stale TIDV 
timer fires on the hardware, the interrupt it generates has no configured path to be 
received by the guest OS. From the guest's perspective, the interrupt is lost. Our 
emulation should model this by ignoring/clearing the stale event, which is precisely what 
the patch does.

> 
> The expression "TIDV/RDTR are not used for moderation in MSI-X mode" is also unclear. 
> Behaving drivers may indeed use ITR for that purpose, but the question for us is: what 
> will e1000e do when the guest tries to use TIDV/RDTR in MSI-X mode anyway? That defines 
> the behavior we need to implement.

The TIDV and RDTR registers are part of the device's memory-mapped I/O space. The hardware 
will almost certainly allow a write to these registers at any time.

However, based on the separate hardware paths described above, the write would be 
ineffective. A driver could set the TIDV timer, and the timer would likely count down, but 
its expiration event is only wired to the legacy interrupt generation logic. Since the 
device is configured for MSI-X interrupt delivery, that path is dormant. The write is 
accepted, but the action is inert.

> 
> If the datasheet describes the expected behavior with delayed interrupts in MSI-X, a 
> reference to the datasheet should be made at least in the patch message. Otherwise, 
> perhaps this "if (msix_enabled(core->owner))" is just extraneous and should be removed.

The "if (msix_enabled(core->owner))" check is not extraneous and must be kept. It 
correctly separates the emulation logic for these two mutually exclusive hardware modes. 
Removing it would incorrectly allow a legacy delayed interrupt to be processed as if it 
were valid in MSI-X mode, which is not how the hardware works.

Moreover it can introduce unexpected behavior in the guest as this case could not be managed.

Thanks,
Laurent


