Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79613C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadeB-0005di-HH; Wed, 22 Jan 2025 11:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taddz-0005ZM-0t; Wed, 22 Jan 2025 11:31:59 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1taddt-0006Zz-4n; Wed, 22 Jan 2025 11:31:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737563509; x=1769099509;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=W0CEBDItbQycNDfZ7B7OcSu3dB5zqUDBtqxse3ndIY0=;
 b=RME/J/SDft4wlCbbou3lMO5md6HEx8YiK+aLlPXU6jlYtS9zdwphnSxp
 UfjffPnTMks6IuyvH2oV7zo6yRvcY5++UJ9Vd3PmsSeiNkfBTUDE29bz7
 RbvEoTK2rt4DqILqxST4HlFUtnfG3NF1/kpuzi14iIWx2CoCaVl1EogfM
 rFGbMINWRjz06CbMTuHh6KboXCzLxn0mFzJnTz8ZgV7TV9+On/i93YjdZ
 ebB2p8m3DeGhqWlf9AAF+SJJeD9dyks5nVg3CP+QZXytxs8G4xO00HduB
 iQ5yeyJ1DGfoz6yaqPnIDCIvHiFJFppo7bGfHo6yIy9LM/0Z/OZ5J5g+M A==;
X-CSE-ConnectionGUID: uKznSBkCQv+v2aD1YU0iGg==
X-CSE-MsgGUID: 8Kc+VPjKS4+Y5h8kbdn3VQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="48624788"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="48624788"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 08:31:20 -0800
X-CSE-ConnectionGUID: sPifOw+7RUiC8+5H83MOoQ==
X-CSE-MsgGUID: ykdb5zhISSWtqndLz07VzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="107631399"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa007.jf.intel.com with ESMTP; 22 Jan 2025 08:31:19 -0800
Date: Thu, 23 Jan 2025 00:50:41 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 05/10] rust: pl011: pull interrupt updates out of
 read/write ops
Message-ID: <Z5Eh4Yj2Mp+xQV5Z@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

On Fri, Jan 17, 2025 at 10:26:52AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:52 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/10] rust: pl011: pull interrupt updates out of
>  read/write ops
> X-Mailer: git-send-email 2.47.1
> 
> qemu_irqs are not part of the vmstate, therefore they will remain in
> PL011State.  Update them if needed after regs_read()/regs_write().
> 
> Apply #[must_use] to functions that return whether the interrupt state
> could have changed, so that it's harder to forget the call to update().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 68 ++++++++++++++++++--------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 

[snip]

>  
>      pub fn event(&mut self, event: QEMUChrEvent) {
>          if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
> -            self.put_fifo(registers::Data::BREAK.into());
> +            let update = self.put_fifo(registers::Data::BREAK.into());

We can omit this `update` variable.

> +            if update {
> +                self.update();
> +            }
>          }
>      }

Nice refactoring!

Reviewed-by: Zhao Liu <zhao.liu@intel.com>


