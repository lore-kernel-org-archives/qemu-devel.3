Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0F8C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 01:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpeht-0007Y8-Fu; Wed, 27 Mar 2024 21:37:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rpehr-0007Xn-In
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 21:37:27 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rpeho-0000EI-TJ
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 21:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711589844; x=1743125844;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=O1k80KbUBNPKN2Cz8jdjH7/l3Qy2e0v1DTF3Pf8/QLU=;
 b=D1BS/DljU++m21Z4CgMcG0U8fCTaiZA+CQEBpIBh1p6xqlIOnGXPH4X7
 PYOCYnw3yMvUKk9MN6SDmi5hZA8xtcJEnhEyMPWKfjA0/1gzgJSSigIXL
 8bj3nakjQJOcKfHVnR0HmY+Dj/2K3IoUUrYXyRkS1zuDBV0T44ONmPS/1
 1m/48dSpksdeHtBUSolDBzP3fyFOBv8UkTE/Uo41nc7kw6dac9u7E1YGN
 cQXparpyAZwUo9/ofekHiv8nVmKI4bYsTEoIKuZZrKFD/3nHQqFe0LiqD
 9nhMvShFefY2Z2S60q+2ZT8+xdon3odTfsjW1Z14FShelCRL83l1e9Bkm Q==;
X-CSE-ConnectionGUID: RCJNEjilSbiShJz7CaHneA==
X-CSE-MsgGUID: 4x4VANluTgm9wjIa0gjjKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="17453692"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="17453692"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 18:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21131863"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 18:37:16 -0700
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
Subject: Re: [PATCH v6 2/2] memory tier: create CPUless memory tiers after
 obtaining HMAT info
In-Reply-To: <20240327072729.3381685-3-horenchuang@bytedance.com> (Ho-Ren
 Chuang's message of "Wed, 27 Mar 2024 07:27:28 +0000")
References: <20240327072729.3381685-1-horenchuang@bytedance.com>
 <20240327072729.3381685-3-horenchuang@bytedance.com>
Date: Thu, 28 Mar 2024 09:35:22 +0800
Message-ID: <87v857kujp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=192.198.163.9; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

[snip]

> @@ -655,6 +672,34 @@ void mt_put_memory_types(struct list_head *memory_types)
>  }
>  EXPORT_SYMBOL_GPL(mt_put_memory_types);
>  
> +/*
> + * This is invoked via `late_initcall()` to initialize memory tiers for
> + * CPU-less memory nodes after driver initialization, which is
> + * expected to provide `adistance` algorithms.
> + */
> +static int __init memory_tier_late_init(void)
> +{
> +	int nid;
> +
> +	mutex_lock(&memory_tier_lock);
> +	for_each_node_state(nid, N_MEMORY)
> +		if (!node_state(nid, N_CPU) &&
> +			node_memory_types[nid].memtype == NULL)

Think about this again.  It seems that it is better to check
"node_memory_types[nid].memtype == NULL" only here.  Because for all
node with N_CPU in memory_tier_init(), "node_memory_types[nid].memtype"
will be !NULL.  And it's possible (in theory) that some nodes becomes
"node_state(nid, N_CPU) == true" between memory_tier_init() and
memory_tier_late_init().

Otherwise, Looks good to me.  Feel free to add

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

in the future version.

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

[snip]

--
Best Regards,
Huang, Ying

