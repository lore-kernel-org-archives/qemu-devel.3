Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7630CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:17:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqBS-0001uo-68; Wed, 20 Mar 2024 03:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rmqBQ-0001u2-1T
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:16:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rmqAp-0008LD-2f
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710918943; x=1742454943;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=dGANDLcgpPUgVShpcdJEWJFjwNSJyHiL6/yYzMvvXG8=;
 b=RLEcNi+3406wbi3VglO5n4wyn5CAIYUU8iThA6cao75atKc7Sn356igR
 jDMqho3TG2qZAw1qjQ6tAbZ907/jzGkmdlDefH70WeRWjsuHbAfk8zUpc
 kHTOvedexuPrQXpTeccWBAIH4hpQaCFld8Ov8XRnCEL9LT6X1f8Ar1acR
 oQDBi4RhdbyGT3sl3AmYSLuhXIVDCl5/L2l7Wgw7TD2ONMbbg50Zo0EnT
 1dD9A79PAIARb5RqxAuv1hHVNgFoxBqo8jpkZZB9Xp5GmfC3y3j/hLJYb
 /OdNf+iHKACtMW3uj4i/ecF5YqUbZjJa19jFjnn/5r+Z0xLCLfLnjPfUb A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5675057"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="5675057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 00:15:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; d="scan'208";a="18528664"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 00:15:10 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Gregory Price" <gourry.memverge@gmail.com>,
 aneesh.kumar@linux.ibm.com,  mhocko@suse.com,  tj@kernel.org,
 john@jagalactic.com,  "Eishan Mirakhur" <emirakhur@micron.com>,
 "Vinicius Tavares Petrucci" <vtavarespetr@micron.com>,  "Ravis OpenSrc"
 <Ravis.OpenSrc@micron.com>,  "Alistair Popple" <apopple@nvidia.com>,
 "Srinivasulu Thanneeru" <sthanneeru@micron.com>,  Dan Williams
 <dan.j.williams@intel.com>,  Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org,  linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,  "Ho-Ren
 (Jack) Chuang" <horenchuang@gmail.com>,  qemu-devel@nongnu.org,  Hao Xiang
 <hao.xiang@bytedance.com>
Subject: Re: [PATCH v3 1/2] memory tier: dax/kmem: create CPUless memory
 tiers after obtaining HMAT info
In-Reply-To: <20240320061041.3246828-2-horenchuang@bytedance.com> (Ho-Ren
 Chuang's message of "Wed, 20 Mar 2024 06:10:39 +0000")
References: <20240320061041.3246828-1-horenchuang@bytedance.com>
 <20240320061041.3246828-2-horenchuang@bytedance.com>
Date: Wed, 20 Mar 2024 15:13:17 +0800
Message-ID: <87edc5s7ea.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=192.198.163.19; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> The current implementation treats emulated memory devices, such as
> CXL1.1 type3 memory, as normal DRAM when they are emulated as normal memory
> (E820_TYPE_RAM). However, these emulated devices have different
> characteristics than traditional DRAM, making it important to
> distinguish them. Thus, we modify the tiered memory initialization process
> to introduce a delay specifically for CPUless NUMA nodes. This delay
> ensures that the memory tier initialization for these nodes is deferred
> until HMAT information is obtained during the boot process. Finally,
> demotion tables are recalculated at the end.
>
> More details:

You have done several stuff in one patch.  So you need "more details".
You may separate them into multiple patches.  One for echo "*" below.
But I have no strong opinion on that.

> * late_initcall(memory_tier_late_init);
> Some device drivers may have initialized memory tiers between
> `memory_tier_init()` and `memory_tier_late_init()`, potentially bringing
> online memory nodes and configuring memory tiers. They should be excluded
> in the late init.
>
> * Abstract common functions into `mt_find_alloc_memory_type()`
> Since different memory devices require finding or allocating a memory type,
> these common steps are abstracted into a single function,
> `mt_find_alloc_memory_type()`, enhancing code scalability and conciseness.
>
> * Handle cases where there is no HMAT when creating memory tiers
> There is a scenario where a CPUless node does not provide HMAT information.
> If no HMAT is specified, it falls back to using the default DRAM tier.
>
> * Change adist calculation code to use another new lock, `mt_perf_lock`.
> In the current implementation, iterating through CPUlist nodes requires
> holding the `memory_tier_lock`. However, `mt_calc_adistance()` will end up
> trying to acquire the same lock, leading to a potential deadlock.
> Therefore, we propose introducing a standalone `mt_perf_lock` to protect
> `default_dram_perf`. This approach not only avoids deadlock but also
> prevents holding a large lock simultaneously.
>
> * Upgrade `set_node_memory_tier` to support additional cases, including
>   default DRAM, late CPUless, and hot-plugged initializations.
> To cover hot-plugged memory nodes, `mt_calc_adistance()` and
> `mt_find_alloc_memory_type()` are moved into `set_node_memory_tier()` to
> handle cases where memtype is not initialized and where HMAT information is
> available.
>
> * Introduce `default_memory_types` for those memory types that are not
>   initialized by device drivers.
> Because late initialized memory and default DRAM memory need to be managed,
> a default memory type is created for storing all memory types that are
> not initialized by device drivers and as a fallback.
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  drivers/dax/kmem.c           | 13 +----
>  include/linux/memory-tiers.h |  7 +++
>  mm/memory-tiers.c            | 94 +++++++++++++++++++++++++++++++++---
>  3 files changed, 95 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 42ee360cf4e3..de1333aa7b3e 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -55,21 +55,10 @@ static LIST_HEAD(kmem_memory_types);
>  
>  static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
>  {
> -	bool found = false;
>  	struct memory_dev_type *mtype;
>  
>  	mutex_lock(&kmem_memory_type_lock);
> -	list_for_each_entry(mtype, &kmem_memory_types, list) {
> -		if (mtype->adistance == adist) {
> -			found = true;
> -			break;
> -		}
> -	}
> -	if (!found) {
> -		mtype = alloc_memory_type(adist);
> -		if (!IS_ERR(mtype))
> -			list_add(&mtype->list, &kmem_memory_types);
> -	}
> +	mtype = mt_find_alloc_memory_type(adist, &kmem_memory_types);
>  	mutex_unlock(&kmem_memory_type_lock);
>  
>  	return mtype;

It seems that there's some miscommunication about my previous comments
about this.  What I suggested is to create one separate patch, which
moves mt_find_alloc_memory_type() and mt_put_memory_types() into
memory-tiers.c.  And make this patch the first one of the series.

> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..b2135334ac18 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,8 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> +							struct list_head *memory_types);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +138,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	return NULL;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 0537664620e5..d9b96b21b65a 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -6,6 +6,7 @@
>  #include <linux/memory.h>
>  #include <linux/memory-tiers.h>
>  #include <linux/notifier.h>
> +#include <linux/acpi.h>

We don't need this anymore.

>  #include "internal.h"
>  
> @@ -36,6 +37,11 @@ struct node_memory_type_map {
>  
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
> +/*
> + * The list is used to store all memory types that are not created
> + * by a device driver.
> + */
> +static LIST_HEAD(default_memory_types);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  struct memory_dev_type *default_dram_type;
>  
> @@ -505,7 +511,8 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
>  static struct memory_tier *set_node_memory_tier(int node)
>  {
>  	struct memory_tier *memtier;
> -	struct memory_dev_type *memtype;
> +	struct memory_dev_type *memtype, *mtype = NULL;

It seems unnecessary to introduce another variable, just use memtype?

> +	int adist = MEMTIER_ADISTANCE_DRAM;
>  	pg_data_t *pgdat = NODE_DATA(node);
>  
>  
> @@ -514,7 +521,18 @@ static struct memory_tier *set_node_memory_tier(int node)
>  	if (!node_state(node, N_MEMORY))
>  		return ERR_PTR(-EINVAL);
>  
> -	__init_node_memory_type(node, default_dram_type);
> +	mt_calc_adistance(node, &adist);
> +	if (adist != MEMTIER_ADISTANCE_DRAM &&
> +			node_memory_types[node].memtype == NULL) {
> +		mtype = mt_find_alloc_memory_type(adist, &default_memory_types);
> +		if (IS_ERR(mtype)) {
> +			mtype = default_dram_type;
> +			pr_info("Failed to allocate a memory type. Fall back.\n");
> +		}
> +	} else
> +		mtype = default_dram_type;

This can be simplified to

	mt_calc_adistance(node, &adist);
	if (node_memory_types[node].memtype == NULL) {
		mtype = mt_find_alloc_memory_type(adist, &default_memory_types);
		if (IS_ERR(mtype)) {
			mtype = default_dram_type;
			pr_info("Failed to allocate a memory type. Fall back.\n");
		}
	}

> +	__init_node_memory_type(node, mtype);
>  
>  	memtype = node_memory_types[node].memtype;
>  	node_set(node, memtype->nodes);
> @@ -623,6 +641,55 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	list_for_each_entry(mtype, memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, memory_types);
> +	}
> +
> +	return mtype;
> +}
> +EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
> +
> +/*
> + * This is invoked via late_initcall() to create
> + * CPUless memory tiers after HMAT info is ready or
> + * when there is no HMAT.

Better to avoid HMAT in general code.  How about something as below?

This is invoked via late_initcall() to initialize memory tiers for
CPU-less memory nodes after drivers initialization.  Which is
expect to provide adistance algorithms.

> + */
> +static int __init memory_tier_late_init(void)
> +{
> +	int nid;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for_each_node_state(nid, N_MEMORY)
> +		if (!node_state(nid, N_CPU) &&
> +			node_memory_types[nid].memtype == NULL)
> +			/*
> +			 * Some device drivers may have initialized memory tiers
> +			 * between `memory_tier_init()` and `memory_tier_late_init()`,
> +			 * potentially bringing online memory nodes and
> +			 * configuring memory tiers. Exclude them here.
> +			 */
> +			set_node_memory_tier(nid);
> +
> +	establish_demotion_targets();
> +	mutex_unlock(&memory_tier_lock);
> +
> +	return 0;
> +}
> +late_initcall(memory_tier_late_init);
> +
>  static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  {
>  	pr_info(
> @@ -631,12 +698,16 @@ static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  		coord->read_bandwidth, coord->write_bandwidth);
>  }
>  
> +/*
> + * The lock is used to protect the default_dram_perf.
> + */
> +static DEFINE_MUTEX(mt_perf_lock);

Miscommunication here too.  Should be moved to near the
"default_dram_perf" definition.  And it protects not only
default_dram_perf.

>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source)
>  {
>  	int rc = 0;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&mt_perf_lock);
>  	if (default_dram_perf_error) {
>  		rc = -EIO;
>  		goto out;
> @@ -684,7 +755,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  	}
>  
>  out:
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&mt_perf_lock);
>  	return rc;
>  }
>  
> @@ -700,7 +771,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  	    perf->read_bandwidth + perf->write_bandwidth == 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&mt_perf_lock);
>  	/*
>  	 * The abstract distance of a memory node is in direct proportion to
>  	 * its memory latency (read + write) and inversely proportional to its
> @@ -713,7 +784,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
>  		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>  		(perf->read_bandwidth + perf->write_bandwidth);
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&mt_perf_lock);
>  
>  	return 0;
>  }
> @@ -826,7 +897,8 @@ static int __init memory_tier_init(void)
>  	 * For now we can have 4 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
>  	 */
> -	default_dram_type = alloc_memory_type(MEMTIER_ADISTANCE_DRAM);
> +	default_dram_type = mt_find_alloc_memory_type(
> +					MEMTIER_ADISTANCE_DRAM, &default_memory_types);
>  	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
> @@ -836,6 +908,14 @@ static int __init memory_tier_init(void)
>  	 * types assigned.
>  	 */
>  	for_each_node_state(node, N_MEMORY) {
> +		if (!node_state(node, N_CPU))
> +			/*
> +			 * Defer memory tier initialization on CPUless numa nodes.
> +			 * These will be initialized after firmware and devices are
> +			 * initialized.
> +			 */
> +			continue;
> +
>  		memtier = set_node_memory_tier(node);
>  		if (IS_ERR(memtier))
>  			/*

--
Best Regards,
Huang, Ying

