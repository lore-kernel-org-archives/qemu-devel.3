Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51FAC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 11:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjcoK-0004ye-Qr; Sun, 16 Feb 2025 06:27:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjcoI-0004y5-1B; Sun, 16 Feb 2025 06:27:42 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tjcoE-0001G7-FP; Sun, 16 Feb 2025 06:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739705258; x=1771241258;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=skh4bQ2t97KY8d+tx+gGGRpHVl1qmREwLCPXTtFQgiM=;
 b=k0dzPamA9XrgwNLi+s2YafWcBk8OzlFlhKTjA7ugXlEakWS6ccfgOhnz
 lgDEOP1XMboAc8lEYLEu2TO33+KGXwx472hM+Ps1vzb2lBV5qqF5FAsr+
 MfYeZ9D+8+X/QFypZ7ndaou9rosvrm/v9H4YJoPWUKTwMzp8ulln12zlV
 W8+IXO7EPIhtXJUAFzZIal0sJzaTUWQfIrE3HLyVV/xaGQg7I4LTcB5fZ
 YH3kiUbH41kq1F5WAARHSGuBW4gFQHGSVFxyYmmi8Hk1F3Wu+hPywfqx5
 V7TpLFXuw9515PJgdhb5g4rXHJuCTrYyL2WMFXCxYaYo38qTMiKKYn2H9 g==;
X-CSE-ConnectionGUID: rCY0mu+ISWq4R6hhaUH6hw==
X-CSE-MsgGUID: GitZjZIJTaK9JTCmXUIHMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40327330"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; d="scan'208";a="40327330"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2025 03:27:33 -0800
X-CSE-ConnectionGUID: GVpNehOJSFycEQ3jpxN0wQ==
X-CSE-MsgGUID: ls0MjM4pTXWJ7fp6iTNYDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; d="scan'208";a="113746215"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 16 Feb 2025 03:27:31 -0800
Date: Sun, 16 Feb 2025 19:47:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 01/10] i386/fw_cfg: move hpet_cfg definition to hpet.c
Message-ID: <Z7HQONYiq5GFIw9+@intel.com>
References: <20250210030051.2562726-1-zhao1.liu@intel.com>
 <20250210030051.2562726-2-zhao1.liu@intel.com>
 <CABgObfb6PhiKO9=iWne9AoXQ+Ek7FddoW8D0VcWvw3Qa3TW-9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfb6PhiKO9=iWne9AoXQ+Ek7FddoW8D0VcWvw3Qa3TW-9w@mail.gmail.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.195,
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

On Thu, Feb 13, 2025 at 12:25:55PM +0100, Paolo Bonzini wrote:
> Date: Thu, 13 Feb 2025 12:25:55 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [PATCH v2 01/10] i386/fw_cfg: move hpet_cfg definition to
>  hpet.c
> 
> On Mon, Feb 10, 2025 at 3:41 AM Zhao Liu <zhao1.liu@intel.com> wrote:
> > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > index d2cb08715a21..546de63123e6 100644
> > --- a/hw/i386/fw_cfg.c
> > +++ b/hw/i386/fw_cfg.c
> > @@ -26,8 +26,6 @@
> >  #include CONFIG_DEVICES
> >  #include "target/i386/cpu.h"
> >
> > -struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
> 
> This must be kept for the case where HPET is not enabled at all in the
> build; removing the FW_CFG_HPET file changes the guest API and I'd
> prefer to merge the Rust HPET implementation without having to figure
> out the safety of that change.
> 
> No need to do anything, I'll just make it
> 
> #if !defined(CONFIG_HPET) && !defined(CONFIG_X_HPET_RUST)
> const struct hpet_fw_config hpet_fw_cfg = {.count = UINT8_MAX};
> #endif
> 

Thanks! This makes sense.

Zhao


