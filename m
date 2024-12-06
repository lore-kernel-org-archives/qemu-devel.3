Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15204E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJTob-0008RM-HE; Fri, 06 Dec 2024 03:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJToQ-0008Jh-Jr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:49 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJToO-0000V8-32
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 03:35:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733474144; x=1765010144;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LHW2bwV7KvSfxrZymFNIT7Gz/I7Rzo7bWPXOULc6x0w=;
 b=RXqaShik1bOfR6vjcWiT5ufv/HFyf3jydabqXuYaVLZ0tTdIu9OW5tx6
 nXL9m8uvGRp6qBYQIIbFGAcL3ErsKNyV2WHW3nDRutRFhkLvlMHMyTeZT
 9i6kN0HamzyCxcs7RQD48+rm6GbJtrYJOAN3xc2dv+AkF5vKdief56NmC
 kAQNAkkK67ju6/ioEcE59s+2c+PoHykphLZe0FBIZUhOgbM6vZwdsj6Yo
 axbFL9beDBxl3262PBGUN3dMWHgY+L8DIQn5aU/4+DybGt6zTyCbEdq9j
 OCd363zO0vTv6L8YsCBXzZQeW3I1AsFlcadb1T80frVjY/GDidXeO9LHn w==;
X-CSE-ConnectionGUID: fc6gpaF5ShqA88dzz95e0g==
X-CSE-MsgGUID: G6xlKXNDQ7uXit4H7D5NZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33703090"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="33703090"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2024 00:35:41 -0800
X-CSE-ConnectionGUID: Sn1dbOY5TvymiagqyNnR0Q==
X-CSE-MsgGUID: z5M21bfxTo+n7iHZrPWFmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="94025149"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 06 Dec 2024 00:35:40 -0800
Date: Fri, 6 Dec 2024 16:53:52 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH] hpet: do not overwrite properties on post_load
Message-ID: <Z1K7oMumN1Mu+1v9@intel.com>
References: <20241205203721.347233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205203721.347233-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Thu, Dec 05, 2024 at 09:37:21PM +0100, Paolo Bonzini wrote:
> Date: Thu,  5 Dec 2024 21:37:21 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] hpet: do not overwrite properties on post_load
> X-Mailer: git-send-email 2.47.1
> 
> Migration relies on having the same device configuration on the source
> and destination.  Therefore, there is no need to modify flags,
> timer capabilities and the fw_cfg HPET block id on migration;
> it was set to exactly the same values by realize.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/timer/hpet.c | 10 ----------
>  1 file changed, 10 deletions(-)

Indeed, thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index 5399f1b2a3f..18c8ce26e0d 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -275,16 +275,6 @@ static int hpet_post_load(void *opaque, int version_id)
>                          - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>      }
>  
> -    /* Push number of timers into capability returned via HPET_ID */
> -    s->capability &= ~HPET_ID_NUM_TIM_MASK;
> -    s->capability |= (s->num_timers - 1) << HPET_ID_NUM_TIM_SHIFT;
> -    hpet_cfg.hpet[s->hpet_id].event_timer_block_id = (uint32_t)s->capability;
> -
> -    /* Derive HPET_MSI_SUPPORT from the capability of the first timer. */
> -    s->flags &= ~(1 << HPET_MSI_SUPPORT);
> -    if (s->timer[0].config & HPET_TN_FSB_CAP) {
> -        s->flags |= 1 << HPET_MSI_SUPPORT;

About the MSI (FSB) support, I haven't seen it being used anywhere. Is it the
dead code?

> -    }
>      return 0;
>  }
>  
> -- 
> 2.47.1
> 

