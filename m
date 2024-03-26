Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B4EC54E64
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 03:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roxAo-0004i5-A5; Mon, 25 Mar 2024 23:08:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1roxAl-0004hN-Hk
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 23:08:23 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1roxAg-0008G3-Fv
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 23:08:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711422499; x=1742958499;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version:content-transfer-encoding;
 bh=tshkDg+57nZGbKKTGrPpvXEl1QS5OIzpwMeGxbRpWlQ=;
 b=lKVl+Lv/0crgLxT+NkkEl9M/G76u6gYStLT2Is714fo+2WrZrMEbXxoF
 T7JQyoGLxsJV1mkr2dxUgd0zlMt2qNS4OKGS28a/xhPIDUaWnNQNq7CDY
 jWpMoTsR2q7/Ll7UiA4KKj5LUcgARa5ZwdRLbdls8cgL75scwHZD+Pb/k
 BcDAf8tSIZGgBv2P0SiiwRtmZwkivUI45iDuU7W59gV96FO2PEHyLFl+l
 NIWRkXXRTUt0o+p0DdZW6VVlS4JENqRJudLNu4jneWQxW5WQNPTXVAfy3
 fB4/nkthazTv74wqw852BaIkfjFsugXXELBtsqeoCmn9MNjbP09nVDTGC A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17089232"
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; d="scan'208";a="17089232"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 20:08:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,155,1708416000"; d="scan'208";a="15695641"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2024 20:08:07 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: Gregory Price <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
 mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  Eishan Mirakhur
 <emirakhur@micron.com>,  Vinicius Tavares Petrucci
 <vtavarespetr@micron.com>,  Ravis OpenSrc <Ravis.OpenSrc@micron.com>,
 Alistair Popple <apopple@nvidia.com>,  Srinivasulu Thanneeru
 <sthanneeru@micron.com>,  Dan Williams <dan.j.williams@intel.com>,  Vishal
 Verma <vishal.l.verma@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,  nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,  "Ho-Ren
 (Jack) Chuang" <horenchuang@gmail.com>,  qemu-devel@nongnu.org,  Hao Xiang
 <hao.xiang@bytedance.com>
Subject: Re: [External] Re: [PATCH v4 2/2] memory tier: create CPUless
 memory tiers after obtaining HMAT info
In-Reply-To: <CAKPbEqptUKhDdH0ke7PuFShTBFm-Y=NWDtMOWCXBQBe-mac88w@mail.gmail.com>
 (Ho-Ren Chuang's message of "Fri, 22 Mar 2024 11:26:33 -0700")
References: <20240322070356.315922-1-horenchuang@bytedance.com>
 <20240322070356.315922-3-horenchuang@bytedance.com>
 <87cyrmr773.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAKPbEqptUKhDdH0ke7PuFShTBFm-Y=NWDtMOWCXBQBe-mac88w@mail.gmail.com>
Date: Tue, 26 Mar 2024 11:06:13 +0800
Message-ID: <87ttktofoa.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=192.198.163.11; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> On Fri, Mar 22, 2024 at 1:41=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>>
>> > The current implementation treats emulated memory devices, such as
>> > CXL1.1 type3 memory, as normal DRAM when they are emulated as normal m=
emory
>> > (E820_TYPE_RAM). However, these emulated devices have different
>> > characteristics than traditional DRAM, making it important to
>> > distinguish them. Thus, we modify the tiered memory initialization pro=
cess
>> > to introduce a delay specifically for CPUless NUMA nodes. This delay
>> > ensures that the memory tier initialization for these nodes is deferred
>> > until HMAT information is obtained during the boot process. Finally,
>> > demotion tables are recalculated at the end.
>> >
>> > * late_initcall(memory_tier_late_init);
>> > Some device drivers may have initialized memory tiers between
>> > `memory_tier_init()` and `memory_tier_late_init()`, potentially bringi=
ng
>> > online memory nodes and configuring memory tiers. They should be exclu=
ded
>> > in the late init.
>> >
>> > * Handle cases where there is no HMAT when creating memory tiers
>> > There is a scenario where a CPUless node does not provide HMAT informa=
tion.
>> > If no HMAT is specified, it falls back to using the default DRAM tier.
>> >
>> > * Introduce another new lock `default_dram_perf_lock` for adist calcul=
ation
>> > In the current implementation, iterating through CPUlist nodes requires
>> > holding the `memory_tier_lock`. However, `mt_calc_adistance()` will en=
d up
>> > trying to acquire the same lock, leading to a potential deadlock.
>> > Therefore, we propose introducing a standalone `default_dram_perf_lock=
` to
>> > protect `default_dram_perf_*`. This approach not only avoids deadlock
>> > but also prevents holding a large lock simultaneously.
>> >
>> > * Upgrade `set_node_memory_tier` to support additional cases, including
>> >   default DRAM, late CPUless, and hot-plugged initializations.
>> > To cover hot-plugged memory nodes, `mt_calc_adistance()` and
>> > `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` =
to
>> > handle cases where memtype is not initialized and where HMAT informati=
on is
>> > available.
>> >
>> > * Introduce `default_memory_types` for those memory types that are not
>> >   initialized by device drivers.
>> > Because late initialized memory and default DRAM memory need to be man=
aged,
>> > a default memory type is created for storing all memory types that are
>> > not initialized by device drivers and as a fallback.
>> >
>> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
>> > Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
>> > ---
>> >  mm/memory-tiers.c | 73 ++++++++++++++++++++++++++++++++++++++++-------
>> >  1 file changed, 63 insertions(+), 10 deletions(-)
>> >
>> > diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> > index 974af10cfdd8..9396330fa162 100644
>> > --- a/mm/memory-tiers.c
>> > +++ b/mm/memory-tiers.c
>> > @@ -36,6 +36,11 @@ struct node_memory_type_map {
>> >
>> >  static DEFINE_MUTEX(memory_tier_lock);
>> >  static LIST_HEAD(memory_tiers);
>> > +/*
>> > + * The list is used to store all memory types that are not created
>> > + * by a device driver.
>> > + */
>> > +static LIST_HEAD(default_memory_types);
>> >  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>> >  struct memory_dev_type *default_dram_type;
>> >
>> > @@ -108,6 +113,7 @@ static struct demotion_nodes *node_demotion __read=
_mostly;
>> >
>> >  static BLOCKING_NOTIFIER_HEAD(mt_adistance_algorithms);
>> >
>> > +static DEFINE_MUTEX(default_dram_perf_lock);
>>
>> Better to add comments about what is protected by this lock.
>>
>
> Thank you. I will add a comment like this:
> + /* The lock is used to protect `default_dram_perf*` info and nid. */
> +static DEFINE_MUTEX(default_dram_perf_lock);
>
> I also found an error path was not handled and
> found the lock could be put closer to what it protects.
> I will have them fixed in V5.
>
>> >  static bool default_dram_perf_error;
>> >  static struct access_coordinate default_dram_perf;
>> >  static int default_dram_perf_ref_nid =3D NUMA_NO_NODE;
>> > @@ -505,7 +511,8 @@ static inline void __init_node_memory_type(int nod=
e, struct memory_dev_type *mem
>> >  static struct memory_tier *set_node_memory_tier(int node)
>> >  {
>> >       struct memory_tier *memtier;
>> > -     struct memory_dev_type *memtype;
>> > +     struct memory_dev_type *mtype;
>>
>> mtype may be referenced without initialization now below.
>>
>
> Good catch! Thank you.
>
> Please check below.
> I may found a potential NULL pointer dereference.
>
>> > +     int adist =3D MEMTIER_ADISTANCE_DRAM;
>> >       pg_data_t *pgdat =3D NODE_DATA(node);
>> >
>> >
>> > @@ -514,11 +521,20 @@ static struct memory_tier *set_node_memory_tier(=
int node)
>> >       if (!node_state(node, N_MEMORY))
>> >               return ERR_PTR(-EINVAL);
>> >
>> > -     __init_node_memory_type(node, default_dram_type);
>> > +     mt_calc_adistance(node, &adist);
>> > +     if (node_memory_types[node].memtype =3D=3D NULL) {
>> > +             mtype =3D mt_find_alloc_memory_type(adist, &default_memo=
ry_types);
>> > +             if (IS_ERR(mtype)) {
>> > +                     mtype =3D default_dram_type;
>> > +                     pr_info("Failed to allocate a memory type. Fall =
back.\n");
>> > +             }
>> > +     }
>> >
>> > -     memtype =3D node_memory_types[node].memtype;
>> > -     node_set(node, memtype->nodes);
>> > -     memtier =3D find_create_memory_tier(memtype);
>> > +     __init_node_memory_type(node, mtype);
>> > +
>> > +     mtype =3D node_memory_types[node].memtype;
>> > +     node_set(node, mtype->nodes);
>
> If the `mtype` could be NULL, would there be a potential
> NULL pointer dereference. Do you have a preferred idea
> to fix this if needed?

Initialize mtype with default_dram_type?

>> > +     memtier =3D find_create_memory_tier(mtype);
>> >       if (!IS_ERR(memtier))
>> >               rcu_assign_pointer(pgdat->memtier, memtier);
>> >       return memtier;
>> > @@ -655,6 +671,34 @@ void mt_put_memory_types(struct list_head *memory=
_types)
>> >  }
>> >  EXPORT_SYMBOL_GPL(mt_put_memory_types);
>> >

[snip]

--
Best Regards,
Huang, Ying

