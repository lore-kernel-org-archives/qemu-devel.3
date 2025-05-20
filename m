Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44071C54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 01:56:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHCD8-0004at-0r; Mon, 19 May 2025 21:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHCD6-0004X7-1C
 for qemu-devel@nongnu.org; Mon, 19 May 2025 21:56:04 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uHCD4-0004y9-CO
 for qemu-devel@nongnu.org; Mon, 19 May 2025 21:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747706162; x=1779242162;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=FfR8hydQHQGwdWxVyH0Su2S/e2oBJ2K9fDx0WHO4UVk=;
 b=FlSIzqlLx5omYLWikffe6nAqwK3BIvDqgTssJ09duZbaBoyfAKXjIUfr
 EMNDSK71Cczr9EKTGfgyKlvxw3INSv6KiO4+34x+2hr0A27ymuNSrP75W
 AMF2pIUFPF68hoIqiGozxuI51PxiyrCjVJx/51e+MpRbnYk2CLqUxfZta
 cn5A8D+d0YxlH6d9FbPdJiG45hqX8BSZd9cpqeTk6VOqE5gRqQqeGYPpd
 UL8EGxz0k3oGUfBEnMR0WzMCF0i9oTGGuZLecNtOM47HvoLIsER0LkW7M
 N07C2sl7QHT1P1oc4jCBDzA1JYgHOIa4sWWhwjpKx36KTbyRm7FnTwjcL A==;
X-CSE-ConnectionGUID: IQAffjx5SvOCjLaAk2618w==
X-CSE-MsgGUID: YGnyoBmOSO+7aWMbLQM4/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="48737760"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="48737760"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2025 18:55:55 -0700
X-CSE-ConnectionGUID: UQacMpadQxSS0nGOW9ACxw==
X-CSE-MsgGUID: mHI0vsZgSzWtuFsddTIMFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; d="scan'208";a="144792342"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 19 May 2025 18:55:43 -0700
Date: Tue, 20 May 2025 10:16:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2 3/4] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
Message-ID: <aCvmEUQgV55eRm8n@intel.com>
References: <20250519145114.2786534-1-peter.maydell@linaro.org>
 <20250519145114.2786534-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519145114.2786534-4-peter.maydell@linaro.org>
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
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

On Mon, May 19, 2025 at 03:51:13PM +0100, Peter Maydell wrote:
> Date: Mon, 19 May 2025 15:51:13 +0100
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH v2 3/4] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
> X-Mailer: git-send-email 2.43.0
> 
> The x86 DE bit in the FPU and MXCSR status is supposed to be set
> when an input denormal is consumed. We didn't previously report
> this from softfloat, so the x86 code either simply didn't set
> the DE bit or else incorrectly wired it up to denormal_flushed,
> depending on which register you looked at.
> 
> Now we have input_denormal_used we can wire up these DE bits
> with the semantics they are supposed to have.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/tcg/fpu_helper.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


