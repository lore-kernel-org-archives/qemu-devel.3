Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE39C36010
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Apr 2025 08:32:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1htA-0006XX-VH; Mon, 07 Apr 2025 04:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u1ht6-0006Kj-QP
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:31:25 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u1ht0-0003U8-0L
 for qemu-devel@nongnu.org; Mon, 07 Apr 2025 04:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744014678; x=1775550678;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=kZrG6A3qreL/i86/K2NTwOlUnRVT2U3MzsiWZCErg/E=;
 b=CM2kQAEtIEXBq9tQux1uG0J4oCMGhk4Vs//Sg+Fd9yuIJ/qmdNaPSbV2
 BmhX3h39Yv3X4dAljKHpXHqehodGiXxb762PEbtuNh1XDId7NccchTxU1
 PA06vOJNyQY8Nbew5l1fH6XGpsJ7KpLeZgsKAa74Z1jBUp8shcqiLdI2L
 HAoy74ofseADnQGey2OKgSTc1S8mtLxqzGwT4f+a8mg319pfX69UKNnIg
 glK6r16fQ6ePrx8k+Fdpt5fno1YvBogDhkdCx+hnwZC7AEYVbMYDKvEqN
 PtmzD/gFVpCM43eNp9JgJCifnnTfCg2cL7w/ISc9jqavfGVImm8hlez5o g==;
X-CSE-ConnectionGUID: AhRwysDcTHCfiQ4RAt2eYg==
X-CSE-MsgGUID: oLdqT5qGT6i28PS2woXX9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11396"; a="49179683"
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="49179683"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2025 01:31:15 -0700
X-CSE-ConnectionGUID: 3UnJmUBtRACuOGFOxL2hig==
X-CSE-MsgGUID: /fy17LQ3TmGx2BKsh8y5Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,193,1739865600"; d="scan'208";a="158851027"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 07 Apr 2025 01:31:09 -0700
Date: Mon, 7 Apr 2025 16:51:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Ewan Hai <ewanhai-oc@zhaoxin.com>
Cc: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, pbonzini@redhat.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, louisqi@zhaoxin.com, liamni@zhaoxin.com,
 frankzhu@zhaoxin.com, silviazhao@zhaoxin.com
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
Message-ID: <Z/OSEw+yJkN89aDG@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <8a547bf5-bdd4-4a49-883a-02b4aa0cc92c@zhaoxin.com>
 <84653627-3a20-44fd-8955-a19264bd2348@oracle.com>
 <e3a64575-ab1f-4b6f-a91d-37a862715742@zhaoxin.com>
 <a94487ab-b06d-4df4-92d8-feceeeaf5ec3@oracle.com>
 <65a6e617-8dd8-46ee-b867-931148985e79@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65a6e617-8dd8-46ee-b867-931148985e79@zhaoxin.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.659,
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

On Tue, Apr 01, 2025 at 11:35:49AM +0800, Ewan Hai wrote:
> Date: Tue, 1 Apr 2025 11:35:49 +0800
> From: Ewan Hai <ewanhai-oc@zhaoxin.com>
> Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers
>  during VM reset
> 
> > > [2] As mentioned in [1], QEMU always sets the vCPU's vendor to match the host's
> > > vendor
> > > when acceleration (KVM or HVF) is enabled. Therefore, if users want to emulate a
> > > Zhaoxin CPU on an Intel host, the vendor must be set manually.Furthermore,
> > > should we display a warning to users who enable both vPMU and KVM acceleration
> > > but do not manually set the guest vendor when it differs from the host vendor?
> > 
> > Maybe not? Sometimes I emulate AMD on Intel host, while vendor is still the
> > default :)
> 
> Okay, handling this situation can be rather complex, so let's keep it
> simple. I have added a dedicated function to capture the intended behavior
> for potential future reference.
> 
> Anyway, Thanks for taking Zhaoxin's situation into account, regardless.
> 

Thanks for your code example!!

Zhaoxin implements perfmon v2, so I think checking the vendor might be
overly complicated. If a check is needed, it seems more reasonable to
check the perfmon version rather than the vendor, similar to how avx10
version is checked in x86_cpu_filter_features().

I understand Ewan's concern is that if an Intel guest requires a higher
perfmon version that the Zhaoxin host doesn't support, there could be
issues (although I think this situation doesn't currently exist in KVM-QEMU,
one reason is QEMU uses the pmu_version in 0xa queried from KVM directly,
which means QEMU currently doesn't support custom pmu_version).

(I'll help go through Dongli's v3 soon.)

Thank you both,
Zhao


