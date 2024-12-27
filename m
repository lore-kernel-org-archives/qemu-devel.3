Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3EAE7718F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2024 07:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tR4ep-0007lb-TT; Fri, 27 Dec 2024 02:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4ej-0007l2-Ad
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:21:10 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tR4ef-0005zd-Se
 for qemu-devel@nongnu.org; Fri, 27 Dec 2024 02:21:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1735284066; x=1766820066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=A6ImB+orkL2jaGAShPBNmF3zKkTddbFDbcrIqEgGQQg=;
 b=PBneHuFAoKgtsN9dc/DUY4UPLND5IEDMEZ7Rko42XUShrxPttv+D/cpx
 5+HwnmaC1K4BTzJWF8cPO5miWSUsuixnZNUPh0+EWLpyvbTY3rChjE9N1
 pSCAa9WLsvUr3btYkLhmlViT00S8zZ5opirsGYkX4vPF8PK3P6G2I/Hvp
 ugQsb8lzx5QJQ+6omu0owhrUerLxHn2w5dn9EPfKizuWikKcxpRM7QPPS
 bkXdgB0aaij7aF64ynifmZqFAtspEE/ZN4BNcIL5dipU2m/ANzS+9MpWe
 VkPSxTR9wPlzD/UJFzzrhJ7uY1uu4nwrYuz+UXTjis/B5DLqYlxSJQbve A==;
X-CSE-ConnectionGUID: UrD6vzYpQ66FFJcW1znSCg==
X-CSE-MsgGUID: XI61m/qJT1StIh3ts2M4XA==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46183633"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="46183633"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Dec 2024 23:21:02 -0800
X-CSE-ConnectionGUID: R3cJaghXReii27QPxh+jBg==
X-CSE-MsgGUID: IW0xW7IwSAC4VEdTvEj0Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; d="scan'208";a="99932439"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa007.fm.intel.com with ESMTP; 26 Dec 2024 23:21:00 -0800
Date: Fri, 27 Dec 2024 15:39:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Yanan Wang <wangyanan55@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v2 03/10] i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
Message-ID: <Z25Zv+oE+1FZ/gQ9@intel.com>
References: <20241219110125.1266461-1-xiaoyao.li@intel.com>
 <20241219110125.1266461-4-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219110125.1266461-4-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 19, 2024 at 06:01:18AM -0500, Xiaoyao Li wrote:
> Date: Thu, 19 Dec 2024 06:01:18 -0500
> From: Xiaoyao Li <xiaoyao.li@intel.com>
> Subject: [PATCH v2 03/10] i386/cpu: Drop cores_per_pkg in cpu_x86_cpuid()
> X-Mailer: git-send-email 2.34.1
> 
> Local variable cores_per_pkg is only used to calculate threads_per_pkg.
> No need for it. Drop it and open-code it instead.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  target/i386/cpu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


