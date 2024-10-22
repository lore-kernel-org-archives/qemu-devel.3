Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22C1D2C56A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 15:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3GfV-0005Q7-ER; Tue, 22 Oct 2024 11:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3GfR-0005Pj-2i
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:19:29 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t3GfO-0004Zo-Ah
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 11:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729610366; x=1761146366;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=hby/lNQb7kcz3aErF/baCHtbEoNxlIQvuJ1v3SMGwU0=;
 b=Pr+yJPqpl2dIsoUr0BGub61Z5tnH4PvNJC2pQ37bavvOJTOQAa71EC/j
 h5yuirWWdrXqh1+vNsOvZouXhAzm3SVMt0OoUBO1dOLWNUndHTtWYArjI
 TQzVpr9ERfJMiFM0Urk+wEA4k/pXfvGhgewRcmaLKt9B/c8M/kpm71d+T
 uwG4kQFPYPM8NLNm+DVCH21pOBNP9Xr/QC8a8KRG7MQiKxS6WNWUG7uuD
 XCdknxS5MZ8GL1NErCREupZWy+E7jVb05LN8M9Qo0PWa00hTax+0nWn2u
 oROOzyXPqMgu0HRlVG+CD2ya5zMgVRmtfdZCxFUtAZ0ggQCK5Xw1oSK3M g==;
X-CSE-ConnectionGUID: G9oC2kOuRuKpyZagfJ6e3A==
X-CSE-MsgGUID: pD9C8WI7Q0ai9RnqlAqjoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="40528818"
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="40528818"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2024 08:19:21 -0700
X-CSE-ConnectionGUID: zkVdP6n8Q7ef+T8tDYcMng==
X-CSE-MsgGUID: v/shGKtRTy6XjTBBVqMqQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; d="scan'208";a="80078966"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 22 Oct 2024 08:19:20 -0700
Date: Tue, 22 Oct 2024 23:35:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH v2 03/13] meson: pass rustc_args when building all crates
Message-ID: <ZxfGSO1AklSDwvQC@intel.com>
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021163538.136941-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
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

On Mon, Oct 21, 2024 at 06:35:28PM +0200, Paolo Bonzini wrote:
> Date: Mon, 21 Oct 2024 18:35:28 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH v2 03/13] meson: pass rustc_args when building all crates
> X-Mailer: git-send-email 2.46.2
> 
> rustc_args is needed to smooth the difference in warnings between the various
> versions of rustc.  Always include those arguments.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                       | 20 +++++++++++++-------
>  rust/qemu-api/meson.build         |  2 +-
>  rust/qemu-api/src/device_class.rs | 10 ++++++----
>  3 files changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
 

