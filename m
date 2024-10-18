Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A28D2FFE0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 09:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1jda-0008Ha-NT; Fri, 18 Oct 2024 05:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jdZ-0008HI-1K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:51:13 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1t1jdX-0002dr-Dw
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 05:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1729245072; x=1760781072;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=K4xbK/n2aVVzi3ALJtdnrMgdfPdLYbDHGEmq3kF6wUw=;
 b=aLAHt14Qja/qZTb0gQEzSmQaIAaeFb5wIJkM63KW59QFaQU+i8XbGAJ0
 VJf178urJHPtUtPwiRLlQP2ZE2IejhydDG8mPlrgvkfnhAqgJKgoIg18H
 eIe/ExhBhpcISWaZd8z0y6K9GK4HXlHu60mZaOXxPlXYUtqep+qQnTeBv
 SacrHUN7emlPLiP+bFM2VwCxH+50ew7ox9GsbxTkWPqpMHhYvo4bEdyE+
 1wJUHWNEeA5R20udoI2SSBdOj+S5Ood3opwhuMfs/hoXdYncRz4EAE8EJ
 T1KEFuySDPY4osJ5nlz+yl37bzBUSB4Lquw9j3QivnfwygY/OefCXfg8E Q==;
X-CSE-ConnectionGUID: X2rrMAqyQjexV/4R+bM3+A==
X-CSE-MsgGUID: KirM3EdjTO62QtDcfL4gcw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28873481"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="28873481"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2024 02:51:10 -0700
X-CSE-ConnectionGUID: PmHE8IhOQYaWLVRuatFkHQ==
X-CSE-MsgGUID: jEZZhENSTLm+l2oYRx3aow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; d="scan'208";a="83459586"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 18 Oct 2024 02:51:08 -0700
Date: Fri, 18 Oct 2024 18:07:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 24/31] target: adapt to new import path for qobject
 data type headers
Message-ID: <ZxIzXEr7Uan+NvrQ@intel.com>
References: <20241017113344.883424-1-berrange@redhat.com>
 <20241017113344.883424-25-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241017113344.883424-25-berrange@redhat.com>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
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

On Thu, Oct 17, 2024 at 12:33:36PM +0100, Daniel P. Berrangé wrote:
> Date: Thu, 17 Oct 2024 12:33:36 +0100
> From: "Daniel P. Berrangé" <berrange@redhat.com>
> Subject: [PATCH v2 24/31] target: adapt to new import path for qobject data
>  type headers
> 
> The qobject data type headers have moved from qapi/qmp/ to
> qobject/.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  target/arm/arm-qmp-cmds.c             | 2 +-
>  target/i386/cpu-apic.c                | 2 +-
>  target/i386/cpu-sysemu.c              | 2 +-
>  target/i386/monitor.c                 | 2 +-
>  target/loongarch/loongarch-qmp-cmds.c | 2 +-
>  target/ppc/cpu_init.c                 | 2 +-
>  target/riscv/riscv-qmp-cmds.c         | 4 ++--
>  target/s390x/cpu_models_sysemu.c      | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


