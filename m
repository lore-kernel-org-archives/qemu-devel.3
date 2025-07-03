Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8378AC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 08:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFHL-0005Dh-6Q; Thu, 03 Jul 2025 04:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFHI-0005DK-KP
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:26:44 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXFHG-0005J2-0h
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 04:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751531202; x=1783067202;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=ZmG4X3Jhxv8Gv5+e4UWaPy0CAvjKsc9isQvzNVKdnmE=;
 b=EXpway/xZvBgmU/cTvIGWCDaHV3xHSv+R7th4HVBbcGkYmh84kKYe2Ee
 ftC5qZ6EiTmjLOKM/wL1TqfXPkwk+E8XVTtZr/zXmbmfCDEzp56mZKFrE
 wWn7DxbM2E+zatZNdEXcn/LIOUXGiKq8qWm0vNZeVP1LRcVKiEXEFXsvY
 ymSRMqGlSvEDs+T5bm/UrLB+v38LjEP7k9b+3voMEgWTKTEOu15DGacF5
 WjwnHCPCyxoOZHrjPIxSAFE4/FJEwX93cDmOW+W7YjOGLw7dqmzt+A4cP
 CWntkIHpBUpXchBC1TtcF8VCQWsUf69bjYshvDERSCOu1NSwavOWAh8Ud A==;
X-CSE-ConnectionGUID: AmiEbwbAQuWym9RoGSojKw==
X-CSE-MsgGUID: rHstoouSQGiduEOtCiSCjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="79280748"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="79280748"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2025 01:26:40 -0700
X-CSE-ConnectionGUID: z/7Ky3ApTN2kD35uOXuQkQ==
X-CSE-MsgGUID: ag0q8rMPT1GDBYZQiY2pWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="185245908"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 03 Jul 2025 01:26:35 -0700
Date: Thu, 3 Jul 2025 16:48:01 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Reinoud Zandijk <reinoud@netbsd.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
Subject: Re: [PATCH v4 58/65] accel: Always register
 AccelOpsClass::get_elapsed_ticks() handler
Message-ID: <aGZDwZaXu1TAfsJY@intel.com>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-59-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702185332.43650-59-philmd@linaro.org>
Received-SPF: pass client-ip=192.198.163.7; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 02, 2025 at 08:53:20PM +0200, Philippe Mathieu-Daudé wrote:
> Date: Wed,  2 Jul 2025 20:53:20 +0200
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH v4 58/65] accel: Always register
>  AccelOpsClass::get_elapsed_ticks() handler
> X-Mailer: git-send-email 2.49.0
> 
> In order to dispatch over AccelOpsClass::get_elapsed_ticks(),
> we need it always defined, not calling a hidden handler under
> the hood. Make AccelOpsClass::get_elapsed_ticks() mandatory.
> Register the default cpus_kick_thread() for each accelerator.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  include/system/accel-ops.h        | 1 +
>  accel/hvf/hvf-accel-ops.c         | 2 ++
>  accel/kvm/kvm-accel-ops.c         | 3 +++
>  accel/qtest/qtest.c               | 2 ++
>  accel/tcg/tcg-accel-ops.c         | 3 +++
>  accel/xen/xen-all.c               | 2 ++
>  system/cpus.c                     | 6 ++----
>  target/i386/nvmm/nvmm-accel-ops.c | 3 +++
>  target/i386/whpx/whpx-accel-ops.c | 3 +++
>  9 files changed, 21 insertions(+), 4 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


