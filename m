Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF43CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQwQ-0008KR-41; Wed, 10 Apr 2024 01:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruQwN-0008K6-Tb
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:56:11 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruQwL-00045U-Ae
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:56:11 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcc80d6004bso6445174276.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 22:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712728565; x=1713333365; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqGY/vGIyR9LCZTBxU/bq4zwRiV3ymHiMH0aV8SV/K8=;
 b=iHOhOxuPQ0XwzOm9vA8yGGPGxKyCTMo3rduqwDSzZfbnhOrB7XFzn1EpWZXiYPqZYU
 sn1y3bYxwcZrdgi8VbMgEOzXKzX93+z1Q/yVXvp68z01anfyUW3mel68I7+O0wiGn7fZ
 2Io0lL27cWvlfy5TtHfwWPanRkad+hvZpURqagvdtoEEhyYLZc3Z/1OaMeMLR8FQ2X8q
 GS7IzkBmmWFZbRuXbVrx0vkoR8/xSDPazbxIALj29OAdKJwy8SiejiBGzxax6B3Ht43v
 qTBB4TaxrHlb6sQVFw5RAxEflQKhmRdEQK1P0lxxCvwsvoV6Zs2ZNsKuxL5q3fr67gX1
 YCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712728565; x=1713333365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IqGY/vGIyR9LCZTBxU/bq4zwRiV3ymHiMH0aV8SV/K8=;
 b=QPTaTojF/kr+jFUV04ai8yrMKR/9gi5eh4nwTTSKtBal1QgumeglYiG+Wq+3D+/Y+W
 BHXUoCiT0fHiTg2FuI964K2sZKjLYQ98+knZQJ7/aUKBLyZJ7rZkzyE5X3kAX95MdYqc
 wr30Y8kwomw9WoaRCEhj76fvyhG6jKyN71Xxyb5uVWbdgv4TX9MACG6Hh8+LzouvJ+Eg
 s/88jRUjGB/i7q8JjWVPKDzFXbraPphOGd3c/Y3CkVv8gzWfvAhcX1LLiH0AofSmse+N
 7b3F8WtpHJdWrc7SS8iBUF+9zyWtrddZ4MFsazmsyP5BWfNseu2hYbhnzth8ltFEIeRi
 qzCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp/WLIJyY1t1sUNrcn5QTtzgddbVbQEjorWl/89alCREektGfhVd7qraIa+C0vAK6mHc9Cl64qO1ePGHUtd1OClkw1jJ8=
X-Gm-Message-State: AOJu0Yz8XT+nqYZ8k2kHtKbKyiNFcFcxS1kPTXicaAxsUNzb2UCc7agN
 PRCvOjssAd1pAkVm4v0cutBhsMXdzt/OXpVbOle97utRoN/G7AzXt3CzoBL2KNxIxXtvuKeO6QA
 y+A2qlhTxWJNl/N9enwC1100nRkI7TSrnsLQwbQ==
X-Google-Smtp-Source: AGHT+IHeeE9q1+cJcZFRlCtvV1BbpZVxnUEWrSDgdRRs3q/CuKFEvKs0kmjhM3Z408INF7Cm0W+a8a8XNmlyII/QV0E=
X-Received: by 2002:a25:be92:0:b0:dcd:5635:5c11 with SMTP id
 i18-20020a25be92000000b00dcd56355c11mr1731856ybk.45.1712728565448; Tue, 09
 Apr 2024 22:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com>
 <20240405150244.00004b49@Huawei.com>
 <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
 <87ttka54pr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87ttka54pr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 22:55:54 -0700
Message-ID: <CAKPbEqqH0nhVUAcJUxDc_bPewY85+TqhtO94MyypV35GBo33+A@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 2/2] memory tier: create CPUless memory
 tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linux Memory Management List <linux-mm@kvack.org>,
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, 
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2d.google.com
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

On Tue, Apr 9, 2024 at 7:33=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> >>
> >> On Fri,  5 Apr 2024 00:07:06 +0000
> >> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> >>
> >> > The current implementation treats emulated memory devices, such as
> >> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal=
 memory
> >> > (E820_TYPE_RAM). However, these emulated devices have different
> >> > characteristics than traditional DRAM, making it important to
> >> > distinguish them. Thus, we modify the tiered memory initialization p=
rocess
> >> > to introduce a delay specifically for CPUless NUMA nodes. This delay
> >> > ensures that the memory tier initialization for these nodes is defer=
red
> >> > until HMAT information is obtained during the boot process. Finally,
> >> > demotion tables are recalculated at the end.
> >> >
> >> > * late_initcall(memory_tier_late_init);
> >> > Some device drivers may have initialized memory tiers between
> >> > `memory_tier_init()` and `memory_tier_late_init()`, potentially brin=
ging
> >> > online memory nodes and configuring memory tiers. They should be exc=
luded
> >> > in the late init.
> >> >
> >> > * Handle cases where there is no HMAT when creating memory tiers
> >> > There is a scenario where a CPUless node does not provide HMAT infor=
mation.
> >> > If no HMAT is specified, it falls back to using the default DRAM tie=
r.
> >> >
> >> > * Introduce another new lock `default_dram_perf_lock` for adist calc=
ulation
> >> > In the current implementation, iterating through CPUlist nodes requi=
res
> >> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will =
end up
> >> > trying to acquire the same lock, leading to a potential deadlock.
> >> > Therefore, we propose introducing a standalone `default_dram_perf_lo=
ck` to
> >> > protect `default_dram_perf_*`. This approach not only avoids deadloc=
k
> >> > but also prevents holding a large lock simultaneously.
> >> >
> >> > * Upgrade `set_node_memory_tier` to support additional cases, includ=
ing
> >> >   default DRAM, late CPUless, and hot-plugged initializations.
> >> > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> >> > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()=
` to
> >> > handle cases where memtype is not initialized and where HMAT informa=
tion is
> >> > available.
> >> >
> >> > * Introduce `default_memory_types` for those memory types that are n=
ot
> >> >   initialized by device drivers.
> >> > Because late initialized memory and default DRAM memory need to be m=
anaged,
> >> > a default memory type is created for storing all memory types that a=
re
> >> > not initialized by device drivers and as a fallback.
> >> >
> >> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> >> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> >> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >>
> >> Hi - one remaining question. Why can't we delay init for all nodes
> >> to either drivers or your fallback late_initcall code.
> >> It would be nice to reduce possible code paths.
> >
> > I try not to change too much of the existing code structure in
> > this patchset.
> >
> > To me, postponing/moving all memory tier registrations to
> > late_initcall() is another possible action item for the next patchset.
> >
> > After tier_mem(), hmat_init() is called, which requires registering
> > `default_dram_type` info. This is when `default_dram_type` is needed.
> > However, it is indeed possible to postpone the latter part,
> > set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
> > indeed be split into two parts, and the latter part can be moved to
> > late_initcall() to be processed together.
>
> I don't think that it's good to move all memory_tier initialization in
> drivers to late_initcall().  It's natural to keep them in
> device_initcall() level.
>
> If so, we can allocate default_dram_type in memory_tier_init(), and call
> set_node_memory_tier() only in memory_tier_lateinit().  We can call
> memory_tier_lateinit() in device_initcall() level too.
>

It makes sense to me to leave only `default_dram_type ` and
hotplug_init() in memory_tier_init(), postponing all
set_node_memory_tier()s to memory_tier_late_init()

Would it be possible there is no device_initcall() calling
memory_tier_late_init()? If yes, I think putting memory_tier_late_init()
in late_init() is still necessary.

> --
> Best Regards,
> Huang, Ying
>
> > Doing this all memory-type drivers have to call late_initcall() to
> > register a memory tier. I=E2=80=99m not sure how many they are?
> >
> > What do you guys think?
> >
> >>
> >> Jonathan
> >>
> >>
> >> > ---
> >> >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++---------=
---
> >> >  1 file changed, 70 insertions(+), 24 deletions(-)
> >> >
> >> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> >> > index 516b144fd45a..6632102bd5c9 100644
> >> > --- a/mm/memory-tiers.c
> >> > +++ b/mm/memory-tiers.c
> >>
> >>
> >>
> >> > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> >> >        * For now we can have 4 faster memory tiers with smaller adis=
tance
> >> >        * than default DRAM tier.
> >> >        */
> >> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM=
);
> >> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTA=
NCE_DRAM,
> >> > +                                                   &default_memory_=
types);
> >> >       if (IS_ERR(default_dram_type))
> >> >               panic("%s() failed to allocate default DRAM tier\n", _=
_func__);
> >> >
> >> > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> >> >        * types assigned.
> >> >        */
> >> >       for_each_node_state(node, N_MEMORY) {
> >> > +             if (!node_state(node, N_CPU))
> >> > +                     /*
> >> > +                      * Defer memory tier initialization on
> >> > +                      * CPUless numa nodes. These will be initializ=
ed
> >> > +                      * after firmware and devices are initialized.
> >>
> >> Could the comment also say why we can't defer them all?
> >>
> >> (In an odd coincidence we have a similar issue for some CPU hotplug
> >>  related bring up where review feedback was move all cases later).
> >>
> >> > +                      */
> >> > +                     continue;
> >> > +
> >> >               memtier =3D set_node_memory_tier(node);
> >> >               if (IS_ERR(memtier))
> >> >                       /*
> >>



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

