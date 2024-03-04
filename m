Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A11C5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 02:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgyHe-0005Qo-TV; Sun, 03 Mar 2024 21:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rgyHd-0005Qa-6D
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 21:42:29 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rgyHa-0005II-QG
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 21:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709520146; x=1741056146;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=p3rlpauy9CcC/96wXB/B3OYstONDXCGXsyOYQKXvKOw=;
 b=ms9Kh/wj+pGxdXw8mfPec+Sohl2aQDjqW28YfjW3vWcIOPnp+N7dSAhz
 BEgKzkUWQfpC9dpQMSNnoW8rCvL9LL4qMHo1lCqJ5Odn4lQ1NcwHuc2rt
 sOJRY6RYky5DcLNWT3BHLX7GLp22ce5LJnA7oIi0onpCysilirBi5gFqb
 YsCxnvLSqUF5Lyk8Ig8V8JEhnM29OQSbvsX3j6bFZ3asf40mkeu2DzBw3
 4yLHYdjFhXj0qF5+GJXjJyK//uFLwGjvDUEvJg6pXleuR0fE95WvCmVUX
 oD1uZHKxcYWB6iSjQDroCjGax+WHjP4fNtD8xZSbsw5RvrhPu1s2TbpL6 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="14706604"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="14706604"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 18:42:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="39839001"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 18:42:16 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Hao Xiang" <hao.xiang@bytedance.com>,  "Gregory Price"
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
 mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  "Eishan Mirakhur"
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v1 1/1] memory tier: acpi/hmat: create CPUless memory
 tiers after obtaining HMAT info
In-Reply-To: <20240301082248.3456086-2-horenchuang@bytedance.com> (Ho-Ren
 Chuang's message of "Fri, 1 Mar 2024 08:22:45 +0000")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <20240301082248.3456086-2-horenchuang@bytedance.com>
Date: Mon, 04 Mar 2024 10:40:22 +0800
Message-ID: <87jzmibtyh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=192.198.163.9; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi, Jack,

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> * Introduce `mt_init_with_hmat()`
> We defer memory tier initialization for those CPUless NUMA nodes
> until acquiring HMAT info. `mt_init_with_hmat()` is introduced to
> post-create CPUless memory tiers after obtaining HMAT info.
> It iterates through each CPUless memory node, creating memory tiers if
> necessary. Finally, it calculates demotion tables again at the end.
>
> * Introduce `hmat_find_alloc_memory_type()`
> Find or allocate a memory type in the `hmat_memory_types` list.
>
> * Make `set_node_memory_tier()` more generic
> This function can also be used for setting other memory types for a node.
> To do so, a new argument is added to specify a memory type.
>
> * Handle cases where there is no HMAT when creating memory tiers
> If no HMAT is specified, it falls back to using `default_dram_type`.
>
> * Change adist calculation code to use another new lock, mt_perf_lock.
> Iterating through CPUlist nodes requires holding the `memory_tier_lock`.
> However, `mt_calc_adistance()` will end up trying to acquire the same lock,
> leading to a potential deadlock. Therefore, we propose introducing a
> standalone `mt_perf_lock` to protect `default_dram_perf`. This approach not
> only avoids deadlock but also prevents holding a large lock simultaneously.

The patch description is used to described why we need the change, and
how we do that, but not what we do.  People can tell what is done from
the code itself.

> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
> ---
>  drivers/acpi/numa/hmat.c     |  3 ++
>  include/linux/memory-tiers.h |  6 +++
>  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>  3 files changed, 77 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index d6b85f0f6082..9f57338b3cb5 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -1038,6 +1038,9 @@ static __init int hmat_init(void)
>  	if (!hmat_set_default_dram_perf())
>  		register_mt_adistance_algorithm(&hmat_adist_nb);
>  
> +	/* Post-create CPUless memory tiers after getting HMAT info */
> +	mt_init_with_hmat();
> +
>  	return 0;
>  out_put:
>  	hmat_free_structures();
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..2f845e90c033 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,7 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +void mt_init_with_hmat(void);

HMAT isn't universally available.  It's a driver in fact.  So, don't put
driver specific code in general code.

>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +137,10 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +static inline void mt_init_with_hmat(void)
> +{
> +
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 0537664620e5..7a0a579b3deb 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -35,7 +35,9 @@ struct node_memory_type_map {
>  };
>  
>  static DEFINE_MUTEX(memory_tier_lock);
> +static DEFINE_MUTEX(mt_perf_lock);
>  static LIST_HEAD(memory_tiers);
> +static LIST_HEAD(hmat_memory_types);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>  struct memory_dev_type *default_dram_type;
>  
> @@ -502,7 +504,7 @@ static inline void __init_node_memory_type(int node, struct memory_dev_type *mem
>  	}
>  }
>  
> -static struct memory_tier *set_node_memory_tier(int node)
> +static struct memory_tier *set_node_memory_tier(int node, struct memory_dev_type *new_memtype)

No. memory_dev_type are passed to the function via node_memory_types[node].memtype.

>  {
>  	struct memory_tier *memtier;
>  	struct memory_dev_type *memtype;
> @@ -514,7 +516,7 @@ static struct memory_tier *set_node_memory_tier(int node)
>  	if (!node_state(node, N_MEMORY))
>  		return ERR_PTR(-EINVAL);
>  
> -	__init_node_memory_type(node, default_dram_type);
> +	__init_node_memory_type(node, new_memtype);
>  
>  	memtype = node_memory_types[node].memtype;
>  	node_set(node, memtype->nodes);
> @@ -623,6 +625,56 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +static struct memory_dev_type *hmat_find_alloc_memory_type(int adist)

Similar function existed in drivers/dax/kmem.c.  Please abstract them
and move them here.

> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	list_for_each_entry(mtype, &hmat_memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, &hmat_memory_types);
> +	}
> +	return mtype;
> +}
> +
> +static void mt_create_with_hmat(int node)
> +{
> +	struct memory_dev_type *mtype = NULL;
> +	int adist = MEMTIER_ADISTANCE_DRAM;
> +
> +	mt_calc_adistance(node, &adist);
> +	if (adist != MEMTIER_ADISTANCE_DRAM) {
> +		mtype = hmat_find_alloc_memory_type(adist);
> +		if (IS_ERR(mtype))
> +			pr_err("%s() failed to allocate a tier\n", __func__);
> +	} else {
> +		mtype = default_dram_type;
> +	}
> +
> +	set_node_memory_tier(node, mtype);
> +}
> +
> +void mt_init_with_hmat(void)
> +{
> +	int nid;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for_each_node_state(nid, N_MEMORY)
> +		if (!node_state(nid, N_CPU))
> +			mt_create_with_hmat(nid);
> +
> +	establish_demotion_targets();
> +	mutex_unlock(&memory_tier_lock);
> +}
> +EXPORT_SYMBOL_GPL(mt_init_with_hmat);
> +

I guess that we can put most hmat related code above in hmat.c.

>  static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  {
>  	pr_info(
> @@ -636,7 +688,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  {
>  	int rc = 0;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&mt_perf_lock);
>  	if (default_dram_perf_error) {
>  		rc = -EIO;
>  		goto out;
> @@ -684,7 +736,7 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  	}
>  
>  out:
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&mt_perf_lock);
>  	return rc;
>  }
>  
> @@ -700,7 +752,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  	    perf->read_bandwidth + perf->write_bandwidth == 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&memory_tier_lock);
> +	mutex_lock(&mt_perf_lock);
>  	/*
>  	 * The abstract distance of a memory node is in direct proportion to
>  	 * its memory latency (read + write) and inversely proportional to its
> @@ -713,7 +765,7 @@ int mt_perf_to_adistance(struct access_coordinate *perf, int *adist)
>  		(default_dram_perf.read_latency + default_dram_perf.write_latency) *
>  		(default_dram_perf.read_bandwidth + default_dram_perf.write_bandwidth) /
>  		(perf->read_bandwidth + perf->write_bandwidth);
> -	mutex_unlock(&memory_tier_lock);
> +	mutex_unlock(&mt_perf_lock);
>  
>  	return 0;
>  }
> @@ -797,7 +849,7 @@ static int __meminit memtier_hotplug_callback(struct notifier_block *self,
>  		break;
>  	case MEM_ONLINE:
>  		mutex_lock(&memory_tier_lock);
> -		memtier = set_node_memory_tier(arg->status_change_nid);
> +		memtier = set_node_memory_tier(arg->status_change_nid, default_dram_type);
>  		if (!IS_ERR(memtier))
>  			establish_demotion_targets();
>  		mutex_unlock(&memory_tier_lock);
> @@ -836,7 +888,15 @@ static int __init memory_tier_init(void)
>  	 * types assigned.
>  	 */
>  	for_each_node_state(node, N_MEMORY) {
> -		memtier = set_node_memory_tier(node);
> +		if (!node_state(node, N_CPU))
> +			/*
> +			 * Defer memory tier initialization on CPUless numa nodes.
> +			 * These will be initialized when HMAT information is
> +			 * available.
> +			 */
> +			continue;
> +
> +		memtier = set_node_memory_tier(node, default_dram_type);

On system with HMAT, how to fall back CPU-less node to
default_dram_type?  I found your description, but I don't find it in code.

>  		if (IS_ERR(memtier))
>  			/*
>  			 * Continue with memtiers we are able to setup

--
Best Regards,
Huang, Ying

