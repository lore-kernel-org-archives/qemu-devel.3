Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83289CD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 05:45:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSTYD-0002MC-97; Thu, 28 May 2026 01:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wSTY6-0002Ld-4x
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:44:55 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1wSTY1-0003d9-KP
 for qemu-devel@nongnu.org; Thu, 28 May 2026 01:44:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779947090; x=1811483090;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=grKZz61OVYFNNJHJ5sYeUmbUtKNym66hz/hWDIAvdCM=;
 b=iPM/RQtIG/oVfzQ8uECtcQKQqfwNOXl8+rtbreEaO8nYDzKKvJFywDOR
 Bfl5A9d2mCoBPs2A5EGtUPkY2e/LArYu5Yd+RP8j6xMxW6X9mWWEPjjQ2
 UkshjjcTuDkDVCnfRwEJhcsd7knVWbqmqf7ZFjAh+rZ5/nyernFFS4q2+
 +qrWW/I2Xk3la9JVvtRfnLnYlpAoDCRwmEdNLi2sk/DCnf8q2AmSRD+4Y
 p/h+CdEu8jgxAhwwauU/NJqpsf4qmF/um9gc1NxXw6qdlYO4nQ5aO6kbo
 uXogslfJHsTnnVpkBfc/TTqbORmP+G4G01Zw/233lqt4Gnr5Dq44pv//R w==;
X-CSE-ConnectionGUID: 9JUAMgQ/TXC8GJ4zXpGZ/Q==
X-CSE-MsgGUID: 0/xXYjdoSOOHsxX8eB5pSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84673510"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; d="scan'208";a="84673510"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 22:44:45 -0700
X-CSE-ConnectionGUID: yzFselZYRyqWESurnNzUkw==
X-CSE-MsgGUID: 6hpef2JIQNmdfTYsyZP6pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; d="scan'208";a="242612230"
Received: from unknown (HELO [10.239.158.62]) ([10.239.158.62])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 22:44:41 -0700
Message-ID: <04f3184d-58f5-45c3-b5d4-5485e68946ae@intel.com>
Date: Thu, 28 May 2026 13:44:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/12] guest_memfd: support in-place memory conversion
To: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, berrange@redhat.com,
 armbru@redhat.com, pankaj.gupta@amd.com, isaku.yamahata@intel.com,
 chao.p.peng@linux.intel.com, david@kernel.org, ashish.kalra@amd.com,
 ackerleytng@google.com
References: <20260528000416.8161-1-michael.roth@amd.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260528000416.8161-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.14; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/28/2026 8:03 AM, Michael Roth wrote:
> This patchset is also available at:
> 
>    https://github.com/amdese/qemu/commits/snp-inplace-rfc1
> 
> which is in turn based on the following series:
> 
>    [PATCH 0/4] "guest_memfd: Fix handling for conversions of MMIO ranges"
>    https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg07547.html
> 
> 
> OVERVIEW
> --------
> 
> This series adds guest_memfd support for in-place conversion of memory
> between private/shared, and enables it for SEV-SNP guests. It is based
> on recently-added kernel support for mmap()-able guest_memfd
> instances[1], which allow it to be used for shared memory, and the
> following patchset[2], which adds additional guest_memfd interfaces to
> allow it to be used to perform in-place conversion:
> 
>    "[PATCH v7 00/42] guest_memfd: In-place conversion support"
>    https://lore.kernel.org/kvm/20260522-gmem-inplace-conversion-v7-0-2f0fae496530@google.com/
> 
> That series also introduces a new 'vm_memory_attributes' KVM
> module option, which sets whether memory attributes are tracked
> VM-wide by KVM (vm_memory_attributes=1: the existing 'legacy' mode),
> or per-guest_memfd instance (vm_memory_attributes=0: the new mode
> which allows for in-place conversion). The latter is intended to
> eventually deprecate the legacy mode, at which point in-place
> conversion would become the primarily-supported mode.
> 
> 
> MOTIVATION
> ----------
> 
> Today, SEV-SNP guests (and other CoCo VM types using guest_memfd) keep
> shared and private memory on separate physical backings: a userspace
> memory-backend object for shared pages, and a kernel-allocated
> guest_memfd file descriptor for private pages. KVM_SET_MEMORY_ATTRIBUTES
> flips which backing the guest sees for a given GPA range, and the old
> backing is typically discarded / hole-punched on conversion to avoid
> doubled memory usage.
> 
> That model works, but has a number of downsides that impact certain
> use-cases:
> 
>    - Each conversion involves discarding pages on one side and faulting
>      them in on the other, which incurs allocation overheads in the
>      host kernel for every conversion.
> 
>    - Some use-cases, like pKVM[3], rely on memory isolation rather than
>      encryption and rely on in-place conversion to pass through things
>      like secured framebuffer memory without needing to bounce data
>      through separate shared/private HPAs, which would introduce
>      unacceptable latency for that sort of workload.
> 
>    - Hugetlb support[4] for guest_memfd will rely on it, since things like
>      1GB hugepages with a mix of shared/private sub-ranges would generally
>      require 2 1GB hugetlb pages to remain available to handle shared vs.
>      private accesses, which quickly causes doubling of guest memory usage.
> 
> Recent kernel work[2] makes guest_memfd mmap()-able and lets the *same*
> physical pages be used for both shared and private states for a given
> GPA range, allowing the above pitfalls to be naturally avoided.
> 
> This series wires that support up in QEMU.

+ Peter,

Peter had the series[*] to enable the mmap() of guest memfd and allow it 
serve as unencrypted memory for VMs. I believe there are some overlapped 
efforts.

[*] 
https://lore.kernel.org/qemu-devel/20251215205203.1185099-1-peterx@redhat.com/

> 
> DESIGN
> ------
> 
> A new dedicated memory backend, memory-backend-guest-memfd, allocates
> its memory via a guest_memfd file descriptor obtained from KVM with
> the GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED flags. 

A quick feedback:

The design choice from Peter's series was to extend the current 
hostmem-memfd backend to support guest-memfd instead of a new dedicated 
backend.
I think we need to evaluate the pros and cons of each other, and make a 
choice.

(I will go read the other part later and provide more feedback)

