Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F0BC8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFCk-0000Ar-D4; Tue, 08 Jul 2025 16:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDmO-0003hq-RT; Tue, 08 Jul 2025 15:15:07 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZDmG-0006fB-R2; Tue, 08 Jul 2025 15:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752002093; x=1783538093;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eqW/GZxVmXxa6Rs8JzPHetgNBfIq7ooBhf8uaasmLf0=;
 b=R44LPOUR1PdI2qjzFnnM/3TXTPt0pgI5Vais0OyCRA1N6wo8t2ENZvsW
 5j9zuulO+Em63EnW4aO9xy6tJ/SjrYhQbdEXAS4gFkUo7oP2TD03CcC9F
 hlqQ/WTin8g+TEneNEOtg4hlzA3wkK+zePYjmpaeT0CF+amyvHKep/Z4T
 JZtt6NUaIz+gE7+hxAMtwa/xWTvYtZorQVeStO84YgapTfbSNs3gDhkka
 0potVJFztFvWzgTdut4xHDpyyUnBJMC3zn5uQtHTjnb7Hgnbg/Eydwjcz
 v+s/Zign5rmtpEPdrBKDRqOQcGS6TyAqIKspguoMnUX9+j++vd/kuqE9G g==;
X-CSE-ConnectionGUID: qqq2wr9JS7WMt4hvJIfwpg==
X-CSE-MsgGUID: J4APQoszTVW8GA5GW8KTCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="76739652"
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="76739652"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jul 2025 00:58:29 -0700
X-CSE-ConnectionGUID: y/tLSVigRZSgnvc/1wdxyA==
X-CSE-MsgGUID: hAUsDz+zQJyt1tCW+CnNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,296,1744095600"; d="scan'208";a="154842527"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 08 Jul 2025 00:58:27 -0700
Date: Tue, 8 Jul 2025 16:19:55 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] rust/memory: replace size arg with Bits enum
Message-ID: <aGzUq5vZFZvk4uxh@intel.com>
References: <20250703-rust-mem-api-v1-0-cd5314bdf580@linaro.org>
 <20250703-rust-mem-api-v1-1-cd5314bdf580@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703-rust-mem-api-v1-1-cd5314bdf580@linaro.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 04:58:11PM +0300, Manos Pitsidianakis wrote:
> Date: Thu, 03 Jul 2025 16:58:11 +0300
> From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Subject: [PATCH 1/3] rust/memory: replace size arg with Bits enum
> X-Mailer: b4 0.14.2
> 
> We have the ability to make memory accesses use a typesafe access width
> type in Rust, which the C API currently lacks as it does not use a
> newtype wrapper for specifying the amount of bytes a memory access has;
> it uses a plain 32-bit integer value instead.
> 
> Replace use of u32 size arguments with a Bits enum that has only the
> allowed byte sizes as variants and has a u32 representation so that it
> can be fed back into C as well.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  rust/hw/char/pl011/src/device.rs |  8 ++++----
>  rust/hw/timer/hpet/src/device.rs | 14 +++++++-------
>  rust/qemu-api/src/memory.rs      | 34 ++++++++++++++++++++++++----------
>  3 files changed, 35 insertions(+), 21 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


