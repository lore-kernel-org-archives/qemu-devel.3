Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F6FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:19:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLA5-0007N5-SM; Mon, 27 Oct 2025 07:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDL9v-0006y6-2T
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:13:09 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDL9k-0007nL-SW
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761563577; x=1793099577;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=T7zC62ErZg1/hbryOP00DYUI5q8qL4AeEstwHLT26mU=;
 b=Mwq92+uL0CyZb9zcQsiR63yzPq5P84amCWrdb27JWwcYdLJIFVHMmRgk
 cdOk76g95Og0TG6/zgD6ELvLDsQQ7DDuiHy5Sh2A7cExRNTyS+rvrfhio
 uYSkH27Me7Ol3xsXLS3BaLnSXMLRe+lcd47D/hCmSWHbuJQIJJEGrwVAL
 LZglQ5Ey0bDwrok49jVh5n7cYR8ES4gNy3SZTJoG9JsbrSqDZWw5BZHQk
 T5/HxaiUHGf8Y/raUi6X/6lbdfSoUyedSI8+yIjq7dTCX2oNQm9BEJoR4
 ZEvGw0N5z0yb9vEdqbYVYMJHdtHe6XbEBBSNDU+j6Hbd7xjCbonPYP6yJ Q==;
X-CSE-ConnectionGUID: b0uUo2SPSt2uwXVG53iIWg==
X-CSE-MsgGUID: 7bcqGXy1Q4SXykXNlGVajA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74756920"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="74756920"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 04:12:50 -0700
X-CSE-ConnectionGUID: d0E73kGmQTSUZLk/GgIozw==
X-CSE-MsgGUID: 11NVjgtuSLiG1Pimo6QKkg==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 27 Oct 2025 04:12:46 -0700
Date: Mon, 27 Oct 2025 19:34:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as
 migratable
Message-ID: <aP9Y4B1J1W+3Gv/2@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-17-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024065632.1448606-17-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, Oct 24, 2025 at 02:56:28PM +0800, Zhao Liu wrote:
> Date: Fri, 24 Oct 2025 14:56:28 +0800
> From: Zhao Liu <zhao1.liu@intel.com>
> Subject: [PATCH v3 16/20] i386/cpu: Mark cet-u & cet-s xstates as migratable
> X-Mailer: git-send-email 2.34.1
> 
> Cet-u and cet-s are supervisor xstates. Their states are saved/loaded by
> saving/loading related CET MSRs. And there's a vmsd "vmstate_cet" to
> migrate these MSRs.
> 
> Thus, it's safe to mark them as migratable.
> 
> Tested-by: Farrah Chen <farrah.chen@intel.com>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  target/i386/cpu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 0bb65e8c5321..c08066a338a3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>              XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>              XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
> -            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
> +            XSTATE_PKRU_MASK | XSTATE_CET_U_MASK | XSTATE_CET_S_MASK |

CET-U & CET-S should be added to FEAT_XSAVE_XSS_LO.

> +            XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |
>              XSTATE_XTILE_DATA_MASK,
>      },
>      [FEAT_XSAVE_XCR0_HI] = {
> -- 
> 2.34.1
> 

