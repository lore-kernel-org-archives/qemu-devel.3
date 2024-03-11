Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29F4BC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjafQ-0006EW-JU; Mon, 11 Mar 2024 04:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjafN-0006EB-1s
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:05:49 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjafL-0003F1-0Q
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710144347; x=1741680347;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=F/IuLV+s9yUiWzJMY+p2Y7SPDRn/5q14hfmZENra7ig=;
 b=UbZSxrISLJZaOEY6MNahbJNiQzYPtQ6ApHoyKtse87JzB1c6D7y+Dhdp
 RTwMpBoJsMWKXNoHpuv2u5RzUjsf0qRoxHzZYKOPUsnZlX5T1rgztR7Vy
 FTx+sCB/IJcgyhQtXcNWqu58+HuZy9fQ7ar5n8Wk0GvYymez5zMW8j1rb
 BNasBISByFmzcW4BzHv5RyL9JnnAuO9Agm3mv4nowxWimN5MjwuFuGK1d
 hujASL1AjEqz5IkZe8DIpeGIL+6XJeQc07/T1CPrOuAzNt4Z/W09jxtUI
 /wcPYanhlpy/T3KME1Tc2ZV7vVCv3FSQduKXxRS6P+Sa+DMDmZsld8kln A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="4716423"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="4716423"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2024 01:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; d="scan'208";a="15687880"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 11 Mar 2024 01:05:40 -0700
Date: Mon, 11 Mar 2024 16:19:28 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Babu Moger <babu.moger@amd.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v9 09/21] i386/cpu: Introduce bitmap to cache available
 CPU topology levels
Message-ID: <Ze6+kCvWklX8JxSE@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-10-zhao1.liu@linux.intel.com>
 <770fe9ab-c9cc-4062-b841-180036a3d050@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770fe9ab-c9cc-4062-b841-180036a3d050@intel.com>
Received-SPF: none client-ip=198.175.65.21;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On Mon, Mar 11, 2024 at 02:28:17PM +0800, Xiaoyao Li wrote:
> Date: Mon, 11 Mar 2024 14:28:17 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v9 09/21] i386/cpu: Introduce bitmap to cache available
>  CPU topology levels
> 
> On 2/27/2024 6:32 PM, Zhao Liu wrote:
> > From: Zhao Liu <zhao1.liu@intel.com>
> > 
> > Currently, QEMU checks the specify number of topology domains to detect
> > if there's extended topology levels (e.g., checking nr_dies).
> > 
> > With this bitmap, the extended CPU topology (the levels other than SMT,
> > core and package) could be easier to detect without touching the
> > topology details.
> > 
> > This is also in preparation for the follow-up to decouple CPUID[0x1F]
> > subleaf with specific topology level.
> > 
> > Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> 
> 
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

Thanks for your review! 

Regrads,
Zhao


