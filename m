Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4268DD4976C
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 12:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHitm-0001N2-OL; Sun, 01 Dec 2024 07:18:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tHitg-0001MY-PD
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 07:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tHitc-0006ri-Pv
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 07:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733055468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GfM+hv+UmRrO0wcCc3aaf+FTe3Isw++/K+lNX65f+zU=;
 b=eWVeFptXcWhSZpzWZ1qCOkQbgysAoMKS06BVrW6/9c3YOlcRTHzFVx7fAH3t2ZNoAK5dxK
 +WE403Pj6NzvKv+5ctjyc5rhNH4eL+gdvZVHs4VFxNeKZ5KEoQXUwMckyx/txdVogZuSik
 HyseO33xvzrVJFDIW9XRSPQ5jZgpypI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-dgWMCFjzMEGn3AUIRW3V1A-1; Sun, 01 Dec 2024 07:17:45 -0500
X-MC-Unique: dgWMCFjzMEGn3AUIRW3V1A-1
X-Mimecast-MFC-AGG-ID: dgWMCFjzMEGn3AUIRW3V1A
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385dc37cb3eso1190710f8f.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 04:17:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733055463; x=1733660263;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfM+hv+UmRrO0wcCc3aaf+FTe3Isw++/K+lNX65f+zU=;
 b=HnBK1rcYrib+vp+LXmQybG+BgHHnEyBXmNQx9HM+jGiIhlRp8Fawe7xyR3u1uqJhLP
 WVTs7deO86IAda27vnZa7pp/Csei6MTzEikxzS3DljEk9KCEHChWWYtzrihWlgjmjP5m
 wUCO4Sgohj2mpCpCZTQfQ1ltjz4yUWQXxdgynCiFXjfiYLy2GQNol0RLzyIvPnV/KVrX
 hhdNXaQttClWjh6Kgwebq2ZCVgSADPFs4u2NNb0iIIJ+zwFqidvicDJuApWh0KZp7Ymw
 s34RJQZBzrNmDwfHMYPSDc58CJ6FmqQZUzfr/mbeecaU2zPahbmHZ8K2yrJw2mnSBtEK
 0Jyg==
X-Gm-Message-State: AOJu0YxHqsWOnEz0hk+uK6bSYHIFsL6/TNaMZDiTcrqBcwJB/CR4FkeY
 61ZKS3S0OohH9XM8KzuvXcu/zOVAP6Pg+TyinZ5kcU+saAkUk5TwaNwxuOT2OMa5+uUIiLmBMlt
 tWNSvZUHmKnu3pjeol+Aul4jRK+S9vpAYt74ZxtOdVPeroHHSymnSBYsuOLncWXSyxrsjJCq/mZ
 17I2j0ftjLnd8A6xA2UTzi+VaPnl7ct6InbzmU6g==
X-Gm-Gg: ASbGncsNLK+jO1A/hhJSJCVtskRleAF9H0FzhoAkU8COtLFkNQ5H5N0sc05tpLEWcKY
 WqySLLq39ZhHsN8rXU9BgUEih5RGsQiJQ
X-Received: by 2002:a5d:6481:0:b0:385:df4e:366f with SMTP id
 ffacd0b85a97d-385df4e3bdfmr8266601f8f.38.1733055463030; 
 Sun, 01 Dec 2024 04:17:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkQw47DE0EnM3j7nTNOLGY/qU4MDXyFc++EM7IhIZlADxr9N7xvQdRT32GJOn2TRKJFmERNpFOFR1DmYqejNM=
X-Received: by 2002:a5d:6481:0:b0:385:df4e:366f with SMTP id
 ffacd0b85a97d-385df4e3bdfmr8266582f8f.38.1733055462674; Sun, 01 Dec 2024
 04:17:42 -0800 (PST)
MIME-Version: 1.0
References: <ab7626bb-7c77-49c9-8dc8-86d79b095e3a@pbonzini.local>
In-Reply-To: <ab7626bb-7c77-49c9-8dc8-86d79b095e3a@pbonzini.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 1 Dec 2024 13:16:00 +0100
Message-ID: <CABgObfbdhNE6OY1JTLkYOj+7e+P+vY2s8XoSTFUPQAR9KdqJSA@mail.gmail.com>
Subject: Re: Rust in QEMU roadmap
To: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Nov 26, 2024 at 6:48=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Callbacks
> '''''''''
>
> This is the least mature of the "urgent" changes, and perhaps the more
> important to have a good design for.  PL011 has callbacks for character
> devices and memory regions, but other usecases include timers, bottom
> halves and interrupt sinks (aka GPIO inputs).

Ok, I have an idea that should make it possible to write something like thi=
s:

pub struct Timer {
    t: *mut QEMUTimer,
}

impl Timer {
    // FnCall is QEMU-specific and contains all the magic.
    unsafe extern "C" fn rust_timer_cb<
        'a, T, F: FnCall<(&'a T,)>>(opaque: *mut c_void) {
        // The argument to F::call is a tuple, otherwise this is fairly exp=
ected
        F::call((unsafe { &*(opaque.cast::<T>()) },))
    }

    #[inline]
    fn new_ns<'a, T, F: FnCall<(&'a T,)>>(
        clk: QEMUClockType,
        _cb: F,
        opaque: &'a T,
    ) -> Timer {
        let cb: unsafe extern "C" fn(*mut c_void) =3D rust_timer_cb::<'a, T=
, F>;
        Timer {
            t: unsafe { bindings::timer_new_ns(clk, cb, opaque) },
        }
    }
}

and then the caller can simply write

   self.timer =3D Timer::new_ns(QEMU_CLOCK_VIRTUAL, Self::timer_update, sel=
f);

The idea is that the compiler will generate a different version of
rust_timer_cb for every value of the second argument (which is unused,
except inasmuch as it helps the compiler know what "F::call" means).
In the code above "unsafe" is only needed for the unavoidable casts
and FFI calls, while the device has no unsafe at all. I haven't
written the timer bindings but the basic idea is like the above. It
can be expanded once Zhao posts his HPET conversion.

It may also be possible to use macros to make things a little less
verbose, but I'm tending to err on the side of explicitness for now.

I'm also not sure about the applicability of this trick to character
devices and memory regions, since those have multiple callbacks and/or
callbacks in structs rather than function parameters. However, for
timers this is a good option I think.

Paolo


