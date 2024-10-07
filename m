Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807FBCFB43F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 11:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxmBD-0004Pl-6V; Mon, 07 Oct 2024 07:45:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxmBA-0004P5-RT; Mon, 07 Oct 2024 07:45:32 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sxmB7-0004K0-AA; Mon, 07 Oct 2024 07:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728301530; x=1759837530;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=le1Z3PXrvGJX3Kl1hVhAfYKoggcgT0BzKXDZW7x8nyk=;
 b=E7R0z2WYKWtkGSxE9OjLM8MjSyC1jw2IO5/ri50Y52xCh2ZVYleHgtrH
 bKhgm1NsLLvPJ5ZP+I+YfqrW1gntmox+l6lAHwgR6ExxsbMBHa3JRvq4f
 rTd4Sk//EUevIKx2TmCWEAQbXcKosAssD842u6RikOyARTFg0sD2hD7vP
 4+oMBfevEu98pl7kD/m0tHW9kVeDjsK7cwX60rI0IIc+mP09RF1oNIqcI
 fisWqDCNO0Z7qeSvq4ECAapZI+FpVXqm7rJ8R8yKq8NowfwD6hAZBEQvn
 +RKo8gpJ1xCi4EM4L5kw+JNRU2nCZvssqLYEmGlFq+vM8m3qe9gxCpCTS g==;
X-CSE-ConnectionGUID: sRr6a0PTQUCgMuuFX5LHpQ==
X-CSE-MsgGUID: lBSUmyi9SOGZhMG4JgF/pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="31238712"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="31238712"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 04:45:26 -0700
X-CSE-ConnectionGUID: ScLS3KrURUWQ6QAUbYDBDQ==
X-CSE-MsgGUID: Dca2mNFFQzGhm1/53s65IA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; d="scan'208";a="75455218"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 07 Oct 2024 04:45:20 -0700
Date: Mon, 7 Oct 2024 20:01:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenyu.z.wang@intel.com,
 dapeng1.mi@linux.intel.com, yongwei.ma@intel.com, armbru@redhat.com,
 farman@linux.ibm.com, peter.maydell@linaro.org, mst@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, linuxarm@huwei.com,
 shameerali.kolothum.thodi@huawei.com, Jonathan.Cameron@huawei.com,
 jiangkunkun@huawei.comi, zhao1.liu@intel.com
Subject: Re: [PATCH 2/5] i386/cpu: add IsDefined flag to smp-cache property
Message-ID: <ZwPNnLE1ZmsNWTQA@intel.com>
References: <20240912133829.400-1-alireza.sanaee@huawei.com>
 <20240912133829.400-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912133829.400-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Ali,

On Thu, Sep 12, 2024 at 02:38:26PM +0100, Alireza Sanaee wrote:
> Date: Thu, 12 Sep 2024 14:38:26 +0100
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: [PATCH 2/5] i386/cpu: add IsDefined flag to smp-cache property
> X-Mailer: git-send-email 2.34.1
> 
> This commit adds IsDefined flag to the object and this helps in avoiding
> extra checks for every single layer of caches in both x86 and ARM.
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/core/machine-smp.c | 2 ++
>  include/hw/boards.h   | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/hw/core/machine-smp.c b/hw/core/machine-smp.c
> index 9a28194676..5a02bbf584 100644
> --- a/hw/core/machine-smp.c
> +++ b/hw/core/machine-smp.c
> @@ -371,6 +371,8 @@ bool machine_parse_smp_cache(MachineState *ms,
>          return false;
>      }
>  
> +    ms->smp_cache.IsDefined = true;
> +
>      return true;
>  }
>  
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index db2aa2b706..2883a57084 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -373,6 +373,7 @@ typedef struct CpuTopology {
>  
>  typedef struct SmpCache {
>      SmpCacheProperties props[CACHE_LEVEL_AND_TYPE__MAX];
> +    bool IsDefined;
>  } SmpCache;

Thanks!

I'd add the flag "has_caches" in SMPCompatProps.
I could pick this patch into my next version and remove my "TODO". :-)

Regards,
Zhao



