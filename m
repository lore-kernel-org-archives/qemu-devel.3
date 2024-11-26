Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C171DD3B98B
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 13:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFvbB-0001au-Sf; Tue, 26 Nov 2024 08:27:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFvb4-0001aQ-0x; Tue, 26 Nov 2024 08:27:20 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tFvb2-0006My-4t; Tue, 26 Nov 2024 08:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1732627636; x=1764163636;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=K6XXf+rtqfFri+dEe2QWzluaJwKyzJmpYXmIjSY/3Jg=;
 b=Exj+wOjJvNU5B1HhTWpmKooU7QPL1lHCwaS+1R9xLO4EsPMAku5CYu8B
 BDkFJVHBrfmR6FPSABUGqNZgu51R1zn5EqpLA73XHyMJkrtu/h0t+AAMd
 hONZiMUG6kNy1O71bPdprDJizWrnfUBo2KoXnVae6BDDZzREDVQl6YHA1
 64V5CmzBQwiQIeCAWmgTWS862t7lzj4foKN8j6wE79mLhEKdTnmQ1i+BY
 OrKq2I122WfgLuhaofQHob5tD0PJMtquIqU3SZO4paLJMZGHpfv0JS1nG
 J+n3Xxkf095aWgyKlLUIGZOqYuRrhj03PiknAePjDGpgIv1LL0EZ7V34m A==;
X-CSE-ConnectionGUID: UGzNXBK5RwuwwwPq0E8M7Q==
X-CSE-MsgGUID: kJsveW0rT9eBrf3FsxDjSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11268"; a="43854540"
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="43854540"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2024 05:27:12 -0800
X-CSE-ConnectionGUID: HOAxYzSuTXmuWgxaXBiGfw==
X-CSE-MsgGUID: 6ZoE6FH2TC6vi8C6IXxMtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,186,1728975600"; d="scan'208";a="91233537"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by fmviesa006.fm.intel.com with ESMTP; 26 Nov 2024 05:27:10 -0800
Date: Tue, 26 Nov 2024 21:45:19 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, junjie.mao@hotmail.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/2] rust: add bindings for interrupt sources
Message-ID: <Z0XQ79uYWNUrbmR2@intel.com>
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122074756.282142-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Fri, Nov 22, 2024 at 08:47:56AM +0100, Paolo Bonzini wrote:
> Date: Fri, 22 Nov 2024 08:47:56 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/2] rust: add bindings for interrupt sources
> X-Mailer: git-send-email 2.47.0
> 
> The InterruptSource bindings let us call qemu_set_irq() and sysbus_init_irq()
> as safe code.
> 
> Interrupt sources, qemu_irq in C code, are pointers to IRQState objects.
> They are QOM link properties and can be written to outside the control
> of the device (i.e. from a shared reference); therefore they must be
> interior-mutable in Rust. 

Out of curiosity, are there any examples of this situation?

> Since thread-safety is provided by the BQL,
> what we want here is the newly-introduced BqlCell.  A pointer to the
> contents of the BqlCell (an IRQState**, or equivalently qemu_irq*)
> is then passed to the C sysbus_init_irq function.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 22 ++++++-----
>  rust/qemu-api/meson.build        |  2 +
>  rust/qemu-api/src/irq.rs         | 66 ++++++++++++++++++++++++++++++++
>  rust/qemu-api/src/lib.rs         |  2 +
>  rust/qemu-api/src/sysbus.rs      | 26 +++++++++++++
>  5 files changed, 108 insertions(+), 10 deletions(-)
>  create mode 100644 rust/qemu-api/src/irq.rs
>  create mode 100644 rust/qemu-api/src/sysbus.rs

...

> +    /// Send `level` to the interrupt sink.
> +    pub fn set(&self, level: bool) {
> +        unsafe {
> +            qemu_set_irq(self.0.get(), level.into());
> +        }
> +    }

Regarding the boolean discussion, the c_int/i32->boolean conversion
seems unavoidable if it is changed to a boolean, for example, the
level parameter in qemu_irq_handler is declared to be c_int, and
there is a pattern of setting the level in qemu_irq_handler with the
level irq:
* hpet_handle_legacy_irq
* split_irq_handler
* a9mp_priv_set_irq
...

So it feels like a more direct way to follow the use of c_int or i32?
Inconsistent types for level are always confusing. Maybe we can change
the type of rust after the C version can be standardized to boolean?

> +    pub(crate) const fn as_ptr(&self) -> *mut *mut IRQState {
> +        self.0.as_ptr()
> +    }
> +}
> +
> +impl Default for InterruptSource {
> +    fn default() -> Self {
> +        InterruptSource(BqlCell::new(ptr::null_mut()))
> +    }
> +}
> +

I like this idea and this binding is very useful!

HPET also needs qdev_init_gpio_in() and qdev_init_gpio_out(). 
Should these two safe binding wrappers be implemented as methods of
DeviceState, or just the public functions?

Regards,
Zhao



