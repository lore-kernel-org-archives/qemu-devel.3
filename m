Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABF0CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIuO-0004kT-Gj; Tue, 04 Nov 2025 10:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIuN-0004kH-D0; Tue, 04 Nov 2025 10:25:19 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vGIuL-0006Bm-U3; Tue, 04 Nov 2025 10:25:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762269918; x=1793805918;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=qUUC5QUd+RXOioX6icW/Nm4Uoqzz0t3Mh29VeMqiGNA=;
 b=Ve7yNg40f13u3uRSTryViaVOo2/KJ2fWosMEhqeTaLTT9AEE75uijM2W
 6uIvsEBaZLJGS1t0NitRsg6ZdSqSGVNpK5cVMVRQ7ovMLaori+pgX6RTb
 lEsAGHMHF2RIep5DWfin50wOu6yZC4Ty3MvKuNoV7y4f77S65HNj1LSgt
 3TfaHkdPseAjnvoRHFomjMNpB+ESO13xEETjs5ON4hfMvmmctSCUgIzsB
 R4+iTQi4vVemQomWZzHr1+mPdOnINKBXHf/zrwyipWuSnBNOeODHgc5EQ
 dUKAGFUXzEfXvkZSvUsIVMjGQP+CijOXrkQFdsqz4OZczc5T6MXppxfkO A==;
X-CSE-ConnectionGUID: CoHvEu28QJ+Km2mnlEeoiA==
X-CSE-MsgGUID: fPKE4leHSLOXjmVAZPr4Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="64517041"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="64517041"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 07:25:15 -0800
X-CSE-ConnectionGUID: uLFUgQsYSdaD3QplbeBNEw==
X-CSE-MsgGUID: u/M/x0X0SH6dybvgi/DJkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; d="scan'208";a="187630256"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 04 Nov 2025 07:25:14 -0800
Date: Tue, 4 Nov 2025 23:47:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/4] rust: pull error_fatal out of
 SysbusDeviceMethods::sysbus_realize
Message-ID: <aQogELmilW9KZlSH@intel.com>
References: <20251031152540.293293-1-pbonzini@redhat.com>
 <20251031152540.293293-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031152540.293293-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
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

On Fri, Oct 31, 2025 at 04:25:39PM +0100, Paolo Bonzini wrote:
> Date: Fri, 31 Oct 2025 16:25:39 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/4] rust: pull error_fatal out of
>  SysbusDeviceMethods::sysbus_realize
> X-Mailer: git-send-email 2.51.1
> 
> Return a Result<()> from the method, and "unwrap" it into error_fatal
> in the caller.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs |  4 ++--
>  rust/hw/core/src/sysbus.rs       | 13 ++++++-------
>  rust/util/src/error.rs           | 31 ++++++++++++++++++++++++++++++-
>  rust/util/src/lib.rs             |  2 +-
>  4 files changed, 39 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


