Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50749CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 22:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulaYU-0003kG-TP; Mon, 11 Aug 2025 17:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulaYT-0003jP-MR
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 17:59:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1ulaYJ-0005Hs-Uo
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 17:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754949573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U2W51kmkkFKHmpDHAdXz/jePtQs5canvoYctR1R6RhI=;
 b=Xp4agu8p8ok/u0pxuNyzxyMLhI9nVPkcINqstD8XtY0DVLoO40kTtakyPmjZYmoDEtOSe8
 GV6F3mIlA8lEABd3Y5I9yezWx85EuF2HyZwb/QngIIb0jG+g+zaWkyhldeLHgcgVbiWOSG
 B2rv5U8F3vvC8NusXBmkGLRqPjOCElc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-j-1J1qaeO5KWan5YGTujTg-1; Mon, 11 Aug 2025 17:59:31 -0400
X-MC-Unique: j-1J1qaeO5KWan5YGTujTg-1
X-Mimecast-MFC-AGG-ID: j-1J1qaeO5KWan5YGTujTg_1754949570
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b78a034d25so2401128f8f.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 14:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754949570; x=1755554370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U2W51kmkkFKHmpDHAdXz/jePtQs5canvoYctR1R6RhI=;
 b=Ti1sKyM1Rey9SakRQcFXp3TLdxlPgML0xUUbEb2kRCIGgOzimT6yaqukBcvvhwVCx9
 +4XC/p0F8wFWTFCz8U+3q1Rn776f/j9GJPOpqjSY9SC4mXI3WMrHJsSJf7ZgIYS5Cx/L
 TPQXcAGZHPKo/9G1y249DphgZlTzvTKPPhrUNzj6XPfqY6Qo99xiEzJGfZMlcc88xesc
 CHfKbKsj8zrsSpACevUTJSILiDI8UDUn8je5PPATRuA/0N/PJ6fPrSAJgVk75OCQxix7
 r8DUCg6UGAA/cqKAgJeiiIJ1LDJJA32zcrOCkvMnOUvzSYHLrfoIIeb6Ic5keA6Pk6tt
 kPKA==
X-Gm-Message-State: AOJu0YzJAxQGn3UlfdoJYMw8Z3O+CNoVc+lUvpoc99PRozLjiNq9Kag0
 OmLXDyRpnr1WSTcm6WDPZld7GpLYCCeVrqbZglHU0NiDXSHgjOdNsGc8/Wqtla5lolKkZvdjjp4
 92gqc+MWSt3WsBvFj82z8AyQ0tcacoHqbq23o96Qg583yO5oNOFt7y0PGcT0gRMCexWHprRzoYp
 5U2FFMKmkobBcSlJutKAm4SdMJ26bZDAk=
X-Gm-Gg: ASbGncv07Itl4j+/wb3QfaWuoXKUdsyFIzEJrTVueMB9efQzax4S4qoWygLo1g+1LCw
 QVnwuNybQpIE5/vsAZALZ9Pk7mu4qJh3tQEOyBEi37SiYl4axfQkP5PMT7deyxplVbfx/ErIRqG
 uqqF16isHD4Pok+lCo1yf9ag==
X-Received: by 2002:a5d:5d87:0:b0:3a3:65b5:51d7 with SMTP id
 ffacd0b85a97d-3b910fdea25mr1019844f8f.26.1754949570246; 
 Mon, 11 Aug 2025 14:59:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1I0Kwlk4hvTXUmkVWOo6mg2t8GP7dHCuySrxB+3ZuQDco3I0+dhKbnztOJPZ6sOGzebUC2CWUxIv5zxShmG8=
X-Received: by 2002:a5d:5d87:0:b0:3a3:65b5:51d7 with SMTP id
 ffacd0b85a97d-3b910fdea25mr1019837f8f.26.1754949569903; Mon, 11 Aug 2025
 14:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250811190159.237321-1-jsnow@redhat.com>
In-Reply-To: <20250811190159.237321-1-jsnow@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 11 Aug 2025 23:59:18 +0200
X-Gm-Features: Ac12FXwuAqixTT7iKRxrj1WIYRzBlcxJ3Vb03r4A5jVvE2fjUiqfKuBjA_fY1ew
Message-ID: <CABgObfZ5izVnO1ZNGEstr55Lko0P4vzuOjaC=Ddy-xgh_hhRwA@mail.gmail.com>
Subject: Re: [PATCH] mkvenv: Support pip 25.2
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, 
 "Sv. Lockal" <lockalsash@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000b69862063c1e09d8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

--000000000000b69862063c1e09d8
Content-Type: text/plain; charset="UTF-8"

Il lun 11 ago 2025, 21:02 John Snow <jsnow@redhat.com> ha scritto:

> From: "Sv. Lockal" <lockalsash@gmail.com>
>
> Fix compilation with pip-25.2 due to missing distlib.version
>

Stupid question: can we just say that, starting with 10.1, people have to
install distlib to build QEMU?

We're bending over backwards just because the Python developers on one hand
keep shipping pip while saying that "no, pip is absolutely not special";
and on the other hand keep *not* shipping packaging and distlib while
complaining that people don't use them.

Paolo

>

--000000000000b69862063c1e09d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il lun 11 ago 2025, 21:02 John S=
now &lt;<a href=3D"mailto:jsnow@redhat.com">jsnow@redhat.com</a>&gt; ha scr=
itto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From: &quo=
t;Sv. Lockal&quot; &lt;<a href=3D"mailto:lockalsash@gmail.com" target=3D"_b=
lank" rel=3D"noreferrer">lockalsash@gmail.com</a>&gt;<br>
<br>
Fix compilation with pip-25.2 due to missing distlib.version<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Stupid question=
: can we just say that, starting with 10.1, people have to install distlib =
to build QEMU?</div><div dir=3D"auto"><br></div><div dir=3D"auto">We&#39;re=
 bending over backwards just because the Python developers on one hand keep=
 shipping pip while saying that &quot;no, pip is absolutely not special&quo=
t;; and on the other hand keep *not* shipping packaging and distlib while c=
omplaining that people don&#39;t use them.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div class=3D"gmail_quote g=
mail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div></div>

--000000000000b69862063c1e09d8--


