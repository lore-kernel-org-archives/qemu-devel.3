Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C26C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 14:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbKrG-00030T-8q; Fri, 24 Jan 2025 09:40:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbKrE-000300-JB
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:40:28 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tbKrC-00041a-Qc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 09:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737729627; x=1769265627;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lqBcTjUad00nEjl4On6LQYz18KLKlD9aDKrmHzFPdpI=;
 b=NDTLyfmFeoAg39ChhqLFSP7QBuq5RU3r5yLCppJBh9A/dlJ8Wp5FALHi
 syh86AKjOunFiO0rM6xLcRbHPaWlkuKMl/H42hHZ6RrL8qoO+F4+TBN+e
 1D1T+obv8kz8hIoygq4GwbwmtLDfL3l7ti0kZCO0ZQ9cP964lZrv5dnuP
 WYRvvRb551j8J8RX7pOj03n+zoUtJ/N+hCG2PCNNk4dKsDyXHCCwwzJfb
 Gg7lMxlhe/z4Y1PIhMPCeQ7Br4AD9gGgo6HFR3mhh02dS3LzOdhBZkIJr
 s0f+vLjSjrX3GcbFFb/CAMoCmhl1qwSyvZUA483a+LcpgdeqBCufo0jPA g==;
X-CSE-ConnectionGUID: RutNHKyyTLCfSVWciA+ivA==
X-CSE-MsgGUID: IlBozKzfRWuQ/qrfe8nuwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="48848574"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="48848574"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 06:40:22 -0800
X-CSE-ConnectionGUID: mbTDrtKNSzCyF5GPWrD/7w==
X-CSE-MsgGUID: Z5ikiRxSSPiCXFFrBWmsBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="112915996"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2025 06:40:21 -0800
Date: Fri, 24 Jan 2025 22:59:44 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hpet: do not overwrite properties on post_load
Message-ID: <Z5Oq4LppNuN7N6NL@intel.com>
References: <20241205203721.347233-1-pbonzini@redhat.com>
 <Z1K7oMumN1Mu+1v9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1K7oMumN1Mu+1v9@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This patch was missed :-) which could free HPETState.flags from a
BqlCell.

> > -    /* Push number of timers into capability returned via HPET_ID */
> > -    s->capability &= ~HPET_ID_NUM_TIM_MASK;
> > -    s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
> > -    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
> > -
> > -    /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
> > -    s->flags &= ~(1 << HPET_MSI_SUPPORT);
> > -    if (s->timer[0].config & HPET_TN_FSB_CAP) {
> > -        s->flags |= 1 << HPET_MSI_SUPPORT;
> 
> About the MSI (FSB) support, I haven't seen it being used anywhere. Is it the
> dead code?
> 

I have this question since I find it seems no way to set "msi" and
"timers" properties by user, and no code sets them.

    DEFINE_PROP_UINT8("timers", HPETState, num_timers, HPET_MIN_TIMERS),
    DEFINE_PROP_BIT("msi", HPETState, flags, HPET_MSI_SUPPORT, false),

Thanks,
Zhao


