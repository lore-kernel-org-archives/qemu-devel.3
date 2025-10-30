Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52803CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUgg-0004oj-Sm; Thu, 30 Oct 2025 11:35:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUge-0004ob-Uj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:35:40 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vEUgW-0000Zj-39
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761838532; x=1793374532;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fCS4z6Ye0JP+cKo2Hrda8Sh3rYbjMNOQols/w0IsCtI=;
 b=aLX3AbrnH8ufgVwCaQnv1UM6WsYncqkeft5dPNB6UKUe6SmYIDRiM8r/
 rCDU5yX3BVLZ8bvdRmEGTofq+f0ZDtYt0bD4bMtLm6vnwbXpR7/1hgddf
 1t54rz5bkuOWrv6iygep70+UTGuNNfSKJ3ltUqV8lPqvx+UrZLaiDGGfi
 LqSAT7yndtVZLcCndXamwkzpPdgsWUIVS1in27eG8pLVw+0+KOh9WJEoo
 Mlq7CNCns7PH+0uScPw1EgClLCwwC9+PeKapJs4b9iaKvKdtp/yeclbgb
 tMPPY1tARyVTlKwHY6nOnGwFteVPXPeM1h2Rfy6QMpZwSH5wGBfAz7r/C g==;
X-CSE-ConnectionGUID: hqzD4zzKSG2yc3APWG0K5g==
X-CSE-MsgGUID: nKEwrM3aRIavdTelpMyIew==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63912913"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="63912913"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 08:35:24 -0700
X-CSE-ConnectionGUID: qynHfdgJSmyEQZV8k6P6DA==
X-CSE-MsgGUID: amNjm247S6SdOghf6h+reg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,267,1754982000"; d="scan'208";a="186721596"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 30 Oct 2025 08:35:21 -0700
Date: Thu, 30 Oct 2025 23:57:33 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 12/20] i386/cpu: Add CET support in CR4
Message-ID: <aQOK7b5VAzH8eiKk@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-13-zhao1.liu@intel.com>
 <bb8609f2-a17b-42ff-9784-379be0b77502@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb8609f2-a17b-42ff-9784-379be0b77502@intel.com>
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

> > @@ -274,7 +275,7 @@ typedef enum X86Seg {
> >                  | CR4_LA57_MASK \
> >                  | CR4_FSGSBASE_MASK | CR4_PCIDE_MASK | CR4_OSXSAVE_MASK \
> >                  | CR4_SMEP_MASK | CR4_SMAP_MASK | CR4_PKE_MASK | CR4_PKS_MASK \
> > -                | CR4_LAM_SUP_MASK | CR4_FRED_MASK))
> > +                | CR4_LAM_SUP_MASK | CR4_FRED_MASK | CR4_CET_MASK))
> 
> Maybe put CR4_CET_MASK between PKE and PKS to keep it in order.

Sure, good idea.

Regards,
Zhao


