Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A338CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slqyJ-0007mK-CP; Wed, 04 Sep 2024 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1slqyD-0007g2-Nl; Wed, 04 Sep 2024 10:26:55 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1slqyB-0001JI-QX; Wed, 04 Sep 2024 10:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725460012; x=1756996012;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=J/O7jPR+9LMp4leGzo9biNFU02/Xi7Y+x90LmMp/+oQ=;
 b=gNwuY/NAPdvHjba4ShU2hQQvZOf/6W6uu0ghLSUnjxB5GEv/8K19LX9B
 V7heHi8L1A1WMxspphrPeSIulqg0ab8Rt7EwWkbhQfGUSsPUKnylebPbB
 cus34sftF0p8vXgL19VBeHFl2CPsZbZDHfXFVx/9bz9ZwT/kcMCdgTJZL
 iADVJ3oRDyEXj6pUZwiXrvfMmHN9jl5XCydb9SULQ6iMaXa2JR+gfMJpy
 pa0Gf0ft7QUHUvZuq7BevJrztZAQCKuQuCA44wFmKfX8fWOqpkwkWzGZ3
 z5J1GDILyLY5dLXwv8JyMt7gja5I76Ixo0FiVWJgPzRq2T+lI2uVa9Spd w==;
X-CSE-ConnectionGUID: zcorqITNTiGea+tmP9DrpA==
X-CSE-MsgGUID: YZxek9qWRUir/xAYvQsWfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="13369174"
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; d="scan'208";a="13369174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2024 07:26:46 -0700
X-CSE-ConnectionGUID: RUJj5sxSTWmFraLN1vMKgw==
X-CSE-MsgGUID: g0AsuLfnSkSb7p1sEfRpPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,202,1719903600"; d="scan'208";a="65626630"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 04 Sep 2024 07:26:37 -0700
Date: Wed, 4 Sep 2024 22:42:37 +0800
From: "zhao1.liu@intel.com" <zhao1.liu@intel.com>
To: Salil Mehta <salil.mehta@huawei.com>
Cc: Gavin Shan <gshan@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>, "maz@kernel.org" <maz@kernel.org>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "andrew.jones@linux.dev" <andrew.jones@linux.dev>,
 "david@redhat.com" <david@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "will@kernel.org" <will@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rafael@kernel.org" <rafael@kernel.org>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "harshpb@linux.ibm.com" <harshpb@linux.ibm.com>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
 "darren@os.amperecomputing.com" <darren@os.amperecomputing.com>,
 "ilkka@os.amperecomputing.com" <ilkka@os.amperecomputing.com>,
 "vishnu@os.amperecomputing.com" <vishnu@os.amperecomputing.com>,
 "karl.heubaum@oracle.com" <karl.heubaum@oracle.com>,
 "miguel.luis@oracle.com" <miguel.luis@oracle.com>,
 "salil.mehta@opnsrc.net" <salil.mehta@opnsrc.net>,
 zhukeqian <zhukeqian1@huawei.com>,
 "wangxiongfeng (C)" <wangxiongfeng2@huawei.com>,
 "wangyanan (Y)" <wangyanan55@huawei.com>,
 "jiakernel2@gmail.com" <jiakernel2@gmail.com>,
 "maobibo@loongson.cn" <maobibo@loongson.cn>,
 "lixianglai@loongson.cn" <lixianglai@loongson.cn>,
 "shahuang@redhat.com" <shahuang@redhat.com>, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Message-ID: <Zthx3dQInrcgly6+@intel.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <c889781d3eb048d19bae4ceff8646a4e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c889781d3eb048d19bae4ceff8646a4e@huawei.com>
Received-SPF: pass client-ip=192.198.163.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Salil,

On Mon, Aug 19, 2024 at 11:53:52AM +0000, Salil Mehta wrote:
> Date: Mon, 19 Aug 2024 11:53:52 +0000
> From: Salil Mehta <salil.mehta@huawei.com>
> Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
>  {socket,cluster,core,thread}-id property

[snip]

> >  > NULL); @@ -2708,6 +2716,7 @@ static const CPUArchIdList
> >  *virt_possible_cpu_arch_ids(MachineState *ms)
> >  >   {
> >  >       int n;
> >  >       unsigned int max_cpus = ms->smp.max_cpus;
> >  > +    unsigned int smp_threads = ms->smp.threads;
> >  >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >  >       MachineClass *mc = MACHINE_GET_CLASS(vms);
> >  >
> >  > @@ -2721,6 +2730,7 @@ static const CPUArchIdList
> >  *virt_possible_cpu_arch_ids(MachineState *ms)
> >  >       ms->possible_cpus->len = max_cpus;
> >  >       for (n = 0; n < ms->possible_cpus->len; n++) {
> >  >           ms->possible_cpus->cpus[n].type = ms->cpu_type;
> >  > +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
> >  >           ms->possible_cpus->cpus[n].arch_id =
> >  >               virt_cpu_mp_affinity(vms, n);
> >  >
> >  
> >  Why @vcpus_count is initialized to @smp_threads? it needs to be
> >  documented in the commit log.
> 
> 
> Because every thread internally amounts to a vCPU in QOM and which
> is in 1:1 relationship with KVM vCPU. AFAIK, QOM does not strictly follows
> any architecture. Once you start to get into details of threads there
> are many aspects of shared resources one will have to consider and
> these can vary across different implementations of architecture.

For SPAPR CPU, the granularity of >possible_cpus->cpus[] is "core", and
for x86, it's "thread" granularity.

And smp.threads means how many threads in one core, so for x86, the
vcpus_count of a "thread" is 1, and for spapr, the vcpus_count of a
"core" equals to smp.threads.

IIUC, your granularity is still "thread", so that this filed should be 1.

-Zhao

> It is a bigger problem than you think, which I've touched at very nascent
> stages while doing POC of vCPU hotplug but tried to avoid till now. 
> 
> 
> But I would like to hear other community members views on this.
> 
> Hi Igor/Peter,
> 
> What is your take on this?
> 
> Thanks
> Salil.

