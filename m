Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E19FC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:11:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYOT-0003sK-E7; Thu, 18 Jul 2024 17:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOS-0003nM-2s
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:28 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1sUYOQ-0007d5-Ab
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721337026; x=1752873026;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=zE17BZkwy8UycCJoMocpdUeKfD78ndYlxuRu42pElz0=;
 b=b9g+bpQvZywZrK+bK2MiHsbYWyc5Fq7REE8aDfrnEWpQ/FOD32faLdOb
 ENy1iqKX3syx/J0vfJUCa+P+LMAC7dgfPXi/3VdyUYBVUjdMSVHolhV/7
 W3NoTC3CwB3G8kcYgxp8FfYshmWttY/cOLVWVEz0eP9iG4Y+AWwsEOF3N
 aqc9U5LNW2zO1PDG5TjPrkKm0jBdsKLUJCLp8Rvk2066tUEFU9oXUf5Kr
 pYlPDnWzKqFfx4P+lnWIFdmEyFhf/ASiEg9ZDvqNWzBIg1Zk/DK4p0mnj
 Wcad87Q/jEa93fRczlKVa0hJpCBc+dGVZnbEt69/miIz/7jxYStTHOSPT Q==;
X-CSE-ConnectionGUID: AYbGo7TOSwySPibVw/dFVQ==
X-CSE-MsgGUID: hOAl3sg5QX2cSObWGgyuCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11137"; a="21831742"
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="21831742"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jul 2024 14:10:25 -0700
X-CSE-ConnectionGUID: BgUkApG2TkSl7t7DPCmCNw==
X-CSE-MsgGUID: QSRmJP61RIukymHCxKByyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,218,1716274800"; d="scan'208";a="55179111"
Received: from soc-cp83kr3.jf.intel.com (HELO [10.24.10.107]) ([10.24.10.107])
 by fmviesa005-auth.fm.intel.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2024 14:10:25 -0700
Message-ID: <eac04a1a-d340-4d63-9d2e-91d8e4859073@intel.com>
Date: Thu, 18 Jul 2024 14:10:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] target/i386/kvm: Drop workaround for
 KVM_X86_DISABLE_EXITS_HTL typo
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20240716161015.263031-1-zhao1.liu@intel.com>
 <20240716161015.263031-6-zhao1.liu@intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20240716161015.263031-6-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 7/16/2024 9:10 AM, Zhao Liu wrote:
> The KVM_X86_DISABLE_EXITS_HTL typo has been fixed in commit
> 77d361b13c19 ("linux-headers: Update to kernel mainline commit
> b357bf602").
> 
> Drop the related workaround.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
>  target/i386/kvm/kvm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 64e54beac7b3..4aae4ffc9ccd 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -2728,10 +2728,6 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  
>      if (enable_cpu_pm) {
>          int disable_exits = kvm_check_extension(s, KVM_CAP_X86_DISABLE_EXITS);
> -/* Work around for kernel header with a typo. TODO: fix header and drop. */
> -#if defined(KVM_X86_DISABLE_EXITS_HTL) && !defined(KVM_X86_DISABLE_EXITS_HLT)
> -#define KVM_X86_DISABLE_EXITS_HLT KVM_X86_DISABLE_EXITS_HTL
> -#endif
>          if (disable_exits) {
>              disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
>                                KVM_X86_DISABLE_EXITS_HLT |

