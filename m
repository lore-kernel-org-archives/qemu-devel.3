Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A34C27C5E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 06:20:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGuqi-0000HF-Ot; Tue, 11 Jun 2024 02:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sGuqg-0000GO-H9; Tue, 11 Jun 2024 02:19:14 -0400
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sGuqd-0003mx-DJ; Tue, 11 Jun 2024 02:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1718086751; x=1749622751;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=XHJof9KHIGlQUK8G+y0OIiHckY7ViqyWin/79YCmlT8=;
 b=Xvi/pCMnkoa23fUW1daJEazmAnr2UdqVs2KpZv2GT1ctAZF+/uTIHP9l
 tY7f0YHb+cEG0rPBLaRzByiOY1Z2wJLQzxSoHJauR7jHES6DetJX+7Wcr
 jIhv/Te2j0EF9X2A8b3T4yGULTPcLteQGAMXG9K5DP392Ox5I8A+lffqp
 o+a+yC+esqkgtRTGtLe9OfM4j6hp38JmvtIYOBN34XsIXarg2IB/45jzV
 Vi4tOIBO81QDAmP27gBTqHrMFjxAaqeT6Yrt4a4xaZ/O7ijTV1BW9qysO
 RCgjLpxhRg1yVxarYJmZfhGwiGybSaDeWn7LivZ0kv7E4uYINf+DgK3wa w==;
X-CSE-ConnectionGUID: IzeEOoJATmSW+rk68i9JeQ==
X-CSE-MsgGUID: 44LNSObLR5We/bJX84QKvA==
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="14946705"
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="14946705"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2024 23:19:06 -0700
X-CSE-ConnectionGUID: 5ve7Y1uDQwW7TiqL7a9GxA==
X-CSE-MsgGUID: RFUv8XI6TDG1xJ7tkB4Zhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,229,1712646000"; d="scan'208";a="39421515"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa009.fm.intel.com with ESMTP; 10 Jun 2024 23:19:04 -0700
Date: Tue, 11 Jun 2024 14:34:32 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, xieyongji@bytedance.com,
 imammedo@redhat.com, qemu-stable@nongnu.org,
 Guixiong Wei <weiguixiong@bytedance.com>,
 Yipeng Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
 processor cores in the physical package
Message-ID: <Zmfv+Ce+3sAiNJLL@intel.com>
References: <20240611032314.64076-1-xuchuangxclwt@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611032314.64076-1-xuchuangxclwt@bytedance.com>
Received-SPF: pass client-ip=192.198.163.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 11, 2024 at 11:23:14AM +0800, Chuang Xu wrote:
> Date: Tue, 11 Jun 2024 11:23:14 +0800
> From: Chuang Xu <xuchuangxclwt@bytedance.com>
> Subject: [PATCH v3] i386/cpu: fixup number of addressable IDs for processor
>  cores in the physical package
> X-Mailer: git-send-email 2.24.3 (Apple Git-128)
> 
> When QEMU is started with:
> -cpu host,host-cache-info=on,l3-cache=off \
> -smp 2,sockets=1,dies=1,cores=1,threads=2
> Guest can't acquire maximum number of addressable IDs for processor cores in
> the physical package from CPUID[04H].
> 
> When creating a CPU topology of 1 core per package, host-cache-info only
> uses the Host's addressable core IDs field (CPUID.04H.EAX[bits 31-26]),
> resulting in a conflict (on the multicore Host) between the Guest core
> topology information in this field and the Guest's actual cores number.
> 
> Fix it by removing the unnecessary condition to cover 1 core per package
> case. This is safe because cores_per_pkg will not be 0 and will be at
> least 1.
> 
> Fixes: d7caf13b5fcf ("x86: cpu: fixup number of addressable IDs for logical processors sharing cache")
> Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> ---
>  target/i386/cpu.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks! LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


