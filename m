Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6547BC021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmpxp-0006Gj-VG; Tue, 25 Feb 2025 03:06:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmpxo-0006GM-99; Tue, 25 Feb 2025 03:06:48 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tmpxm-0003KZ-8L; Tue, 25 Feb 2025 03:06:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740470807; x=1772006807;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=n9RpmYDIFhb5St0ldENbDzfjlYnp7IIS8EXlppT1cGs=;
 b=mBb37im7JKOZpJkWQuD9XLFz8GQoJp+2LWmXipyMXPyVH8SOVtJAqRcu
 J3fuN1puQoT72paosYoTp/7zc7xXkd4Ck/xMIYyAs/8x+LiuUh7EImQRX
 GK9ckk9Djn88ezgfoDRsW8jyfudST9CGwfBHLamI7YLrqN3JqCzw0MZso
 hXOX8ZYYy3jwrG/5mzWO3tepogq9PEu/Z+BaUaMxRD4EbVolbuNWUC/jC
 bGoNtLrE0zds7jHYHEE4vyjmQq0SkelbeetM0VKFstAoa1EF9zfzao46K
 UvCMXQ9bi3eIFgdE9PQNzk14o9oSztJxrTIamX4HtU0QycVx10R9abLui w==;
X-CSE-ConnectionGUID: JvhB863cSl+wVWe9PfQAGg==
X-CSE-MsgGUID: HsQGpyRcTPW2Z2PKPj1XNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="40966347"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="40966347"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2025 00:06:43 -0800
X-CSE-ConnectionGUID: XOQXjDbETvKnHe+o9FpoIQ==
X-CSE-MsgGUID: 6cpb9PIATLitp60sfz9UHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; d="scan'208";a="139556276"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 25 Feb 2025 00:06:41 -0800
Date: Tue, 25 Feb 2025 16:26:18 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 09/15] rust: irq: wrap IRQState with Opaque<>
Message-ID: <Z71+qiu+X4BKW2ja@intel.com>
References: <20250221170342.63591-1-pbonzini@redhat.com>
 <20250221170342.63591-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221170342.63591-10-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
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

> +/// An opaque wrapper around [`bindings::IRQState`].
> +#[repr(transparent)]
> +#[derive(Debug, qemu_api_macros::Wrapper)]
> +pub struct IRQState(Opaque<bindings::IRQState>);
> +
>  /// Interrupt sources are used by devices to pass changes to a value (typically
>  /// a boolean).  The interrupt sink is usually an interrupt controller or
>  /// GPIO controller.
> @@ -22,8 +28,7 @@
>  /// method sends a `true` value to the sink.  If the guest has to see a
>  /// different polarity, that change is performed by the board between the
>  /// device and the interrupt controller.
> -pub type IRQState = bindings::IRQState;
> -
> +///
>  /// Interrupts are implemented as a pointer to the interrupt "sink", which has
>  /// type [`IRQState`].  A device exposes its source as a QOM link property using
>  /// a function such as [`SysBusDeviceMethods::init_irq`], and
> @@ -41,7 +46,7 @@ pub struct InterruptSource<T = bool>
>  where
>      c_int: From<T>,
>  {
> -    cell: BqlCell<*mut IRQState>,
> +    cell: BqlCell<*mut bindings::IRQState>,

Once we've already wrapper IRQState in Opaque<>, should we still use
bindings::IRQState?

Although InterruptSource just stores a pointer. However, I think we can
use wrapped IRQState here instead of the native binding type, since this
item is also crossing the FFI boundary. What do you think?

>      _marker: PhantomData<T>,
>  }
>  

