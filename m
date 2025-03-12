Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2F0C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 08:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsHAL-0003pt-Gf; Wed, 12 Mar 2025 04:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tsHAD-0003lZ-FN
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:10:06 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tsHAA-0002qZ-RD
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 04:10:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741767003; x=1773303003;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Aej7uSydC5Ff1oCpTr2BwUDISjhUC3cOAX+PsKHMFrY=;
 b=LsXd0OoqvwC8xNw5zGyOlfeRCw1HtZTIXpF3u/fFzBgb600QFStFiQIS
 VY7Rf0ILgO3pQr7mBF8eZR660cWwUWPAWTnKXOcGaevX0NgRxHFMWqGwh
 Lur0vCu62sCWfptzY7iYdyCswM65yZ2+61CYLqmIIUJkwlRhXiZp6d0kO
 bMzvjRAnuhFMS7AvmnV+fJwEoIMP5vpTZiAHayDImqqvHY9qfaIAvw/Ca
 gyhCreJj9PSCgu6HIdODzPY+06dFfj3PebNij7p5ZnJfErNEHAw3o/Ypd
 BSZyFWmLYcieZnPJxC+W87VXVoBgrJXjYsyEA1bYPx0wQpH/Ao+u7rWvs g==;
X-CSE-ConnectionGUID: +HaJxur3TuWsviOEW66upg==
X-CSE-MsgGUID: blrpTO+/TbOjWNVn1cxKFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="42747319"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="42747319"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Mar 2025 01:09:59 -0700
X-CSE-ConnectionGUID: E/C4qN+cQs6Actd9TlWwIA==
X-CSE-MsgGUID: /OVup4TCQuGeLwFECSscIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; d="scan'208";a="125466778"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 12 Mar 2025 01:09:55 -0700
Date: Wed, 12 Mar 2025 16:30:05 +0800
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
Message-ID: <Z9FGDfzqimDo8SV5@intel.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
 <20250302220112.17653-9-dongli.zhang@oracle.com>
 <Z86Y9BxV6p25A2Wo@intel.com>
 <a52ad0b9-4760-4347-ad73-1690eb28a464@oracle.com>
 <Z9A/0RE2Zc7BKDvD@intel.com>
 <976f58aa-5e14-4dda-ae07-f78276b54ff8@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <976f58aa-5e14-4dda-ae07-f78276b54ff8@oracle.com>
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

> >>>> +    /*
> >>>> +     * If KVM_CAP_PMU_CAPABILITY is not supported, there is no way to
> >>>> +     * disable the AMD pmu virtualization.
> >>>> +     *
> >>>> +     * If KVM_CAP_PMU_CAPABILITY is supported !cpu->enable_pmu
> >>>> +     * indicates the KVM has already disabled the PMU virtualization.
> >>>> +     */
> >>>> +    if (has_pmu_cap && !cpu->enable_pmu) {
> >>>> +        return;
> >>>> +    }
> >>>
> >>> Could we only check "cpu->enable_pmu" at the beginning of this function?
> >>> then if pmu is already disabled, we don't need to initialize the pmu info.
> >>
> >> I don't think so. There is a case:
> >>
> >> - cpu->enable_pmu = false. (That is, "-cpu host,-pmu").
> >> - But for KVM prior v5.18 that KVM_CAP_PMU_CAPABILITY doesn't exist.
> >>
> >> There is no way to disable vPMU. To determine based on only
> >> "!cpu->enable_pmu" doesn't work.
> > 
> > Ah, I didn't get your point here. When QEMU user has already disabled
> > PMU, why we still need to continue initialize PMU info and save/load PMU
> > MSRs? In this case, user won't expect vPMU could work.
> 
> Yes, "In this case, user won't expect vPMU could work.".
> 
> But in reality vPMU is still active, although that doesn't match user's
> expectation.
> 
> User doesn't expect PMU to work. However, "perf stat" still works in VM
> (when KVM_CAP_PMU_CAPABILITY isn't available).
> 
> Would you suggest we only follow user's expectation?

Yes, for this case, many PMU related CPUIDs have already been disabled
because of "!enable_pmu", so IMO it's not necessary to handle other PMU
MSRs.

> That is, once user
> configure "-pmu", we are going to always assume vPMU is disabled, even it
> is still available (on KVM without KVM_CAP_PMU_CAPABILITY and prior v5.18)?

Strictly speaking, only the earlier AMD PMUs are still AVAILABLE at this
point, as the other platforms, have CPUIDs to indicate PMU enablement.
So for the latter (which I understand is most of the cases nowadays),
there's no reason to assume that the PMUs are still working when the CPUIDs
are corrupted...

There is no perfect solution for pre-v5.18 kernel... But while not breaking
compatibility, again IMO, we need the logic to be self-consistent, i.e.
any time the user does not enable vPMU (enable_pmu = false), it should be
assumed that vPMU does not work.

Thanks,
Zhao


