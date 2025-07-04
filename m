Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F6EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdoQ-0007iy-UQ; Fri, 04 Jul 2025 06:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXdoF-0007iK-Io
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:38:25 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXdoD-000250-4e
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:38:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751625501; x=1783161501;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=JXto//9eX9Re5XTTIs+3f4MRMB4qV6S0SmvbPTgLnnQ=;
 b=IVN68en3tz+XqboVTOuooKrDdqG6GF1D8Uaw/x+2VjOKxzuvVvYpI0xt
 G9whJrsuzgtM4zij2cn61sbSutYTy7fbGX+gSvp1SoQlEJyxK5pKxtiGE
 MoeCYf+mMfqpxo7HWvopsbJ3JfUp4mRrmQCbmKl/huAbJFBfsfiMIF7FR
 KPLUmg4KeBBL35/EyRcmuQyoFam79/mI22a4XtZOTG8N9VwVH8sH+x/o8
 ifl1mzq2BCts0mqYrbmJUYozDWjaGO3ePo6KCRm1/g7asYLy2tsBEEx6s
 Rwh2c55tCynOjFMlxMMY2biIlpAy1HZnC3ER4Ss1V+lD5OGDh6zYRoaG8 w==;
X-CSE-ConnectionGUID: rQMyvbe/RAOBb5260T2Yyg==
X-CSE-MsgGUID: aauKJEDsSoqWjw1O5WWf/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="53884719"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="53884719"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 03:38:16 -0700
X-CSE-ConnectionGUID: /hNgBwWfQECrLzZ7zmgDIA==
X-CSE-MsgGUID: JvTw3iR5TRWx3hrDfwiEVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="155103923"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa008.jf.intel.com with ESMTP; 04 Jul 2025 03:38:15 -0700
Date: Fri, 4 Jul 2025 18:59:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 27/39] accel: Pass old/new interrupt mask to
 handle_interrupt() handler
Message-ID: <aGe0HYi6wq2aVzl6@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-28-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-28-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
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

On Thu, Jul 03, 2025 at 07:32:33PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:33 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 27/39] accel: Pass old/new interrupt mask to
>  handle_interrupt() handler
> X-Mailer: git-send-email 2.49.0
> 
> Update CPUState::interrupt_request once in cpu_interrupt().
> Pass the old and new masks along.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-accel-ops-icount.h |  2 +-
>  accel/tcg/tcg-accel-ops.h        |  2 +-
>  include/system/accel-ops.h       |  2 +-
>  accel/tcg/tcg-accel-ops-icount.c |  8 +++-----
>  accel/tcg/tcg-accel-ops.c        |  4 +---
>  system/cpus.c                    | 12 +++++++-----
>  6 files changed, 14 insertions(+), 16 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


