Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFF5C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnY5x-0005YC-2z; Thu, 27 Feb 2025 02:14:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnY5u-0005Wy-0n; Thu, 27 Feb 2025 02:14:06 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tnY5n-0001MH-7R; Thu, 27 Feb 2025 02:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740640439; x=1772176439;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=qdAdZcAasHUhjX5Ys69joDLzr/BzyelEqQzOyO5Abjw=;
 b=aErysI4yfRIYUSaE3mezLpmI7kpPv4GcAdOqWTzofPOjZZMmNSAjyJfG
 aXP7QIIvyLMVFrr3ENLpVcBUSmNCjJzEHBGqtAMLIeNpPmEduxqjoiWmz
 NPDAGd5xURvdq5fQOZ9EAZKrSq9vQsk0mBRPt/pfumhpSaV+EDt+jwcZM
 8biG8lcwVqAGBjhrFXAH027UUFNQBVYgr3BdRs9MkZGLGRMeKdZf1YGzb
 4s8Y9uavt+vurvNNwE3j4YX1LEkEFxKWIT9w0TRL27t0B1nUa0V7Mnko7
 /dUioAIcqXus00IvSYZox/yKuShFFDhqZeVQM/mO5UtSk8LLkgqfWGbO0 g==;
X-CSE-ConnectionGUID: LI3kOjitSOStpnVTLw2DGA==
X-CSE-MsgGUID: +0Zrl6nqQTCSzxaQ1lamRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11357"; a="66888390"
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="66888390"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 23:13:55 -0800
X-CSE-ConnectionGUID: 17T/iO2CRIChEWeJtA6wQg==
X-CSE-MsgGUID: II06IYt2QWCYrK/xX61ClQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,319,1732608000"; d="scan'208";a="117116952"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 23:13:52 -0800
Message-ID: <aada9fe4-b7c9-40b1-9111-e32f0a979db0@intel.com>
Date: Thu, 27 Feb 2025 15:13:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] i386/cpu: Fix cpu number overflow in
 CPUID.01H.EBX[23:16]
To: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Chuang Xu <xuchuangxclwt@bytedance.com>,
 Isaku Yamahata <isaku.yamahata@intel.com>, Babu Moger <babu.moger@amd.com>
Cc: qemu-devel@nongnu.org, Qian Wen <qian.wen@intel.com>,
 qemu-stable@nongnu.org
References: <20250227062523.124601-1-zhao1.liu@intel.com>
 <20250227062523.124601-3-zhao1.liu@intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250227062523.124601-3-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/27/2025 2:25 PM, Zhao Liu wrote:
> From: Qian Wen <qian.wen@intel.com>
> 
> The legacy topology enumerated by CPUID.1.EBX[23:16] is defined in SDM
> Vol2:
> 
> Bits 23-16: Maximum number of addressable IDs for logical processors in
> this physical package.
> 
> When threads_per_socket > 255, it will 1) overwrite bits[31:24] which is
> apic_id, 2) bits [23:16] get truncated.
> 
> Specifically, if launching the VM with -smp 256, the value written to
> EBX[23:16] is 0 because of data overflow. If the guest only supports
> legacy topology, without V2 Extended Topology enumerated by CPUID.0x1f
> or Extended Topology enumerated by CPUID.0x0b to support over 255 CPUs,
> the return of the kernel invoking cpu_smt_allowed() is false and APs
> (application processors) will fail to bring up. Then only CPU 0 is online,
> and others are offline.
> 
> For example, launch VM via:
> qemu-system-x86_64 -M q35,accel=kvm,kernel-irqchip=split \
>      -cpu qemu64,cpuid-0xb=off -smp 256 -m 32G \
>      -drive file=guest.img,if=none,id=virtio-disk0,format=raw \
>      -device virtio-blk-pci,drive=virtio-disk0,bootindex=1 --nographic
> 
> The guest shows:
>      CPU(s):               256
>      On-line CPU(s) list:  0
>      Off-line CPU(s) list: 1-255
> 
> To avoid this issue caused by overflow, limit the max value written to
> EBX[23:16] to 255 as the HW does.
> 
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Qian Wen <qian.wen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

> ---
> Changes since original v4 [*]:
>   * Rebase on addressable ID fixup.
>   * Drop R/b tags since the code base changes.
> 
> [*] original v4: https://lore.kernel.org/qemu-devel/20230829042405.932523-2-qian.wen@intel.com/
> ---
>   target/i386/cpu.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b8a78276cd50..ae6c8bfd8b5e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6691,16 +6691,21 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>           }
>           *edx = env->features[FEAT_1_EDX];
>           if (threads_per_pkg > 1) {
> +            uint32_t num;
> +
>               /*
>                * For CPUID.01H.EBX[Bits 23-16], AMD requires logical processor
>                * count, but Intel needs maximum number of addressable IDs for
>                * logical processors per package.
>                */
>               if (cpu->vendor_cpuid_only && IS_AMD_CPU(env)) {
> -                *ebx |= threads_per_pkg << 16;
> +                num = threads_per_pkg;
>               } else {
> -                *ebx |= 1 << apicid_pkg_offset(topo_info) << 16;
> +                num = 1 << apicid_pkg_offset(topo_info);
>               }
> +
> +            /* Fixup overflow: max value for bits 23-16 is 255. */
> +            *ebx |= MIN(num, 255) << 16;
>           }
>           if (!cpu->enable_pmu) {
>               *ecx &= ~CPUID_EXT_PDCM;


