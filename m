Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE39C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 23:41:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thzrs-0004jS-Ec; Tue, 11 Feb 2025 18:40:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1thzrq-0004jB-F0; Tue, 11 Feb 2025 18:40:38 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1thzro-00010w-FI; Tue, 11 Feb 2025 18:40:38 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5de7519e5a7so3827537a12.2; 
 Tue, 11 Feb 2025 15:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739317233; x=1739922033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/5Nb9o4KF3LWCwuMPwYQTtNfalzd7ogY1Xyw/B3g2Y=;
 b=TuP6BX+Er6Fk5ldfqbTslXBR/aGOz6i2ZVhSdeaRnlaogTBykZI2J4zx2uO1zkh/mw
 Y7vaqvS0+ArtbDZTWqDeWGSPJVL35eQOHv5N4LyRcVBa5ssuCuF738sMovGpqT96kzdX
 NPYuT7P0tr7bN+bgHgcwNaGiHPRuhiP08+2mCaKviklJ+BZv58YTKT2aagd4faA9GQgL
 IJpzvw37oUltEMC9qHmSLvS0WXPHWvWTMRGtmaVNK/xPVncEhynk+kYIBSUaSiJ/vn0H
 Jk7l4/ji3CqJkaoC52mpUPO+otUhY495zH+1LRq6/vIr2RuyWVLeGItVmNSUSFt7oeO5
 Qlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739317233; x=1739922033;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/5Nb9o4KF3LWCwuMPwYQTtNfalzd7ogY1Xyw/B3g2Y=;
 b=eNNFvdjaIQ8W6Tptxq1iQppkh0UmT3HoRAiNaoWtNV7LFkin7CQec/vEniPWrjYl47
 4c+IZhnOE0DybK78gg96fHq28ne/Jo/XcAxlIjlDtITLBATrHgsgNclvcvTN31lvt0GZ
 mdYDgJjYSuOZZhLM0O2WbKXuXCIbeGjZl/G3BAtZzNSFYyNIZFTo3kk9OjQNTjGd58yW
 YjuFZCYnvzfMmm9lvNxwgf5VkXUDf46wbGG8w0ta5SNdhuzJzNUK+K3OoUckr4C3/scY
 Vz5kTTzMqKcCFMywe27h9pDXhJyf4xS5I99qzdhJ1Klsnz9XGIa9uMKzWwLx7is8UKS1
 /+kQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZ0EI9SPS7G6FlKTnZAY270qlbEjEev/pduXvLRf6B6v5UoANbBDDaso5IEoIEsAyQxrX0Ekv/lw==@nongnu.org
X-Gm-Message-State: AOJu0YxKsonD8nr/hcxJLLFBcKe5Q7lyxYcbdw8JCdopmNsHiMyxreku
 StwgINgipvcamdn9ybK0nC01l+6imQHncUjsQr5P6f1v+M3ZwT19
X-Gm-Gg: ASbGncv0otfDYddZ5RmOprLC0VpZsBivo2kpOA6T5ieeONH5UfP9KEYDdgkfOmxeND4
 7g/m2hP2oj8plT677QG0BH5iXjIKbP3+wzHPO0wDA0Qvj67ZnBJ/9RoinGKxpI6H+B2+HaE0CFw
 MGByySM79u9CdLVFxQ2QZ0jqPmWxRG5gCRBIdThdV9euA9mtk7dGjPb6xC+co7xHd1e8LdU/8j8
 YFuS3U5s+pssvGlWJInWuUsKe9ObtvQ2E/vPpoHxIiZcVdiQ2y3yRRkFxLVOqA9lAXLGuQCMv9e
 YXT99G8mm6YrNy2QtyReDDnUcg9YdEguoL9K5LoVfN76PyRliHNBBER7U30PJEcl
X-Google-Smtp-Source: AGHT+IGaAzQudLBIuq5jptRhOFY2+QeIRpK/E3zB9dDkErAWYujVZoCBvKb+sbL/F3tjR8+XAQAMRA==
X-Received: by 2002:a05:6402:2189:b0:5dc:5860:6881 with SMTP id
 4fb4d7f45d1cf-5deaddb5921mr857954a12.19.1739317232460; 
 Tue, 11 Feb 2025 15:40:32 -0800 (PST)
Received: from [127.0.0.1] (dynamic-089-012-033-197.89.12.pool.telefonica.de.
 [89.12.33.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5de45a92fa7sm9513159a12.23.2025.02.11.15.40.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Feb 2025 15:40:31 -0800 (PST)
Date: Tue, 11 Feb 2025 23:40:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 04/18] hw/arm: Add i.MX 8M Plus EVK board
In-Reply-To: <CAFEAcA-7REe0uQsuptAxxSsd36c5MgPVzufqVcstJVqZmfAKDw@mail.gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
 <20250204092112.26957-5-shentey@gmail.com>
 <CAFEAcA8qgEDAnfaQDmpUjy77KZBiqwdKSmyLE-ZwEAhMNLWn4Q@mail.gmail.com>
 <831901E4-69B2-4637-8507-77C7BF4DA65D@gmail.com>
 <CAFEAcA-7REe0uQsuptAxxSsd36c5MgPVzufqVcstJVqZmfAKDw@mail.gmail.com>
Message-ID: <9777664F-E3FB-4C9E-B41B-2793625E799D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 11=2E Februar 2025 10:06:19 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Mon, 10 Feb 2025 at 22:44, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>>
>>
>> Am 10=2E Februar 2025 17:30:01 UTC schrieb Peter Maydell <peter=2Emayde=
ll@linaro=2Eorg>:
>> >On Tue, 4 Feb 2025 at 09:21, Bernhard Beschow <shentey@gmail=2Ecom> wr=
ote:
>> >>
>> >> As a first step, implement the bare minimum: CPUs, RAM, interrupt co=
ntroller,
>> >> serial=2E All other devices of the A53 memory map are represented as
>> >> TYPE_UNIMPLEMENTED_DEVICE, i=2Ee=2E the whole memory map is provided=
=2E This allows
>> >> for running Linux without it crashing due to invalid memory accesses=
=2E
>> >>
>> >> Signed-off-by: Bernhard Beschow <shentey@gmail=2Ecom>
>> >> ---
>> >
>> >
>> >
>> >> --- /dev/null
>> >> +++ b/docs/system/arm/imx8mp-evk=2Erst
>> >> @@ -0,0 +1,56 @@
>> >> +NXP i=2EMX 8M Plus Evaluation Kit (``imx8mp-evk``)
>> >> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>> >> +
>> >> +The QEMU i=2EMX 8M Plus EVK board emulation is intended to emulate =
a plain i=2EMX 8M
>> >> +Plus system on chip (SoC)=2E All peripherals the real board has suc=
h as flash and
>> >> +I2C devices are intended to be added via configuration, e=2Eg=2E co=
mmand line=2E
>> >
>> >Why do this? If they're on the real hardware board, we should
>> >be creating them by default in the machine model in QEMU=2E
>> >Command line options are for devices that are optional and
>> >pluggable by the user on the hardware=2E
>>
>> My goal is to be able to model a custom, proprietary machine which runs=
 in a CI=2E In order to avoid peripherals getting in the way, the idea is t=
o have a machine which essentially exposes the plain SoC, and allow users t=
o "decorate" it themselves=2E Is an EVK machine the wrong approach for this=
? Are there any other ways to achieve this, e=2Eg=2E with -nodefaults?
>
>That's not really a usage model QEMU currently supports=2E We generally
>speaking model what the actual hardware does=2E=20

Why not support such usage model? The machine in this series works amazing=
ly well for our purposes=2E If modeling a concrete board implies hardcoding=
 peripherals, would modeling an artificial "board" which just contains the =
SoC work instead? IOW should I drop the "-evk" suffix from the machine and =
claim it only models the SoC?

>In the same way,
>if you were running CI on the real EVK board your CI would have
>to deal with those devices being present=2E
>
>> >> +        /*
>> >> +         * Magic value from Linux output: "arch_timer: cp15 timer(s=
) running at
>> >> +         * 8=2E00MHz (phys)"=2E
>> >> +         */
>> >> +        object_property_set_int(OBJECT(&s->cpu[i]), "cntfrq", 80000=
00,
>> >> +                                &error_abort);
>> >
>> >This is the CNTFRQ value in Hz=2E The datasheet actually tells you
>> >this, so we don't need to call it a magic number (section 4=2E11=2E4=
=2E1=2E6=2E4
>> >of the i=2EMX 8M Plus Applications Processor Reference Manual says the
>> >base frequency of the system counter is 8MHz)=2E
>>
>> Ah, so then it's the "nxp,sysctr-timer"-compatible counter in
>> the device tree? I've stared my own implementation but didn't
>> see the relation to the cp15 timer=2E Thanks for clarifying this=2E
>
>Yeah; I haven't actually checked carefully whether there
>are NXP specifics here, as that device-tree compat string
>suggests=2E But it's almost certainly the same general principle:
>there's a memory-mapped system counter which is the global
>source of the system count, and each CPU consumes that count
>and uses it to feed its generic timers and counters=2E So if
>you mess with the enable on the memory mapped system counter
>then this causes the CPU's timers/counters to stop ticking=2E

Yeah, this also is how I understand the documentation of the system counte=
r in the reference manual=2E

>
>I modelled this similarly to the in-tree M-profile
>sse-counter and sse-timer, where you link the timer to
>the counter and there's an API that lets the timer know
>when the counter is enabled/disabled, changes frequency, etc=2E
>This needs changes to the timer and counter code in the CPU
>itself=2E (You can get away without doing this if you assume
>that the guest code never tries to actually disable the system
>counter or pick a non-default frequency, which is typically true:
>it will just want to set it up to a single standard config and
>then leave it alone=2E)

I have this implementation which puts the focus more on waking up the CPUs=
 via the IRQ: <https://github=2Ecom/shentok/qemu/commit/1aa0887a5ff926572ab=
40b39fe5a087acb3ff249> The IRQ fires but doesn't wake any CPU in case of di=
rect kernel boot since the IRQ is masked in EL1 (rich OS mode) and EL3 isn'=
t set up=2E

>
>> >(Incidentally the memory mapped system counter is a stock Arm
>> >IP block and I have about 60% of a model of it, I just haven't
>> >needed to upstream it yet because in practice no guest software
>> >really tries to mess with it=2E If we turn out to need it for
>> >this SoC that would be a reason for me to clean it up and
>> >send it out=2E But I suspect we don't need it in practice=2E)
>>
>> The ugly workaround for the cpu-idle-states above is actually related t=
o this counter, IIUC=2E I suppose that QEMU doesn't support these idle stat=
es, it only seems to support WFI=2E But if it did, then this counter would =
wake up the CPUs (if I'm not mistaken, I'm no expert here)=2E It would be n=
ice to be able to boot the machine via U-Boot, and I wonder if that could f=
ix the idle states when there are PSCI handlers in the secure world=2E Agai=
n, this probably also requires the counter implementation=2E Looking into U=
-Boot, TF-A, and OP-TEE is on my plan, but right now I'm focusing on direct=
 kernel boot=2E
>
>Hmm, if the system counter can generate interrupts then
>it might be different from the Arm IP block in that
>respect=2E I'd have to check the datasheet=2E Anyway, as
>you suggest this is all something we can postpone until
>we need to care about running EL3 firmware in the guest=2E

Yeah, this would probably work with U-Boot then=2E But for direct kernel b=
oot we'd need support beyond WFI directly in QEMU -- which is currently mis=
sing, right?

Best regards,
Bernhard

>
>thanks
>-- PMM

