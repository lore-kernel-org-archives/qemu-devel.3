Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3DAC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 05:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tapks-00073g-Sx; Thu, 23 Jan 2025 00:27:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tapkr-00073M-Jh; Thu, 23 Jan 2025 00:27:49 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tapko-00088P-MB; Thu, 23 Jan 2025 00:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737610066; x=1769146066;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=optQFQz1CJMuMjQWM0NAieY4JkXW8d3R9zhYxjteByQ=;
 b=JpKQPlWk1iIQ3DMhSD6uADF7uO/oAsRJhYnIzsB6o7Y4EiFyqK2CBfDE
 8aJIM380iQTMaQ1kQAG6F/rJiueeBY78EYSPBfHJrsKHhTvYfB8GfZFhK
 ap+wTyEr8edCyQQiw8tn/06q1S0cGU1W5I7qXaxvqA/oPbahsN6FpdL5c
 GACBOYCMKm/vZf9G15uKp9Ez2UfzO4gGGEHgam32Wv6jUgi684zOGNfDu
 GRkskrvkr5oCRoLbu1WL/LA/LIIx0dLjT6gp/lFmcBF/ggBO3rmWomoZe
 tLP8UoHl+2ZfnjiStsz4asVGLcLqhVd0G0iMUoomt0aV6N4duDpMiJned w==;
X-CSE-ConnectionGUID: iWlfA+VQS+21d80caNfMUA==
X-CSE-MsgGUID: Qa8+W8kzSg+hUhj1BKm21Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="49510040"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="49510040"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2025 21:27:43 -0800
X-CSE-ConnectionGUID: z8mAUNI3TcutsSOngWQ/eg==
X-CSE-MsgGUID: fs3D5cnwTfmHM89oENZPjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; d="scan'208";a="107167348"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa009.jf.intel.com with ESMTP; 22 Jan 2025 21:27:42 -0800
Date: Thu, 23 Jan 2025 13:47:04 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 07/10] rust: pl011: wrap registers with BqlRefCell
Message-ID: <Z5HX2G0+bt+3vzVB@intel.com>
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117092657.1051233-8-pbonzini@redhat.com>
Received-SPF: pass client-ip=192.198.163.10; envelope-from=zhao1.liu@intel.com;
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

On Fri, Jan 17, 2025 at 10:26:54AM +0100, Paolo Bonzini wrote:
> Date: Fri, 17 Jan 2025 10:26:54 +0100
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 07/10] rust: pl011: wrap registers with BqlRefCell
> X-Mailer: git-send-email 2.47.1
> 
> This is a step towards making memory ops use a shared reference to the
> device type; it's not yet possible due to the calls to character device
> functions.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/hw/char/pl011/src/device.rs       | 38 +++++++++++++-------------
>  rust/hw/char/pl011/src/device_class.rs |  8 +++---
>  rust/hw/char/pl011/src/memory_ops.rs   |  2 +-
>  3 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
> index 476abe765a9..1d3da59e481 100644
> --- a/rust/hw/char/pl011/src/device.rs
> +++ b/rust/hw/char/pl011/src/device.rs
> @@ -102,14 +102,14 @@ pub struct PL011Registers {
>  }
>  
>  #[repr(C)]
> -#[derive(Debug, qemu_api_macros::Object, qemu_api_macros::offsets)]

This is the issue I also met, so why not drive "Debug" for BqlRefCell?

I tried to do this in [*]. Do we need to reconsider this?

[*]: https://lore.kernel.org/qemu-devel/20241205060714.256270-3-zhao1.liu@intel.com/

> +#[derive(qemu_api_macros::Object, qemu_api_macros::offsets)]
>  /// PL011 Device Model in QEMU
>  pub struct PL011State {
>      pub parent_obj: ParentField<SysBusDevice>,
>      pub iomem: MemoryRegion,
>      #[doc(alias = "chr")]
>      pub char_backend: CharBackend,
> -    pub regs: PL011Registers,
> +    pub regs: BqlRefCell<PL011Registers>,

This is a good example on the usage of BqlRefCell!

//! `BqlRefCell` is best suited for data that is primarily accessed by the
//! device's own methods, where multiple reads and writes can be grouped within
//! a single borrow and a mutable reference can be passed around. "

>      /// QEMU interrupts
>      ///
>      /// ```text
> @@ -530,8 +530,8 @@ fn post_init(&self) {
>          }
>      }
>  
> +    #[allow(clippy::needless_pass_by_ref_mut)]

How did you trigger this lint error? I switched to 1.84 and didn't get
any errors (I noticed that 1.84 fixed the issue of ignoring `self` [*],
but it still doesn't seem to work on my side).

[*]: https://github.com/rust-lang/rust-clippy/pull/12693

>      pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
> -        let regs = &mut self.regs;
>          match RegisterOffset::try_from(offset) {
>              Err(v) if (0x3f8..0x400).contains(&(v >> 2)) => {
>                  let device_id = self.get_class().device_id;
> @@ -541,7 +541,7 @@ pub fn read(&mut self, offset: hwaddr, _size: u32) -> ControlFlow<u64, u64> {
>                  // qemu_log_mask(LOG_GUEST_ERROR, "pl011_read: Bad offset 0x%x\n", (int)offset);
>                  ControlFlow::Break(0)
>              }
> -            Ok(field) => match regs.read(field) {
> +            Ok(field) => match self.regs.borrow_mut().read(field) {
>                  ControlFlow::Break(value) => ControlFlow::Break(value.into()),
>                  ControlFlow::Continue(value) => {
>                      self.update();

[snip]

> @@ -603,19 +603,19 @@ pub fn realize(&mut self) {
>      }
>  
>      pub fn reset(&mut self) {

In principle, this place should also trigger `needless_pass_by_ref_mut`.

> -        self.regs.reset();
> +        self.regs.borrow_mut().reset();
>      }

[snip]

> @@ -657,10 +657,10 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
>  pub unsafe extern "C" fn pl011_receive(opaque: *mut c_void, buf: *const u8, size: c_int) {
>      unsafe {
>          debug_assert!(!opaque.is_null());
> -        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
> +        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());

Perhaps we can use NonNull::new and unwrap()? Then debug_assert! is
unnecessary.

let state = unsafe { NonNull::new(opaque.cast::<PL011State>()).unwrap().as_ref() };

>          if size > 0 {
>              debug_assert!(!buf.is_null());
> -            state.as_mut().receive(u32::from(buf.read_volatile()));
> +            state.as_ref().receive(u32::from(buf.read_volatile()));
>          }
>      }
>  }
> @@ -673,8 +673,8 @@ pub fn post_load(&mut self, _version_id: u32) -> Result<(), ()> {
>  pub unsafe extern "C" fn pl011_event(opaque: *mut c_void, event: QEMUChrEvent) {
>      unsafe {

I think we could narrow the unsafe scope next.

>          debug_assert!(!opaque.is_null());
> -        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
> -        state.as_mut().event(event)
> +        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
> +        state.as_ref().event(event)
>      }
>  }
  
[snip]

> diff --git a/rust/hw/char/pl011/src/memory_ops.rs b/rust/hw/char/pl011/src/memory_ops.rs
> index c4e8599ba43..8f66c8d492c 100644
> --- a/rust/hw/char/pl011/src/memory_ops.rs
> +++ b/rust/hw/char/pl011/src/memory_ops.rs
> @@ -26,7 +26,7 @@
>  unsafe extern "C" fn pl011_read(opaque: *mut c_void, addr: hwaddr, size: c_uint) -> u64 {
>      assert!(!opaque.is_null());
>      let mut state = unsafe { NonNull::new_unchecked(opaque.cast::<PL011State>()) };
> -    let val = unsafe { state.as_mut().read(addr, size) };
> +    let val = unsafe { state.as_mut() }.read(addr, size);

Nice cleanup.

>      match val {
>          std::ops::ControlFlow::Break(val) => val,
>          std::ops::ControlFlow::Continue(val) => {
> -- 

Nice transition! This is an important step. (Even my comments above
didn't affect the main work of the patch :-) )

So,

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>



