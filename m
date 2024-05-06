Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B26C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 07:19:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3scH-0002fY-LW; Mon, 06 May 2024 03:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3sc6-0002ey-78
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:18:18 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s3sc3-0000kR-C1
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1714979895; x=1746515895;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=cFirAcoZTRqKJ0iTk0DBL2WwrpmPyYIfO3yUwwGZOEo=;
 b=iAlosSfttNvO+221VT257NCJJtFhLh344Y6+2e5Qhjs69f47Kb/YeyYd
 sXVPP0EoiSKwgzWKVt8iDbjhU9/wlQ88v3Gq/2JVJvNhWEfGj8vpERL9M
 FN1wokhJ1zOr5sxO/SMPuqkyvTYhutEvjl+tO66Nw26GECUwp4pN3VYG1
 kbwX+pRGorKtIxWnWUigwyR4VeeOAgZoSC+wh/wNdqmUolBxGJ0PXxX6O
 epHN0InMhpI0b6Nz+7mvZc3JpmtV4VLjQnTXG4HtBYLNM8nprRIKWNw0J
 LZcXJGUeY+xLVIw36UTJtZqJJAZbbH8AbcDL18WOVediYUepIQaAEW/Lo g==;
X-CSE-ConnectionGUID: bbHgnzUVSCeZSU4nLUTdFw==
X-CSE-MsgGUID: C7hk6K+vSdWjhFSumFaCkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="13656876"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="13656876"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2024 00:18:12 -0700
X-CSE-ConnectionGUID: f9xDeTiUQHeKMsD+XB8KEg==
X-CSE-MsgGUID: 8oLN0wnCRg+q+bMEHLQhqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; d="scan'208";a="28162719"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa010.fm.intel.com with ESMTP; 06 May 2024 00:18:10 -0700
Date: Mon, 6 May 2024 15:32:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Tejus GK <tejus.gk@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Babu Moger <babu.moger@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v11 19/21] i386: Add cache topology info in CPUCacheInfo
Message-ID: <ZjiHhVSEjyxitWvg@intel.com>
References: <20240424154929.1487382-1-zhao1.liu@intel.com>
 <20240424154929.1487382-20-zhao1.liu@intel.com>
 <6766AC1F-96D1-41F0-AAEB-CE4158662A51@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6766AC1F-96D1-41F0-AAEB-CE4158662A51@nutanix.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
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

Hi Tejus,

(Also +Paolo/Daniel)

On Tue, Apr 30, 2024 at 06:14:52AM +0000, Tejus GK wrote:
> Date: Tue, 30 Apr 2024 06:14:52 +0000
> From: Tejus GK <tejus.gk@nutanix.com>
> Subject: Re: [PATCH v11 19/21] i386: Add cache topology info in CPUCacheInfo
> 
> 
> 
> On 24 Apr 2024, at 9:19 PM, Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> @@ -2140,6 +2164,7 @@ static const CPUCaches epyc_milan_cache_info = {
>         .lines_per_tag = 1,
>         .self_init = 1,
>         .no_invd_sharing = true,
> +        .share_level = CPU_TOPO_LEVEL_CORE,
>     },
>     .l1i_cache = &(CPUCacheInfo) {
>         .type = INSTRUCTION_CACHE,
> @@ -2152,6 +2177,7 @@ static const CPUCaches epyc_milan_cache_info = {
>         .lines_per_tag = 1,
>         .self_init = 1,
>         .no_invd_sharing = true,
> +        .share_level = CPU_TOPO_LEVEL_CORE,
>     },
>     .l2_cache = &(CPUCacheInfo) {
>         .type = UNIFIED_CACHE,
> @@ -2162,6 +2188,7 @@ static const CPUCaches epyc_milan_cache_info = {
>         .partitions = 1,
>         .sets = 1024,
>         .lines_per_tag = 1,
> +        .share_level = CPU_TOPO_LEVEL_CORE,
>     },
>     .l3_cache = &(CPUCacheInfo) {
>         .type = UNIFIED_CACHE,
> @@ -2175,6 +2202,7 @@ static const CPUCaches epyc_milan_cache_info = {
>         .self_init = true,
>         .inclusive = true,
>         .complex_indexing = true,
> +        .share_level = CPU_TOPO_LEVEL_DIE,
>     },
> };
> 
> 
> Hi Zhao and Babu, thank you for this patch. I have a slightly
> off-topic question about this patch. Firstly, many AMD CPU models
> have pre-defined cache sizes for the various cache levels; how are
> these values decided? I couldn't figure that out from the patches that
> introduced those changes.

I understand the AMD pre-defined cache idea started from this
discussion:

https://lore.kernel.org/qemu-devel/20180320175427.GU3417@localhost.localdomain/

From the discussion, it appears that AMD's cache information is encoded
according to the spec/datasheet for each generation of EPYC.

> Secondly, there isn't any pre-defined cache size for Intel, and the
> legacy cache values are used. This value can be vastly different from
> what actual available caches might be. Is there any reason why
> something like that for Intel has yet to be introduced?

Previously, there should be a lack of reason to introduce on Intel side,
or haven't met the relevant need/issue before.

I understand that AMD's reason is to make the cache information in the
Guest with a specific CPU model look more correct and to be able to
better emulate the Host environment.

Hi @Paolo and @Daniel, do you think Intel should also add correct cache
info for each CPU model?

Thanks,
Zhao


