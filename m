Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD831D148A3
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 06:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdjlf-0005IH-Su; Thu, 08 Jan 2026 01:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdjld-0005HD-HR; Thu, 08 Jan 2026 01:45:09 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vdjla-0003RQ-OC; Thu, 08 Jan 2026 01:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1767854707; x=1799390707;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZdjK3CN3w2PQzyiNpSWvDzi9Dfm/4LQykNr7WIiHgKw=;
 b=YtS+R3vcRTtg8Ntrr2pH4b57ydNEwZIH56/847u2da2EagWBgbIGsuH/
 IK3CsQDaWvhEWGTWEHPoPSCkQxqrAW822MZUNln75xKPf4/toYZc3k2hM
 9K0rbDT8hv/a+l2Bsq4BeStqmw8dYd4I7VJQ26adGFoWP11l9pH+VJ1Qd
 qIw5GMkgP/p5Dwxi1A4YAQTMuE/flPjcLZw50s0nkq2NuCAR+8oJBBpfQ
 ux4cAApRjCOUyK2l15Rx2nkWh0nPtusNs1M1WUt9NKETOaq4J20fFVvBx
 Pf2KRQ8Mc/r/Vyd+efgVaIIOH6ttlesJXpDd2XhK0vLMiKGKSWaav8uBe Q==;
X-CSE-ConnectionGUID: LUVShMRFS/GqcPmuteH9CQ==
X-CSE-MsgGUID: E/+vyHjBSVSzqoaC17HinQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69388293"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="69388293"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jan 2026 22:45:01 -0800
X-CSE-ConnectionGUID: 1u9ug1S3Rl6Y8I31eJbghg==
X-CSE-MsgGUID: Q6s4aJWSTumCIgTiOhXtEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; d="scan'208";a="203145748"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 07 Jan 2026 22:44:58 -0800
Date: Thu, 8 Jan 2026 15:10:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 1/5] target/i386: Restrict WatchPoint API to TCG
Message-ID: <aV9YYE3Yind7Y/Nc@intel.com>
References: <20260106231908.16756-1-philmd@linaro.org>
 <20260106231908.16756-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260106231908.16756-2-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jan 07, 2026 at 12:19:03AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed,  7 Jan 2026 00:19:03 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 1/5] target/i386: Restrict WatchPoint API to TCG
> X-Mailer: git-send-email 2.52.0
> 
> Watchpoints are specific to the TCG accelerator. Restrict
> the cpu_watchpoint_remove_all() call.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


