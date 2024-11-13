Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21668D462D3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 16:31:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBGGN-0002FZ-G2; Wed, 13 Nov 2024 11:30:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tBGGL-0002Eu-2L
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:30:37 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tBGGI-0006hp-RF
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 11:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1731515435; x=1763051435;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=r5qLpRURZWKqh+qzltYbHLtKz5Eb8VMEBe7FX268juo=;
 b=OAB2rchlWe6ecjoBW056iBHneUhUZAjsQVBwSgja9gQsngkBaCvGKIrU
 YU8znfalf5r89tgdjJHg6CmeXMp7C5rCsQYcJw8D+J5xNmELuwakLXkYX
 xa5PryWHWskWiOvwfHf0bUZ4+KZxb+yJAlYUqLmeSTl+QNqPYdtn23Zyh
 ugoUY3jRaVIFmv3AZC7369hRKyfq272FyDzXhT8mgtcBEG5cDbQMT1YCR
 dK80wAehHbHRv607jZ3hc/1bZZdTi/F9RLRswI/tHZZWB3Rut3rWY/d45
 eDP/wKiVxKRu2siKbhSo5RIxUs6y9rjDwx7U0S00KYy+0Atk/O5SjmHQ0 g==;
X-CSE-ConnectionGUID: kPIKtTIVRz6VtuI/7J5yrQ==
X-CSE-MsgGUID: P9hm+YWvR7itdq0CRDP+Ag==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41977184"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="41977184"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2024 08:30:30 -0800
X-CSE-ConnectionGUID: etMJktvSTm6SYva+9vNDyA==
X-CSE-MsgGUID: V4tr+zkcQwWJ6CY3HotHQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; d="scan'208";a="91961625"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa003.fm.intel.com with ESMTP; 13 Nov 2024 08:30:25 -0800
Date: Thu, 14 Nov 2024 00:48:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, lyan@digitalocean.com,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, joe.jin@oracle.com, davydov-max@yandex-team.ru
Subject: Re: [PATCH 3/7] target/i386/kvm: init PMU information only once
Message-ID: <ZzTYWMM9bUAkn+c8@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-4-dongli.zhang@oracle.com>
 <ZzDRZcy7EdK40PO1@intel.com>
 <418a42f0-13d6-4f1e-8733-2d05ddd1959d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418a42f0-13d6-4f1e-8733-2d05ddd1959d@oracle.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Nov 12, 2024 at 05:50:26PM -0800, dongli.zhang@oracle.com wrote:
> Date: Tue, 12 Nov 2024 17:50:26 -0800
> From: dongli.zhang@oracle.com
> Subject: Re: [PATCH 3/7] target/i386/kvm: init PMU information only once
> 
> Hi Zhao,
> 
> On 11/10/24 7:29 AM, Zhao Liu wrote:
> > Hi Dongli,
> > 
> >>  int kvm_arch_init_vcpu(CPUState *cs)
> >>  {
> >>      struct {
> >> @@ -2237,6 +2247,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
> >>      cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
> >>      cpuid_data.cpuid.nent = cpuid_i;
> >>  
> >> +    /*
> >> +     * Initialize PMU information only once for the first vCPU.
> >> +     */
> >> +    if (cs == first_cpu) {
> >> +        kvm_init_pmu_info(env);
> >> +    }
> >> +
> > 
> > Thank you for the optimization. However, I think it¡¯s not necessary
> > because:
> > 
> > * This is not a hot path and not a performance bottleneck.
> > * Many CPUID leaves are consistent across CPUs, and 0xA is just one of them.
> > * And encoding them all in kvm_x86_build_cpuid() is a common pattern.
> >   Separating out 0xa disrupts code readability and fragments the CPUID encoding.
> > 
> > Therefore, code maintainability and correctness might be more important here,
> > than performance concern.
> 
> I am going to remove this patch in v2.
> 
> Just a reminder, we may have more code in this function by other patches,
> including the initialization of both Intel and AMD PMU infortmation (PerfMonV2).

Yes, I mean we can just remove "first_cpu" check and move this function
into kvm_x86_build_cpuid() again. Your function wrapping is fine for me.

> Dongli Zhang
> 
> > 
> >>      if (((env->cpuid_version >> 8)&0xF) >= 6
> >>          && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
> >>             (CPUID_MCE | CPUID_MCA)) {
> >> -- 
> >> 2.39.3
> >>
> 

