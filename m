Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C453C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 14:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugOqO-0006tS-Gq; Mon, 28 Jul 2025 10:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ugOqD-0006h1-3d
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:28:38 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1ugOqA-0001VT-Es
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 10:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753712914; x=1785248914;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=TLIz7v18DfzsGm3tc6yqJN4YrTCrTkeqfFdjY2bhjyU=;
 b=lgsyAA7ltmtCJftb817/TMbjCxU6bAfvn7YvXheDLVE68ippPrNujXHd
 cIZMLRD/6fj3rVhi93vWA/ZXAjKZbOLZjCMDu8JMaK+jh00B+IRTSoDkN
 jkwMH2NFytd3Ly9yJ3c0epqvEuWsJO+Yuwxsxr5b6v3BgEeWNEDYA7Z8t
 QKiQKABEyD/a7uLlUsj78iyKHAY8P76z1VFEPej28bjFhhQg0UbypT5io
 vhJbvr/StAnWsn8XuBSBpC4Nq4u+NqDDDvLe9TT/G1OfrHFh8vJFBAhi5
 Ut0XbhOY7kT2B4L2PB4lRAd+oLakdYpwcYsLIziUwRqcNCGzNJxI6rBH5 g==;
X-CSE-ConnectionGUID: I0XceQ48SBSizhSYZXZVmQ==
X-CSE-MsgGUID: 11aEOVjhQJ2kg0/cK8OInQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="67313779"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="67313779"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 07:28:30 -0700
X-CSE-ConnectionGUID: 5Do60L4gTPK1oRBdMmPhgQ==
X-CSE-MsgGUID: 4hBM8Kh4SceNz7HB9pOv4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="162474848"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 28 Jul 2025 07:28:28 -0700
Date: Mon, 28 Jul 2025 22:50:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Shaoqin Huang <shahuang@redhat.com>
Subject: Re: [PATCH] hw/i386: Fix 'use-legacy-x86-rom' property compatibility
Message-ID: <aIeOG5Inr3Xf4WgU@intel.com>
References: <20250723062714.1245826-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723062714.1245826-1-clg@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On Wed, Jul 23, 2025 at 08:27:14AM +0200, Cédric Le Goater wrote:
> Date: Wed, 23 Jul 2025 08:27:14 +0200
> From: Cédric Le Goater <clg@redhat.com>
> Subject: [PATCH] hw/i386: Fix 'use-legacy-x86-rom' property compatibility
> 
> Commit 350785d41d8b ("ramfb: Add property to control if load the
> romfile") introduced the `use-legacy-x86-rom` property for the
> `vfio-pci-nohotplug` device, allowing control over VGA BIOS ROM
> loading. However, the property compatibility setting was incorrectly
> applied to the `vfio-pci` device instead, which causes all `vfio-pci`
> devices to fail to load. This change fixes the issue by ensuring the
> property is set on the correct device.
> 
> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/types.h   | 2 ++
>  hw/core/machine.c | 2 +-
>  hw/i386/microvm.c | 2 +-
>  hw/i386/pc_piix.c | 2 +-
>  hw/i386/pc_q35.c  | 2 +-
>  hw/vfio/pci.c     | 2 --
>  6 files changed, 6 insertions(+), 6 deletions(-)

LGTM. Thanks!

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


