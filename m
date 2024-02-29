Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A139C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaUy-0006lx-5i; Thu, 29 Feb 2024 02:06:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfaUb-0006cl-H7; Thu, 29 Feb 2024 02:06:11 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rfaUX-0003h6-3s; Thu, 29 Feb 2024 02:06:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709190365; x=1740726365;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=i9uq6y/awOo4nqggMPn0JAiBk7ClRoK07Pbq42o5yNE=;
 b=BdziewIXQavscsipJggKv7w/EVB/kL4RlvGrGe+hvaBB+PZnAQEn+UoB
 GvBRB8bKtnkkF8MH4D0hVb64bUiE0ltJJZiGOjym2+5Hwl1/uXxhTB3RI
 jotzbTnzKQNu0U43FyGlmmj8B9LLGizXaCS5tqYnY3C0yKXqnZN2Vh0pB
 JwkERuynzPPgtTM8D05mIqkvg7O/3zrFvrwni18moKVGeQzh0U3c2zILb
 +BlpkzMhJbxGskUQgh7cjOuL8cCtkw148Dk5ykNtSJPAldZGyyhOw3RZ9
 H3t9rm8OZe4uh1zQJ3kTVYM9zdYzX9CW8pcTdGIT7CRM9XGuV+l7VT5TR Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3764831"
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="3764831"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2024 23:06:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,192,1705392000"; 
   d="scan'208";a="8082618"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 28 Feb 2024 23:05:56 -0800
Date: Thu, 29 Feb 2024 15:19:40 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 6/8] i386/cpu: Update cache topology with machine's
 configuration
Message-ID: <ZeAwDIDdJff6SiiB@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-7-zhao1.liu@linux.intel.com>
 <BJSPR01MB0561F3D87C67D4BCCA9E9C8D9C58A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BJSPR01MB0561F3D87C67D4BCCA9E9C8D9C58A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Received-SPF: none client-ip=198.175.65.18;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Hi JeeHeng,

> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index d7cb0f1e49b4..4b5c551fe7f0 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -7582,6 +7582,27 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
> > 
> >  #ifndef CONFIG_USER_ONLY
> >      MachineState *ms = MACHINE(qdev_get_machine());
> > +
> > +    if (ms->smp_cache.l1d != CPU_TOPO_LEVEL_INVALID) {
> > +        env->cache_info_cpuid4.l1d_cache->share_level = ms->smp_cache.l1d;
> > +        env->cache_info_amd.l1d_cache->share_level = ms->smp_cache.l1d;
> > +    }
> > +
> > +    if (ms->smp_cache.l1i != CPU_TOPO_LEVEL_INVALID) {
> > +        env->cache_info_cpuid4.l1i_cache->share_level = ms->smp_cache.l1i;
> > +        env->cache_info_amd.l1i_cache->share_level = ms->smp_cache.l1i;
> > +    }
> > +
> > +    if (ms->smp_cache.l2 != CPU_TOPO_LEVEL_INVALID) {
> > +        env->cache_info_cpuid4.l2_cache->share_level = ms->smp_cache.l2;
> > +        env->cache_info_amd.l2_cache->share_level = ms->smp_cache.l2;
> > +    }
> > +
> > +    if (ms->smp_cache.l3 != CPU_TOPO_LEVEL_INVALID) {
> > +        env->cache_info_cpuid4.l3_cache->share_level = ms->smp_cache.l3;
> > +        env->cache_info_amd.l3_cache->share_level = ms->smp_cache.l3;
> > +    }
> > +
>
> I think this block of code can be further optimized. Maybe we can create
> a function called updateCacheShareLevel() that takes a cache pointer and
> a share level as arguments. This function encapsulates the common
> pattern of updating cache share levels for different caches. You can define
> it like this:
> void updateCacheShareLevel(XxxCacheInfo *cache, int shareLevel) {
>     if (shareLevel != CPU_TOPO_LEVEL_INVALID) {
>         cache->share_level = shareLevel;
>     }
> }
>

Good idea! Will try this way.

Thanks,
Zhao


