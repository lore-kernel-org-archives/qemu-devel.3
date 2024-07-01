Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC873C3065A
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 06:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOAxE-0001DB-6V; Mon, 01 Jul 2024 02:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sOAxB-0001Cd-GT; Mon, 01 Jul 2024 02:55:57 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sOAwv-00020P-DM; Mon, 01 Jul 2024 02:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719816942; x=1751352942;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=t4QGXPCNfoQQarKhlZB0PhL8oxy9LjS1x3CCEtIAdZo=;
 b=Tu0f4+2YXDFEn/cQiMR+PF4AN4JV4BjB1dydVO+63x+qTnFAGY7bu5IK
 nMAhF6nbLyVLRKDJ3F2T8L2muvGU96rogF0NTP1bAXUGKPZ1EiZ++z5ib
 lSzSJJeB7NfRzdFKjvIX5Eg1bmqrGxGwU8aYrlUllns+bCLhW5DCoswAh
 sw2iTfRTwmdUZWK/wk5MIxs8AiNVLAl0+k+aYatqm7mIqm2AvmmFhbzIV
 bcyVwOKYNYWjgoL45SHRJkE+GWwLehaHgXPg2uWPlAS5NtV6OpY5ipZ9e
 ENvF2AsrhR68gpculLh0Dns0o2ABe4rhkeRE8xvHlF2TV3rIdCEw08mDA w==;
X-CSE-ConnectionGUID: J9JRN7agQ+qC6lStyzUa1Q==
X-CSE-MsgGUID: x+qCxm+eRQOC7KQVUpq0tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="16745593"
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="16745593"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jun 2024 23:55:38 -0700
X-CSE-ConnectionGUID: UG1I6birQnaRf7DtXW0Gfw==
X-CSE-MsgGUID: AMPwadPZQGyNryIAibD0WQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,175,1716274800"; d="scan'208";a="45384940"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2024 23:55:35 -0700
Date: Mon, 1 Jul 2024 15:11:11 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xieyongji@bytedance.com, imammedo@redhat.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
 processor cores in the physical package
Message-ID: <ZoJWjwavmFpMxQC4@intel.com>
References: <20240611032314.64076-1-xuchuangxclwt@bytedance.com>
 <3394a8f2-0bab-4842-bf94-c15b2fa67a2f@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3394a8f2-0bab-4842-bf94-c15b2fa67a2f@tls.msk.ru>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Jul 01, 2024 at 09:48:02AM +0300, Michael Tokarev wrote:
> Date: Mon, 1 Jul 2024 09:48:02 +0300
> From: Michael Tokarev <mjt@tls.msk.ru>
> Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
>  processor cores in the physical package
> 
> 11.06.2024 06:23, Chuang Xu wrote:
> > When QEMU is started with:
> > -cpu host,host-cache-info=on,l3-cache=off \
> > -smp 2,sockets=1,dies=1,cores=1,threads=2
> > Guest can't acquire maximum number of addressable IDs for processor cores in
> > the physical package from CPUID[04H].
> > 
> > When creating a CPU topology of 1 core per package, host-cache-info only
> > uses the Host's addressable core IDs field (CPUID.04H.EAX[bits 31-26]),
> > resulting in a conflict (on the multicore Host) between the Guest core
> > topology information in this field and the Guest's actual cores number.
> > 
> > Fix it by removing the unnecessary condition to cover 1 core per package
> > case. This is safe because cores_per_pkg will not be 0 and will be at
> > least 1.
> > 
> > Fixes: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> > ---
> >   target/i386/cpu.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index bc2dceb647..b68f7460db 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6426,10 +6426,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >               if (*eax & 31) {
> >                   int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
> > -                if (cores_per_pkg > 1) {
> > -                    *eax &= ~0xFC000000;
> > -                    *eax |= max_core_ids_in_package(&topo_info) << 26;
> > -                }
> > +                *eax &= ~0xFC000000;
> > +                *eax |= max_core_ids_in_package(&topo_info) << 26;
> >                   if (host_vcpus_per_cache > threads_per_pkg) {
> >                       *eax &= ~0x3FFC000;
> 
> In qemu 9.0, the context is a bit different here:
> 
> 
>             if (*eax & 31) {
>                 int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                 int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
>                 if (cs->nr_cores > 1) {
>                     *eax &= ~0xFC000000;
>                     *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
>                 }
>                 if (host_vcpus_per_cache > vcpus_per_socket) {
> 
> Ie, no max_core_ids_in_package(), cores_per_pkg etc, introduced in
> v9.0.0-790-gf602eb925a "i386/cpu: Use CPUCacheInfo.share_level to encode
> CPUID[4]" and nearby.
> 
> Am I right the above change becomes
> 
>              if (*eax & 31) {
>                  int host_vcpus_per_cache = 1 + ((*eax & 0x3FFC000) >> 14);
>                  int vcpus_per_socket = cs->nr_cores * cs->nr_threads;
> -                if (cs->nr_cores > 1) {
> -                    *eax &= ~0xFC000000;
> -                    *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
> -                }
> +                *eax &= ~0xFC000000;
> +                *eax |= (pow2ceil(cs->nr_cores) - 1) << 26;
>                  if (host_vcpus_per_cache > vcpus_per_socket) {
>                      *eax &= ~0x3FFC000;
>                      *eax |= (pow2ceil(vcpus_per_socket) - 1) << 14;
> 
> in 9.0 -- in other words, just remove the nr_cores condition check
> and do the *eax assignment unconditionally ?
> 
> From the patch description it seems like it is, but I thought I'd
> ask anyway :)

Hi Michael,

I can help confirm your changes are correct.

-Zhao


