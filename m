Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F1C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 16:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBdPq-0000vl-5t; Mon, 27 May 2024 12:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBdPn-0000vA-Eu
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:41:39 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sBdPl-0007PD-Bl
 for qemu-devel@nongnu.org; Mon, 27 May 2024 12:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716828097; x=1748364097;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Cmw4nIUxhVOSAdRT2Ygkx9iTQKrmA+RTH/iOYZumS4M=;
 b=XWf7/ZnfHuDhzYlncbVA1M9V8R2u7kXjHskV/TphEwYrWUh+kRCD8uOC
 lCyZQq/IU9/zN+dwZl1CFKfdoZaePp6LhrpZYKa924bKdBlVqD6uMC9Xv
 /blC4S0awA9XyKm0V6HPk2TTKu8IKdkoWI5I0f6151C5oBlz4zh/c21WQ
 aMZ/HlcYlhjCmRao+0gpXfAMB8RLsqTEuUBINUSLikoF0K5SXlgzqER1x
 Krkwz1qcGCPVcm2ePYojCvd2Q09VF/wl9zSq3p1Od3aeXlSHSjO0Epdj4
 Oq2Iu+qqF6tqhBR0HOI6UVO/Tsn0jn8VfRv0zf5Nll5YmU/SYhFtXFQP8 Q==;
X-CSE-ConnectionGUID: 5xWaYd8nSfKHF6z1u3HeAA==
X-CSE-MsgGUID: I1sE0vWoTlCoeGVD6dEbTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="30682291"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; d="scan'208";a="30682291"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2024 09:41:34 -0700
X-CSE-ConnectionGUID: tFULggY6R8GCJdTgNRTvSg==
X-CSE-MsgGUID: YFJPzj8qSza1yPrtj2O8Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; d="scan'208";a="39654247"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 27 May 2024 09:41:32 -0700
Date: Tue, 28 May 2024 00:56:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xieyongji@bytedance.com,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>,
 Babu Moger <babu.moger@amd.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Dapeng Mi <dapeng1.mi@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>
Subject: Re: [PATCH] x86: cpu: fixup number of addressable IDs for processor
 cores in the physical package
Message-ID: <ZlS7VjagJ5jd0Alq@intel.com>
References: <20240527031333.85932-1-xuchuangxclwt@bytedance.com>
 <20240527170317.14520a2f@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527170317.14520a2f@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
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

Hi Igor,

On Mon, May 27, 2024 at 05:03:17PM +0200, Igor Mammedov wrote:
> Date: Mon, 27 May 2024 17:03:17 +0200
> From: Igor Mammedov <imammedo@redhat.com>
> Subject: Re: [PATCH] x86: cpu: fixup number of addressable IDs for
>  processor cores in the physical package
> X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
> 
> On Mon, 27 May 2024 11:13:33 +0800
> Chuang Xu <xuchuangxclwt@bytedance.com> wrote:
> 
> > When QEMU is started with:
> > -cpu host,host-cache-info=on,l3-cache=off \
> > -smp 2,sockets=1,dies=1,cores=1,threads=2
> > Guest can't acquire maximum number of addressable IDs for processor cores in
> > the physical package from CPUID[04H].
> 
> please add commit message, what you are actually seeing
> and expected values as well.
> And if guest complains about it also include related dmesg output.
> 
> 
> > This bug was introduced in commit d7caf13b5fcf742e5680c1d3448ba070fc811644.
> > Fix it by changing the judgement condition to a >= 1.
> > 
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index cd16cb893d..0369c01153 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6097,7 +6097,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >              if (*eax & 31) {
> >                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> >                  int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> 
> in light of dies and recent modules shouldn't we also account for them here?

cs->nr_cores now account dies and modules (as its comment said "Number
of cores within this CPU package"). The code for this patch is a bit
outdated, although the issue is still here on the latest master.

> > -                if (cs->nr_cores > 1) {
> > +                if (cs->nr_cores >= 1) {
> >                      *eax &= ~0xFC000000;
> >                      *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> >                  }
> above and also following condition
> 
>                 if (host_vcpus_per_cache > vcpus_per_socket) {
>                     ...
>                     *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> 
> Makes me think, do we really have to have both conditionals,
> Why not just drop conditions and always encode both values
> to ones configured on '-smp' CLI?

The first condition "cores_per_pkg >= 1" can be removed in this patch
since cs->nr_cores won't be 0. :-)

About the 2nd condition "host_vcpus_per_cache > vcpus_per_socket", more
work is needed for cleanup...removal is also desirable, but not direct
removal, otherwise, Guest's L1/L2/L3 cache topology will default to
package level.

Currently with host_vcpus_per_cache <= threads_per_pkg, QEMU will
directly give Guest the Host's EAX[bits 25 -14], which is also
inaccurate, especially if there is a big difference between Guest and
Host CPU topology.

The correct way to do it is to parse the specific level of cache
topology on Host (core/module/die/package), and then encode Guest's
EAX[bits 25 -14] according to the specific items configured in -smp.

By cleaning up in this way, the second condition can be removed
naturally.

The host-cache-info cleanup was originally planned for me as well, I
think I can do this after Chuang's fix.

Thanks,
Zhao


