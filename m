Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AD6C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 05:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taqFo-0003Eo-RM; Thu, 23 Jan 2025 00:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taqFn-00039e-7a; Thu, 23 Jan 2025 00:59:47 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taqFl-00060Q-H3; Thu, 23 Jan 2025 00:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737611986; x=1769147986;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4RNSsvyIfyI527p9rN4aht97v6yUbBMyqkIAj23NyVc=;
 b=JtEvMYwasm2T/Ymw3Rp/wu2DZ1TkUCilGdq+5sTByr4utzwTvYL/Bze9
 Zl90Q6lwJxBBE9uOlq5jTMB0OIc+NbWQJaW1q7r6oTcaOXgNpD0fzwmq/
 aHo8m/FSRdDvXaosr6ZhgWGgzsdwfai7lFP6ovk/wuO3sX3e3UnMNSnDE
 KEwIAYdwf+fu+FM88hB0kAHYHwKpL6tPW0JO1H97ZZ/5+qoiMPqQ34z9I
 X+lTb1pJ+I9GEzzkHtEpO9v0kKsjFWjDEmckrhPbZlyn4QHpBVW9vGgtw
 zoox0fKT5W2DsqgkW3/+JPa9Dd0HenT3xBnyJeSmSchI5biEfVqwlh9Kb g==;
X-CSE-ConnectionGUID: xyuqskLUTc6xBlgsA1oVGQ==
X-CSE-MsgGUID: te5g/gGMRAuF98A86AEihA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="38126781"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="38126781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 21:59:44 -0800
X-CSE-ConnectionGUID: zAaWcYM9SsWUTPu80laYkQ==
X-CSE-MsgGUID: tddI6TDsTqC/rnt+lgiZAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107792977"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 22 Jan 2025 21:59:42 -0800
Date: Thu, 23 Jan 2025 14:19:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 10/10] rust: qdev: make reset take a shared reference
Message-ID: <Z5HfWANS6cda+fcN@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-11-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 17, 2025 at 10:26:57AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:57 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 10/10] rust: qdev: make reset take a shared reference
> X-Mailer: git-send-email 2.47.1
> 
> Because register reset is within a borrow_mut() call, reset
> does not need anymore a mut reference to the PL011State.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 4 ++--
>  rust/qemu-api/src/qdev.rs        | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


