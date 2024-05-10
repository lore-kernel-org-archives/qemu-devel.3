Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D750C25B10
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 12:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5PHc-0003FT-PR; Fri, 10 May 2024 08:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PHW-0003Do-CH
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:23:23 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1s5PHJ-00015z-W2
 for qemu-devel@nongnu.org; Fri, 10 May 2024 08:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715343790; x=1746879790;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=BMfNUCLvwufURjzLTTi66ysMSXRFSXPXdkm4Gvullis=;
 b=cK1iC+JsKkjtozxuQJuVIK96WHdoh+yPmuX9vRb4gpDALAUGW4ERQF6+
 hUgsZEzduhbqahAP/zJCpq9Z+Vk10qLrev/SD6EAPTBSY8a6RXlUmFR5i
 gjnoFCVw8I5EfOdaTwKtfu7A2ceLPSzgj/0E3daDb/Ajg8lmVjTrak22g
 PVmy830+/Ad+zyl2upLCKvdDotuFUQsZRkCuyf7LcbgNKU/nDmf0XPAQA
 CFQRfNsN9dGOjPxWZiGEywZRMAvZemwHnuW9SwgZLQF07UHZ9X8y8ykPp
 mhEErc4jPOQY9GiXYzBShHMQW3V/8H0E4dRRcyMUx3xP4aTRPKul64xVE A==;
X-CSE-ConnectionGUID: 0DNRjvGXSNuDFLBf3lQmHg==
X-CSE-MsgGUID: a2Cgx4A6TBijPgq/1PFssQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="14273150"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="14273150"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2024 05:23:07 -0700
X-CSE-ConnectionGUID: QA5Y55NEQsmP8hxEJRaIow==
X-CSE-MsgGUID: drgU6KnVQxeQvDzGyU7tkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; d="scan'208";a="29562244"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa007.fm.intel.com with ESMTP; 10 May 2024 05:23:06 -0700
Date: Fri, 10 May 2024 20:37:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Subject: Re: [PATCH 11/13] hw/i386: move rtc-reset-reinjection command out of
 hw/rtc
Message-ID: <Zj4U/7U5iQKATpIV@intel.com>
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-12-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240509170044.190795-12-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.13; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.586,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, May 09, 2024 at 07:00:42PM +0200, Paolo Bonzini wrote:
> Date: Thu,  9 May 2024 19:00:42 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 11/13] hw/i386: move rtc-reset-reinjection command out of
>  hw/rtc
> X-Mailer: git-send-email 2.45.0
> 
> The rtc-reset-reinjection QMP command is specific to x86, other boards do not
> have the ACK tracking functionality that is needed for RTC interrupt
> reinjection.  Therefore the QMP command is only included in x86, but
> qmp_rtc_reset_reinjection() is implemented by hw/rtc/mc146818rtc.c
> and requires tracking of all created RTC devices.  Move the implementation
> to hw/i386, so that 1) it is available even if no RTC device exist
> 2) the only RTC that exists is easily found in x86ms->rtc.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/hw/rtc/mc146818rtc.h |  2 +-
>  hw/i386/monitor.c            | 46 ++++++++++++++++++++++++++++++++++++
>  hw/rtc/mc146818rtc.c         | 12 ++--------
>  hw/i386/meson.build          |  1 +
>  4 files changed, 50 insertions(+), 11 deletions(-)
>  create mode 100644 hw/i386/monitor.c

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


