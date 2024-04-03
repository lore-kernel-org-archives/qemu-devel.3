Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98300CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 23:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs9nd-0008QK-1m; Wed, 03 Apr 2024 19:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rs9nb-0008Pu-Is
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 19:13:43 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rs9nZ-0006kU-H8
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 19:13:43 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-dd14d8e7026so423171276.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 16:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712186015; x=1712790815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXQkJndwO2OFb1B4uAhm6DSgUpXUEz9T4TSxXyfE+FM=;
 b=fpGwHT/ZpxSJY9A9pZ1eqsqs98IV6mqmKlWPXEb6R+FguH/RfXORpD6k/so2EIOLkH
 AWarY6qK1XYvXzoedv0MIVWTFC1WrxEgboCdtEv5Oo+MUFudD4T7vSJxsED7NWfpUV8x
 CPPRthSdrwrBFZQhaOauP0VCoHcBJu9EA20U5L2QAqbJiA5b7masTXWRu81/zI0/K469
 NTzlEheYQ2smo5qcu4fwdRiT+mx8a6lXQ47pu3YCsnUBktqyjQjVR7zZ5+W47MfRg/Ka
 oCkfKWIiyaFJO5+caWQqhYvynxxkKGB1+ASleVyUZyPUmXKdplu+PicnE/NT5I8MN+EK
 pZfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712186015; x=1712790815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SXQkJndwO2OFb1B4uAhm6DSgUpXUEz9T4TSxXyfE+FM=;
 b=uEjIkN7qR2gwAxLhee+65otc8kH4AgHzHj85hCFRpywxOYbg0aHpe12n9R5crJudMY
 oV1ITQ2vYnuXmn82vCFRK8CcG0jyqnfMnuQLz2Kee2MUzaRtlEe3LIWl2Njshb1NQAsF
 TBMRmuJgSqizag9OeizNXRe04jl4Fu2NA82m8E79dYgWsLd8fv22U8DZjaPuor3PbD0e
 fbeEBwypnQm1Aq+SPlq3CSLoY32Ia9NSEIdOedM3qhX51sHzkrGRSAIChcwHIiMfpURd
 YQnl073ICCVMS0Me7ZKpVaR5wAM8+B9zPF6yVU738ql/FhjR4/mO2vvmgZk7cbb4yWPK
 cwdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Sfr57zYvhPP3Kfico+UCmY/R+5MeVOHqfREvQ/kLSwB1YBMG68mdc4FFJLzxdoDj0QPfRY5Mm2RXmmmQ90eh3LrDwXo=
X-Gm-Message-State: AOJu0YynKer0ir9YoXJ5ysRHNG7fiC8Eou+HiIRyNSdql45VGnyZbVIG
 pZEsZydWnosLxrPWz0Mv6jSEAQzbWdrR5YisdRbFMK0ej/F4CefkRnV/kW+Hfr5SbTdW6VTCFc4
 jSZzqxLnXuB/Xtxkabb+QD0UT+mGKi5dT7rkyMQ==
X-Google-Smtp-Source: AGHT+IFVeLOeseHn7jgUi35tqoQdrprRgFyBUayTJ7qIeLYhEuQo2z8SpiV7Er/5CVQCTXOehRej6DG8/caODWdPemM=
X-Received: by 2002:a25:8189:0:b0:dc2:3936:5fa5 with SMTP id
 p9-20020a258189000000b00dc239365fa5mr828148ybk.51.1712186014869; Wed, 03 Apr
 2024 16:13:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-2-horenchuang@bytedance.com>
 <20240403175201.00000c2c@Huawei.com>
In-Reply-To: <20240403175201.00000c2c@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Wed, 3 Apr 2024 16:13:24 -0700
Message-ID: <CAKPbEqo_zN1Y-Ut6oGpP6OaRALQRFMmA737_br-9=ROcnj25gg@mail.gmail.com>
Subject: Re: [PATCH v10 1/2] memory tier: dax/kmem: introduce an abstract
 layer for finding, allocating, and putting memory types
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
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2a.google.com
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

Hi Jonathan,

Thanks for your feedback. I will fix them (inlined) in the next V11.
No worries, it's never too late!

On Wed, Apr 3, 2024 at 9:52=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue,  2 Apr 2024 00:17:37 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > Since different memory devices require finding, allocating, and putting
> > memory types, these common steps are abstracted in this patch,
> > enhancing the scalability and conciseness of the code.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>
> Hi,
>
> I know this is a late entry to the discussion but a few comments inline.
> (sorry I didn't look earlier!)
>
> All opportunities to improve code complexity and readability as a result
> of your factoring out.
>
> Jonathan
>
>
> > ---
> >  drivers/dax/kmem.c           | 20 ++------------------
> >  include/linux/memory-tiers.h | 13 +++++++++++++
> >  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
> >  3 files changed, 47 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 42ee360cf4e3..01399e5b53b2 100644
> > --- a/drivers/dax/kmem.c
> > +++ b/drivers/dax/kmem.c
> > @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
> >
> >  static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
> >  {
> > -     bool found =3D false;
> >       struct memory_dev_type *mtype;
> >
> >       mutex_lock(&kmem_memory_type_lock);
> could use
>
>         guard(mutex)(&kmem_memory_type_lock);
>         return mt_find_alloc_memory_type(adist, &kmem_memory_types);
>

I will change it accordingly.

> I'm fine if you ignore this comment though as may be other functions in
> here that could take advantage of the cleanup.h stuff in a future patch.
>
> > -     list_for_each_entry(mtype, &kmem_memory_types, list) {
> > -             if (mtype->adistance =3D=3D adist) {
> > -                     found =3D true;
> > -                     break;
> > -             }
> > -     }
> > -     if (!found) {
> > -             mtype =3D alloc_memory_type(adist);
> > -             if (!IS_ERR(mtype))
> > -                     list_add(&mtype->list, &kmem_memory_types);
> > -     }
> > +     mtype =3D mt_find_alloc_memory_type(adist, &kmem_memory_types);
> >       mutex_unlock(&kmem_memory_type_lock);
> >
> >       return mtype;
>
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index 69e781900082..a44c03c2ba3a 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source);
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > +                                                     struct list_head =
*memory_types);
>
> That indent looks unusual.  Align the start of struct with start of int.
>

I can make this aligned but it will show another warning:
"WARNING: line length of 131 exceeds 100 columns"
Is this ok?

> > +void mt_put_memory_types(struct list_head *memory_types);
> >  #ifdef CONFIG_MIGRATION
> >  int next_demotion_node(int node);
> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> > @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct acce=
ss_coordinate *perf, int *adis
> >  {
> >       return -EIO;
> >  }
> > +
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +{
> > +     return NULL;
> > +}
> > +
> > +void mt_put_memory_types(struct list_head *memory_types)
> > +{
> > +
> No blank line needed here.

Will fix.

> > +}
> >  #endif       /* CONFIG_NUMA */
> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 0537664620e5..974af10cfdd8 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -623,6 +623,38 @@ void clear_node_memory_type(int node, struct memor=
y_dev_type *memtype)
> >  }
> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
>
> Breaking this out as a separate function provides opportunity to improve =
it.
> Maybe a follow up patch makes sense given it would no longer be a straigh=
t
> forward code move.  However in my view it would be simple enough to be ob=
vious
> even within this patch.
>

I will just keep this as is for now to minimize the changes aka mistakes.

> > +{
> > +     bool found =3D false;
> > +     struct memory_dev_type *mtype;
> > +
> > +     list_for_each_entry(mtype, memory_types, list) {
> > +             if (mtype->adistance =3D=3D adist) {
> > +                     found =3D true;
>
> Why not return here?
>                         return mtype;
>

Yes, I can return here. I will do that and take care of the ptr
returning at this point.

> > +                     break;
> > +             }
> > +     }
> > +     if (!found) {
>
> If returning above, no need for found variable - just do this uncondition=
ally.
> + I suggest you flip logic for simpler to follow code flow.
> It's more code but I think a bit easier to read as error handling is
> out of the main simple flow.
>
>         mtype =3D alloc_memory_type(adist);
>         if (IS_ERR(mtype))
>                 return mtype;
>
>         list_add(&mtype->list, memory_types);
>
>         return mtype;
>

Good idea! I will change it accordingly.

> > +             mtype =3D alloc_memory_type(adist);
> > +             if (!IS_ERR(mtype))
> > +                     list_add(&mtype->list, memory_types);
> > +     }
> > +
> > +     return mtype;
> > +}
> > +EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
> > +
> > +void mt_put_memory_types(struct list_head *memory_types)
> > +{
> > +     struct memory_dev_type *mtype, *mtn;
> > +
> > +     list_for_each_entry_safe(mtype, mtn, memory_types, list) {
> > +             list_del(&mtype->list);
> > +             put_memory_type(mtype);
> > +     }
> > +}
> > +EXPORT_SYMBOL_GPL(mt_put_memory_types);
> > +
> >  static void dump_hmem_attrs(struct access_coordinate *coord, const cha=
r *prefix)
> >  {
> >       pr_info(
>


--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

