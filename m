Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C96C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOJx-0000kC-PO; Fri, 09 May 2025 10:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDJdc-0001s0-8D
 for qemu-devel@nongnu.org; Fri, 09 May 2025 05:03:24 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDJda-0008AQ-5P
 for qemu-devel@nongnu.org; Fri, 09 May 2025 05:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746781402; x=1778317402;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=l8JyMGZ0zcKsAe3qZtfcs7BWyCr+6rRWirZwK992pLE=;
 b=a+0kIX0XMu+4BxoD1F1L1osAwqAagH1IrGU9vxyJPYFB7c8rQxnKQjz7
 0kzxyBAHZGHi9lOawCOEIJZ1ybbuXltJbqco0Ur7LgFozukKipdjIy5x8
 Hu9+5349tt9mDDIqEzLV6YHbo/e5PCVoQE3e+LrBlJi0WXRMFaAhx7IMm
 d2AxTg8pOZRYf5YUYs0biYxjbPbCtJXECwipEwWHnRkH0w2FFZMWzMP+1
 8/Q+QSxuULQCKSveuvAUycHX+dt3Tqj/2V5TMi5M7TbvTofxEGV0GyYzs
 wiWTkihMYvfQqLVw1byJhL+J46MQRzH3XpJjPseEpKaghX0+e03FblBWG Q==;
X-CSE-ConnectionGUID: OhdA4DhQQt29z7pEw4A1rA==
X-CSE-MsgGUID: Inuo0Bq9RSaWyKp9MLtPbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="47710669"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="47710669"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 02:03:19 -0700
X-CSE-ConnectionGUID: uinuH+qaQ/6OZxWPwkGL1g==
X-CSE-MsgGUID: AmgzoiFRRviovWwpyWw7RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141663661"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.236])
 ([10.124.240.236])
 by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 02:03:15 -0700
Message-ID: <f6b9c107-4f6c-43d5-99f9-c5663cffb0cf@linux.intel.com>
Date: Fri, 9 May 2025 17:03:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 11/13] KVM: Introduce CVMPrivateSharedListener for
 attribute changes during page conversions
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-12-chenyi.qiang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250407074939.18657-12-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=192.198.163.19;
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

On 4/7/2025 3:49 PM, Chenyi Qiang wrote:
> With the introduction of the RamBlockAttribute object to manage
> RAMBlocks with guest_memfd and the implementation of
> PrivateSharedManager interface to convey page conversion events, it is
> more elegant to move attribute changes into a PrivateSharedListener.
> 
> The PrivateSharedListener is reigstered/unregistered for each memory
> region section during kvm_region_add/del(), and listeners are stored in
> a CVMPrivateSharedListener list for easy management. The listener
> handler performs attribute changes upon receiving notifications from
> private_shared_manager_state_change() calls. With this change, the
> state changes operations in kvm_convert_memory() can be removed.
> 
> Note that after moving attribute changes into a listener, errors can be
> returned in ram_block_attribute_notify_to_private() if attribute changes
> fail in corner cases (e.g. -ENOMEM). Since there is currently no rollback
> operation for the to_private case, an assert is used to prevent the
> guest from continuing with a partially changed attribute state.

 From the kernel IOMMU subsystem's perspective, this lack of rollback
might not be a significant issue. Currently, converting memory pages
from shared to private involves unpinning the pages and removing the
mappings from the IOMMU page table, both of which are typically non-
failing operations.

But, in the future, when it comes to partial conversions, there might be
a cut operation before the VFIO unmap. The kernel IOMMU subsystem cannot
guarantee an always-successful cut operation.

Thanks,
baolu

