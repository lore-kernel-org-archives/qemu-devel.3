Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4476FC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raStX-0001sR-HY; Wed, 14 Feb 2024 22:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.luck@intel.com>)
 id 1raQPh-0002yG-Du
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 20:19:45 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tony.luck@intel.com>)
 id 1raQPf-0000KA-7P
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 20:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707959983; x=1739495983;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8etmOUolKQtAINrMulYOSO7ZrAS0mvvYXhM462kQD/0=;
 b=W+4XTZhCcRmGBeqfClszC5prz6R0pVV+WU/JJz7cGRMRqQ3U2eizbriA
 1WjS+I0SyIJcRJtjHdJVDDG8ROIsWk9PZyH8bSC0hj06pc7OHeC1eaRKO
 pepTllmrF5N4uDhk47VzYutiKDCndiQNuhvngzJ7cwRivhg46mJrLUrci
 kHkIYeHJyx9roRc4ic+oeV0VwE0VVu4Bt7lwxLuOAoE0dk3rAVwd5sIG1
 P7PFvfVjowfWWunR9Sg2XoIT9y+6HtrYuThz7WCRS1figZXBAhzFPvHpC
 5XvqtM0gQaKCDINyUc6T0itcPO5bm73W62BDC8Hhx23tFo8Jl7WlhAYgY A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1914560"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1914560"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Feb 2024 17:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="3395181"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
 by orviesa009-auth.jf.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 17:19:38 -0800
Date: Wed, 14 Feb 2024 17:19:36 -0800
From: Tony Luck <tony.luck@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Jonathan.Cameron@huawei.com, dan.j.williams@intel.com
Subject: Re: [RFC PATCH 3/5] cxl/core: introduce cxl_mem_report_poison()
Message-ID: <Zc1mqOp9WiV49_Yi@agluck-desk3>
References: <20240209115417.724638-1-ruansy.fnst@fujitsu.com>
 <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209115417.724638-6-ruansy.fnst@fujitsu.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=tony.luck@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 14 Feb 2024 22:58:39 -0500
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

On Fri, Feb 09, 2024 at 07:54:15PM +0800, Shiyang Ruan wrote:
> If poison is detected(reported from cxl memdev), OS should be notified to
> handle it.  Introduce this function:
>   1. translate DPA to HPA;
>   2. construct a MCE instance; (TODO: more details need to be filled)
>   3. log it into MCE event queue;
> 
> After that, MCE mechanism can walk over its notifier chain to execute
> specific handlers.

This looks like a useful proof of concept patch to pass errors to all
the existing logging systems (console, mcelog, rasdaemon, EDAC). But
it's a bare minimum (just passing the address and dropping any other
interesting information about the error). I think we need something
more advanced that covers more CXL error types.

> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  arch/x86/kernel/cpu/mce/core.c |  1 +
>  drivers/cxl/core/mbox.c        | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index bc39252bc54f..a64c0aceb7e0 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -131,6 +131,7 @@ void mce_setup(struct mce *m)
>  	m->ppin = cpu_data(m->extcpu).ppin;
>  	m->microcode = boot_cpu_data.microcode;
>  }
> +EXPORT_SYMBOL_GPL(mce_setup);
>  
>  DEFINE_PER_CPU(struct mce, injectm);
>  EXPORT_PER_CPU_SYMBOL_GPL(injectm);
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 27166a411705..f9b6f50fbe80 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -4,6 +4,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <asm/mce.h>
>  #include <asm/unaligned.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
> @@ -1290,6 +1291,38 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +static void cxl_mem_report_poison(struct cxl_memdev *cxlmd,
> +				  struct cxl_poison_record *poison)
> +{
> +	struct mce m;
> +	u64 dpa = le64_to_cpu(poison->address) & CXL_POISON_START_MASK;
> +	u64 len = le64_to_cpu(poison->length), i;
> +	phys_addr_t phys_addr = cxl_memdev_dpa_to_hpa(cxlmd, dpa);
> +
> +	if (phys_addr)
> +		return;
> +
> +	/*
> +	 * Initialize struct mce.  Call preempt_disable() to avoid
> +	 * "BUG: using smp_processor_id() in preemptible" for now, not sure
> +	 * if this is a correct way.
> +	 */
> +	preempt_disable();
> +	mce_setup(&m);
> +	preempt_enable();
> +
> +	m.bank = -1;
> +	/* Fake a memory read error with unknown channel */
> +	m.status = MCI_STATUS_VAL | MCI_STATUS_EN | MCI_STATUS_ADDRV |
> +		   MCI_STATUS_MISCV | 0x9f;
> +	m.misc = (MCI_MISC_ADDR_PHYS << 6);
> +
> +	for (i = 0; i < len; i++) {
> +		m.addr = phys_addr++;
> +		mce_log(&m);

This loop looks wrong. What values do you expect for "len" (a.k.a.
poison->length)? Creating one log for each byte in the range will
be very noisy!

> +	}
> +}
> +
>  int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>  		       struct cxl_region *cxlr)
>  {
> -- 
> 2.34.1

-Tony

