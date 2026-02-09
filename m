Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DD02E81BCB
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 15:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpSjb-0005SD-Ll; Mon, 09 Feb 2026 09:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vpSja-0005Rj-1q
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:59:30 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vpSjY-00080Y-2G
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 09:59:29 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b8869cd7bb1so561588766b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 06:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770649166; x=1771253966; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AcAorsrXsp+S3nB5onb9YV5cu7Z6kn3YGrGK1EJFqo=;
 b=TOkdaXNEXH4giH5PyHdrBqr0rp/QGhJGsSxlabj1BTdr3cm604f8TlAI5Kkzp2qvkk
 NXmwTo+hAwE0pE3L4X2bW/U/ymqEAR7zYAegI1f7EKxgzFcZnVe6EeNMAHynwX4JBXJr
 64sijlPPEFwG198l42USZtDl5RdJ3vwBRHaN6RTa0qu6DCLd8XVW0rFb6tCPWQWyZcHt
 Xl4+cv9yos9WseKxwQZnm82+Ba9YHycl9xsHMes+rowKgJgg390Us6XjH4wBbKKNQsKH
 3XIoK2KhslFT4/Fsk2qdM+4qaFHfovhuy0z0zHiTO8YTVGrVfdqCKREEM5hVLkgPH2dV
 27tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770649166; x=1771253966;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3AcAorsrXsp+S3nB5onb9YV5cu7Z6kn3YGrGK1EJFqo=;
 b=ORzggQH2SQO0jXwwXLCbwFXXqOuWYOrvng7BpENGTihwd43vBYnvRJO/VjSMtU8PCz
 skZKJEhaKDES3UDtqoy5Csmk+fcbuGhL/1QvKE+aWcPfRBBV1jMRSCZdIo5TsfjZKjBN
 BJgE1tzhKqnCHNwQrgNIE7vCYPojlvlKY8xlpODk5zhXaFcxOR8MemrZ8ViMPwmxH4WV
 F7mPLTbi5C5gDgaEF5TsMgYkeYF3VKOCwZT9kD4mhAroouMgHIzdWJI9Ln10bP9kqdUN
 kvRymXKD4M0EV6J15JYKmA2uxtXp5VoEXJzGmqT/+kkOZCa+OnSFSDvp76wyx9fMG7A6
 5OZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjyhbLw0pmqcCZPN3x2Ik63uD70YfEoa209QfoiNK0ISDCIjXPWkPT8hTQY8hhR3hSnXzpmR1RwEdM@nongnu.org
X-Gm-Message-State: AOJu0YxbJhb+JoczbKzOE5ym7jBbzQpJeRx3otoHcR5MqFSk4kNljSw0
 hEIR2/Pq/2RfdgvXgmryZ0gDzC9T/eTRtLybkJf+K7cPmPSzzxnOVQI/wCSIaPhK+d8=
X-Gm-Gg: AZuq6aKOeW6Nd6caI1TiKdiEvTXTuBzPRqHn/hYJahaRaM1Tk24AcdmHh2aHDsqe11u
 5otIxNp6Y9WRPRRiMst2yhp6Ji3IsbVeZ1JbO3Bid7AdholxBzGrA+TzX2xbWog4mv24buX2wVs
 X1EYCOhTI9Ucj0HYUnu1y7Mg/3LqZ7szRKZyVMC7U71QPqkvdSwe66buaI4zt3+qN9OgyvG+q1/
 Heuog1knS7j4uHVrDTIl4o+c08hdrPJp/jpG3QAplebC/j9MVkDJOLwSz/hoJdwuibX6f3nyFZQ
 lNJiV3fCMpxt1uxKd3PeR8wAED4838Kso8rFoqF6rvDo+hw4xUainwoSufs2W3wso0W9x0cpeOf
 gTy1zZWhjAS/k8kU6OG6lRmjqGlWN4A0G8D8LyFvHVtADMfmrO9mdHTOWqunY1EHt9fZKv7gRs/
 Sl/6PZiSL3Z8w=
X-Received: by 2002:a17:906:7315:b0:b8e:4790:d7cf with SMTP id
 a640c23a62f3a-b8edf344040mr659045066b.53.1770649165573; 
 Mon, 09 Feb 2026 06:59:25 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8eda7e2ca1sm397975866b.29.2026.02.09.06.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 06:59:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 16DF65F80A;
 Mon, 09 Feb 2026 14:59:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Auger <eric.auger@redhat.com>,  eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  cohuck@redhat.com,
 maz@kernel.org,  oliver.upton@linux.dev,  sebott@redhat.com,
 gshan@redhat.com,  ddutile@redhat.com,  peterx@redhat.com,
 philmd@linaro.org,  pbonzini@redhat.com
Subject: Re: [PATCH v6 00/11] Mitigation of "failed to load
 cpu:cpreg_vmstate_array_len" migration failures
In-Reply-To: <CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com>
 (Peter Maydell's message of "Fri, 6 Feb 2026 14:15:12 +0000")
References: <20260126165445.3033335-1-eric.auger@redhat.com>
 <CAFEAcA-gi42JObOjLuPudABX8WRdWf5SzSbkzU-bd06ecF1Vog@mail.gmail.com>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 09 Feb 2026 14:59:24 +0000
Message-ID: <87h5rqyncj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Peter Maydell <peter.maydell@linaro.org> writes:

> On Mon, 26 Jan 2026 at 16:54, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> When migrating ARM guests accross same machines with different host
>> kernels we are likely to encounter failures such as:
>>
>> "failed to load cpu:cpreg_vmstate_array_len"
>>
>> This is due to the fact KVM exposes a different number of registers
>> to qemu on source and destination. When trying to migrate a bigger
>> register set to a smaller one, qemu cannot save the CPU state.
>>
>> For example, recently we faced such kind of situations with:
>> - unconditionnal exposure of KVM_REG_ARM_VENDOR_HYP_BMAP_2 FW pseudo
>>   register from v6.16 onwards. Causes backward migration failure.
>> - removal of unconditionnal exposure of TCR2_EL1, PIRE0_EL1, PIR_EL1
>>   from v6.13 onwards. Causes forward migration failure.
>
> Hi; sorry I haven't given this series any attention before.
>
> (1) Yes, this is definitely a problem we need to solve.
>
> (2) What are the requirements we have for this?
>
> This series sets up CPU properties controlling this, and then
> sets them in the virt machine model based on the machine
> type, but this seems awkward for two reasons:
>
>  * using properties confines us to using a "text string"
>    way of describing the behaviour; if we could implement
>    the handling in code and C data structures in target/arm
>    we could potentially do it in a more flexible and
>    readable way (e.g. being able to specify the register
>    via something other than a raw hex value)
>  * different host kernel versions isn't really related to
>    the QEMU version, so tying it to a versioned machine
>    type doesn't seem to fit
>
> Q: Do we need the user to be able to control this (e.g. adding
> extra registers to be ignored) on their command line, or
> can we say "you need a newer QEMU that understands how to
> deal with this register if you want to do migrations involving
> this newer kernel version" ?
>
> Q: This series adds a "hide this register" option which
> stops the register appearing in the outbound migration data.
> Do we need that, or would it be enough to have "ignore this
> register in the inbound migration data" ? Assuming we're
> not trying to migrate backwards to an older QEMU version
> that's unaware of the new register, that seems to me like
> it should be equivalent.

As I understand it these signal to the guest what services the
hypervisor supplies. I assume the guest kernel only reads these once at
boot up rather than before invoking any particular service?

If this is the case then things would break if a new host couldn't
support the guest's request of the hypervisor service.

>
> (3) Categories of sysreg that are causing problems:
>
> a: "controls" -- like the PSCI_VERSION pseudoreg. Here the setting
> controls what the kernel is exposing to the guest, and so we need
> to be able to have the user tell QEMU to use a specific version
> that's not the host kernel default if the default isn't one
> that's valid for all older kernels. Sometimes the new kernel
> default is the same as the old kernel's behaviour and in those
> cases we also want handling of "if you see the control reg in
> the incoming data and its value is the default then it's OK to
> ignore it".
>
> b: "things exposed that should not have been" -- where the old kernel
> exposed a register but the new one does not because exposing the
> register was wrong (i.e. a bug). The handling here can be
> "ignore this in migration input if present". Examples are the
> TCG2_EL1, PIRE0_EL1, PIR_EL1 regs that shouldn't exist if the
> corresponding feature was disabled for the guest.
>
> c: "things not exposed that should have been" -- where a new kernel
> exposes a new register that the old one does not, and so migration
> from a host with the new kernel to the old one fails. In most cases
> it should be possible to handle this with "ignore in migration input
> if present", or "fail migration if incoming value is not some safe
> default, but if it is that default value then ignore".

Shame we don't know if the guest ever read the register. If the old host
provides features the new host doesn't but it never probed anyway then
neither the guest or new host needs to care about the register.

>
> Have I missed anything ?
>
> (4) Mechanisms for handling them:
>
> This series provides two mechanisms:
>
> "safe missing reg" -- these registers are ignored if they appear
> in the incoming migration data.
>
> "hidden" -- the behaviour here is that we effectively entirely
> ignore the register, so we do not read it from the kernel or write
> it back, do not send it in outbound migration data, and do
> not expect to see it in incoming migration data.
>
> The "arm: add kvm-psci-version vcpu property" series handles one
> specific "control" register, with a specific user-facing cpu property.
> If new "control" type registers are rare, this seems like a good
> way to go, because it means we can give the user an interface that
> is reasonably clear about what it does, and we can provide better
> errors on the migration-destination side (e.g. pointing the user
> at the need to specify the property on the source side to get a
> VM they can migrate to this destination).
>
> The only use of "hidden" so far is for KVM_REG_ARM_VENDOR_HYP_BMAP_2.
> However, I'm not sure this is the right way to handle this register.
> Judging from the documentation, this seems to be a "control" register:
> it would let QEMU enable certain things to be visible to the guest.
> It also is odd to treat this differently from the existing
> KVM_REG_ARM_VENDOR_HYP_BMAP register, which has exactly the same
> semantics.
>
> I think that the right way to treat this register would be
> "if this is present in the incoming migration system and the
> host kernel doesn't know about it, a value of zero is OK, but
> any other value should fail migration".
>
> In general I'm not convinced that "hidden" is a useful thing
> to provide -- it should always be fine for QEMU to read and
> write back to the same host kernel some sysreg it doesn't
> know about, so what "hidden" is mostly doing is "don't put
> this into outgoing migration data". Do we need to be able
> to do that, or can we instead always use a "ignore in
> incoming migration data" strategy?
>
> (5) My preferences
>
> I think that assuming that it meets the requirements, I would
> prefer something like a mechanism where we use some kind of
> C data structure / code in target/arm/machine.c to represent
> "this register needs some special handling", where the special
> handling might be:
>  - ignore if present in input
>  - if present in input, value must be X, otherwise fail
>    migration
>  - maybe some other things if we need them
>
> and this is not tied to specific QEMU machine versions and
> isn't something we expose via QOM properties.
>
> I'd rather avoid the "hidden" register idea unless we
> definitely need it in addition to "ignore in incoming data".
>
> thanks
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

