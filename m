Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AC3C282CD
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 14:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp74q-0007fH-6F; Mon, 03 Mar 2025 09:47:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp74a-0007TN-0R; Mon, 03 Mar 2025 09:47:12 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tp74W-0005aB-Uz; Mon, 03 Mar 2025 09:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741013229; x=1772549229;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QTvbWc1GG+obRWFaJIgtgWZ8kkNtXfaNvunAvbY8bIo=;
 b=TaYjmc/xfTbOED7mg/HP2vBeIxGJpH06KXxgTFIBSsLOyVewkToB3hnW
 A9vMHD84XcNhwTV6wM5LMWInjPQ9CjiKR+EvRUlUkP7ToTOAIoMT6IgAe
 dQM6NjAzA7LPDjc3+XYEfSZGPHRykj6r1hDOUrZI8VgDYD1o4jCS0zeOT
 qwoMpX+k7W1KYjdF+Q9PBgqxpHV6hNLKoK7igG60iA3VjzY487hoM0jQ4
 bXNhf3umK4jZhA03sC11VJm7g/OuUZ0t5gKKvLxKqAI3XeKZ8Bb3ZsM2u
 /O/yH6WvhBsYHCnXnA3bDPSr2GhCPSseXkPuhDi6Vj1rUTtTWm26ydGdR g==;
X-CSE-ConnectionGUID: CGMqOEGGT/iS3mD8D5jR4w==
X-CSE-MsgGUID: RJtMxkjqQJaH+uKck/o4ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="52095773"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="52095773"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2025 06:47:05 -0800
X-CSE-ConnectionGUID: 1P2hq9MpRQ+EsaGwt15Ilw==
X-CSE-MsgGUID: xTf1Sh3jQVu6PqFPv96Vtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; d="scan'208";a="118729878"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 03 Mar 2025 06:47:04 -0800
Date: Mon, 3 Mar 2025 23:07:10 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 05/12] rust: irq: wrap IRQState with Opaque<>
Message-ID: <Z8XFnknjvv6ACcrm@intel.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
 <20250227142219.812270-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227142219.812270-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 27, 2025 at 03:22:12PM +0100, Paolo Bonzini wrote:
> Date: Thu, 27 Feb 2025 15:22:12 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/12] rust: irq: wrap IRQState with Opaque<>
> X-Mailer: git-send-email 2.48.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/qemu-api/src/irq.rs    | 15 ++++++++++-----
>  rust/qemu-api/src/sysbus.rs |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)

...

> +///
>  /// Interrupts are implemented as a pointer to the interrupt "sink", which has
>  /// type [`IRQState`].  A device exposes its source as a QOM link property using
>  /// a function such as [`SysBusDeviceMethods::init_irq`], and
> @@ -40,7 +45,7 @@ pub struct InterruptSource<T = bool>
>  where
>      c_int: From<T>,
>  {
> -    cell: BqlCell<*mut IRQState>,
> +    cell: BqlCell<*mut bindings::IRQState>,
>      _marker: PhantomData<T>,
>  }

Thanks! Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


