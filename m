Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CCC9C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trTve-0003Qq-4o; Sun, 09 Mar 2025 23:35:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trTvZ-0003QW-TF
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:35:42 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trTvX-0007v8-HM
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:35:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741577739; x=1773113739;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LXMGQOQfMpK8Ot0XRMhmYs2+5Wy8pzBjI6L07qFxgvo=;
 b=WGfX+66ZjbRiUJ1fdNLQvUxTKjz08/nEtne8uoyRVLP4/TTFlWLSWEj+
 hAsNsvvXuikJfPGEPSSlsipXYRsNzVpqcyOzZN3mB4hriTS3Mp5sWhIRm
 RAhPo1dmXG0y1OcgtLQz4wW6loedaIKbUnqbTU0KSfEypaz+diVJ/6say
 HPNFiBiC5fcosSvRuglgNylT7CqBNxJe4aWJoZHnYiApOGDjXiNl2F0Sn
 lTCDtDTp1Xp1yxZy2KPXSHo6TaEbHc3Xe2yVU9MmWwXb5/0KRbKccAqEs
 LkrAJAup8Udipdoma7QQXcOI5jcPQOXjZ3flCu9XNkbCKMBqzYqavjvcw g==;
X-CSE-ConnectionGUID: DQaZmgkaSzCQF78dXHR+cg==
X-CSE-MsgGUID: dx7eCxqSTFWMSqm0P/CFlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="45352874"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="45352874"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2025 20:35:36 -0700
X-CSE-ConnectionGUID: gkhPiYgGRZWuXQQ4yRtvVA==
X-CSE-MsgGUID: UFXEgryWS+CdMoFJ+c1w1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="157067879"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 09 Mar 2025 20:35:30 -0700
Date: Mon, 10 Mar 2025 11:55:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 05/10] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
Message-ID: <Z85ivB8XYyVKVurm@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-6-dongli.zhang@oracle.com>
 <Z8q5NHQeIgXxTmPO@intel.com>
 <23cca084-2081-408d-a360-22fad0ff5037@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23cca084-2081-408d-a360-22fad0ff5037@oracle.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> How about we still wrap in another new function with &cpuid_data.cpuid as
> an argument?
> 
> 1. In current patch, we need cpuid(0xa) to query Intel PMU info.
> 
> 2. In PATCH 08/10 (AMD), we need cpuid(0x80000001) to determine PERFCORE.
> 
> https://lore.kernel.org/all/20250302220112.17653-9-dongli.zhang@oracle.com/
> 
> (Otherwise, we may use ((env->features[FEAT_8000_0001_ECX] &
> CPUID_EXT3_PERFCORE), but I prefer something consistent)
> 
> 
> 3. In PATCH 09/10 (AMD PerfMonV2), we need cpuid(0x80000022) to query the
> PerfMonV2 support, and the number of PMU counters.
> 
> https://lore.kernel.org/all/20250302220112.17653-10-dongli.zhang@oracle.com/

Thanks, I see. This new function makes sense for me.

Regards,
Zhao


