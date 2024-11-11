Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B9DD2E9D1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:10:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tARMs-0002m5-Vr; Mon, 11 Nov 2024 05:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tARMp-0002ll-KJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:09:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tARMn-0003yj-Qy
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731319792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lE4aIdPHsOWBO/MU/sb+KFp54tNZPLYKpnQ335EqJsw=;
 b=M7nI2UQLbIsk25FQbNLTrKe9r2r9OIO5Ry/f0KEVh+zaOrfLJkJFKoSGQnNxAQ5PxKp+Ie
 HWI/ylkNam5XDRSV8pa+d7BBqj2lOCiM1BW0+f9kFk9804KrhmMZdJ2sSfAoPecj8epWTr
 v5JSukxMPhAMtZmvGPRcE5v1StQHMMw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-lb_O34W_O1-mdYGA00Teag-1; Mon, 11 Nov 2024 05:09:51 -0500
X-MC-Unique: lb_O34W_O1-mdYGA00Teag-1
X-Mimecast-MFC-AGG-ID: lb_O34W_O1-mdYGA00Teag
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso29327045e9.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 02:09:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731319790; x=1731924590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lE4aIdPHsOWBO/MU/sb+KFp54tNZPLYKpnQ335EqJsw=;
 b=mjS3RH9URzhFfr+sas/BL1HjK5BaVXKL4vJsLAly33cJBYakbtDJjvr2zAYAjAxdTj
 yVRPK/jsfOgRmrab22pmEDFHmf7TVJunm3ejcw0Ea+7IqKIvRmiBoMVo2sOF6MFwDSXW
 knLxbD10uAued/gppp3RKs08+dKUit6LHqyZUbw0G6nnz1TeJlG+GrJsi9a/NvLFodox
 K5elxE3uZhvk7kOgnv5WK70b0RaptVyabY2xkGH1Qi+5+0XUtwsQ+Qhv4sGHyestuqLH
 iucg94cfXvGntLzj+rJLuo9R9teF218WI6iAvPEovNsQ8bSmLIYjYnAh1ost8uu8VTX0
 dVZw==
X-Gm-Message-State: AOJu0YwwrS4Uo9uOd2KFxhTzESVOLI4dXpzh9rM5rH5m/n5UAmiEg+6M
 CBDuOQ2DVihD9paYTxjZShWcLk7SsudTA3/WPfUl9LYSVLwRUyJUXyaWQ20m7kcBB7+ArPAaI76
 U6Z04rwoxHZO03KXB1H4sIg8DUulD5gS6Pe2xFfxefSAr2KVMf6Q7SLAMPJAUkfvg+NO92EaEHK
 4XppR/ziqq089Od0XKY8WY1fLQLiY=
X-Received: by 2002:a05:600c:3c8f:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-432b751e28fmr91653425e9.32.1731319790085; 
 Mon, 11 Nov 2024 02:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0GunwSjIHGJaYOcnB42S7yBivdFiONSQwhP2Iuc7ytgpxkM4HR/wzBc9lwZ0hfofBt9NlWkqJX2/NP6jedgE=
X-Received: by 2002:a05:600c:3c8f:b0:431:4e25:fe42 with SMTP id
 5b1f17b1804b1-432b751e28fmr91653205e9.32.1731319789714; Mon, 11 Nov 2024
 02:09:49 -0800 (PST)
MIME-Version: 1.0
References: <20241104085159.76841-1-pbonzini@redhat.com>
 <SY0P300MB10266F3AFA3AEF31A6E06ACF955D2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10266F3AFA3AEF31A6E06ACF955D2@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Nov 2024 11:09:37 +0100
Message-ID: <CABgObfYekLM2MJiU+F3qcmJ86XiyxdQxrBU5OqkiJUoYfELDyw@mail.gmail.com>
Subject: Re: [RFC PATCH] rust: add bindings for interrupt sources + interior
 mutability discussion
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, zhao1.liu@intel.com,
 kwolf@redhat.com, marcandre.lureau@redhat.com, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 8, 2024 at 10:16=E2=80=AFAM Junjie Mao <junjie.mao@hotmail.com>=
 wrote:
> I like the idea of modeling device struct fields as interior-mutable.
> That reflects how such fields are referenced and can help forbid invalid
> accesses early.
>
> To showcase the benefit of modeling interior-mutable fields, a more
> complex device example (probably involving coroutines or other async
> mechanisms) may be needed.

I don't think there's really a benefit, it's more like avoiding a lie.
Even though right now (or in general) it's extremely unlikely that
this causes miscompilation, Rust's expectation is that a &mut is not
aliased except if it is formed from a shared reference via
UnsafeCell<>. Right now that's violated in both realize and the
Chardev callbacks.

> To me a container that check locking rules sound more like Lock, not
> Cell. Name it as a Cell can be misleading to those being used to Rust
> cells.

Right, it still performs the function and has the API of a Cell but
I've settled on BqlCell and BqlRefCell for clarity.

Especially if you have multiple imports of std::cell::Cell and QEMU's
own BQL-based (lowercase) cell, you don't want them to have the same
name.

> That said, one of its primary differences from the standard locking
> types in Rust is that the lock involved is global instead of being bound
> to a specific object. There are two alternative APIs in my mind:
>
> 1. get(&self) -> T / set(&self, T) which internally checks if BQL is
> held by the current thread, and panics if it is not. This is more
> straightforward.
>
> 2. get(&self, _: &BqlLockGuard) -> T / set(&self, _: T,
> _: &BqlLockGuard) which takes an extra evidence of BQL being
> held. BqlLockGuard can only be got as an argument to BQL-protected
> callbacks (macro-generated glue code here) or Bql::lock() which calls
> bql_lock().
>
> The second approach looks more idiomatic to me and may allow the
> compiler to error (via analyzing lifetimes) on derefs of
> borrow()/borrow_mut()-returned refs after BQL is unlocked (I need a
> double check on this). However, temporarily unlocking BQL is extremely
> rare in devices. I'm not sure if that's worthwhile at the cost of making
> the APIs more tedious to use.

Yes, this would be better in terms of compile-time safety, but on the
other hand the guard would propagate to all APIs that require the BQL.
The nice thing about the cell approach is that, as far as most devices
are concerned, QEMU has a single program flow (though not a single
thread) with very well defined preemption points but with an abundance
of reentrancy. If your callbacks get a BQL guard from the outside,
it's true that checks move from run-time to compile-time, on the other
hand you still need a RefCell-like mechanism to protect from
unexpected reentrancy. I'd rather avoid types like Bql<RefCell<T>>,
they are verbose in the definitions and the usage because they require
both a guard and explicit borrowing.

However, there are two points that are related to your observation:

1) when BqlRefCell is added, the C code needs to abort if the BQL is
released while a BqlRefCell borrow (either shared or mutable) is
alive. That's because you can never be sure that C code won't come in
and mutate the data that is protected by BqlRefCell.

2) We probably want a custom guard object sooner or later, maybe for
the block layer to assert that you're in the right AioContext, but for
now the risk of lock-related runtime failures of BqlRefCell seems
small to me (especially compared to already-borrowed panics due to
Rust->C->Rust reentrancy).


There is another issue that is solved by custom cell types compared to
RefCell, by the way, and it's that you cannot do offset_of! of
something within a RefCell. However we can make the BqlRefCell start
with the inner type:

#[repr(C)]
pub struct BqlRefCell<T> {
    inner: T,
    ...
}

and then use offset_of!(DeviceStruct, cell) + offset_of!(DeviceRegs,
reg_name). This however is very much left for later, as there are more
pressing issues and I think no one has put much thought into VMState
yet.

Thanks for sharing. I'll post a version of the BqlCell sometime within
the next week or two.

Paolo


