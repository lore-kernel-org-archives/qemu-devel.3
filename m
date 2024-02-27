Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4290C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 03:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reo3y-0001b5-CH; Mon, 26 Feb 2024 22:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reo3x-0001ao-7W
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 22:23:25 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1reo3s-0004Aw-2R
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 22:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709004201; x=1740540201;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=NiUNhkfxjBi8CduPdMiTKe5MGWkIL8WqezpHe2RZPgQ=;
 b=M8HVPXuh6YCnZEqW4Us5wHnoN7caR3VqR3F2U63aJiH9Zl3HF5Sdl7D/
 VW+pcn73grAex6iElYEziLHnOhDj8tId4Epu2EYSYes/hR9T1pBzFS4Ds
 83acR/kvetoB0IxwwLBiVMD77hI2rh0k8VpY9mKF7A8OF1xlVA7GJrgzo
 Er6QpBBVixBCbbeGdomF0Z1QzT+Q9YBS9Xu2KNNQU05xtO5u6Y/s63RHD
 cZ+RTurp4Dz0ZsJRpZOGn3e/CmFo2jcuAzCU8MjhQpsZ9MGzdpezh1VCw
 P5nglnnq1J2sVCmbcXMm/Qwfm6vjrLP+AJb+Y3ojpgiPY4zd5NmvvrPeX w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7142849"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7142849"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 19:23:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="7297674"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa006.jf.intel.com with ESMTP; 26 Feb 2024 19:23:15 -0800
Date: Tue, 27 Feb 2024 11:36:57 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
 implementing Resettable
Message-ID: <Zd1Y2aEo1nYy7tqp@intel.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-7-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220160622.114437-7-peter.maydell@linaro.org>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 04:06:18PM +0000, Peter Maydell wrote:
> Date: Tue, 20 Feb 2024 16:06:18 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 06/10] hw/core: Add ResetContainer which holds objects
>  implementing Resettable
> X-Mailer: git-send-email 2.34.1
> 
> Implement a ResetContainer.  This is a subclass of Object, and it
> implements the Resettable interface.  The container holds a list of
> arbitrary other objects which implement Resettable, and when the
> container is reset, all the objects it contains are also reset.
> 
> This will allow us to have a 3-phase-reset equivalent of the old
> qemu_register_reset() API: we will have a single "simulation reset"
> top level ResetContainer, and objects in it are the equivalent of the
> old QEMUResetHandler functions.
> 
> The qemu_register_reset() API manages its list of callbacks using a
> QTAILQ, but here we use a GPtrArray for our list of Resettable
> children: we expect the "remove" operation (which will need to do an
> iteration through the list) to be fairly uncommon, and we get simpler
> code with fewer memory allocations.
> 
> Since there is currently no listed owner in MAINTAINERS for the
> existing reset-related source files, create a new section for
> them, and add these new files there also.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS                      | 10 +++++
>  include/hw/core/resetcontainer.h | 48 ++++++++++++++++++++
>  hw/core/resetcontainer.c         | 76 ++++++++++++++++++++++++++++++++
>  hw/core/meson.build              |  1 +
>  4 files changed, 135 insertions(+)
>  create mode 100644 include/hw/core/resetcontainer.h
>  create mode 100644 hw/core/resetcontainer.c
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


