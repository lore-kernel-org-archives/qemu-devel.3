Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647E4C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 14:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thUVB-0006Ur-8X; Mon, 10 Feb 2025 09:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUV3-0006Sx-V7; Mon, 10 Feb 2025 09:11:05 -0500
Received: from mgamail.intel.com ([198.175.65.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1thUV1-0004qK-J2; Mon, 10 Feb 2025 09:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1739196660; x=1770732660;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Dl0ZWBsR1/HSCOhMTXqjWRBpm2e6iP4RBwyicQrCF/A=;
 b=OgjzTGcxmc/eTFqJgO6jGZ3q5k9lco293hBoOnVBmytF/cXP5h47IuP7
 1GgI0ioHs+WjzqAcaqon7YZZEqrQ11SwTQzcktXzgDEcJL+XUTjatFtAL
 20P1bSBpbcQzgj7zYSEH6iq6m5PoDg1IWAezB0aG0Q64zBq7qjJCJR4zz
 1DivholO52JbhxwXf8/XcZc+ibsyBNJGQp/dkKMBAhptb6/erQCquPsGG
 4PZur8CIxge0HUK1irbOWUiFNn1QR+97F5WbzZ1dZjre3F6FUbEXQm2bf
 mEvEv3grkUnmCw/8see807Ynlwsq2xbUi2LCW4XSxrigc15BZVYu2YDi6 A==;
X-CSE-ConnectionGUID: UMfm4CW/RGum0FSYqKlUaw==
X-CSE-MsgGUID: pMpjtVjDSweyd0Rl9NNsiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50010018"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; d="scan'208";a="50010018"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2025 06:10:57 -0800
X-CSE-ConnectionGUID: EDxs6woCSrKfJxIIHvx4iA==
X-CSE-MsgGUID: ZgbMYkR0QLOARRgo62pN3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="117128900"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2025 06:10:56 -0800
Date: Mon, 10 Feb 2025 22:30:26 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/12] rust: qom: add object creation functionality
Message-ID: <Z6oNgks2bNDRrIIz@intel.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
 <20250207101623.2443552-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207101623.2443552-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.388,
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

On Fri, Feb 07, 2025 at 11:16:13AM +0100, Paolo Bonzini wrote:
> Date: Fri,  7 Feb 2025 11:16:13 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 02/12] rust: qom: add object creation functionality
> X-Mailer: git-send-email 2.48.1
> 
> The basic object lifecycle test can now be implemented using safe code!
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 23 +++++++++++++----------
>  rust/qemu-api/src/prelude.rs     |  1 +
>  rust/qemu-api/src/qom.rs         | 23 +++++++++++++++++++++--
>  rust/qemu-api/tests/tests.rs     | 30 +++++++++++-------------------
>  4 files changed, 46 insertions(+), 31 deletions(-)
>

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


