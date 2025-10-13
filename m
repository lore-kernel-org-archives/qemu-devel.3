Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C093CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:36:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8E2K-0000kN-6L; Mon, 13 Oct 2025 04:36:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8E2D-0000jd-FD
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:36:01 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8E27-0007Di-HI
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760344555; x=1791880555;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VPJCR2SNcS1s/rG2zxm8HfcdnJ2zHj6J89PZlwHomWs=;
 b=eM+49oXEoAO6u8iFqLuMhNAPJYhDIlGHEI0w1XiiPvr80E2kOAlKM6OV
 VDBSP21zaILRP3eyCuuPmjJ/+wl5AVJtb7aeeEE9IaFXIOaKe3pygwQBh
 h/VpxKmVNgsr23IsamBnJgtnnjFgRZmq0UzxKmq8afSUoTsBf66lzWrn/
 y0xYtRw4gGjqUpJ/+XDjDBV22hQrHWduTfV+ux4q3lE1GZ7PGn2nMSQON
 BPVIqfXE3rzpbVimfddshIH08X7U5Q7BtjOTj9fvBmoApNsVw2RMiMlD3
 4SN7fM8/RkmujnwUAWSts6V4yVZtYJFFndZcjUllwjw4MBCHKPXfKqyEC Q==;
X-CSE-ConnectionGUID: rbihZK8UT4Ok+TdsiPNoGw==
X-CSE-MsgGUID: V4cHWy8USCOJaXYt3yAzPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="66332025"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="66332025"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 01:35:52 -0700
X-CSE-ConnectionGUID: miwko5QyQDSvESibltEn0A==
X-CSE-MsgGUID: yiraLPU/RNe7lYwcrcb/bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="212172029"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa002.jf.intel.com with ESMTP; 13 Oct 2025 01:35:52 -0700
Date: Mon, 13 Oct 2025 16:57:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 06/11] rust: move VMState from bql to migration
Message-ID: <aOy/FFpD5nOe8w45@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.12; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 09:52:05AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:05 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 06/11] rust: move VMState from bql to migration
> X-Mailer: git-send-email 2.51.0
> 
> The high-level wrapper Migratable<T> will contain a BqlCell,
> which would introduce a circular dependency betwen the bql and
> migration crates.  Move the implementation of VMState for cells
> to "migration", together with the implementation for std types.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/Cargo.lock               | 4 +---
>  rust/bql/Cargo.toml           | 3 ---
>  rust/bql/meson.build          | 1 -
>  rust/bql/src/cell.rs          | 6 ------
>  rust/meson.build              | 2 +-
>  rust/migration/Cargo.toml     | 1 +
>  rust/migration/meson.build    | 4 ++--
>  rust/migration/src/vmstate.rs | 2 ++
>  8 files changed, 7 insertions(+), 16 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


