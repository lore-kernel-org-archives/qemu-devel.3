Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DB4C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 07:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCCag-0006NM-6h; Tue, 06 May 2025 03:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCac-0006N4-He; Tue, 06 May 2025 03:19:42 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCCaa-0004Jc-6s; Tue, 06 May 2025 03:19:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746515981; x=1778051981;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=YlGksIAV9kKGZINExs8vmvh79/UBRQ6iPfg+JT1sOV0=;
 b=L8dL6404xKNWZL0wMnLnDB96EB665q3pfi8yiSESOXKgkQtxTXxp9tW2
 DT/mGwLLCCph6C+SgkH3GTJhQHbFEAvCEp2BYrQbxY9jReEbh4lT/q6Is
 TTZCvnA33LioAfD/TVY4cQY8PqSKBDehsFeDCqoveJTfvFNt+MBtx9M6a
 HVmlgVkbXuewzMSPy1smwmZIgHeGSulwr8/+YGKtdjc+DyduAQLsyEq8s
 /iVp6uaKL2HpTgbh9ef5HrtG7/T2k0P+7qJ0LSMioar+wG4S6oNyAsEwP
 zSTCPSmXLZkPEsueg5CsGtDy3uym1pjScI3cwXRH8Eg8DaczdVTvyBvuY Q==;
X-CSE-ConnectionGUID: +tdosc0lSHuCim6xSLOsdg==
X-CSE-MsgGUID: TLTiCt0/SU+5QNZE5CPEuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="65698434"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="65698434"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2025 00:19:38 -0700
X-CSE-ConnectionGUID: ZopmxHrAScKMLduvFQvPgA==
X-CSE-MsgGUID: UoUYZHDfRNevwCyGnek6lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; d="scan'208";a="135497260"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa006.fm.intel.com with ESMTP; 06 May 2025 00:19:36 -0700
Date: Tue, 6 May 2025 15:40:37 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/11] rust: use std::ffi instead of std::os::raw
Message-ID: <aBm89RakvG9rYNHG@intel.com>
References: <20250505090438.24992-1-pbonzini@redhat.com>
 <20250505090438.24992-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505090438.24992-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Mon, May 05, 2025 at 11:04:28AM +0200, Paolo Bonzini wrote:
> Date: Mon,  5 May 2025 11:04:28 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/11] rust: use std::ffi instead of std::os::raw
> X-Mailer: git-send-email 2.49.0
> 
> This is allowed since Rust 1.64.0.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/devel/rust.rst                    | 2 --
>  rust/hw/char/pl011/src/device_class.rs | 2 +-
>  rust/hw/timer/hpet/src/hpet.rs         | 3 +--
>  rust/qemu-api/src/chardev.rs           | 3 +--
>  rust/qemu-api/src/irq.rs               | 6 +++++-
>  rust/qemu-api/src/lib.rs               | 2 +-
>  rust/qemu-api/src/memory.rs            | 3 +--
>  rust/qemu-api/src/qdev.rs              | 3 +--
>  rust/qemu-api/src/qom.rs               | 3 +--
>  rust/qemu-api/src/timer.rs             | 2 +-
>  rust/qemu-api/src/vmstate.rs           | 2 +-
>  rust/qemu-api/tests/vmstate_tests.rs   | 7 ++++++-
>  12 files changed, 20 insertions(+), 18 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


