Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC99C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQSK-0001fD-A7; Tue, 04 Jun 2024 05:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEQSH-0001di-Tm; Tue, 04 Jun 2024 05:27:46 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sEQSF-0006jo-EI; Tue, 04 Jun 2024 05:27:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717493263; x=1749029263;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M34TiPqHvfz68DTrVC1np753jAh5/Vgb/IRv0jNKKmY=;
 b=PcifkvjL7E7HSmP7x8MOd4dwlsLl6DOOgJReUZoORv4/oNPfUEtLwxVW
 v5BUrW0vafyTQ3lzMTRpMQu4yaOPkvW+YoxbbwHucO0jU5hlZVwvZkpEo
 AUWwuegdeyk2nApCKu4Hmc4UAzGTuG2kzph5o9nLYpeNORHQM/of+B2v5
 tWW7yBiYHcNtdHgG0j91BLujHTpGa5sgiibJW9cXevDhTUMDjl5DG7iM/
 XaBsG4qXWT3kln2WzE7NXi6jmKUBMHTzgWXSaSTbwJwfDnaoT3VFh4+1I
 doq6HVAUQDFqjNA6YyDw76JvUsBomwIEZBtnWPUa360YJfNAqrKVEVZwH g==;
X-CSE-ConnectionGUID: RZeq0JL1THuVPTcePnMNRg==
X-CSE-MsgGUID: 4ZduWdWsT8mrEZXIwNSC5g==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="13776280"
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="13776280"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2024 02:27:40 -0700
X-CSE-ConnectionGUID: PC+dvAYyRWiCQeoOSAmSgg==
X-CSE-MsgGUID: KTtMExXsRXqUQmsnkyhYRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,213,1712646000"; d="scan'208";a="68345314"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 04 Jun 2024 02:27:38 -0700
Date: Tue, 4 Jun 2024 17:43:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 imammedo@redhat.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v2] i386/cpu: fixup number of addressable IDs for
 processor cores in the physical package
Message-ID: <Zl7hpyutlWN5iE+6@intel.com>
References: <20240603083641.97241-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603083641.97241-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Hi Chuang,

On Mon, Jun 03, 2024 at 04:36:41PM +0800, Chuang Xu wrote:
> Date: Mon,  3 Jun 2024 16:36:41 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v2] i386/cpu: fixup number of addressable IDs for processor
>  cores in the physical package
> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
> 
> When QEMU is started with:
> -cpu host,host-cache-info=on,l3-cache=off \
> -smp 2,sockets=1,dies=1,cores=1,threads=2
> Guest can't acquire maximum number of addressable IDs for processor cores in
> the physical package from CPUID[04H].
>
> When testing Intel TDX, guest attempts to acquire extended topology from CPUID[0bH],
> but because the TDX module doesn't provide the emulation of CPUID[0bH],
> guest will instead acquire extended topology from CPUID[04H]. However,
> due to QEMU's inaccurate emulation of CPUID[04H], one of the vcpus in 2c TDX
> guest would be offline.

I guess this case is based on downstream's TDX patches... Since TDX
hasn't landed in QEMU yet, it's a bit ahead of the curve to elaborate on
TDX-specific case.

Because normal VM will also face the such cache topology error, I think
it could be stated a bit more generically like:

When creating a CPU topology of 1 core per package, host-cache-info only
uses the Host's addressable core IDs field (CPUID.04H.EAX[bits 31-26]),
resulting in a conflict (on the multicore Host) between the Guest core
topology information in this field and the Guest's actual cores number.

Fix it by removing the unnecessary condition to cover 1 core per package
case. This is safe because cores_per_pkg will not be 0 and will be at
least 1.

> Fix it by removing the unnecessary condition.
> 
> Fixes: d7caf13b5fcf742e5680c1d3448ba070fc811644 ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")

12 characters (d7caf13b5fcf) is enough. No blank line. ;-)

> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index bc2dceb647..b68f7460db 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6426,10 +6426,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>              if (*eax & 31) {
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>  
> -                if (cores_per_pkg > 1) {
> -                    *eax &= ~0xFC000000;
> -                    *eax |= max_core_ids_in_package(&topo_info) << 26;
> -                }
> +                *eax &= ~0xFC000000;
> +                *eax |= max_core_ids_in_package(&topo_info) << 26;
>                  if (host_vcpus_per_cache > threads_per_pkg) {
>                      *eax &= ~0x3FFC000;
>  
> -- 
> 2.20.1
> 

