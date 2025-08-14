Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EC6CA0ED1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 09:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umUWn-0008T4-FT; Thu, 14 Aug 2025 05:45:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umUWT-0008PH-GL
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:45:25 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1umUWQ-0007qM-4j
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 05:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755164722; x=1786700722;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=1lE5dlS6y19eRj9nrgov7ltMSa/n7xbClcD8csxw44E=;
 b=jOJEgPi3LUE9096JJB2m4vOSmjjNeG3ZldRabIByrUBqRN7aL/GZuCdU
 JCOYqDVVYQwCCzOTmunbpisiC8souX/19WRX2/c9ygB/VUKoBdl9zmEYD
 Jkil8XiXNVzQfsWCIBmcffE7GxM1lPwWFRuBh8WYN6TyimH5B7UhBf+lS
 Us9h3u403/ePn8XvehmF82Ro4KjRIn/3n0jqPlm5CYYXLpbSi94djy31h
 lBPdDp/hhx0EB9U9n3wJabDFSuE/K31d+AKLZO/G/8cKlNMujn9gcS9Wz
 qLx/SgE2CJZ1Z3gEaMT+5Xscr/jNuWcJKpKU7OLJLfpKh08HSVmJ2snxJ Q==;
X-CSE-ConnectionGUID: /RITMuvhQza9fswrpPuYZw==
X-CSE-MsgGUID: HCuoKtGgSTyOxO0uoInNvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="56684657"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="56684657"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 02:45:18 -0700
X-CSE-ConnectionGUID: AXtxbNQvTvmcKbsudZBBcg==
X-CSE-MsgGUID: 8IVLkszuSZSo8U0mVOnc/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; d="scan'208";a="171952371"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Aug 2025 02:45:17 -0700
Message-ID: <f38c961d-9c5a-4e45-a42e-fbafb7e5e88b@intel.com>
Date: Thu, 14 Aug 2025 17:45:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
To: David Hildenbrand <david@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
References: <20250721065220.895606-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250721065220.895606-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.18; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.941, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/21/2025 2:52 PM, Xiaoyao Li wrote:
> shm can surely serve as the shared memory for coco-VMs. But currently it
> doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
> flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
> require private mmeory.
> 
> Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
> allow shm memory backend serve as shared memory for coco-VMs.

ping...

Paolo, will you merge it for QEMU 10.1? I think it's worth it.

> cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>   backends/hostmem-shm.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/backends/hostmem-shm.c b/backends/hostmem-shm.c
> index f66211a2ec92..806e2670e039 100644
> --- a/backends/hostmem-shm.c
> +++ b/backends/hostmem-shm.c
> @@ -54,6 +54,7 @@ have_fd:
>       /* Let's do the same as memory-backend-ram,share=on would do. */
>       ram_flags = RAM_SHARED;
>       ram_flags |= backend->reserve ? 0 : RAM_NORESERVE;
> +    ram_flags |= backend->guest_memfd ? RAM_GUEST_MEMFD : 0;
>   
>       return memory_region_init_ram_from_fd(&backend->mr, OBJECT(backend),
>                                                 backend_name, backend->size,


