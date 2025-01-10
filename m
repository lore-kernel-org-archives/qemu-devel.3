Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1998EE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 15:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHDe-0003Pv-92; Fri, 10 Jan 2025 10:46:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHCA-0002Rk-LQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:45:12 -0500
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tWHC6-0008GT-Hp
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 10:45:09 -0500
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e3fd6cd9ef7so5564071276.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 07:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736523903; x=1737128703; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=511Z+41OEUqcFab25iPvQUjyLzAT2pDdqxvoPH5a6BI=;
 b=lSxSfLIgUzoKYSsyktvFoXg+mJRmvDnCxb/RngJt/z7Xoi7Y5eK3IJQIVeQFvPLocp
 iayfDEIcfv2SOiF4/+cyAhIeLdxRQXy9fjF2Z+6Ttqzy6nLd6wOduB5zPqZp/c9BoIdv
 ZdUgjXiRGePyA5oXL7niEAqEJ6nUmeKGz44/f7fiE/h2UBvUF1/QV1OKEzEdX7IirbI7
 b57DSZUBCvf2m1x5PMjSU0ovdPmDzsof19vtbo8eUDJyBcznG7kzkmS1YVZZb2rsXfYi
 f1vynIDXAfalBilLFhdpuV3IXZ/zL4z6VkJng7DBytyt3ajXfGrf4p+l9uZOgXidnFRS
 /0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736523903; x=1737128703;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=511Z+41OEUqcFab25iPvQUjyLzAT2pDdqxvoPH5a6BI=;
 b=YN7cY2nNl48gJ1qy1qqClE7Dfox9lNiIZWaTrLGQ2ZFrpV7U8NVQiHEfTfGv0a2wta
 G6jfBKn+zlA72d8AeI/DeVfOOPL4G2c6JNr3FIppDxYv4kl23LuZryOwwXgpXqCVLHEh
 U3+9HIi9Me2gm/Yh+uiAinBAujKrJqRKaTXRpV/AFiw+sVADuHxgctKe7Sh/OSAdDnKA
 yA0zhhVqflCEsIiucANvFJXpJye98ZyuRsXC/Xhj1TYPZiXswH8jRdg1GRb18wT120B4
 +03aoWpXKgxSnFWNducKAiUevl/4bkE4Y8u6ntPPPGln8PmJjr8mcB5ZLiLuToBgoPWb
 rnZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuETPpVG1foVVeb2L4GLbOu323fKhF4epKRu6VmdgD+qbrenjF1/STDeFF22N6TyAICnogWqhntvFt@nongnu.org
X-Gm-Message-State: AOJu0YxTUBBO/7lzFD/gRNjRdLLScooeZvFneENDUdGlmVOI1UE4B9jT
 lmX5HljwMBnI91EPEQ8yTDuPqpkwdnzNKI6VWz84RG81R7KV8JQzo96+D3oDKFuDpOKZPeGkD3x
 zfvgNJ/hpAHsinA+2aHLdtKqhk7bCz+5v/8K3kA==
X-Gm-Gg: ASbGncv6I22LpbkYsah+ildMhCSzuU/5YSmYACwzMye63EP1E99OCPJaf+jR6Gr9xLi
 IX6jsg/yhbkYcozLWpVOH/nYyAIHKMPBlB0iktd4=
X-Google-Smtp-Source: AGHT+IHSDTFhnf4Fk9iHV+3pKr6XgWBSk7LJ2bfmoWDJXoDC+L58j4PvU5S4vs+ZFbl7oScvbVbnQ0z5jqpHns26+Es=
X-Received: by 2002:a05:690c:b84:b0:6ee:8515:6730 with SMTP id
 00721157ae682-6f54964144dmr45818637b3.17.1736523902793; Fri, 10 Jan 2025
 07:45:02 -0800 (PST)
MIME-Version: 1.0
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
 <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
 <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
 <4aa676ea-331f-4c8b-be1d-208804ede674@redhat.com>
In-Reply-To: <4aa676ea-331f-4c8b-be1d-208804ede674@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jan 2025 15:44:51 +0000
X-Gm-Features: AbW1kvaFO2kQbhhpny1eFTGF5HNEKuFN9q3NizdO_i62XwvmUUNMZ0tBUXTDqaY
Message-ID: <CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com>
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
To: David Hildenbrand <david@redhat.com>
Cc: Stefan Zabka <git@zabka.it>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 8 Jan 2025 at 20:10, David Hildenbrand <david@redhat.com> wrote:
>
> On 08.01.25 19:35, Stefan Zabka wrote:
> > On 21/12/2024 15:55, David Hildenbrand wrote:
> >   > Let's wait for opinions from others first.
> >
> > <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-your-patch-seems-to-have-been-ignored>
> > states that two weeks is a reasonable amount of time for follow-up.
> >
> > Should I also ping the original patch? I thought pinging the thread
> > would be more appropriate, as it contains relevant information.
> >
>
> I just pushed a compiling version of the attrs.debug approach to:
>
>         https://github.com/davidhildenbrand/qemu/tree/debug_access

I think this approach (having a 'debug' attribute in the MemTxAttrs
seems reasonable. I do note that if we allow this kind of access
to write to MMIO devices then we are also permitting ELF (and other)
image loads to write to MMIO devices where currently we ignore those.
That means there's probably a class of guest images (of dubious
correctness) which will start writing junk (likely zeroes) into
device model registers; we previously would silently ignore any
such bogus ELF sections.

Q: should we suggest behaviour for device models if they see a
'debug = 1' transaction, e.g. "don't update your internal state
for a debug read if you have clear-on-read or similar kinds of
register fields" ?

> With two preparation patches, the relevant patch is:
>
>
>  From 2e85cb1724385e4b8640364415832c030e5c5e6d Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Wed, 8 Jan 2025 20:58:00 +0100
> Subject: [PATCH] physmem: allow cpu_memory_rw_debug to write to MMIO devices
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/core/cpu-sysemu.c    | 13 +++++++++----
>   include/exec/memattrs.h |  5 ++++-
>   include/exec/memory.h   |  2 ++
>   system/physmem.c        |  9 ++-------
>   4 files changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
> index 2a9a2a4eb5..0aa0a569e4 100644
> --- a/hw/core/cpu-sysemu.c
> +++ b/hw/core/cpu-sysemu.c
> @@ -51,13 +51,18 @@ hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
>                                        MemTxAttrs *attrs)
>   {
>       CPUClass *cc = CPU_GET_CLASS(cpu);
> +    hwaddr paddr;
>
>       if (cc->sysemu_ops->get_phys_page_attrs_debug) {
> -        return cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
> +        paddr = cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
> +    } else {
> +        /* Fallback for CPUs which don't implement the _attrs_ hook */
> +        *attrs = MEMTXATTRS_UNSPECIFIED;
> +        paddr = cc->sysemu_ops->get_phys_page_debug(cpu, addr);
>       }
> -    /* Fallback for CPUs which don't implement the _attrs_ hook */
> -    *attrs = MEMTXATTRS_UNSPECIFIED;
> -    return cc->sysemu_ops->get_phys_page_debug(cpu, addr);
> +    /* Indicate that this is a debug access. */
> +    attrs->debug = 1;
> +    return paddr;
>   }
>
>   hwaddr cpu_get_phys_page_debug(CPUState *cpu, vaddr addr)
> diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
> index e27c18f3dc..14e0edaa58 100644
> --- a/include/exec/memattrs.h
> +++ b/include/exec/memattrs.h
> @@ -26,7 +26,8 @@ typedef struct MemTxAttrs {
>       /* Bus masters which don't specify any attributes will get this
>        * (via the MEMTXATTRS_UNSPECIFIED constant), so that we can
>        * distinguish "all attributes deliberately clear" from
> -     * "didn't specify" if necessary.
> +     * "didn't specify" if necessary. "debug" can be set alongside
> +     * "unspecified".
>        */

This feels like one of those changes which is "*probably* OK,
but breaks a thing that was previously an invariant" ones.
But trying to get all targets to support reporting real
attributes is probably too long a side-quest (we can't really
do it in cpu_get_phys_page_attrs_debug() because I don't think
we have a pre-existing way to ask the target "are you in usermode
now"; the rest of the fields we could validly leave 0).

>       unsigned int unspecified:1;
>       /*
> @@ -50,6 +51,8 @@ typedef struct MemTxAttrs {
>        * (see MEMTX_ACCESS_ERROR).
>        */
>       unsigned int memory:1;
> +    /* Debug access that can even write to ROM. */
> +    unsigned int debug:1;
>       /* Requester ID (for MSI for example) */
>       unsigned int requester_id:16;
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 3dcadcf3a2..7458082455 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2990,6 +2990,8 @@ static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
>                                              MemTxAttrs attrs)
>   {
>       if (is_write) {
> +        if (attrs.debug)
> +            return memory_region_is_ram(mr) || memory_region_is_romd(mr);

It's a bit weird that the condition for "debug access can write"
is not the same as the one for "debug access can read"...

>           return memory_region_is_ram(mr) && !mr->readonly &&
>                  !mr->rom_device && !memory_region_is_ram_device(mr);
>       } else {

-- PMM

