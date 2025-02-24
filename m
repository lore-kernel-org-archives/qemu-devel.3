Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D28C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 15:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmaAB-0002hs-34; Mon, 24 Feb 2025 10:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmaA8-0002hL-Gl
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:14:28 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmaA6-00040s-7O
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 10:14:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740410066; x=1771946066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=nqnXOdhhbSf3FSsBLv+n0ff4BYjRtr/PsBIjLrIkf30=;
 b=PcpjREZrP3YBbu4hi5hnDqoPUD3oVtP8I5U2ZVXzr0hZBJDVa3KeuIT/
 EbY2zrm2S/sVAobIxVDjufq0Tq8U+hTr1fQww3I7q0mIZnnihNt7Hzg5K
 2SdtM/FOkUB8ZMorLFRo9dXfypCzK/cqgQV0T5PjrFwhidxFlqtffaplc
 n3M46y45+8ZWqn8BIsSVswTzoJ9zM+aqnQVBRLn51A/ZMD1cfIu3pT3Pi
 ANCpXmmdrBLbLZGKs0TiYpdrezvlaF1HfrcMqHWdQ4bMHvr7i/O0wCnIa
 a+dNjiftIIheNIRXhM/ubDqVajmrp2S71yaUVZlg3dAAlsrbE/UL4Vxdi w==;
X-CSE-ConnectionGUID: oc/k+DlkToC6vv2ufLGqVQ==
X-CSE-MsgGUID: kvqEcJCoR5qghd5q2HGG8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="45075988"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="45075988"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2025 07:14:23 -0800
X-CSE-ConnectionGUID: U9UcDV1EToK7wB6Cedv8lQ==
X-CSE-MsgGUID: S1j/Q2SIQNKO7mM0xMFxtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; d="scan'208";a="116106267"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 24 Feb 2025 07:14:22 -0800
Date: Mon, 24 Feb 2025 23:33:58 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?B?TWF0aGlldS1EYXVk77+9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RESEND] i386: Only configure HPET firmware info when HPET
 is enabled
Message-ID: <Z7yRZhwCPkPrrtnu@intel.com>
References: <20250121140121.84550-1-zhao1.liu@intel.com>
 <20250220101525-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220101525-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Hi Michael,

Thanks for looking at here!

On Thu, Feb 20, 2025 at 10:16:56AM -0500, Michael S. Tsirkin wrote:
> Date: Thu, 20 Feb 2025 10:16:56 -0500
> From: "Michael S. Tsirkin" <mst@redhat.com>
> Subject: Re: [PATCH RESEND] i386: Only configure HPET firmware info when
>  HPET is enabled
> 
> On Tue, Jan 21, 2025 at 10:01:21PM +0800, Zhao Liu wrote:
> > At present, the hpet_cfg is written unconditionally since 40ac17cd56eb
> > ("pass info about hpets to seabios.]"), because it concerns ACPI HPET is
> > created unconditionally.
> > 
> > But that fact has changed since 51124bbfd2ea ("i386: acpi: Don't build
> > HPET ACPI entry if HPET is disabled") and ACPI checks if HPET device
> > exists in (hw/i386/acpi-build.c).
> > 
> > Therefore, configure HPET firmware information if and only if HPET is
> > enabled.
> >
> 
> and what is the gain from this change? just a cleanup?

This patch was trying to decouple hpet_cfw with i386 codes, which can
resolve the compilation issue when both the Rust and C versions of HPET
are both disabled.

But this patch is not needed since Paolo has figured out a simpler way
[*].

And thank you anyway!

[*]: https://lore.kernel.org/qemu-devel/CABgObfb6PhiKO9=iWne9AoXQ+Ek7FddoW8D0VcWvw3Qa3TW-9w@mail.gmail.com/

Regards,
Zhao


