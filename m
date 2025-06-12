Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4940DC61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:05:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjUL-00057c-Dp; Thu, 12 Jun 2025 11:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPjTz-0004rk-Hi; Thu, 12 Jun 2025 11:04:48 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uPjTw-0004WZ-36; Thu, 12 Jun 2025 11:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749740684; x=1781276684;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Uzd80MfbH0B2i2Iq6hvmbAhJ29lb/JWcWBgozs+nhaE=;
 b=SQhcszhhPjktvPaHlKtIEAj9VkewdY7w6wDlEZqyUoKM08XqnLzDI7/z
 Mk2rcECXEWZaRK5Fv7yL4WDwSygVTMinF/tvABcYThrxeLhaF77bFKhjw
 ZlzAlhdgEoDZI8YxcJuU6afQ+wuTI6sWby8i15pd/gAM6kp77xtyjKrbC
 ZetbO+kYh+7qY/JfrwQzma7Tj3X5f0TYDpp35cVVvGib8Vq/fB6bpW4y5
 qJF/OkDjhAr0sgczAQL7vF2Dlfm0IebUrhRdFwEld9ylL94o8oOgVpBnG
 uku/XhhdhY1OXTJ9bBtniV0y6/jutc5vxoHve85Sftjv4PZ/SB96EjXy8 Q==;
X-CSE-ConnectionGUID: qCLrURHlQ2aowcfCzL0IDg==
X-CSE-MsgGUID: xvTKvNqOQg+3yM0rC4IMtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="69494701"
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="69494701"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2025 08:04:39 -0700
X-CSE-ConnectionGUID: yEt4wnjnT/i/x9UGSYVhEQ==
X-CSE-MsgGUID: MFrBY5odQ/6J7hiO8cO/NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,231,1744095600"; d="scan'208";a="147537149"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 12 Jun 2025 08:04:38 -0700
Date: Thu, 12 Jun 2025 23:25:54 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 5/5] rust: qom: change instance_init to take a ParentInit<>
Message-ID: <aErxghTgZnH7Ae8s@intel.com>
References: <20250609154423.706056-1-pbonzini@redhat.com>
 <20250609154423.706056-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250609154423.706056-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Jun 09, 2025 at 05:44:23PM +0200, Paolo Bonzini wrote:
> Date: Mon,  9 Jun 2025 17:44:23 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/5] rust: qom: change instance_init to take a ParentInit<>
> X-Mailer: git-send-email 2.49.0
> 
> This removes undefined behavior associated to writing to uninitialized
> fields, and makes it possible to remove "unsafe" from the instance_init
> implementation.
> 
> However, the init function itself is still unsafe, because it must promise
> (as a sort as MaybeUninit::assume_init) that all fields have been
> initialized.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 34 ++++++++++-----------
>  rust/hw/timer/hpet/src/device.rs | 16 ++++------
>  rust/qemu-api/src/memory.rs      | 12 ++++----
>  rust/qemu-api/src/qdev.rs        | 51 ++++++++++++++++++++------------
>  rust/qemu-api/src/qom.rs         |  9 ++++--
>  5 files changed, 65 insertions(+), 57 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


