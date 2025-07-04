Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACBA4C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeXN-0002mz-68; Fri, 04 Jul 2025 07:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeX8-0002bR-O0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:24:47 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeX7-0002Xa-3x
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751628286; x=1783164286;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=oi6tnJaH7knQgay6ed4+QUz5CHiJ6Dz9uJ1yC0IPIg4=;
 b=hS6Cf/lyQElIMeZ66lxAoyngZiKG1q/HKDD99dL5JS8AZgMRx5qMIXyh
 Gwl/yFJ8fCh/2X3gx0+mry2Mve5RmgLEcCGy7YBtJXcCuCKEbPHOUGmVq
 98xPv4H5w0HKEvtflqmovrIb7DpQcYUMX79LnmJsDUf33nE4ccjxjQEVr
 jf+j/Ivp9pROlpoGBN3wJ+uWY+Wpj8uQzTr7YYU22b4m57GJmY0/J9f5k
 kWd+ZspgFAhE43hU6iGuX8C2Nv3usSz/bIf0w1BPcjO34ix2RUxgsOzBZ
 NTzxkyrq1rP6J5o2EDjCmPGDsUA4IobauKk+GTUgC4XuJUTlfgU7Ti0gp w==;
X-CSE-ConnectionGUID: +gtP5T8yTNalSWpyaXNgIg==
X-CSE-MsgGUID: 66FzGPLoRkCRA/fZbefB0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="57737480"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="57737480"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:24:43 -0700
X-CSE-ConnectionGUID: ARiMgefAReagYJtlnF2qXA==
X-CSE-MsgGUID: xmQXkeX5TbSgN2ETUqb3Hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="178287390"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 04 Jul 2025 04:24:42 -0700
Date: Fri, 4 Jul 2025 19:46:08 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 33/39] accel: Directly pass AccelState argument to
 AccelClass::has_memory()
Message-ID: <aGe/AOb7HosV1KNE@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-34-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-34-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
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

On Thu, Jul 03, 2025 at 07:32:39PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:39 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 33/39] accel: Directly pass AccelState argument to
>  AccelClass::has_memory()
> X-Mailer: git-send-email 2.49.0
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/qemu/accel.h | 2 +-
>  accel/kvm/kvm-all.c  | 4 ++--
>  system/memory.c      | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


