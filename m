Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A755EB596A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3V5-0005MJ-NY; Wed, 11 Feb 2026 01:14:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vq3V4-0005Ld-34
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:14:58 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1vq3V2-00006z-1L
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:14:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770790496; x=1802326496;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rP5llVY+IJ2BiSdns8crbNzy366rp4QhMGd+dzV2WHQ=;
 b=TQZ4apZzeaYeT9AXwaURkL2IoHm1TaEis8ZRk/CiFmQJwXwGGpq8RmAz
 lKxQ8wyn1jfUMS63NlZq9w7HhKboi+SVpVKKpQ8QfCk9LZiq56dGP9L9u
 ZLl6zEvKzh2ReeGQbZvsJ/+4ibP4LdjVnt5zrU6HtAz/QseOT+X96NFKg
 3GC/oPn5/sagWH9ZRyYbmdmKGPg3fCXn7EZNTVOjwMA7IBq8Ihp2bDfrT
 oy03aiytBB0f/0JPU9knUPl9/PTeOT5ZTV4CAqcFHLOG8faJ+6NELyixJ
 xX+culjXZziNL66NI0iiXRRx2YpU/mOYV43/Lmd+aO7fRoFGaG5WNWKNr w==;
X-CSE-ConnectionGUID: 8LwfBOpvSByAL8RZ+I6iMg==
X-CSE-MsgGUID: qFiO5WRPS3qsYm/JI4fQfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="97387986"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="97387986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:14:52 -0800
X-CSE-ConnectionGUID: 4GJdpKNRRdS4hQ6jszuq4g==
X-CSE-MsgGUID: hN7ZDFQGQtuhhY1HequhuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="249784774"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.173])
 ([10.124.240.173])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:14:50 -0800
Message-ID: <7803017e-aefa-421a-92a1-3b5820beba53@intel.com>
Date: Wed, 11 Feb 2026 14:14:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 01/11] target/i386: Disable unsupported BTS for guest
To: Zide Chen <zide.chen@intel.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>
References: <20260128231003.268981-1-zide.chen@intel.com>
 <20260128231003.268981-2-zide.chen@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20260128231003.268981-2-zide.chen@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
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

On 1/29/2026 7:09 AM, Zide Chen wrote:
> BTS (Branch Trace Store), enumerated by IA32_MISC_ENABLE.BTS_UNAVAILABLE
> (bit 11), is deprecated and has been superseded by LBR and Intel PT.
> 
> KVM yields control of the above mentioned bit to userspace since KVM
> commit 9fc222967a39 ("KVM: x86: Give host userspace full control of
> MSR_IA32_MISC_ENABLES").
> 
> However, QEMU does not set this bit, which allows guests to write the
> BTS and BTINT bits in IA32_DEBUGCTL.  Since KVM doesn't support BTS,
> this may lead to unexpected MSR access errors.
> 
> Signed-off-by: Zide Chen <zide.chen@intel.com>

Since the patch is handling BTS,

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>


Besides, I'm curious about the (legacy) PEBS enable.

Before KVM commit 9fc222967a39, BTS_UNAVAIL and PEBS_UNAVAIL in 
MISC_ENABLES are maintained by KVM and userspace cannot change them. KVM 
keeps MISC_ENABLES.PEBS_UNAVAIL set when

   !(vcpu->arch.perf_capabilities & PERF_CAP_PEBS_FORMAT)

After KVM commit 9fc222967a39, it's userspace's responsibility to set 
correct value for MSR_IA32_MISC_EANBLES. So, if PEBS is not exposed to 
guest, QEMU should set MISC_ENABLE_PEBS_UNAVAIL. But I don't see such 
logic in QEMU. (Maybe the later patch in this series will handle it, let 
me keep reading.)

> ---
> V2:
> - Address Dapeng's comments.
> - Remove mention of VMState version_id from the commit message.
> 
>   target/i386/cpu.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2bbc977d9088..f02812bfd19f 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -474,8 +474,11 @@ typedef enum X86Seg {
>   
>   #define MSR_IA32_MISC_ENABLE            0x1a0
>   /* Indicates good rep/movs microcode on some processors: */
> -#define MSR_IA32_MISC_ENABLE_DEFAULT    1
> +#define MSR_IA32_MISC_ENABLE_FASTSTRING    (1ULL << 0)
> +#define MSR_IA32_MISC_ENABLE_BTS_UNAVAIL   (1ULL << 11)
>   #define MSR_IA32_MISC_ENABLE_MWAIT      (1ULL << 18)
> +#define MSR_IA32_MISC_ENABLE_DEFAULT    (MSR_IA32_MISC_ENABLE_FASTSTRING     |\

Nit, we usually add a space before "\"

> +                                         MSR_IA32_MISC_ENABLE_BTS_UNAVAIL)
>   
>   #define MSR_MTRRphysBase(reg)           (0x200 + 2 * (reg))
>   #define MSR_MTRRphysMask(reg)           (0x200 + 2 * (reg) + 1)


