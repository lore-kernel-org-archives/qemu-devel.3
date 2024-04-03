Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B5E7CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 16:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs3qS-0000lj-0i; Wed, 03 Apr 2024 12:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rs3qQ-0000i4-0i
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:52:14 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rs3qN-0006t8-5Q
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 12:52:13 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8rNM5jKhz6D8Yx;
 Thu,  4 Apr 2024 00:50:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 8C7A0140B67;
 Thu,  4 Apr 2024 00:52:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 3 Apr
 2024 17:52:02 +0100
Date: Wed, 3 Apr 2024 17:52:01 +0100
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
CC: "Huang, Ying" <ying.huang@intel.com>, Gregory Price
 <gourry.memverge@gmail.com>, <aneesh.kumar@linux.ibm.com>, <mhocko@suse.com>, 
 <tj@kernel.org>, <john@jagalactic.com>, Eishan Mirakhur
 <emirakhur@micron.com>, Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, Alistair Popple
 <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, SeongJae
 Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, Andrew
 Morton <akpm@linux-foundation.org>, <nvdimm@lists.linux.dev>,
 <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, "Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack)
 Chuang" <horenchuang@gmail.com>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH v10 1/2] memory tier: dax/kmem: introduce an abstract
 layer for finding, allocating, and putting memory types
Message-ID: <20240403175201.00000c2c@Huawei.com>
In-Reply-To: <20240402001739.2521623-2-horenchuang@bytedance.com>
References: <20240402001739.2521623-1-horenchuang@bytedance.com>
 <20240402001739.2521623-2-horenchuang@bytedance.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue,  2 Apr 2024 00:17:37 +0000
"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:

> Since different memory devices require finding, allocating, and putting
> memory types, these common steps are abstracted in this patch,
> enhancing the scalability and conciseness of the code.
> 
> Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

Hi,

I know this is a late entry to the discussion but a few comments inline.
(sorry I didn't look earlier!)

All opportunities to improve code complexity and readability as a result
of your factoring out.

Jonathan


> ---
>  drivers/dax/kmem.c           | 20 ++------------------
>  include/linux/memory-tiers.h | 13 +++++++++++++
>  mm/memory-tiers.c            | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 42ee360cf4e3..01399e5b53b2 100644
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
could use

	guard(mutex)(&kmem_memory_type_lock);
	return mt_find_alloc_memory_type(adist, &kmem_memory_types);

I'm fine if you ignore this comment though as may be other functions in
here that could take advantage of the cleanup.h stuff in a future patch.

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
 
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 69e781900082..a44c03c2ba3a 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -48,6 +48,9 @@ int mt_calc_adistance(int node, int *adist);
>  int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>  			     const char *source);
>  int mt_perf_to_adistance(struct access_coordinate *perf, int *adist);
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist,
> +							struct list_head *memory_types);

That indent looks unusual.  Align the start of struct with start of int.

> +void mt_put_memory_types(struct list_head *memory_types);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
>  void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> @@ -136,5 +139,15 @@ static inline int mt_perf_to_adistance(struct access_coordinate *perf, int *adis
>  {
>  	return -EIO;
>  }
> +
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)
> +{
> +	return NULL;
> +}
> +
> +void mt_put_memory_types(struct list_head *memory_types)
> +{
> +
No blank line needed here. 
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 0537664620e5..974af10cfdd8 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -623,6 +623,38 @@ void clear_node_memory_type(int node, struct memory_dev_type *memtype)
>  }
>  EXPORT_SYMBOL_GPL(clear_node_memory_type);
>  
> +struct memory_dev_type *mt_find_alloc_memory_type(int adist, struct list_head *memory_types)

Breaking this out as a separate function provides opportunity to improve it.
Maybe a follow up patch makes sense given it would no longer be a straight
forward code move.  However in my view it would be simple enough to be obvious
even within this patch.

> +{
> +	bool found = false;
> +	struct memory_dev_type *mtype;
> +
> +	list_for_each_entry(mtype, memory_types, list) {
> +		if (mtype->adistance == adist) {
> +			found = true;

Why not return here?
			return mtype;

> +			break;
> +		}
> +	}
> +	if (!found) {

If returning above, no need for found variable - just do this unconditionally.
+ I suggest you flip logic for simpler to follow code flow.
It's more code but I think a bit easier to read as error handling is
out of the main simple flow.

	mtype = alloc_memory_type(adist);
	if (IS_ERR(mtype))
		return mtype;

	list_add(&mtype->list, memory_types);

	return mtype;

> +		mtype = alloc_memory_type(adist);
> +		if (!IS_ERR(mtype))
> +			list_add(&mtype->list, memory_types);
> +	}
> +
> +	return mtype;
> +}
> +EXPORT_SYMBOL_GPL(mt_find_alloc_memory_type);
> +
> +void mt_put_memory_types(struct list_head *memory_types)
> +{
> +	struct memory_dev_type *mtype, *mtn;
> +
> +	list_for_each_entry_safe(mtype, mtn, memory_types, list) {
> +		list_del(&mtype->list);
> +		put_memory_type(mtype);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(mt_put_memory_types);
> +
>  static void dump_hmem_attrs(struct access_coordinate *coord, const char *prefix)
>  {
>  	pr_info(


