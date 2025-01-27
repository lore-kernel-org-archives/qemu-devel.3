Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CA6C0218C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 07:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcJho-00018Z-Ky; Mon, 27 Jan 2025 02:38:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcJhb-00017a-6Q; Mon, 27 Jan 2025 02:38:35 -0500
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tcJhZ-0000BF-EY; Mon, 27 Jan 2025 02:38:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737963513; x=1769499513;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gUjYa/wXHmfmKSJyMDgaO+wx9TfzH4TNlD4321+7HX8=;
 b=II74H7n84rviAD/XEDeYFm1OoFbu5g38Bc2KmVmraMlmLhLJfO5gYXuy
 BnDCWRWogl4OyTjCL2m4WmWOCuQPYt8Fwx1kc8SxuQkKkJtTgXqo+njxJ
 TyFiQUJ/1B2hG65HV6I+86Yca+20A/sSO39QdlGgRmDR789NQx8am5OqQ
 ahC64OtOXEzozo3oI9uI8h9+agCFHA2X5OujjsVbXgX16NoSTWVpq10bN
 jesKuqF0xrBQ+U699eDQCySd6XcgDMl1j/NcDagnyJVd1au0eunAg7Z51
 YlW5CI2BG11iAMYKrehdTra9aknRtaThHUwOT5ZK4zgiapkXCjcvHNaEV w==;
X-CSE-ConnectionGUID: f3vJvVkFQhaFrZTZyfANGQ==
X-CSE-MsgGUID: zSXDRlCRQn2Z0zNVbN0U1Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11327"; a="38444098"
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; d="scan'208";a="38444098"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2025 23:38:30 -0800
X-CSE-ConnectionGUID: qRoe3rdKSWyCyQnt9HJGXg==
X-CSE-MsgGUID: JCZaExa1TPebNCY9HbQS1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,237,1732608000"; d="scan'208";a="113355882"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa004.fm.intel.com with ESMTP; 26 Jan 2025 23:38:28 -0800
Date: Mon, 27 Jan 2025 15:57:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
Message-ID: <Z5c8gVcUn4rzVpID@intel.com>
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117194003.1173231-3-pbonzini@redhat.com>
Received-SPF: pass client-ip=198.175.65.17; envelope-from=zhao1.liu@intel.com;
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

> +impl<T: ObjectType> Owned<T> {
> +    /// Convert a raw C pointer into an owned reference to the QOM
> +    /// object it points to.  The object's reference count will be
> +    /// decreased when the `Owned` is dropped.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `ptr` is NULL.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must indeed own a reference to the QOM object.
> +    /// The object must not be embedded in another unless the outer
> +    /// object is guaranteed to have a longer lifetime.
> +    ///
> +    /// A raw pointer obtained via [`Owned::into_raw()`] can always be passed
> +    /// back to `from_raw()` (assuming the original `Owned` was valid!),
> +    /// since the owned reference remains there between the calls to
> +    /// `into_raw()` and `from_raw()`.
> +    #[allow(clippy::missing_const_for_fn)]
> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> +        // SAFETY NOTE: while NonNull requires a mutable pointer, only
> +        // Deref is implemented so the pointer passed to from_raw
> +        // remains const
> +        Owned(NonNull::new(ptr as *mut T).unwrap())
> +    }

...

> +    /// Increase the reference count of a QOM object and return
> +    /// a new owned reference to it.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The object must not be embedded in another, unless the outer
> +    /// object is guaranteed to have a longer lifetime.
> +    pub unsafe fn from(obj: &T) -> Self {
> +        unsafe {
> +            object_ref(obj.as_object_mut_ptr().cast::<c_void>());
> +
> +            // SAFETY NOTE: while NonNull requires a mutable pointer, only
> +            // Deref is implemented so the reference passed to from_raw
> +            // remains shared
> +            Owned(NonNull::new_unchecked(obj.as_mut_ptr()))
> +        }
> +    }
> +}
> +

About the difference between from_raw() and from(), I understand if the
C side also holds a pointer, the Rust side must increase the reference
count (using Owned::from), and If the C side does not have any other
pointers, Rust can directly use Owned::from_raw. Am I right?

* The use of from():

        fn do_init_clock_in(
            dev: *mut DeviceState,
            name: &str,
            cb: Option<unsafe extern "C" fn(*mut c_void, ClockEvent)>,
            events: ClockEvent,
        ) -> Owned<Clock> {
            assert!(bql_locked());

            // SAFETY: the clock is heap allocated and does not have a reference, so
            // Owned::from adds one.  the callback is disabled automatically
            // when the clock is unparented, which happens before the device is
            // finalized.
            unsafe {
                let cstr = CString::new(name).unwrap();
                let clk = bindings::qdev_init_clock_in(
                    dev,
                    cstr.as_ptr(),
                    cb,
                    dev.cast::<c_void>(),
                    events.0,
                );

                Owned::from(&*clk)
            }
        }

* The use of from_raw():

    fn new() -> Owned<Self> {
        assert!(bql_locked());
        // SAFETY: the object created by object_new is allocated on
        // the heap and has a reference count of 1
        unsafe {
            let obj = &*object_new(Self::TYPE_NAME.as_ptr());
            Owned::from_raw(obj.unsafe_cast::<Self>())
        }
    }


Comparing with these 2 use cases, I find the difference is
qdev_init_clock_in() creates a pointer in qdev_init_clocklist().

Then the comment "the clock is heap allocated and does not have
a reference" sounds like a conflict. I'm sure I'm missing something. :-(

Thanks,
Zhao


