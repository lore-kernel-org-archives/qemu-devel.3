Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3E7C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 15:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rezb7-0002hc-D2; Tue, 27 Feb 2024 10:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rezb4-0002gB-Hf; Tue, 27 Feb 2024 10:42:22 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rezaw-00076i-Ok; Tue, 27 Feb 2024 10:42:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709048535; x=1740584535;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=PpopX1xgqsSGu+ibkHdRkgrvQaMYRWvsytFX1WWOZtI=;
 b=CtDFgnHDJdtfOdlSn9C1p1uoqg4PMLDW0uQrVwnZu9uIKuLijRvvT/iW
 OMH8huDa1opt3Xl/KOgXPGkSA90rz4gznV//WhSBIKRPPTJo0G6PP9w2A
 eJh3jzFdhrU3Q3x2micsFHA8SBWuviNHoqIrlv++MuXDP1gikTqtl8TBS
 2XYX/Nx8BXoPyGlpL/WbXdokqLNBb+Ktu8m3GSbtVKF99zuyoNAi2/tc4
 pbnega3IVbchXwgHcbHe05eCCAgp7XS0dm1Y2yJuXCJwdoqJM3PWOzhlt
 5DL1TFZY5z4OzBUCceu2Ovlg7YneT2wS1Qr+3rsvOWEgBxToZi/PeJfa3 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3513684"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="3513684"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2024 07:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; d="scan'208";a="11697786"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 27 Feb 2024 07:42:04 -0800
Date: Tue, 27 Feb 2024 23:55:46 +0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel P =?utf-8?B?LiBCZXJyYW5n77+9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Alex =?utf-8?B?QmVubu+/vWU=?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Yongwei Ma <yongwei.ma@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
Message-ID: <Zd4GAhwpw/w0QUth@intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
 <20240220092504.726064-5-zhao1.liu@linux.intel.com>
 <20240226153947.00006fd6@Huawei.com> <Zd2pWVH4/eo3HM8j@intel.com>
 <20240227105145.0000106d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227105145.0000106d@Huawei.com>
Received-SPF: none client-ip=198.175.65.18;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 27, 2024 at 10:51:45AM +0000, Jonathan Cameron wrote:
> Date: Tue, 27 Feb 2024 10:51:45 +0000
> From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Subject: Re: [RFC 4/8] hw/core: Add cache topology options in -smp
> X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
> 
> On Tue, 27 Feb 2024 17:20:25 +0800
> Zhao Liu <zhao1.liu@linux.intel.com> wrote:
> 
> > Hi Jonathan,
> > 
> > > Hi Zhao Liu
> > > 
> > > I like the scheme.  Strikes a good balance between complexity of description
> > > and systems that actually exist. Sure there are systems with more cache
> > > levels etc but they are rare and support can be easily added later
> > > if people want to model them.  
> > 
> > Thanks for your support!
> > 
> > [snip]
> > 
> > > > +static int smp_cache_string_to_topology(MachineState *ms,  
> > > 
> > > Not a good name for a function that does rather more than that.  
> > 
> > What about "smp_cache_get_valid_topology()"?
> 
> Looking again, could we return the CPUTopoLevel? I think returning
> CPU_TOPO_LEVEL_INVALID will replace -1/0 returns and this can just
> be smp_cache_string_to_topology() as you have it in this version.
> 
> The check on the return value becomes a little more more complex
> and I think you want to squash CPU_TOPO_LEVEL_MAX down so we only
> have one invalid value to check at callers..  E.g.
> 
> static CPUTopoLevel smp_cache_string_to_topolgy(MachineState *ms,
>                                                 char *top_str,
>                                                 Error **errp)
> {
>     CPUTopoLevel topo = string_to_cpu_topo(topo_str);
> 
>     if (topo == CPU_TOPO_LEVEL_MAX || topo == CPU_TOP?O_LEVEL_INVALID) {
>         return CPU_TOPO_LEVEL_INVALID;
>     }
> 
>     if (!machine_check_topo_support(ms, topo) {
>         error_setg(errp,
>                    "Invalid cache topology level: %s. "
>                    "The cache topology should match the CPU topology level",
> //Break string like this to make it as grep-able as possible!
>                    topo_str);
>         return CPU_TOPO_LEVEL_INVALID;
>     }
> 
>     return topo;
> 
> }                
> 
> 
> The checks then become != CPU_TOPO_LEVEL_INVALID at each callsite.
>

Good idea! This makes the code clearer. Let me try this way. Thanks!


