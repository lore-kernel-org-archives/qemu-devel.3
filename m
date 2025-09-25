Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6835ECAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 00:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1ZdJ-0007RK-UG; Wed, 24 Sep 2025 20:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZdI-0007Pu-6S
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:14:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1ZdC-00024z-EY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 20:14:46 -0400
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-46d25f99d5aso10959475e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 17:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758759277; x=1759364077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z5mVfEiU0DZt2GEnnhR0MnVrerb80VQxDG6tv5ItMM8=;
 b=m14W6KEAOcozecREQ5pBZhMMSPxK7xnhWAIXxOrfWZ/sIeeJop+L+1wP1BZYEYIuGE
 lSP3Qc7Kz2EWfyu6d8ZLgFXZkqt9ZIW7FAr8QXFoUE6ZXWqivC6kX6Ccg/E+gRdJ5LtD
 R/rMV9hqgruzjiMfBzZjGcIdUXi1wkVbXjI4BCQ6tJMJVUmbV+z+jkbz9mt2vv6yfa+h
 XdUK0yCIJtRwGehdo/vK/9yRUztK8TU+SXnOEBv5dneoIjO9XTGt9NQubfSOdAd4raVr
 8UY6TkVDtzXQcsXAtmlZUnrG6l47FtUBBOXh3kuTCrGWUO8PUtUOdO1CP+mcqw9ceIHv
 JWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758759277; x=1759364077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z5mVfEiU0DZt2GEnnhR0MnVrerb80VQxDG6tv5ItMM8=;
 b=lDALa4sMGOuUqG/Dm8gKYwww/PQVoYAic6G/nSDZqaDHaDtJwY5FBQq3bL71hvzV5u
 S60Z/EgeeexiiBl0xeN6llRCGwdfRYRODBQF3QsNjgQnTUaZdzFu8OV8OeKzZy0gcVmC
 l+dgHlvZnJp7AGVwLDagOGlDJEW6zn9vw1YZHYLfTcnaVgVHp3e/JMRCCVd7Rc1fsfiu
 ARhYhFuuIbkz91acA29lM9uiG8+CE2fZX0mIB6eyXI/4b0fdGgCOwg9AVPQ5KjNjtrcA
 7l75A0PgFr7GzmLQqMK6c93raHcm46UkTOJunfOp/mgz/6fsyd5oawyuW7+02MgjZR3M
 X86g==
X-Gm-Message-State: AOJu0YyJdR+0eRUI0KIWgMUojd2G8RhGNYfxKe4aLXT+oeIpiGpig2gD
 BMk00J/Dno7/f0yjPkf6yZRRTDxNjIS5EvhUAVCC87oC/JsfszuhdEqJYYi5ds/aMog=
X-Gm-Gg: ASbGncuh2gmUuDJEoODTzD/iHRWuMyNrtcwcKGxt1sje6b2GRrU2m3Iqr5HDim320h1
 DhsFoXuyCYJoI6oPgq1P/9SbvbeQm6WwmkbZqgkkWwGtxOBJGWSpPP+hN5DItfgHnIE5NmKWXbu
 i4zps9Ykd3w2MseoAIgEcQUtKEdGyu6svfIThpJOzBqHfUzSe+fwRlU9eEqh6XQjApkQGJ30ntu
 ZbcQAov0MuuMXqrnvFQLgHdXEZBLhX26dORV6uzlVAVNdxNuCP1xRSLCGOl2yIZYiN8cPEPbaL0
 LTXbGa4c+sAahcQHnPrWCkeJUXTughZh4qFZxPCIxacXB565w+Ge7cR7jMNeA5mWbOq2Nd8GZsF
 Mmr9+/1j3agL6X0WBoqrJmxASQuErux31Rski+ebFW8uqLss2cNLNyp8cEtNv2uc2UQ==
X-Google-Smtp-Source: AGHT+IHR9KivEskQy77hkVv5tBANpZO/ILhMhGUkrFchAB7ZZg07dmnSaPPe+lTQZn4Ecm4rgwMWyQ==
X-Received: by 2002:a05:6000:610:b0:3ee:11d1:2a1e with SMTP id
 ffacd0b85a97d-40f5fea54d4mr449230f8f.10.1758759277359; 
 Wed, 24 Sep 2025 17:14:37 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33bef4b4sm8402435e9.20.2025.09.24.17.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 17:14:35 -0700 (PDT)
Message-ID: <10ba1122-8b36-4843-96e6-30a89c78f0f7@linaro.org>
Date: Thu, 25 Sep 2025 02:14:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
 <aL7xrilR-gyByKEM@redhat.com>
 <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_wt3HwDq=sJ+VuLdx_RFFwB6E9FjrbT1zgNXGGvfQ9YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 8/9/25 17:15, Peter Maydell wrote:
> On Mon, 8 Sept 2025 at 16:09, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Mon, Sep 08, 2025 at 01:50:57PM +0100, Peter Maydell wrote:
>>> Currently our security policy defines a "virtualization use case"
>>> where we consider bugs to be security issues, and a
>>> "non-virtualization use case" where we do not make any security
>>> guarantees and don't consider bugs to be security issues.
>>>
>>> The rationale for this split is that much code in QEMU is older and
>>> was not written with malicious guests in mind, and we don't have the
>>> resources to audit, fix and defend it.  So instead we inform users
>>> about what the can in practice rely on as a security barrier, and
>>> what they can't.
>>>
>>> We don't currently restrict the "virtualization use case" to any
>>> particular set of machine types.  This means that we have effectively
>>> barred ourselves from adding KVM support to any machine type that we
>>> don't want to put into the "bugs are security issues" category, even
>>> if it would be useful for users to be able to get better performance
>>> with a trusted guest by enabling KVM. This seems an unnecessary
>>> restriction, and in practice the set of machine types it makes
>>> sense to use for untrusted-guest virtualization is quite small.
>>>
>>> Specifically, we would like to be able to enable the use of
>>> KVM with the imx8 development board machine types, but we don't
>>> want to commit ourselves to having to support those SoC models
>>> and device models as part of QEMU's security boundary:
>>> https://lore.kernel.org/qemu-devel/20250629204851.1778-3-shentey@gmail.com/
>>>
>>> This patch updates the security policy to explicitly list the
>>> machine types we consider to be useful for the "virtualization
>>> use case".
>>>
>>> This is an RFC partly to see if we have consensus that this change
>>> makes sense, and partly because I was only able to identify the
>>> machine types we want to cover for some of our target architectures.
>>> If maintainers for the other architectures could clarify which
>>> machine types work with KVM that would be helpful.
>>
>> The split of "virtualization" vs "non-virtualization" use case
>> in the docs was always as rather a crude hack.
>>
>> "Virtualization uses cases" was more or less a code phrase to
>> mean "the subset of QEMU that we traditionally shipped in RHEL"
>> as that is approximately what we have reasonable confidence
>> about.
>>
>> Personally I wouldn't assign strict equivalence between "machine
>> can use KVM" and  "virtualization use case".
> 
> I agree, but this is effectively what our docs are currently doing,
> and what I'm trying to decouple with this patch...
> 
>> Case in point - the "isapc" machine type can use KVM but I would
>> not consider that to be a virtualization use case, and would likely
>> reject a security report if it /only/ affected isapc, and not 'pc'
>> / 'q35'.
>>
>> We didn't want to undertake the work to annotate every QOM/QDev
>> impl in QEMU with info about whether we considered it in scope
>> for security fixes or not, which is what we really ought to do
>> at some point. The main challenge is someone having the time
>> to do the audit & annotation work.
>>
>>> diff --git a/docs/system/security.rst b/docs/system/security.rst
>>> index f2092c8768b..395c2d7fb88 100644
>>> --- a/docs/system/security.rst
>>> +++ b/docs/system/security.rst
>>> @@ -35,6 +35,34 @@ malicious:
>>>   Bugs affecting these entities are evaluated on whether they can cause damage in
>>>   real-world use cases and treated as security bugs if this is the case.
>>>
>>> +To be covered by this security support policy you must:
>>> +
>>> +- use a virtualization accelerator like KVM or HVF

If the "split-accel" (HW virtualization + SW emulation) effort lands,
we'll have a case of HVF + TCG. Do we want to consider it within our
security support policy? I doubt it (at least at the beginning). However
that would match "use a virtualization accelerator like KVM or HVF" (AND
"use one of the machine types listed below" with the 'virt' machine).

Should we reword? Or explicit "Any SW emulation use case is NOT
covered"?

>>> +- use one of the machine types listed below
>>> +
>>> +It may be possible to use other machine types with a virtualization
>>> +accelerator to provide improved performance with a trusted guest
>>> +workload, but any machine type not listed here should not be
>>> +considered to be providing guest isolation or security guarantees,
>>> +and falls under the "non-virtualization use case".
>>> +
>>> +Supported machine types for the virtualization use case, by target architecture:
>>> +
>>> +aarch64
>>> +  ``virt``
>>> +i386, x86_64
>>> +  ``microvm``, ``xenfv``, ``xenpv``, ``xenpvh``, ``pc``, ``q35``, ``isapc``
>>> +s390x
>>> +  ``s390-ccw-virtio``
>>> +loongarch64:
>>> +  ``virt``
>>> +ppc, ppc64:
>>> +  TODO
>>> +mips, mips64:
>>> +  TODO
>>> +riscv32, riscv64:
>>> +  TODO
>>
>> Currently 'virtualization use case' is reasonably vague such that we can
>> bend its scope as we desire, at the time it is questioned in a possible
>> security report.
>>
>> Machine types are only one aspect of this. Devices are the other, and
>> the area where it gets significantly more fuzzy and difficult because
>> essentially any device can be used with KVM, and where we draw the
>> line is fairly arbitrary.
> 
> I think that being vague like this is a disservice to our users.
> If I'm a user of QEMU, I'd like to know whether I'm inside the
> line or outside of it before I put my config into production,
> not later on when it turns out there was an exploitable bug
> that wasn't classified as a security issue...
> 
> Most devices can't in fact be used with KVM, because they're
> sysbus devices that aren't used in the machines that you can
> use with KVM. Pluggable devices are rarer (and yes, under
> our current policy random PCI devices are effectively
> in-scope).
> 
> thanks
> -- PMM


