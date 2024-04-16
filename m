Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525C4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 15:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwkZe-0005rj-HG; Tue, 16 Apr 2024 11:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwkZc-0005pn-LY
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:18:16 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rwkZa-0007q2-T7
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 11:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1713280695; x=1744816695;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=b/UybqY1T85zLNnDTCZ3ZriqBdkKyGPWMleRZOWNCAM=;
 b=BwQwpeoxZeNgroj4MDxv+FBll2v0jHw5hN19JdTA5Vu76XxUTxqaIqjd
 BzySEJzjObjOCpNj9gl9qDo32SwTAt2Kg6xwi+b9uRi02Gi7qKu3RbJUw
 dQYG15BuKSwYnBm/ypNZZ+hfZ8v47e43ZOg3Pc+/nY0GXtzKeIkOLjHDY
 1FHhOysWs3psgHOpo2hy/CEKppildJdqHa01Zr1vlOBuEge/Kx8XNTwvx
 3caAAZCKcQYoT18OA9oH+dDQ2PXIkNLhzaGBGH1tkuLroLOCq7BuBURaD
 DG5vvSsGh6LWyW8nAP9OkXC8XrtjUJ6lNqFBCz857Hv13g9dDkb+Ij7b0 w==;
X-CSE-ConnectionGUID: epCBYQwdR8WUHYoH95E4mA==
X-CSE-MsgGUID: m6pqJwGnQXyw1p5zN6Yd3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="8946304"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="8946304"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2024 08:18:13 -0700
X-CSE-ConnectionGUID: PBNSXj+cS0y0c9jqOHpPmg==
X-CSE-MsgGUID: tfzGw2DwQYK09lV4J6PN3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; d="scan'208";a="53494933"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa001.fm.intel.com with ESMTP; 16 Apr 2024 08:18:12 -0700
Date: Tue, 16 Apr 2024 23:32:15 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 27/27] target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
Message-ID: <Zh6Z/7kdfFxCTi14@intel.com>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-28-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412073346.458116-28-richard.henderson@linaro.org>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.844,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On Fri, Apr 12, 2024 at 12:33:46AM -0700, Richard Henderson wrote:
> Date: Fri, 12 Apr 2024 00:33:46 -0700
> From: Richard Henderson <richard.henderson@linaro.org>
> Subject: [PATCH v3 27/27] target/i386/kvm: Improve KVM_EXIT_NOTIFY warnings
> X-Mailer: git-send-email 2.34.1
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/kvm/kvm.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


