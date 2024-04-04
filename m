Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CD1CD128A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 00:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsAre-0008MR-CW; Wed, 03 Apr 2024 20:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsArR-0008Ls-8i
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 20:21:47 -0400
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rsArH-0003Y9-VF
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 20:21:44 -0400
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dc25e12cc63so1435197276.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 17:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712190092; x=1712794892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qO60jqsH0RDRW8MepZgYWUNAloZS/uU+ZxX94+OfopY=;
 b=VOH0eEA8eq56FbMeLjEwgc1SzNHoU4UA3nHcPK0EzPN12ktRRs54gdfksEuw17RtPb
 aA4x3W4tDw408YSMIXfTAYq1SbEVkM1sHmULSVANvmnPVP/v0whBUscyLQlQDQJ7uZ4U
 HGLbSljZ0ptpjK6v/3Z5okFAf3TMtGmkhAMj3FSunMvHuBWQlIP3mKlK+NURJfGPcqhH
 p8WmH2RaFytDR72sxeBFebNtotqN7JZEWqySCpmJJ7UlTDm+5FPIO/N0TRIiOGBsGKuH
 aY1uKE+G6BmhObYzlJnPWerNBUYi88Po6Wf9gdlvZs3d6ecKwJ2ZFErdsns5vXOc3Qgg
 ZyQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712190092; x=1712794892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qO60jqsH0RDRW8MepZgYWUNAloZS/uU+ZxX94+OfopY=;
 b=RC0nMqaN1h1CGvdwHGWzI/fNVP09cvZ3wzIoa2mom5Xt6xoWMtN2q7zcRdl83Emb1o
 auByi3QycuPAp6qm3q0cdAiO9Ab1+9waSfqA/5RQpKbpcJk3w7GpQfCTm70OMwPXb1Dd
 EcP8rO/fHb2fbQmbgSvEoiNmFJH5KZ1x8IwDHvXQ0d4lH9PPLxP0MJNaZ/GWQE1kL78Z
 TClLIQOi+6HRDMFabz6N+3CGbc5XOiQ/U2x1aWOWBFsS8BCnm+OmQasOWU+zGAVc/fl4
 co7it6amc46BA+rp96XUSA9sLhoImrqCugdNGEhYSztDnyHuqDslwA87cUZH2EXiHjak
 Lmlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX97/M2HXbkrysYrpeXJOjA61R72mwGBQvh3YrCEjRwySwJVSs7EMkoFE2VWbpcZ7vjzuIBkFW0IRjqPQ5c7gDFT95ITX0=
X-Gm-Message-State: AOJu0Ywdago3wqsY4Q9hJfBihiacj6CekyQz7i2+Tl+7D7EN2XXHPNVv
 YoehDYeTw8QlCG6dnH0jHrepH/k1kQ6zYS9H4JvKJj14BupDXvluqQAVl5wabkgpmzNM1uPioX/
 L8BMV6XhfDBtHy3CKFQp9MpxQT2pS+hPmy3qAxQ==
X-Google-Smtp-Source: AGHT+IHSYTr5M+525vcAEY5Aj2ib0qO6jpryNktw+PRCGQjz5qKA3WKMPc+zBf2F+1T8pwG+v1Tqmm74FhKD/Wr0Snw=
X-Received: by 2002:a05:6902:1029:b0:dc7:46fd:4998 with SMTP id
 x9-20020a056902102900b00dc746fd4998mr1050153ybt.13.1712190092377; Wed, 03 Apr
 2024 17:21:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-3-horenchuang@bytedance.com>
 <20240403180425.00003be0@Huawei.com>
In-Reply-To: <20240403180425.00003be0@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Wed, 3 Apr 2024 17:21:21 -0700
Message-ID: <CAKPbEqoJZe+HWHhCvBTVSHXffGY2ign3Htp4pfbFb4YVJS_Q2A@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] memory tier: create CPUless memory tiers after
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Thank you for your feedback. I will fix them (inlined) in the next V11.

On Wed, Apr 3, 2024 at 10:04=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> A few minor comments inline.
>
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index a44c03c2ba3a..16769552a338 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -140,12 +140,13 @@ static inline int mt_perf_to_adistance(struct acc=
ess_coordinate *perf, int *adis
> >       return -EIO;
> >  }
> >
> > -struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +static inline struct memory_dev_type *mt_find_alloc_memory_type(int ad=
ist,
> > +                                     struct list_head *memory_types)
> >  {
> >       return NULL;
> >  }
> >
> > -void mt_put_memory_types(struct list_head *memory_types)
> > +static inline void mt_put_memory_types(struct list_head *memory_types)
> >  {
> Why in this patch and not previous one?

I've also noticed this issue. I will fix it in the next V11.

> >
> >  }
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 974af10cfdd8..44fa10980d37 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -36,6 +36,11 @@ struct node_memory_type_map {
> >
> >  static DEFINE_MUTEX(memory_tier_lock);
> >  static LIST_HEAD(memory_tiers);
> > +/*
> > + * The list is used to store all memory types that are not created
> > + * by a device driver.
> > + */
> > +static LIST_HEAD(default_memory_types);
> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >  struct memory_dev_type *default_dram_type;
> >
> > @@ -108,6 +113,8 @@ static struct demotion_nodes *node_demotion __read_=
mostly;
> >
> >  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
> >
> > +/* The lock is used to protect `default_dram_perf*` info and nid. */
> > +static DEFINE_MUTEX(default_dram_perf_lock);
> >  static bool default_dram_perf_error;
> >  static struct access_coordinate default_dram_perf;
> >  static int default_dram_perf_ref_nid =3D NUMA_NO_NODE;
> > @@ -505,7 +512,8 @@ static inline void __init_node_memory_type(int node=
, struct memory_dev_type *mem
> >  static struct memory_tier *set_node_memory_tier(int node)
> >  {
> >       struct memory_tier *memtier;
> > -     struct memory_dev_type *memtype;
> > +     struct memory_dev_type *mtype =3D default_dram_type;
>
> Does the rename add anything major to the patch?
> If not I'd leave it alone to reduce the churn and give
> a more readable patch.  If it is worth doing perhaps
> a precursor patch?
>

Either name works. Keeping it the same name will make the code
easier to follow. I agree! Thanks.

> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >       pg_data_t *pgdat =3D NODE_DATA(node);
> >
> >
> > @@ -514,11 +522,20 @@ static struct memory_tier *set_node_memory_tier(i=
nt node)
> >       if (!node_state(node, N_MEMORY))
> >               return ERR_PTR(-EINVAL);
> >
> > -     __init_node_memory_type(node, default_dram_type);
> > +     mt_calc_adistance(node, &adist);
> > +     if (node_memory_types[node].memtype =3D=3D NULL) {
> > +             mtype =3D mt_find_alloc_memory_type(adist, &default_memor=
y_types);
> > +             if (IS_ERR(mtype)) {
> > +                     mtype =3D default_dram_type;
> > +                     pr_info("Failed to allocate a memory type. Fall b=
ack.\n");
> > +             }
> > +     }
> > +
> > +     __init_node_memory_type(node, mtype);
> >
> > -     memtype =3D node_memory_types[node].memtype;
> > -     node_set(node, memtype->nodes);
> > -     memtier =3D find_create_memory_tier(memtype);
> > +     mtype =3D node_memory_types[node].memtype;
> > +     node_set(node, mtype->nodes);
> > +     memtier =3D find_create_memory_tier(mtype);
> >       if (!IS_ERR(memtier))
> >               rcu_assign_pointer(pgdat->memtier, memtier);
> >       return memtier;
> > @@ -655,6 +672,33 @@ void mt_put_memory_types(struct list_head *memory_=
types)
> >  }
> >  EXPORT_SYMBOL_GPL(mt_put_memory_types);
> >
> > +/*
> > + * This is invoked via `late_initcall()` to initialize memory tiers fo=
r
> > + * CPU-less memory nodes after driver initialization, which is
> > + * expected to provide `adistance` algorithms.
> > + */
> > +static int __init memory_tier_late_init(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (node_memory_types[nid].memtype =3D=3D NULL)
> > +                     /*
> > +                      * Some device drivers may have initialized memor=
y tiers
> > +                      * between `memory_tier_init()` and `memory_tier_=
late_init()`,
> > +                      * potentially bringing online memory nodes and
> > +                      * configuring memory tiers. Exclude them here.
> > +                      */
>
> Does the comment refer to this path, or to ones where memtype is set?
>

Yes, the comment is for explaining why the if condition is used.

> > +                     set_node_memory_tier(nid);
>
> Given the large comment I would add {} to help with readability.
> You could flip the logic to reduce indent
>         for_each_node_state(nid, N_MEMORY) {
>                 if (node_memory_types[nid].memtype)
>                         continue;
>                 /*
>                  * Some device drivers may have initialized memory tiers
>                  * between `memory_tier_init()` and `memory_tier_late_ini=
t()`,
>                  * potentially bringing online memory nodes and
>                  * configuring memory tiers. Exclude them here.
>                  */
>                 set_node_memory_tier(nid);
>
>

I will change it accordingly.

> > +
> > +     establish_demotion_targets();
> > +     mutex_unlock(&memory_tier_lock);
> > +
> > +     return 0;
> > +}
> > +late_initcall(memory_tier_late_init);
> > +
> >  static void dump_hmem_attrs(struct access_coordinate *coord, const cha=
r *prefix)
> >  {
> >       pr_info(
> > @@ -668,7 +712,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >  {
> >       int rc =3D 0;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&default_dram_perf_lock);
>
> As below, this is a classic case where guard() will help readability.
>

I will change it accordingly.

> >       if (default_dram_perf_error) {
> >               rc =3D -EIO;
> >               goto out;
> > @@ -716,23 +760,30 @@ int mt_set_default_dram_perf(int nid, struct acce=
ss_coordinate *perf,
> >       }
> >
> >  out:
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&default_dram_perf_lock);
> >       return rc;
> >  }
> >
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
> >  {
> > -     if (default_dram_perf_error)
> > -             return -EIO;
> > +     int rc =3D 0;
>
> Looks like rc is set in all paths that reach where it issued.
>

Using guard(mutex), I will no longer need `int rc`.
Replace `rc =3D` with `return XXX`.

> >
> > -     if (default_dram_perf_ref_nid =3D=3D NUMA_NO_NODE)
> > -             return -ENOENT;
> > +     mutex_lock(&default_dram_perf_lock);
>
> This would benefit quite a lot from
> guard(mutex)(&default_dram_perf_lock);
> and direct returns throughout.
>

Got it. I will change it accordingly.

>
> > +     if (default_dram_perf_error) {
> > +             rc =3D -EIO;
> > +             goto out;
> > +     }
> >
> >       if (perf->read_latency + perf->write_latency =3D=3D 0 ||
> > -         perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> > -             return -EINVAL;
> > +         perf->read_bandwidth + perf->write_bandwidth =3D=3D 0) {
> > +             rc =3D -EINVAL;
> > +             goto out;
> > +     }
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     if (default_dram_perf_ref_nid =3D=3D NUMA_NO_NODE) {
> > +             rc =3D -ENOENT;
> > +             goto out;
> > +     }
> >       /*
> >        * The abstract distance of a memory node is in direct proportion=
 to
> >        * its memory latency (read + write) and inversely proportional t=
o its
> > @@ -745,9 +796,10 @@ int mt_perf_to_adistance(struct access_coordinate =
*perf, int *adist)
> >               (default_dram_perf.read_latency + default_dram_perf.write=
_latency) *
> >               (default_dram_perf.read_bandwidth + default_dram_perf.wri=
te_bandwidth) /
> >               (perf->read_bandwidth + perf->write_bandwidth);
> > -     mutex_unlock(&memory_tier_lock);
> >
> > -     return 0;
> > +out:
> > +     mutex_unlock(&default_dram_perf_lock);
> > +     return rc;
> >  }
> >  EXPORT_SYMBOL_GPL(mt_perf_to_adistance);
> >
> > @@ -858,7 +910,8 @@ static int __init memory_tier_init(void)
> >        * For now we can have 4 faster memory tiers with smaller adistan=
ce
> >        * than default DRAM tier.
> >        */
> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > +     default_dram_type =3D mt_find_alloc_memory_type(MEMTIER_ADISTANCE=
_DRAM,
> > +                                                                     &=
default_memory_types);
>
> Unusual indenting.  Align with just after (
>

Aligning with "(" will exceed 100 columns. Would that be acceptable?

> >       if (IS_ERR(default_dram_type))
> >               panic("%s() failed to allocate default DRAM tier\n", __fu=
nc__);
> >
> > @@ -868,6 +921,14 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on CPUless nu=
ma nodes.
> > +                      * These will be initialized after firmware and d=
evices are
>
> I think this wraps at just over 80 chars.  Seems silly to wrap so tightly=
 and not
> quite fit under 80. (this is about 83 chars.
>

I can fix this.
I have a question. From my patch, this is <80 chars. However,
in an email, this is >80 chars. Does that mean we need to
count the number of chars in an email, not in a patch? Or if I
missed something? like vim configuration or?

> > +                      * initialized.
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

