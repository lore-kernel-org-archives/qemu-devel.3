Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E39C83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:15:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXcVS-0005PO-FZ; Fri, 04 Jul 2025 05:14:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcVQ-0005O3-Rx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:14:52 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXcVP-0001LV-9Q
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751620491; x=1783156491;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=t+J/nB4cAVI0KSD4rgQE67vIMS4Ht4rh2NMB33eJrBc=;
 b=aX9BkWXaOXwx8SZCm2Z/YUSO8TCkBbxtnUkwVIv3/UB5Nt0NC9kBl5ww
 AmIY9Z1Fkmwj7hgDykc4J7Kxuo7vMHkiWtWsfFNB3dtk+t9CBsmXg6/2K
 OzvWSnrWbrxgP1nB6JJmjEjcM+Ll52yWdBh7vRkNaBjPCK8rdILclpc20
 OsYuw0kyRTMo2mT2FpvA9iUbfHQ751DugO4Hc/b9MOWR8IS6KOEfsgax/
 FYwXI+7NM3zaW4sKlsyOTUMpOVlt8qpTfOlbA0D5sUqhlnGkRDjRiVZEt
 bSTJiiwAPcEOTCF3nAEfdmMkmmWdr6XWW0gF8unKJtBCEWlr1zj8XudU6 A==;
X-CSE-ConnectionGUID: 1kDHkAQ3TNK8EoKe2J9e1g==
X-CSE-MsgGUID: d1QekgzTSrqYdqBpa+bfug==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="56580811"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="56580811"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:14:50 -0700
X-CSE-ConnectionGUID: rpuPFBlmQWKILgCGBqFsNQ==
X-CSE-MsgGUID: 8Zt5UZDmSImRd5LebIdW/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="159150950"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 04 Jul 2025 02:14:48 -0700
Date: Fri, 4 Jul 2025 17:36:14 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 07/39] accel/tcg: Remove 'info opcount' and
 @x-query-opcount
Message-ID: <aGegjrAunaMNodUa@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-8-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:13PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:13 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 07/39] accel/tcg: Remove 'info opcount' and
>  @x-query-opcount
> X-Mailer: git-send-email 2.49.0
> 
> Since commit 1b65b4f54c7 ("accel/tcg: remove CONFIG_PROFILER",
> released with QEMU v8.1.0) we get pointless output:
> 
>   (qemu) info opcount
>   [TCG profiler not compiled]
> 
> Remove that unstable and unuseful command.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  qapi/machine.json          | 18 ------------------
>  accel/tcg/monitor.c        | 21 ---------------------
>  tests/qtest/qmp-cmd-test.c |  1 -
>  hmp-commands-info.hx       | 14 --------------
>  4 files changed, 54 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


