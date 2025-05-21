Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4F6C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 08:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHes6-0007Ru-5J; Wed, 21 May 2025 04:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHes3-0007RP-WC
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:32:16 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHerz-00024q-5z
 for qemu-devel@nongnu.org; Wed, 21 May 2025 04:32:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747816331; x=1779352331;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WYKrLqTpzo+Kn2nj+U3KFX7t/XvO3S/P5Se2toDBQk0=;
 b=Zyc1pSpRWzjc0Wix4h8rJOGMzCoIWpd0DOrkN0NKCgyFvpJNPCSMAwI3
 AgRPQpvqgkOb4ISDSU2fEKMhr7ga3fziU8IaD4c0sYt3+fbIpx/MixMHi
 ZjCqNdG6TdUc9F55/8UZnahL9KT5GnuEqTTeUvcmwYkOiEDbUyi3YPR8W
 g4UvwJnVT09Ms3tKFCAWx1f3/ReEpGJepncLi0AqYbokZCs3g/Xbq98z0
 aRaF7ho3HcHjXxH6/0BER6OgcUBP0+vh/+XX2PNtipSFVfDiOGAdrBRyt
 QrM0eiw99rwpSGVpYPgRGXzdLYniZsIbWYyeu3s1jM+C/lAVbJosEFYC5 w==;
X-CSE-ConnectionGUID: oyhCEL4oTDurDXrZPFN4pA==
X-CSE-MsgGUID: 3NoYIy4aRjWTOSeBSBaotg==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49043530"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="49043530"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 01:32:06 -0700
X-CSE-ConnectionGUID: 301eAhgwQDaptSZLeY+T+w==
X-CSE-MsgGUID: Q91BmB1sTdeyeJxBnk7oRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; d="scan'208";a="144698852"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 21 May 2025 01:32:04 -0700
Date: Wed, 21 May 2025 16:53:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>,
 Babu Moger <babu.moger@amd.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] i386/cpu: Fix topological field encoding & overflow
Message-ID: <aC2UduRVRiALRVyk@intel.com>
References: <20250227062523.124601-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227062523.124601-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.487,
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

Hi Paolo,

A gentle poke. There's no conflict for now. Do you agree with these
fixes?

Thanks,
Zhao

On Thu, Feb 27, 2025 at 02:25:19PM +0800, Zhao Liu wrote:
> Date: Thu, 27 Feb 2025 14:25:19 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH 0/4] i386/cpu: Fix topological field encoding & overflow
> X-Mailer: git-send-email 2.34.1
> 
> Hi,
> 
> This series collects and organizes several topology-related cleanups and
> fixes, based on b69801dd6b1e ("Merge tag 'for_upstream' of
> https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging").
> 
> Patch 1 is picked from Chuang's v6 [1].
> 
> Patch 2-3 are picked from Qian's v4 [2], though it had previously gone
> through sufficient review (got R/b tags), I dropped its R/b tags because
> of my code change.
> 
> Patch 4 is newly added, inspired by patch 3, to also perform a check on
> AMD's cache CPUID. This is to consider the current maximum number of
> supported CPUs, which is approaching the overflow boundary.
> 
> In addition to the 0x1, 0x4, and 0x8000001d leaves involved in the patch
> series, there is also the 0x1f leaf related to topology. However, the
> upper limit for CPUID.1FH.EBX[bits 15:0] is 65,535 threads, which
> provides enough room. Therefore, this field does not currently require
> overflow checks.
> 
> This series correct the CPUIDs, but it doesn't affect the Guest's live
> migration. Therefore, I did not add the compat property for this.
> 
> [1]: https://lore.kernel.org/qemu-devel/20241009035638.59330-1-xuchuangxclwt@bytedance.com/
> [2]: https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/
> 
> Thanks and Best Regards,
> Zhao
> ---
> Chuang Xu (1):
>   i386/cpu: Fix number of addressable IDs field for CPUID.01H.EBX[23:16]
> 
> Qian Wen (2):
>   i386/cpu: Fix cpu number overflow in CPUID.01H.EBX[23:16]
>   i386/cpu: Fix overflow of cache topology fields in CPUID.04H
> 
> Zhao Liu (1):
>   i386/cpu: Honor maximum value for CPUID.8000001DH.EAX[25:14]
> 
>  target/i386/cpu.c | 35 ++++++++++++++++++++++++++++-------
>  1 file changed, 28 insertions(+), 7 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

