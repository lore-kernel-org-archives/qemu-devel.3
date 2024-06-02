Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FDAC25B74
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2024 09:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDhIs-0000aA-PH; Sun, 02 Jun 2024 05:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhIr-0000Yj-0v
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:15:01 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1sDhIp-0002Gq-FJ
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 05:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717319699; x=1748855699;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=lXDWBQdHBDJ+a5feWzxDQKGtUxYpdHtT2MhN1u7JNbg=;
 b=Y/uGl3W9DwG45ldnRcbTnIX1lQy/cxkasZhh47xYi07Br9ING72sL8b2
 DZ+SUfWpGztGEhwA3B+iDfuCjvcdHXS2hg9Fg/Dz1/ylJWX6BZrsifVXZ
 5x7rrzHeDelKWEHApKWefa+ZiNUoznwU+W3wccwzen1GtZ/M94Q2hYfO8
 5NZJQnvYEXIQLt2eUHVW5tDpUUdzMfAP8oSnN6sT2H5SfBw1zw3qKlsTK
 u4arOb/YO3E2PrxuxQTqlvNHV56psmxYHVvexXOjHuab1SOvnO+qBqWko
 22g3gzS8k9rbH0t5j9M8tcgnipnErt5bkoyLDis7KN3cIYd/Gm7PyoX/z g==;
X-CSE-ConnectionGUID: KHKvBok+QfOw4Q260hGbjQ==
X-CSE-MsgGUID: JdKH/ZJbSSu0R0jJUZo84w==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="24943241"
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="24943241"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2024 02:14:57 -0700
X-CSE-ConnectionGUID: ArCdT6MGQ8WKdXmlMe02rg==
X-CSE-MsgGUID: pL0A6ekcT9OLenQWp+gIbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,209,1712646000"; d="scan'208";a="41145632"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 02 Jun 2024 02:14:56 -0700
Date: Sun, 2 Jun 2024 17:30:21 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 4/6] host/i386: assume presence of SSE2
Message-ID: <Zlw7rbSUCzIRZoA0@intel.com>
References: <20240531091457.42200-1-pbonzini@redhat.com>
 <20240531091457.42200-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531091457.42200-5-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, May 31, 2024 at 11:14:55AM +0200, Paolo Bonzini wrote:
> Date: Fri, 31 May 2024 11:14:55 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 4/6] host/i386: assume presence of SSE2
> X-Mailer: git-send-email 2.45.1
> 
> QEMU now requires an x86-64-v2 host, which has SSE2.
> Use it freely in buffer_is_zero.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  host/include/i386/host/cpuinfo.h | 1 -
>  util/bufferiszero.c              | 2 +-
>  util/cpuinfo-i386.c              | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


