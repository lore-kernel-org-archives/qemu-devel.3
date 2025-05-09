Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B439C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 14:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDOJw-0000jn-OH; Fri, 09 May 2025 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDJx5-00032u-9h
 for qemu-devel@nongnu.org; Fri, 09 May 2025 05:23:31 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <baolu.lu@linux.intel.com>)
 id 1uDJx2-0002mw-Vl
 for qemu-devel@nongnu.org; Fri, 09 May 2025 05:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746782609; x=1778318609;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iFMZIw+14kY1d7IgnZ74KIDB4WWlMeVYLeVjbCOX2dM=;
 b=XI1wQ0AZ7h9H47agV/LbQkVHIpx1a7wrTHvODhiRwK3kBM1yEI3axPVg
 aw3tgD1QV9onKyG/xjTC7u7ig7il8h4wet/Qonr03GAZWUiS+pncCNn+6
 fMG2InkBMf+jgy25hvj1Di1lPXCUAzPQQDvYwVUJJ1G7nJk53/R0pdZaG
 IRCi/5TWWFiy4MC1uTLxHUlHVcxg5fvjYPL+NYSVz6IABtMyykVScFKE6
 w6mmTc7TkVw3HIwzyzIyXyYymofUl0Y6edKFI9d95GgMHnX6OAzuKtpJW
 xjyHx9XJgwkCucuABa18OeQVFhVSrmSzaREJOg8jzEm+lw+GocipsZses A==;
X-CSE-ConnectionGUID: WSqZKe5+ThmnkQ50eNViqg==
X-CSE-MsgGUID: 5zkip3oUR1CpFebeSGIyjA==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48609168"
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="48609168"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 02:23:27 -0700
X-CSE-ConnectionGUID: HBHVEMxFRIKC7P0+mu0rog==
X-CSE-MsgGUID: EjiDTsgnRJqTNFKFc6Id4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,274,1739865600"; d="scan'208";a="141474549"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.240.236])
 ([10.124.240.236])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2025 02:23:23 -0700
Message-ID: <e089f11a-da4c-44c9-8553-3492e236d4aa@linux.intel.com>
Date: Fri, 9 May 2025 17:23:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Williams Dan J <dan.j.williams@intel.com>,
 Peng Chao P <chao.p.peng@intel.com>, Gao Chao <chao.gao@intel.com>,
 Xu Yilun <yilun.xu@intel.com>, Li Xiaoyao <xiaoyao.li@intel.com>
Subject: Re: [PATCH v4 12/13] ram-block-attribute: Add priority listener
 support for PrivateSharedListener
To: Chenyi Qiang <chenyi.qiang@intel.com>,
 David Hildenbrand <david@redhat.com>, Alexey Kardashevskiy <aik@amd.com>,
 Peter Xu <peterx@redhat.com>, Gupta Pankaj <pankaj.gupta@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>
References: <20250407074939.18657-1-chenyi.qiang@intel.com>
 <20250407074939.18657-13-chenyi.qiang@intel.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20250407074939.18657-13-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=198.175.65.17;
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
> In-place page conversion requires operations to follow a specific
> sequence: unmap-before-conversion-to-private and
> map-after-conversion-to-shared. Currently, both attribute changes and
> VFIO DMA map/unmap operations are handled by PrivateSharedListeners,
> they need to be invoked in a specific order.
> 
> For private to shared conversion:
> - Change attribute to shared.
> - VFIO populates the shared mappings into the IOMMU.
> - Restore attribute if the operation fails.
> 
> For shared to private conversion:
> - VFIO discards shared mapping from the IOMMU.
> - Change attribute to private.
> 
> To faciliate this sequence, priority support is added to
> PrivateSharedListener so that listeners are stored in a determined
> order based on priority. A tail queue is used to store listeners,
> allowing traversal in either direction.
> 
> Signed-off-by: Chenyi Qiang<chenyi.qiang@intel.com>
> ---
> Changes in v4:
>      - Newly added.
> ---
>   accel/kvm/kvm-all.c          |  3 ++-
>   hw/vfio/common.c             |  3 ++-
>   include/exec/memory.h        | 19 +++++++++++++++++--
>   include/exec/ramblock.h      |  2 +-
>   system/ram-block-attribute.c | 23 +++++++++++++++++------
>   5 files changed, 39 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index aec64d559b..879c61b391 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -1745,7 +1745,8 @@ static void kvm_region_add(MemoryListener *listener,
>       psl = &cpsl->listener;
>       QLIST_INSERT_HEAD(&cgs->cvm_private_shared_list, cpsl, next);
>       private_shared_listener_init(psl, kvm_private_shared_notify_to_shared,
> -                                 kvm_private_shared_notify_to_private);
> +                                 kvm_private_shared_notify_to_private,
> +                                 PRIVATE_SHARED_LISTENER_PRIORITY_MIN);
>       generic_state_manager_register_listener(gsm, &psl->scl, section);
>   }
>   
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 6e49ae597d..a8aacae26c 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -515,7 +515,8 @@ static void vfio_register_private_shared_listener(VFIOContainerBase *bcontainer,
>   
>       psl = &vpsl->listener;
>       private_shared_listener_init(psl, vfio_private_shared_notify_to_shared,
> -                                 vfio_private_shared_notify_to_private);
> +                                 vfio_private_shared_notify_to_private,
> +                                 PRIVATE_SHARED_LISTENER_PRIORITY_COMMON);
>       generic_state_manager_register_listener(gsm, &psl->scl, section);
>       QLIST_INSERT_HEAD(&bcontainer->vpsl_list, vpsl, next);
>   }
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 9472d9e9b4..3d06cc04a0 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -770,11 +770,24 @@ struct RamDiscardManagerClass {
>       GenericStateManagerClass parent_class;
>   };
>   
> +#define PRIVATE_SHARED_LISTENER_PRIORITY_MIN       0
> +#define PRIVATE_SHARED_LISTENER_PRIORITY_COMMON    10

For the current implementation with primarily KVM and VFIO needing
ordered execution, the two priority levels are likely sufficient. Not
sure whether it needs more priority levels for future development.

Thanks,
baolu

