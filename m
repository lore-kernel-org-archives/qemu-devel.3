Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40B110F3DCD
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7DTl-0005D8-E0; Mon, 30 Mar 2026 10:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7DTj-0005Aw-D1
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:20:31 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1w7DTf-0001KK-Gh
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:20:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774880427; x=1806416427;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Tve9qn/j7kSthh8NTWiiiFPSRxdmkB42Wi4X15EMmQA=;
 b=GAZ3dTDTyk7mJ0DhVYgE+SbDoaSDaBitff43xx+13NXHLgeozw89ryLe
 HGrRTxzcMQxriqxnxHQg4EVOrO85yBO5BX8RVMYGu6DD0cYJxVNJep6Nw
 kXHvlqJ5msencxIDwx5V1bY9Mmfong4uCw2EO/wlYCNr/AbtMdE4zU+0p
 6OevU0ClsE5fvF12n8oJy5Zosotj45HG6hqP2kUdDz1JBIXUKVvj0qzA6
 P1orsGFGZok1eIQAIpRd6rww5QnU1dvzNG3OH2n2UxS05NNNFyM97hNPT
 It8qJMSzgHF5b3pFcmby95TLsEsJncbGfXqc6yTpD3JN4CQbbtybA4Dlp g==;
X-CSE-ConnectionGUID: 4f5SZkwMQvGYwPMxMVvJCA==
X-CSE-MsgGUID: 0CSjqt3BT/u+k9RJRSwNxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11743"; a="86492317"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="86492317"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2026 07:20:25 -0700
X-CSE-ConnectionGUID: IkbiNFbYSaOgBkHdQDUsYg==
X-CSE-MsgGUID: /XX0vHfBTcaiBHTOgh5aGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; d="scan'208";a="226050689"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 30 Mar 2026 07:20:24 -0700
Date: Mon, 30 Mar 2026 22:46:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Yuma Kurogome, Ricerca Security, Inc." <yumak@ricsec.co.jp>
Subject: Re: [PATCH] hpet: fix bounds check for s->timer[]
Message-ID: <acqM0he6SpiY7LOK@intel.com>
References: <20260327174701.364328-1-pbonzini@redhat.com>
 <CAFEAcA8R0qGsaBAQLgAGRgU1H+4JRpRCa8TaeAcdYo25R=dQww@mail.gmail.com>
 <CABgObfYxPmG+M1t8VakdKiKEkunQ8cyLfoo8dtVQTTR4RtxUug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfYxPmG+M1t8VakdKiKEkunQ8cyLfoo8dtVQTTR4RtxUug@mail.gmail.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Mar 27, 2026 at 09:02:09PM +0100, Paolo Bonzini wrote:
> Date: Fri, 27 Mar 2026 21:02:09 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH] hpet: fix bounds check for s->timer[]
> 
> Il ven 27 mar 2026, 19:46 Peter Maydell <peter.maydell@linaro.org> ha
> scritto:
> 
> > > (even
> > > though HPET_MAX_TIMERS is 32) the HPET only has room for 24 timers in
> > > its MMIO region,

It seems like a missing case for HPET spec v1.0a (about how to extend
MMIO). The MMIO size (HPET_LEN = 0x400) and max timers (HPET_MAX_TIMERS
= 32) are both from the spec. And general capabilities register
allocates bits 8-12 for NUM_TIM_CAP (up to 32 timers).

The spec only mentions for IA64 platform, the timer register space can
be up to 64K bytes with page protection capability. :(

> If we can only fit 24 timers into the MMIO region, should we do one of:
> >  * lower HPET_MAX_TIMERS
> >  * enlarge the MMIO region
> >  * leave HPET_MAX_TIMERS where it is but make realize enforce
> >    that num_timers <= 24 ?
> >
> 
> Lowering HPET_MAX_TIMERS is the easiest, yes. No one really uses anything
> but the default anyway.

yes, I agree, maybe no vender implememnts more than 24 timers, which is
why HPET doesn't provide further details on MMIO extensions I think.

Regards,
Zhao


