Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DA5C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 09:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhR6t-0008Fz-DE; Tue, 05 Mar 2024 04:29:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhR6n-0008EA-Kg
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:29:14 -0500
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhR6j-0000kx-Ub
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 04:29:12 -0500
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-7da728b0597so2290503241.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 01:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709630946; x=1710235746; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79M1BRzVOMDaKqMxEGUh5q94dnwcGvlodjX5ei2a/R4=;
 b=YnRy60JQTw67qf/4MwMeSWjBUEurZv6AxIDbVdErEnZ3XfIZMobqsbPdVnrWBHPR3B
 UQufcekZChNN398pGdYFXZMHWcmLJdLcEHIsytIh0pfJRv4XFvwKND2hhOhcXVhHjHbK
 SzIl6phkdoasBcPGT7GH6WKxB7ufAuaYTz+16D+r6ACwGEqiFnYn/9dabRSGnMGtKalK
 AQpQ8uvHSnNDpcf+FNRasfckx8nhCroeV+vloElJt7XmK+dtN9IVLIGrvsgVwIroSbvj
 Un59/1R8IFrhLjdgDH23AiqReQ7CSpiQuNnszpSQSmCSw2lNaSUNNIpE5g5Znm+FTdfR
 G0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709630946; x=1710235746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79M1BRzVOMDaKqMxEGUh5q94dnwcGvlodjX5ei2a/R4=;
 b=ZuKyg08eUg64UIAi9BtUFLH0SWpShwnJ3EwUsqFLwEB7rKmzOsnDj0jdk+mbjdKuhr
 G85j2GPHDhYBPqf7sZbRCBRtQXPM0H2MR96ImSfhX9xM5j40d+f7z6Som0eQ3GCvCWnA
 hVhQ92P3GicJShzP9TFmqv5YNnokTkelmlPxAoltOTzwza+QzmW9XLWybINzsmnuzHui
 bp1nQ4VJJrl/7MyBmm+QJUYpYGC6VTBlOdw5zlmpvsYUzSjDPrt5Vjm8iVjXY9mhU4mw
 1Y7k1ssSuBg3nq9KI1GhTInN/AfDWtK+on/3jk0NQ/H4feh90h7O9cP0FiTy+nuFVGyz
 mCsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOArNMYE2og6BDGuRZJjW8jdChR8fiiJaGR6z/i1xeuI21KuE+Y5IaJnBqkuNsMKVPAz2DVMid5VMAaQcBKkr2wrQmRbY=
X-Gm-Message-State: AOJu0YzXps3zd7KiD+LkfcmVWJzsQduw+urldVJ7CcsKc4RSkrqiIflC
 jx7ffP/XrONvKXgyKVtdqbQCH8UA895g1KHV9bajP7vX07VC+985z34CY+mUjll11+ZbP5BTo1l
 ePdJn46HWIVBhuAhd+kTp9lASvP80LR6MEjY/4g==
X-Google-Smtp-Source: AGHT+IGeG8eiA+gbTAW4lP8+EW0Wh/ImGvq3CgHfBV04xBBfvRQuXg2vDyo36TnOBu+4pDZXWZHNMilzpagoOwujU5k=
X-Received: by 2002:a05:6102:21ba:b0:472:c844:804d with SMTP id
 i26-20020a05610221ba00b00472c844804dmr1040181vsb.18.1709630946252; Tue, 05
 Mar 2024 01:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <20240301082248.3456086-2-horenchuang@bytedance.com>
 <87jzmibtyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87jzmibtyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 5 Mar 2024 01:28:55 -0800
Message-ID: <CAKPbEqrti2x05n5QhXtefhu+C=xmMUaH8mMwDy83LVN3Fj6nDw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 1/1] memory tier: acpi/hmat: create
 CPUless memory tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=horenchuang@bytedance.com; helo=mail-ua1-x92e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Sun, Mar 3, 2024 at 6:42=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> Hi, Jack,
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > * Introduce `mt_init_with_hmat()`
> > We defer memory tier initialization for those CPUless NUMA nodes
> > until acquiring HMAT info. `mt_init_with_hmat()` is introduced to
> > post-create CPUless memory tiers after obtaining HMAT info.
> > It iterates through each CPUless memory node, creating memory tiers if
> > necessary. Finally, it calculates demotion tables again at the end.
> >
> > * Introduce `hmat_find_alloc_memory_type()`
> > Find or allocate a memory type in the `hmat_memory_types` list.
> >
> > * Make `set_node_memory_tier()` more generic
> > This function can also be used for setting other memory types for a nod=
e.
> > To do so, a new argument is added to specify a memory type.
> >
> > * Handle cases where there is no HMAT when creating memory tiers
> > If no HMAT is specified, it falls back to using `default_dram_type`.
> >
> > * Change adist calculation code to use another new lock, mt_perf_lock.
> > Iterating through CPUlist nodes requires holding the `memory_tier_lock`=
.
> > However, `mt_calc_adistance()` will end up trying to acquire the same l=
ock,
> > leading to a potential deadlock. Therefore, we propose introducing a
> > standalone `mt_perf_lock` to protect `default_dram_perf`. This approach=
 not
> > only avoids deadlock but also prevents holding a large lock simultaneou=
sly.
>
> The patch description is used to described why we need the change, and
> how we do that, but not what we do.  People can tell what is done from
> the code itself.
>

Got it. Thanks. Will rewrite it after the code is finalized.

> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> > ---
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index d6b85f0f6082..9f57338b3cb5 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -1038,6 +1038,9 @@ static __init int hmat_init(void)
> >       if (!hmat_set_default_dram_perf())
> >               register_mt_adistance_algorithm(&hmat_adist_nb);
> >
> > +     /* Post-create CPUless memory tiers after getting HMAT info */
> > +     mt_init_with_hmat();
> > +
> >       return 0;
> >  out_put:
> >       hmat_free_structures();
> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index 69e781900082..2f845e90c033 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source);
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> > +void mt_init_with_hmat(void);
>
> HMAT isn't universally available.  It's a driver in fact.  So, don't put
> driver specific code in general code.
>

Please see below regarding "move code to hmat.c"

> >  #ifdef CONFIG_MIGRATION
> >  int next_demotion_node(int node);
> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> > @@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct acce=
ss_coordinate *perf, int *adis
> >  {
> >       return -EIO;
> >  }
> > +
> > +static inline void mt_init_with_hmat(void)
> > +{
> > +
> > +}
> >  #endif       /* CONFIG_NUMA */
> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 0537664620e5..7a0a579b3deb 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -35,7 +35,9 @@ struct node_memory_type_map {
> >  };
> >
> >  static DEFINE_MUTEX(memory_tier_lock);
> > +static DEFINE_MUTEX(mt_perf_lock);
> >  static LIST_HEAD(memory_tiers);
> > +static LIST_HEAD(hmat_memory_types);
> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> >  struct memory_dev_type *default_dram_type;
> >
> > @@ -502,7 +504,7 @@ static inline void __init_node_memory_type(int node=
, struct memory_dev_type *mem
> >       }
> >  }
> >
> > -static struct memory_tier *set_node_memory_tier(int node)
> > +static struct memory_tier *set_node_memory_tier(int node, struct memor=
y_dev_type *new_memtype)
>
> No. memory_dev_type are passed to the function via node_memory_types[node=
].memtype.
>

Got it. Will mimic the way kmem.c does. Thanks.

> >  {
> >       struct memory_tier *memtier;
> >       struct memory_dev_type *memtype;
> > @@ -514,7 +516,7 @@ static struct memory_tier *set_node_memory_tier(int=
 node)
> >       if (!node_state(node, N_MEMORY))
> >               return ERR_PTR(-EINVAL);
> >
> > -     __init_node_memory_type(node, default_dram_type);
> > +     __init_node_memory_type(node, new_memtype);
> >
> >       memtype =3D node_memory_types[node].memtype;
> >       node_set(node, memtype->nodes);
> > @@ -623,6 +625,56 @@ void clear_node_memory_type(int node, struct memor=
y_dev_type *memtype)
> >  }
> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >
> > +static struct memory_dev_type *hmat_find_alloc_memory_type(int adist)
>
> Similar function existed in drivers/dax/kmem.c.  Please abstract them
> and move them here.
>

Got it. Will try. Thanks.

> > +{
> > +     bool found =3D false;
> > +     struct memory_dev_type *mtype;
> > +
> > +     list_for_each_entry(mtype, &hmat_memory_types, list) {
> > +             if (mtype->adistance =3D=3D adist) {
> > +                     found =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     if (!found) {
> > +             mtype =3D alloc_memory_type(adist);
> > +             if (!IS_ERR(mtype))
> > +                     list_add(&mtype->list, &hmat_memory_types);
> > +     }
> > +     return mtype;
> > +}
> > +
> > +static void mt_create_with_hmat(int node)
> > +{
> > +     struct memory_dev_type *mtype =3D NULL;
> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> > +
> > +     mt_calc_adistance(node, &adist);
> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
> > +             mtype =3D hmat_find_alloc_memory_type(adist);
> > +             if (IS_ERR(mtype))
> > +                     pr_err("%s() failed to allocate a tier\n", __func=
__);
> > +     } else {
> > +             mtype =3D default_dram_type;
> > +     }
> > +
> > +     set_node_memory_tier(node, mtype);
> > +}
> > +
> > +void mt_init_with_hmat(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (!node_state(nid, N_CPU))
> > +                     mt_create_with_hmat(nid);
> > +
> > +     establish_demotion_targets();
> > +     mutex_unlock(&memory_tier_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(mt_init_with_hmat);
> > +
>
> I guess that we can put most hmat related code above in hmat.c.
>

To put the heat-related code to hmat.c I will need to export some
static functions in memory-tiers.c, like set_node_memory_tier() and
establish_demotion_targets(). Is that ok?

> >  static void dump_hmem_attrs(struct access_coordinate *coord, const cha=
r *prefix)
> >  {
> >       pr_info(
> > @@ -636,7 +688,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >  {
> >       int rc =3D 0;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&mt_perf_lock);
> >       if (default_dram_perf_error) {
> >               rc =3D -EIO;
> >               goto out;
> > @@ -684,7 +736,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >       }
> >
> >  out:
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&mt_perf_lock);
> >       return rc;
> >  }
> >
> > @@ -700,7 +752,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
perf, int *adist)
> >           perf->read_bandwidth + perf->write_bandwidth =3D=3D 0)
> >               return -EINVAL;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&mt_perf_lock);
> >       /*
> >        * The abstract distance of a memory node is in direct proportion=
 to
> >        * its memory latency (read + write) and inversely proportional t=
o its
> > @@ -713,7 +765,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
perf, int *adist)
> >               (default_dram_perf.read_latency + default_dram_perf.write=
_latency) *
> >               (default_dram_perf.read_bandwidth + default_dram_perf.wri=
te_bandwidth) /
> >               (perf->read_bandwidth + perf->write_bandwidth);
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&mt_perf_lock);
> >
> >       return 0;
> >  }
> > @@ -797,7 +849,7 @@ static int __meminit memtier_hotplug_callback(struc=
t notifier_block *self,
> >               break;
> >       case MEM_ONLINE:
> >               mutex_lock(&memory_tier_lock);
> > -             memtier =3D set_node_memory_tier(arg->status_change_nid);
> > +             memtier =3D set_node_memory_tier(arg->status_change_nid, =
default_dram_type);
> >               if (!IS_ERR(memtier))
> >                       establish_demotion_targets();
> >               mutex_unlock(&memory_tier_lock);
> > @@ -836,7 +888,15 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > -             memtier =3D set_node_memory_tier(node);
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on CPUless nu=
ma nodes.
> > +                      * These will be initialized when HMAT informatio=
n is
> > +                      * available.
> > +                      */
> > +                     continue;
> > +
> > +             memtier =3D set_node_memory_tier(node, default_dram_type)=
;
>
> On system with HMAT, how to fall back CPU-less node to
> default_dram_type?  I found your description, but I don't find it in code=
.
>

I assume you meant without HMAT, if so,
because if no HMAT, adist will not be updated in mt_calc_adistance():
+ int adist =3D MEMTIER_ADISTANCE_DRAM;
+
+ mt_calc_adistance(node, &adist);
+ if (adist !=3D MEMTIER_ADISTANCE_DRAM) {
=E2=80=A6
+ } else {
+ mtype =3D default_dram_type;
+ }
+
+ set_node_memory_tier(node, mtype);

> >               if (IS_ERR(memtier))
> >                       /*
> >                        * Continue with memtiers we are able to setup
>
> --
> Best Regards,
> Huang, Ying
--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

