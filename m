Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C98BD7497D
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 07:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t62wU-0005uY-4g; Wed, 30 Oct 2024 03:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t62wS-0005uE-NJ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 03:16:32 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1t62wP-00019s-SQ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 03:16:31 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-50d3d4d2ad2so2344706e0c.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 00:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730272588; x=1730877388; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RXtWYJ9webn5vyHBbRScmR1AohXSlxZsQIb3Ew481E4=;
 b=iIhUkCyKSyTEFXwlFItjhDquxTD8/QpU1jaZU6Su82frUo2QOaRTVDRN/mpD2Dllh1
 ezSdWhbJt1NmNvOyHB0jc0CGOkIk4ICA6yNMQBmbx/CTUjO6x81QoLOQ1jEwW9Co2lAJ
 SK9wLKHORCRUtZFDlw7MSGMX26fSSu2Lie2E+LXmS2tOIwrlaniBz2T4Pv/v9YQWavQg
 /d9svmNIIeUnXc/NRuAY+wtVktcGG8e3FVWj2rNN22YfHVfYkT6PXkcebO13Dwy+v/OP
 74cysFz8zUgQ02Q2ZbRYcgOf4WPiOTVb8eubywFU/tzI/owIRP3+fE0TQuM7hT3b2UJ6
 tCqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730272588; x=1730877388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RXtWYJ9webn5vyHBbRScmR1AohXSlxZsQIb3Ew481E4=;
 b=phPMTtvOuzPukYprDW//A4LjhJZJvl1D7+W9xPWofYirLKHF3McpdqTPryFlGfqje6
 1vTWBFk98a0V8qMUN3V6vr7E/7KaQOYHHGvKnOHkDvn3F6EEwTj4FbXkW8jPSH59xSd3
 yyWiABvXxNgslLHqR0yr4JHm6o18PWig7uBMgp+NZ4n7Xd73+b+Qr6a1WMd6SvZMuBvE
 iCtIVq0C89AWuQoiB99AJeIN/HjuIqjJl0sHPnl9pTfs16OpqT6DqqcFWQAEaX3t67lu
 56Ra+3lrAFabqyKLEnMB1NTf2PCWChtEcdHG+HmmdmGUqI/lUu81o0hoYPPVD/ZRdvS/
 X8+w==
X-Gm-Message-State: AOJu0YwfBjKTjyZvHvM3LoaG+43Y9WNVD2AcK7Pn1D3NUSCCyynlyOFz
 JNjXBUl4a9Aic/wZYYvKsAI7ZxqIiwG8JB1OdYtJ7B4CPeevD5ka3r9gs4ix3KcJy+YvZ4498fT
 WSVrgJUf1tVvQ6APplFpTI04DI50=
X-Google-Smtp-Source: AGHT+IEWSmt1NT00+D+//kpoHhu1AryPVt8sI7nzQiX2Zk15khg3QwoGMJ5JaXODZUcG7MLKFAtpmlfdOPEBK9c3Lpk=
X-Received: by 2002:a05:6122:3c46:b0:50a:b5a3:e00c with SMTP id
 71dfb90a1353d-51015009e23mr12304425e0c.1.1730272587699; Wed, 30 Oct 2024
 00:16:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241008211727.49088-1-dorjoychy111@gmail.com>
 <5839222b-4d61-419b-80a2-cc7afb36abc9@amazon.com>
 <CAFfO_h5HquFuWQSo0n009dgi48Qoi_5MdRFuHOuHMGWNB2Q8+A@mail.gmail.com>
 <CAFfO_h4QCDc5qTP_U+-c0NTxPh5J53x876e5aVskMHx28OUerQ@mail.gmail.com>
 <54fe9ff2-ee5c-42dc-adb0-b4131a496a0a@redhat.com>
 <CAFfO_h7pFJUkm=BgJwyMYoVfj5GOb8oGivfcPfu9UrSix19_Ow@mail.gmail.com>
 <CABgObfbftKsxNkQeW_zv+tyCATM+hDC3JrhLtFVH1H2144QWpw@mail.gmail.com>
In-Reply-To: <CABgObfbftKsxNkQeW_zv+tyCATM+hDC3JrhLtFVH1H2144QWpw@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 30 Oct 2024 13:16:15 +0600
Message-ID: <CAFfO_h6i0bA9K2e6KwEevzKH5G1v6K1kZEGBB4u=6SikhaOijg@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] AWS Nitro Enclave emulation support
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>, 
 Alexander Graf <graf@amazon.com>, stefanha@redhat.com, slp@redhat.com, 
 Richard Henderson <richard.henderson@linaro.org>, eduardo@habkost.net, 
 "Michael S. Tsirkin" <mst@redhat.com>, marcel.apfelbaum@gmail.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000f461140625ac7a1a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=dorjoychy111@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000f461140625ac7a1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024, 1:03 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On Tue, Oct 29, 2024 at 9:08=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gm=
ail.com>
> wrote:
> > Thanks for fixing. The attached patch looks great to me. I just have
> > one suggestion. Now that the CONFIG_* symbols have the dependencies
> > listed explicitly in the Kconfig files, maybe we don't need the
> > explicit dependencies in the meson.build files? For example, the
> > following line in hw/core/meson.build file:
> > system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib,
> > libcbor, gnutls])
> > can be changed to:
> > system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c')])
> >
> > I am not sure if zlib is a required dependency for QEMU, probably not
> > needed to be listed above as well. I am just guessing.
>
> No, because the dependencies are not automatically added to all
> compiler and linker commands.  Having them in the "add" call lets the
> compiler find include files and the linker add the dependency to the
> executable.
>
> As an aside,
>
>   if foo.found()
>     system_ss.add(files('x.c'))
>   endif
>
> can be written
>
>   system_ss.add(when: foo, if_true: files('x.c'))
>
> and "when:" supports multiple entries.  But in this case it's okay to
> put it only in "if_true", since the dependency is handled in the
> Kconfig files and guaranteed to be present.
>

Understood. All good then. Thanks!

Regards,
Dorjoy

--000000000000f461140625ac7a1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Wed, Oct 30, 2024, 1:03 PM Paolo Bonzini &lt;<a hre=
f=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">On Tue, Oct 29, 2024 at 9:08=E2=80=AFPM Do=
rjoy Chowdhury &lt;<a href=3D"mailto:dorjoychy111@gmail.com" target=3D"_bla=
nk" rel=3D"noreferrer">dorjoychy111@gmail.com</a>&gt; wrote:<br>
&gt; Thanks for fixing. The attached patch looks great to me. I just have<b=
r>
&gt; one suggestion. Now that the CONFIG_* symbols have the dependencies<br=
>
&gt; listed explicitly in the Kconfig files, maybe we don&#39;t need the<br=
>
&gt; explicit dependencies in the meson.build files? For example, the<br>
&gt; following line in hw/core/meson.build file:<br>
&gt; system_ss.add(when: &#39;CONFIG_EIF&#39;, if_true: [files(&#39;eif.c&#=
39;), zlib,<br>
&gt; libcbor, gnutls])<br>
&gt; can be changed to:<br>
&gt; system_ss.add(when: &#39;CONFIG_EIF&#39;, if_true: [files(&#39;eif.c&#=
39;)])<br>
&gt;<br>
&gt; I am not sure if zlib is a required dependency for QEMU, probably not<=
br>
&gt; needed to be listed above as well. I am just guessing.<br>
<br>
No, because the dependencies are not automatically added to all<br>
compiler and linker commands.=C2=A0 Having them in the &quot;add&quot; call=
 lets the<br>
compiler find include files and the linker add the dependency to the<br>
executable.<br>
<br>
As an aside,<br>
<br>
=C2=A0 if foo.found()<br>
=C2=A0 =C2=A0 system_ss.add(files(&#39;x.c&#39;))<br>
=C2=A0 endif<br>
<br>
can be written<br>
<br>
=C2=A0 system_ss.add(when: foo, if_true: files(&#39;x.c&#39;))<br>
<br>
and &quot;when:&quot; supports multiple entries.=C2=A0 But in this case it&=
#39;s okay to<br>
put it only in &quot;if_true&quot;, since the dependency is handled in the<=
br>
Kconfig files and guaranteed to be present.<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Understood. All good then. Thank=
s!</div><div dir=3D"auto"><br></div><div dir=3D"auto">Regards,</div><div di=
r=3D"auto">Dorjoy</div></div>

--000000000000f461140625ac7a1a--

