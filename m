Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CFF5E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 06:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOAVC-0006le-10; Thu, 19 Dec 2024 01:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOAVA-0006l0-39; Thu, 19 Dec 2024 01:59:16 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tOAV8-0005IP-52; Thu, 19 Dec 2024 01:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734591554; x=1766127554;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=VaXttkF8EVBqFeyXTg6CWMny5d8W+6UWMMLUW+gPnPk=;
 b=NAQk+/m4rcggc5f6OMg8cIEGYz2dIbDz3pvtTFwx4yp4iO3LSUuJv2IJ
 hdjKozGd02utBeIiCILFA6HtIjwJMR9xXn29JVAHMHRqmeeiECJez28QJ
 8X7+22G5GKaX212nJeA9Q9wlpKtGjkpQQjFcvNII51n74ZsVok9uRgZSV
 QkLyVZlO4dbrJrgoBoBcyU0YquGAS8Atf0uZO9MrNAVS+WbA4QiehBCc9
 Uurn0HrXQ4ZHigVr0hbmBBjbJvSwzS6c9iMv0kgV6LlZmrq/KqCpRKUvU
 PCPAWAAI14rhfcT5M/UYjMcO+FnoVZzDICfeOKKQqrwFUWXyhWphMSbBJ A==;
X-CSE-ConnectionGUID: sX6mVR5YQT6HjL+pTO8Pig==
X-CSE-MsgGUID: biti/0YHSS2SNFCKa5+OBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52498513"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="52498513"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 22:59:11 -0800
X-CSE-ConnectionGUID: /+sMp4nFRxOCC4U182JR7A==
X-CSE-MsgGUID: c8HbErRiS/yNGGkJt8+Ubw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; d="scan'208";a="98510657"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 18 Dec 2024 22:59:10 -0800
Date: Thu, 19 Dec 2024 15:17:49 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 4/7] rust: pl011: fix break errors and definition of Data
 struct
Message-ID: <Z2PInQy1ag4szr5H@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.10; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 12, 2024 at 06:22:01PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:22:01 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/7] rust: pl011: fix break errors and definition of Data
>  struct
> X-Mailer: git-send-email 2.47.1
> 
> The Data struct is wrong, and does not show how bits 8-15 of DR
> are the receive status.  Fix it, and use it to fix break
> errors ("c >> 8" in the C code does not translate to
> "c.to_be_bytes()[3]").
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 15 ++++++------
>  rust/hw/char/pl011/src/lib.rs    | 41 ++++++++++++++++++++++----------
>  2 files changed, 36 insertions(+), 20 deletions(-)

>      impl ReceiveStatusErrorClear {
> +        pub fn set_from_data(&mut self, data: Data) {
> +            self.set_errors(data.errors());
> +        }
> +

This is the clear and clever way.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


