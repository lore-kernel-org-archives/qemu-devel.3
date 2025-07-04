Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2854BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:25:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeXz-0004OX-5K; Fri, 04 Jul 2025 07:25:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeXu-0004Ei-Jx
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:25:34 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeXt-0002pr-47
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751628334; x=1783164334;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=uVaSriLlcGDJkO8fVej7xFk288Hkks1H+Ov0QbI9er8=;
 b=arFGIOVSx8+cMhMVfguMcMMuGMJ5VLEu8y0wsPEVkXaVdXtbh+a6zqM+
 0/haGxK9iLqGeelbqPoFNqXMKxRhL1HN/SF2o2JLyZnC52tERBMWlcEhG
 wE3JYYIZx9m7oePz7yQXATG5aY3c4SVSZCJXFeLIwT2HXVgpgjzp2+AlL
 oiXXvFgaJHRZA5qYKPsVPeZ6wTF2uPsj2J8bb0vS87/VmlaYy03ni0bDP
 xqSpCO1ZJCBNSugxlfABFtfMUBVz958uW1KQy5hMDDFnWLKSbScjmVssP
 IBKsr3tZDPSgElR6Ku6BLKxTpUKH9VhGiI0n+SwXz9ty6D8Iyf07TFNGh A==;
X-CSE-ConnectionGUID: wk4+lpa0RyexcvsTzGsXgA==
X-CSE-MsgGUID: QbTbNNxDSEW+sojzV3fqMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54082082"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="54082082"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:25:32 -0700
X-CSE-ConnectionGUID: IAMFATxITYWVOwdZwOEJ5Q==
X-CSE-MsgGUID: y3nBgVxhR4eA9za/PldQbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="191791400"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 Jul 2025 04:25:31 -0700
Date: Fri, 4 Jul 2025 19:46:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 34/39] accel/kvm: Directly pass KVMState argument to
 do_kvm_create_vm()
Message-ID: <aGe/MIrspSQH5lgw@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-35-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-35-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:40PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:40 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 34/39] accel/kvm: Directly pass KVMState argument to
>  do_kvm_create_vm()
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/kvm/kvm-all.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


