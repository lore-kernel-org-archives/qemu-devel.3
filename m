Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B69C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 10:17:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td57h-0008C4-7s; Wed, 29 Jan 2025 05:16:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td57f-0008BQ-VQ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:16:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1td57e-0003pt-0R
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 05:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738145796;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w+G8waqSz+sW1WzRxyXqVcZa+E1OzGMu5DN+Rnb5mGQ=;
 b=QX5m3lSrkAkzVLzw+oISc0fSzFJsYVwSpSsoKuXJVuBsworOxE4a7OYSDbO/Andq7njm50
 S2r1zBVL7wlMmrJCC+yB8bYfUw+nBDTp8JjZkkSBizoJxMC2Ih4gr33OwkU9Wgesh565c4
 EhbMxTMko4oblHtrBhxVfHDgMOnyPtI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-5tnFfne4M-CpwHKLGgMnzw-1; Wed, 29 Jan 2025 05:16:34 -0500
X-MC-Unique: 5tnFfne4M-CpwHKLGgMnzw-1
X-Mimecast-MFC-AGG-ID: 5tnFfne4M-CpwHKLGgMnzw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38a35a65575so4612800f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 02:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738145793; x=1738750593;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w+G8waqSz+sW1WzRxyXqVcZa+E1OzGMu5DN+Rnb5mGQ=;
 b=q8RNuMhXT5r2e291zzatFOk3xdmS59NqJSwAmgh3Tbb+uvYJ8J+xxgZoNwIatcrHsk
 SWS9vWxABa7zntgIvaV9KJq0rDdT1aOxXzq6myooCyCNtHmSa9+i5+TpKtQh/79cjJT7
 QOhcLmXYb5BzLa1mgLp23bA0oF/ffprAIV1IhL4bLx02hq6tU7e5Gjq15jCTI78M9dHg
 rmNIE9lva/EGG9tIPtGC0J1W1hlFypYuq5K6UashE9wxNEgl3Y4SD1LubvLbeKwVa2rc
 rTJUQHO5onTo7UDd2AdHrKmkZBGt1aS5snz40N5pBg7KROQVAQx09F60m3Fg/EnnsubK
 WEKA==
X-Gm-Message-State: AOJu0YyW87FMeoGylyteDKe6Il0RxXGbyO6L8zClQ41o+Tyz1FmpcL8Z
 7a78oZs/ZtA472yOvKwDNejQRJ/9n+EsJrg9nny4+aEUgkUGCuny8r+in2W2mT+tlsomXBlBIu8
 w7T1HLlF9JbyiGVlustT2sxEv0SQicg8UUv9g+LCO3h0L9YpXGbV9kr6OjY1MJocAU3p/WMyt0z
 vOwDsNZt48SIYYVVq8Hu3jfIMQ9kU=
X-Gm-Gg: ASbGnct6GzqX/H5iGD6tVMLNJqoOMA0HXkYRIGeoUy8CjRXZSk5Xb3FiQVc2z2wmfEk
 uFuN6ockKN3FR49zc35EpdyAkIJFLniUnMRRwNy5QoVEuuPTbmiH5ekSt1flV
X-Received: by 2002:a5d:5847:0:b0:386:3825:2c3b with SMTP id
 ffacd0b85a97d-38c5194c75cmr2063745f8f.18.1738145793550; 
 Wed, 29 Jan 2025 02:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFl8vBQYpbHBsp1jESsQ6cQcP7IETOy40haopYAa2Ua2mN5lsq8HmtyeKT+BL6k2TtclADwNcEW0D4WLX2CbMI=
X-Received: by 2002:a5d:5847:0:b0:386:3825:2c3b with SMTP id
 ffacd0b85a97d-38c5194c75cmr2063723f8f.18.1738145793176; Wed, 29 Jan 2025
 02:16:33 -0800 (PST)
MIME-Version: 1.0
References: <20250117194003.1173231-1-pbonzini@redhat.com>
 <20250117194003.1173231-3-pbonzini@redhat.com>
 <Z5c8gVcUn4rzVpID@intel.com>
In-Reply-To: <Z5c8gVcUn4rzVpID@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 29 Jan 2025 11:16:21 +0100
X-Gm-Features: AWEUYZkqaWvqQNdpUWQut2JEKbrMIOETSMl_-j2ga15e1vqt8M_ETs5WhouNLQE
Message-ID: <CABgObfbLaHXtoGAkUVW9CUXio-N_1A=Awq0=ZCY3G8sAO+9NXQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] rust: qom: add reference counting functionality
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 27, 2025 at 8:38=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wrot=
e:
>
> > +impl<T: ObjectType> Owned<T> {
> > +    /// Convert a raw C pointer into an owned reference to the QOM
> > +    /// object it points to.  The object's reference count will be
> > +    /// decreased when the `Owned` is dropped.
> > +    ///
> > +    /// # Panics
> > +    ///
> > +    /// Panics if `ptr` is NULL.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must indeed own a reference to the QOM object.
> > +    /// The object must not be embedded in another unless the outer
> > +    /// object is guaranteed to have a longer lifetime.
> > +    ///
> > +    /// A raw pointer obtained via [`Owned::into_raw()`] can always be=
 passed
> > +    /// back to `from_raw()` (assuming the original `Owned` was valid!=
),
> > +    /// since the owned reference remains there between the calls to
> > +    /// `into_raw()` and `from_raw()`.
> > +    #[allow(clippy::missing_const_for_fn)]
> > +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> > +        // SAFETY NOTE: while NonNull requires a mutable pointer, only
> > +        // Deref is implemented so the pointer passed to from_raw
> > +        // remains const
> > +        Owned(NonNull::new(ptr as *mut T).unwrap())
> > +    }
>
> ...
>
> > +    /// Increase the reference count of a QOM object and return
> > +    /// a new owned reference to it.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The object must not be embedded in another, unless the outer
> > +    /// object is guaranteed to have a longer lifetime.
> > +    pub unsafe fn from(obj: &T) -> Self {
> > +        unsafe {
> > +            object_ref(obj.as_object_mut_ptr().cast::<c_void>());
> > +
> > +            // SAFETY NOTE: while NonNull requires a mutable pointer, =
only
> > +            // Deref is implemented so the reference passed to from_ra=
w
> > +            // remains shared
> > +            Owned(NonNull::new_unchecked(obj.as_mut_ptr()))
> > +        }
> > +    }
> > +}
> > +
>
> About the difference between from_raw() and from(), I understand if the
> C side also holds a pointer, the Rust side must increase the reference
> count (using Owned::from), and If the C side does not have any other
> pointers, Rust can directly use Owned::from_raw. Am I right?

Pretty much - more precisely you use Object::from_raw 1) if the C side
gifts a reference 2) if you got the pointer from Owned::into_raw. The
second case is similar to Arc::from_raw, which expects that you got a
reference from Arc::into_raw. The first is the more common case.

>
> * The use of from():
>
>                 let clk =3D bindings::qdev_init_clock_in(...)
>                 Owned::from(&*clk)

In this case the C side wants to manage the reference that
qdev_init_clock_in() returns; it is dropped in
qdev_finalize_clocklist(). So Rust code needs to increase the
refcount.

> * The use of from_raw():
>
>     fn new() -> Owned<Self> {
>         assert!(bql_locked());
>         // SAFETY: the object created by object_new is allocated on
>         // the heap and has a reference count of 1
>         unsafe {
>             let obj =3D &*object_new(Self::TYPE_NAME.as_ptr());
>             Owned::from_raw(obj.unsafe_cast::<Self>())
>         }
>     }

In this case the C side lets the caller manage the (only) reference
when object_new returns, so you must not increase the refcount.

Owned::from() is slightly less efficient, though that almost never
matters. If it does you can use ManuallyDrop::new(Owned::from_raw(p)).

> Comparing with these 2 use cases, I find the difference is
> qdev_init_clock_in() creates a pointer in qdev_init_clocklist().

That is related, but more precisely the difference is that
qdev_init_clock_in() wants to unref that pointer later.

> Then the comment "the clock is heap allocated and does not have
> a reference" sounds like a conflict. I'm sure I'm missing something. :-(

Changed:

      // SAFETY: the clock is heap allocated, but qdev_init_clock_in()
      // does not gift the reference to its caller; so use Owned::from to
      // add one.  the callback is disabled automatically when the clock
      // is unparented, which happens before the device is finalized.


Thanks for the review!

Paolo


