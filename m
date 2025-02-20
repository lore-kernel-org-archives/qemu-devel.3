Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3F3C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 06:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkzrc-0007na-V4; Thu, 20 Feb 2025 01:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkzrN-0007mE-II; Thu, 20 Feb 2025 01:16:38 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tkzrK-0004Pf-Er; Thu, 20 Feb 2025 01:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740032191; x=1771568191;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=WPIjTIzp6eqPd1mbM8xr75W+IZbSlGN/E4pgdFz8akQ=;
 b=nhCBmfPi3hVtKETtvNJji3JUYcIIMOJAaDd4+ZCXlXKwQRpIS/1bhv43
 ttrZ655QLAufQ+G45Cldm+tKmubMaehsSVg25djoFdkYw8pWd66lD+bST
 PtXjAPt7T6+em+wXp1h2xx1Ws240FQT6xe5iUzqYEiz3huxmKh06E+/Sl
 LMPqvhBr8YbIGZhtqPuZWstb37ysB54Ic7aS5b3dC58Tq592pMimS9lV0
 mBRfdccIzrufH8q8CECHw9wUiGQQIhqzW6nPQEzvys7I2Vkjz9mXkEHVO
 DtHvlj4OYQ0RdW8ofWtAVLvvwqsckmVI+XpMcpqWnHM+B4P4Ai1mSLo49 Q==;
X-CSE-ConnectionGUID: pu7IkRrTQeOyzEjMvSoV7A==
X-CSE-MsgGUID: x/wirv56QKmz/0mqzj/1mw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40664002"
X-IronPort-AV: E=Sophos;i="6.13,300,1732608000"; d="scan'208";a="40664002"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2025 22:16:24 -0800
X-CSE-ConnectionGUID: uaybu7o6ScClSLdpLuCz/Q==
X-CSE-MsgGUID: MvC9TgjVQxOz+9HY9JdEEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="145833968"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 19 Feb 2025 22:16:21 -0800
Date: Thu, 20 Feb 2025 14:35:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH v2 04/11] rust/qemu-api: Add wrappers to run futures in
 QEMU
Message-ID: <Z7bNTILVp0KFJw57@intel.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
 <20250218182019.111467-5-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218182019.111467-5-kwolf@redhat.com>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
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

> +/// Use QEMU's event loops to run a Rust [`Future`] to completion and return its result.
> +///
> +/// This function must be called in coroutine context. If the future isn't ready yet, it yields.
> +pub fn qemu_co_run_future<F: Future>(future: F) -> F::Output {
> +    let waker = Waker::from(Arc::new(RunFutureWaker {
> +        co: unsafe { bindings::qemu_coroutine_self() },
> +    }));
> +    let mut cx = Context::from_waker(&waker);
> +
> +    let mut pinned_future = std::pin::pin!(future);

pin macro stabilized in v1.68.0, but currently the minimum rustc
supported by QEMU is v1.63.

I found there's a workaround [*], so we can add a temporary pin.rs in
qemu_api until QEMU bumps up rustc to >= v1.68?

[*]: https://github.com/rust-lang/rust/issues/93178#issuecomment-1386177439

> +    loop {
> +        match pinned_future.as_mut().poll(&mut cx) {
> +            Poll::Ready(res) => return res,
> +            Poll::Pending => unsafe {
> +                bindings::qemu_coroutine_yield();
> +            },
> +        }
> +    }
> +}
> +

