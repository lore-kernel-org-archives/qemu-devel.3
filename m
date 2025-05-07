Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ABBCC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 12:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCeDP-0005ue-Ke; Wed, 07 May 2025 08:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCeDN-0005su-E4
 for qemu-devel@nongnu.org; Wed, 07 May 2025 08:49:33 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uCeDL-0005rz-Hi
 for qemu-devel@nongnu.org; Wed, 07 May 2025 08:49:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746622171; x=1778158171;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=6lMxAS1FtPrEYPx+4kmzts3bA76jEOE2+dKA/bl3HGA=;
 b=S5pzXjTeix8k/wYiPgqu9gwbWo0pEdCYjQ5eQk5IqTScUqdb6oTjOzrU
 s5S7JtxlUiMQ4r4gc26qhjESeDmBB0QB9Nxj/lN3i54jqYt7AKODkUdi0
 GpkFeZvvHvtJCQzIv8MIV1iv6+72AJK9Cpry6QIOJHr7CT9Xq4mM5vy0x
 +Q4tuAKRINyh4bm3Dv53l+sTlflT0kmhQwZfqwVbui3QIbxf3fsL8tysl
 K689TgfzNLapU1U+ipRUZJPPS5Ef5WL++rNV0uWoOb1fFnYgCDotEgzBJ
 D47x6l5T1QOFYzJNtaLTp40zFzcUaUBkvRxKphJ+nqNDu6aOzDF2zZxtG Q==;
X-CSE-ConnectionGUID: /3uGIFZhTrWBFBO8Om/YKw==
X-CSE-MsgGUID: olbW9MZqTmyI7MHlaGdqKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="65880108"
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="65880108"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2025 05:49:28 -0700
X-CSE-ConnectionGUID: /Zbw7ssUT16exN9Z9GzdIg==
X-CSE-MsgGUID: bK6561E/SoejiiuXyF+4dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,269,1739865600"; d="scan'208";a="135665265"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 07 May 2025 05:49:27 -0700
Date: Wed, 7 May 2025 21:10:28 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH 1/4] target/i386: Detect flush-to-zero after rounding
Message-ID: <aBtbxJq8KFpn7KiK@intel.com>
References: <20250213142613.151308-1-peter.maydell@linaro.org>
 <20250213142613.151308-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213142613.151308-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
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

On Thu, Feb 13, 2025 at 02:26:10PM +0000, Peter Maydell wrote:
> Date: Thu, 13 Feb 2025 14:26:10 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 1/4] target/i386: Detect flush-to-zero after rounding
> X-Mailer: git-send-email 2.43.0
> 
> The Intel SDM section 10.2.3.3 on the MXCSR.FTZ bit says that we
> flush outputs to zero when we detect underflow, which is after
> rounding.  Set the detect_ftz flag accordingly.
> 
> This allows us to enable the test in fma.c which checks this
> behaviour.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/tcg/fpu_helper.c | 8 ++++----
>  tests/tcg/x86_64/fma.c       | 5 -----
>  2 files changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


