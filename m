Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B97F6C021AB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 05:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkd1R-0003TJ-IB; Wed, 19 Feb 2025 00:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkd1P-0003T5-Lk
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 00:53:23 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkd1M-0001sT-Nv
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 00:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739944401; x=1771480401;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=mIfATD4ak/bE/oe7f2i2NgJHDs4bJphTwTkiLSJqm64=;
 b=UHDWIX+MXgT1locO1dI1QY7Rz2FsSaQmhvd7+Zu2h4IPiFksytH9K+7H
 m2RNGztopEh6xvb9kWCePMftLK9EV1cqBIkKWZmmjEm+PMPKOzyDrTZ3Y
 ScAnbFpL8t14SoIzOUub/nWcq/MBunVOhzI0WTUn+48WHWFbp12Rw99F2
 3etTpyrDaOpeaRlZlIL9bzifjUiM6rX3B65Bn15L3nnQBbh8Uhq4xXcYr
 Tx9gP5nK+X2mouApdOQuI6CkYaWHyAawiyGDezjtEwQSq+cHHAQWBPVkd
 T7ZgpE+0iL20HpyOJ0woiHDC0xrCmqn7e9A/U6eF3L8spEacA89vNl1l2 A==;
X-CSE-ConnectionGUID: HqnaTme2S+CnwRCDtQKBlQ==
X-CSE-MsgGUID: aC4rrBOJRKu3Fym/vka7pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40792662"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="40792662"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 21:53:18 -0800
X-CSE-ConnectionGUID: iEv57i2yQHW+RAmib+PHtg==
X-CSE-MsgGUID: NcUWR9PhSvuelVIq/muzDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; d="scan'208";a="115129019"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 18 Feb 2025 21:53:16 -0800
Date: Wed, 19 Feb 2025 14:12:51 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
Message-ID: <Z7V2Y7jVs5jgIoMo@intel.com>
References: <20250218073702.3299300-1-zhao1.liu@intel.com>
 <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
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

On Tue, Feb 18, 2025 at 09:53:00AM +0100, Paolo Bonzini wrote:
> Date: Tue, 18 Feb 2025 09:53:00 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
> 
> On 2/18/25 08:37, Zhao Liu wrote:
> > "addr & 0x18" ignores invalid address, so that the trace in default
> > branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.
> > 
> > Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
> > registers access and ~4 means to keep any invalid address offset.
> 
> I think this is less readable.
> 
> The reason to use !4 in the Rust code is because the initial AND is done
> in a separate function, timer_and_addr(). In C you don't have the same thing.

Yes.

> If anything you could do something like this:
 
> diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
> index ccb97b68066..7c011204971 100644
> --- a/hw/timer/hpet.c
> +++ b/hw/timer/hpet.c
> @@ -425,6 +425,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>      int shift = (addr & 4) * 8;
>      uint64_t cur_tick;
> +    addr &= ~4;
>      trace_hpet_ram_read(addr);
>      /*address range of all TN regs*/
> @@ -437,7 +438,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>              return 0;
>          }
> -        switch (addr & 0x18) {
> +        switch (addr & 0x1f) {
>          case HPET_TN_CFG: // including interrupt capabilities
>              return timer->config >> shift;
>          case HPET_TN_CMP: // comparator register
> @@ -449,7 +450,7 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
>              break;
>          }
>      } else {
> -        switch (addr & ~4) {
> +        switch (addr) {
>          case HPET_ID: // including HPET_PERIOD
>              return s->capability >> shift;
>          case HPET_CFG:
> 
> and the same in the write function, 

Thanks! Your example is clearer!

> but that's also different from the Rust code.

At least, user could know the invalid access by trace in C side. Rust
hasn't supported trace, but it will be in the future.

There will be some differences in code between the two, and we can make
sure that the debug ability to be as consistent as possible.

Thanks,
Zhao


