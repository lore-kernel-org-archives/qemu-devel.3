Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05094C35FF1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzhi-0004aX-T3; Tue, 11 Mar 2025 09:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trzhV-0004IW-6B
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:31:24 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1trzhQ-0006MA-JJ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741699873; x=1773235873;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=1KOmzmrSwiEXReJq2LterO9F8yh62frqUd0TRpdbQtI=;
 b=WoRts0fB2SlGqV7YwpXk8c9l+udqBIHxl0VqOUIVdQXe/McfxTWUF3tv
 Qo4eVQeysjC+Uzhsx+vQsueNu+I2gAvNEX8gZS+PuqmKaE6dpLDpuNNmP
 Mvf0De8KpY0kNw4/3ILjoiZ/tSl4zbFkvX7rKN+v1BJ3LWcryiEPMFZlL
 91i/pySMHroz/rDtMjP9jA/Ua+N6bLL9EI4h8RfNsgnSaNMyPvcWM9R0G
 IpbJ6Gfy4lEduXh1e1yBOcaMdAj/+LPbzv4ETK/T+TrLdUdjqJK2o1V7A
 CCFUI+vj2RLvAylmNe6h8AJax1CX4MHahKjhajxBDHtXyQnywlm//q3/8 g==;
X-CSE-ConnectionGUID: GqAN2r+DQ/Wph7PdYQGhXA==
X-CSE-MsgGUID: kFDHqaHmRtuJaAwm006RsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42648522"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="42648522"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2025 06:31:08 -0700
X-CSE-ConnectionGUID: Pxk/4SkhTnK69gTC0YQDKw==
X-CSE-MsgGUID: VME4DSeXRry7yMJ+/JsIZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; d="scan'208";a="120814359"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 11 Mar 2025 06:31:03 -0700
Date: Tue, 11 Mar 2025 21:51:13 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 mtosatti@redhat.com, sandipan.das@amd.com, babu.moger@amd.com,
 likexu@tencent.com, like.xu.linux@gmail.com,
 zhenyuw@linux.intel.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com
Subject: Re: [PATCH v2 08/10] target/i386/kvm: reset AMD PMU registers during
 VM reset
Message-ID: <Z9A/0RE2Zc7BKDvD@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <Z86Y9BxV6p25A2Wo@intel.com>
 <a52ad0b9-4760-4347-ad73-1690eb28a464@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a52ad0b9-4760-4347-ad73-1690eb28a464@oracle.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

Hi Dongli,

> >> +    /*
> >> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
> >> +     * disable the AMD pmu virtualization.
> >> +     *
> >> +     * If KVM_CAP_PMU_CAPABILITY is supported !cpu->enable_pmu
> >> +     * indicates the KVM has already disabled the PMU virtualization.
> >> +     */
> >> +    if (has_pmu_cap && !cpu->enable_pmu) {
> >> +        return;
> >> +    }
> > 
> > Could we only check "cpu->enable_pmu" at the beginning of this function?
> > then if pmu is already disabled, we don't need to initialize the pmu info.
> 
> I don't think so. There is a case:
> 
> - cpu->enable_pmu = false. (That is, "-cpu host,-pmu").
> - But for KVM prior v5.18 that KVM_CAP_PMU_CAPABILITY doesn't exist.
> 
> There is no way to disable vPMU. To determine based on only
> "!cpu->enable_pmu" doesn't work.

Ah, I didn't get your point here. When QEMU user has already disabled
PMU, why we still need to continue initialize PMU info and save/load PMU
MSRs? In this case, user won't expect vPMU could work.

> It works only when "!cpu->enable_pmu" and KVM_CAP_PMU_CAPABILITY exists.
> 
> 
> We may still need a static global variable here to indicate where
> "kvm.enable_pmu=N" (as discussed in PATCH 07).
>
> > 
> >> +    if (IS_INTEL_CPU(env)) {
> > 
> > Zhaoxin also supports architectural PerfMon in 0xa.
> > 
> > I'm not sure if this check should also involve Zhaoxin CPU, so cc
> > zhaoxin guys for double check.
> 
> Sure for both here and below 'ditto'. Thank you very much!

Per the Linux commit 3a4ac121c2cac, Zhaoxin mostly follows Intel
Architectural PerfMon-v2. Afterall, before this patch, these PMU things
didn't check any vendor, so I suppose vPMU may could work for Zhaoxin as
well. Therefore, its' better to consider Zhaoxin when you check Intel
CPU, which can help avoid introducing some regressions.

Thanks,
Zhao


