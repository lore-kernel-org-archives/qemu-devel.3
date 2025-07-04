Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ADDC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 09:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXczm-0002g2-CN; Fri, 04 Jul 2025 05:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXczZ-0002fT-0m
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:46:02 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXczU-0005Bh-2T
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 05:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751622356; x=1783158356;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=5qSGiSXOKcAKV/h8so7GZZe+pHC4rBtVv0yxLpt2vEg=;
 b=EdmKSAzEvmRFnMGwo/YadgTo2wPL5IDyj9G+c67P/HxRJTkubGl8F4Gw
 LnUkIdT+UTdaWNlyMdgktDGc7SVQRKb/sbWZ4gHKkwCecm2phHaGcpTcX
 togIvI0lri5zQwbLTunO9a8zL8+mnWBqE+jX6bFQMhuS/qAl3U9wzqNF9
 G9Z0ZtAVaxS7yWIMKI8dcLuWS7AKSBPBikqACjPOGaEdZOY9+cg3f48R5
 pwX2bdP2nbEwz2cp0KVvQV9q6iubDqekVhVrOkHtC6s4GXm/NrGZH1myi
 SArdEop14oyhTfXnDrXBjMlqAh8VfxXjEqiw+rdzsgWu+GP1ySUGX8fqv Q==;
X-CSE-ConnectionGUID: IqABEzXPT0mZM9wAfb21bQ==
X-CSE-MsgGUID: MbjFkmwUTPuz504NdXl1Gw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71393714"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="71393714"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 02:45:53 -0700
X-CSE-ConnectionGUID: 5kSuDYzoRGKavZPd0khEAw==
X-CSE-MsgGUID: EKR+H+lWQpmfY2mJXcCuFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; d="scan'208";a="191776557"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa001.jf.intel.com with ESMTP; 04 Jul 2025 02:45:51 -0700
Date: Fri, 4 Jul 2025 18:07:17 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 18/39] accel/hvf: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Message-ID: <aGen1bJ0N65NT5oH@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-19-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-19-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:24PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:24 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 18/39] accel/hvf: Replace @dirty field by generic
>  CPUState::vcpu_dirty field
> X-Mailer: git-send-email 2.49.0
> 
> No need for accel-specific @dirty field when we have
> a generic one in CPUState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/system/hvf_int.h  |  1 -
>  accel/hvf/hvf-accel-ops.c | 10 +++++-----
>  target/arm/hvf/hvf.c      |  4 ++--
>  target/i386/hvf/hvf.c     |  4 ++--
>  target/i386/hvf/x86hvf.c  |  2 +-
>  5 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


