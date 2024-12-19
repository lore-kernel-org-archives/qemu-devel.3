Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CB1E7718B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 07:12:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOAhf-0000KP-L0; Thu, 19 Dec 2024 02:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOAhd-0000JK-B5; Thu, 19 Dec 2024 02:12:09 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOAhb-0000B0-It; Thu, 19 Dec 2024 02:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734592328; x=1766128328;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=LUjbjnsIOgbLecN2TJ0VlLoVBCyQnwbHtcx8B3DCHF0=;
 b=n69ozAMK2Tc4xFKc1oOWGszIxAR+CnCcZabCaouZb12jIOXcpyW/ozgW
 ILWLVopGTcwhIAR62rnOGb8IVvQmu66+UrJA+D2YE1R7Hjw5SqgCOgvHA
 wyNWr6Kin86y3CW/hwJajDDjeroNf0zD7aq03+IpEw0uvs57wYQWkLVfa
 HoxzW8IuNidWuFHg7X4zfLllMTGwsOiL+ZcUMM83x0uLORNWfTx4X08mH
 1aPo9SieiQUjk5ANitOn0oSmDBneDHp11/FRicB0hGi31tml/fil6GG5H
 uVJXJyiaBW1I7gepV5eXw/PgZnyQAV8NxIjZdDDIA+7aGzLbDpW1JaLB/ Q==;
X-CSE-ConnectionGUID: g4FKpxGZRHWf1rTP+uT0Ew==
X-CSE-MsgGUID: LW1Xm7LqRBKhc/UKJRRpag==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35247497"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="35247497"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 23:12:05 -0800
X-CSE-ConnectionGUID: OsH/+ug4R36jLBaXQcqErw==
X-CSE-MsgGUID: NeY/xevERVKOpb75IBkcUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="98641538"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 18 Dec 2024 23:12:03 -0800
Date: Thu, 19 Dec 2024 15:30:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 5/7] rust: pl011: extend registers to 32 bits
Message-ID: <Z2PLo99JnPfNH/t0@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 12, 2024 at 06:22:02PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:22:02 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 5/7] rust: pl011: extend registers to 32 bits
> X-Mailer: git-send-email 2.47.1
> 
> The PL011 Technical Reference Manual lists the "real" size of the
> registers in table 3-1, and only rounds up to the next byte when
> describing the registers; for example, UARTDR is listed as having
> width 12/8 (12 bits read, 8 written) and only bits 15:0 are listed
> in "Table 3-2 UARTDR Register".
> 
> However, in practice these are 32-bit registers, accessible only
> through 32-bit MMIO accesses; preserving the fiction that they're
> smaller introduces multiple casts (to go from the bilge bitfield
> type to e.g u16 to u64) and more importantly it breaks the
> migration stream (though only on big-endian machines) because
> the Rust vmstate macros are not yet type safe.
> 
> So, just make everything 32-bits wide.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 36 ++++++++++++++------------------
>  rust/hw/char/pl011/src/lib.rs    | 23 +++++++++-----------
>  2 files changed, 26 insertions(+), 33 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


