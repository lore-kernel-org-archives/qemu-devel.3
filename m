Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5783AC5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 02:47:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgyM7-0006l8-Tr; Sun, 03 Mar 2024 21:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rgyM5-0006km-TY
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 21:47:05 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ying.huang@intel.com>)
 id 1rgyM4-00065u-AG
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 21:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709520424; x=1741056424;
 h=from:to:cc:subject:in-reply-to:references:date:
 message-id:mime-version;
 bh=NpJ3kMXPkFPpAOq7sPat1SWaWWApgyHoKsLSe8iwW2k=;
 b=m9JUpqYc/ETsg2VikOg98LU7XLxT0QJlAeNqPO/SF2udBrqbnd9ZeFwT
 jpDOSDSXtrKFbm+TYDHi+7xKB6C5ybDkLGRUGiIf3qgFx4EnRO2apju7s
 GBas1NOZPoUDedKnvkRLNyvRcMjngtb4GAewgOXOwDFQ5mIzk9yFjEf2c
 /S2tZRi9U/jwrR3ArJ2KB5/bYZnF45jWiUOwgmmvYrAp4BGJH9uSzvIhc
 uRsEg/dPsWUToPOvFzhS9JKx+R4iXy8thBrXBf6GDZeS04Z7+/KhAf41t
 vTmjAWRMDoIsT0FfGun1ZJUUZsg0fbGF2f/EsP+JQIpRioU6bCH9rwW7l Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="4115026"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="4115026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 18:47:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="32002826"
Received: from yhuang6-desk2.sh.intel.com (HELO
 yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
 by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 18:46:56 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Cc: "Hao Xiang" <hao.xiang@bytedance.com>,  "Gregory Price"
 <gourry.memverge@gmail.com>,  aneesh.kumar@linux.ibm.com,
 mhocko@suse.com,  tj@kernel.org,  john@jagalactic.com,  "Eishan Mirakhur"
 <emirakhur@micron.com>,  "Vinicius Tavares Petrucci"
 <vtavarespetr@micron.com>,  "Ravis OpenSrc" <Ravis.OpenSrc@micron.com>,
 "Alistair Popple" <apopple@nvidia.com>,  "Rafael J. Wysocki"
 <rafael@kernel.org>,  Len Brown <lenb@kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Dave Jiang <dave.jiang@intel.com>,  Dan
 Williams <dan.j.williams@intel.com>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  "Ho-Ren (Jack)
 Chuang" <horenc@vt.edu>,  "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>,
 linux-cxl@vger.kernel.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v1 0/1] Improved Memory Tier Creation for CPUless NUMA
 Nodes
In-Reply-To: <20240301082248.3456086-1-horenchuang@bytedance.com> (Ho-Ren
 Chuang's message of "Fri, 1 Mar 2024 08:22:44 +0000")
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
Date: Mon, 04 Mar 2024 10:45:02 +0800
Message-ID: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Received-SPF: pass client-ip=198.175.65.16; envelope-from=ying.huang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

"Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:

> The memory tiering component in the kernel is functionally useless for
> CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the nodes
> are lumped together in the DRAM tier.
> https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A@PH0PR08MB7955.namprd08.prod.outlook.com/T/

I think that it's unfair to call it "useless".  Yes, it doesn't work if
the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
please be specific about in which cases it doesn't work instead of too
general "useless".

> This patchset automatically resolves the issues. It delays the initialization
> of memory tiers for CPUless NUMA nodes until they obtain HMAT information
> at boot time, eliminating the need for user intervention.
> If no HMAT specified, it falls back to using `default_dram_type`.
>
> Example usecase:
> We have CXL memory on the host, and we create VMs with a new system memory
> device backed by host CXL memory. We inject CXL memory performance attributes
> through QEMU, and the guest now sees memory nodes with performance attributes
> in HMAT. With this change, we enable the guest kernel to construct
> the correct memory tiering for the memory nodes.
>
> Ho-Ren (Jack) Chuang (1):
>   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
>     HMAT info
>
>  drivers/acpi/numa/hmat.c     |  3 ++
>  include/linux/memory-tiers.h |  6 +++
>  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
>  3 files changed, 77 insertions(+), 8 deletions(-)

--
Best Regards,
Huang, Ying

