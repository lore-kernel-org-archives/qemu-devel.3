Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06813CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EiF-0000uT-Lq; Thu, 02 Oct 2025 04:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4EiA-0000tc-3D
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:30:50 -0400
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v4Ehy-0003Kc-FA
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:30:47 -0400
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-74625f748a0so9090197b3.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759393827; x=1759998627; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=thJUyunQ1DRYZHJorhfZ5XxGZExCOn/F+KmYxfOiRK0=;
 b=Lg+RjRifI9eatLuDiObabkzM2EEWSjjAlxix0tsy3oNTQQLlQCYekMvsOShcKZ3Gcq
 qn9Kb7Ma9Pr0/5e8J9RpGW3eKZ9iVC5vS0KMtfdIkSfU9T/z00wCoRuksLLfip+lsZ/4
 VBzOVRCKGm8dR3QBadl9wDqCWilwhnboAnKo05GvxdTcbykqRq5/JjbMHDMY0ahSL3Hh
 5b71dCKpJrv2VTRjHPT/yl9meT0hL/3lEXcSaDm7I/mCPK5YARE6S17oGlOah43UiaK4
 ar9UaXYQ12XtCfP0at2hqs1rYeO7Xv+Kn58gk4xoHAtrO6H/s+bFRDKNiKhcy+iS0bn7
 n4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759393827; x=1759998627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=thJUyunQ1DRYZHJorhfZ5XxGZExCOn/F+KmYxfOiRK0=;
 b=Gh7k0Fhc+JmtMM7UBwtXFPJfdCJX++dYPdx7RJKOV7yRvoTLwExP1KBa7L90qRsp0C
 41SQYkv9NiWrPM/o8DK37e78gqQ0suyj9Cvl71k6giyK+Ka4gA0x6P4r186YK9PLsSbZ
 r4047gAHPCOT1MRRK+ny22xjGp702fTI1TqjTXg47Owkff4vcVaSeSug4z7Z84bQelpX
 FLqwywvyh4alF1lUxduQ30P1YH/yx/BSWLdHjVwEUefFADRVdewvIiVHqOWt5Z65FxlD
 7GMjio7BZm6cPE5ZJCaUsRw6BC6GACyY2XW6cntBoj1fOQQ2BOiNMo+XsGbv/E1PiAiz
 C4nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUzx2aGTVtBCQB4VgGUxzUAdEMr3CDFRREhtQIq1zPQFwrnQT2kE8EpJSoU3C/eAIJP9LVbNzWQH94q@nongnu.org
X-Gm-Message-State: AOJu0YxDaZVlzhf53ABWro4ChJ3wO4zDi15UUonCffR+wiSC2sA0xAhx
 GTWUL4OqmdrXNY4mH6lxqcOiGinKoN9dy9i+90wjw0uj3KWOUOSG0mhkBdIjESf7yLwu/oOtq9C
 HbtdV8SeQ4agee+I8KdyOoJsh+/v3rQWPqUmGVPpWig==
X-Gm-Gg: ASbGnctv7nCb/Vj4M1yA8o5Xu81iJgmIu+WFjs8g3aQlqBD0th9uiUVWUD58WhxjCkO
 9N7JlQWGw+dEezxLIHhijP6gnSotbA43juqzaUyNMHgvJDC9wwV13OimhKPAmGaKXadrjLPyfeH
 7HyF99qkD9du2TI7djofKG/E3lfr4crP7UxN66fiSxBFS2Nz3RdP3IxNTKnfj6w1620dti/UacN
 hJH8ZrpDEAMtKJZwnKAugB6YC0Hgho2Gate
X-Google-Smtp-Source: AGHT+IGo72mvg3XBwKIi6JWLiy9gBXhMpFUHDXEtKnDemqolAUv403Y/vZ1n/d6Wovfh+zt9OXD728Y3XnXT6zgADno=
X-Received: by 2002:a53:bf10:0:b0:635:2cdd:4ba9 with SMTP id
 956f58d0204a3-63b6ff7e83emr6501848d50.34.1759393827059; Thu, 02 Oct 2025
 01:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <1c567b4a-4966-4374-8851-81c9b1393d8a@linaro.org> <aN2fKu6wfPSQx05S@x1.local>
 <98ec5131-8468-4484-800d-36439c6b5ae9@linaro.org>
In-Reply-To: <98ec5131-8468-4484-800d-36439c6b5ae9@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Oct 2025 09:30:15 +0100
X-Gm-Features: AS18NWBmvu3-3LfJGe_EU-mXOt4ll0MGbb3LEKxPRKyrXt2gt2FUTDbI_2hWUsE
Message-ID: <CAFEAcA9HjmseQhxaMCLeuYvFwQeMgc506EEVeooQZ-VYOnbFHA@mail.gmail.com>
Subject: Re: [PATCH 0/3] system: Don't leak CPU AddressSpaces
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 1 Oct 2025 at 22:59, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/1/25 14:37, Peter Xu wrote:
> > I only have a very preliminary understanding on this, so please bare with
> > me if I'll make silly mistakes...
> >
> > I was expecting QEMU provides both the global view (address_space_memory),
> > and the per-vcpu view.
>
> My hypothesis is that separate views for each cpu doesn't make sense.
>
> In the true symmetric multiprocessor case, which is the vast majority of everything we
> emulate in QEMU, each processor has the exact same view(s).

This is not the case in general. Some CPUs have per-CPU
devices which show up only for that CPU. Examples include
the A9's per-CPU peripherals (which we don't currently model
that way, but perhaps ought to) and some stuff in one of the
M-profile boards.

TCG registers its CPU listener with every AS because
the information that TCG is caching that is stale is
something it cares about for every AS the CPU has to
deal with.

HVF and KVM register their CPU listener only with
address_space_memory because the information that those
accelerators are caching is the details of RAM layout in
the system, which in both cases the kernel imposes
the limitation of being the same for every CPU.
Similarly in target/arm's kvm_arm_register_device()
we listen on address_space_memory because the thing
we're listening for is "where has this device's
MemoryRegion been put", and again the kernel imposes
the requirement that the GIC (or whatever) is at the
same location for all CPUs.

The "global" view of address_space_memory and
system_memory is a bit theoretically dubious because
there's nothing saying all CPUs have to have some
underlying mostly-the-same view of things. But in
practice almost all systems do, plus KVM and HVF impose
that world-model, so it's easier to retain this than try
to think about how we would eliminate it.

> In the rare asymmetric multiprocessor case, of which we have a few, we have a couple of
> clusters and within each cluster all cpus share the exact same view(s).
>
> Thus access to address spaces on a per-cpu basis makes sense, but allocating them on a
> per-cpu basis does not.

Also, in general, per-CPU address spaces fits the rest of
how we model memory-transaction-capable devices. The
device (e.g. a DMA controller or similar) has a QOM
property which takes a pointer to a MemoryRegion describing
the view of the world that that device has; it then internally
creates an AddressSpace whose purpose is to provide the
APIs for making memory transactions into that MemoryRegion.

cpu_address_space_init() is just some convenience wrapping
around that.

thanks
-- PMM

