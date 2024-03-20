Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46018C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 23:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn5MF-00016d-9g; Wed, 20 Mar 2024 19:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rn5MC-00016D-Sa
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 19:28:28 -0400
Received: from mail-yb1-xb33.google.com ([2607:f8b0:4864:20::b33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rn5Lz-00070z-HG
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 19:28:28 -0400
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so327698276.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 16:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1710977291; x=1711582091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJzBq5JYuB2XAGJ0KALCMa2K2ac89AEZaVfd/fyT9P0=;
 b=Tokzkw+cLTaltMHI3tZlm1fw48xon8QRngujuBxidiA7BHJlroHszQTfF/C4tE5XF9
 vpKxtTRBJjIbIMmSioEaXa4w/F3wiR2wwLugN1v20OwfVPW1vpvO4heoOHjSPQ9Plfq/
 Hn91UUohy1vc96J4ottYKwn7k72OkY8ljTGsZxOnMThu/diglkrQvAw0PBhaCJuOCr1H
 x4H7cItgCqUi03wiT5EVNY/JG7zsl6f3K5RF2IhM5LPCExVBWTkfKYfPBx/jHQJ654IY
 pjPpDIuKiQSjvv5T93Y+AVfyTmxJgxtEwEF0Wp+j1getN7OHO0jxVp3wTc5vHi9glzgc
 rafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710977291; x=1711582091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zJzBq5JYuB2XAGJ0KALCMa2K2ac89AEZaVfd/fyT9P0=;
 b=eOduTGw3X0qY1LmILFE02pnmQDxvnisgbGJeYkl37hsneN4nnNsSe+Iyfka8c/q2Nl
 kcJ9IrcjmKRloAeyxHYh4E8aN8iQCVL4lGDBrhXsr7w6Ld+rMEXM1T1O8MF4nhMmgXBd
 bJ16qG0roTUspWgoBRjucsRs8wKukqykWxKmsT0GxrvLsfNU7qFMCU32ckkLMxl0sQ/W
 Cy0W9/JCOJk89VxQsy1W5i7IU/Olg9KHBsTz/VYftyITqs9TeBLmNMj2imB4KV6iFE6L
 38m7KOPhFQg9xwzGfiZGGzcQaGQt/Nt9ul2py5m6PMNN4iMQFA8Eb6zUsUYSp0n7pTbb
 b46w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIIhWbiad2KgLwhgHy7y2ur90BxxlC4eHNCBbwtOLzyu0wqv0RFUp8leYW23RMm0TOgoVdkibzmTlKX9I3G1VqYfogGUk=
X-Gm-Message-State: AOJu0Yyq8a4DoJUiz70q4n6FDO04ybDRSIE4V9dBbgNwEl1+lYhc+PGi
 IiSoLBqoXWpc5jnifS6CRLQx/a1rZecquZ34RDEGCuV+pHEnqNL5wPVI2Y07DXzReye1wyib+la
 WT+lP9szH77CzP0mdwjEIp3Lqe2vBui+AfWevvQ==
X-Google-Smtp-Source: AGHT+IFGJliSrDOUQ4ErqYoYgEzAjB2StnHNHTXjgXve2MnBnRyAPXbxRVaPnc6fOZEVfVxO8SzIJ0MjV2hraKOtNuk=
X-Received: by 2002:a25:fe03:0:b0:dd1:517b:571d with SMTP id
 k3-20020a25fe03000000b00dd1517b571dmr314816ybe.16.1710977290644; Wed, 20 Mar
 2024 16:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240320061041.3246828-1-horenchuang@bytedance.com>
 <20240320061041.3246828-2-horenchuang@bytedance.com>
 <87edc5s7ea.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87edc5s7ea.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Wed, 20 Mar 2024 16:27:59 -0700
Message-ID: <CAKPbEqrfdJwHCuc9yvSBXa2jR-KwXwaa-dFD6iMmXT_OiweYmg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 1/2] memory tier: dax/kmem: create
 CPUless memory tiers after obtaining HMAT info
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dave Jiang <dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>,
 nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org, 
 Hao Xiang <hao.xiang@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b33;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Mar 20, 2024 at 12:15=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
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
> > More details:
>
> You have done several stuff in one patch.  So you need "more details".
> You may separate them into multiple patches.  One for echo "*" below.
> But I have no strong opinion on that.
>
> > * late_initcall(memory_tier_late_init);
> > Some device drivers may have initialized memory tiers between
> > `memory_tier_init()` and `memory_tier_late_init()`, potentially bringin=
g
> > online memory nodes and configuring memory tiers. They should be exclud=
ed
> > in the late init.
> >
> > * Abstract common functions into `mt_find_alloc_memory_type()`
> > Since different memory devices require finding or allocating a memory t=
ype,
> > these common steps are abstracted into a single function,
> > `mt_find_alloc_memory_type()`, enhancing code scalability and concisene=
ss.
> >
> > * Handle cases where there is no HMAT when creating memory tiers
> > There is a scenario where a CPUless node does not provide HMAT informat=
ion.
> > If no HMAT is specified, it falls back to using the default DRAM tier.
> >
> > * Change adist calculation code to use another new lock, `mt_perf_lock`=
.
> > In the current implementation, iterating through CPUlist nodes requires
> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end=
 up
> > trying to acquire the same lock, leading to a potential deadlock.
> > Therefore, we propose introducing a standalone `mt_perf_lock` to protec=
t
> > `default_dram_perf`. This approach not only avoids deadlock but also
> > prevents holding a large lock simultaneously.
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
> > ---
> >  drivers/dax/kmem.c           | 13 +----
> >  include/linux/memory-tiers.h |  7 +++
> >  mm/memory-tiers.c            | 94 +++++++++++++++++++++++++++++++++---
> >  3 files changed, 95 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> > index 42ee360cf4e3..de1333aa7b3e 100644
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
> It seems that there's some miscommunication about my previous comments
> about this.  What I suggested is to create one separate patch, which
> moves mt_find_alloc_memory_type() and mt_put_memory_types() into
> memory-tiers.c.  And make this patch the first one of the series.
>

I will make mt_find_alloc/mt_put_memory_type changes as
a separate patch and the first of my patch series. Thanks.


> > diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.=
h
> > index 69e781900082..b2135334ac18 100644
> > --- a/include/linux/memory-tiers.h
> > +++ b/include/linux/memory-tiers.h
> > @@ -48,6 +48,8 @@ int mt_calc_adistance(int node, int *adist);
> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source);
> >  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> > +                                                     struct list_head =
*memory_types);
> >  #ifdef CONFIG_MIGRATION
> >  int next_demotion_node(int node);
> >  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> > @@ -136,5 +138,10 @@ static inline int mt_perf_to_adistance(struct acce=
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
> >  #endif       /* CONFIG_NUMA */
> >  #endif  /* _LINUX_MEMORY_TIERS_H */
> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> > index 0537664620e5..d9b96b21b65a 100644
> > --- a/mm/memory-tiers.c
> > +++ b/mm/memory-tiers.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/memory.h>
> >  #include <linux/memory-tiers.h>
> >  #include <linux/notifier.h>
> > +#include <linux/acpi.h>
>
> We don't need this anymore.
>

Thanks. I will remove it.

> >  #include "internal.h"
> >
> > @@ -36,6 +37,11 @@ struct node_memory_type_map {
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
> > @@ -505,7 +511,8 @@ static inline void __init_node_memory_type(int node=
, struct memory_dev_type *mem
> >  static struct memory_tier *set_node_memory_tier(int node)
> >  {
> >       struct memory_tier *memtier;
> > -     struct memory_dev_type *memtype;
> > +     struct memory_dev_type *memtype, *mtype =3D NULL;
>
> It seems unnecessary to introduce another variable, just use memtype?
>

Yes, I will consolidate them.


> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
> >       pg_data_t *pgdat =3D NODE_DATA(node);
> >
> >
> > @@ -514,7 +521,18 @@ static struct memory_tier *set_node_memory_tier(in=
t node)
> >       if (!node_state(node, N_MEMORY))
> >               return ERR_PTR(-EINVAL);
> >
> > -     __init_node_memory_type(node, default_dram_type);
> > +     mt_calc_adistance(node, &adist);
> > +     if (adist !=3D MEMTIER_ADISTANCE_DRAM &&
> > +                     node_memory_types[node].memtype =3D=3D NULL) {
> > +             mtype =3D mt_find_alloc_memory_type(adist, &default_memor=
y_types);
> > +             if (IS_ERR(mtype)) {
> > +                     mtype =3D default_dram_type;
> > +                     pr_info("Failed to allocate a memory type. Fall b=
ack.\n");
> > +             }
> > +     } else
> > +             mtype =3D default_dram_type;
>
> This can be simplified to
>
>         mt_calc_adistance(node, &adist);
>         if (node_memory_types[node].memtype =3D=3D NULL) {
>                 mtype =3D mt_find_alloc_memory_type(adist, &default_memor=
y_types);
>                 if (IS_ERR(mtype)) {
>                         mtype =3D default_dram_type;
>                         pr_info("Failed to allocate a memory type. Fall b=
ack.\n");
>                 }
>         }
>

Sounds good! I will do.


> > +     __init_node_memory_type(node, mtype);
> >
> >       memtype =3D node_memory_types[node].memtype;
> >       node_set(node, memtype->nodes);
> > @@ -623,6 +641,55 @@ void clear_node_memory_type(int node, struct memor=
y_dev_type *memtype)
> >  }
> >  EXPORT_SYMBOL_GPL(clear_node_memory_type);
> >
> > +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct li=
st_head *memory_types)
> > +{
> > +     bool found =3D false;
> > +     struct memory_dev_type *mtype;
> > +
> > +     list_for_each_entry(mtype, memory_types, list) {
> > +             if (mtype->adistance =3D=3D adist) {
> > +                     found =3D true;
> > +                     break;
> > +             }
> > +     }
> > +     if (!found) {
> > +             mtype =3D alloc_memory_type(adist);
> > +             if (!IS_ERR(mtype))
> > +                     list_add(&mtype->list, memory_types);
> > +     }
> > +
> > +     return mtype;
> > +}
> > +EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
> > +
> > +/*
> > + * This is invoked via late_initcall() to create
> > + * CPUless memory tiers after HMAT info is ready or
> > + * when there is no HMAT.
>
> Better to avoid HMAT in general code.  How about something as below?
>
> This is invoked via late_initcall() to initialize memory tiers for
> CPU-less memory nodes after drivers initialization.  Which is
> expect to provide adistance algorithms.
>

Got it. Thanks.
"
This is invoked via `late_initcall()` to initialize memory tiers for
CPU-less memory nodes after driver initialization, which is
expected to provide `adistance` algorithms.
"


> > + */
> > +static int __init memory_tier_late_init(void)
> > +{
> > +     int nid;
> > +
> > +     mutex_lock(&memory_tier_lock);
> > +     for_each_node_state(nid, N_MEMORY)
> > +             if (!node_state(nid, N_CPU) &&
> > +                     node_memory_types[nid].memtype =3D=3D NULL)
> > +                     /*
> > +                      * Some device drivers may have initialized memor=
y tiers
> > +                      * between `memory_tier_init()` and `memory_tier_=
late_init()`,
> > +                      * potentially bringing online memory nodes and
> > +                      * configuring memory tiers. Exclude them here.
> > +                      */
> > +                     set_node_memory_tier(nid);
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
> > @@ -631,12 +698,16 @@ static void dump_hmem_attrs(struct access_coordin=
ate *coord, const char *prefix)
> >               coord->read_bandwidth, coord->write_bandwidth);
> >  }
> >
> > +/*
> > + * The lock is used to protect the default_dram_perf.
> > + */
> > +static DEFINE_MUTEX(mt_perf_lock);
>
> Miscommunication here too.  Should be moved to near the
> "default_dram_perf" definition.  And it protects not only
> default_dram_perf.
>

I will move it closer to default_dram_perf*.
And change it to:
+/*
+ * The lock is used to protect default_dram_perf*.
+ */


> >  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
> >                            const char *source)
> >  {
> >       int rc =3D 0;
> >
> > -     mutex_lock(&memory_tier_lock);
> > +     mutex_lock(&mt_perf_lock);
> >       if (default_dram_perf_error) {
> >               rc =3D -EIO;
> >               goto out;
> > @@ -684,7 +755,7 @@ int mt_set_default_dram_perf(int nid, struct access=
_coordinate *perf,
> >       }
> >
> >  out:
> > -     mutex_unlock(&memory_tier_lock);
> > +     mutex_unlock(&mt_perf_lock);
> >       return rc;
> >  }
> >
> > @@ -700,7 +771,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
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
> > @@ -713,7 +784,7 @@ int mt_perf_to_adistance(struct access_coordinate *=
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
> > @@ -826,7 +897,8 @@ static int __init memory_tier_init(void)
> >        * For now we can have 4 faster memory tiers with smaller adistan=
ce
> >        * than default DRAM tier.
> >        */
> > -     default_dram_type =3D alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> > +     default_dram_type =3D mt_find_alloc_memory_type(
> > +                                     MEMTIER_ADISTANCE_DRAM, &default_=
memory_types);
> >       if (IS_ERR(default_dram_type))
> >               panic("%s() failed to allocate default DRAM tier\n", __fu=
nc__);
> >
> > @@ -836,6 +908,14 @@ static int __init memory_tier_init(void)
> >        * types assigned.
> >        */
> >       for_each_node_state(node, N_MEMORY) {
> > +             if (!node_state(node, N_CPU))
> > +                     /*
> > +                      * Defer memory tier initialization on CPUless nu=
ma nodes.
> > +                      * These will be initialized after firmware and d=
evices are
> > +                      * initialized.
> > +                      */
> > +                     continue;
> > +
> >               memtier =3D set_node_memory_tier(node);
> >               if (IS_ERR(memtier))
> >                       /*
>
> --
> Best Regards,
> Huang, Ying



--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

