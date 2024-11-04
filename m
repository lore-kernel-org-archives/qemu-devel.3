Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D2FBD1BDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80YF-0004Dz-3p; Mon, 04 Nov 2024 12:07:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t80Y9-0004AC-QS
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:07:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t80Y6-0006Gs-OJ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:07:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730740047;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9kd/SLSKtmTJFWvEeiYbH/ZTYsZ9MzO/O/GCUBVtKaw=;
 b=c84Sr+iSq3dfnrfY3Fd+U6I6nQB+LncC/vrz/kQ6sMXCRpWCRu91x4ZBwvzM6JJ2ISvA4O
 0oH5T6ECjQZ0698OpCa2mJQ41lF8+YLJknu6U5qOHBXlSVfdyRHj94c5218+AhkbC12HNH
 yL2vlF95VuSRPIjU2xTyrlFbFF2hAbY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-hiQ4lIgdP9GJJ4Ed-K4wJw-1; Mon, 04 Nov 2024 12:07:26 -0500
X-MC-Unique: hiQ4lIgdP9GJJ4Ed-K4wJw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315d98a75fso30628125e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:07:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730740045; x=1731344845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9kd/SLSKtmTJFWvEeiYbH/ZTYsZ9MzO/O/GCUBVtKaw=;
 b=BaCIN1/Qd7gwBXkk9HI4EIf3mZrfb6io02ZQDHUrsPMoWPzoliHZIm8LVNz7F+oWVk
 KzZ+zAjbKrUunyLygAMeG1YclQlqDFNXLYflEGYj2YEV4lsn6iE6yw5u85dAUV4rWtcl
 UkYhLbTmps0cWVFX883GFFwsYj3UxDrfGwQIFUdRvR3Sb5RAa3p5Py1s6UNCPTuA4+Xd
 8TPcxmuPAwkp++b1d7l6qy5yptCxWHDOPv+cZ4iUMZmXA0bWjlnzbGqTCX8C9ehgX8ew
 HBwVpRb2UBtIgkAr6E431HN0ia/MuXItIoCn5Bi+3uGyaCkj3YwOCqcS5ZUDjbFZi/nH
 VqdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAcDAVccdZ0eokTBiWIGMeTUnIV03Cqg2duMy9PCrCdWicUTdKlDFmuqVDDJGj2bgKw/cuTQhfBiXH@nongnu.org
X-Gm-Message-State: AOJu0YxhNoARiobC0JN8A0IGi/9b3Hvsbsu4+UA1AJXQyXCpeCKaZHfe
 umXrA15imcgZ9FZKL3APThgl8cS3Q+VE9v+PAY2kHAVwwvN009tJ/zm8q3PFC8QWkZRFsDkPUNp
 qWz57A3fympw3NcmDZdn4JPdDkt8yCQEj4fkaxNOZZ4xsaTkF15DV
X-Received: by 2002:a05:600c:3b07:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-4319ad361dfmr283157395e9.32.1730740045193; 
 Mon, 04 Nov 2024 09:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZvDg4fTtX5ZmRLfNudb/l0TZaDxUkgWzH2OS49xWRILUJ7G0tKC0AXxSffyMyeP9Iy/9AXg==
X-Received: by 2002:a05:600c:3b07:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-4319ad361dfmr283156685e9.32.1730740044307; 
 Mon, 04 Nov 2024 09:07:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698144sm163984475e9.39.2024.11.04.09.07.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 09:07:23 -0800 (PST)
Message-ID: <48637795-14b9-4b0c-9fb5-46b387be4fd0@redhat.com>
Date: Mon, 4 Nov 2024 18:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 21/21] arm/cpu-features: Document custom vcpu model
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, eric.auger.pro@gmail.com,
 cohuck@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 kvmarm@lists.linux.dev, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <20241025101959.601048-22-eric.auger@redhat.com> <Zx__Zi3Zpg1AspnE@pinwheel>
 <52690aae-55b6-47d5-a308-dd75475f8377@redhat.com>
 <CAFEAcA9y5ooPNZ7JbGmRyTKbZn5XPK+5zZgVAvnER=++kWuBrg@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA9y5ooPNZ7JbGmRyTKbZn5XPK+5zZgVAvnER=++kWuBrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 11/4/24 17:30, Peter Maydell wrote:
> On Mon, 4 Nov 2024 at 15:34, Eric Auger <eric.auger@redhat.com> wrote:
>> Hi Kashyap,
>>
>> On 10/28/24 22:17, Kashyap Chamarthy wrote:
>>> On Fri, Oct 25, 2024 at 12:17:40PM +0200, Eric Auger wrote:
>>>> From: Cornelia Huck <cohuck@redhat.com>
>>>>
>>>> Add some documentation for the custom model.
>>>>
>>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  docs/system/arm/cpu-features.rst | 55 +++++++++++++++++++++++++++-----
>>>>  1 file changed, 47 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/docs/system/arm/cpu-features.rst b/docs/system/arm/cpu-features.rst
>>>> index a5fb929243..962a2c6c26 100644
>>>> --- a/docs/system/arm/cpu-features.rst
>>>> +++ b/docs/system/arm/cpu-features.rst
>>>> @@ -2,7 +2,10 @@ Arm CPU Features
>>> [...]
>>>
>>>> +Using the ``host`` type means the guest is provided all the same CPU
>>>> +features as the host CPU type has.  And, for this reason, the ``host``
>>>> +CPU type should enable all CPU features that the host has by default.
>>>> +
>>>> +In case some features need to be hidden to the guest, ``custom`` model
>>>> +shall be used instead. This is especially useful for migration purpose.
>>>> +
>>>> +The ``custom`` CPU model generally is the better choice if you want more
>>>> +flexibility or stability across different machines or with different kernel
>>>> +versions.
>>> Does "more flexibility or stability across different machines" also
>>> imply "live migration compatiblity across host CPUs"?
>> yes that's the goal
>>>> However, even the ``custom`` CPU model will not allow configuring
>>>> +an arbitrary set of features; the ID registers must describe a subset of the
>>>> +host's features, and all differences to the host's configuration must actually
>>>> +be supported by the kernel to be deconfigured.
>>> [...]
>>>
>>>> +The ``custom`` CPU model needs to be configured via individual ID register
>>>> +field properties, for example::
>>>> +
>>>> +  $ qemu-system-aarch64 -M virt -cpu custom,SYSREG_ID_AA64ISAR0_EL1_DP=0x0
>>> If possible, it would be really helpful (and user-friendly) to be able
>>> to specify the CPU feature names as you see under /proc/cpuinfo, and be
>>> able to turn the flags on or off:
>>>
>>>         -M virt -cpu franken,rndr=on,ts=on,fhm=off
>>>
>>> (... instead of specifying long system register IDs that groups together
>>> a bunch of CPU features.  If I understand it correctly, the register
>>> "ID_AA64ISAR0_EL1" maps to a set of visible features listed here:
>>> https://docs.kernel.org/arch/arm64/cpu-feature-registers.html)
>> Not all the writable ID regs are visible through the above technique.
>> But indeed I think we converged on the idea to use higher level feature
>> names than ID reg field values.
>> However we need to study the feasibility and mappings between those high
>> level features and ID reg field values.
>> The cons is that we need to describe this mapping manually. Besides
>> being cumbersome this is also error prone.
> You might be interested in "Arm Architecture Features" on
> https://developer.arm.com/Architectures/A-Profile%20Architecture#Downloads
> which includes a 1.8MB Features.json which is a machine
> readable version of the "what are the features and their
> dependencies and ID registers and so on" information.
thank you for the link.
>
> But note that (a) it is alpha quality and (b) I am not personally
> going to try to interpret what might be reasonable to do with it
> based on the legal notice attached to it: that's a matter for
> you and your lawyer ;-)

Thank you for the notice. This may be similar to the ARM xml mentioned
by Marc...

Eric
>
> -- PMM
>


