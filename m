Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D85CEC48BF8
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5Zt-0002C4-Bs; Thu, 22 Feb 2024 04:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5Zq-0002BP-1W; Thu, 22 Feb 2024 04:41:14 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rd5Zl-00051A-5r; Thu, 22 Feb 2024 04:41:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708594869; x=1740130869;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=//cILPlV8ZtEIE5OOllf2iCg88j8tXpTlvuQ7BDcJRY=;
 b=WJFUQ1SdFjh3Xmnfo/Z6EN3r6AQ5kP+q1hb3zKs2Sfx+BXwZ6ryHJJGB
 52NOuCbXLlLvZxKT7IB1OmgXjFWRCxyKgnEqbbsUT/r/jO2ADPNk1WP+7
 7sHaanUhO8J3cvvkmxef8MqawpjYGOYt0u/QMbomQ/yRvQQ3+3UIqk6az
 T5nDKox4vvWhn1pZBSNHLEIXijZgd+9DlVP1l3OzS1P4btQDsXGvWKA6h
 PqLbeNXVdo4umOEdT6lZrzBj9iNchX6npNEFlaTZa/oY6gfM9gBZIqqy0
 pmMcTuOwLlVIgCvDYD4ZZb70IGVLX1hoKv803aH1Yey7SdELNVByCNN4X g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13936000"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; d="scan'208";a="13936000"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Feb 2024 01:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5805540"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 22 Feb 2024 01:41:02 -0800
Date: Thu, 22 Feb 2024 17:54:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 07/21] target: Replace DEVICE(object_new) -> qdev_new()
Message-ID: <ZdcZ4TPGX9ZJ0GRL@intel.com>
References: <20240216110313.17039-1-philmd@linaro.org>
 <20240216110313.17039-8-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216110313.17039-8-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Feb 16, 2024 at 12:02:58PM +0100, Philippe Mathieu-Daudé wrote:
> Date: Fri, 16 Feb 2024 12:02:58 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH 07/21] target: Replace DEVICE(object_new) -> qdev_new()
> X-Mailer: git-send-email 2.41.0
> 
> Prefer QDev API for QDev objects, avoid the underlying QOM layer.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/mips/cpu.c   | 2 +-
>  target/xtensa/cpu.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index d644adbc77..6b3909ee08 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -649,7 +649,7 @@ MIPSCPU *mips_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
>  {
>      DeviceState *cpu;
>  
> -    cpu = DEVICE(object_new(cpu_type));
> +    cpu = qdev_new(cpu_type);
>      qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
>      qdev_realize(cpu, NULL, &error_abort);
>  
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 79f91819df..4f9408e1a0 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -205,7 +205,7 @@ XtensaCPU *xtensa_cpu_create_with_clock(const char *cpu_type, Clock *cpu_refclk)
>  {
>      DeviceState *cpu;
>  
> -    cpu = DEVICE(object_new(cpu_type));
> +    cpu = qdev_new(cpu_type);
>      qdev_connect_clock_in(cpu, "clk-in", cpu_refclk);
>      qdev_realize(cpu, NULL, &error_abort);
>  
> -- 
> 2.41.0
> 
> 

