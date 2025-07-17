Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E589CC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:21:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJqy-0004Ga-TW; Thu, 17 Jul 2025 04:20:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucJqq-0004BJ-SW
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:20:25 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ucJqn-0000qG-He
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:20:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752740422; x=1784276422;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=fL92tWr/g2fBKqdtf04Rw6jIuAOiOhSgysYj+aMOtwc=;
 b=XF1yA9z8jdXDjqDXWBKcio1H7erHVPVkahPd1EgPQ3fOWI90xjbgLSVS
 +YySeB8syVMzPhid9oEGS0TynVEp0hp0yqnBwZrEqguDli+Y4aVdShv5Z
 u6NAwIQfH1YSfKeHXXZlYzBdOZg9GhVVj/PxYA8Lcw2h9KKD0i2uNbZxV
 oM7J8F8mYHiPIBHqy1IfFWuZHBYnxmM1yYj8Khnq5pl9X/MPUg6AMh3WD
 tbXY3KlM5P9gknU1+bQ6/5JkPeXNwnpdrpq9BSJ6P6rcQz7RCGA8u7T50
 +bbtNNzdIKaeTMqXGnLqUW7xyk7JRD7evqW4UXJ1RmQi5rBFuI0WrjVd8 g==;
X-CSE-ConnectionGUID: iEgVQZbWQkG1x4+2OIiv4Q==
X-CSE-MsgGUID: gHerSWU9QeeEg6GIGKeDmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54880831"
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="54880831"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jul 2025 01:20:16 -0700
X-CSE-ConnectionGUID: anytn1/HQbOEInGkNK8apw==
X-CSE-MsgGUID: tKzCMJRHS3Sf2CE4gclaiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,318,1744095600"; d="scan'208";a="158087601"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 17 Jul 2025 01:20:14 -0700
Date: Thu, 17 Jul 2025 16:41:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] i386/cpu: Cleanup host_cpu_max_instance_init()
Message-ID: <aHi3ShRbe+uhTLBL@intel.com>
References: <20250716063117.602050-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716063117.602050-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.21; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 16, 2025 at 02:31:16PM +0800, Xiaoyao Li wrote:
> Date: Wed, 16 Jul 2025 14:31:16 +0800
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH] i386/cpu: Cleanup host_cpu_max_instance_init()
> X-Mailer: git-send-email 2.43.0
> 
> The implementation of host_cpu_max_instance_init() was merged into
> host_cpu_instance_init() by commit 29f1ba338baf ("target/i386: merge
> host_cpu_instance_init() and host_cpu_max_instance_init()"), while the
> declaration of it remains in host-cpu.h.
> 
> Clean it up.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/host-cpu.h | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


