Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED9AC3A59D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssHz-0005rs-HX; Fri, 05 Apr 2024 18:44:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rssHy-0005rj-A0
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:44:02 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rssHv-00014H-BR
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:44:02 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-dc6d8bd618eso2669116276.3
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712357038; x=1712961838; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCBHfr4VKJb+nF0gfasAMfqJdSwuuy6m/sFNcO7Zez0=;
 b=cdXJTggeZepIP0zaMVbPZdzsjxIj0TEoetcEhYKBCAk956GbFGlkSqMjCcSCRXISmx
 ZyYzTW5p3nhrw6WSzjb9je8AzF9uGTpYL6fIvhMkliGPM6GTzDwhXB0UYN9ue6GAgi79
 3Ay5ffH/1PJFM+M/yY44fTGKG5r3T6hjP64vJ9a0bgMcNQTO/Q7u76CQysf0U/8fBQzi
 qiOMKeQ6gndXkls+f5ELkISC2IGN5Fq6FpNMEpvgFHVFh9LyEgWqSZhL0pXg/KwzGv6s
 TIlCrFakpnK5AYsn/xNCrDG/Ca7Y1TWz4ui8jKVcVxfCMn/xCHCF4YjdWWF+Ou993VVs
 +iOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712357038; x=1712961838;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hCBHfr4VKJb+nF0gfasAMfqJdSwuuy6m/sFNcO7Zez0=;
 b=q+Laha9okpoukCw+nVkW/Bxdh7dU44ZksGTaaO7hkNNBw9cAaBoZA3xHDlL4bDIiKs
 jJTnIVthL6BX+dTWd6utcgbp131VU8OL797oCEK67Fgisiupq2YJiNwhzNJnHrz2fteg
 W1wVpuH8NkTk+LQGw91PPxgChlLM97R9Cesq7OPRRc/qvjg9go8lCFJZOnuSEuBHarfa
 Dl8PXeug5zyZNn2JNr1bH2aHp3aTCskWKfumQFK8mPYbYXIlgnCU6kfnGoCB2D4FWKA+
 Stp/4RzuFVLS+dvu+f2hQe9CzpOm00dBEMEfoHOeN2iCVWJKL4Pc0KvrPedkmWb++jLp
 JJMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYtJPLl8J0dICDnlOFlC8RHIxxGftg7BsC6seMgYcFq1RYNSrLyAFTDzNjsppMM3XoFgoWqRSSJCeQnCvHl1t4uDokTP8=
X-Gm-Message-State: AOJu0Yxav/Q2gxyAAsgSXI6zcXgRBbc1+QJDuGnAsQKTf6DdkJ+kUBda
 X3156bq5aL9NFIvNCdlaJgwuiU0lmakrAc1A47znWVwzodXbnuInIve1/OYFscN8KIcDh6ev8Ek
 3CRJcCeg7L0eO0YsWONjv6ZfFayW6fXebyjdIvw==
X-Google-Smtp-Source: AGHT+IGkc0Q0l/mos/5NT0gBK0qJn5r1i2V05XNXtK/wcS38g1Oz3fhqPqidWAK23808M9UnRFIa1KWgPI5kzEPoB9g=
X-Received: by 2002:a25:6b51:0:b0:dc6:bbbc:80e4 with SMTP id
 o17-20020a256b51000000b00dc6bbbc80e4mr2701001ybm.4.1712357037795; Fri, 05 Apr
 2024 15:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-3-horenchuang@bytedance.com>
 <20240405150244.00004b49@Huawei.com>
In-Reply-To: <20240405150244.00004b49@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Fri, 5 Apr 2024 15:43:47 -0700
Message-ID: <CAKPbEqpGM_nR+LKbsoFTviBZaKUKYqJ3zbJp9EOCJAGvuPy6aQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2b.google.com
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

On Fri, Apr 5, 2024 at 7:03=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri,  5 Apr 2024 00:07:06 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > The current implementation treats emulated memory devices, such as
> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal me=
mory
> > (E820_TYPE_RAM). However, these emulated devices have different
> > characteristics than traditional DRAM, making it important to
> > distinguish them. Thus, we modify the tiered memory initialization proc=
ess
> > to introduce a delay specifically for CPUless NUMA nodes. This delay
> > ensures that the memory tier initialization for these nodes is deferred
> > until HMAT information is obtained during the boot process. Finally,
> > demotion tables are recalculated at the end.
> >
> > * late_initcall(memory_tier_late_init);
> > Some device drivers may have initialized memory tiers between
> > `memory_tier_init()` and `memory_tier_late_init()`, potentially bringin=
g
> > online memory nodes and configuring memory tiers. They should be exclud=
ed
> > in the late init.
> >
> > * Handle cases where there is no HMAT when creating memory tiers
> > There is a scenario where a CPUless node does not provide HMAT informat=
ion.
> > If no HMAT is specified, it falls back to using the default DRAM tier.
> >
> > * Introduce another new lock `default_dram_perf_lock` for adist calcula=
tion
> > In the current implementation, iterating through CPUlist nodes requires
> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end=
 up
> > trying to acquire the same lock, leading to a potential deadlock.
> > Therefore, we propose introducing a standalone `default_dram_perf_lock`=
 to
> > protect `default_dram_perf_*`. This approach not only avoids deadlock
> > but also prevents holding a large lock simultaneously.
> >
> > * Upgrade `set_node_memory_tier` to support additional cases, including
> >   default DRAM, late CPUless, and hot-plugged initializations.
> > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` t=
o
> > handle cases where memtype is not initialized and where HMAT informatio=
n is
> > available.
> >
> > * Introduce `default_memory_types` for those memory types that are not
> >   initialized by device drivers.
> > Because late initialized memory and default DRAM memory need to be mana=
ged,
> > a default memory type is created for storing all memory types that are
> > not initialized by device drivers and as a fallback.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> Hi - one remaining question. Why can't we delay init for all nodes
> to either drivers or your fallback late_initcall code.
> It would be nice to reduce possible code paths.

I try not to change too much of the existing code structure in
this patchset.

To me, postponing/moving all memory tier registrations to
late_initcall() is another possible action item for the next patchset.

After tier_mem(), hmat_init() is called, which requires registering
`default_dram_type` info. This is when `default_dram_type` is needed.
However, it is indeed possible to postpone the latter part,
set_node_memory_tier(), to `late_init(). So, memory_tier_init() can
indeed be split into two parts, and the latter part can be moved to
late_initcall() to be processed together.

Doing this all memory-type drivers have to call late_initcall() to
register a memory tier. I=E2=80=99m not sure how many they are?

What do you guys think?

>
> Jonathan
>
>
> > ---
> >  mm/memory-tiers.c | 94 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 70 insertions(+), 24 deletions(-)
> >
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 516b144fd45a..6632102bd5c9 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
>
>
>
> > @@ -855,7 +892,8 @@ static int __init memory_tier_init(void)
> >        * For now we can have 4 faster memory tiers with smaller adistan=
ce
> >        * than default DRAM tier.
> >        */
> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANCE=
_DRAM,
> > +                                                   &default_memory_typ=
es);
> >       if (IS_ERR(default_dram_type))
> >               panic("%s() failed to allocate default DRAM tier\n", __fu=
nc__);
> >
> > @@ -865,6 +903,14 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on
> > +                      * CPUless numa nodes. These will be initialized
> > +                      * after firmware and devices are initialized.
>
> Could the comment also say why we can't defer them all?
>
> (In an odd coincidence we have a similar issue for some CPU hotplug
>  related bring up where review feedback was move all cases later).
>
> > +                      */
> > +                     continue;
> > +
> >               memtier =3D set_node_memory_tier(node);
> >               if (IS_ERR(memtier))
> >                       /*
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

