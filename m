Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DCAC021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 03:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkaYV-0001lT-6R; Tue, 18 Feb 2025 22:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkaYT-0001lG-00
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 22:15:21 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkaYQ-0003fC-FG
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 22:15:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739934919; x=1771470919;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=Oxjfc1/h9rhfAuzQMt/cjsFTPdlczPI6KI9XxAov4dY=;
 b=M+pCoo4HAruFCBLHYYiIRJ22+pItf0pZROx3dXBpIZhJPYpKswCY53g/
 GwyRbCOX1x63muxSwrh4brWcLv1sgSoFNlk3XgzRvi9MMIZnRX/IHohEE
 tQ/9H7s0vI8eNKEC5HZ12fApMhQFPHcJjeHa03j7y5kEBCr6EAutO/p2B
 8hFKblLG8Xy9B9nIH3RWdLXRROX7lTvoM14DTQALzjndWLVcyA1U6tv89
 g4VEBdbk8fxArob36nKduQIOaK6EcbOJKfGt8M+Rt11BNp4ddoVTHqBrp
 u5ncktG7ZZELIBigviY0wh4uXL6Xd2LfDDAQxek3dnJ71S9kzeFuUEHYk w==;
X-CSE-ConnectionGUID: LGUmnPVRRfqgnOnu5gOK2Q==
X-CSE-MsgGUID: /5k+yufdS0ObvZ2/uBQnWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44575264"
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="44575264"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 19:15:14 -0800
X-CSE-ConnectionGUID: JACMt5ptRp69Nl+KNMz60A==
X-CSE-MsgGUID: P2EIFEIaTJGCXQgj2ktReA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,296,1732608000"; d="scan'208";a="114571232"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 18 Feb 2025 19:15:13 -0800
Date: Wed, 19 Feb 2025 11:34:47 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
Message-ID: <Z7VRVwirDMqbF4LZ@intel.com>
References: <20250218073702.3299300-1-zhao1.liu@intel.com>
 <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
 <cf10367d-90da-48d4-8440-7afb8b083883@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf10367d-90da-48d4-8440-7afb8b083883@linaro.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
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

On Tue, Feb 18, 2025 at 10:07:18AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Tue, 18 Feb 2025 10:07:18 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
> 
> On 18/2/25 09:53, Paolo Bonzini wrote:
> > On 2/18/25 08:37, Zhao Liu wrote:
> > > "addr & 0x18" ignores invalid address, so that the trace in default
> > > branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.
> > > 
> > > Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
> > > registers access and ~4 means to keep any invalid address offset.
> > 
> > I think this is less readable.
> > 
> > The reason to use !4 in the Rust code is because the initial AND is done
> > in a separate function, timer_and_addr().
> 
> Having a quick look at the model without looking at the specs:
> 
> include/hw/timer/hpet.h:20:#define HPET_LEN                0x400
> 
> hw/timer/hpet.c:439:static uint64_t hpet_ram_read(...,
> hw/timer/hpet.c-441-{
> hw/timer/hpet.c-448-    /*address range of all TN regs*/
> hw/timer/hpet.c-449-    if (addr >= 0x100 && addr <= 0x3ff) {
> hw/timer/hpet.c-450-        uint8_t timer_id = (addr - 0x100) / 0x20;
>                             ...
> hw/timer/hpet.c-469-    } else {
> hw/timer/hpet.c-470-        switch (addr & ~4) {
>                                  ...
> hw/timer/hpet.c-488-        }
> hw/timer/hpet.c-489-    }
> hw/timer/hpet.c-490-    return 0;
> hw/timer/hpet.c-491-}
> 
> hw/timer/hpet.c:699:    memory_region_init_io(&s->iomem, obj,
>                                               &hpet_ram_ops, s,
>                                               "hpet", HPET_LEN);
> 
> I suppose we want to register multiple timers of I/O size 0x20 at 0x100,
> and the I/O size of 0x20 at 0x000 is a generic control region.

Range of general control region is from 0x00 to 0xff.

> Maybe split hpet_ram_ops in 2 (hpet_cfg_ops and hpet_tmr_ops), mapping
> the first one once at 0x000 and the other 24 times at 0x100-0x3ff?
> 
> My 2 cents looking at QDev modelling to avoid these address
> manipulations.

I think it's a good idea! Pls give me some time to try applying
memory_region_add_subregion() to this HPET case. :-)

Thanks,
Zhao


