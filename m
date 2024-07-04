Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F62C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPHLq-0003Qj-0z; Thu, 04 Jul 2024 03:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1sPHLn-0003Nq-Bh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 03:57:55 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1sPHLj-0003nD-I5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 03:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720079872; x=1751615872;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=+nlEZm29FY0yjN+onfpT9t6OyQeU1Kx/26D0jQA3u8A=;
 b=SxYFBOd/Bz0wSaQZQoyAb8buqQigKKmmXMcAwTB9YKLacwBvYClJ+zcp
 5ugSISI7Erz1oYOUX7hDa181lBHQM/wv/+cudcC0h5qylJP5w9lqsW9Oj
 81/iNESow+l1dReZsf8VJtsB1X6B9FaaNzSUciq/sMapApfEefAUVkXBW
 acCnGPVU3yOi89E5ipDAQXvO3QDOwzELlx0tPXgP6n45L+icd1qQCTHaD
 ABbkc8Zf88L/H3MFWo7s9GacQ057xoP8z+0/pgDRapfdLb81vpTFxG97Q
 YhU26yQV3oR/eC2z8dyo3Q7DzIYojCSZhVtrmPi62aDXRkTW0fEDTdifM g==;
X-CSE-ConnectionGUID: 2h9IJIQcTDqXUMiwI2m8fg==
X-CSE-MsgGUID: nS1eSz+9QUCc4k2XFwTMyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17484926"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="17484926"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 00:57:40 -0700
X-CSE-ConnectionGUID: zZCUaaKITQGaYrZ7AzctJg==
X-CSE-MsgGUID: 2WZ2FzmURDqjsTbeqHjHSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800"; d="scan'208";a="46932661"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com)
 ([10.238.208.55])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 00:57:30 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev>
Cc: "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,  "Gregory Price"
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
 mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  "Eishan Mirakhur"
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,  "Srinivasulu Thanneeru"
 <sthanneeru@micron.com>,  "SeongJae Park" <sj@kernel.org>,  "Rafael J.
 Wysocki" <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@bytedance.com>,  "Ho-Ren (Jack) Chuang"
 <horenchuang@gmail.com>,  linux-cxl@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] memory tier: consolidate the initialization of
 memory tiers
In-Reply-To: <20240704072646.437579-1-horen.chuang@linux.dev> (Ho-Ren Chuang's
 message of "Thu, 4 Jul 2024 07:26:44 +0000")
References: <20240704072646.437579-1-horen.chuang@linux.dev>
Date: Thu, 04 Jul 2024 15:55:39 +0800
Message-ID: <87tth5h9qc.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=198.175.65.18; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

"Ho-Ren (Jack) Chuang" <horen.chuang@linux.dev> writes:

> The current memory tier initialization process is distributed across
> two different functions, memory_tier_init() and memory_tier_late_init().
> This design is hard to maintain. Thus, this patch is proposed to reduce
> the possible code paths by consolidating different
> initialization patches into one.
>
> The earlier discussion with Jonathan and Ying is listed here:
> https://lore.kernel.org/lkml/20240405150244.00004b49@Huawei.com/
>
> If we want to put these two initializations together, they must be
> placed together in the later function. Because only at that time,
> the HMAT information will be ready, adist between nodes can be
> calculated, and memory tiering can be established based on the adist.
> So we position the initialization at memory_tier_init() to the
> memory_tier_late_init() call. Moreover, it's natural to keep
> memory_tier initialization in drivers at device_initcall() level.
>
> If we simply move the set_node_memory_tier() from memory_tier_init()
> to late_initcall(), it will result in HMAT not registering
> the mt_adistance_algorithm callback function, because
> set_node_memory_tier() is not performed during the memory tiering
> initialization phase, leading to a lack of correct default_dram
> information.
>
> Therefore, we introduced a nodemask to pass the information of the
> default DRAM nodes. The reason for not choosing to reuse
> default_dram_type->nodes is that it is not clean enough. So in the end,
> we use a __initdata variable, which is a variable that is released once
> initialization is complete, including both CPU and memory nodes for HMAT
> to iterate through.
>
> This patchset is based on commits <cf93be18fa1b> ("memory tier: create
> CPUless memory tiers after obtaining HMAT info") and
> <a72a30af550c> ("memory tier: dax/kmem: introduce an abstract layer for
> finding, allocating, and putting memory types"):
> [0/2] https://lkml.kernel.org/r/20240405000707.2670063-1-horenchuang@bytedance.com
> [1/2] https://lkml.kernel.org/r/20240405000707.2670063-2-horenchuang@bytedance.com
> [1/2] https://lkml.kernel.org/r/20240405000707.2670063-3-horenchuang@bytedance.com
>
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
> - v3:
>  * Combine the cover letter and the patch.
>  * Remove extern default_dram_type
>  * Remove __initdata in a extern variable
>  * Roll back coding style, fix comment description
> - v2:
>  Thanks to Huang, Ying's and Andrew's comments
>  * Add a cover letter
>  * Add Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  * Add get/put_online_mems() protection in memory_tier_late_init()
>  * If memtype is set, skip initializing its node
>  * Remove redundant code/comments or rewrite code in a cleaner manner
>  * https://lore.kernel.org/all/20240628060925.303309-1-horen.chuang@linux.dev/
> - v1:
>  * https://lore.kernel.org/all/20240621044833.3953055-1-horen.chuang@linux.dev/
>
> - Open to discussion:
>  * Should we use `continue` or `break` if set_node_memory_tier() fails in
>    memory_tier_late_init()? I've changed it to `continue` in v3.
>  * Compute the default_dram_nodes mask in hmat when needed? Currently,
>    it still remains in memory-tiers.c
>  * Instead of using guard(mutex)(), use mutex_lock() as it was to make a
>    cleaner diff?
>
> Thanks,
> Ho-Ren (Jack) Chuang
>
>  drivers/acpi/numa/hmat.c     |  5 +---
>  include/linux/memory-tiers.h |  2 ++
>  mm/memory-tiers.c            | 54 ++++++++++++++----------------------
>  3 files changed, 24 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c8ccc91ebe6..a2f9e7a4b479 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -940,10 +940,7 @@ static int hmat_set_default_dram_perf(void)
>  	struct memory_target *target;
>  	struct access_coordinate *attrs;
>  
> -	if (!default_dram_type)
> -		return -EIO;
> -
> -	for_each_node_mask(nid, default_dram_type->nodes) {
> +	for_each_node_mask(nid, default_dram_nodes) {
>  		pxm = node_to_pxm(nid);
>  		target = find_mem_target(pxm);
>  		if (!target)
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 0d70788558f4..0dc0cf2863e2 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -38,6 +38,7 @@ struct access_coordinate;
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
>  extern struct memory_dev_type *default_dram_type;
> +extern nodemask_t default_dram_nodes;
>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void put_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -76,6 +77,7 @@ static inline bool node_is_toptier(int node)
>  
>  #define numa_demotion_enabled	false
>  #define default_dram_type	NULL
> +#define default_dram_nodes	NODE_MASK_NONE
>  /*
>   * CONFIG_NUMA implementation returns non NULL error.
>   */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 6632102bd5c9..4775b3a3dabe 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -43,6 +43,7 @@ static LIST_HEAD(memory_tiers);
>  static LIST_HEAD(default_memory_types);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  struct memory_dev_type *default_dram_type;
> +nodemask_t default_dram_nodes __initdata = NODE_MASK_NONE;
>  
>  static const struct bus_type memory_tier_subsys = {
>  	.name = "memory_tiering",
> @@ -671,28 +672,35 @@ EXPORT_SYMBOL_GPL(mt_put_memory_types);
>  
>  /*
>   * This is invoked via `late_initcall()` to initialize memory tiers for
> - * CPU-less memory nodes after driver initialization, which is
> - * expected to provide `adistance` algorithms.
> + * memory nodes, both with and without CPUs. After the initialization of
> + * firmware and devices, adistance algorithms are expected to be provided.
>   */
>  static int __init memory_tier_late_init(void)
>  {
>  	int nid;
> +	struct memory_tier *memtier;
>  
> +	get_online_mems();
>  	guard(mutex)(&memory_tier_lock);
> +
> +	/* Assign each uninitialized N_MEMORY node to a memory tier. */
>  	for_each_node_state(nid, N_MEMORY) {
>  		/*
> -		 * Some device drivers may have initialized memory tiers
> -		 * between `memory_tier_init()` and `memory_tier_late_init()`,
> -		 * potentially bringing online memory nodes and
> -		 * configuring memory tiers. Exclude them here.
> +		 * Some device drivers may have initialized
> +		 * memory tiers, potentially bringing memory nodes
> +		 * online and configuring memory tiers.
> +		 * Exclude them here.
>  		 */
>  		if (node_memory_types[nid].memtype)
>  			continue;
>  
> -		set_node_memory_tier(nid);
> +		memtier = set_node_memory_tier(nid);
> +		if (IS_ERR(memtier))
> +			continue;
>  	}
>  
>  	establish_demotion_targets();
> +	put_online_mems();
>  
>  	return 0;
>  }
> @@ -875,8 +883,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  
>  static int __init memory_tier_init(void)
>  {
> -	int ret, node;
> -	struct memory_tier *memtier;
> +	int ret;
>  
>  	ret = subsys_virtual_register(&memory_tier_subsys, NULL);
>  	if (ret)
> @@ -887,7 +894,8 @@ static int __init memory_tier_init(void)
>  				GFP_KERNEL);
>  	WARN_ON(!node_demotion);
>  #endif
> -	mutex_lock(&memory_tier_lock);
> +
> +	guard(mutex)(&memory_tier_lock);
>  	/*
>  	 * For now we can have 4 faster memory tiers with smaller adistance
>  	 * than default DRAM tier.
> @@ -897,29 +905,9 @@ static int __init memory_tier_init(void)
>  	if (IS_ERR(default_dram_type))
>  		panic("%s() failed to allocate default DRAM tier\n", __func__);
>  
> -	/*
> -	 * Look at all the existing N_MEMORY nodes and add them to
> -	 * default memory tier or to a tier if we already have memory
> -	 * types assigned.
> -	 */
> -	for_each_node_state(node, N_MEMORY) {
> -		if (!node_state(node, N_CPU))
> -			/*
> -			 * Defer memory tier initialization on
> -			 * CPUless numa nodes. These will be initialized
> -			 * after firmware and devices are initialized.
> -			 */
> -			continue;
> -
> -		memtier = set_node_memory_tier(node);
> -		if (IS_ERR(memtier))
> -			/*
> -			 * Continue with memtiers we are able to setup
> -			 */
> -			break;
> -	}
> -	establish_demotion_targets();
> -	mutex_unlock(&memory_tier_lock);
> +	/* Record nodes with memory and CPU to set default DRAM performance. */
> +	nodes_and(default_dram_nodes, node_states[N_MEMORY],
> +		  node_states[N_CPU]);
>  
>  	hotplug_memory_notifier(memtier_hotplug_callback, MEMTIER_HOTPLUG_PRI);
>  	return 0;

