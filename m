Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98892C5B543
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 21:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNI4i-0000cR-15; Thu, 05 Jun 2025 17:24:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNI4e-0000c9-RC
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 17:24:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNI4c-00080A-W4
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 17:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749158668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAbRn5jROC+3NkWIVe9mAS1WDn/KYEIIjpKS3r0rsX4=;
 b=bZwkVO5hg0jv9kRjChG9fAyCq2GDbIlLkUjtE+vNxXsimHxsyBHPgV7OJtkvkNlFzTLjwX
 TcKof3I3Ba0YJk32VaRq70yD/1aij96uJlanbazh3FG3YZVUNmChKJaKkHAPEmN60AY721
 oA5TlDh0pM2ICQY5JvUU31jxcX4duik=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-PdqvIq9-OWyqxC_uEajhnw-1; Thu, 05 Jun 2025 17:24:27 -0400
X-MC-Unique: PdqvIq9-OWyqxC_uEajhnw-1
X-Mimecast-MFC-AGG-ID: PdqvIq9-OWyqxC_uEajhnw_1749158666
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-450d290d542so9361305e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 14:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749158665; x=1749763465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lAbRn5jROC+3NkWIVe9mAS1WDn/KYEIIjpKS3r0rsX4=;
 b=CCXcUYitnIiyMp7XFTgvjwGCIN0aWKuFLMSaKV9eD1SY9yvU8LVwYtgARjm73S+LHh
 i/cpul8raesYCwCdl4WqcULBmdvz9/Xh7IidTw/IbTbXsXkbqkj2eIIuP62iB0TJKhM5
 biChuiH/zS1RRYasyzdLJW+1cRxAS0Xdjf8/TILBj8AU/xiowGjtfxVoovgse8aIl0CF
 Y3dC+SsMXW6pcjBeGh1/7DwU3xXZeAuMXCteCBtUCxOpU3eKxtnO644DZsxD0tcaNU1X
 j5X3quYrfHB8kvUGcwJnZgRhB4SMiBzQ8fJA9yLuArGN6Fc90tgsp1PRxqWTdNg+cat1
 hxcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+1N6LXVQpos7uQJas+bwhGei9CFTedt51F5PrikFogULBLbTVjAz1Y40wbn4QBrHjVkXeimgzR4FE@nongnu.org
X-Gm-Message-State: AOJu0YxgBmyCoQ8IfCCFWzBo1N84eerrojbVZ5OMgoWeoX/sjogGF27n
 ljR+b/bmlorN628nCwpCPU5puJ26pIiUUftje2RRw9QpqJrQnwD+kQAPyiWMbzUzyPqr824tlY/
 6WynACf0WuObbDM7xc00g15MgmmJ6iIoLoVWXOklipyIQ0bu/+TTuS+ZDKSEVGbT/LSsmcQMuW8
 wkTT808J/NJwV10WpeEDRL/2Wn5FYE/Lj69wA6mUk=
X-Gm-Gg: ASbGncvzkTzcxkec5Mt0L46F9XGBfMpu47brX/id2SMS+kusLr/gEVo5139aeXZ3pyM
 D5D7ONZqOhCiuDIUSDG87I7T5ait/7VVKazhYNY0eAF5bmPQwKPsX4/3NHo9KC3EwMQIcCU0NF1
 u92A==
X-Received: by 2002:a05:600c:3f12:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-452014d4870mr8434995e9.28.1749158665002; 
 Thu, 05 Jun 2025 14:24:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA+1o2KWqRVpjcQsmo5F1ARFVtHiYUKrybadEuRcwV8hAika373REUd7domzsHeANXRYwBX/yY5vaXIYU5Uc0=
X-Received: by 2002:a05:600c:3f12:b0:43c:fbba:41ba with SMTP id
 5b1f17b1804b1-452014d4870mr8434825e9.28.1749158664644; Thu, 05 Jun 2025
 14:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250601181231.3461-1-tanishdesai37@gmail.com>
 <20250601181231.3461-3-tanishdesai37@gmail.com>
 <20250602222434.GB320269@fedora>
 <7f4eefa2-9e00-4ba2-898f-c480c2123904@redhat.com>
 <CAJSP0QX=e3GkB5L0rpAf8YfkJDKOZYJcx553tut+7Hp2NK3XYg@mail.gmail.com>
 <03c067fc-2a47-4fc5-9204-1ac6ded4301b@redhat.com>
 <aEHt8cL9EAtM3jBm@redhat.com>
In-Reply-To: <aEHt8cL9EAtM3jBm@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 5 Jun 2025 23:24:13 +0200
X-Gm-Features: AX0GCFt9QL0yROzv7tyvYai3RdG-lDpnNhZauu2mProsuGFqJ2XCMi-4dCU_cyQ
Message-ID: <CABgObfYbNQwySn4qY=EXxJvHDaX7jjrns5aCr4mOk3k1GgRjrw@mail.gmail.com>
Subject: Re: [PATCH 2/3] trace/ftrace: seperate cold paths of tracing functions
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Tanish Desai <tanishdesai37@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="000000000000dcbdce0636d9bc29"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

--000000000000dcbdce0636d9bc29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 5 giu 2025, 21:20 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
scritto:

> > > How is this patch series related to Rust tracing? If generated code
> > > needs to be restructured so Rust can call it, then that's a strong
> > > justification.
> > Well, moving code to the .c file would make it possible to call it in
> Rust
> > without duplicating code generation for the various backends (other tha=
n
> the
> > "if" and function calls, of course, but those are easy). However, this =
is
> > only handy and not absolutely necessary for the Rust tracing project.
>
> This might work for some trace backends, but certainly for dtrace/systemt=
ap
> I'd expect us to use a native rust impl to get the optimal low overhead.
>

Yes, dtrace and ust are special. But they also have very small code
generation, so there would also be no reason to do a patch like this one
for them.

Paolo


> With regards,
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

--000000000000dcbdce0636d9bc29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il gio 5 giu 2025, 21:20 Daniel =
P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat=
.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
&gt; &gt; How is this patch series related to Rust tracing? If generated co=
de<br>
&gt; &gt; needs to be restructured so Rust can call it, then that&#39;s a s=
trong<br>
&gt; &gt; justification.<br>
&gt; Well, moving code to the .c file would make it possible to call it in =
Rust<br>
&gt; without duplicating code generation for the various backends (other th=
an the<br>
&gt; &quot;if&quot; and function calls, of course, but those are easy). How=
ever, this is<br>
&gt; only handy and not absolutely necessary for the Rust tracing project.<=
br>
<br>
This might work for some trace backends, but certainly for dtrace/systemtap=
<br>
I&#39;d expect us to use a native rust impl to get the optimal low overhead=
.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>Yes, dtrace and ust are special. But they also have very small code genera=
tion, so there would also be no reason to do a patch like this one for them=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D=
"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_co=
ntainer"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
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
</blockquote></div></div></div>

--000000000000dcbdce0636d9bc29--


