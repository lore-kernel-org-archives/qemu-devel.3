Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34A1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:22:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tppdE-0004dF-7K; Wed, 05 Mar 2025 09:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tppdB-0004bv-Ny
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:21:54 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tppd7-0005gO-3v
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:21:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741184509; x=1772720509;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=bnMfchWzPl1XtUrU0nbIzpEbDv6J0UZh8/s9tPzJ42w=;
 b=MUKBbwy+ihZSdxLstl7ooEOIZjPgkoQVg2IiIXOSnWDDAd+FNR+sd3tB
 lS8iGxHQVdtByu/zcMQryY0X2v7S8HlNHaSwlcjZmicN51FTUdmKZKLoH
 3doapH5/IcjH/9+P8BJonkl+na88/gaXT2iJ26Jln/045jvK2ilVYixYI
 a9EZ5hGKgCLRe8B0H9HwGsHCMipD7y9YPfiDXzfxUpIP17a2dXalu7qyB
 sp54a1wNaG4AFBvQpdRash0qq5OJtHq8l/LNa3ru0lJlgdtce7ghwtZhM
 tU1hUzi3k1oN7kJ3ErWUeLPcbM4Sh1i0LEVUEJfrQJtjI2hw4N0cdnBTC g==;
X-CSE-ConnectionGUID: vo7lKGNxRUytg4+BbRzLVw==
X-CSE-MsgGUID: RCjdDQcpTH2rkK++mV9xDg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42277010"
X-IronPort-AV: E=Sophos;i="6.14,223,1736841600"; d="scan'208";a="42277010"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 06:21:44 -0800
X-CSE-ConnectionGUID: efI84FRRROWbVW0d+MOEfA==
X-CSE-MsgGUID: NvbSPA3CQ7mmchWuqvw1/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="118623962"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 05 Mar 2025 06:21:40 -0800
Date: Wed, 5 Mar 2025 22:41:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, pbonzini@redhat.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: Re: [PATCH v2 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if
 "-pmu" is configured
Message-ID: <Z8hiqwz4ExgWfRFR@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-5-dongli.zhang@oracle.com>
 <76da2b4a-2dc4-417c-91bc-ad29e08c8ba0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76da2b4a-2dc4-417c-91bc-ad29e08c8ba0@intel.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

> > +        if (has_pmu_cap && !X86_CPU(cpu)->enable_pmu) {
> 
> One nit, it's safer to use
> 
> 	(has_pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu
> 
> Maybe we can rename has_pmu_cap to pmu_cap as well.

Yes, I agree.

Regards,
Zhao


