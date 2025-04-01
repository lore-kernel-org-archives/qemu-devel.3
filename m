Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09614C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 08:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzXA0-0005wr-Kq; Tue, 01 Apr 2025 04:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tzX9y-0005wJ-Uq
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:39:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tzX9w-0001ji-Rl
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 04:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743496785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R5CUnTw7XaT5k94huOQtQ6egMWSK52jbJtE05Bw6TMg=;
 b=h876r+klp9NPwBsgOyWFOPS0Bizk+XMQ20ghtbzzL/yDCekMpWx3ii/4LU3x8WOkeihXUe
 FEjjC1yKdU8iZl7yCv1Vr972TOSqR9NYstFdbZUnPlrROsn8DEfFpRgN/j+MLFMsC/8wvN
 r+1+kNPJlLfT2ZdE5Myk8GH3YIShR1U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-SJBBCnn2NBKavr6Du5Ap4g-1; Tue, 01 Apr 2025 04:39:43 -0400
X-MC-Unique: SJBBCnn2NBKavr6Du5Ap4g-1
X-Mimecast-MFC-AGG-ID: SJBBCnn2NBKavr6Du5Ap4g_1743496783
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf3168b87so29234835e9.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 01:39:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743496782; x=1744101582;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R5CUnTw7XaT5k94huOQtQ6egMWSK52jbJtE05Bw6TMg=;
 b=C7EEHBbyyMGSmnTNGAjL/dlEyMaQF+QsHEnUIwrmpvXEBSK3cxjwqwvx38QOhnc1An
 jixNld4XcHGNIxM4e/APQevd06SpyRiB62FRireWlqcD0Z99+ap08LFbEHK4wGKWH6q5
 oc6R0eiaBLpc59CMkMbG/bnTQLquOEuPIty5bfXGhcvm4luit2OjsIRQSDz0j3X3ISRp
 BXkxZuwdZz8eJJwqdvopP/0gx29ixiTaPZ4Cs0b5GrP3F3gJcODY8ZNrDksd5VAOMbIi
 OD+tz3CKP7swmy5nutxFrCAaJWpQqpbY+0TdrLYVhQp/igaRCRKWOoUvD/mu83hFkzPy
 FndA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgb79X4KrEfK2IiKBF5WmIlXtBk54FN3rWwRKx4bgNO/DwL+A4ihIyzoTg3VvXYpA0/0F08tDdD2QD@nongnu.org
X-Gm-Message-State: AOJu0YzzEyCLmp/ILBO2uT6ulqNcbvlMygA/oyta53VfVjC1YTUpJRKk
 u0n6mEWY+Tb+zxq5AYirJK46LUMq13dvKnK+ufsGlQDC1JpHG8myojxFQDnQ1fJsx73J9K7SMzf
 ZF56ltJgHUBKoRd2c2dZbclD8r3kKhbsdR+I37tiZ0RkH6e5x40E8083U1xdwgJy7eB1ETcYaWS
 23O70asMfWxbb8auAHmBtSFJMHtR4=
X-Gm-Gg: ASbGncsYBOwvNDI6tgdD0nHyqzxD1eq762ieCD48YY/obrmfI4GVu9668bVGHs/811L
 GeFloPQhr50IKPOihktVrRbEfEWuNccEfDS1rZqYWmOyY8ds4tdlh3co02fOMwZHJARVxR92q4w
 0=
X-Received: by 2002:a05:600c:a087:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-43ea7cc3841mr18843275e9.23.1743496782609; 
 Tue, 01 Apr 2025 01:39:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0kwY5dhCkHMW9G5dKBr8YPgzHbkoG1f30MbBmjyMJOAnDXikeQGw9fBRU7sId9Emw+vGv3P5g3wE01mk/R6E=
X-Received: by 2002:a05:600c:a087:b0:43c:fe5e:f040 with SMTP id
 5b1f17b1804b1-43ea7cc3841mr18843075e9.23.1743496782268; Tue, 01 Apr 2025
 01:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250401002633.738345-1-saman@enumclass.cc>
 <Z-ujXI126OC9lZpi@redhat.com>
In-Reply-To: <Z-ujXI126OC9lZpi@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 1 Apr 2025 10:39:31 +0200
X-Gm-Features: AQ5f1JqsI5Wk-7grYWKZhpRc4wqm-WONUiUiQku6LhaeV6zNKQqFIfJkzJBTEdU
Message-ID: <CABgObfYNWPfeh67etsjaqeCf-5WvRqiAo3+czPpu37_=3buq-w@mail.gmail.com>
Subject: Re: [PATCH] Rust: Add tracing and logging support for Rust code
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: saman <saman@enumclass.cc>, qemu-devel <qemu-devel@nongnu.org>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-rust@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000005ff02e0631b37aa3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000005ff02e0631b37aa3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 1 apr 2025, 10:27 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> This is a non-trivial degradation for the tracing code. The code is
> generated in an inline function in the header so that when a probe
> point is not active, it has as little overhead as possible - with
> some backends it will just a 'nop' instruction.  With this change
> every probe is turned into a function call with no possiblity to
> optimize away this overhead.
>
> IMHO tracing in Rust needs to be done by generating native Rust
> code for the (sub)set of trace  backends that we care about, and
> not attempt to wrap the C trace code from Rust.
>

A little bit of both. Moving the body of the tracing to a C out-of-line
function is okay: easier than converting printf strings to Rust format
strings and possibly *more* efficient. The condition must remain inline
though.

Also, the focus should be on what the Rust API should look like, not on
throwing some code on the other side of the fence. Introducing a second
language has the risk of introducing massive technical debt, and therefore
requires some design work. Tracing and logging is certainly not a one-patch
task.

Paolo

With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>
>

--0000000000005ff02e0631b37aa3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 1 apr 2025, 10:27 Daniel =
P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat=
.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">This is a non-trivial degradation for the tracing code. The code=
 is<br>
generated in an inline function in the header so that when a probe<br>
point is not active, it has as little overhead as possible - with<br>
some backends it will just a &#39;nop&#39; instruction.=C2=A0 With this cha=
nge<br>
every probe is turned into a function call with no possiblity to<br>
optimize away this overhead.<br>
<br>
IMHO tracing in Rust needs to be done by generating native Rust<br>
code for the (sub)set of trace=C2=A0 backends that we care about, and<br>
not attempt to wrap the C trace code from Rust.<br></blockquote></div></div=
><div dir=3D"auto"><br></div><div dir=3D"auto">A little bit of both. Moving=
 the body of the tracing to a C out-of-line function is okay: easier than c=
onverting printf strings to Rust format strings and possibly *more* efficie=
nt. The condition must remain inline though.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Also, the focus should be on what the Rust API should =
look like, not on throwing some code on the other side of the fence. Introd=
ucing a second language has the risk of introducing massive technical debt,=
 and therefore requires some design work. Tracing and logging is certainly =
not a one-patch task.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Pa=
olo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_=
quote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
<br>
</blockquote></div></div></div>

--0000000000005ff02e0631b37aa3--


