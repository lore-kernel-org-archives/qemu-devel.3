Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B47CF3962
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2024 18:14:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srLfB-0004qV-72; Thu, 19 Sep 2024 14:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srLf4-0004pY-M8; Thu, 19 Sep 2024 14:13:50 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1srLf2-0004KJ-3C; Thu, 19 Sep 2024 14:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1726769628; x=1758305628;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H8UFqDiYL88Y39+LVctMDhnXcCsvsv1vrNjASa8mq+4=;
 b=Ws5nlnADIF4fwxgt4rQ9zJhgrFyYXkN0gVDJ89EbqRRaSTdE2IGkLLSS
 A+I9hwPpvWnubzNTsx4OBbC5jzxCj8K98P33mK0fjtTlohBo4auqLBKR4
 yOXrC3GpREbLGZo0yZdv7/ORPsKMaW0crzAWcR7X4Qh7ufepNnD1iX2lM
 TMIVAs91yTv36WTQPcKjXziCYDY2pfohyUj1vyUaR9Yp8VBMPfejPO4Y5
 UsvA8Kft0gX3O5eO+KAFsA/Cpk01uGDLHUgzc9jN92CK6fbUFmkaUM2gI
 JFBrGm4yhmwHsX90Dqb03QFDeyQVhevi6sE4zE8m+6cOttJm/SVTcMOpc A==;
X-CSE-ConnectionGUID: ywOpPxwWRNe4iO7SUMIxVA==
X-CSE-MsgGUID: KzoaS5i7SEivR+drVDvHOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11200"; a="51165921"
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; d="scan'208";a="51165921"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2024 11:13:43 -0700
X-CSE-ConnectionGUID: 02qoweJLTjuCBYmUotqFRg==
X-CSE-MsgGUID: T7l3D1lrTdCIU3pn9NkX5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,242,1719903600"; d="scan'208";a="74805726"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 19 Sep 2024 11:13:41 -0700
Date: Fri, 20 Sep 2024 02:29:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>, imammedo@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 chaiwen.cc@bytedance.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>, zhao1.liu@intel.com
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for logical
 processors in the physical package
Message-ID: <ZuxtmjZBGGwNaVwl@intel.com>
References: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Chuang and Igor,

Sorry for late reply,

On Wed, Sep 18, 2024 at 09:18:15PM +0800, Chuang Xu wrote:
> Date: Wed, 18 Sep 2024 21:18:15 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v3] i386/cpu: fixup number of addressable IDs for logical
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
> 
> As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> integer too. Otherwise we may encounter unexpected results in guest.
> 
> For example, when QEMU is started with CLI above and xtopology is disabled,
> guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> as the result, even though theads-per-core should actually be 2.
> 
> So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> to solve the unexpected result.
> 
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4c2e6f3a71..3710ae5283 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -6417,7 +6417,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          }
>          *edx = env->features[FEAT_1_EDX];
>          if (threads_per_pkg > 1) {
> -            *ebx |= threads_per_pkg << 16;
> +            *ebx |= pow2ceil(threads_per_pkg) << 16;

Yes, the fix is right.

About the "Maximum number of addressable IDs", the commit 88dd4ca06c83
("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]")
introduced the new way to calculate.

The pow2ceil() works for current SMP topology, but may be wrong on
hybrid topology, as the reason I listed in the commit message:

> The nearest power-of-2 integer can be calculated by pow2ceil() or by
> using APIC ID offset/width (like L3 topology using 1 << die_offset [3]).

> But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> are associated with APIC ID. For example, in linux kernel, the field
> "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> matched with actual core numbers and it's calculated by:
> "(1 << (pkg_offset - core_offset)) - 1".

Using APIC ID offset to calculate is the hardware's approach, so I tried
to use APIC ID instead of pow2ceil() and replaced all pow2ceil() case.

Hi Igor, do you agree? :-)

Best Regards,
Zhao


