Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FC3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOJu-0000iN-MT; Fri, 09 May 2025 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDHV9-00007I-HO
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:46:31 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDHV3-00089I-C0
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746773186; x=1778309186;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=B/S648cE9UMjrXY4G55L/9UarDhdPR/uC967jP+/D6Y=;
 b=L8RKvz6vCeGU9jkMbUZ5iRzlA+F/8tbTO5l+W5YV38+tmIrFMCxIvUZT
 oPgsQsyuDjYihLz/YfUcwXsuu5NW1JouxvlUSTZ3n/cArwh4AbJyNoGJC
 9wRie17CEOZ5TCf/iQ5ZB7W89UcU9DDlwm2aHVcRDcjQ9XJJZVBZan3GE
 iwsCxxZhWvRASL6DkDPuuj7aMvqfZHMA4fVp++liWWGP6oJ2zJP5wXYqi
 fIDQQk7S4JkmD2DXgpYb3wIejXW6SubGCTiUH/Wx2m1T1iuvM1B0VWqa9
 BLt1q5yHuKX9qvuglng2lKQyQixmq8+oTxKBRgRDro2pJxQgkLyJkx7MG w==;
X-CSE-ConnectionGUID: l2c31YCxR5KtAgM1OBPBbw==
X-CSE-MsgGUID: 0f2hOhTMTsGLql7Mb/ra8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48744116"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48744116"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:46:15 -0700
X-CSE-ConnectionGUID: zdojglEvRUWT+tIOOBWUpw==
X-CSE-MsgGUID: AyroqVwHRgiYPYok+xNV4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141482476"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 23:46:12 -0700
Message-ID: <013b36a9-9310-4073-b54c-9c511f23decf@linux.intel.com>
Date: Fri, 9 May 2025 14:41:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/13] ram-block-attribute: Introduce RamBlockAttribute
 to manage RAMBLock with guest_memfd
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-8-chenyi.qiang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250407074939.18657-8-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.18;
 envelope-from=baolu.lu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 09 May 2025 10:03:20 -0400
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

On 4/7/25 15:49, Chenyi Qiang wrote:
> Commit 852f0048f3 ("RAMBlock: make guest_memfd require uncoordinated
> discard") highlighted that subsystems like VFIO may disable RAM block
> discard. However, guest_memfd relies on discard operations for page
> conversion between private and shared memory, potentially leading to
> stale IOMMU mapping issue when assigning hardware devices to
> confidential VMs via shared memory. To address this, it is crucial to
> ensure systems like VFIO refresh its IOMMU mappings.
> 
> PrivateSharedManager is introduced to manage private and shared states in
> confidential VMs, similar to RamDiscardManager, which supports
> coordinated RAM discard in VFIO. Integrating PrivateSharedManager with
> guest_memfd can facilitate the adjustment of VFIO mappings in response
> to page conversion events.
> 
> Since guest_memfd is not an object, it cannot directly implement the
> PrivateSharedManager interface. Implementing it in HostMemoryBackend is
> not appropriate because guest_memfd is per RAMBlock, and some RAMBlocks
> have a memory backend while others do not. Notably, virtual BIOS
> RAMBlocks using memory_region_init_ram_guest_memfd() do not have a
> backend.
> 
> To manage RAMBlocks with guest_memfd, define a new object named
> RamBlockAttribute to implement the RamDiscardManager interface. This
> object stores guest_memfd information such as shared_bitmap, and handles
> page conversion notification. The memory state is tracked at the host
> page size granularity, as the minimum memory conversion size can be one
> page per request. Additionally, VFIO expects the DMA mapping for a
> specific iova to be mapped and unmapped with the same granularity.
> Confidential VMs may perform partial conversions, such as conversions on
> small regions within larger regions. To prevent invalid cases and until
> cut_mapping operation support is available, all operations are performed
> with 4K granularity.

Just for your information, IOMMUFD plans to introduce the support for
cut operation. The kickoff patch series is under discussion here:

https://lore.kernel.org/linux-iommu/0-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com/

This new cut support is expected to be exclusive to IOMMUFD and not
directly available in the VFIO container context. The VFIO uAPI for map/
unmap is being superseded by IOMMUFD, and all new features will only be
available in IOMMUFD.

> 
> Signed-off-by: Chenyi Qiang<chenyi.qiang@intel.com>

<...>

> +
> +int ram_block_attribute_realize(RamBlockAttribute *attr, MemoryRegion *mr)
> +{
> +    uint64_t shared_bitmap_size;
> +    const int block_size  = qemu_real_host_page_size();
> +    int ret;
> +
> +    shared_bitmap_size = ROUND_UP(mr->size, block_size) / block_size;
> +
> +    attr->mr = mr;
> +    ret = memory_region_set_generic_state_manager(mr, GENERIC_STATE_MANAGER(attr));
> +    if (ret) {
> +        return ret;
> +    }
> +    attr->shared_bitmap_size = shared_bitmap_size;
> +    attr->shared_bitmap = bitmap_new(shared_bitmap_size);

Above introduces a bitmap to track the private/shared state of each 4KB
page. While functional, for large RAM blocks managed by guest_memfd,
this could lead to significant memory consumption.

Have you considered an alternative like a Maple Tree or a generic
interval tree? Both are often more memory-efficient for tracking ranges
of contiguous states.

> +
> +    return ret;
> +}
> +
> +void ram_block_attribute_unrealize(RamBlockAttribute *attr)
> +{
> +    g_free(attr->shared_bitmap);
> +    memory_region_set_generic_state_manager(attr->mr, NULL);
> +}

Thanks,
baolu

