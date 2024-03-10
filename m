Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB30CC54791
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Mar 2024 13:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjJG1-0008I9-Bf; Sun, 10 Mar 2024 09:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjJG0-0008Hx-8Y
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 09:30:28 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rjJFy-0004uw-Mu
 for qemu-devel@nongnu.org; Sun, 10 Mar 2024 09:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710077427; x=1741613427;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T3AsQLCTzlvB6x76yxRW5FOo6r7+SB2qVULan5I1YpQ=;
 b=QnWHJoYf1UI1mS4AQKRa+fOLWaTr7I+Vz6JVQiArqcd0P6eL1vjGMPWU
 JwXrrv0c8sNZaJttHCekFzRQsf+5adv62sZBrBLmvAr3y1dBf6olh5ef7
 jJDNrS1hQUWH3japaf0J+BSy5dS6xjj4rO/rc6UFdie/llklEEL8zXvye
 h54lnf179etmOSfdhVB7N2VF3O6W4UT/MzbAw1M1ieOhTMCP98LIkeeQr
 Ph7WPsh/YVOcf4RCAViAnlSers3BEpjyYYOnBGYMkJlI9i4lp+cDq5H5S
 LPUG2ntrdx4T0JCh7KH0GC39Iygm416n4DXhROue1AbyHU4tqNLtYKQTj A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4670920"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="4670920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Mar 2024 06:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; d="scan'208";a="41898789"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 10 Mar 2024 06:30:20 -0700
Date: Sun, 10 Mar 2024 21:44:08 +0800
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
 Zhao Liu <zhao1.liu@intel.com>, Robert Hoo <robert.hu@linux.intel.com>
Subject: Re: [PATCH v9 08/21] i386/cpu: Consolidate the use of topo_info in
 cpu_x86_cpuid()
Message-ID: <Ze25KAEvahnO2oGF@intel.com>
References: <20240227103231.1556302-1-zhao1.liu@linux.intel.com>
 <20240227103231.1556302-9-zhao1.liu@linux.intel.com>
 <89ed09f2-c139-46b1-b76a-8fa3522cc1ed@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89ed09f2-c139-46b1-b76a-8fa3522cc1ed@intel.com>
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

Hi Xiaoyao,

On Sat, Mar 09, 2024 at 09:48:34PM +0800, Xiaoyao Li wrote:
> Date: Sat, 9 Mar 2024 21:48:34 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: Re: [PATCH v9 08/21] i386/cpu: Consolidate the use of topo_info in
>  cpu_x86_cpuid()
> 
> On 2/27/2024 6:32 PM, Zhao Liu wrote:
> > From: Zhao Liu<zhao1.liu@intel.com>
> > 
> > In cpu_x86_cpuid(), there are many variables in representing the cpu
> > topology, e.g., topo_info, cs->nr_cores and cs->nr_threads.
> > 
> > Since the names of cs->nr_cores/cs->nr_threads does not accurately
> 
> Again as in v7, please changes to "cs->nr_cores and cs->nr_threads",
> 
> "cs->nr_cores/cs->nr_threads" looks like a single variable of division
> 

I missed to change this.

Though, TBH, legitimate division operations are going to add spaces
around "/". It's also common practice to represent "or" by "/" w/t
spaces. But I'll change it in the next version to make you happy!

Thanks,
Zhao


