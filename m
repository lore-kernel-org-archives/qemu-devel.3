Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC72CCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 08:35:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8E0M-00085N-Mz; Mon, 13 Oct 2025 04:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8E0K-00085C-U2
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:34:04 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v8E0F-0006qW-Rh
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760344440; x=1791880440;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fsXktAnRlF3w3O8/d13m0BFsy323A2gm5BuG5w6gWck=;
 b=esGWjcoQ9nVh3/ELsU5s/TgSXMWhG8YAJauOknu9dRUoNDz965Iampa1
 Cx847upbuEgRVn4AVZvvj2Xt6EwuseT2cSuMdOKodbmVbIUs9UdEpfMXG
 co0lzpQvbbha2dbXtWvktQE9LRNThbw0oJO3gPtP/iNyn4cso5YZ6KHay
 Z3E0SLgNTDM7ojf3TnU2J/KxBzAvSoM6mFLSs9J9qJRo+Tzr5wxrBVaX+
 Dx4tjKdq1zeR+RQMQQWJGCeXUaok2GLjLNT/5IWmMkzwR0Jm0Qn3YiYbE
 0D/223BAYdObH1RndJ+F4UWr7LPnOrRlsS5M5m3os4iianuLFhmrh8EZj w==;
X-CSE-ConnectionGUID: thrKhY5HTiqrERRKuHZdIA==
X-CSE-MsgGUID: nA3uvHOVRTuSalXdRFesuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11580"; a="73824866"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="73824866"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2025 01:33:53 -0700
X-CSE-ConnectionGUID: NZpaCQ+JTr+KWn3qRD/0aQ==
X-CSE-MsgGUID: rwuMl/8UTcagBmcphaaiEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; d="scan'208";a="218654165"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 13 Oct 2025 01:33:53 -0700
Date: Mon, 13 Oct 2025 16:55:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 05/11] rust: migration: extract vmstate_fields_ref
Message-ID: <aOy+ne+eYMI8J8h2@intel.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
 <20251001075210.1042479-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001075210.1042479-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, Oct 01, 2025 at 09:52:04AM +0200, Paolo Bonzini wrote:
> Date: Wed,  1 Oct 2025 09:52:04 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/11] rust: migration: extract vmstate_fields_ref
> X-Mailer: git-send-email 2.51.0
> 
> This is useful when building a VMState for generic structs, because you have
> to avoid nested statics.  Using vmstate_fields! will fail in the likely case
> where the _FIELDS static uses Self from an outer item, because that is
> forbidden.
> 
> The separate macros are needed because you cannot just do
> 
>                  .fields(vmstate_fields_ref! {
>                       vmstate_of!(PL011State, clock),
>                  })
> 
> The value returned by vmstate_fields_ref! is not promoted to static, which is
> unfortunate but intentional (https://github.com/rust-lang/rust/issues/60502):
> 
> error[E0716]: temporary value dropped while borrowed
>    --> rust/hw/char/pl011/libpl011.rlib.p/structured/device.rs:743:17
>     |
> 738 | /      VMStateDescriptionBuilder::<PL011State>::new()
> 739 | |          .name(c"pl011/clock")
> 740 | |          .version_id(1)
> 741 | |          .minimum_version_id(1)
> 742 | |          .needed(&PL011State::clock_needed)
> 743 | |          .fields(vmstate_fields_ref! {
>     | | _________________^
> 744 | ||              vmstate_of!(PL011State, clock),
> 745 | ||         })
>     | ||_________^- argument requires that borrow lasts for `'static`
>     |  |_________|
>     |            creates a temporary value which is freed while still in use
> 746 |            .build();
>     |                   - temporary value is freed at the end of this statement
> 
> Thus it is necessary to use the "static", whether explicitly or hidden by
> vmstate_fields.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


