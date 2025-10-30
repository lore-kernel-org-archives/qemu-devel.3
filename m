Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6327ECCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:47:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUrx-0008Vt-1h; Thu, 30 Oct 2025 11:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUrt-0008US-C1
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:47:18 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUri-0003eL-3X
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761839226; x=1793375226;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Eqo4DVoLwi8Ct/RRlM48iY64Hvj8SIZbn5etBQmpufw=;
 b=VKvuJdrfOpTH6c4npbINQO7mh/xcBurzdwa2U+0aREjG3UCM+Q+GWxqu
 4YgALoE+kAvHqHyd337FdwjB4qwRVI/0wunC6jQIm6fI/t52cfuqECN57
 v2SKqHwkdKckLpxAd88coZybmN4UAEHU/ZU+ODkxYxNYQfVEF6tSPOLlj
 NmUn7iROWj5hYxf5uN6Md6nbmytdxD1ShtxCIzd47G3AO0SyztEFT1ujK
 gK6Ep6QOgI9aoXv/xXhnOhPH3IPCyZ4qyBZMs2Bo4D4w/p/o6OTvI+qVf
 1Y5oqPKQ3UAa5erymx6Ik9gqylR9ovrTociLmWQopMc13AZg0GhG7SHf8 g==;
X-CSE-ConnectionGUID: anLAPtXURYOWT5j8+wQu6A==
X-CSE-MsgGUID: RpcgoYPoSfiwwwI9UsivZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="63895458"
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="63895458"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 08:46:57 -0700
X-CSE-ConnectionGUID: FA4RR9eUQNuPiDBK/BMq/w==
X-CSE-MsgGUID: xB9czmitQRuLugEU7B6+XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="186428469"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 30 Oct 2025 08:46:54 -0700
Date: Fri, 31 Oct 2025 00:09:06 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as
 migratable
Message-ID: <aQONorppI83cWYJK@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-17-zhao1.liu@intel.com>
 <aQGvwMTWYPx5FNdQ@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQGvwMTWYPx5FNdQ@intel.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
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

On Wed, Oct 29, 2025 at 02:10:08PM +0800, Chao Gao wrote:
> Date: Wed, 29 Oct 2025 14:10:08 +0800
> From: Chao Gao <chao.gao@intel.com>
> Subject: Re: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as
>  migratable
> 
> On Fri, Oct 24, 2025 at 02:56:28PM +0800, Zhao Liu wrote:
> >Cet-u and cet-s are supervisor xstates. Their states are saved/loaded by
> >saving/loading related CET MSRs. And there's a vmsd "vmstate_cet" to
> >migrate these MSRs.
> >
> >Thus, it's safe to mark them as migratable.
> >
> >Tested-by: Farrah Chen <farrah.chen@intel.com>
> >Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> >---
> > target/i386/cpu.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >index 0bb65e8c5321..c08066a338a3 100644
> >--- a/target/i386/cpu.c
> >+++ b/target/i386/cpu.c
> >@@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
> >         .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
> >             XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
> >             XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
> >-            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
> >+            XSTATE_PKRU_MASK | XSTATE_CET_U_MASK | XSTATE_CET_S_MASK |
> >+            XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
> >             XSTATE_XTILE_DATA_MASK,
> 
> Supervisor states are enumerated via CPUID[EAX=0xd,ECX=1].ECX/EDX while user
> states are enumerated via CPUID[EAX=0xd,ECX=0].EAX/EDX. So, maybe we need to 
> two new feature words?

Yes, I added the mask into wrong place...

Regards,
Zhao


