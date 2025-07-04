Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89783C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 11:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXeLp-0001zD-SR; Fri, 04 Jul 2025 07:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeLR-0001jI-Am
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:44 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXeLN-0002C1-Nw
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 07:12:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751627558; x=1783163558;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=/hVPCh73fUpNDW3bOXImYu4Hg6P01VNCk8dVhBXuTBA=;
 b=RBbWsSl3EqpbE6KnaVLZUch5jwiFmPJgeU1onTKXiLKLFS3DYNLeyxTg
 5zjgTYLfrFJ1TARVdFB7kIYnbxv0scV+jmg8h8ekW8qNTGD9l6ZDoIMWd
 pf/cLS8kjaK3gJR2fRC7aXMnEPJXgUJ6p24mSvwa+oREggTmyuCDFm2RU
 TfAM9MmPKuUrEh0pZfpD/RepF75wijx2aGhblS7v3pFppPa/0vrBBBsMD
 Ywt8Mf6lO6FzUDsoB4Ua6ytGOe+xRmyBtKjj6bWs2EGHWnssUR8785bVL
 colWDEavSnvGujZ9mm7CwmsFbIgMF1Pvg+mWW5ODuMDVfbfjg6JYM/sgm w==;
X-CSE-ConnectionGUID: /i7qKRH6Szuf4gVOzsgMgA==
X-CSE-MsgGUID: CjUij/b8SuOIB006MUkOSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="65016895"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="65016895"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 04:12:31 -0700
X-CSE-ConnectionGUID: hrqwtJE8S9+A/37PTm2uKg==
X-CSE-MsgGUID: SiwZ9sOxQFKZCTjycoC7MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="154031149"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa010.jf.intel.com with ESMTP; 04 Jul 2025 04:12:30 -0700
Date: Fri, 4 Jul 2025 19:33:56 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 31/39] accel/kvm: Prefer local AccelState over global
 MachineState::accel
Message-ID: <aGe8JNShQjQ07kgt@intel.com>
References: <20250703173248.44995-1-philmd@linaro.org>
 <20250703173248.44995-32-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250703173248.44995-32-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Thu, Jul 03, 2025 at 07:32:37PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Thu,  3 Jul 2025 19:32:37 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v6 31/39] accel/kvm: Prefer local AccelState over global
>  MachineState::accel
> X-Mailer: git-send-email 2.49.0
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/kvm/kvm-all.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


