Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821A7E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 07:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKuLG-00069J-Sw; Tue, 10 Dec 2024 02:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKuLF-000696-LB; Tue, 10 Dec 2024 02:07:33 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tKuLD-0001zU-Qy; Tue, 10 Dec 2024 02:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1733814452; x=1765350452;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=coGPBQhNTHCyJm0nBr/HK99I2IV0DqSM0ggVJlMIn3Y=;
 b=fAULgLKQybv5fka8AZ0lUQjfhO5awcIAYKetlBKJhwtv94iqB2qioe7o
 g99OMDPbNYABs1mSdr4J7F32Gah8SBXt5MoAxq8dLrAhcCB4UEzQyTRa1
 AMSzdLvya0/F0pwfjQ9LfSviBXpiTale0qyBSRRFLZo7MZIKQ+z+accmf
 Y2qs1AS/ZRPPOBIi2UK8uIVlbEnf2VzjSLdQWbXgkBkGg01AUORbyO5Ge
 VwV+YeR9BU2v/3MICv5GjfCtSef9m6ohz+P4e/Hsl7ov0WoVokc6qR0+C
 qVko+LEbuoFnE0GJtLU93WDKGtFFthAqVHvRd85WIuSvq58KWv/mNkTB7 A==;
X-CSE-ConnectionGUID: kTafMvscTcS8+VevhvdqIw==
X-CSE-MsgGUID: 9uYlZaZdQpiT18s2nWvYOg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="37928440"
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="37928440"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 23:07:29 -0800
X-CSE-ConnectionGUID: EyyqTZqBQJmK3iY8NCQOmw==
X-CSE-MsgGUID: Ac/MUlC1QH+egoWhY/Yz6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,221,1728975600"; d="scan'208";a="100124858"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa004.fm.intel.com with ESMTP; 09 Dec 2024 23:07:28 -0800
Date: Tue, 10 Dec 2024 15:25:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Junjie Mao <junjie.mao@hotmail.com>
Subject: Re: [PATCH 05/26] rust: add bindings for interrupt sources
Message-ID: <Z1fs9lmj+rU8qeYW@intel.com>
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-6-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209123717.99077-6-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.14; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
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

On Mon, Dec 09, 2024 at 01:36:56PM +0100, Paolo Bonzini wrote:
> Date: Mon,  9 Dec 2024 13:36:56 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 05/26] rust: add bindings for interrupt sources
> X-Mailer: git-send-email 2.47.1
> 
> The InterruptSource bindings let us call qemu_set_irq() and sysbus_init_irq()
> as safe code.
> 
> Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
> They are QOM link properties and can be written to outside the control
> of the device (i.e. from a shared reference); therefore they must be
> interior-mutable in Rust.  Since thread-safety is provided by the BQL,
> what we want here is the newly-introduced BqlCell.  A pointer to the
> contents of the BqlCell (an IRQState**, or equivalently qemu_irq*)
> is then passed to the C sysbus_init_irq function.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 22 ++++----
>  rust/qemu-api/meson.build        |  2 +
>  rust/qemu-api/src/irq.rs         | 91 ++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs         |  2 +
>  rust/qemu-api/src/sysbus.rs      | 27 ++++++++++
>  5 files changed, 134 insertions(+), 10 deletions(-)
>  create mode 100644 rust/qemu-api/src/irq.rs
>  create mode 100644 rust/qemu-api/src/sysbus.rs
> 

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


