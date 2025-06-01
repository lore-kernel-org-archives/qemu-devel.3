Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955E6C5B555
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkrR-0006b4-F8; Sun, 01 Jun 2025 11:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uLkrO-0006am-O0
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:44:30 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uLkrM-0006TF-D9
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:44:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748792669; x=1780328669;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CrzePAb4bB7XgRH1J0UXaTlj3s1yRQ9aXdOygA9u6iw=;
 b=i/0SXLjwxuwG/V1v63dvdA9ejCxl+DX4zfVSs7Q48BaUBfxPAenjrm92
 1xHEXsXWAxdOV9E91iyVTvlZ+8gzeydmSbzH8R71vRy8KlpVMIZRmDREY
 ldcI4Jhes9+lOEnnx7LkEQXQCwbPH6C0+t/ghrr2vfyX8HHXxXkbQHN11
 8hCnTgpSpJ23B9OpcsKbme18bm5E6RARsI4zB8uI5RncTwyJtngINO6i9
 yeZ1gb6lOirPWKvOiUcUhyhqWyGsyJ5oYuF3p8SU2UleptnYV2WJfAPt9
 YingS7zEQ7RDntRiKvSXEh4Q4ONHdavWmfsose+Yffau04SDxfGHjBPVV w==;
X-CSE-ConnectionGUID: 1O0Yt7JjRF6C8PoSSQIvfQ==
X-CSE-MsgGUID: 8t6oZnzNQTqGXsepFd6r8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="50517333"
X-IronPort-AV: E=Sophos;i="6.16,201,1744095600"; d="scan'208";a="50517333"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2025 08:44:25 -0700
X-CSE-ConnectionGUID: 4RaEFyP8SvqAErzzBo7uyQ==
X-CSE-MsgGUID: x5GmQESmQLKTuiau8cRcjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,201,1744095600"; d="scan'208";a="175340974"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2025 08:44:19 -0700
Message-ID: <a5fbaad2-87c2-4791-8728-39db9e977521@intel.com>
Date: Sun, 1 Jun 2025 23:44:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/5] memory: Export a helper to get intersection of a
 MemoryRegionSection with a given range
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 Baolu Lu <baolu.lu@linux.intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Alex Williamson <alex.williamson@redhat.com>
References: <20250530083256.105186-1-chenyi.qiang@intel.com>
 <20250530083256.105186-2-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250530083256.105186-2-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/30/2025 4:32 PM, Chenyi Qiang wrote:
> Rename the helper to memory_region_section_intersect_range() to make it
> more generic. Meanwhile, define the @end as Int128 and replace the
> related operations with Int128_* format since the helper is exported as
> a wider API.
> 
> Suggested-by: Alexey Kardashevskiy<aik@amd.com>
> Reviewed-by: Alexey Kardashevskiy<aik@amd.com>
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Reviewed-by: Zhao Liu<zhao1.liu@intel.com>
> Signed-off-by: Chenyi Qiang<chenyi.qiang@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

