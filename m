Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1CDC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfdlz-0004JJ-RP; Thu, 29 Feb 2024 05:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rfdlx-0004Hs-Qt
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:36:17 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rfdlv-0000nQ-G6
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:36:17 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6ddf26eba3cso483582a34.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709202974; x=1709807774;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=werhXj+q+CY+aPjoduq/4UbLxgq/dfx2/xywUI7Y9WA=;
 b=zi0vse6H54lJ3/XT3XDArFkU9QDXDI5h5E+MWaVhiBQquANuAMgVGK8nHQeKNBvytJ
 /WU5di2rMaP8S0xt9NnRYyNyDcJ+qmo0CmVywOJsn9xGFnDpJXqEXg7NbnnBhDzBLT/b
 7LTQu4iaaG3/B7qXms2kKxAbVIDMV5ymzdeVItcO9loD2VqWAf5eiAObFRXetzOe7icA
 hqK/AHPPn5AIKGV/R22GercBhj+Ejp4KX1DG/Gs1p4VI95YHhb6rrJ76Kd7RTN5TiT3s
 z/mVij3lOkWmIkif5WRzhTyETcCBX4I35XruhbY7+w5qJLhsMDvL5ksP9+sIR9+E489Z
 Gq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709202974; x=1709807774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=werhXj+q+CY+aPjoduq/4UbLxgq/dfx2/xywUI7Y9WA=;
 b=hzI6/qASa0+PAGZ68CRKVuDqNdYwQD4fL3i44cL0HkTkts6Jz8NvoRLTs7L+stK8al
 gRKa5VoC1cup6BXNU+PcCprQKHjYmCatl4qrkDbZcFaM3SQiu7Hf3oVT3oUc3Zgo09qC
 v5k1S/cGlsF5W2IePX1Xz2DVxFh0+07NR6xwbBU+RhnGq/+Zoap/bdTxVFDYBJBMG5WZ
 Zt7qFB7kl3rmq0ooy2XcjWtWPiJYwPYICDu3qLxSFL3zk7FE0EQwLdUARZ3W1mAlnpHm
 AmUcPXxcJoBGZT6Gam4g4M8JaNfP6b3Amq2ULNRDWGyACZ5/jBP8Zja/j5Y2PKDV/wMm
 r3Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJQxVS4Hserzv99EHIyRmcJNrXtq9MkV8exiEANRzsU0A+hR0seCRAjmz13VcBVaLm/y9x+1xiqYYMgeCGAy2i2W0VbyQ=
X-Gm-Message-State: AOJu0Yx5TzLMBUmPiLsJF4PxoOCO+8wX6NZDASjCiZEOd5JMA72LP8eL
 GbbvcEhq9CO+wY5E7SWMALpSjNx8dtwG9h46qOJWwCrZL2eCxD7afiuFNbT1UVoKvxb7qGeIja2
 cC/Pa8wiu8kxVXnpTPstAwBwzSjU0qczAb990GA==
X-Google-Smtp-Source: AGHT+IH28XGLrKTvZwzzWKhaJHJpCecMQcB96taW/729JJ2mub246CtaVEGEM4j63fRy2WrhO/xzJO/+HrYNGGXYjfY=
X-Received: by 2002:a05:6870:b61d:b0:220:8c16:fe1b with SMTP id
 cm29-20020a056870b61d00b002208c16fe1bmr1731201oab.40.1709202973837; Thu, 29
 Feb 2024 02:36:13 -0800 (PST)
MIME-Version: 1.0
References: <20240228125939.56925-1-heinrich.schuchardt@canonical.com>
 <fb6ef90d-4a3e-4bdd-8516-8b15c1f2329f@linaro.org>
 <b9937680-8c0b-46f6-86ef-55139562e2c4@canonical.com>
 <CAFEAcA_Bshua2BQTfOb3D1aF27ayELEt9TcQM8hkQdKaih3xHw@mail.gmail.com>
 <9c64be5c-25b8-421d-966a-bdac03dfe37c@canonical.com> <Zd_Z2f-5_l3rXNbp@x1n>
 <2a07005c-6465-47da-ae89-dd6151e8ed74@canonical.com>
In-Reply-To: <2a07005c-6465-47da-ae89-dd6151e8ed74@canonical.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Thu, 29 Feb 2024 11:36:02 +0100
Message-ID: <CAGNS4TaYD8mZYCOiW0423BrHsuaBsEAQKE33UjHa_ku=MUH4pg@mail.gmail.com>
Subject: Re: [PATCH, v2] physmem: avoid bounce buffer too small
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=mnissler@rivosinc.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 11:22=E2=80=AFAM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 29.02.24 02:11, Peter Xu wrote:
> > On Wed, Feb 28, 2024 at 08:07:47PM +0100, Heinrich Schuchardt wrote:
> >> On 28.02.24 19:39, Peter Maydell wrote:
> >>> On Wed, 28 Feb 2024 at 18:28, Heinrich Schuchardt
> >>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>
> >>>> On 28.02.24 16:06, Philippe Mathieu-Daud=C3=A9 wrote:
> >>>>> Hi Heinrich,
> >>>>>
> >>>>> On 28/2/24 13:59, Heinrich Schuchardt wrote:
> >>>>>> virtqueue_map_desc() is called with values of sz exceeding that ma=
y
> >>>>>> exceed
> >>>>>> TARGET_PAGE_SIZE. sz =3D 0x2800 has been observed.
> >
> > Pure (and can also be stupid) question: why virtqueue_map_desc() would =
map
> > to !direct mem?  Shouldn't those buffers normally allocated from guest =
RAM?
> >
> >>>>>>
> >>>>>> We only support a single bounce buffer. We have to avoid
> >>>>>> virtqueue_map_desc() calling address_space_map() multiple times.
> >>>>>> Otherwise
> >>>>>> we see an error
> >>>>>>
> >>>>>>        qemu: virtio: bogus descriptor or out of resources
> >>>>>>
> >>>>>> Increase the minimum size of the bounce buffer to 0x10000 which ma=
tches
> >>>>>> the largest value of TARGET_PAGE_SIZE for all architectures.
> >>>>>>
> >>>>>> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.=
com>
> >>>>>> ---
> >>>>>> v2:
> >>>>>>       remove unrelated change
> >>>>>> ---
> >>>>>>     system/physmem.c | 8 ++++++--
> >>>>>>     1 file changed, 6 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/system/physmem.c b/system/physmem.c
> >>>>>> index e3ebc19eef..3c82da1c86 100644
> >>>>>> --- a/system/physmem.c
> >>>>>> +++ b/system/physmem.c
> >>>>>> @@ -3151,8 +3151,12 @@ void *address_space_map(AddressSpace *as,
> >>>>>>                 *plen =3D 0;
> >>>>>>                 return NULL;
> >>>>>>             }
> >>>>>> -        /* Avoid unbounded allocations */
> >>>>>> -        l =3D MIN(l, TARGET_PAGE_SIZE);
> >>>>>> +        /*
> >>>>>> +         * There is only one bounce buffer. The largest occuring
> >>>>>> value of
> >>>>>> +         * parameter sz of virtqueue_map_desc() must fit into the=
 bounce
> >>>>>> +         * buffer.
> >>>>>> +         */
> >>>>>> +        l =3D MIN(l, 0x10000);
> >>>>>
> >>>>> Please define this magic value. Maybe ANY_TARGET_PAGE_SIZE or
> >>>>> TARGETS_BIGGEST_PAGE_SIZE?
> >>>>>
> >>>>> Then along:
> >>>>>      QEMU_BUILD_BUG_ON(TARGET_PAGE_SIZE <=3D TARGETS_BIGGEST_PAGE_S=
IZE);
> >>>>
> >>>> Thank you Philippe for reviewing.
> >>>>
> >>>> TARGETS_BIGGEST_PAGE_SIZE does not fit as the value is not driven by=
 the
> >>>> page size.
> >>>> How about MIN_BOUNCE_BUFFER_SIZE?
> >>>> Is include/exec/memory.h the right include for the constant?
> >>>>
> >>>> I don't think that TARGET_PAGE_SIZE has any relevance for setting th=
e
> >>>> bounce buffer size. I only mentioned it to say that we are not
> >>>> decreasing the value on any existing architecture.
> >>>>
> >>>> I don't know why TARGET_PAGE_SIZE ever got into this piece of code.
> >>>> e3127ae0cdcd ("exec: reorganize address_space_map") does not provide=
 a
> >>>> reason for this choice. Maybe Paolo remembers.
> >>>
> >>> The limitation to a page dates back to commit 6d16c2f88f2a in 2009,
> >>> which was the first implementation of this function. I don't think
> >>> there's a particular reason for that value beyond that it was
> >>> probably a convenient value that was assumed to be likely "big enough=
".
> >>>
> >>> I think the idea with this bounce-buffer has always been that this
> >>> isn't really a code path we expected to end up in very often --
> >>> it's supposed to be for when devices are doing DMA, which they
> >>> will typically be doing to memory (backed by host RAM), not
> >>> devices (backed by MMIO and needing a bounce buffer). So the
> >>> whole mechanism is a bit "last fallback to stop things breaking
> >>> entirely".
> >>>
> >>> The address_space_map() API says that it's allowed to return
> >>> a subset of the range you ask for, so if the virtio code doesn't
> >>> cope with the minimum being set to TARGET_PAGE_SIZE then either
> >>> we need to fix that virtio code or we need to change the API
> >>> of this function. (But I think you will also get a reduced
> >>> range if you try to use it across a boundary between normal
> >>> host-memory-backed RAM and a device MemoryRegion.)
> >>
> >> If we allow a bounce buffer only to be used once (via the in_use flag)=
, why
> >> do we allow only a single bounce buffer?
> >>
> >> Could address_space_map() allocate a new bounce buffer on every call a=
nd
> >> address_space_unmap() deallocate it?
> >>
> >> Isn't the design with a single bounce buffer bound to fail with a
> >> multi-threaded client as collision can be expected?
> >
> > See:
> >
> > https://lore.kernel.org/r/20240212080617.2559498-1-mnissler@rivosinc.co=
m
> >
> > For some reason that series didn't land, but it seems to be helpful in =
this
> > case too if e.g. there can be multiple of such devices.
> >
> > Thanks,
> >
>
> Hello Peter Xu,
>
> thanks for pointing to your series. What I like about it is that it
> removes the limit of a single bounce buffer per AddressSpace.
>
> Unfortunately it does not solve my problem. You limit the sum of all of
> the allocations for a single AddressSpcace to
> DEFAULT_MAX_BOUNCE_BUFFER_SIZE =3D 4096 which is too small for my use cas=
e.

Note that the limit is configured for address spaces attached to PCI
devices with a parameter.

>
> Why do we need a limit?

The rationale is to prevent a guest from allocating unlimited amounts
of host memory.

> Why is it so tiny?

Nobody has come up with a good way to determine a "sufficient" amount
that works with all use cases, while at the same time addressing the
concern due to malicious guest behavior mentioned above.

(Note that I'm merely reciting previous conversations as the author of
the series Peter pointed you at)

>
> Best regards
>
> Heinrich
>
>
>

