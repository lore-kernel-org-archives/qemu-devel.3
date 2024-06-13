Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9436FC27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 09:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHh66-0005oT-Bm; Thu, 13 Jun 2024 05:50:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHh63-0005o3-SO
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:50:19 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1sHh61-00027G-Rs
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 05:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718272218; x=1749808218;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=6y4QQC9OFuWGXJq4CbQWs+OveQI9h7vXDqnwywuumfo=;
 b=DeX0C/lIG0VhhNkjrLhEiguHoZ/lllgIHuaSLgSCUkEYxB9HbiITpaOn
 4eu112pb5/v2oJx8+P7IlxRAIObuWYB2AfjJ84PkjAGXi642pQLENiUj8
 Vx+0H1HtqP/4B+9bRASZUsgSNy08TX1ynmu7B/jQBdjr/g3AjyOAK02TM
 Vsu/MaAdy5MuKzYFXYvvwuDs80qcs/WWdQ5yoXrTxKfEPiqsWTrd3GynM
 /YWbt2HV4vUOlO+GO+NyOWXaM1Qad8ZdnWSfegIpcMLyGUhHJzJ5RepFu
 wBByRRxzX51G9IL6bpCvTnzoB92BSd+jW1QBZLe9wq+MUsmCkQiV5FRiV Q==;
X-CSE-ConnectionGUID: 1y4H1KqBQEKo4y7seN13uA==
X-CSE-MsgGUID: 833X7oQ9RASvHXjl909HKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="14878963"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="14878963"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 02:50:13 -0700
X-CSE-ConnectionGUID: 6IiplG3QTDCj3YxYhuStCg==
X-CSE-MsgGUID: KWnptnc6SR2LQm1USBa9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; d="scan'208";a="70877989"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.227.51])
 ([10.124.227.51])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2024 02:50:12 -0700
Message-ID: <c54d5f72-ecfd-46e0-baf9-324fdedd2ed3@intel.com>
Date: Thu, 13 Jun 2024 17:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 39/42] i386: Add support for SUCCOR feature
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: John Allen <john.allen@amd.com>, William Roche
 <william.roche@oracle.com>, Joao Martins <joao.m.martins@oracle.com>
References: <20240608083415.2769160-1-pbonzini@redhat.com>
 <20240608083415.2769160-40-pbonzini@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240608083415.2769160-40-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/8/2024 4:34 PM, Paolo Bonzini wrote:
> From: John Allen <john.allen@amd.com>
> 
> Add cpuid bit definition for the SUCCOR feature. This cpuid bit is required to
> be exposed to guests to allow them to handle machine check exceptions on AMD
> hosts.
> 
> ----
> v2:
>    - Add "succor" feature word.
>    - Add case to kvm_arch_get_supported_cpuid for the SUCCOR feature.
> 
> Reported-by: William Roche <william.roche@oracle.com>
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> Signed-off-by: John Allen <john.allen@amd.com>
> Message-ID: <20240603193622.47156-3-john.allen@amd.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

[snip]
...

> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 55a9e8a70cf..56d8e2a89ec 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -532,6 +532,8 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>            */
>           cpuid_1_edx = kvm_arch_get_supported_cpuid(s, 1, 0, R_EDX);
>           ret |= cpuid_1_edx & CPUID_EXT2_AMD_ALIASES;
> +    } else if (function == 0x80000007 && reg == R_EBX) {
> +        ret |= CPUID_8000_0007_EBX_SUCCOR;

IMO, this is incorrect.

Why make it supported unconditionally? Shouldn't there be a KVM patch to 
report it in KVM_GET_SUPPORTED_CPUID?

If make it supported unconditionally, all VMs boot with "-cpu host/max" 
will see the CPUID bits, even if it is Intel VMs.


>       } else if (function == KVM_CPUID_FEATURES && reg == R_EAX) {
>           /* kvm_pv_unhalt is reported by GET_SUPPORTED_CPUID, but it can't
>            * be enabled without the in-kernel irqchip


