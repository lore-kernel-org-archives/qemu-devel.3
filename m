Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FBAC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 14:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tabVX-0007FL-Pl; Wed, 22 Jan 2025 09:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tabVM-0007EY-D6; Wed, 22 Jan 2025 09:14:54 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tabVI-0000KD-0F; Wed, 22 Jan 2025 09:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737555288; x=1769091288;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=4XkzYjEnxy/zWhUwK1HhvVt/+RjVEjrPXsIrPO1Wp70=;
 b=KdgN4V1OVAKgRvoL5eQ9SySrIWH0mW602L5gtFgMwxD4wers406BE/N/
 GKOaLWOUKJSaFBZ8BviB1SEIk0adjoqDKBNlxOOHMHWt4K/1d7D8hTeTZ
 BByrAXPVm/UcOpmXxFa+MBfxtHeK7sFzPl7PmVpoz0j18fx8VtoHef164
 d5usjG2axydyGL0LR2sVNwMAimBWt+evQD2R0Jj97OEaHP59EPnNA+77Q
 y1KWL05YjmNkyDL8YXYbVTSMN89TvrNqn4JtZthGV3FSFa/1tGG4JdCVN
 hRQXFAfwDeyhL5obJ1nfneg50J+YXpUx54mymhFjJlu4j2qFyFP2jZW9w w==;
X-CSE-ConnectionGUID: YB08vuguR3moz3MCf0b70w==
X-CSE-MsgGUID: 1TBSVX9cRs2YyT24VAGjhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="60481649"
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="60481649"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 06:14:44 -0800
X-CSE-ConnectionGUID: N/9jOM56Smetn/r1qf3CIg==
X-CSE-MsgGUID: rnsDzu+sQ1eOZMPTFGme+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,225,1732608000"; d="scan'208";a="112182940"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 22 Jan 2025 06:14:43 -0800
Date: Wed, 22 Jan 2025 22:34:05 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 03/10] rust: pl011: extract conversion to RegisterOffset
Message-ID: <Z5EB3b0VqvqxUaWm@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 17, 2025 at 10:26:50AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:50 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 03/10] rust: pl011: extract conversion to RegisterOffset
> X-Mailer: git-send-email 2.47.1
> 
> As an added bonus, this also makes the new function return u32 instead
> of u64, thus factoring some casts into a single place.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs | 114 +++++++++++++++++--------------
>  1 file changed, 63 insertions(+), 51 deletions(-)

[snip]

> -    pub fn read(&mut self, offset: hwaddr, _size: c_uint) -> std::ops::ControlFlow<u64, u64> {
> +    fn regs_read(&mut self, offset: RegisterOffset) -> ControlFlow<u32, u32> {
>          use RegisterOffset::*;

Can we move this "use" to the start of the file?

IMO, placing it in the local scope appears unnecessary and somewhat
fragmented.

> -        let value = match RegisterOffset::try_from(offset) {
> -            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
> -                let device_id = self.get_class().device_id;
> -                u32::from(device_id[(offset - 0xfe0) >> 2])
> -            }
> -            Err(_) => {
> -                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
> -                0
> -            }
> -            Ok(DR) => {
> +        std::ops::ControlFlow::Break(match offset {

std::ops can be omitted now.

> +            DR => {
>                  self.flags.set_receive_fifo_full(false);
>                  let c = self.read_fifo[self.read_pos];
>                  if self.read_count > 0 {

[snip]

> -    pub fn write(&mut self, offset: hwaddr, value: u64) {
> +    fn regs_write(&mut self, offset: RegisterOffset, value: u32) {
>          // eprintln!("write offset {offset} value {value}");
>          use RegisterOffset::*;
> -        let value: u32 = value as u32;
> -        match RegisterOffset::try_from(offset) {
> -            Err(_bad_offset) => {
> -                eprintln!("write bad offset {offset} value {value}");
> -            }
> -            Ok(DR) => {
> +        match offset {
> +            DR => {
>                  // ??? Check if transmitter is enabled.
>                  let ch: u8 = value as u8;
>                  // XXX this blocks entire thread. Rewrite to use
> @@ -290,22 +277,22 @@ pub fn write(&mut self, offset: hwaddr, value: u64) {
>                  self.int_level |= registers::INT_TX;
>                  self.update();
>              }
> -            Ok(RSR) => {
> -                self.receive_status_error_clear.reset();
> +            RSR => {
> +                self.receive_status_error_clear = 0.into();

Emm, why do we use 0.into() instead of reset() here? It looks they're
same.

[snip]

> @@ -562,6 +549,31 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
>  
>          Ok(())
>      }
> +
> +    pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {

Maybe pub(crate)? But both are fine for me :-)

> +        match RegisterOffset::try_from(offset) {
> +            Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
> +                let device_id = self.get_class().device_id;
> +                ControlFlow::Break(u64::from(device_id[(offset - 0xfe0) >> 2]))
> +            }
> +            Err(_) => {
> +                // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
> +                ControlFlow::Break(0)
> +            }
> +            Ok(field) => match self.regs_read(field) {
> +                ControlFlow::Break(value) => ControlFlow::Break(value.into()),
> +                ControlFlow::Continue(value) => ControlFlow::Continue(value.into()),
> +            }
> +        }
> +    }
> +

Look good to me,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>


