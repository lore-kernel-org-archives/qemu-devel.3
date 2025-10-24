Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD704CCD193
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 00:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vC5UK-0000US-Ix; Thu, 23 Oct 2025 20:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC5UJ-0000UK-Ef
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 20:16:59 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vC5UH-0005co-DA
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 20:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761265018; x=1792801018;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=m+oB9nRr6GoH2ASh4gVO6tSysklw4I41lqQqcbbNQ84=;
 b=nzPwmo0Bt94U88TQzcVF1BkDrr+2yt3+7yg6eKpusDjme2pRWpf95DAX
 phdK4rg6c9z8QcMG/mBlGgBTluDnSyjcj3gvAHeGJRLe8ylIsQjfHGEhE
 RzYuiXUiOVAxnHdbEIRcqNng4A+wnVE2ksdjgVZ4WqLczZmfSYUndDXD/
 /6uHX33DemwoZVwJGGWLJ9clJwW5pjPWh+3+wBREdU+V7D7fvOqFjkls5
 08cKdKlizWLfAfIQ+aU5XTe7gFPlDQcPYZFYZXzWfuC8iF3stxJhhsLWv
 G3qWCCp7P0fVy3qz9X5f0IR5s1CZEhjKl+5Yba7GrrgN9aJqp3moGUJpo A==;
X-CSE-ConnectionGUID: Jg3Okx/mTYiszKt9uu+1vQ==
X-CSE-MsgGUID: 9n1xHiz8TPOH/V491kGSiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74886512"
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="74886512"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 17:16:56 -0700
X-CSE-ConnectionGUID: tD2J5tuGQd6SDVUNPOPeow==
X-CSE-MsgGUID: OC2x5hXJTGef457/jI96xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,251,1754982000"; d="scan'208";a="184365337"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2025 17:16:53 -0700
Message-ID: <d4b331bf-b5e6-4634-8f93-9b71eeb587c1@intel.com>
Date: Fri, 24 Oct 2025 08:16:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ram-block-attributes: Unify the retrieval of the
 block size
To: Chenyi Qiang <chenyi.qiang@intel.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gao Chao <chao.gao@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
References: <20251023095526.48365-1-chenyi.qiang@intel.com>
 <20251023095526.48365-3-chenyi.qiang@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20251023095526.48365-3-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
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

On 10/23/2025 5:55 PM, Chenyi Qiang wrote:
> There's an existing helper function designed to obtain the block size.
> Modify ram_block_attribute_create() to use this function for
> consistency.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Changes in v2:
>    - Newly added.
> ---
>   system/ram-block-attributes.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
> index a7579de5b46..cf8f5f41966 100644
> --- a/system/ram-block-attributes.c
> +++ b/system/ram-block-attributes.c
> @@ -390,7 +390,7 @@ int ram_block_attributes_state_change(RamBlockAttributes *attr,
>   
>   RamBlockAttributes *ram_block_attributes_create(RAMBlock *ram_block)
>   {
> -    const int block_size  = qemu_real_host_page_size();
> +    const int block_size  = ram_block_attributes_get_block_size();
>       RamBlockAttributes *attr;
>       MemoryRegion *mr = ram_block->mr;
>   


