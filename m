Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C039CC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 10:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcM6r-0005ag-1O; Mon, 27 Jan 2025 05:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcM6k-0005aE-54; Mon, 27 Jan 2025 05:12:43 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcM6i-0000f4-4R; Mon, 27 Jan 2025 05:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737972760; x=1769508760;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=iu57v9/ANTE0Gzuc/7drSyoftYkaLDydCoSoFawrCkw=;
 b=ChQUDCy1tV6srqmz8Z/WiPdzzlHUefKbYY+7OoeX9TbDJDuVrmvzulR7
 j8PMTqS+SRAfsFM2Eq1jpmesIeUfLZmQD/he5Vr6z+v2DIyG1el1iPdwU
 Do0bd1/qBovdJtp++WvbOyBB3ujoWHMM0khMpTtcu9i3ypVKL/B9EfWVA
 Aoh+QlXUlW+tIlPDsn0d5iqPQzsEGfx3pzwPfx7xeWDY8Rd3WeJr/mhXy
 4mrmQcHlp4O5Aa2tubJrAHS97Fmt7yqNeOPIxDGn535Jbc5D/E9TvJYhi
 R6ZSNO+T+7fFVd1kJRL9Doy5Nc/g2WElnnYA2uI3GbQiEJR1xqfq7EgFb w==;
X-CSE-ConnectionGUID: If4+ovKSS/WDnG/IbG2MJg==
X-CSE-MsgGUID: SXulBOq5SSeqm78LTt8hnA==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="42088843"
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="42088843"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2025 02:12:36 -0800
X-CSE-ConnectionGUID: 7+DXXvz4T2akgpNeuEQYTQ==
X-CSE-MsgGUID: Xkycg4MtQ4iPnFO5RN4zdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,238,1732608000"; d="scan'208";a="108982137"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa009.fm.intel.com with ESMTP; 27 Jan 2025 02:12:35 -0800
Date: Mon, 27 Jan 2025 18:31:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 08/10] rust: qdev: switch from legacy reset to Resettable
Message-ID: <Z5dgn5MQNGEa5lry@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-9-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-9-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.15; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> +/// Trait providing the contents of [`ResettablePhases`].
> +pub trait ResettablePhasesImpl {
> +    /// If not None, this is called when the object enters reset. It
> +    /// can reset local state of the object, but it must not do anything that
> +    /// has a side-effect on other objects, such as raising or lowering a
> +    /// [`qemu_irq`] line or reading or writing guest memory. It takes the
> +    /// reset's type as argument.
> +    const ENTER: Option<fn(&Self, ResetType)> = None;
> +
> +    /// If not None, this is called when the object for entry into reset, once
> +    /// every object in the system which is being reset has had its
> +    /// @phases.enter method called. At this point devices can do actions

Maybe s/@phases.enter/ResettablePhasesImpl::ENTER/?

> +    /// that affect other objects.
> +    ///
> +    /// If in doubt, implement this method.
> +    const HOLD: Option<fn(&Self, ResetType)> = None;
> +
> +    /// If not None, this phase is called when the object leaves the reset
> +    /// state. Actions affecting other objects are permitted.
> +    const EXIT: Option<fn(&Self, ResetType)> = None;
> +}
> +

...
 
>  impl<T> ClassInitImpl<DeviceClass> for T
>  where
> -    T: ClassInitImpl<ObjectClass> + DeviceImpl,
> +    T: ClassInitImpl<ObjectClass> + ClassInitImpl<ResettableClass> + DeviceImpl,

This constraint requires each device to explicitly implement ResettablePhasesImpl,
even the device doesn't want to do anything for reset.

So what about the following changes:
 * Define 3-Phases methods in DeviceImpl.
 * Implement ResettablePhasesImpl for all devices by passing their 3-Phases
   methods to ResettablePhasesImpl's.

Then device doesn't need to implement this reset trait if unnecessary.

For example:

--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -84,7 +84,7 @@ pub trait ResettablePhasesImpl {
 }

 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl: ObjectImpl + ResettablePhasesImpl {
+pub trait DeviceImpl: ObjectImpl {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
@@ -106,6 +106,18 @@ fn properties() -> &'static [Property] {
     fn vmsd() -> Option<&'static VMStateDescription> {
         None
     }
+
+    const RESET_ENTER: Option<fn(&Self, ResetType)> = None;
+    const RESET_HOLD: Option<fn(&Self, ResetType)> = None;
+    const RESET_EXIT: Option<fn(&Self, ResetType)> = None;
+}
+
+impl<T> ResettablePhasesImpl for T
+where T: DeviceImpl
+{
+    const ENTER: Option<fn(&Self, ResetType)> = T::RESET_ENTER;
+    const HOLD: Option<fn(&Self, ResetType)> = T::RESET_HOLD;
+    const EXIT: Option<fn(&Self, ResetType)> = T::RESET_EXIT;
 }

 /// # Safety

---

Though this way add duplicate methods, it reduces the burden on the
device developer.

Regards,
Zhao

>  {
>      fn class_init(dc: &mut DeviceClass) {
>          if <T as DeviceImpl>::REALIZE.is_some() {
>              dc.realize = Some(rust_realize_fn::<T>);
>          }
> -        if <T as DeviceImpl>::RESET.is_some() {
> -            unsafe {
> -                bindings::device_class_set_legacy_reset(dc, Some(rust_reset_fn::<T>));
> -            }
> -        }
>          if let Some(vmsd) = <T as DeviceImpl>::vmsd() {
>              dc.vmsd = vmsd;
>          }
> @@ -99,6 +162,7 @@ fn class_init(dc: &mut DeviceClass) {
>              }
>          }
>  
> +        ResettableClass::interface_init::<T, DeviceState>(dc);
>          <T as ClassInitImpl<ObjectClass>>::class_init(&mut dc.parent_class);
>      }
>  }

