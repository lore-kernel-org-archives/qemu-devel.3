Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 573FACA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usND1-0000Rh-AE; Sat, 30 Aug 2025 11:09:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uruqK-0001z4-Ua; Fri, 29 Aug 2025 04:52:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uruqI-0002Ph-3y; Fri, 29 Aug 2025 04:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756457538; x=1787993538;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=l7b+q34d0sKKs/7TOEfdd7HLVy9j9TxG1Cvc6YBvK6s=;
 b=i1msZhYgelfDP/Yd6TgfXJ4Bl3Z2v0ZsHgxV4oYYEm2IKuCgTeDlKCMd
 3LoJIXPLp0XHzfpodImsN7RLEx7GRz3vjvnm1FVQioc3F1z+Pjmp7A0gD
 dlQfIo81p76qN8Tnb3JUNqfLqtfHq+iOmICCRYBkXzRwVKIhR8+g/XO4S
 TVGFuJrp5+cL3jmRg5A7OHnW9X/r1Y6v1xJmpsyVaLOjLIMLV1dIgPM34
 BIZqzS8BnyTNzy1ygKvvUs18FCwJ1lH2D44SjylSPH7S/w4O5HrepOLlF
 fAVpGSkeAJYacwk7D55CoKm5fqyAAJPRp0CqWgNa1SAPqGv3w63Rh9D+g w==;
X-CSE-ConnectionGUID: wGPKlSqhTVWF/g2iDsDiaQ==
X-CSE-MsgGUID: 4u23em37Sx6zLKrnjG/iSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="57764792"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="57764792"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 01:52:12 -0700
X-CSE-ConnectionGUID: 4cFlMhq5RCOU+hjbs3v/bw==
X-CSE-MsgGUID: gcogKTgYT26UtqDIAamb0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="174504351"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 29 Aug 2025 01:52:11 -0700
Date: Fri, 29 Aug 2025 17:13:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pbonzini@redhat.com, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH 11/22] rust: split "bql" crate
Message-ID: <aLFvVW1FsH/j3SMS@intel.com>
References: <20250827104147.717203-1-marcandre.lureau@redhat.com>
 <20250827104147.717203-12-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250827104147.717203-12-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
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

On Wed, Aug 27, 2025 at 02:41:33PM +0400, marcandre.lureau@redhat.com wrote:
> Date: Wed, 27 Aug 2025 14:41:33 +0400
> From: marcandre.lureau@redhat.com
> Subject: [PATCH 11/22] rust: split "bql" crate
> 
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Unfortunately, an example had to be compile-time disabled, since it
> relies on higher level crates (qdev, irq etc). The alternative is
> probably to move that code to an example in qemu-api or elsewere and
> make a link to it, or include_str.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---

[snip]

> index 0000000000..ef08221e9c
> --- /dev/null
> +++ b/rust/bql/src/lib.rs
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +mod bindings;
> +use bindings::{bql_block_unlock, bql_locked, rust_bql_mock_lock};
> +
> +mod cell;
> +pub use cell::*;
> +
> +/// An internal function that is used by doctests.
> +pub fn start_test() {
> +    // SAFETY: integration tests are run with --test-threads=1, while
> +    // unit tests and doctests are not multithreaded and do not have
> +    // any BQL-protected data.  Just set bql_locked to true.
> +    unsafe {
> +        rust_bql_mock_lock();
> +    }
> +}
> +
> +pub fn is_locked() -> bool {

I prefer the original names: bql_locked()...

> +    // SAFETY: the function does nothing but return a thread-local bool
> +    unsafe { bql_locked() }
> +}
> +
> +pub fn block_unlock(increase: bool) {

... and bql_block_unlock.

> +    // SAFETY: this only adjusts a counter
> +    unsafe {
> +        bql_block_unlock(increase);
> +    }
> +}

The consistent naming can help C developers become familiar with the
same interfaces in Rust.

And we will have more and more lock bindings - add lock name in the
method name could help avoid confusion.

Others LGTM, so

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


