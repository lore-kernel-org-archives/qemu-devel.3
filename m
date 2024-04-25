Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAA9C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzx58-0002Q0-Um; Thu, 25 Apr 2024 07:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzx4w-0002Oz-Df
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:15:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzx4u-0005ev-11
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:15:50 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34c09040154so436485f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043746; x=1714648546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G4ZnQkHtsQYV5izP24jwbUnWOLUgyvTo6sYu/NbRPDw=;
 b=FXJBNhFmtOAzco+I3ZumqTT0vja1Giu/klP+1H+WvLfRQpBORG5Ib9NlU/JuH0/8pS
 o1Fox41+zI57GgMZS2sC+dlrZbP9Pkj4wOn+jtGpwHuQTKrC9yKFnTnwIHQLMFbd3aGd
 NDcwRkIvl+xVNmHkwy9qPYyFuWzhhhmTM1jithIhux2vF/Wfc107s2kxEpME7zdwb7X+
 uPhUTSnxUzjVY/17LloMQ25JF9lIMvyKp0r9NdqJhZZDVZj2mzyhgH85PaCkd1Yj9uO2
 84PyFXUDtEeGgJ3AfWg/FDoHqRi+XNXD7+xg7dpiFZ8WTDPsNqyAojupUvTzmMx61Cst
 L7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043746; x=1714648546;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G4ZnQkHtsQYV5izP24jwbUnWOLUgyvTo6sYu/NbRPDw=;
 b=hllvBuwsZj6vPoAwPoC02FZoWRtS4LksmGH4hlExTCrYMoKqyxeQ0NYKU32MqDjR4C
 qPscdpXKN5vN2WU1R2qh4B4xbHZagJyQfJMz6JBVk5XOuxSqdnRNjAZTT+ACxnnW26RA
 93JWIwaUWyCQdUY/o7OOrXcvwbnO63GMlcbcN8RJ/vaxUVo/QkQnKL4gje+zwBhN4/hI
 Sxzezp7tbd6Kzn2AgKvZhltwEe59yQcwYqCdCoDvLMIwVQIj40tQ+lFWsBwfzBOimDCD
 D0YUlWrvTDmxYrKA/AbRoF3z16p6uVleAX1nXqcIPiOt/8Ic5gbW3N27wG/fhLih7rB/
 r1rQ==
X-Gm-Message-State: AOJu0YwlDLMmJGk+iI+zWV1QcMY86nXZb9jvWLZrFV6lI76NnnYKClVm
 q4Nre3w0gNJASErIPZZwwygh2hUYXhn64+j41lUOcfiaHQo+p0jne6yECxjnT96lXsOOj3XS8rd
 J
X-Google-Smtp-Source: AGHT+IHNVvSprpQdm0fsBVrsAp4pC+/X6FOYAgl7gsWdIf/HKlgpfNElYK91YOMnBH9c7xt4Mpw2Fw==
X-Received: by 2002:a5d:5648:0:b0:34a:e884:977b with SMTP id
 j8-20020a5d5648000000b0034ae884977bmr3649116wrw.32.1714043745664; 
 Thu, 25 Apr 2024 04:15:45 -0700 (PDT)
Received: from [192.168.66.175] ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 j6-20020a5d5646000000b0034b19cb1531sm9938325wrw.59.2024.04.25.04.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 04:15:45 -0700 (PDT)
Message-ID: <fab578a2-42a2-4963-be4f-8cbb73e11404@linaro.org>
Date: Thu, 25 Apr 2024 13:15:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/audio/virtio-snd: Use device endianness instead of
 target one
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-stable@nongnu.org
References: <20240422170056-mutt-send-email-mst@kernel.org>
 <1f6447c4-ea4c-4bd3-a879-8efb72448bb8@linaro.org>
 <20240422170913-mutt-send-email-mst@kernel.org>
 <CAAjaMXZxFJtEdJh38_76ZdL82JBM52Ke0+p1K07miiFeQSJtcw@mail.gmail.com>
 <CAAjaMXaoPeCVpd=q-d2GH25SfrNPVqh6hCerMOrQ6payXVMmyA@mail.gmail.com>
 <f5c67478-4fb9-4fb9-a6b2-286d6372bd0a@linaro.org>
 <b9fb7a87-2328-4999-8f7e-6b6cf04984a3@ilande.co.uk>
 <CAAjaMXa00nWejPRc_Xc9fnoncXVDiWO9MNabwq-QU5nepA4b9w@mail.gmail.com>
 <fd6b0336-ecc7-4c0e-aa48-f8e984d293dc@ilande.co.uk>
 <CAAjaMXaBd8+DuNzeVO9k=6ojt5brt1nmm1gApdwgXJ3JzjisTA@mail.gmail.com>
 <20240425062213-mutt-send-email-mst@kernel.org>
 <CAAjaMXYTGUUeABd+Ghaf374pOFjoF7RdncTTiciLhmo1yXXZVQ@mail.gmail.com>
 <f85ab427-9cb4-4034-8fd7-29acc4d0b8a9@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f85ab427-9cb4-4034-8fd7-29acc4d0b8a9@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 25/4/24 12:40, Mark Cave-Ayland wrote:
> On 25/04/2024 11:26, Manos Pitsidianakis wrote:
> 
>> On Thu, 25 Apr 2024 at 13:24, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>
>>> On Thu, Apr 25, 2024 at 01:04:31PM +0300, Manos Pitsidianakis wrote:
>>>> On Thu, 25 Apr 2024 at 10:49, Mark Cave-Ayland
>>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>>
>>>>> On 25/04/2024 07:30, Manos Pitsidianakis wrote:
>>>>>
>>>>>> On Wed, 24 Apr 2024 at 13:31, Mark Cave-Ayland
>>>>>> <mark.cave-ayland@ilande.co.uk> wrote:
>>>>>>>
>>>>>>> On 23/04/2024 12:05, Philippe Mathieu-Daudé wrote:
>>>>>>>
>>>>>>>> On 23/4/24 11:18, Manos Pitsidianakis wrote:
>>>>>>>>> On Tue, 23 Apr 2024 at 11:47, Manos Pitsidianakis
>>>>>>>>> <manos.pitsidianakis@linaro.org> wrote:
>>>>>>>>>>
>>>>>>>>>> On Tue, 23 Apr 2024 at 00:11, Michael S. Tsirkin 
>>>>>>>>>> <mst@redhat.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> On Mon, Apr 22, 2024 at 11:07:21PM +0200, Philippe 
>>>>>>>>>>> Mathieu-Daudé wrote:
>>>>>>>>>>>> On 22/4/24 23:02, Michael S. Tsirkin wrote:
>>>>>>>>>>>>> On Mon, Apr 22, 2024 at 04:20:56PM +0200, Philippe 
>>>>>>>>>>>>> Mathieu-Daudé wrote:
>>>>>>>>>>>>>> Since VirtIO devices can change endianness at runtime,
>>>>>>>>>>>>>> we need to use the device endianness, not the target
>>>>>>>>>>>>>> one.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Cc: qemu-stable@nongnu.org
>>>>>>>>>>>>>> Fixes: eb9ad377bb ("virtio-sound: handle control messages 
>>>>>>>>>>>>>> and streams")
>>>>>>>>>>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>>
>>>>>>>>>>>>> This is all completely bogus. Virtio SND is from Virtio 1.0 
>>>>>>>>>>>>> only.
>>>>>>>>>>>>> It is unconditionally little endian.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> This part of the code is for PCM frames (raw bytes), not 
>>>>>>>>>> virtio spec
>>>>>>>>>> fields (which indeed must be LE in modern VIRTIO).
>>>>>>>>>
>>>>>>>>> Thought a little more about it. We should keep the target's 
>>>>>>>>> endianness
>>>>>>>>> here, if it's mutable then we should query the machine the 
>>>>>>>>> device is
>>>>>>>>> attached to somehow. the virtio device should never change 
>>>>>>>>> endianness
>>>>>>>>> like Michael says since it's not legacy.
>>>>>>>>
>>>>>>>> Grr. So as Richard suggested, this need to be pass as a device
>>>>>>>> property then.
>>>>>>>> (https://lore.kernel.org/qemu-devel/ed134c9d-6e6f-465b-900f-e39ca4e09876@linaro.org/)
>>>>>>>
>>>>>>> It feels to me that the endianness is something that should be 
>>>>>>> negotiated as part of
>>>>>>> the frame format, since the endianness of the audio hardware can 
>>>>>>> be different from
>>>>>>> that of the CPU (think PReP machines where it was common that a 
>>>>>>> big endian CPU is
>>>>>>> driving little endian hardware as found on x86).
>>>>>>
>>>>>> But that is the job of the hardware drivers, isn't it? Here we are
>>>>>> taking frames passed from the guest to its virtio driver in the 
>>>>>> format
>>>>>> specified in the target cpu's endianness and QEMU as the device 
>>>>>> passes
>>>>>> it to host ALSA/Pipewire/etc which in turn passes it to the actual
>>>>>> audio hardware driver..
>>>>>
>>>>> The problem is that the notion of target CPU endian is not fixed. 
>>>>> For example the
>>>>> PowerPC CPU starts off in big-endian mode, but these days most 
>>>>> systems will switch
>>>>> the CPU to little-endian mode on startup to run ppc64le. There's 
>>>>> also the ILE bit
>>>>> which can be configured so that a big-endian PowerPC CPU can 
>>>>> dynamically switch to
>>>>> little-endian mode when processing an interrupt, so you could 
>>>>> potentially end up with
>>>>> either depending upon the current mode of the CPU.
>>>>>
>>>>> These are the kinds of issues that led to the later virtio 
>>>>> specifications simply
>>>>> using little-endian for everything, since then there is zero 
>>>>> ambiguity over what
>>>>> endian is required for the virtio configuration space accesses.
>>>>>
>>>>> It feels to me that assuming a target CPU endian is fixed for the 
>>>>> PCM frame formats
>>>>> is simply repeating the mistakes of the past - and even the fact 
>>>>> that we are
>>>>> discussing this within this thread suggests that at a very minimum 
>>>>> the virtio-snd
>>>>> specification needs to be updated to clarify the byte ordering of 
>>>>> the PCM frame formats.
>>>>>
>>>>>
>>>>> ATB,
>>>>>
>>>>> Mark.
>>>>>
>>>>
>>>>
>>>> Agreed, I think we are saying approximately the same thing here.
>>>>
>>>>   We need a mechanism to retrieve the vCPUs endianness and a way to
>>>> notify subscribed devices when it changes.
>>>
>>> I don't think I agree, it's not the same thing.
>>> Guest should just convert and send data in LE format.
>>> Host should then convert from LE format.
>>> Target endian-ness does not come into it.
>>
>> That's not in the VIRTIO 1.2 spec. We are talking about supporting
>> things as they currently stand, not as they could have been.
> 
> Can you also clarify the particular case that you're trying to fix - is 
> it big-endian on ARM, or something else?

I'm only aware of big-endian on ARM.

Regards,

Phil.

