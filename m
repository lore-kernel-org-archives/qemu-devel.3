Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E239FE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 08:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJU0w-0001Pr-2P; Fri, 06 Dec 2024 03:48:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJU0t-0001P1-AP; Fri, 06 Dec 2024 03:48:39 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJU0q-000281-IH; Fri, 06 Dec 2024 03:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733474917; x=1765010917;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NbLCRzDIFRKoVHiBviovQ5AhbZ97mMp/mc4EDknjibE=;
 b=Gtx5yK8iyhgaIGYLCqNQk7WUmuIowrlmMxd6bG9CJc23yXIZbU/aKAKA
 /XBCoCBQsEKIOPQvDOfynPGvF8LPlRDUgg6LT/OvGz7rDf/UMY2Z9Fk/F
 ysKZsZgX5Fp9VYRuuOS3xkGSfxUL+R51lE+1bUorf0rmXNy68/EANPU4U
 Y1t0xC9HrfpG5D6IKyA3akYHHw/TFRPzKcbfQUyq55hwFq5jJQpJVdPxb
 fdvAXwmHtDIHKPypDkNGomgY9GXRET5qX0fKRVqOX36vb+TIxDkWSYiX3
 fGeDgA5Y9nGFRxaYSj2f4H6HZ8FSZtblQd6GtGcBMP6eCO/pnzqyGl8uv Q==;
X-CSE-ConnectionGUID: HRBM/TgSSIyhI4kaEtpGgw==
X-CSE-MsgGUID: y8yFTYRiQ7qK/LD47TuG5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33741984"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="33741984"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2024 00:48:34 -0800
X-CSE-ConnectionGUID: f1h6/wlSRomWbhZKNuPq6A==
X-CSE-MsgGUID: yy9baQwYTRKNMoIKsLqAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; d="scan'208";a="94828118"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 06 Dec 2024 00:48:31 -0800
Date: Fri, 6 Dec 2024 17:06:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC 13/13] i386: enable rust hpet for pc when rust is enabled
Message-ID: <Z1K+o+VPgJ+RkxDn@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-14-zhao1.liu@intel.com>
 <a76ccad6-5c8d-47e1-9613-9ac48df38940@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a76ccad6-5c8d-47e1-9613-9ac48df38940@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 05, 2024 at 04:20:44PM +0100, Paolo Bonzini wrote:
> Date: Thu, 5 Dec 2024 16:20:44 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: Re: [RFC 13/13] i386: enable rust hpet for pc when rust is enabled
> 
> On 12/5/24 07:07, Zhao Liu wrote:
> > Add HPET configuration in PC's Kconfig options, and select HPET device
> > (Rust version) if Rust is supported.
> > 
> > Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> > ---
> >   hw/i386/Kconfig       | 2 ++
> >   hw/timer/Kconfig      | 1 -
> >   rust/hw/Kconfig       | 1 +
> >   rust/hw/timer/Kconfig | 2 ++
> >   4 files changed, 5 insertions(+), 1 deletion(-)
> >   create mode 100644 rust/hw/timer/Kconfig
> > 
> > diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> > index 32818480d263..83ab3222c4f0 100644
> > --- a/hw/i386/Kconfig
> > +++ b/hw/i386/Kconfig
> > @@ -39,6 +39,8 @@ config PC
> >       select PCSPK
> >       select I8257
> >       select MC146818RTC
> > +    select HPET if !HAVE_RUST
> > +    select X_HPET_RUST if HAVE_RUST
> 
> HPET is optional, so you need to have...

Oops, I didn't realize that.

> >   config HPET
> >       bool
> > -    default y if PC
> 
> +default y if PC && !HAVE_RUST
> 
> with a matching "default y if PC && HAVE_RUST" for X_HPET_RUST.

Thank you!

-Zhao


