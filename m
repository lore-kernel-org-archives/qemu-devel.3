Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DCBC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 05:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDdpJ-0003qE-Qv; Sun, 02 Jun 2024 01:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDdpH-0003pc-I5
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 01:32:15 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDdpF-0001VY-GU
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 01:32:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717306333; x=1748842333;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Ptv/XhbYMsUNg5qRKHMukVfxG6OeqjmHjnvkdPpd7ug=;
 b=gJp9CfXIkonowBQXxRDwvvh0JiXcJ3oQUERlUiS7ZMNc64Giw7mTGvOT
 GHBFhZ3fEntSgGynqZjF29g5bp6IBxQg64ra0L4RpouTNHRajsecUDnM6
 9a3LWrTtNhLXrBG68AMsSJ/0l6P8nSD3Z2iu9OkZ/LGmWHmZKUAREWLU0
 STMShER5EuJKF33f9KILdFedukMBIaABZjL1PVu/nfT8nN8HoMWxn8Ydl
 hRF9A/fnVT7WHyrulAjdVFpCuTaWUeYsSdQofNJsDkZJDs89pFLLu7ff+
 Nj7xUyzut6cYOoFj2Z31W2RMo2bD7FxXL511yODR/QF2HHA0PB1755bnv Q==;
X-CSE-ConnectionGUID: B3x4xuOyTXaC/3NiBxSZzQ==
X-CSE-MsgGUID: XTeTuB9GQeq1yTB/cGnI6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="31348325"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; d="scan'208";a="31348325"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2024 22:32:10 -0700
X-CSE-ConnectionGUID: BrX3tFMFRx+YGIymyRxdNg==
X-CSE-MsgGUID: KRtBTvExTtivDJsx8DRnrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; d="scan'208";a="41481962"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa003.jf.intel.com with ESMTP; 01 Jun 2024 22:32:10 -0700
Date: Sun, 2 Jun 2024 13:47:34 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] machine: allow early use of machine_require_guest_memfd
Message-ID: <ZlwHdncUT7+ms5ul@intel.com>
References: <20240531112636.80097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531112636.80097-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.8; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.041,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, May 31, 2024 at 01:26:36PM +0200, Paolo Bonzini wrote:
> Date: Fri, 31 May 2024 13:26:36 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH] machine: allow early use of machine_require_guest_memfd
> X-Mailer: git-send-email 2.45.1
> 
> Ask the ConfidentialGuestSupport object whether to use guest_memfd
> for KVM-backend private memory.  This bool can be set in instance_init
> (or user_complete) so that it is available when the machine is created.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/exec/confidential-guest-support.h | 5 +++++
>  include/hw/boards.h                       | 1 -
>  hw/core/machine.c                         | 2 +-
>  3 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


