Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22A4E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 04:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tO81G-0006Ss-N4; Wed, 18 Dec 2024 23:20:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tO81D-0006Rm-4n; Wed, 18 Dec 2024 23:20:11 -0500
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tO81A-0004Qm-Bb; Wed, 18 Dec 2024 23:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1734582008; x=1766118008;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=GW+o7SVjCakjJZVOrY7tYKoadk03w1Whr5eowl7GwJU=;
 b=H1l4mJ7lXSkWwUujyci6zzBEPECc7tNV9UHwwlXvcMmOiN9TvEnPQSn+
 ahl9R+HUIhw/kbp7IGNXfEPuA612+tmGMpB/vvjfh0Ts2t84wBpLmJdLO
 qVkSB+yoOfkfV7RbV/6jxi/HTWZv88ze3VIWlW4ZENDB1LoUk5+NdWCVe
 zbK+WTUoqQQRD7ujyRYRpTpUY4y5tT+M0lRa4g2639rUg8iXq9WE7ZtYh
 uVRdy6BpuL4kre5SvIqJMYOsxxImrZBEUFlytUavCgoaM5SuXAUmsbKDD
 PbTyOWhJGjO/9Jv9DKprCOmeW1TsLboilE2+6hdL4AnREnbvW9oAXJbFK Q==;
X-CSE-ConnectionGUID: RFtoP65MS0GayF25ByeVyA==
X-CSE-MsgGUID: Kess7Zi9TRS5D02BLwNWsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="45675692"
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; d="scan'208";a="45675692"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Dec 2024 20:20:04 -0800
X-CSE-ConnectionGUID: JKStyo3URxmmN8pYENMW9Q==
X-CSE-MsgGUID: 8qWSfQV/QZqaJz9ulCiF1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="129047781"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa001.fm.intel.com with ESMTP; 18 Dec 2024 20:20:03 -0800
Date: Thu, 19 Dec 2024 12:38:43 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 2/7] rust: pl011: match break logic of C version
Message-ID: <Z2OjU3CdoBFI7xA8@intel.com>
References: <20241212172209.533779-1-pbonzini@redhat.com>
 <20241212172209.533779-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212172209.533779-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.11; envelope-from=zhao1.liu@intel.com;
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

On Thu, Dec 12, 2024 at 06:21:59PM +0100, Paolo Bonzini wrote:
> Date: Thu, 12 Dec 2024 18:21:59 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 2/7] rust: pl011: match break logic of C version
> X-Mailer: git-send-email 2.47.1
> 
> Check loopback_enabled(), not fifo_enabled(), like the C code.
> 
> Also, set_break_error() must not happen until the break is read from
> the FIFO.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Now the logic here matches C version, so

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

But...

> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 41220c99a83..c6a8dbe1af4 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -465,9 +465,8 @@ pub fn can_receive(&self) -> bool {
>      }
>  
>      pub fn event(&mut self, event: QEMUChrEvent) {
> -        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.fifo_enabled() {
> +        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.loopback_enabled() {
>              self.put_fifo(DATA_BREAK);
> -            self.receive_status_error_clear.set_break_error(true);
>          }
>      }
>   

...but when I double-check where to set up the rsr, I realized that the
rust version and the C version seem to be inconsistent?

C:

static uint32_t pl011_read_rxdata(PL011State *s)
{
    ...
    c = s->read_fifo[s->read_pos];
    ...
    s->rsr = c >> 8;
    ...
}

Rust:

    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
        ...
	std::ops::ControlFlow::Break(match RegisterOffset::try_from(offset) {
            ...
	    Ok(DR) => {
                ...
		let c = self.read_fifo[self.read_pos];
                ...
		// Update error bits.
                self.receive_status_error_clear = c.to_be_bytes()[3].into();
                ...
	    }
        ...
    }

`to_be_bytes()` retures a byte array in big-endian byte order [*], so rust
accesses the first 8 bits and C accesses the last 24 bits, am I understanding
this correctly and which one is correct?

IIUC, I guess Rust should uses to_be_bytes()[2].

[*]: https://doc.rust-lang.org/std/primitive.u32.html#method.to_be_bytes

Regards,
Zhao



