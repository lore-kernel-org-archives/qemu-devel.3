Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9608AD3C53F
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 02:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1cbP-0008Tt-1G; Thu, 17 Oct 2024 22:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1cbN-0008TN-MI; Thu, 17 Oct 2024 22:20:29 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1cbL-0004yf-5r; Thu, 17 Oct 2024 22:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729218027; x=1760754027;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8PKsoPgR4Ld+C0xF/qZFXE3weaPnEMpOVlDjd59wIDw=;
 b=NGoZQCDc0frZ5uGb0x3DQDFg4ghw/jle5FeN2QyFgFBGnKNDuChRQ6zX
 Slulr7XJ0k6XHBHWLXWKjSe2Lr5PMQjq0shMA2z0YNXvK2HeGFAyJ2G8D
 4uAw2gIITrYQkk9/82oMYwdfoqCcsSftUwxV7Uw/N4Ry6bew7i+vjCzVm
 0WGi4TBQz7OysRtqtnRbrSDxT9EDjUgnvBidTWxxLcV4m5E67aEKtfQ1X
 c1csjp+SdxJPBiWp294uY2C0nbVgcAR7DpVuOup1pHkkU/xJtyKoVj0rL
 CohVaOln/P35QbLrTOtAL4eeQg+j5LmP9vh6oyfF55AMWLytEW2QBKD98 g==;
X-CSE-ConnectionGUID: gF2am3UfQSevXv2Hf5NICQ==
X-CSE-MsgGUID: ivJ5dVYjQim6xZpbJzhz7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28827909"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; d="scan'208";a="28827909"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2024 19:20:22 -0700
X-CSE-ConnectionGUID: L+YNHYlyR+6QwKMonGQkjw==
X-CSE-MsgGUID: GChpiH98T9WKlXP4N1D6Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="83557602"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 19:20:14 -0700
Date: Fri, 18 Oct 2024 10:36:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v3 1/7] hw/core: Make CPU topology enumeration
 arch-agnostic
Message-ID: <ZxHJri+rgdGKf/0L@intel.com>
References: <20241012104429.1048908-1-zhao1.liu@intel.com>
 <20241012104429.1048908-2-zhao1.liu@intel.com>
 <ZxEte1KBwWuCdkb1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZxEte1KBwWuCdkb1@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

Hi Daniel,

> > -/*
> > - * CPUTopoLevel is the general i386 topology hierarchical representation,
> > - * ordered by increasing hierarchical relationship.
> > - * Its enumeration value is not bound to the type value of Intel (CPUID[0x1F])
> > - * or AMD (CPUID[0x80000026]).
> > - */
> > -enum CPUTopoLevel {
> > -    CPU_TOPO_LEVEL_INVALID,
> > -    CPU_TOPO_LEVEL_SMT,
> > -    CPU_TOPO_LEVEL_CORE,
> > -    CPU_TOPO_LEVEL_MODULE,
> > -    CPU_TOPO_LEVEL_DIE,
> > -    CPU_TOPO_LEVEL_PACKAGE,
> > -    CPU_TOPO_LEVEL_MAX,
> > -};
> > -
> 
> snip
> 
> > @@ -18,3 +18,47 @@
> >  ##
> >  { 'enum': 'S390CpuEntitlement',
> >    'data': [ 'auto', 'low', 'medium', 'high' ] }
> > +
> > +##
> > +# @CpuTopologyLevel:
> > +#
> > +# An enumeration of CPU topology levels.
> > +#
> > +# @invalid: Invalid topology level.
> 
> Previously all topology levels were internal to QEMU, and IIUC
> this CPU_TOPO_LEVEL_INVALID appears to have been a special
> value to indicate  the cache was absent ?

Now I haven't support this logic.
x86 CPU has a "l3-cache" property, and maybe that property can be
implemented or replaced by the "invalid" level support you mentioned.

> Now we're exposing this directly to the user as a settable
> option. We need to explain what effect setting 'invalid'
> has on the CPU cache config.

If user set "invalid", QEMU will report the error message:

qemu-system-x86_64: Invalid cache topology level: invalid. The topology should match valid CPU topology level

Do you think this error message is sufficient?

Thanks,
Zhao


