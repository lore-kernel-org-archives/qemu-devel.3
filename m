Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9824BCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8Z-0002Cn-5G; Sat, 30 Aug 2025 11:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urtWO-00059E-3x
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:27:40 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1urtWJ-0001UN-05
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 03:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756452455; x=1787988455;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Pc/dPQ459IqwCahzHXFvqDdvdMe5WtGmeTDxhph0vPE=;
 b=LSmMsvMrkZwhImQXG2rHyRYT6ru0O6ajbUL1vk2f94rDNV3K7ld3jhA9
 oUMcgtaXRYrkHoieVIKYhbf+dFC94tR6IB3X9ahuRk1krcwDKrDl0W3Rd
 1BKihnMqArvM/U4zI3ZLpPnvmAzLPDq6Nlj1uM2MAsiVTo5z9dxcRICv8
 xyzFEWoHQN5BnIW6w+t8fmYU0s9xPwzOFKWp2wVy7osTa2e/CELFH8OhB
 m03e8DzJ0qCAksc5pvLnmo2m2vWCcCXKShuVOw3r8kzDxMdHvoyalIl1r
 w1TXecP1vxFoXW67Gco53Z7ecL92OxntyZftAzWlUAQ3xaLsIsvzP6nEp w==;
X-CSE-ConnectionGUID: x/91oYqfS7qQeJqBHrmQyA==
X-CSE-MsgGUID: A1COGfueSpuz35s0sMyaqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62379824"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="62379824"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Aug 2025 00:27:27 -0700
X-CSE-ConnectionGUID: X5FYqx+IQpOInZxaJVvyjQ==
X-CSE-MsgGUID: g0Q3RUDAQySQHvKQt50Hqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; d="scan'208";a="193976134"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa002.fm.intel.com with ESMTP; 29 Aug 2025 00:27:25 -0700
Date: Fri, 29 Aug 2025 15:49:12 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mtosatti@redhat.com,
 kvm@vger.kernel.org, aharivel@redhat.com
Subject: Re: [PATCH 1/2] i386/kvm/vmsr_energy: Plug memory leak on failure to
 connect socket
Message-ID: <aLFbeCthx53qkq8e@intel.com>
References: <20250723133257.1497640-1-armbru@redhat.com>
 <20250723133257.1497640-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723133257.1497640-2-armbru@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
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

On Wed, Jul 23, 2025 at 03:32:56PM +0200, Markus Armbruster wrote:
> Date: Wed, 23 Jul 2025 15:32:56 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH 1/2] i386/kvm/vmsr_energy: Plug memory leak on failure to
>  connect socket
> 
> vmsr_open_socket() leaks the Error set by
> qio_channel_socket_connect_sync().  Plug the leak by not creating the
> Error.
> 
> Fixes: 0418f90809ae (Add support for RAPL MSRs in KVM/Qemu)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  target/i386/kvm/vmsr_energy.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


