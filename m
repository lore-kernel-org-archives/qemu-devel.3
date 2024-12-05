Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C0DE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 06:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJ4yj-0007Fy-FN; Thu, 05 Dec 2024 01:04:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4yf-0007FC-MF; Thu, 05 Dec 2024 01:04:41 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tJ4yX-0005Fn-Gz; Thu, 05 Dec 2024 01:04:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733378673; x=1764914673;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=sRVrzqxgowgNuEq+HU+J5QCFqfpel+2YZVRxDHlc328=;
 b=Fa3ft/CkcZgBhWR5IQ3ILiakDzQStPqmH42nA3ImHD9knjPb/LHq2Ytk
 4No8z9Tmo9yN24aVs1ub6EbSGnCydahfdtsVTFymvQT5yHl4NqvJSNgk3
 vyaH5RjIXV3JuhS2+KawFi8Byhqd4uw52U6jGev4o7MzKM0TPKy9N82Zx
 6rPlkvdSHZZDGoVFDPSHlPq7aqyEScQS4kd9++1MIRN2aJC/eOzDnwNF8
 p1REw95FrTLkC/RWRPf8hoxbfs3gCMHoQcah45oLcsXUSFHd4I+Vc4wqC
 ux3yKVfQdIHccg89aHhsexXvxnkeMpdEyK/zp4ahPp9Jq+lafHkKZKRil Q==;
X-CSE-ConnectionGUID: wbLROBxaRs2IraBL/AC+dQ==
X-CSE-MsgGUID: hyg3H8RtRhWYvY5hC5MUSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11276"; a="44281055"
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="44281055"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Dec 2024 22:04:28 -0800
X-CSE-ConnectionGUID: PIC/4ZFDTwaE3A95eZQQhA==
X-CSE-MsgGUID: mauZe62oR5OcegsQ/oyWKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,209,1728975600"; d="scan'208";a="98961225"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa005.jf.intel.com with ESMTP; 04 Dec 2024 22:04:26 -0800
Date: Thu, 5 Dec 2024 14:22:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [RFC 00/13] rust: Reinvent the wheel for HPET timer in Rust
Message-ID: <Z1FGrQC4g8Nq0Wwr@intel.com>
References: <20241205060714.256270-1-zhao1.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205060714.256270-1-zhao1.liu@intel.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

> After making empty promises for many months, I have finally written the
> Rust version of HPET :-) I'm also very grateful for the help from Paolo,
> Manos, and Junjie!
> 
> Overall, HPET in Rust maintains the same logic as the original C
> version, adhering to the IA-HPET spec v1.0a [1]. While keeping the logic
> unchanged, it attempts to keep up with the current development progress
> of Rust for QEMU, leveraging the latest and ongoing Rust binding updates
> as much as possible, such as BqlCell / BqlRefCell, qom & qdev
> enhancements, irq binding, and more. Additionally, it introduces new
> bindings, including gpio_{in|out}, bitops, memattrs, and timer. Finally,
> based on Paolo's suggestion, the vmstate part is temporarily on hold.
> 
> Welcome your comments and feedback!

Based on Paolo's rust-next branch of https://gitlab.com/bonzini/qemu at
the commit 05de50008121 ("rust: qom: move device_id to PL011 class side").
 
[snip]

> Public and Private in QOM State
> -------------------------------
> 
> I recently asked on the mailing list [4] about the reason for using
> "<public>"/"<private>" comments in QOM structures. Peter, Junjie, and
> Balaton provided some explanations and feedback (thank you all).

And thanks Daniel!!

...

> [4]: https://lore.kernel.org/qemu-devel/ZxPZ5oUDRcVroh7o@intel.com/

Regards,
Zhao


