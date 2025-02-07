Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7944CC0219C
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 09:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL47-0001dR-Gl; Fri, 07 Feb 2025 04:54:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgL43-0001c5-Lt
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:54:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgL41-00080d-Q2
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 04:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738922059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=14N4LN9FPiVuAo2srZND+rufrzAZ5UTPmrbsIu/NbzQ=;
 b=IWYD1KxjCm5FEl2tLYpvE+Eh+umoSTfNoRgh1rEDYJ+63TmYzKL0rpzxeJcQz1kIGzldx0
 KHLmmNcnvalbbXxktl5bjuOd0fhWMs0ClPmx9uXuCWn5I4Xkp+zzsPjKX460f7qRJ9Y2wn
 lnRPjef19h/SSuoAZgDPTiHNy1KvMvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-ARc_3FHiMfK1Qj6N7h6oKw-1; Fri, 07 Feb 2025 04:54:17 -0500
X-MC-Unique: ARc_3FHiMfK1Qj6N7h6oKw-1
X-Mimecast-MFC-AGG-ID: ARc_3FHiMfK1Qj6N7h6oKw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dc32f753dso572621f8f.3
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 01:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738922056; x=1739526856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=14N4LN9FPiVuAo2srZND+rufrzAZ5UTPmrbsIu/NbzQ=;
 b=SxDe2XhfGds0CMQYOu0kxdTMs2jR5undCz+VK/4fpsnaTUb2Osqt8ubcKOr+toc24K
 SMx2jldCjOQmvn7Qk4txjma+ml5m8hXZhFP1llNDNQH2Pu/AwwF/mJ+tlRf4tYSPE7FM
 zytiJ7y2STV6mfe3eNjV3oqX8kRfPTS36DYGP940aNchZk/4MAiNogFJApP3hXqRbhbg
 sBLIJWiuYnl1ID0+6gMkrZPiwU3DtSRqsOh4X3icy2tAvWRKMheEAn5j6nGCG4taVwP0
 E32MY0UiHdGiFPfokeXXGWcstoCQvCKCtFf5cr9Y1+loAb0KwrT9pvZxpd6CkqQpdsbI
 Sk0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb3Dy/trTdM89nc67/zWJGukEF1hUb86zFYsp/XuzfDAmyI/0qDQ2G2Ag0mmezQniewh9qhlH9f+N2@nongnu.org
X-Gm-Message-State: AOJu0YySGqyhqiFpqEbyY5Ou0H79k9XXkN1EyZXlOLkLZHA6XycB9BYP
 DbKHWhQzfPBy0tnTCUThU/FIzFuRBfU+ppWuxUHuxoQogliDqcKXc57I/YYz0Mva1ILJ5Z6vdUI
 U4tjnUOwGeOo0IhdMnq7yFR5q8dvaqLrbyP0VnLvY3oYynBnZkSrjAP0FIkhtupH5HsPZgT1jKG
 qtz/7X07NxXZydZ+04yussLdtCBxw=
X-Gm-Gg: ASbGncs6TBd6fn8Rbni7v6imE773t3qZ5nm1ektkpxHaExwTmvnQ3i++1tPMCH2sKfP
 8R/L8SfgiadDMlQ+AP+F9BkcH/VxP8D34kSn76zhxMk5m7Bw692gd0aYufLZU
X-Received: by 2002:a5d:5f48:0:b0:38d:b409:7d46 with SMTP id
 ffacd0b85a97d-38dc959f9fbmr1778548f8f.48.1738922056335; 
 Fri, 07 Feb 2025 01:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl5OE8FSyqQJ2lqJo4WnAhWZgVl6JVKHTSxceTb5ID0uMEAc47pJhtaMTmfVKL+KZTlG+LUA80I+F/Rmz6QRI=
X-Received: by 2002:a5d:5f48:0:b0:38d:b409:7d46 with SMTP id
 ffacd0b85a97d-38dc959f9fbmr1778530f8f.48.1738922055978; Fri, 07 Feb 2025
 01:54:15 -0800 (PST)
MIME-Version: 1.0
References: <20250125125137.1223277-1-zhao1.liu@intel.com>
 <20250125125137.1223277-5-zhao1.liu@intel.com>
 <5a19e7d2-9d69-45fe-812f-84145229876f@redhat.com> <Z6XHzXwoIklPZQ/I@intel.com>
In-Reply-To: <Z6XHzXwoIklPZQ/I@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 7 Feb 2025 10:54:04 +0100
X-Gm-Features: AWEUYZkpMUjEgdAOeT7C0ODn4XbHSMnbIytTWsCaZe5o4KIf8kL9ABrIgpKg3YU
Message-ID: <CABgObfYathYPF-KWrZv+33+iEA_j=ee7eJbJmzA5F2rpY-ktqw@mail.gmail.com>
Subject: Re: [PATCH 04/10] rust: add bindings for gpio_{in|out} initialization
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000706c23062d8a57cd"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000706c23062d8a57cd
Content-Type: text/plain; charset="UTF-8"

Il ven 7 feb 2025, 09:24 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > Please add "let _: () = F::ASSERT_IS_SOME;", which is added by the
> > qdev_init_clock_in() patch.
> >
>
> Okay.
>
> I would add `assert!(F::is_some());` at the beginning of init_gpio_in().
>

Use the "let" so that it's caught at compile time.

There's a difference with origianl C version:
>
> In C side, qdev_get_gpio_in() family could accept a NULL handler, but
> there's no such case in current QEMU:
>
> * qdev_get_gpio_in
> * qdev_init_gpio_in_named
> * qdev_init_gpio_in_named_with_opaque
>
> And from code logic view, creating an input GPIO line but doing nothing
> on input, sounds also unusual.
>

Wouldn't it then crash in qemu_set_irq?

Paolo

So, for simplicity, in the Rust version I make the handler non-optional.
>
>
>

--000000000000706c23062d8a57cd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il ven 7 feb 2025, 09:24 Zhao Li=
u &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha=
 scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; P=
lease add &quot;let _: () =3D F::ASSERT_IS_SOME;&quot;, which is added by t=
he<br>
&gt; qdev_init_clock_in() patch.<br>
&gt; <br>
<br>
Okay.<br>
<br>
I would add `assert!(F::is_some());` at the beginning of init_gpio_in().<br=
></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Use=
 the &quot;let&quot; so that it&#39;s caught at compile time.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
There&#39;s a difference with origianl C version:<br>
<br>
In C side, qdev_get_gpio_in() family could accept a NULL handler, but<br>
there&#39;s no such case in current QEMU:<br>
<br>
* qdev_get_gpio_in<br>
* qdev_init_gpio_in_named<br>
* qdev_init_gpio_in_named_with_opaque<br>
<br>
And from code logic view, creating an input GPIO line but doing nothing<br>
on input, sounds also unusual.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">Wouldn&#39;t it then crash in qemu_set_irq?</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"au=
to"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_conta=
iner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">So, for simplicity,=
 in the Rust version I make the handler non-optional.<br>
<br>
<br>
</blockquote></div></div></div>

--000000000000706c23062d8a57cd--


