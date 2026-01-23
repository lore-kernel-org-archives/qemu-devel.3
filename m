Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F95FD72366
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 09:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjDwV-0001Lp-MP; Fri, 23 Jan 2026 04:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vjDwR-0001LP-PJ
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 04:58:59 -0500
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vjDwP-0002Jk-M2
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 04:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769162338; x=1800698338;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Xy3xO6KWuwAAmL3C3cKDoW1TBUV13nyii5WRYl1xGlo=;
 b=dwsWVWw98hWrsBpcls6MLOIp0HVXUyE2nRWPnEEZO+gDLppK3K8jn7Pu
 OEjiYznX0eXP04nmnPv/zgRjPwzNsTnd500DMvoD1W9bGbpfwgaN9pq4H
 N70lW6rTm3MdRQ7ANtEoCHUxPAZHYykVTHIuQ5Lg6P2jOJ4pb/m/kxeHD
 HfNW33FKEw/eTE6AZyNdkL867PEGePCNeTAq8JFkJKMj7zBVU2PFxLJHx
 OA236VLXmZD50hyJGv0Lim+7xhJGWJFozzUfQUxeyShKlLepMBx5t9AYu
 CzeecPdLykc60wa1/Qm7BPSEVx8kICyoNrlPioiwDrmcXjgbzwVvGWPI1 A==;
X-CSE-ConnectionGUID: rjLS5aSITba74aYe7BYmbQ==
X-CSE-MsgGUID: RIFPTbe+RpiEI7z8cBGGPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="70475555"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="70475555"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2026 01:58:53 -0800
X-CSE-ConnectionGUID: s0R+Dyu6TZCWBJp3P/tZlg==
X-CSE-MsgGUID: o1HemVHQR7ylwSBiLtFbLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; d="scan'208";a="229947450"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 23 Jan 2026 01:58:52 -0800
Date: Fri, 23 Jan 2026 18:24:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Aidan Khoury <aidan@aktech.ai>
Cc: qemu-devel@nongnu.org, aidan@revers.engineering,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] i386/cpu: Fix unexpected initializer override in CPU
 model definition for Diamond Rapids
Message-ID: <aXNMWKq7ecx/9CXj@intel.com>
References: <20260113164355.1623966-2-aidan@aktech.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113164355.1623966-2-aidan@aktech.ai>
Received-SPF: pass client-ip=192.198.163.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

(Cc Maintainer Paolo)

On Tue, Jan 13, 2026 at 12:43:56PM -0400, Aidan Khoury wrote:
> Date: Tue, 13 Jan 2026 12:43:56 -0400
> From: Aidan Khoury <aidan@aktech.ai>
> Subject: [PATCH] i386/cpu: Fix unexpected initializer override in CPU model
>  definition for Diamond Rapids
> X-Mailer: git-send-email 2.43.0
> 
> The new Diamond Rapids x86 cpu model definition that was added in 7a6dd8bde159 has an unexpected comma in
> the `.features[FEAT_VMX_EXIT_CTLS]` subobject initializer causing the prior initialization to be overridden,
> meaning that `VMX_VM_EXIT_SAVE_DEBUG_CONTROLS | VMX_VM_EXIT_HOST_ADDR_SPACE_SIZE` is not included.
> 
> Fix this by replacing the comma with the missing bitwise OR to properly combine all the flags into a single
> bitmask value.
> 
> Fixes: 7a6dd8bde159 ("i386/cpu: Add CPU model for Diamond Rapids")
> Signed-off-by: Aidan Khoury <aidan@aktech.ai>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you and my bad,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

BTW, just curious, what warning did you meet? I can make some
improvements.

Thanks,
Zhao


