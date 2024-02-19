Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82799C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 07:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbyUy-0000MJ-7p; Mon, 19 Feb 2024 02:55:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rbyUq-0000II-LE
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 02:55:30 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rbyUl-0004bA-6A
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 02:55:26 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3c031c24fbeso3273969b6e.3
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 23:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708329320; x=1708934120;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RA3Q+FlfFK5TkfQRygaWvCNYHsvJE2ya7hxRDH59qDk=;
 b=A+Hi2BLYyGw2Wac1y+pT9s8q60AQebdF1uJg/J0yuxCu+gqlCnXzzxeC+x9wRI4ydg
 OAVXxtl9QewX/b9gSX63c4w24xFqcrWDrz1qzBEdMVOULJNeKw6eniLDj0wzqpbWBWbJ
 ME/NBL9TrEEpM7KP29tkh94Sb8OWQfAuCv1YnIggSupZJEs+mhkSPx3YTo7atXsPIrfS
 JBzNx2fAGqI7ZKHLkakxQCtUySE5C0xVAgHwEjHngW7EHDVpI1C5RBz4YZWET/BBsLn/
 2uWMy+Ps8hIvmgcx7A6wt/prqy5LyUQoxgc0GGGZ+fPeyszRvUaDMRqysfsnZ4e8mYvX
 p80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708329320; x=1708934120;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RA3Q+FlfFK5TkfQRygaWvCNYHsvJE2ya7hxRDH59qDk=;
 b=HgTFfcPQkJesqeDw63ENN8K3FuTnFUHX1M2Mn+sDtIt9+xwOy3wd5jvwHkp369NBMY
 yusul4Ec0GRoziQN4QDx1e9ImfCuvVs9Y/XwDcy8w9IJEWf19RZsB5V3RS6bbxu+nrP6
 J5y5KbjFl/5p1IN6z62rOT0lj7Set2OGwZfjMwIHGfWV9AgAwRNs0cV4jxWorJ5f43oy
 hMCMJ6j7IdiR7AoGXIEfSuakJIqgYxGjiWtevOkLOnbS688nZGId3BoOHqwfZDQAGN3d
 gmWcZCycmqY+aDFjARp4Xrirs2Oz7jQkAGGZjgtnu1qtzvIt0qFpKquSoAWGHbJde02y
 Piuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVapfP82FX7pKHKD6m71KUt1jlEOYuHsGm25bS8lSYfTliOEbXcecUJubcFM0BR8YoZOKasS6mZSnmiNoATVqINYywJAoM=
X-Gm-Message-State: AOJu0YyRmllGkneO9R35KCPdo/S2P5nfpAVURlUY4qRJfbBiCt3J0tzz
 gRjiuGCWNh5BwoLmjmexDGKH2X5ZeVBxNsyWHpGxPkMIPNOZhVfbl2HQwAf/BH8DY5oB6e6lYYT
 YkNlpTgNHCz2cKAuFuvy1l9/UAbBMKa65PEY9+g==
X-Google-Smtp-Source: AGHT+IFUWZCCtVlKBUjOjGHiRIdSJmAE2JNq/HmXT2u0ciBnNr8IqI4yeHLfRvZJWb0z4rLJK0ZrcWyc3qVMNJ+5wT4=
X-Received: by 2002:a05:6870:1611:b0:21e:c0cd:a4ff with SMTP id
 b17-20020a056870161100b0021ec0cda4ffmr2230265oae.27.1708329320523; Sun, 18
 Feb 2024 23:55:20 -0800 (PST)
MIME-Version: 1.0
References: <87msskkyce.fsf@draig.linaro.org>
 <CAFEAcA_a_AyQ=Epz3_+CheAT8Crsk9mOu894wbNW_FywamkZiw@mail.gmail.com>
 <20240201162150.000022cf@huawei.com> <87h6iskuad.fsf@draig.linaro.org>
 <20240201170822.00005bad@Huawei.com> <87r0hwjdvl.fsf@draig.linaro.org>
 <CAFEAcA_xDH=rZzXnjNMQTKGJ+-E4Q=A_bEtKLgYYx6x04h0Jkw@mail.gmail.com>
 <ZbvpSaOXzZkqDd6c@memverge.com> <20240202162633.0000453c@huawei.com>
 <CAFEAcA-32--EmbzewL8WfAPanoWQ-eRpkjKuDLc5uV04wpOCpw@mail.gmail.com>
 <Zb0dXy72lyglchJa@memverge.com>
 <CAFEAcA9KG9mF2KRS_Z2XdfD6b-aaNssZ7HCL_JKymyRkCJMq0A@mail.gmail.com>
 <20240207173415.00000125@huawei.com> <20240208145042.0000065f@huawei.com>
 <20240215152929.00007e8d@huawei.com>
In-Reply-To: <20240215152929.00007e8d@huawei.com>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Mon, 19 Feb 2024 08:55:09 +0100
Message-ID: <CAGNS4TbtwndNvZPsto3rzrkqjmR5pC8_2hjx_pewStUbipV--w@mail.gmail.com>
Subject: Re: Crash with CXL + TCG on 8.2: Was Re: qemu cxl memory expander
 shows numa_node -1
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, linuxarm@huawei.com, 
 Dimitrios Palyvos <dimitrios.palyvos@zptcorp.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org, Gregory Price <gregory.price@memverge.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Sajjan Rao <sajjanr@gmail.com>, richard.henderson@linaro.org, mst@redhat.com, 
 david@redhat.com
Content-Type: multipart/alternative; boundary="0000000000004f3bd50611b76af9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=mnissler@rivosinc.com; helo=mail-oi1-x22b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--0000000000004f3bd50611b76af9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 4:29=E2=80=AFPM Jonathan Cameron <
Jonathan.Cameron@huawei.com> wrote:

> On Thu, 8 Feb 2024 14:50:59 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>
> > On Wed, 7 Feb 2024 17:34:15 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> >
> > > On Fri, 2 Feb 2024 16:56:18 +0000
> > > Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > > On Fri, 2 Feb 2024 at 16:50, Gregory Price <
> gregory.price@memverge.com> wrote:
> > > > >
> > > > > On Fri, Feb 02, 2024 at 04:33:20PM +0000, Peter Maydell wrote:
>
> > > > > > Here we are trying to take an interrupt. This isn't related to
> the
> > > > > > other can_do_io stuff, it's happening because do_ld_mmio_beN
> assumes
> > > > > > it's called with the BQL not held, but in fact there are some
> > > > > > situations where we call into the memory subsystem and we do
> > > > > > already have the BQL.
> > > >
> > > > > It's bugs all the way down as usual!
> > > > > https://xkcd.com/1416/
> > > > >
> > > > > I'll dig in a little next week to see if there's an easy fix. We
> can see
> > > > > the return address is already 0 going into mmu_translate, so it
> does
> > > > > look unrelated to the patch I threw out - but probably still has
> to do
> > > > > with things being on IO.
> > > >
> > > > Yes, the low level memory accessors only need to take the BQL if th=
e
> thing
> > > > being accessed is an MMIO device. Probably what is wanted is for
> those
> > > > functions to do "take the lock if we don't already have it",
> something
> > > > like hw/core/cpu-common.c:cpu_reset_interrupt() does.
> >
> > Got back to x86 testing and indeed not taking the lock in that one path
> > does get things running (with all Gregory's earlier hacks + DMA limits =
as
> > described below).  Guess it's time to roll some cleaned up patches and
> > see how much everyone screams :)
> >
>
> 3 series sent out:
> (all also on gitlab.com/jic23/qemu cxl-2024-02-15 though I updated patch
> descriptions
> a little after pushing that out)
>
> Main set of fixes (x86 'works' under my light testing after this one)
>
> https://lore.kernel.org/qemu-devel/20240215150133.2088-1-Jonathan.Cameron=
@huawei.com/
>
> ARM FEAT_HADFS (access and dirty it updating in PTW) workaround for
> missing atomic CAS
>
> https://lore.kernel.org/qemu-devel/20240215151804.2426-1-Jonathan.Cameron=
@huawei.com/T/#t
>
> DMA / virtio fix:
>
> https://lore.kernel.org/qemu-devel/20240215142817.1904-1-Jonathan.Cameron=
@huawei.com/
>
> Last thing I need to do is propose a suitable flag to make
> Mattias' bounce buffering size parameter apply to "memory" address space.


For background, I actually had a global bounce buffer size parameter apply
to all address spaces in an earlier version of my series. After discussion
on the list, we settled on an address-space specific parameter so it can be
configured per device. I haven't looked into where the memory accesses in
your context originate from - can they be attributed to a specific entity
to house the parameter?


> Currently
> I'm carrying this: (I've no idea how much is need but it's somewhere
> between 4k and 1G)
>
> diff --git a/system/physmem.c b/system/physmem.c
> index 43b37942cf..49b961c7a5 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -2557,6 +2557,7 @@ static void memory_map_init(void)
>      memory_region_init(system_memory, NULL, "system", UINT64_MAX);
>      address_space_init(&address_space_memory, system_memory, "memory");
>
> +    address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 * 1024;
>      system_io =3D g_malloc(sizeof(*system_io));
>      memory_region_init_io(system_io, NULL, &unassigned_io_ops, NULL, "io=
",
>                            65536);
>
> Please take a look. These are all in areas of QEMU I'm not particularly
> confident
> about so relying on nice people giving feedback even more than normal!
>
> Thanks to all those who helped with debugging and suggestions.
>
> Thanks,
>
> Jonathan
>
> > Jonathan
> >
> >
> > > >
> > > > -- PMM
> > >
> > > Still a work in progress but I thought I'd give an update on some of
> the fun...
> > >
> > > I have a set of somewhat dubious workarounds that sort of do the job
> (where
> > > the aim is to be able to safely run any workload on top of any valid
> > > emulated CXL device setup).
> > >
> > > To recap, the issue is that for CXL memory interleaving we need to ha=
ve
> > > find grained routing to each device (16k Max Gran).  That was fine
> whilst
> > > pretty much all the testing was DAX based so software wasn't running
> out
> > > of it.  Now the kernel is rather more aggressive in defaulting any
> volatile
> > > CXL memory it finds to being normal memory (in some configs anyway)
> people
> > > started hitting problems. Given one of the most important functions o=
f
> the
> > > emulation is to check data ends up in the right backing stores, I'm n=
ot
> > > keen to drop that feature unless we absolutely have to.
> > >
> > > 1) For the simple case of no interleave I have working code that just
> > >    shoves the MemoryRegion in directly and all works fine.  That was
> always
> > >    on the todo list for virtualization cases anyway were we pretend t=
he
> > >    underlying devices aren't interleaved and frig the reported perf
> numbers
> > >    to present aggregate performance etc.  I'll tidy this up and post
> it.
> > >    We may want a config parameter to 'reject' address decoder
> programming
> > >    that would result in interleave - it's not remotely spec compliant=
,
> but
> > >    meh, it will make it easier to understand.  For virt case we'll
> probably
> > >    present locked down decoders (as if a FW has set them up) but for
> emulation
> > >    that limits usefulness too much.
> > >
> > > 2) Unfortunately, for the interleaved case can't just add a lot of
> memory
> > >    regions because even at highest granularity (16k) and minimum size
> > >    512MiB it takes for ever to eventually run into an assert in
> > >    phys_section_add with the comment:
> > >    "The physical section number is ORed with a page-aligned
> > >     pointer to produce the iotlb entries.  Thus it should
> > >     never overflow into the page-aligned value."
> > >     That sounds hard to 'fix' though I've not looked into it.
> > >
> > > So back to plan (A) papering over the cracks with TCG.
> > >
> > > I've focused on arm64 which seems a bit easier than x86 (and is
> arguably
> > > part of my day job)
> > >
> > > Challenges
> > > 1) The atomic updates of accessed and dirty bits in
> > >    arm_casq_ptw() fail because we don't have a proper address to do
> them
> > >    on.  However, there is precedence for non atomic updates in there
> > >    already (used when the host system doesn't support big enough cas)
> > >    I think we can do something similar under the bql for this case.
> > >    Not 100% sure I'm writing to the correct address but a simple frig
> > >    superficially appears to work.
> > > 2) Emulated devices try to do DMA to buffers in the CXL emulated
> interleave
> > >    memory (virtio_blk for example).  Can't do that because there is n=
o
> > >    actual translation available - just read and write functions.
> > >
> > >    So should be easy to avoid as we know how to handle DMA limitation=
s.
> > >    Just set the max dma address width to 40 bits (so below the CXL
> Fixed Memory
> > >    Windows and rely on Linux to bounce buffer with swiotlb). For a
> while
> > >    I couldn't work out why changing IORT to provide this didn't work
> and
> > >    I saw errors for virtio-pci-blk. So digging ensued.
> > >    Virtio devices by default (sort of) bypass the dma-api in linux.
> > >    vring_use_dma_api() in Linux. That is reasonable from the
> translation
> > >    point of view, but not the DMA limits (and resulting need to use
> bounce
> > >    buffers).  Maybe could put a sanity check in linux on no iommu +
> > >    a DMA restriction to below 64 bits but I'm not 100% sure we wouldn=
't
> > >    break other platforms.
> > >    Alternatively just use emulated real device and all seems fine
> > >    - I've tested with nvme.
> > >
> > > 3) I need to fix the kernel handling for CXL CDAT table originated
> > >    NUMA nodes on ARM64. For now I have a hack in place so I can make
> > >    sure I hit the memory I intend to when testing. I suspect we need
> > >    some significant work to sort
> > >
> > > Suggestions for other approaches would definitely be welcome!
> > >
> > > Jonathan
> > >
> >
> >
>
>

--0000000000004f3bd50611b76af9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 15, 2024 at 4:29=E2=80=AF=
PM Jonathan Cameron &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com">Jona=
than.Cameron@huawei.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">On Thu, 8 Feb 2024 14:50:59 +0000<br>
Jonathan Cameron &lt;Jonathan.Cameron@Huawei.com&gt; wrote:<br>
<br>
&gt; On Wed, 7 Feb 2024 17:34:15 +0000<br>
&gt; Jonathan Cameron &lt;<a href=3D"mailto:Jonathan.Cameron@huawei.com" ta=
rget=3D"_blank">Jonathan.Cameron@huawei.com</a>&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Fri, 2 Feb 2024 16:56:18 +0000<br>
&gt; &gt; Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org" tar=
get=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; &gt; &gt; On Fri, 2 Feb 2024 at 16:50, Gregory Price &lt;<a href=3D"ma=
ilto:gregory.price@memverge.com" target=3D"_blank">gregory.price@memverge.c=
om</a>&gt; wrote:=C2=A0 =C2=A0 <br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On Fri, Feb 02, 2024 at 04:33:20PM +0000, Peter Maydell=
 wrote:=C2=A0 =C2=A0 =C2=A0 <br>
&gt; &gt; &gt; &gt; &gt; Here we are trying to take an interrupt. This isn&=
#39;t related to the<br>
&gt; &gt; &gt; &gt; &gt; other can_do_io stuff, it&#39;s happening because =
do_ld_mmio_beN assumes<br>
&gt; &gt; &gt; &gt; &gt; it&#39;s called with the BQL not held, but in fact=
 there are some<br>
&gt; &gt; &gt; &gt; &gt; situations where we call into the memory subsystem=
 and we do<br>
&gt; &gt; &gt; &gt; &gt; already have the BQL.=C2=A0 =C2=A0 =C2=A0 <br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0<br>
&gt; &gt; &gt; &gt; It&#39;s bugs all the way down as usual!<br>
&gt; &gt; &gt; &gt; <a href=3D"https://xkcd.com/1416/" rel=3D"noreferrer" t=
arget=3D"_blank">https://xkcd.com/1416/</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I&#39;ll dig in a little next week to see if there&#39;=
s an easy fix. We can see<br>
&gt; &gt; &gt; &gt; the return address is already 0 going into mmu_translat=
e, so it does<br>
&gt; &gt; &gt; &gt; look unrelated to the patch I threw out - but probably =
still has to do<br>
&gt; &gt; &gt; &gt; with things being on IO.=C2=A0 =C2=A0 =C2=A0 <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Yes, the low level memory accessors only need to take the BQ=
L if the thing<br>
&gt; &gt; &gt; being accessed is an MMIO device. Probably what is wanted is=
 for those<br>
&gt; &gt; &gt; functions to do &quot;take the lock if we don&#39;t already =
have it&quot;, something<br>
&gt; &gt; &gt; like hw/core/cpu-common.c:cpu_reset_interrupt() does.=C2=A0 =
<br>
&gt; <br>
&gt; Got back to x86 testing and indeed not taking the lock in that one pat=
h<br>
&gt; does get things running (with all Gregory&#39;s earlier hacks + DMA li=
mits as<br>
&gt; described below).=C2=A0 Guess it&#39;s time to roll some cleaned up pa=
tches and<br>
&gt; see how much everyone screams :)<br>
&gt; <br>
<br>
3 series sent out:<br>
(all also on <a href=3D"http://gitlab.com/jic23/qemu" rel=3D"noreferrer" ta=
rget=3D"_blank">gitlab.com/jic23/qemu</a> cxl-2024-02-15 though I updated p=
atch descriptions<br>
a little after pushing that out)<br>
<br>
Main set of fixes (x86 &#39;works&#39; under my light testing after this on=
e)<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20240215150133.2088-1-Jonatha=
n.Cameron@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.ke=
rnel.org/qemu-devel/20240215150133.2088-1-Jonathan.Cameron@huawei.com/</a><=
br>
<br>
ARM FEAT_HADFS (access and dirty it updating in PTW) workaround for missing=
 atomic CAS<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20240215151804.2426-1-Jonatha=
n.Cameron@huawei.com/T/#t" rel=3D"noreferrer" target=3D"_blank">https://lor=
e.kernel.org/qemu-devel/20240215151804.2426-1-Jonathan.Cameron@huawei.com/T=
/#t</a><br>
<br>
DMA / virtio fix:<br>
<a href=3D"https://lore.kernel.org/qemu-devel/20240215142817.1904-1-Jonatha=
n.Cameron@huawei.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.ke=
rnel.org/qemu-devel/20240215142817.1904-1-Jonathan.Cameron@huawei.com/</a><=
br>
<br>
Last thing I need to do is propose a suitable flag to make <br>
Mattias&#39; bounce buffering size parameter apply to &quot;memory&quot; ad=
dress space.=C2=A0 </blockquote><div><br></div><div>For background, I actua=
lly had a global bounce buffer size parameter apply to all address spaces i=
n an earlier version of my series. After discussion on the list, we settled=
 on an address-space specific parameter so it can be configured per device.=
 I haven&#39;t looked into where the memory accesses in your context origin=
ate from - can they be attributed to a specific entity to house the paramet=
er?<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Currently<br>
I&#39;m carrying this: (I&#39;ve no idea how much is need but it&#39;s some=
where between 4k and 1G)<br>
<br>
diff --git a/system/physmem.c b/system/physmem.c<br>
index 43b37942cf..49b961c7a5 100644<br>
--- a/system/physmem.c<br>
+++ b/system/physmem.c<br>
@@ -2557,6 +2557,7 @@ static void memory_map_init(void)<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init(system_memory, NULL, &quot;system&qu=
ot;, UINT64_MAX);<br>
=C2=A0 =C2=A0 =C2=A0address_space_init(&amp;address_space_memory, system_me=
mory, &quot;memory&quot;);<br>
<br>
+=C2=A0 =C2=A0 address_space_memory.max_bounce_buffer_size =3D 1024 * 1024 =
* 1024;<br>
=C2=A0 =C2=A0 =C2=A0system_io =3D g_malloc(sizeof(*system_io));<br>
=C2=A0 =C2=A0 =C2=A0memory_region_init_io(system_io, NULL, &amp;unassigned_=
io_ops, NULL, &quot;io&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A065536);<br>
<br>
Please take a look. These are all in areas of QEMU I&#39;m not particularly=
 confident<br>
about so relying on nice people giving feedback even more than normal!<br>
<br>
Thanks to all those who helped with debugging and suggestions.<br>
<br>
Thanks,<br>
<br>
Jonathan<br>
<br>
&gt; Jonathan<br>
&gt; <br>
&gt; <br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; -- PMM=C2=A0 =C2=A0 <br>
&gt; &gt; <br>
&gt; &gt; Still a work in progress but I thought I&#39;d give an update on =
some of the fun...<br>
&gt; &gt; <br>
&gt; &gt; I have a set of somewhat dubious workarounds that sort of do the =
job (where<br>
&gt; &gt; the aim is to be able to safely run any workload on top of any va=
lid<br>
&gt; &gt; emulated CXL device setup).<br>
&gt; &gt; <br>
&gt; &gt; To recap, the issue is that for CXL memory interleaving we need t=
o have<br>
&gt; &gt; find grained routing to each device (16k Max Gran).=C2=A0 That wa=
s fine whilst<br>
&gt; &gt; pretty much all the testing was DAX based so software wasn&#39;t =
running out<br>
&gt; &gt; of it.=C2=A0 Now the kernel is rather more aggressive in defaulti=
ng any volatile<br>
&gt; &gt; CXL memory it finds to being normal memory (in some configs anywa=
y) people<br>
&gt; &gt; started hitting problems. Given one of the most important functio=
ns of the<br>
&gt; &gt; emulation is to check data ends up in the right backing stores, I=
&#39;m not<br>
&gt; &gt; keen to drop that feature unless we absolutely have to.<br>
&gt; &gt; <br>
&gt; &gt; 1) For the simple case of no interleave I have working code that =
just<br>
&gt; &gt;=C2=A0 =C2=A0 shoves the MemoryRegion in directly and all works fi=
ne.=C2=A0 That was always<br>
&gt; &gt;=C2=A0 =C2=A0 on the todo list for virtualization cases anyway wer=
e we pretend the<br>
&gt; &gt;=C2=A0 =C2=A0 underlying devices aren&#39;t interleaved and frig t=
he reported perf numbers<br>
&gt; &gt;=C2=A0 =C2=A0 to present aggregate performance etc.=C2=A0 I&#39;ll=
 tidy this up and post it.<br>
&gt; &gt;=C2=A0 =C2=A0 We may want a config parameter to &#39;reject&#39; a=
ddress decoder programming<br>
&gt; &gt;=C2=A0 =C2=A0 that would result in interleave - it&#39;s not remot=
ely spec compliant, but<br>
&gt; &gt;=C2=A0 =C2=A0 meh, it will make it easier to understand.=C2=A0 For=
 virt case we&#39;ll probably<br>
&gt; &gt;=C2=A0 =C2=A0 present locked down decoders (as if a FW has set the=
m up) but for emulation<br>
&gt; &gt;=C2=A0 =C2=A0 that limits usefulness too much.<br>
&gt; &gt;=C2=A0 =C2=A0 <br>
&gt; &gt; 2) Unfortunately, for the interleaved case can&#39;t just add a l=
ot of memory<br>
&gt; &gt;=C2=A0 =C2=A0 regions because even at highest granularity (16k) an=
d minimum size<br>
&gt; &gt;=C2=A0 =C2=A0 512MiB it takes for ever to eventually run into an a=
ssert in<br>
&gt; &gt;=C2=A0 =C2=A0 phys_section_add with the comment:<br>
&gt; &gt;=C2=A0 =C2=A0 &quot;The physical section number is ORed with a pag=
e-aligned<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0pointer to produce the iotlb entries.=C2=A0 Th=
us it should<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0never overflow into the page-aligned value.&qu=
ot;<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0That sounds hard to &#39;fix&#39; though I&#39=
;ve not looked into it.<br>
&gt; &gt; <br>
&gt; &gt; So back to plan (A) papering over the cracks with TCG.<br>
&gt; &gt; <br>
&gt; &gt; I&#39;ve focused on arm64 which seems a bit easier than x86 (and =
is arguably<br>
&gt; &gt; part of my day job)<br>
&gt; &gt; <br>
&gt; &gt; Challenges<br>
&gt; &gt; 1) The atomic updates of accessed and dirty bits in<br>
&gt; &gt;=C2=A0 =C2=A0 arm_casq_ptw() fail because we don&#39;t have a prop=
er address to do them<br>
&gt; &gt;=C2=A0 =C2=A0 on.=C2=A0 However, there is precedence for non atomi=
c updates in there<br>
&gt; &gt;=C2=A0 =C2=A0 already (used when the host system doesn&#39;t suppo=
rt big enough cas)<br>
&gt; &gt;=C2=A0 =C2=A0 I think we can do something similar under the bql fo=
r this case.<br>
&gt; &gt;=C2=A0 =C2=A0 Not 100% sure I&#39;m writing to the correct address=
 but a simple frig<br>
&gt; &gt;=C2=A0 =C2=A0 superficially appears to work.<br>
&gt; &gt; 2) Emulated devices try to do DMA to buffers in the CXL emulated =
interleave<br>
&gt; &gt;=C2=A0 =C2=A0 memory (virtio_blk for example).=C2=A0 Can&#39;t do =
that because there is no<br>
&gt; &gt;=C2=A0 =C2=A0 actual translation available - just read and write f=
unctions.<br>
&gt; &gt; <br>
&gt; &gt;=C2=A0 =C2=A0 So should be easy to avoid as we know how to handle =
DMA limitations.<br>
&gt; &gt;=C2=A0 =C2=A0 Just set the max dma address width to 40 bits (so be=
low the CXL Fixed Memory<br>
&gt; &gt;=C2=A0 =C2=A0 Windows and rely on Linux to bounce buffer with swio=
tlb). For a while<br>
&gt; &gt;=C2=A0 =C2=A0 I couldn&#39;t work out why changing IORT to provide=
 this didn&#39;t work and<br>
&gt; &gt;=C2=A0 =C2=A0 I saw errors for virtio-pci-blk. So digging ensued.<=
br>
&gt; &gt;=C2=A0 =C2=A0 Virtio devices by default (sort of) bypass the dma-a=
pi in linux.<br>
&gt; &gt;=C2=A0 =C2=A0 vring_use_dma_api() in Linux. That is reasonable fro=
m the translation<br>
&gt; &gt;=C2=A0 =C2=A0 point of view, but not the DMA limits (and resulting=
 need to use bounce<br>
&gt; &gt;=C2=A0 =C2=A0 buffers).=C2=A0 Maybe could put a sanity check in li=
nux on no iommu +<br>
&gt; &gt;=C2=A0 =C2=A0 a DMA restriction to below 64 bits but I&#39;m not 1=
00% sure we wouldn&#39;t<br>
&gt; &gt;=C2=A0 =C2=A0 break other platforms.<br>
&gt; &gt;=C2=A0 =C2=A0 Alternatively just use emulated real device and all =
seems fine<br>
&gt; &gt;=C2=A0 =C2=A0 - I&#39;ve tested with nvme.<br>
&gt; &gt; <br>
&gt; &gt; 3) I need to fix the kernel handling for CXL CDAT table originate=
d<br>
&gt; &gt;=C2=A0 =C2=A0 NUMA nodes on ARM64. For now I have a hack in place =
so I can make<br>
&gt; &gt;=C2=A0 =C2=A0 sure I hit the memory I intend to when testing. I su=
spect we need<br>
&gt; &gt;=C2=A0 =C2=A0 some significant work to sort <br>
&gt; &gt; <br>
&gt; &gt; Suggestions for other approaches would definitely be welcome!<br>
&gt; &gt; <br>
&gt; &gt; Jonathan<br>
&gt; &gt;=C2=A0 =C2=A0<br>
&gt; <br>
&gt; <br>
<br>
</blockquote></div></div>

--0000000000004f3bd50611b76af9--

