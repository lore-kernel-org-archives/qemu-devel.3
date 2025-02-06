Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C14C02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 08:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfwzD-0006d2-DV; Thu, 06 Feb 2025 03:11:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfwz9-0006cI-S9; Thu, 06 Feb 2025 03:11:43 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tfwz6-0006Hx-Ik; Thu, 06 Feb 2025 03:11:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738829500; x=1770365500;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=eIKsmD8XMF3SRlYjbfPnHYr7iCfsDZi3y6KpBuE1DuI=;
 b=XQUJvPwYAqRcrRc6jQZyZHfDr133d47lzo1hg4BmDkm+DDByFkzt2Jcc
 ELvGPHHUqjq6YG8rAUSrh+1fKkAid/sj6NmR6UizdSlUnLj472xph4YIM
 fBiQ8E/Q3XIBwCCmid65OU0w6uXJ/PwBLKv+ua456wQPHHacX5NRmSR/V
 39SJU3/lgNb5EvklpnAbI1aDY5wvBXZZ9IAaQHuR3/LxZ9RU9EiXYr5D8
 mQJkn0+UOyp6yyotH2cfX26gnlIjcQgdJMSJBRS3AQ9zjh5h8sxHobx8d
 ow9cIywUGHK6vU+nLQ5gP3SbLE20D0MGq6sqILvd9JFeDKQ0yABiy7VLH w==;
X-CSE-ConnectionGUID: Jy9GtVB9SB6e796Zsa3h1w==
X-CSE-MsgGUID: ryx4qEldS/azrU6Iacl2kQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43176019"
X-IronPort-AV: E=Sophos;i="6.13,263,1732608000"; d="scan'208";a="43176019"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 00:11:35 -0800
X-CSE-ConnectionGUID: 4J2Ad1z6QOm8j/vI0KloWg==
X-CSE-MsgGUID: 6Uqcp3QgTFqGFFiTi4Reow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="115226409"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 06 Feb 2025 00:11:33 -0800
Date: Thu, 6 Feb 2025 16:31:03 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/10] rust: qdev: switch from legacy reset to Resettable
Message-ID: <Z6RzR3oWZdjs6O0n@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 17, 2025 at 08:40:01PM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 20:40:01 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 08/10] rust: qdev: switch from legacy reset to Resettable
> X-Mailer: git-send-email 2.47.1
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  meson.build                      |   1 +
>  rust/hw/char/pl011/src/device.rs |  10 ++-
>  rust/qemu-api/src/qdev.rs        | 116 ++++++++++++++++++++++++-------
>  rust/qemu-api/tests/tests.rs     |   5 +-
>  4 files changed, 102 insertions(+), 30 deletions(-)
>

Add my R/b tag,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


