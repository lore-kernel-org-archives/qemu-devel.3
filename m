Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092DEC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 16:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLuM-0005dO-IF; Mon, 14 Jul 2025 12:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubKyF-0003dJ-IM
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:20:00 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ubKyB-0002Lp-Fm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752506396; x=1784042396;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=3TFMp5LO/2slN6dVm1vpSPE+9igU+5m9IduE/JKJ7DM=;
 b=UUdCHzrfpI75A96my0KAIPqlC56/f0SkljCPLEC1yKtBsnJE7+OATXcJ
 AqmhJBbmD+zgyzX/mOIDpmxTALCWhCTbTIkZSfXjedCTORyYlB1vm6OAp
 6HNYQhJTSthwtJ+enxdZiZDhWa/Y/aI+kWOyOZdn+k5VI16u90Ma4zCEs
 wVkrikkJXv6+yu0T2yiVq9cOeKNyXF/ujqnQsnEV13IcEjmRf9K0GxGsS
 x0SMu5qO4HgVcWadSUVT0qSgWHq1zGx0cKztO/6MC2GtXjxL3XLmYAQMy
 NVcBz/SD1zpFiS7GBp9m8E24Ajx4gu5eQKAbdkkLVIfkf9YBVkfXCXr5b g==;
X-CSE-ConnectionGUID: v86rkqBBR6awI/tQK0zFug==
X-CSE-MsgGUID: 6kio4n4VT1q+Pq1bqvMLtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="77236660"
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="77236660"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2025 08:19:51 -0700
X-CSE-ConnectionGUID: tuYErg4NTY2OE+ckX3L4+Q==
X-CSE-MsgGUID: uijobc+2SxiQG5YX7VGrmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,311,1744095600"; d="scan'208";a="162625585"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 14 Jul 2025 08:19:48 -0700
Date: Mon, 14 Jul 2025 23:41:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ewan Hai <ewanhai-oc@zhaoxin.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Tao Su <tao1.su@intel.com>,
 Yi Lai <yi1.lai@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 7/7] i386/cpu: Honor maximum value for
 CPUID.8000001DH.EAX[25:14]
Message-ID: <aHUlHjzYWUM/ryQy@intel.com>
References: <20250714080859.1960104-1-zhao1.liu@intel.com>
 <20250714080859.1960104-8-zhao1.liu@intel.com>
 <d19082cc-6662-4299-89c6-94657ce672f7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d19082cc-6662-4299-89c6-94657ce672f7@amd.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jul 14, 2025 at 09:51:25AM -0500, Moger, Babu wrote:
> Date: Mon, 14 Jul 2025 09:51:25 -0500
> From: "Moger, Babu" <babu.moger@amd.com>
> Subject: Re: [PATCH v2 7/7] i386/cpu: Honor maximum value for
>  CPUID.8000001DH.EAX[25:14]
> 
> Hi Zhao,
> 
> On 7/14/25 03:08, Zhao Liu wrote:
> > CPUID.8000001DH:EAX[25:14] is "NumSharingCache", and the number of
> > logical processors sharing this cache is the value of this field
> > incremented by 1. Because of its width limitation, the maximum value
> > currently supported is 4095.
> > 
> > Though at present Q35 supports up to 4096 CPUs, by constructing a
> > specific topology, the width of the APIC ID can be extended beyond 12
> > bits. For example, using `-smp threads=33,cores=9,modules=9` results in
> > a die level offset of 6 + 4 + 4 = 14 bits, which can also cause
> > overflow. Check and honor the maximum value as CPUID.04H did.
> > 
> > Cc: Babu Moger <babu.moger@amd.com>
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> > Changes Since RFC v1 [*]:
> >  * Correct the RFC's description, now there's the overflow case. Provide
> >    an overflow example.
> > 
> > RFC:
> >  * Although there are currently no overflow cases, to avoid any
> >    potential issue, add the overflow check, just as I did for Intel.
> > 
> > [*]: https://lore.kernel.org/qemu-devel/20250227062523.124601-5-zhao1.liu@intel.com/
> > ---
> >  target/i386/cpu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index fedeeea151ee..eceda9865b8f 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -558,7 +558,8 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
> >  
> >      *eax = CACHE_TYPE(cache->type) | CACHE_LEVEL(cache->level) |
> >                 (cache->self_init ? CACHE_SELF_INIT_LEVEL : 0);
> > -    *eax |= max_thread_ids_for_cache(topo_info, cache->share_level) << 14;
> > +    /* Bits 25:14 - NumSharingCache: maximum 4095. */
> > +    *eax |= MIN(max_thread_ids_for_cache(topo_info, cache->share_level), 4095) << 14;
> 
> Will this be more meaningful?
> 
> *eax |=
>  max_thread_ids_for_cache(topo_info, cache->share_level) & 0xFFF << 14

Hi Babu, thank you for your feedback! This approach depends on truncation,
which might lead to more erroneous conclusions. Currently, such cases
shouldn't exist on actual hardware; it's only QEMU that supports so many
CPUs and custom topologies.

Previously, when Intel handled similar cases (where the topology space
wasn't large enough), it would encode the maximum value rather than
truncate, as I'm doing now (you can refer to the description of 0x1 in
patch 5, and similar fixes in Intel's 0x4 leaf in patch 6). In the
future, if actual hardware CPUs reach such numbers and has special
behavior, we can update accordingly. I think at least for now, this
avoids overflow caused by special topology in QEMU emulation.

Thanks,
Zhao


