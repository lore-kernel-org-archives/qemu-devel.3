Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D655C54FB3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 May 2025 08:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKZ1y-0002wg-6F; Thu, 29 May 2025 04:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKZ1r-0002wE-Bg; Thu, 29 May 2025 04:54:23 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uKZ1p-0006pX-NF; Thu, 29 May 2025 04:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748508861; x=1780044861;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=8pK53x7vB0ZTDIpz/l7dcqHC0ZTqcS4Iw1MPLeIuGrY=;
 b=RQOpuBXzU+G1dpotJKuKqTV6wx4SQlPgYkFmUYgYeQGb7d7R+82WnX7A
 x4QHMEXbbMANO91YNY587xcdofbzvcW+yxkHZllkulwHA9lohvbEYDHvi
 +DHjTKsfaFEKztrbIyvuZ4vhpuIb949bYKcSDOMjOpcxntVH8TtohpSmP
 fQECpbDkysjew/9Ys7R/WMwJ/GYw3fZ5FinsotgFFy72bMlBhAn98QJhL
 xfXtYIAzu4yCKQ4ZHD24XQo4PqRMLfixmsXoUj1cEQohxb9EK+MYfy4Of
 5y16CFs898ns6d+WJ+TsiuifnKLWLsRz6ht7lSTFc3dPNtgcMl1MZ7hcI Q==;
X-CSE-ConnectionGUID: WPQ+feQKRCSAZCrth0Rxcg==
X-CSE-MsgGUID: R7Bn2sFjSfKlKQSKthdOQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11447"; a="50436881"
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="50436881"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2025 01:54:17 -0700
X-CSE-ConnectionGUID: virlQbg2Rli/zvWLvG95/Q==
X-CSE-MsgGUID: CxQ6qyfrSF+AYwpRuzjatg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,323,1739865600"; d="scan'208";a="144139312"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 29 May 2025 01:54:17 -0700
Date: Thu, 29 May 2025 17:15:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 11/12] rust/hpet: return errors from realize if
 properties are incorrect
Message-ID: <aDglrxH6o6spPC2v@intel.com>
References: <20250526142254.1061009-1-pbonzini@redhat.com>
 <20250526142455.1061519-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526142455.1061519-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -72
X-Spam_score: -7.3
X-Spam_bar: -------
X-Spam_report: (-7.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

On Mon, May 26, 2025 at 04:24:54PM +0200, Paolo Bonzini wrote:
> Date: Mon, 26 May 2025 16:24:54 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/12] rust/hpet: return errors from realize if properties
>  are incorrect
> X-Mailer: git-send-email 2.49.0
> 
> Match the code in hpet.c; this also allows removing the
> BqlCell from the num_timers field.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/fw_cfg.rs |  7 +++----
>  rust/hw/timer/hpet/src/hpet.rs   | 16 +++++++---------
>  2 files changed, 10 insertions(+), 13 deletions(-)

Patch is fine for me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


>          if self.int_route_cap == 0 {
> -            // TODO: Add error binding: warn_report()
> -            println!("Hpet's hpet-intcap property not initialized");
> +            Err("hpet.hpet-intcap property not initialized")?;
>          }

Though here we don't need print warning...do we still need to provide
the warn_report() binding? Or println!() is enough in Rust side?

Thanks,
Zhao


