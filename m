Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E207D5AE6F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 07:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8x7K-0006RM-5Y; Thu, 07 Nov 2024 02:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8x7E-0006R3-HW
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:39:41 -0500
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t8x7C-0005Rw-OU
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 02:39:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730965179; x=1762501179;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=o3PUuxafAuNLu0KCEN1nvG6vAa6h5dDNS9Y7mqKnbo8=;
 b=Y+HrKRzn5UP62EFE3iyTrAsAB9yrhxyf2QjbAB/HP3UUHnbTKutT5Hrr
 tspYHagnr7Kk8of3vvsF/9avfq4lpq7LtonDruxLG+okvvoBGUslrBAMB
 gMl/HxifAOO0OVONLWrh/pFZWOxoWSWCSn32DxjXVd3GxzWsA0/Aw5649
 YS0oZ0DYu7lP5IBDmGsLDt88n7/n/EAeKiu+9bHDX0k9HD5JuuzVM4MHZ
 /5ZnXjMe90+3Z6vbwm/rJovBStu81DXRhz73DRuKbL/yZ+IeRYwyXXENX
 6gN7GqunRhUlqPnMJL0LTroou90WvrfQC+q4vqEgEBBPvnoDucU443ibA w==;
X-CSE-ConnectionGUID: 0ciswIqiTPurBNlogKdR8A==
X-CSE-MsgGUID: 0rHIdBaCRNKBwsrkP5VVVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11248"; a="48312058"
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; d="scan'208";a="48312058"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2024 23:39:36 -0800
X-CSE-ConnectionGUID: xnS3xB5oS92ZYXiVssGaAw==
X-CSE-MsgGUID: KgYwXGwqQXaz1JOmikcEDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,265,1725346800"; d="scan'208";a="85762334"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa008.jf.intel.com with ESMTP; 06 Nov 2024 23:39:33 -0800
Date: Thu, 7 Nov 2024 15:57:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: dongli.zhang@oracle.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, lyan@digitalocean.com,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, joe.jin@oracle.com, davydov-max@yandex-team.ru
Subject: Re: [PATCH 1/7] target/i386: disable PerfMonV2 when PERFCORE
 unavailable
Message-ID: <Zyxy6IL5oOP1NFrn@intel.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
 <20241104094119.4131-2-dongli.zhang@oracle.com>
 <ZyroXEOsRPonKD7x@intel.com>
 <7497ade9-de05-49a9-9419-83e015646ebd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7497ade9-de05-49a9-9419-83e015646ebd@oracle.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

> Thank you very much for the suggestion.
> 
> Yes, this works. The PERFCORE is a prerequisite of PERFMON_V2 (according to
> Linux kernel source code).
> 
> 1403 static int __init amd_core_pmu_init(void)
> 1404 {
> 1405         union cpuid_0x80000022_ebx ebx;
> 1406         u64 even_ctr_mask = 0ULL;
> 1407         int i;
> 1408
> 1409         if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
> 1410                 return 0;
> 
> 
> If you don't mind, I will send the v2 with your Suggested-by.
> 
> Thank you very much!

Sure, welcome! :)

-Zhao

> Dongli Zhang

