Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740A4C5B549
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLl0Y-0008Tc-Do; Sun, 01 Jun 2025 11:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uLl0V-0008R4-Ez
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:53:55 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uLl0T-0007Cw-LB
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:53:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748793234; x=1780329234;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=a+rsVvs42P6P6HnIX16lnuDZ8+2PuELJSaeSCvUQPDU=;
 b=dWlrmJwc9qFjCaHwtGQCkWZjDHSA/iNmGqB9EkUHdurg654J8XLpBxTg
 LswPnQE9egKVehV6dW5vd5aXkf12qp9IPlAy8gS231WhYi34KJN8ttugg
 XCKTcCA2HFELB8pHPuOnQ2phVTc6kqFiUmmPkVfOc1Epw0HLc9ueITKv/
 hCVkQMQwmapst+fFwajNHMpCjgLrohAxP3ZDdbnf2vhBiSpUB5aOI0cli
 3wQtLiYgk81z86syCpg6zYUMh9iCNPQB//ipPTupVMZ8QdMpDjz/aZndY
 8Kbb4QkIYhsNJLhdASoM5tJQQHsmiAcQQLXpnlVLDGBtpj5uP04wtVxJi Q==;
X-CSE-ConnectionGUID: uwj1U8fBQ8iPFzt3YmxJrQ==
X-CSE-MsgGUID: wDpTd1QeR1u/7cqrXcD3HQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11450"; a="62168623"
X-IronPort-AV: E=Sophos;i="6.16,201,1744095600"; d="scan'208";a="62168623"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2025 08:53:51 -0700
X-CSE-ConnectionGUID: XMtRHrsaQS+W0lNbolr6dg==
X-CSE-MsgGUID: cK9aRdw0QnWkSgkcFQidbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,201,1744095600"; d="scan'208";a="144306076"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2025 08:53:47 -0700
Message-ID: <ad5f550b-5d74-4635-996e-1b1d754e727f@intel.com>
Date: Sun, 1 Jun 2025 23:53:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] memory: Change
 memory_region_set_ram_discard_manager() to return the result
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
 <20250530083256.105186-3-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250530083256.105186-3-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
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
> Modify memory_region_set_ram_discard_manager() to return -EBUSY if a
> RamDiscardManager is already set in the MemoryRegion. The caller must
> handle this failure, such as having virtio-mem undo its actions and fail
> the realize() process. Opportunistically move the call earlier to avoid
> complex error handling.
> 
> This change is beneficial when introducing a new RamDiscardManager
> instance besides virtio-mem. After
> ram_block_coordinated_discard_require(true) unlocks all
> RamDiscardManager instances, only one instance is allowed to be set for
> one MemoryRegion at present.
> 
> Suggested-by: David Hildenbrand<david@redhat.com>
> Reviewed-by: David Hildenbrand<david@redhat.com>
> Signed-off-by: Chenyi Qiang<chenyi.qiang@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

