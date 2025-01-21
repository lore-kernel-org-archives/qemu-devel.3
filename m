Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA850C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 12:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taDB0-0005Fk-2Y; Tue, 21 Jan 2025 07:16:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDAy-0005Fc-QO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:16:12 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taDAs-0008Je-NS
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 07:16:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737461767; x=1768997767;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=8T0ApBoSpf7fgy9dbX/ULBhXvOu1k5vONfu4kFvxwO8=;
 b=C+h6eXVSBym89XOGIPD5/OkFq1f4b5mYwzyFGRX2l69bYchzFwMqzy8M
 ta+SApr0njX2dJyd/Xy76wshfucvqBrt75BNcYp8s7AIZzF7V81j1MuUL
 S36ET57kB1RY0HJknL8bKovnNFTHPfodHkMmj++7CVgI/hbnpaMFLLaJW
 p3i2j0UsasqW/loxHtHb3Wy36JVWV3E0anS8L1CTQVc0YYMP2CsoQjCUr
 WLJ8gw8YtHVfqyv7n5bGG+rKzmQGlBVRSx1UytvY0FbONtruJCHKOSM0k
 /CHuBLBLrJ075yhpnu2f39wdEwZTIIXGJMpGEJKz/7qjDC5z3CHQ5zML4 Q==;
X-CSE-ConnectionGUID: zGOBGolER7mfueLQMDUjtA==
X-CSE-MsgGUID: YqXPunm+S460sbmVM5fbiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11321"; a="41546559"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; d="scan'208";a="41546559"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2025 04:16:03 -0800
X-CSE-ConnectionGUID: Uu6z39KSSx2lutsdHEvkww==
X-CSE-MsgGUID: KhZNsEf2Tjau7GgcSMsfXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="144046327"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 21 Jan 2025 04:16:02 -0800
Date: Tue, 21 Jan 2025 20:35:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] target/i386: Pass const CPUX86State to
 x86_cpu_pending_interrupt()
Message-ID: <Z4+UjBXLog7To++7@intel.com>
References: <20250120061544.81623-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250120061544.81623-1-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-3,
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

On Mon, Jan 20, 2025 at 07:15:44AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Mon, 20 Jan 2025 07:15:44 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH] target/i386: Pass const CPUX86State to
>  x86_cpu_pending_interrupt()
> X-Mailer: git-send-email 2.47.1
> 
> Directly pass CPUX86State to x86_cpu_pending_interrupt().
> Since it doesn't modify the dereferenced fields, make the
> argument const.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/i386/cpu.h                   | 2 +-
>  target/i386/cpu.c                   | 8 +++-----
>  target/i386/tcg/system/seg_helper.c | 2 +-
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


