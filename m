Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856A2FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 19:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHRN9-0002Ie-6D; Mon, 27 Apr 2026 15:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wHRN7-0002IP-Bm
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:11:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wHRN5-0006US-9u
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 15:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777317113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHBsSHJy8NeRvM+yo9iyO/9AxFcFHzkLksYY/Y7M1Uk=;
 b=ah7Ml/k+WqHTjE6tQL1XsunK1T87dW/EKX8c28xTt/XW/UWR4BUzj2W1TSEwYcXwfnMuzP
 myhZrLTFl9YPGf4c793gx/cLFu73fkA3NXDpxjotSY21ytsWlZ02fygdK+zS6j9Z04jKyk
 5Ulh1erCxz5aQHMMOIzIeZPiZEp5G8E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-NktrwB3qPYOhlWhCGKS1Hg-1; Mon, 27 Apr 2026 15:11:50 -0400
X-MC-Unique: NktrwB3qPYOhlWhCGKS1Hg-1
X-Mimecast-MFC-AGG-ID: NktrwB3qPYOhlWhCGKS1Hg_1777317109
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a2ff53aso4784319f8f.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 12:11:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777317109; cv=none;
 d=google.com; s=arc-20240605;
 b=SksZ4GV23DGQot+ikt1LapA2+VUfa3IuschvU3j++0y3EnUfvu5xIzxvOetux2xB0f
 LQFqlhVVOymspStG+wGyafFhQ9F1fyouF3mVdvrzNbvZs8JpvpC7vb7he4PzdYpjFLSF
 dgEPIG15EmnYpUbrEery08qbJd4Qg0DfJ8NzEu9Pqx093NKxP5+9aMGXKZ2p0q5ZV7LU
 VzGERqlXKDSKjVOIrcszketr6qU4FRxKo5OGtZ9N2c9WQEeJTafmMFKJERAowj5V9evI
 kJH9+Osnfqs65zURgQyM7byKccTzstsxAQ72zXmh+pn4mLd0OcW/tTjXYJ4xH8Pc9GZR
 gy7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=tHBsSHJy8NeRvM+yo9iyO/9AxFcFHzkLksYY/Y7M1Uk=;
 fh=HdHJjyw0rb7lZJ7Wd/3ROogxV//sLJpL/hPVNGmUoQ0=;
 b=NpJ2kvBlOLKLn+2HF6kCCif6gMBxSn8XBXpae23FpbaxI8x9pwM2bki3ZxBWtd/BmX
 Co+/WTIo4/sv1CC+IwHUQLllebIZvb9MslT/CBUtMSAsGOx/HG8NLcKYCeKw6eZYENW+
 jztGuvElR9XcCR4eq++UdnTuaq8wzsy9p1dTQVMrCRKMA3iBu3ajDi3GiIZucXTHXFQg
 kGB+5YUZd+HVuwdnJuCB9Z+9xPpXLSz3bfI5AZVUZvk2C/+EiO4nhdjA/18OptS9MClA
 Pw+w28xnEy0TVsZjxZ5ISHhhSCqu4lq3StpS1J/k+9Gq6925QMwbLb4WvI9ozILINiT2
 rvCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777317109; x=1777921909; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tHBsSHJy8NeRvM+yo9iyO/9AxFcFHzkLksYY/Y7M1Uk=;
 b=klQURjtZ5ucaws1oRku1dP7P87b+AeyBbbUZysk7Oku2hRZqXP7hxFAlfYzo5/M7mm
 0oze+O0LBEB+fx7OtGq+oNaRB7EzPoPnPFu7PLYoyXN+IzNkXuAElUtoK4hFFCNHOzKI
 whivDOpHU6VT0O+5xzHcDLq9RbUfxy5LiLxuyVLzM9AG9yu1ygku8MmZyGttrEgLDFt8
 ntCwIS5fYw5REd+C42rzxCkCeK8wo/LbBJVe+I2m5xxryjhpeEWLk2txlX0fQKhTsTHb
 WcflmP5XohtIz9KKn8S2vJmdCFV+u1m4AhvDS725hJ2nPxMKfLzo/yoclQyuvNcWC7OE
 TVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777317109; x=1777921909;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tHBsSHJy8NeRvM+yo9iyO/9AxFcFHzkLksYY/Y7M1Uk=;
 b=cimKh7G7WF7bIPLhQRYmP94XivSzObWIMBtXizD+gOM3Zlrn1mhFuklQxPmCdT2aVd
 XsQCF/gmmqRGxRirq+suhIRAVdMH9+4TxoycVpCpqWqL94iuK/ghF2RDB/ukF983DtfU
 jtKGyo/8YY3ciZsBSUNUMRE9imsffAeZbWfHOPCTmN+gYdtVADNYe+bWf7d6e6uoEEnD
 FA2XfrY+bex/YAGKhF6OmZi88Y9Henk3Htow/FjWqWKVacE8vQ9vD4NfB6jJlHBlO8OO
 p8gWr+pYXwE4EyqNZsDJrmbwepAB67z698TeCoQ60YhZ+w0k05jQy836Jn+O9McAbVfk
 CpQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yB77fJo/OkjWxk+ZoU5GYrc0hvrRAcORr5AtpVsZclmPSeKNp/vmxAjHcg+uaH+bROrJ+48yVV6qN@nongnu.org
X-Gm-Message-State: AOJu0YzOjRVMpo8nrtjWOcc9PI7LZDxxBR0tiuE3U5SHegbF6W2R36ME
 TKgx/hA3ZcOfmOOAdoWKiFKfy3oC8nNNEYcIYPsXF0rpkgYsVmfaGLUqmKuwaUNPYnu7hon1Ihb
 U1soAsi9geFcYUrrQszMgo/4zE1qQek6k3ev1k182cS1TXDcuBlMPdUKrAy5bg4/V6FG8YAENkp
 oploHyj7UMXxDUux2jYCtsC9yI9z72aRI=
X-Gm-Gg: AeBDieuTFGZnb5A1sVxuH1oHBM+z7QeRMHHx8I2al14AfknntbLpoSGTPFAv3ng0xzu
 TdpSta66ObWU5L38L4fqN27nlu4NHg4Y8pLKPeKl1rkwVmrsOTchiPeOqs2nHjoEjlBD1Y5TTPB
 Gu2Y8k+1l+/rbiVqncdwYrKvE7H5nli7NRmMUG3hpgWGc813OwW7KOt3ncI5Sm5Zp9HjU9egp3P
 PtWM+i79EktIQvdcRE8NxDZAOpHjcZVZTe0YZ1JicCIrXdLQJLbG4l0BzfjIrQ6syPQQ7vtiPYf
 msacjbPQ5N0HBVA=
X-Received: by 2002:a05:6000:2502:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-446494ea24amr218558f8f.28.1777317109171; 
 Mon, 27 Apr 2026 12:11:49 -0700 (PDT)
X-Received: by 2002:a05:6000:2502:b0:439:c1ca:82be with SMTP id
 ffacd0b85a97d-446494ea24amr218526f8f.28.1777317108771; Mon, 27 Apr 2026
 12:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
 <20260304212303.667141-13-vsementsov@yandex-team.ru>
 <d80e91c1-2cbb-4081-a923-7b0c1da3b7cc@redhat.com>
 <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
In-Reply-To: <f7525a89-7878-43e8-b791-69829589666f@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Apr 2026 21:11:37 +0200
X-Gm-Features: AVHnY4L1cEt2bdxBVR01ADNdVspyXvTREp42867M8yviqklGzR-iFW3LHu5h4mM
Message-ID: <CABgObfbz98A0P4_FAqeKVk_fS+o_3=79agYz=qwnMdmg-h2L-Q@mail.gmail.com>
Subject: Re: [PATCH v3 12/18] migration: VMStateInfo: introduce new handlers
 with errp
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000ec0ab9065075e23f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000ec0ab9065075e23f
Content-Type: text/plain; charset="UTF-8"

Il lun 27 apr 2026, 15:19 Vladimir Sementsov-Ogievskiy <
vsementsov@yandex-team.ru> ha scritto:

> On 26.04.26 11:33, Paolo Bonzini wrote:
> > On 3/4/26 21:22, Vladimir Sementsov-Ogievskiy wrote:
> >> +    bool coroutine_mixed_fn (*load)(QEMUFile *f, void *pv, size_t size,
> >> +                                    const VMStateField *field,
> >> +                                    Error **errp);
> >> +    bool coroutine_mixed_fn (*save)(QEMUFile *f, void *pv, size_t size,
> >> +                                    const VMStateField *field,
> >> +                                    JSONWriter *vmdesc,
> >> +                                    Error **errp);
> > Use void functions for callbacks, with a wrapper adding the bool type.
> While bool/errp is preferred in general, for callbacks it provides N
> opportunities to get it wrong instead of just one.
> >
>
> Hmm, for now, the series is already merged.
>
> Next, I'm unsure, how callbacks are different from other functions around
> errors?
>

As I wrote above, confusing the *error == NULL and bool return value is
avoided without much extra effort for callbacks (or other kinds of virtual
functions) l, because there is a single caller. So the balance between
"avoiding the possibility of getting the return value wrong" and
"convenience of having a return value" tilts more towards the former.

I will post a follow up.

Paolo

I'm not sure that making wrappers, which will have to use ERRP_GUARD and
> check
> *errp for the error is a good practice. If it is, it would be good to
> start by
> modifying the documentation in include/qapi/error.h to mention the
> exclusion
> for callbacks.
>
>
> --
> Best regards,
> Vladimir
>
>

--000000000000ec0ab9065075e23f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 27 apr 2026, 15:19 Vladim=
ir Sementsov-Ogievskiy &lt;<a href=3D"mailto:vsementsov@yandex-team.ru">vse=
mentsov@yandex-team.ru</a>&gt; ha scritto:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">On 26.04.26 11:33, Paolo Bonzini wrote:<br>
&gt; On 3/4/26 21:22, Vladimir Sementsov-Ogievskiy wrote:<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool coroutine_mixed_fn (*load)(QEMUFile *f, v=
oid *pv, size_t size,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst VMStateField *field,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Er=
ror **errp);<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0 bool coroutine_mixed_fn (*save)(QEMUFile *f, v=
oid *pv, size_t size,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst VMStateField *field,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 JS=
ONWriter *vmdesc,<br>
&gt;&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Er=
ror **errp);<br>
&gt; Use void functions for callbacks, with a wrapper adding the bool type.=
 While bool/errp is preferred in general, for callbacks it provides N oppor=
tunities to get it wrong instead of just one.<br>
&gt; <br>
<br>
Hmm, for now, the series is already merged.<br>
<br>
Next, I&#39;m unsure, how callbacks are different from other functions arou=
nd errors?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">As I wrote above, confusing the *error =3D=3D NULL and bool retur=
n value is avoided without much extra effort for callbacks (or other kinds =
of virtual functions) l, because there is a single caller. So the balance b=
etween &quot;avoiding the possibility of getting the return value wrong&quo=
t; and &quot;convenience of having a return value&quot; tilts more towards =
the former.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I will post =
a follow up.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gma=
il_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">I&#39=
;m not sure that making wrappers, which will have to use ERRP_GUARD and che=
ck<br>
*errp for the error is a good practice. If it is, it would be good to start=
 by<br>
modifying the documentation in include/qapi/error.h to mention the exclusio=
n<br>
for callbacks.<br>
<br>
<br>
-- <br>
Best regards,<br>
Vladimir<br>
<br>
</blockquote></div></div></div>

--000000000000ec0ab9065075e23f--


