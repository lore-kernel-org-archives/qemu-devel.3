Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85F3C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA7nL-0006Iw-Is; Wed, 30 Apr 2025 09:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA7nC-0006I3-Kp
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 09:48:09 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA7n9-00022P-NU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 09:48:05 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5f4d0da2d2cso14039702a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 06:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746020881; x=1746625681; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUanpi+IO67CEwwAWV02qXOKd8zQd6SOLd8I4vZBU7c=;
 b=ZNBYS4HgyCN1lDZPunmDjFwSZhFsKJOgsmLh67bcgOtdqREywIrg8Y2y35SL/66jwd
 pOWL8GwVpJS0HtAT3OUU9PxZRYsaKdGuq14LpOe0lJmpbl0nLYqqH4SDD59iptqDTHBz
 Ef/91dKdIO/aqK/QcQu+tBF3iQHRzDeEQ67RIaW4T1Nw3GSM13/Tvb5dxTxmfdxINLOv
 z5VFgiJAE8JDtv/+QOsfheLt8LZlQx93vbfi9ZJJVqCdXvXBd0eLCZ40Tiu9df8HA3ZD
 eTEohq1WmOS64yx8J4zu6nLkHmbJ4hYxZOLFHOeA498FMalGP3ODRrkWkIuahPonNVDV
 gDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746020881; x=1746625681;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vUanpi+IO67CEwwAWV02qXOKd8zQd6SOLd8I4vZBU7c=;
 b=YXGzXt9K9/yX1VnMiH53viiJtQ/WmVMxyDRDHH2BC4/UcmBiwD8O3/GJV2/EpSZYwU
 Rf1VVIyhvUjauw4VkHt2TRYDkPDfbg5wI+n0RsjApRTZgB///81TcEOiRiJa6mY/goBv
 80eLlNw/Xc8VztIN5OU6VXUts3Ic5ffl5ulLYjCCX24RCYZPRzFKi5u67nL73knOELz7
 a6tCLdQusxf8zBSUTKMikFd1LhrNF4vgaReBbu8g8s29csQqq3V+A+NIy7vreoHH3JGT
 j32kdwXTl0BBrn2hiGPIOjtRVErkHMIy3Tlv/UNtUjwHd51jPY3jFsJg6RoOIKOMhd9K
 OPMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCViXdLWoou9XfDexQlOWEGGJAxOXXyGguQ0A9pBa0gUJ0X16qZGjFlJCH40ZI2t93Erncw9CLbEXlrF@nongnu.org
X-Gm-Message-State: AOJu0YzPfd8AicNcbMwYqRoSfs/70Cp487N2qBP1+xSEgpYMcrgdefEG
 P9AW/FnqsuKgJt//W0mfxMOXmSp+H4N+nIR5Jm0QTfuLgwBXVCBVlkynKIriXBI=
X-Gm-Gg: ASbGncsGCoWhiLjOrmRxjlwzPw9OGTVEDSErk6LZpddt0j4eEVxeRL8xtDvqtVo+dG1
 ZLJtYTwliEYdkstgLowaZOb/DRUotx5GhKO2k8Fo+OPPw6Xr9zZG8QM0glhZ8PBgN6xelvy1iB7
 cCKjqIBn7RF4C/kKJwWZJR3ycnWy02lVC9N+yFivdKER8olkCXNywDznUZQ9Ov1mJ+cWHJVsTgC
 Hrt8X9peYHLhwoNyrZdiyNqltYxKrSM/bvYBPNq0RZuDwjgXVQ5OEsWI8joF+igKYCg9u4FCNFN
 cKarDbOaiQdnf9K31EUUBVxkAgetKBw6pT9nTVZLcD8=
X-Google-Smtp-Source: AGHT+IEBcY3HakrLlrORicGJ+HgDsFI1mRfI9VfE6qPAChOVGu9GXbOzuTYO8sFSLE8NAMM1TPAd3A==
X-Received: by 2002:a05:6402:1ec8:b0:5ec:958b:6f5a with SMTP id
 4fb4d7f45d1cf-5f8af0bcb49mr2556957a12.28.1746020881212; 
 Wed, 30 Apr 2025 06:48:01 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f7016f6a82sm9169926a12.48.2025.04.30.06.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 06:48:00 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E81535F8BB;
 Wed, 30 Apr 2025 14:47:59 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Nicholas Piggin <npiggin@gmail.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <0386a2ee-e2c3-a1df-f867-c8fcaf9689a4@eik.bme.hu> (BALATON
 Zoltan's message of "Wed, 30 Apr 2025 13:20:20 +0200 (CEST)")
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <ded56ee3-25bb-4ffd-98e4-2f47c500c88d@linaro.org>
 <164d86d5-f17a-1f89-d973-c3e56255195d@eik.bme.hu>
 <875xin3qeh.fsf@draig.linaro.org>
 <4f7cbb13-2c7c-1d3e-9d41-49ec16bee245@eik.bme.hu>
 <87zffy3l4g.fsf@draig.linaro.org>
 <aec151d9-fae2-4bbc-c690-2b68f5906664@eik.bme.hu>
 <D9JJWC1IWEEB.1IA8DSZF98YT4@gmail.com>
 <0386a2ee-e2c3-a1df-f867-c8fcaf9689a4@eik.bme.hu>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 30 Apr 2025 14:47:59 +0100
Message-ID: <871pt93gmo.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Wed, 30 Apr 2025, Nicholas Piggin wrote:
>> On Wed Apr 30, 2025 at 7:09 AM AEST, BALATON Zoltan wrote:
>>> On Tue, 29 Apr 2025, Alex Benn=C3=A9e wrote:
>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>> On Tue, 29 Apr 2025, Alex Benn=C3=A9e wrote:
>>>>>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>>>>>> On Mon, 28 Apr 2025, Richard Henderson wrote:
>>>>>>>> On 4/28/25 06:26, BALATON Zoltan wrote:
<snip>
>>>>
>>>> if we've been here before (needing n insn from the base addr) we will
>>>> have a cached translation we can re-use. It doesn't stop the longer TB
>>>> being called again as we re-enter a loop.
>>>
>>> So then maybe it should at least check if there's already a cached TB
>>> where it can continue before calling cpu_io_recompile in io_prepare and
>>> only recompile if needed?
>>
>> It basically does do that AFAIKS. cpu_io_recompile() name is misleading
>> it does not cause a recompile, it just updates cflags and exits. Next
>> entry will look up TB that has just 1 insn and enter that.
>
> After reading it I came to the same conclusion but then I don't
> understand what causes the problem. Is it just that it will exit the
> loop for every IO to look up the recompiled TB? It looks like it tries
> to chain TBs, why does that not work here?

Any MMIO access has to come via the slow path. Any MMIO also currently
has to be the last instruction in a block in case the operation triggers
a change in the translation regime that needs to be picked up by the
next instruction you execute.

This is a pathological case when modelling VRAM on a device because its
going to be slow either way. At least if you model the multiple byte
access with a helper you can amortise some of the cost of the MMU lookup
with a single probe_() call.=20

>>> I was thinking maybe we need a flag or counter
>>> to see if cpu_io_recompile is called more than once and after a limit
>>> invalidate the TB and create two new ones the first ending at the I/O a=
nd
>>> then what cpu_io_recompile does now which as I understood was what Rich=
ard
>>> suggested but I don't know how to do that.
>>
>> memset/cpy routines had kind of the same problem with real hardware.
>> They wanted to use vector instructions for best performance, but when
>> those are used on MMIO they would trap and be very slow.
>
> Why do those trap on MMIO on real machine? These routines were tested
> on real machines and the reasoning to use the widest possible access
> was that PCI transfer has overhead and that is minimised by
> transferring more bits in one op. I think they also verifed that it
> works at least for the 32 bit CPUs up to G4 that were used on real
> AmigaNG machines. There are some benchmark results here:
> https://hdrlab.org.nz/benchmark/gfxbench2d/OS/AmigaOS?start=3D60 which
> is also where the benchmark I used comes from so this should be
> similar. I think the MemCopy on that page has plain unoptimised copy
> as Copy to/from VRAM and optimised routines similar to this benchmark
> as Read/Write Pixel Array, but it's not easy to search. Some of the
> machines like Pegasos II and AmigaOne XE were made with both G3 or G4
> CPUs so if I find a result from those with same graphics card that
> could show if AltiVec is faster (although the G4s were also higher
> clock so not directly comparable). Some results there are also from
> QEMU, mostly those that are with SiliconMotion 502 but that does not
> have this problem only vfio-pci pass through.

They don't - what we need is to have a RAM-like-device model for QEMU
where we can relax the translation rules because we know we are writing
to RAM like things that don't have registers or other state changing
behaviour.

The poor behaviour is because QEMU currently treats all MMIO as
potentially system state altering where as for VRAM it doesn't need to.

> So maybe it's something
> with how vfio-pci maps PCI memory BARs?

I don't know about vfio-pci but blob resources mapped via virtio-gpu
just appear as chunks of RAM to the guest - hence no trapping.

>
>> Problem is we don't know ahead of time if some routine will access
>> MMIO or not. You could recompile it with fewer instructions but then
>> it will be slow when used for regular memory.
>>
>> Heuristics are tough because you could have e.g., one initial big
>> memset to clear a MMIO region that iterates many times over inner
>> loop of dcbz instructions, but then is never used again for MMIO but
>> important for regular page clearing. Making something that dynamically
>> decays or periodically would recompile to non-IO case perhaps, but
>> then complexity goes up.

We can't have heuristics when we must prioritise correctness. However we
could expand the device model to make the exact behaviour of different
devices clear and optimise when we know it is safe.=20

>> I would prefer not like to do that just for a microbenchmark, but if
>> you think it is reasonable overall win for average workloads of your
>> users then perhaps.
>
> I'm still trying to understand what to optimise. So far it looks like
> that dcbz has the least impact, then vperm a bit bigger but still only
> about a few percent and the biggest impact is still not known for sure
> but we see faster access on real machines that run on slower PCIe
> (only 4x at best) while CPU benchmarks don't show slower performance
> on QEMU only accessing passed through card's VRAM is slower than
> expected. But if there's a trap involved I've found before that
> exceptions are slower with QEMU but I did not see evidence of that in
> the profile.
>
> Regards,
> BALATON Zoltan

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

