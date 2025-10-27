Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DD8CCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLBw-00013l-VA; Mon, 27 Oct 2025 07:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDLBc-0000as-GU
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:14:55 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDLBT-0008BF-Pd
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761563683; x=1793099683;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IhPw5JiuGawWjhUC7p2pfnm8f4c84/O2WHAP6X8TfbA=;
 b=Ch02HQnwELEf7HwaKvYPx69vsWNe1yLrneJ5rJX0puk7/qAc52YCVgHk
 CX9InTD4mARhYhSRbijXpER+uLJfN5gPXqy4KGUO8/yb5/T1W7Q1+UdDt
 q1anveTfygIX3KxpfShOLg2EE4lMoryILXrqzU7roHN/lAnCyiJciBPL7
 t8PlE4IGTsfYpPAtXAP8uUqrV3u4M20wMoIVHzKezcDnOPu7etIZ/6Ois
 sAikPc1T3HbSmNGu1Ev1t+wicowF9XASxAUyAE65f4I+l9pwyZ9OO/ntG
 Ei/mLkhU0wrWa2f1hYJivc+vFRBp11rYtVLOyOhdOLeJKmx59wDeDjTAy A==;
X-CSE-ConnectionGUID: ZTEaYzxmTmq6nMhEgLzSpg==
X-CSE-MsgGUID: u540djMfRj+vD3o/4GUptQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63563856"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63563856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 04:14:32 -0700
X-CSE-ConnectionGUID: yA7wC3JdTzesg5bgq/k1LA==
X-CSE-MsgGUID: FePlTOIpTuagbAk//+Gadg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="189330236"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 27 Oct 2025 04:14:29 -0700
Date: Mon, 27 Oct 2025 19:36:39 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Chao Gao <chao.gao@intel.com>, John Allen <john.allen@amd.com>,
 Babu Moger <babu.moger@amd.com>, Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 10/20] i386/cpu: Add missing migratable xsave features
Message-ID: <aP9ZR4fI99o54Nfw@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-11-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024065632.1448606-11-zhao1.liu@intel.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 1917376dbea9..b01729ad36d2 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1522,7 +1522,8 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>          .migratable_flags = XSTATE_FP_MASK | XSTATE_SSE_MASK |
>              XSTATE_YMM_MASK | XSTATE_BNDREGS_MASK | XSTATE_BNDCSR_MASK |
>              XSTATE_OPMASK_MASK | XSTATE_ZMM_Hi256_MASK | XSTATE_Hi16_ZMM_MASK |
> -            XSTATE_PKRU_MASK,
> +            XSTATE_PKRU_MASK | XSTATE_ARCH_LBR_MASK | XSTATE_XTILE_CFG_MASK |

ARCH LBR belongs to FEAT_XSAVE_XSS_LO.

> +            XSTATE_XTILE_DATA_MASK,
>      },
>      [FEAT_XSAVE_XCR0_HI] = {
>          .type = CPUID_FEATURE_WORD,
> -- 
> 2.34.1
> 

