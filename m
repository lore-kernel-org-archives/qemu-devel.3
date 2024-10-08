Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A563CED256
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 02:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy083-0003wX-0M; Mon, 07 Oct 2024 22:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sy080-0003vx-Qj; Mon, 07 Oct 2024 22:39:13 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sy07z-0007f8-5o; Mon, 07 Oct 2024 22:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1728355151; x=1759891151;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=h/4KWn9V7cIjP5cDR1TS7MiUChbx6T5U2FcDlheaVt8=;
 b=EgPz4OcyTarscBFkXYPVCOdsTo0wRRI35SSc3oPYyPCN25NAGwxOcSss
 bViphDzPwQR5siJHfvZ/8SK4RP/cPSNa7E2pNLP/susW0beGeGexLD9ku
 axsdCN/3s4JKX5hQ8+Am0t2lx6m8u1VlATmAu+3RB6/tthcYk1x5XpGvR
 nrO5gDvH8n2/lS7XRFl+FIEC0ltXWicK0HWZDwwSWgAepk81uaD/oJGOe
 FORnKuljmo6/regEln2RnrC+bKqbG3pQGQX7UX0+17zzZd4T0TQovsP6c
 NofYYlSDZLj+EXx2Cu6slzK6K9naiE5FOinNcdbL6fIpIu9wtYiMcnRFu w==;
X-CSE-ConnectionGUID: pk28RzSIS0+cKfpXXZsFaw==
X-CSE-MsgGUID: SgWFZrDlQkq3unWsG0tL/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27612025"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; d="scan'208";a="27612025"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2024 19:39:07 -0700
X-CSE-ConnectionGUID: ydLZjjDwTnyX5wr3ApkTrw==
X-CSE-MsgGUID: AfcGwOnVSNGBRoDsN9uwew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; d="scan'208";a="75682478"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 07 Oct 2024 19:39:05 -0700
Date: Tue, 8 Oct 2024 10:55:16 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, imammedo@redhat.com,
 xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v4] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZwSfFNUYQNs/X74u@intel.com>
References: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007081344.10907-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Chuang.

Look fine for me, and only some minor nits:

On Mon, Oct 07, 2024 at 04:13:44PM +0800, Chuang Xu wrote:
> Date: Mon,  7 Oct 2024 16:13:44 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v4] i386/cpu: fixup number of addressable IDs for logical
>  processors in the physical package
> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
> 
> When QEMU is started with:
> -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> -smp 180,sockets=2,dies=1,cores=45,threads=2
> 
> Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
> CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
> execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
> CPUID.04H.EAX[31:26] as expected.

I polished the sentences a bit:

When executing "cpuid -1 -l 1 -r" in the guest, we obtain a value of 90 for
CPUID.01H.EBX[23:16], whereas the expected value is 128. Additionally,
executing "cpuid -1 -l 4 -r" in the guest yields a value of 63 for
CPUID.04H.EAX[31:26], which matches the expected result.

> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,

s/round/rounds/

> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,

What's xtopology?

> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though theads-per-core should actually be 2.

s/theads-per-core/threads-per-core/
 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> to solve the unexpected result.
> 
> In addition, we introduce max_thread_number_in_package() instead of
> using pow2ceil() to be compatible with smp and hybrid.
>
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 85ef7452c0..1b4e3b6931 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -261,6 +261,12 @@ static uint32_t max_thread_ids_for_cache(X86CPUTopoInfo *topo_info,
>      return num_ids - 1;
>  }
>  
> +static uint32_t max_thread_number_in_package(X86CPUTopoInfo *topo_info)
> +{
> +    uint32_t num_threads = 1 << apicid_pkg_offset(topo_info);
> +    return num_threads;
> +}
> +
>  static uint32_t max_core_ids_in_package(X86CPUTopoInfo *topo_info)
>  {
>      uint32_t num_cores = 1 << (apicid_pkg_offset(topo_info) -
> @@ -6462,7 +6468,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            *ebx |= max_thread_number_in_package(&topo_info) << 16;

This helper has only 1 caller and its name doesn't distinguish the
addressable ID, so it's not necessary. I feel it's better to shift
the bits directly here:

*ebx |= 1 << apicid_pkg_offset(topo_info) << 16;

>              *edx |= CPUID_HT;
>          }
>          if (!cpu->enable_pmu) {
> -- 
> 2.20.1
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


