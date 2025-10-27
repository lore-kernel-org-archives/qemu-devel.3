Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878ECCCF9E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 09:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDJpK-0005hE-Qm; Mon, 27 Oct 2025 05:47:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJpE-0005g9-Tl
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:47:42 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vDJpA-0000oz-VH
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 05:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761558458; x=1793094458;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=INtutBeGtSZcey+6l6//I7VSxH7KBfMtFX4UxJfmMhA=;
 b=Lq15KViFWJf31IUKJPFH5f5cxKmRDPREY35symZmbkE0m2ovtdDN9slA
 viU5mIw/d8TSSVoI45sdff0fb0Qi4Y7O46I6itb76NOWnMskrdWYDQEKj
 gjTz9p1+r/t3qh10puc9b8wQO9RFlLC8cy3AbO/qHxxw65qLlkHkZVhxs
 i52LcCPUvlu5LNmUjkjaebDf/fTTzAbUzNZpTb8mdzHxTlRPlCZCxy0fn
 TKv5FUm0O6P5K0qnvJ4VC4ZIOYV7bnIv/j6WVTRPnmMCzZG4ugaB1+J1c
 BBpHbrEt74ZxSwB15sR9taRrltHg9tupKqd+rcNZcQCB/U6qixu8qUvhI g==;
X-CSE-ConnectionGUID: s0hxYB0fRaO549ti7VJudQ==
X-CSE-MsgGUID: 9zV7i8euRGGoktRrrQ2VNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63671114"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="63671114"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2025 02:47:33 -0700
X-CSE-ConnectionGUID: m0k8MP5VRSqS1ezfWvIK5w==
X-CSE-MsgGUID: dQXCqHEvT/GQG+pXwdsPOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; d="scan'208";a="184619291"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 27 Oct 2025 02:47:30 -0700
Date: Mon, 27 Oct 2025 18:09:40 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, Chao Gao <chao.gao@intel.com>,
 John Allen <john.allen@amd.com>, Babu Moger <babu.moger@amd.com>,
 Mathias Krause <minipli@grsecurity.net>,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>, Farrah Chen <farrah.chen@intel.com>
Subject: Re: [PATCH v3 05/20] i386/cpu: Make ExtSaveArea store an array of
 dependencies
Message-ID: <aP9E5M5d8ZoMhFCO@intel.com>
References: <20251024065632.1448606-1-zhao1.liu@intel.com>
 <20251024065632.1448606-6-zhao1.liu@intel.com>
 <2d9f489e-dfa5-4bd1-bc7f-62223f81c167@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d9f489e-dfa5-4bd1-bc7f-62223f81c167@intel.com>
Received-SPF: pass client-ip=198.175.65.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> > @@ -7137,10 +7161,13 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
> >       if (w == FEAT_XSAVE_XCR0_LO || w == FEAT_XSAVE_XCR0_HI) {
> >           int comp = (w == FEAT_XSAVE_XCR0_HI) ? bitnr + 32 : bitnr;
> > -        if (comp < ARRAY_SIZE(x86_ext_save_areas) &&
> > -            x86_ext_save_areas[comp].bits) {
> > -            w = x86_ext_save_areas[comp].feature;
> > -            bitnr = ctz32(x86_ext_save_areas[comp].bits);
> > +        if (comp < ARRAY_SIZE(x86_ext_save_areas)) {
> > +            /* Present the first feature as the default. */
> > +            const FeatureMask *fm = &x86_ext_save_areas[comp].features[0];
> 
> It doesn't look right to me.
> 
> E.g., when users are requesting IBT, thus CET_U and CET_S, they might get
> "shstk" not avaiable.

This was intentional. This patch only introduces a new dependency array
without attempting to change the existing state. The series is already
quite large, so I didn't include all the cleanup within it.



