Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C1E1D1A45D
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 09:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szYW3-0001dA-9P; Sat, 12 Oct 2024 05:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szYW0-0001cU-2t; Sat, 12 Oct 2024 05:34:24 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1szYVx-0008UR-7H; Sat, 12 Oct 2024 05:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728725661; x=1760261661;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=O3mCAQtayiMIHdyQpj2o2BuMZZMWYWs+Uw6UyGPRjUQ=;
 b=lB+mhUtPQ/CLQu/q6cytTN/bwaWUJ3yctCBtrfwLTnW2qkBpAUf8TCKC
 fr4o1JIgpGS2K8irvL6WZj36lGW8iq2c9K1j7ePPpQmW08DOVyMywqUN7
 +y2yePGOTT6+v/9GArwZfK7Odggau8IinPjMWn0Bq2XyhGihExOsq0jzz
 TZ33WkQzqiJWj0QQWDyQpoghNbxV140DdtdEqqcywFUNP6WXZEwNgPIs0
 OtQPwLO49fMLcQZ5QKABekLO0EMH8wa8Lt3QfCBQ5OesouLKDteYg+r/p
 uDk0dM2r1DCjok52iX//parKhX1PQHW1kvQYEf0lUrIFbnKwExt/g0bEt Q==;
X-CSE-ConnectionGUID: t2XdL5PNS6KTncLLicaKGQ==
X-CSE-MsgGUID: RIfxSHVMSC+E7VssSSPgng==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="32035181"
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="32035181"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2024 02:34:17 -0700
X-CSE-ConnectionGUID: 7HZvLXW6TW2XeCQk17lw4A==
X-CSE-MsgGUID: nMhM8DDBQJ6KW6YEML4x9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,198,1725346800"; d="scan'208";a="100447434"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa002.fm.intel.com with ESMTP; 12 Oct 2024 02:34:13 -0700
Date: Sat, 12 Oct 2024 17:50:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, zhenyu.z.wang@intel.com,
 dapeng1.mi@linux.intel.com, yongwei.ma@intel.com, armbru@redhat.com,
 farman@linux.ibm.com, peter.maydell@linaro.org, mst@redhat.com,
 anisinha@redhat.com, shannon.zhaosl@gmail.com, imammedo@redhat.com,
 mtosatti@redhat.com, berrange@redhat.com,
 richard.henderson@linaro.org, linuxarm@huawei.com,
 shameerali.kolothum.thodi@huawei.com, Jonathan.Cameron@huawei.com,
 jiangkunkun@huawei.com, yangyicong@hisilicon.com
Subject: Re: [PATCH v3 2/6] i386/cpu: add IsDefined flag to smp-cache property
Message-ID: <ZwpGYtqS9AJ96G8+@intel.com>
References: <20241010111822.345-1-alireza.sanaee@huawei.com>
 <20241010111822.345-3-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010111822.345-3-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
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

Hi Alireze,

On Thu, Oct 10, 2024 at 12:18:18PM +0100, Alireza Sanaee wrote:
> Date: Thu, 10 Oct 2024 12:18:18 +0100
> From: Alireza Sanaee <alireza.sanaee@huawei.com>
> Subject: [PATCH v3 2/6] i386/cpu: add IsDefined flag to smp-cache property
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
>  
>  /**

Thanks for your patch, now I've added this commit in my series to
resolve my TODO, which can also help your series be more ARM-focused :).

I will post my next version soon.

Thanks,
Zhao



