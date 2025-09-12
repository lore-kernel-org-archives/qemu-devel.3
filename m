Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6426ACA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 05:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwwcs-0003w3-0a; Fri, 12 Sep 2025 01:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwcq-0003vo-09
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:47:12 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uwwco-0001ye-Gc
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 01:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757656030; x=1789192030;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=OP4SWtX+POda+jNuua56TBgHbiy9PMnIrT0PPee0WD4=;
 b=aTiNJrpWO0+o6x73eMxOfxJKj4DHlvtiLQBVMHjEfPOfqlwUm/ZEHF8n
 doaxO8OxEOMnCSq0E72Zw3nLjH4sx5OE8znTUfLB0w6JPzVPnZAgOnOlG
 49Wxm2Z0MV68eBC39YfPN7TVxBd7JkgZh2k8+pK5kfWlEglh7tLP0Tr4b
 GN5TdMnhIQ8zLM1TLpgikzk3Cn0H1pPcPMJXnZ0LvifQ8ud0B39TZpZdF
 Sdj9Qk3XDlR741iZSjME9hwilb7k9/OZlhtf/fy7iRE7C4bxzCLLvmR7g
 77cUB89o9V+/Lx+TfvOE5WTf4Py4WPE+faY91gQq6TFdSYMeTvxS53t4s w==;
X-CSE-ConnectionGUID: 4Ek2wmCrT5uESPiR2fqUTQ==
X-CSE-MsgGUID: 7aXnt5PdTNO50SKLAMyGkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60058589"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60058589"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:47:08 -0700
X-CSE-ConnectionGUID: MxCQqb4/Qqe9P4IrmnKqrw==
X-CSE-MsgGUID: T+iPD833QQOCISyqzV1x0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; d="scan'208";a="178218374"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.238.14])
 ([10.124.238.14])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2025 22:47:07 -0700
Message-ID: <807f9e9c-40b0-46fa-b92e-81cde9f301a6@intel.com>
Date: Fri, 12 Sep 2025 13:47:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] kvm: guest_memfd enhancement and fix for
 KVM_SET_USER_MEMORY_REGION2
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250728115707.1374614-1-xiaoyao.li@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250728115707.1374614-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=198.175.65.18; envelope-from=xiaoyao.li@intel.com;
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

On 7/28/2025 7:57 PM, Xiaoyao Li wrote:
> Patch 1 changes to check guest memfd CAP on VM instance.
> 
> Patch 2 is a fix for KVM_SET_USER_MEMORY_REGION2.
> 
> Patch 3 is an enhancement for guest_memfd_offset.

Gentle ping.

> ---
> Changes in v2:
> - Collect R-B tags;
> - Use {} to zero out the struct instead of memset() in patch2;
> - Initialize guest_memfd_offset at the original source in patch3;
> 
> Xiaoyao Li (3):
>    accel/kvm: Switch to check KVM_CAP_GUEST_MEMFD and
>      KVM_CAP_USER_MEMORY2 on VM
>    accel/kvm: Zero out mem explicitly in kvm_set_user_memory_region()
>    accel/kvm: Set guest_memfd_offset to non-zero value only when
>      guest_memfd is valid
> 
>   accel/kvm/kvm-all.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 


