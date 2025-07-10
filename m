Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1232BC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 08:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZmzA-0003CN-IS; Thu, 10 Jul 2025 04:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZmz9-0003AG-2O; Thu, 10 Jul 2025 04:50:31 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uZmz4-0003JA-26; Thu, 10 Jul 2025 04:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752137426; x=1783673426;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=pOm1xsq/ko7zJ2+6NIOLvMkYIqA8/bOsWOMcCkx5PvA=;
 b=ORcCQrqG+43oSxDDimFNtjxsynbD+OLNvi4OVazlIdWIkchxeEBiCOPx
 T1ov02Ee9JcRKbORG88umnvRe01a5p8Bh+hL+L+27vq/+aPoc+2rR6V2W
 w3bTCygMQaJNNPhu3O7EgkVQz+BcYeZEwBVP9uQlwddLBLrF7kzYLbfzw
 DAfbVYJnHdn8je5Sn+AwWlMm6od/6W7R+5doO9AXsI1Nk/5VXkAJTGi9s
 13Z6NuRhSJekchmkdRezOzgkZ8uvQElJI6g9Jf7/FYR6JJ3ypiXY++4Xa
 gQa7ftX4LguXgc97EAY5W2E9Ya9c4LC1RDizpBBnIHYz7G7GMnTp84C61 w==;
X-CSE-ConnectionGUID: sYxPDFlDT9qQ3MHHAJ02HA==
X-CSE-MsgGUID: nG473AzwRjKoX58EUtAcrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="53631639"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="53631639"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2025 01:50:21 -0700
X-CSE-ConnectionGUID: B8+f8FSCS+WqdtU75rh+yg==
X-CSE-MsgGUID: D6Oe6C4TQQWYtNMcEI6c1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; d="scan'208";a="155427571"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa006.jf.intel.com with ESMTP; 10 Jul 2025 01:50:19 -0700
Date: Thu, 10 Jul 2025 17:11:46 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Shaoqin Huang <shahuang@redhat.com>
Cc: qemu-arm@nongnu.org,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Auger <eauger@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 1/2] ramfb: Add property to control if load the romfile
Message-ID: <aG+D0p8aZsq7+0vB@intel.com>
References: <20250704030315.2181235-1-shahuang@redhat.com>
 <20250704030315.2181235-2-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704030315.2181235-2-shahuang@redhat.com>
Received-SPF: pass client-ip=192.198.163.18; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Jul 03, 2025 at 11:03:14PM -0400, Shaoqin Huang wrote:
> Date: Thu,  3 Jul 2025 23:03:14 -0400
> From: Shaoqin Huang <shahuang@redhat.com>
> Subject: [PATCH v9 1/2] ramfb: Add property to control if load the romfile
> 
> Currently the ramfb device loads the vgabios-ramfb.bin unconditionally,
> but only the x86 need the vgabios-ramfb.bin, this can cause that when
> use the release package on arm64 it can't find the vgabios-ramfb.bin.
> 
> Because only seabios will use the vgabios-ramfb.bin, load the rom logic
> is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
> for ramfb, so they don't need to load the romfile.
> 
> So add a new property use-legacy-x86-rom in both ramfb and vfio_pci
> device, because the vfio display also use the ramfb_setup() to load
> the vgabios-ramfb.bin file.
> 
> After have this property, the machine type can set the compatibility to
> not load the vgabios-ramfb.bin if the arch doesn't need it.
> 
> For now the default value is true but it will be turned off by default
> in subsequent patch when compats get properly handled.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/display/ramfb-standalone.c | 4 +++-
>  hw/display/ramfb-stubs.c      | 2 +-
>  hw/display/ramfb.c            | 6 ++++--
>  hw/vfio/display.c             | 4 ++--
>  hw/vfio/pci.c                 | 1 +
>  hw/vfio/pci.h                 | 1 +
>  include/hw/display/ramfb.h    | 2 +-
>  7 files changed, 13 insertions(+), 7 deletions(-)

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


