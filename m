Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C8ACEDD86
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 13:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLLp7-0003WW-Ce; Tue, 18 Nov 2025 08:32:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLLp3-0003UC-4J; Tue, 18 Nov 2025 08:32:41 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1vLLoz-0007XL-FX; Tue, 18 Nov 2025 08:32:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763472758; x=1795008758;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=L+JSarzF7sKmTXc+TZOqxikZUGWBSZQTkNsnoJg2wKQ=;
 b=N9TlNUuUTO26WLeAsdcpcbAh9IRO42dyFSy+tC4ODh+zmVWVbJROgdyI
 k204u9FtjdxmDdKuVte7ISTUuOlbdKeT5dzrcdykkDm1H3Py/ANGkqD5/
 DqxV2ZMXHMVr4EGM0J9smC/jsT++PF+fpKnTy2Z+EXCNVnZHqvOm/53SH
 XrWk6nd1F9kB9d7aHrUlAbILju/U1GrVAnYOuvBNtXzcOYcYAeqvcuO2L
 RZR+k0niRNeW8KWOpiTUkT8+MsRffsnEbEXilM8P+X9e7N8EHwkX8sTv9
 6YmKNdHrTrYKXwdgNxn3nATMNrX54B+9RvD+z+eR9guw9AAQ+hT1nFTR5 g==;
X-CSE-ConnectionGUID: x+4pQZdtRMqHEtD6wY/eVQ==
X-CSE-MsgGUID: ftsWssmLRICikMQeY3Lg2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="76595822"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="76595822"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 05:32:24 -0800
X-CSE-ConnectionGUID: /R4elfTlRWSYpSL1ufl+dg==
X-CSE-MsgGUID: LuRXDS+BSQidQAuTB7G+oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="191533474"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 18 Nov 2025 05:32:23 -0800
Date: Tue, 18 Nov 2025 21:54:42 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/5] rust/hpet: move hpet_offset to HPETRegisters
Message-ID: <aRx6orZnNELKYPsE@intel.com>
References: <20251117084752.203219-1-pbonzini@redhat.com>
 <20251117084752.203219-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117084752.203219-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.13; envelope-from=zhao1.liu@intel.com;
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

On Mon, Nov 17, 2025 at 09:47:49AM +0100, Paolo Bonzini wrote:
> Date: Mon, 17 Nov 2025 09:47:49 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/5] rust/hpet: move hpet_offset to HPETRegisters
> X-Mailer: git-send-email 2.51.1
> 
> Likewise, do not separate hpet_offset from the other registers.
> However, because it is migrated in a subsection it is necessary
> to copy it out of HPETRegisters and into a BqlCell<>.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/timer/hpet/src/device.rs | 63 ++++++++++++++++++--------------
>  1 file changed, 35 insertions(+), 28 deletions(-)

,,,

> +        let mut next_tick: u64 = tn_regs.cmp64;
>          if tn_regs.is_32bit_mod() {
>              // HPET spec says in one-shot 32-bit mode, generate an interrupt when
>              // counter wraps in addition to an interrupt with comparator match.
>              if !tn_regs.is_periodic() && tn_regs.cmp64 > hpet_next_wrap(cur_tick) {
>                  tn_regs.wrap_flag = 1;
> -                self.arm_timer(tn_regs, hpet_next_wrap(cur_tick));
> -                return;
> +                next_tick = hpet_next_wrap(cur_tick);
>              }
>          }
> -        self.arm_timer(tn_regs, tn_regs.cmp64);
> +        self.arm_timer(regs, next_tick);
>      }

Good! This saves a arm_timer().

...

>  impl HPETRegisters {
> +    fn get_ticks(&self) -> u64 {
> +        // Protect hpet_offset in lockless IO case which would not lock BQL.

Just nit, this comment seems not much necessary, since currently there's
no Mutex lock to represent "Protect". But it's up to you to keep it or
not.

> +        ns_to_ticks(CLOCK_VIRTUAL.get_ns() + self.hpet_offset)
> +    }
> +
> +    fn get_ns(&self, tick: u64) -> u64 {
> +        // Protect hpet_offset in lockless IO case which would not lock BQL.

Ditto.

> +        ticks_to_ns(tick) - self.hpet_offset
> +    }

LGTM,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


