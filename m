Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 845F2E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 07:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR4gR-0008PD-N4; Fri, 27 Dec 2024 02:22:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4gM-0008Om-9b
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:22:51 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4gJ-00064C-Fa
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735284167; x=1766820167;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=QGBeziVfPGvcpoUGpymnsoBTwiEPKSgpt13b/SYPQiA=;
 b=fmwA9M1Xsv/aDtRh/g/7Gzl/UM5OUq4a3V6hPH/TSJ1itd8Z5a+rAS2P
 eyzE6vO8xmogJcE0XpFXpiXZV7B8V5S068Q3m1uZovToMBPA2ZPne+UTT
 56Q7hbTLhD6Skx8zZTDQPfNsmg4fvqmdae31X1mZBTj809cZDBWlFrmeP
 bvkNpxdEeXPtUz3qtLa9dEo3tUDfb6hc4PJTITIsmdHlP1ZYJLy8GRxcs
 hoK/uZFgcswz45OttyuoONh6qU1XYMpVM7OHaZp2ba+DWbv8OrOV8C+/d
 a9E2/1N+IwZp/aSW9YUBwigmEoiY5Tm8IZ7RtHFFFUU58PS9q/fNuKhkv A==;
X-CSE-ConnectionGUID: fnN+0wGYTkWpz6fV5FKENg==
X-CSE-MsgGUID: 1U9nHJWCQbyMNq7ylYz8Gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="39469113"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="39469113"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2024 23:22:46 -0800
X-CSE-ConnectionGUID: fy30Tiv8QyuSRLVb4FmDlA==
X-CSE-MsgGUID: o+rPw9dSSJavbaYgB5uGHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="131078588"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 26 Dec 2024 23:22:43 -0800
Date: Fri, 27 Dec 2024 15:41:27 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2 02/10] i386/cpu: Drop the variable smp_cores and
 smp_threads in x86_cpu_pre_plug()
Message-ID: <Z25aJxj5vKBGKwvv@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-3-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110125.1266461-3-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Dec 19, 2024 at 06:01:17AM -0500, Xiaoyao Li wrote:
> Date: Thu, 19 Dec 2024 06:01:17 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2 02/10] i386/cpu: Drop the variable smp_cores and
>  smp_threads in x86_cpu_pre_plug()
> X-Mailer: git-send-email 2.34.1
> 
> No need to define smp_cores and smp_threads, just using ms->smp.cores
> and ms->smp.threads is straightforward. It's also consistent with other
> checks of socket/die/module.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  hw/i386/x86-common.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


