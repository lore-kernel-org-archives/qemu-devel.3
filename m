Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F147ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 15:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sng4I-0008Hw-JI; Mon, 09 Sep 2024 11:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sng4G-0008B9-Tl; Mon, 09 Sep 2024 11:12:40 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sng4E-0000uC-Dg; Mon, 09 Sep 2024 11:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1725894759; x=1757430759;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=OsmWfy9/jM7Y8SvKhoiJatJA7t9PpOrU8ixthkRiaSA=;
 b=bwGzs4u9Ps69jfuCkwcL0veUeMRAE1YGXkuw8k2Dmlpzxm8jworWfCiI
 E6dvwpB866qAIeONklsQz1fGZCBrhKlITEOy/4scQJBPpjNLsN8qDPufR
 5+s3FDYeU5fK/TZVel0tl66jNdrbFXPgsBBtkCtorjUPsuiLKWyVcCZLk
 s2mqpGTy6Yys4xSAoDU/HUm7KXzaguH1DEm9dp6QSK5jzAL80k5o0J0Cm
 /mSRd7JBGZWy3X1R2wBzIw47E4v/d8uiZC+kUVLtExlsAiyBVkhh65x5g
 gM9VyStNUn6Epw/EAlLRwzFHkXyM6pdsZZwEpvwbPOZFyNF5dBxs3Frjw w==;
X-CSE-ConnectionGUID: YvsSOn7hSrWqbFBP4BFEqA==
X-CSE-MsgGUID: 27ejjkqLQPO4alhQn1DNug==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="47118321"
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; d="scan'208";a="47118321"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2024 08:12:33 -0700
X-CSE-ConnectionGUID: e4fSfRdoRLOxMd5nb7V/nw==
X-CSE-MsgGUID: JHBQ9hB6SkuuWTp2ZI+N7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,214,1719903600"; d="scan'208";a="66673173"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa009.jf.intel.com with ESMTP; 09 Sep 2024 08:12:24 -0700
Date: Mon, 9 Sep 2024 23:28:25 +0800
From: Zhao Liu <zhao1.liu@intel.com>
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
 "shahuang@redhat.com" <shahuang@redhat.com>,
 Linuxarm <linuxarm@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
 {socket,cluster,core,thread}-id property
Message-ID: <Zt8UGd9YRANnBPVT@intel.com>
References: <20240613233639.202896-1-salil.mehta@huawei.com>
 <20240613233639.202896-2-salil.mehta@huawei.com>
 <11e627ef-d75e-4114-9b93-14d80ec0526b@redhat.com>
 <c889781d3eb048d19bae4ceff8646a4e@huawei.com>
 <Zthx3dQInrcgly6+@intel.com>
 <9376341923d94a2bbd8d24f4f6844585@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9376341923d94a2bbd8d24f4f6844585@huawei.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, Sep 04, 2024 at 05:37:21PM +0000, Salil Mehta wrote:
> Date: Wed, 4 Sep 2024 17:37:21 +0000
> From: Salil Mehta <salil.mehta@huawei.com>
> Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
>  {socket,cluster,core,thread}-id property
> 
> Hi Zhao,
> 
> >  From: zhao1.liu@intel.com <zhao1.liu@intel.com>
> >  Sent: Wednesday, September 4, 2024 3:43 PM
> >  To: Salil Mehta <salil.mehta@huawei.com>
> >  
> >  Hi Salil,
> >  
> >  On Mon, Aug 19, 2024 at 11:53:52AM +0000, Salil Mehta wrote:
> >  > Date: Mon, 19 Aug 2024 11:53:52 +0000
> >  > From: Salil Mehta <salil.mehta@huawei.com>
> >  > Subject: RE: [PATCH RFC V3 01/29] arm/virt,target/arm: Add new ARMCPU
> >  > {socket,cluster,core,thread}-id property
> >  
> >  [snip]
> >  
> >  > >  > NULL); @@ -2708,6 +2716,7 @@ static const CPUArchIdList
> >  > > *virt_possible_cpu_arch_ids(MachineState *ms)
> >  > >  >   {
> >  > >  >       int n;
> >  > >  >       unsigned int max_cpus = ms->smp.max_cpus;
> >  > >  > +    unsigned int smp_threads = ms->smp.threads;
> >  > >  >       VirtMachineState *vms = VIRT_MACHINE(ms);
> >  > >  >       MachineClass *mc = MACHINE_GET_CLASS(vms);
> >  > >  >
> >  > >  > @@ -2721,6 +2730,7 @@ static const CPUArchIdList
> >  > > *virt_possible_cpu_arch_ids(MachineState *ms)
> >  > >  >       ms->possible_cpus->len = max_cpus;
> >  > >  >       for (n = 0; n < ms->possible_cpus->len; n++) {
> >  > >  >           ms->possible_cpus->cpus[n].type = ms->cpu_type;
> >  > >  > +        ms->possible_cpus->cpus[n].vcpus_count = smp_threads;
> >  > >  >           ms->possible_cpus->cpus[n].arch_id =
> >  > >  >               virt_cpu_mp_affinity(vms, n);
> >  > >  >
> >  > >
> >  > >  Why @vcpus_count is initialized to @smp_threads? it needs to be
> >  > > documented in the commit log.
> >  >
> >  >
> >  > Because every thread internally amounts to a vCPU in QOM and which is
> >  > in 1:1 relationship with KVM vCPU. AFAIK, QOM does not strictly
> >  > follows any architecture. Once you start to get into details of
> >  > threads there are many aspects of shared resources one will have to
> >  > consider and these can vary across different implementations of
> >  architecture.
> >  
> >  For SPAPR CPU, the granularity of >possible_cpus->cpus[] is "core", and for
> >  x86, it's "thread" granularity.
> 
> 
> We have threads per-core at microarchitecture level in ARM as well. But each
> thread appears like a vCPU to OS and AFAICS there are no special attributes
> attached to it. SMT can be enabled/disabled at firmware and should get
> reflected in the configuration accordingly i.e. value of *threads-per-core* 
> changes between 1 and 'N'.  This means 'vcpus_count' has to reflect the
> correct configuration. But I think threads lack proper representation
> in Qemu QOM.

In topology related part, SMT (of x86) usually represents the logical
processor level. And thread has the same meaning. To change these
meanings is also possible, but I think it should be based on the actual
use case. we can consider the complexity of the implementation when
there is a need.

> In Qemu, each vCPU reflects an execution context (which gets uniquely mapped
> to KVM vCPU). AFAICS, we only have *CPUState* (Struct ArchCPU) as a placeholder
> for this execution context and there is no *ThreadState* (derived out of
> Struct CPUState). Hence, we've  to map all the threads as QOM vCPUs. This means
> the array of present or possible CPUs represented by 'struct CPUArchIdList' contains
> all execution contexts which actually might be vCPU or a thread. Hence, usage of
> *vcpus_count* seems quite superficial to me frankly.
>
> Also, AFAICS, KVM does not have the concept of the threads and only has
> KVM vCPUs, but you are still allowed to specify the topology with sockets, dies,
> clusters, cores, threads in most architectures.  
 
There are some uses for topology, such as it affects scheduling behavior,
and it affects feature emulation, etc.
  
> >  And smp.threads means how many threads in one core, so for x86, the
> >  vcpus_count of a "thread" is 1, and for spapr, the vcpus_count of a "core"
> >  equals to smp.threads.
> 
> 
> Sure, but does the KVM specifies this? 

At least as you said, KVM (for x86) doesn't consider higher-level topologies
at the moment, but that's not to say that it won't in the future, as certain
registers do have topology dependencies.

> and how does these threads map to the QOM vCPU objects or execution context?

Each CPU object will create a (software) thread, you can refer the
function "kvm_start_vcpu_thread(CPUState *cpu)", which will be called
when CPU object realizes.

> AFAICS there is nothing but 'CPUState'
> which will be made part of the  possible vCPU list 'struct CPUArchIdList'.
 
As I said, an example is spapr ("spapr_possible_cpu_arch_ids()"), which
maps possible_cpu to core object. However, this is a very specific
example, and like Igor's slides said, I understand it's an architectural
requirement.

> >  
> >  IIUC, your granularity is still "thread", so that this filed should be 1.
> 
> 
> Well, again we need more discussion on this. I've stated my concerns against
> doing this. User should be allowed to create virtual topology which will
> include 'threads' as one of the parameter.
> 

I don't seem to understand...There is a ¡°threads¡± parameter in -smp, does
this not satisfy your use case?

Regards,
Zhao


