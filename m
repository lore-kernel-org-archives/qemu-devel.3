Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB90C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 06:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua7R7-0005Yj-MP; Fri, 11 Jul 2025 02:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua7R3-0005TB-Sg
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:40:44 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ua7R1-0005qA-9M
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 02:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752216040; x=1783752040;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=phAg/RZzmOX277C2BNg7LfCIRIbcnX0rBuk1dhFQ3CI=;
 b=eo1baacGwMB7vPtbRpwLdKJozSLuncytkghjBQzKan9XQXRJ//8eRC75
 YFc5OCVAAHsTkDcDNqvHQLf0vd5LGEqxnmtkDu7GhU76IIGjNSFc0fRz1
 6V5fuPj864S4wTC94BevcL9I5IH4FNC0K7I7UugDNhKC0FzyEZsoYK+nF
 3oZjNgqniMyCpGHKxIE1UspVkv9hdGK50cExSKMBrvHrTKonl0zzA9FDL
 kgEt+VWwJ3gMHIF6R4yvDOp8x80VPNEvRBx+sNL3Nq6UfE/UUIKTRQ5G5
 3lqczN0OqOz0l4TUR8nYDdTm6HqpB9mWUs+kjOhI5dniLwBYArq/np7bo w==;
X-CSE-ConnectionGUID: 163RpaM+ROeOxjM7KcojfQ==
X-CSE-MsgGUID: 2jQg/jQRTIWHrvYc6Ty+Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="71957274"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="71957274"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 23:40:34 -0700
X-CSE-ConnectionGUID: hQu/ITNnQ4+eE2osSuwdIQ==
X-CSE-MsgGUID: mixQ73tESR+/CnEGH5hEMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; d="scan'208";a="156782232"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 23:40:33 -0700
Message-ID: <523e1e29-67f7-4103-bd39-3e06329adc6d@intel.com>
Date: Fri, 11 Jul 2025 14:40:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/i386: nvmm, whpx: add accel/CPU class that
 sets host vendor
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20250711000603.438312-1-pbonzini@redhat.com>
 <20250711000603.438312-3-pbonzini@redhat.com>
 <92d23086-7866-44a0-b54e-7690c0306248@intel.com>
 <CABgObfbPXmBLrScC3nQMT5A7mf1xz0hSnkLdrvcFS=hGr3dxSg@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CABgObfbPXmBLrScC3nQMT5A7mf1xz0hSnkLdrvcFS=hGr3dxSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

On 7/11/2025 2:35 PM, Paolo Bonzini wrote:
> Il ven 11 lug 2025, 04:18 Xiaoyao Li <xiaoyao.li@intel.com> ha scritto:
> 
>> Besides, do we need to call host_cpu_max_instance_init() for the case of
>> xcc->max_features, like what has been done for kvm and hvf?
>>
> 
> I am intentionally skipping that because it would not have any effect and
> there is no equivalent to KVM_GET_SUPPORTED_CPUID2 implemented for those
> accelerators.

I meant host_cpu_max_instance_init(), not the upper function like 
kvm_cpu_max_instance_init() or hvf_cpu_max_instance_init().

host_cpu_max_instance_init() is for the case "-cpu max/host", which not 
only sets "vendor" to the host value, but also the "host-phys-bits", 
"family" "model" "stepping" and "model-id"

> Paolo
> 
> 
>>
> 


