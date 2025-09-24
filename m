Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE4ACAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 15:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1QyI-000864-7i; Wed, 24 Sep 2025 10:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1QyF-00085F-3j; Wed, 24 Sep 2025 10:59:51 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1v1Qy5-0001NM-VF; Wed, 24 Sep 2025 10:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758725982; x=1790261982;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=rOXY819Wgt9Lpauwown9+ZsR16/omkh1nC1gq7ttzLI=;
 b=dOzyHZb9QJntAOlUBFoDUiwl3eoK64vj8HuCNrXv95byAbL6yAJ1K8LB
 nzhG6Sz+x6If11HI+q+YXSDGVPBQblB26reJ3IHkupuQyC5HEmCSEDOQV
 uS9/bCuXQD/KUymTEya1kTSCGTvMTd56lgzc65WcNG6ZsiJzaV2EOfLrf
 hHmv3ehrZEsWfKL+BtOS4p5k4km5vplaACnC6/+dvRoF1P25HHbIliVSo
 dXwbx7RnBttVbasrRW0rqlwk+6gMj12eEqLs2v6C0W4X+nvGGWLRPOBYh
 BgkboJqDJlm9C0oOQh0fz+vPOft6TpOBnhj0TrO1JIMNNC8Jqp33CI0hD Q==;
X-CSE-ConnectionGUID: Ok/E/4tpQgKA8QH7JLfQHQ==
X-CSE-MsgGUID: 9kzaXrcXTnaZTMj+bc0Xvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="60727627"
X-IronPort-AV: E=Sophos;i="6.18,290,1751266800"; d="scan'208";a="60727627"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2025 07:59:34 -0700
X-CSE-ConnectionGUID: sK3syfCjRqyz8oVm9GRLKQ==
X-CSE-MsgGUID: ieb04+yEQAeiEOdlRoqQsw==
X-ExtLoop1: 1
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 24 Sep 2025 07:59:33 -0700
Date: Wed, 24 Sep 2025 23:21:30 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, manos.pitsidianakis@linaro.org
Subject: Re: [PATCH 3/7] rust: migration: extract vmstate_fields_ref
Message-ID: <aNQMekqSqG7DjmPX@intel.com>
References: <20250920142958.181910-1-pbonzini@redhat.com>
 <20250920142958.181910-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920142958.181910-4-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
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

Hi Paolo,

On Sat, Sep 20, 2025 at 04:29:54PM +0200, Paolo Bonzini wrote:
> Date: Sat, 20 Sep 2025 16:29:54 +0200
> From: Paolo Bonzini <pbonzini@redhat.com>
> Subject: [PATCH 3/7] rust: migration: extract vmstate_fields_ref
> X-Mailer: git-send-email 2.51.0
> 
> This is useful when building a VMState for generic structs, because you have
> to avoid nested statics.  Using vmstate_fields! will fail in the likely case
> where the _FIELDS static uses Self from an outer item, because that is
> forbidden.

vmstate_fields_ref is good for me.

> I also looked into returning a &'static [VMStateField] from vmstate_fields!,
> but that also fails; the fields are not promoted to static, which is
> unfortunate but intentional (https://github.com/rust-lang/rust/issues/60502):
> 
> error[E0716]: temporary value dropped while borrowed
>    --> rust/hw/char/pl011/libpl011.rlib.p/structured/device.rs:743:17
>     |
> 738 | /      VMStateDescriptionBuilder::<PL011State>::new()
> 739 | |          .name(c"pl011/clock")
> 740 | |          .version_id(1)
> 741 | |          .minimum_version_id(1)
> 742 | |          .needed(&PL011State::clock_needed)
> 743 | |          .fields(vmstate_fields! {
>     | | _________________^
> 744 | ||              vmstate_of!(PL011State, clock),
> 745 | ||         })
>     | ||_________^- argument requires that borrow lasts for `'static`
>     |  |_________|
>     |            creates a temporary value which is freed while still in use
> 746 |            .build();
>     |                   - temporary value is freed at the end of this statement

And I'm curious what change caused this error... I guess you're
indicating the following case?

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index c05c4a1fd665..bff6ba502e02 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -417,14 +417,13 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
 #[macro_export]
 macro_rules! vmstate_fields {
     ($($field:expr),*$(,)*) => {{
-        static _FIELDS: &[$crate::bindings::VMStateField] = &[
+        &[
             $($field),*,
             $crate::bindings::VMStateField {
                 flags: $crate::bindings::VMStateFlags::VMS_END,
                 ..::common::zeroable::Zeroable::ZERO
             }
-        ];
-        _FIELDS.as_ptr()
+        ]
     }}
 }

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  rust/migration/src/vmstate.rs | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
> index 05a833a8b7d..421a236194d 100644
> --- a/rust/migration/src/vmstate.rs
> +++ b/rust/migration/src/vmstate.rs
> @@ -413,19 +413,30 @@ const fn phantom__<T>(_: &T) -> ::core::marker::PhantomData<T> {
>      }};
>  }
>  
> +/// Add a terminator to the fields in the arguments, and return
> +/// a reference to the resulting array of values.
> +#[macro_export]
> +macro_rules! vmstate_fields_ref {
> +    ($($field:expr),*$(,)*) => {
> +        &[
> +            $($field),*,
> +            $crate::bindings::VMStateField {
> +                flags: $crate::bindings::VMStateFlags::VMS_END,
> +                ..::common::zeroable::Zeroable::ZERO
> +            }
> +        ]
> +    }
> +}
> +
>  /// Helper macro to declare a list of
>  /// ([`VMStateField`](`crate::bindings::VMStateField`)) into a static and return
>  /// a pointer to the array of values it created.
>  #[macro_export]
>  macro_rules! vmstate_fields {
>      ($($field:expr),*$(,)*) => {{
> -        static _FIELDS: &[$crate::bindings::VMStateField] = &[
> +        static _FIELDS: &[$crate::bindings::VMStateField] = $crate::vmstate_fields_ref!(
>              $($field),*,
> -            $crate::bindings::VMStateField {
> -                flags: $crate::bindings::VMStateFlags::VMS_END,
> -                ..::common::zeroable::Zeroable::ZERO
> -            }
> -        ];
> +        );
>          _FIELDS.as_ptr()

Considerring the idea about returing &'static [VMStateField], I think at
least we could return `_FIELDS.as_ptr()` directly from vmstate_fields!,
and convert &'static [VMStateField] to *const [VMStateField] in
fields(), just like subsections() did.

Thanks,
Zhao

>      }}
>  }
> -- 
> 2.51.0
> 

