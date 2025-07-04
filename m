Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F38C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeM0-0002QC-1A; Fri, 04 Jul 2025 07:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeLu-00027o-JN
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:10 -0400
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeLs-00037R-Fn
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:13:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751627589; x=1783163589;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ao7lv0OhthKaNJWSBtSui9/38qDdDcwvoQlS6+8V+78=;
 b=A3MiE2yTj3ZmlmAVGVHVToSnoimLXd+erJOcf9NG3TVToWlUIr11YmxN
 DRA93KHPavvs8BNba5Uv3RS5aWvIZwRsjP8KncaTzVnLcrU0+aLR6eGwB
 UPLpKpPhi/iikEtz0wcK0Mg5zl8vQeyZbfo7M9eUACt6insT/AJv9DL18
 N63P3QQ+zWdoQPC2FA3fWwKhH8drOQYkNiCu17Fcxfhp0SEwiZjOqBYhv
 PRsgD4H/kQfxDp/b2W9c7HWgCjOVM2RWfXDnZ431Ske2FOVaVrkPpEa3o
 muBhujW/fd6xJF74IXS7KHCtydBtT2tvl96bVEazgstWEVCq68XxN+eNw A==;
X-CSE-ConnectionGUID: wqCVY0p5TjuhtFoMxMJKYw==
X-CSE-MsgGUID: TL+4OBf8RAqkLnSnuLpFZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64208387"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="64208387"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:13:07 -0700
X-CSE-ConnectionGUID: CKPhblVeSFGvGSLp5qF0cg==
X-CSE-MsgGUID: 8sST6zVRS6uXEK+8ipKCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="155199663"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa008.fm.intel.com with ESMTP; 04 Jul 2025 04:13:05 -0700
Date: Fri, 4 Jul 2025 19:34:31 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 32/39] accel/tcg: Prefer local AccelState over global
 current_accel()
Message-ID: <aGe8R57j9ZZ4vckf@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-33-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-33-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:38PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:38 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 32/39] accel/tcg: Prefer local AccelState over global
>  current_accel()
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-all.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


