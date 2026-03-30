Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16CBFF4954
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 06:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w76Un-0003fN-01; Mon, 30 Mar 2026 02:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w76Ul-0003eo-M3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w76Uj-0002VH-4U
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 02:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774853583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TLbww21pZiHN2WIuueS8p9qQpEMTdf0rmHSqoGzQQQo=;
 b=Z6Jv4XJq+W3Wa4d89/G42J/cYkipheVfgyNiAao53dDKAGLlvfHc2gRzBbEjmjwUHlJXnt
 MjbxNYxFiVCa4f28ST1/uXl5yUU8OzFCGNslaDo1jK1b3o45YonhZg7MkW42uVKHl2JTnl
 R0pp2n9O0C7AgYq7pfXHDDspcke1BUc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-sMLPZaEOPjGS6E5k6ukGsg-1; Mon, 30 Mar 2026 02:53:01 -0400
X-MC-Unique: sMLPZaEOPjGS6E5k6ukGsg-1
X-Mimecast-MFC-AGG-ID: sMLPZaEOPjGS6E5k6ukGsg_1774853581
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso124609061cf.3
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2026 23:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774853580; cv=none;
 d=google.com; s=arc-20240605;
 b=DxdgLRwVoQqJpmTTkVxw714lqD9WgEoHhRpC1GjUFrwMlSMNKM9ZhvuT45uDbWlArB
 2yi7Vs8H/GAC056nh3VdvJ7MI31D+UxsiFLe1H7mMf/mf4BZDBmh8yU0wIbnayaPEQ4K
 sIcGKH775TlT1GutEAP5JcTGoUd6l/y8rnSJfqyOHXhXWwsJTIJb11ES4vkDWgo+/Kbz
 Psd0S4PQnJ/09HDdUsKEbBaidmTSv0SfesvEhNkYdc6sD5734JlaJYHGh4HkaIc0CMJV
 MrPIPYSKQNticoDkGphVmByxKBk5HDz2CLwhsHBvabYAb8BOPl2vfCgt5ekjM6btEoQ3
 GpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TLbww21pZiHN2WIuueS8p9qQpEMTdf0rmHSqoGzQQQo=;
 fh=3ZOfzaKfpZLpAyqiSwIuDni0h5/3VpLid8goAI8W3cU=;
 b=F34iOTMP7rXzkLjN6xCD4z4s2BLnpGyOOfobDwJzcoWFbyZpBbq3PnAgF+EP9eAXvn
 pt4KvF3kwIltqrzFGv9Gy4wTGOvql+TwI+ecrAXgTqSVu6Ozc9PmgRwohAhx3yXHdz13
 IISNRF1gkfRntKnNxY8jUrrZPIqXAQ1EVL9MjKZcjHxtp6+dKQsefpSHjH9MydNLJ8lg
 xhHa9l5JVrN0ZdGj/j0AgbaXFwl+Xuimlzzc1b2jL1c/0IsWltgdaiYaLX4Ht2cgv9P6
 68dmPYp5SNKGGaw0eFyVpWPUyse05mvhQ29RI3Aq7yz6tekqvpoEEjzUm/uzFibo6b8C
 sFgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774853580; x=1775458380; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TLbww21pZiHN2WIuueS8p9qQpEMTdf0rmHSqoGzQQQo=;
 b=To9k44cUra8LFevuhk0me5lh0tyOTHAZjZEPbdmjSH6ipQfTnh9+WcJWzGDZTPO3Pv
 hJQdMnTaB6sgpzxFsNBcsBtMcUxBObyTwnCXEdTGSo9y3dmw/LT47RUVgTWjNCWvBww7
 SLB3dOht7wa1PSSZ0ZmcWVkFsDr5x4rnfl7IK+SQTklfEKJyaW2GXbAjM/G/egt183US
 CQ+ESDAPPSmE5Wwch0lXBT/5cyjynI3FygQ37tc9qVfLjOKxDn5HAjM5z87IooEp90D2
 eUVqwyGIsf8yNEjbwUjIYHkXUe/0Y5+nWdeROST84ffWlcgg8XiCMTv3EIz43QKvc1Hy
 EQSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774853580; x=1775458380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLbww21pZiHN2WIuueS8p9qQpEMTdf0rmHSqoGzQQQo=;
 b=qvXXSNHSv/hIgAMreb3i5IRdWY9UM/DZPsWyHjPlAKXIojTCd/pJWVaKqmmLtrCHHm
 WhRq73Iyxl4y+dKE5FwT39viVQhLOg6ywlVlP5n0kaTd8sBlGD5X1mc5B8fwJC90xKB9
 +lZyMi47CJio/9y4NcnXRc8re6dNMGwNMEFKA4tcLmDNjKrDrUiv0Poq7Y5tciaoA9XL
 0KFhAbX2mbgSmmfPT+0AwOB1jKh2pcLFscc71Kdz42Z548HFLZ/kZBKwnrkk7xYNbarV
 La96DUf59NxpjNE1I5gT3gsNIHRPlzSn4RrOPt0cKVORM7H4ZR1c1Wtp5irAGtmtFFLm
 2NcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGgs653m4C3kFFP+WOztr5/gL1xtAMJ+L7zWYyXVdCr5q0b/gJXlyd2ko4Bbmn9/huXBSQKPbB4mMO@nongnu.org
X-Gm-Message-State: AOJu0Yzk8Mdj+Wi32xjDY6Mb8sMSV0DLrFJ7jaw52rJezcONQd4Xbh8t
 21EuwXnh12chMzMCev3jrAMVFRhMVzWCtq994DfFc4pSzzBD1hUSqYHd8FXttK8F5g1X2iy0Nh1
 Yhmkx7GvZKKyyrP3FTfKefR8HJiBhAZhLTn0o8MWTZiwZa6W6ty4/ZFBq2H+vit2K426nDmcutA
 H7HDEmu6EVqlIAsxNfbWD3WSyPONdLMlg=
X-Gm-Gg: ATEYQzxl2eMuWjJ7NBI9MLyaadgR9U66jya6jVNIMyGcaYpV62d6Bwske8B8QK4ufuQ
 VEXrxx9fU8TzvQJuCSpHgpetzAddxMhJPHgVPSCgKVn+BivUrk98LrXCykJ4kF4jDmsBzmLsZpn
 giAS5n2Ji9O3v3weOkQ5hwwadc+FRh6SgaBb05jC5/9aLrn30OiFsLUWj/1mIAuW0zxFRffP5a+
 A2FPJjC
X-Received: by 2002:ac8:5754:0:b0:509:4d26:25df with SMTP id
 d75a77b69052e-50ba39c1849mr147012241cf.66.1774853580536; 
 Sun, 29 Mar 2026 23:53:00 -0700 (PDT)
X-Received: by 2002:ac8:5754:0:b0:509:4d26:25df with SMTP id
 d75a77b69052e-50ba39c1849mr147011961cf.66.1774853580022; Sun, 29 Mar 2026
 23:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260327145012.907264-1-peter.maydell@linaro.org>
 <CAKmqyKMUaHQ2uiqVnT7M98AFenmZOGJd5AAShgtKt5RgDo8APg@mail.gmail.com>
In-Reply-To: <CAKmqyKMUaHQ2uiqVnT7M98AFenmZOGJd5AAShgtKt5RgDo8APg@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 30 Mar 2026 09:52:49 +0300
X-Gm-Features: AQROBzCXE40WsDV_T-TLJrQn6B1LEDwJXzRbTAX9rpgTk5rJ71CwAci0IXeeaS0
Message-ID: <CAPMcbCqFHi=se+RRLJAeekaSxVCv7ft6vcRV-u=QGDCOWyRLRA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/xilinx_zynq: Use strcasecmp to parse boot-mode
 option values
To: Alistair Francis <alistair23@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: multipart/alternative; boundary="0000000000002a831b064e384d6a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000002a831b064e384d6a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Mon, Mar 30, 2026 at 7:32=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com>
wrote:

> On Sat, Mar 28, 2026 at 12:51=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org>
> wrote:
> >
> > In zynq_set_boot_mode() where we parse the string the user has set
> > the boot-mode option to, we use strncasecmp(str, "qspi", 4) and so
> > on.  This is wrong, because it means that we will ignore any trailing
> > junk on the end of the option string, and handle
> >  -machine boot-mode=3DsdXYZZY
> > the same as
> >  -machine boot-mode=3Dsd
> >
> > In the documentation we say:
> >  Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.
> > and that's obviously what we meant to implement.
> >
> > The correct tool for this job is a simple strcasecmp operation.
> > Switch to that.
> >
> > We use the g_ascii_strcasecmp() rather than plain strcasecmp()
> > because we're comparing ASCII strings here and don't want the
> > potentially locale-specific behaviour that strcasecmp() implies (and
> > we're trying to standardize on the glib function for this kind of
> > string comparison).
> >
> > Fixes: 7df3747c92d13 ("hw/arm/xilinx_zynq: Add boot-mode property")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>
> Alistair
>
> > ---
> > Kostiantyn: I sent this patch out while it was on my mind, but
> > don't worry about conflicts with your series -- assuming your
> > patchset goes in first I'll fix this one up later.
> > ---
> >  hw/arm/xilinx_zynq.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
> > index d43f36b718..9dcded9219 100644
> > --- a/hw/arm/xilinx_zynq.c
> > +++ b/hw/arm/xilinx_zynq.c
> > @@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, const
> char *str,
> >      ZynqMachineState *m =3D ZYNQ_MACHINE(obj);
> >      uint8_t mode =3D 0;
> >
> > -    if (!strncasecmp(str, "qspi", 4)) {
> > +    if (!g_ascii_strcasecmp(str, "qspi")) {
> >          mode =3D 1;
> > -    } else if (!strncasecmp(str, "sd", 2)) {
> > +    } else if (!g_ascii_strcasecmp(str, "sd")) {
> >          mode =3D 5;
> > -    } else if (!strncasecmp(str, "nor", 3)) {
> > +    } else if (!g_ascii_strcasecmp(str, "nor")) {
> >          mode =3D 2;
> > -    } else if (!strncasecmp(str, "jtag", 4)) {
> > +    } else if (!g_ascii_strcasecmp(str, "jtag")) {
> >          mode =3D 0;
> >      } else {
> >          error_setg(errp, "%s boot mode not supported", str);
> > --
> > 2.43.0
> >
> >
>
>

--0000000000002a831b064e384d6a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Mon, Mar 30, 2026 at 7:32=E2=80=AFAM Alistair Francis &lt;<a hr=
ef=3D"mailto:alistair23@gmail.com">alistair23@gmail.com</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">On Sat, Mar 28, 2026=
 at 12:51=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@lina=
ro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; In zynq_set_boot_mode() where we parse the string the user has set<br>
&gt; the boot-mode option to, we use strncasecmp(str, &quot;qspi&quot;, 4) =
and so<br>
&gt; on.=C2=A0 This is wrong, because it means that we will ignore any trai=
ling<br>
&gt; junk on the end of the option string, and handle<br>
&gt;=C2=A0 -machine boot-mode=3DsdXYZZY<br>
&gt; the same as<br>
&gt;=C2=A0 -machine boot-mode=3Dsd<br>
&gt;<br>
&gt; In the documentation we say:<br>
&gt;=C2=A0 Supported values are ``jtag``, ``sd``, ``qspi`` and ``nor``.<br>
&gt; and that&#39;s obviously what we meant to implement.<br>
&gt;<br>
&gt; The correct tool for this job is a simple strcasecmp operation.<br>
&gt; Switch to that.<br>
&gt;<br>
&gt; We use the g_ascii_strcasecmp() rather than plain strcasecmp()<br>
&gt; because we&#39;re comparing ASCII strings here and don&#39;t want the<=
br>
&gt; potentially locale-specific behaviour that strcasecmp() implies (and<b=
r>
&gt; we&#39;re trying to standardize on the glib function for this kind of<=
br>
&gt; string comparison).<br>
&gt;<br>
&gt; Fixes: 7df3747c92d13 (&quot;hw/arm/xilinx_zynq: Add boot-mode property=
&quot;)<br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
<br>
Reviewed-by: Alistair Francis &lt;<a href=3D"mailto:alistair.francis@wdc.co=
m" target=3D"_blank">alistair.francis@wdc.com</a>&gt;<br>
<br>
Alistair<br>
<br>
&gt; ---<br>
&gt; Kostiantyn: I sent this patch out while it was on my mind, but<br>
&gt; don&#39;t worry about conflicts with your series -- assuming your<br>
&gt; patchset goes in first I&#39;ll fix this one up later.<br>
&gt; ---<br>
&gt;=C2=A0 hw/arm/xilinx_zynq.c | 8 ++++----<br>
&gt;=C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c<br>
&gt; index d43f36b718..9dcded9219 100644<br>
&gt; --- a/hw/arm/xilinx_zynq.c<br>
&gt; +++ b/hw/arm/xilinx_zynq.c<br>
&gt; @@ -186,13 +186,13 @@ static void zynq_set_boot_mode(Object *obj, cons=
t char *str,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ZynqMachineState *m =3D ZYNQ_MACHINE(obj);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 uint8_t mode =3D 0;<br>
&gt;<br>
&gt; -=C2=A0 =C2=A0 if (!strncasecmp(str, &quot;qspi&quot;, 4)) {<br>
&gt; +=C2=A0 =C2=A0 if (!g_ascii_strcasecmp(str, &quot;qspi&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 1;<br>
&gt; -=C2=A0 =C2=A0 } else if (!strncasecmp(str, &quot;sd&quot;, 2)) {<br>
&gt; +=C2=A0 =C2=A0 } else if (!g_ascii_strcasecmp(str, &quot;sd&quot;)) {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 5;<br>
&gt; -=C2=A0 =C2=A0 } else if (!strncasecmp(str, &quot;nor&quot;, 3)) {<br>
&gt; +=C2=A0 =C2=A0 } else if (!g_ascii_strcasecmp(str, &quot;nor&quot;)) {=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 2;<br>
&gt; -=C2=A0 =C2=A0 } else if (!strncasecmp(str, &quot;jtag&quot;, 4)) {<br=
>
&gt; +=C2=A0 =C2=A0 } else if (!g_ascii_strcasecmp(str, &quot;jtag&quot;)) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mode =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;%s boot mode =
not supported&quot;, str);<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
&gt;<br>
<br>
</blockquote></div>

--0000000000002a831b064e384d6a--


