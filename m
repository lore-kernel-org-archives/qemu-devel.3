Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4224BC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 23:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJiMn-00078l-DD; Tue, 18 Jun 2024 19:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1sJiMl-000771-VY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:35:56 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave.jiang@intel.com>)
 id 1sJiMi-0000Y9-Mc
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 19:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718753753; x=1750289753;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=M1FEDauRjB/4gINRNPjojWAMB+egJq4MMB0aPzU2x14=;
 b=C9iR8FsfDaVANjgG9WzHxYjg7lNM1W96Ha/90j0sEA+Anax2lQxLErrF
 4d7ve8K4RcIMRJECxnvzlWkm+D667+TFeIyBagdLzkRvZeShsNqvDp6hN
 o5LjqG8DOcPawRNSiU+/ceGnGz1G1g3lU6MfZsNf8/+KsdFj1P4CH4BSp
 Gi9p4DzCJ+MeTTucEjUrwhUs5P1Aqf7DRX/oBdNrBW8xGxq5eN9ZdQd8Z
 jtPOSzufzlMIvrN+QDiUoyg+N4zmDKCIchcVuGNEpr0Cd/UH/66kpSDZm
 it9F2X4+pTg0mrq5Nhu7UQmR5ejeagxLuOsPfpmh4MCCzdwQDTQh8S9Hk g==;
X-CSE-ConnectionGUID: LdAnkJ1DSlSrVEb5nK8RvQ==
X-CSE-MsgGUID: AGnbgwwdR5S65xvOnoPqxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15382251"
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; d="scan'208";a="15382251"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2024 16:35:48 -0700
X-CSE-ConnectionGUID: AMbu1aL7Ru6/aO4Vv+HzMw==
X-CSE-MsgGUID: PIcFpnTxRFaosnHDijLJqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,247,1712646000"; d="scan'208";a="79183071"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.236])
 ([10.125.111.236])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2024 16:35:48 -0700
Message-ID: <be14ee00-6d43-4db1-ad63-beac6aacb814@intel.com>
Date: Tue, 18 Jun 2024 16:35:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cxl: avoid duplicating report from MCE & device
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org
Cc: jonathan.cameron@huawei.com, dan.j.williams@intel.com, dave@stgolabs.net, 
 ira.weiny@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240618165310.877974-1-ruansy.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=dave.jiang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



On 6/18/24 9:53 AM, Shiyang Ruan wrote:
> Background:
> Since CXL device is a memory device, while CPU consumes a poison page of 
> CXL device, it always triggers a MCE by interrupt (INT18), no matter 
> which-First path is configured.  This is the first report.  Then 
> currently, in FW-First path, the poison event is transferred according 
> to the following process: CXL device -> firmware -> OS:ACPI->APEI->GHES 
>  -> CPER -> trace report.  This is the second one.  These two reports
> are indicating the same poisoning page, which is the so-called "duplicate
> report"[1].  And the memory_failure() handling I'm trying to add in
> OS-First path could also be another duplicate report.
> 
> Hope the flow below could make it easier to understand:
> CPU accesses bad memory on CXL device, then
>  -> MCE (INT18), *always* report (1)
>  -> * FW-First (implemented now)
>       -> CXL device -> FW
> 	      -> OS:ACPI->APEI->GHES->CPER -> trace report (2.a)
>     * OS-First (not implemented yet, I'm working on it)
>       -> CXL device -> MSI
> 	      -> OS:CXL driver -> memory_failure() (2.b)
> so, the (1) and (2.a/b) are duplicated.
> 
> (I didn't get response in my reply for [1] while I have to make patch to
> solve this problem, so please correct me if my understanding is wrong.)
> 
> This patch adds a new notifier_block and MCE_PRIO_CXL, for CXL memdev
> to check whether the current poison page has been reported (if yes,
> stop the notifier chain, won't call the following memory_failure()
> to report), into `x86_mce_decoder_chain`.  In this way, if the poison
> page already handled(recorded and reported) in (1) or (2), the other one
> won't duplicate the report.  The record could be clear when
> cxl_clear_poison() is called.
> 
> [1] https://lore.kernel.org/linux-cxl/664d948fb86f0_e8be294f8@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  arch/x86/include/asm/mce.h |   1 +
>  drivers/cxl/core/mbox.c    | 130 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/memdev.c  |   6 +-
>  drivers/cxl/cxlmem.h       |   3 +
>  4 files changed, 139 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index dfd2e9699bd7..d8109c48e7d9 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -182,6 +182,7 @@ enum mce_notifier_prios {
>  	MCE_PRIO_NFIT,
>  	MCE_PRIO_EXTLOG,
>  	MCE_PRIO_UC,
> +	MCE_PRIO_CXL,
>  	MCE_PRIO_EARLY,
>  	MCE_PRIO_CEC,
>  	MCE_PRIO_HIGHEST = MCE_PRIO_CEC
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2626f3fff201..0eb3c5401e81 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <linux/notifier.h>
> +#include <asm/mce.h>
>  #include <asm/unaligned.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -880,6 +882,9 @@ void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  		if (cxlr)
>  			hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
>  
> +		if (hpa != ULLONG_MAX && cxl_mce_recorded(hpa))
> +			return;
> +
>  		if (event_type == CXL_CPER_EVENT_GEN_MEDIA)
>  			trace_cxl_general_media(cxlmd, type, cxlr, hpa,
>  						&evt->gen_media);
> @@ -1408,6 +1413,127 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>  
> +struct cxl_mce_record {
> +	struct list_head node;
> +	u64 hpa;
> +};
> +LIST_HEAD(cxl_mce_records);
> +DEFINE_MUTEX(cxl_mce_mutex);
> +
> +bool cxl_mce_recorded(u64 hpa)
> +{
> +	struct cxl_mce_record *cur, *next, *rec;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> +	if (rc)
> +		return false;
> +
> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> +		if (cur->hpa == hpa) {
> +			mutex_unlock(&cxl_mce_mutex);
> +			return true;
> +		}
> +	}
> +
> +	rec = kmalloc(sizeof(struct cxl_mce_record), GFP_KERNEL);
> +	rec->hpa = hpa;
> +	list_add(&cxl_mce_records, &rec->node);
> +
> +	mutex_unlock(&cxl_mce_mutex);
> +
> +	return false;
> +}
> +
> +void cxl_mce_clear(u64 hpa)
> +{
> +	struct cxl_mce_record *cur, *next;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxl_mce_mutex);
> +	if (rc)
> +		return;
> +
> +	list_for_each_entry_safe(cur, next, &cxl_mce_records, node) {
> +		if (cur->hpa == hpa) {
> +			list_del(&cur->node);
> +			break;
> +		}
> +	}
> +
> +	mutex_unlock(&cxl_mce_mutex);
> +}
> +
> +struct cxl_contains_hpa_context {
> +	bool contains;
> +	u64 hpa;
> +};
> +
> +static int __cxl_contains_hpa(struct device *dev, void *arg)
> +{
> +	struct cxl_contains_hpa_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range *range;
> +	u64 hpa = ctx->hpa;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	range = &cxled->cxld.hpa_range;
> +
> +	if (range->start <= hpa && hpa <= range->end) {
> +		ctx->contains = true;
> +		return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool cxl_contains_hpa(const struct cxl_memdev *cxlmd, u64 hpa)
> +{
> +	struct cxl_contains_hpa_context ctx = {
> +		.contains = false,
> +		.hpa = hpa,
> +	};
> +	struct cxl_port *port;
> +
> +	port = cxlmd->endpoint;
> +	if (port && is_cxl_endpoint(port) && cxl_num_decoders_committed(port))

Maybe no need to check is_cxl_endpoint() if the port is retrieved from cxlmd->endpoint.

Also, in order to use cxl_num_decoders_committed(), cxl_region_rwsem must be held. See the lockdep_assert_held() in the function. Maybe add a
guard(cxl_regoin_rwsem);
before the if statement above.

DJ

> +		device_for_each_child(&port->dev, &ctx, __cxl_contains_hpa);
> +
> +	return ctx.contains;
> +}
> +
> +static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
> +			  void *data)
> +{
> +	struct mce *mce = (struct mce *)data;
> +	struct cxl_memdev_state *mds = container_of(nb, struct cxl_memdev_state,
> +						    mce_notifier);
> +	u64 hpa;
> +
> +	if (!mce || !mce_usable_address(mce))
> +		return NOTIFY_DONE;
> +
> +	hpa = mce->addr & MCI_ADDR_PHYSADDR;
> +
> +	/* Check if the PFN is located on this CXL device */
> +	if (!pfn_valid(hpa >> PAGE_SHIFT) &&
> +	    !cxl_contains_hpa(mds->cxlds.cxlmd, hpa))
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * Search PFN in the cxl_mce_records, if already exists, don't continue
> +	 * to do memory_failure() to avoid a poison address being reported
> +	 * more than once.
> +	 */
> +	if (cxl_mce_recorded(hpa))
> +		return NOTIFY_STOP;
> +	else
> +		return NOTIFY_OK;
> +}
> +
>  struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  {
>  	struct cxl_memdev_state *mds;
> @@ -1427,6 +1553,10 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
>  
> +	mds->mce_notifier.notifier_call = cxl_handle_mce;
> +	mds->mce_notifier.priority = MCE_PRIO_CXL;
> +	mce_register_decode_chain(&mds->mce_notifier);
> +
>  	return mds;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0277726afd04..aa3ac89d17be 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -376,10 +376,14 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		goto out;
>  
>  	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> -	if (cxlr)
> +	if (cxlr) {
> +		u64 hpa = cxl_trace_hpa(cxlr, cxlmd, dpa);
> +
> +		cxl_mce_clear(hpa);
>  		dev_warn_once(mds->cxlds.dev,
>  			      "poison clear dpa:%#llx region: %s\n", dpa,
>  			      dev_name(&cxlr->dev));
> +	}
>  
>  	record = (struct cxl_poison_record) {
>  		.address = cpu_to_le64(dpa),
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 19aba81cdf13..fbf8d9f46984 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -501,6 +501,7 @@ struct cxl_memdev_state {
>  	struct cxl_fw_state fw;
>  
>  	struct rcuwait mbox_wait;
> +	struct notifier_block mce_notifier;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
>  			 struct cxl_mbox_cmd *cmd);
>  };
> @@ -836,6 +837,8 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
> +bool cxl_mce_recorded(u64 pfn);
> +void cxl_mce_clear(u64 pfn);
>  
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);

