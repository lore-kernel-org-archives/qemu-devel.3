Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC938C4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:49:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZWfp-0003yy-I9; Mon, 12 Feb 2024 08:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rZWfn-0003xr-T3
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:48:39 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <n.ostrenkov@gmail.com>)
 id 1rZWfm-0004iH-5v
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:48:39 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-296b2e44a3cso1533962a91.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 05:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707745716; x=1708350516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4dQwDkUXtSr2dnvZhP96hdFiOyqylmerfmcj/CKoFI=;
 b=QLJ22TdCgsGcFSSDCD9AJ2wNPxfb9mV0w5f0hA9MhSj2lAhIJ5D4oYOuHaKoKdPd4k
 IbmAI1qd2CW361Y1Q1OfWxE1m19i/L67CfEnMZA7JwTim1PC3kCBV+vz1t84umfJsQzB
 Fak1UmQa6lScMr+ZKQmZNdGzr/kn5lvQ7EGK2LxMOdIfi6AbCvCYFrvftJL8LP0/N7G9
 ICzKlIK39ZKLG/RU7+/y2DXsDaJrKiXMPQQYP5iuRNjMAj9qSj/xsjXegbv0Y4+3vvGK
 jw06/FOdJKeEesUMjYXp7Lott8ohTDvst8nXvc82AuRTwIk415zKXYJcPFzqr9Zj3kPh
 5rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707745716; x=1708350516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4dQwDkUXtSr2dnvZhP96hdFiOyqylmerfmcj/CKoFI=;
 b=O3y5dosOVeWjVQPy1xMnpaT803qMjApMQQldaWbPZ9roGTLwnPFPKdPmyHrArwqAta
 Ju5quqseGh0QHuQ7b/0I8rZAp/bpTwp8iAAcy2fLDh/0HvikCD1+WZKdYAyb4mrWOD5L
 rtda7uJ/L90viOIZ1KL0RpGx28oF2QB6FhtgsCGW/8tYjOQSftogkR4XdF4Gm72UjXQb
 6YKPVi59jlYhNwX3K/A/qEpujeFvL2c2Gk0evYGVAZAhGbFNAlch9gqTQH4apnfJ4D3J
 q1ukzzjerh3ZivBPEZj0KsP9XcoPbA/QFPbJlibrA3YAzw8Dsnw+nbSfKRLgnTaxxKM+
 HrNg==
X-Gm-Message-State: AOJu0YyKndoG0bt9rHOArNRR67ZgG0uts0WyjpitOmDdIsLPQb4b3H2S
 IZM1kyNkLe+ZrEAhpEB6v5rN3x2Lfbehf0zhpYkKnNwfU+k0b7moKnHV/cOeEI0yamOdxpEUHQJ
 LLlqEMQZRSkZTCqm/2ATRQfDvzX1VfXLFSrP8dA==
X-Google-Smtp-Source: AGHT+IFxKKqkb/6432NZD3VtI9yto22VAZdnE9YwMhAYiSoS4/j2TUgRJT8kkE3ECszn1T/RckdoDqJxvsXT8tUwoVE=
X-Received: by 2002:a17:90a:db93:b0:297:fb7:fe1 with SMTP id
 h19-20020a17090adb9300b002970fb70fe1mr3256673pjv.46.1707745716076; Mon, 12
 Feb 2024 05:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20231117173916.3658-1-n.ostrenkov@gmail.com>
 <CAC8KSA1SydreP4hT+3bJS-tZeeFH5_ZWbHCMCAMedM1pYjMP-w@mail.gmail.com>
 <CAC8KSA3B47ceDtNW9DySAPGx4wEOqMGnJ5+NzoXqskurPb3SvQ@mail.gmail.com>
In-Reply-To: <CAC8KSA3B47ceDtNW9DySAPGx4wEOqMGnJ5+NzoXqskurPb3SvQ@mail.gmail.com>
From: Nikita Ostrenkov <n.ostrenkov@gmail.com>
Date: Mon, 12 Feb 2024 16:48:21 +0300
Message-ID: <CAC8KSA0Un3K6i6cTX9PrbM8PhQnj_3hyuKnzaWt+TQXibqfaNQ@mail.gmail.com>
Subject: Re: [PATCH v3] hw/usb: fix xhci port notify
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, mjt@tls.msk.ru
Content-Type: multipart/alternative; boundary="000000000000c607b806112f88d8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=n.ostrenkov@gmail.com; helo=mail-pj1-x1035.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000c607b806112f88d8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(+Michael)

ping
https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/

=D1=87=D1=82, 25 =D1=8F=D0=BD=D0=B2. 2024=E2=80=AF=D0=B3. =D0=B2 23:06, Nik=
ita Ostrenkov <n.ostrenkov@gmail.com>:

> ping
> https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/
>
> =D0=BF=D0=BD, 18 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=D0=B3., 13:40 Nikita O=
strenkov <n.ostrenkov@gmail.com>:
>
>> ping
>> https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/
>>
>> =D0=BF=D1=82, 17 =D0=BD=D0=BE=D1=8F=D0=B1. 2023=E2=80=AF=D0=B3., 20:39 N=
ikita Ostrenkov <n.ostrenkov@gmail.com>:
>>
>>> From MCF5253 Reference manual
>>> https://www.nxp.com/docs/en/reference-manual/MCF5253RM.pdf
>>>
>>> Host mode: Port Change Detect. The controller sets this bit to a one
>>> when on any port a Connect Status occurs, a PortEnable/Disable Change
>>> occurs, an Over Current Change occurs, or the Force Port Resume bit is =
set
>>> as theresult of a J-K transition on the suspended port.
>>>
>>> Signed-off-by: Nikita Ostrenkov <n.ostrenkov@gmail.com>
>>> ---
>>>  hw/usb/hcd-xhci.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>> index 4b60114207..1b2f4ac721 100644
>>> --- a/hw/usb/hcd-xhci.c
>>> +++ b/hw/usb/hcd-xhci.c
>>> @@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port,
>>> uint32_t bits)
>>>      if (!xhci_running(port->xhci)) {
>>>          return;
>>>      }
>>> +    port->xhci->usbsts |=3D USBSTS_PCD;
>>>      xhci_event(port->xhci, &ev, 0);
>>>  }
>>>
>>> --
>>> 2.34.1
>>>
>>>

--000000000000c607b806112f88d8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">(+Michael)<div><br></div><div>ping<div dir=3D"auto"><a hre=
f=3D"https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/"=
 target=3D"_blank">https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenk=
ov@gmail.com/</a></div></div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 25 =D1=8F=D0=BD=D0=B2. 2024=E2=
=80=AF=D0=B3. =D0=B2 23:06, Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostren=
kov@gmail.com">n.ostrenkov@gmail.com</a>&gt;:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex"><div dir=3D"auto">ping<div dir=3D"auto"><a hr=
ef=3D"https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail.com/=
" target=3D"_blank">https://patchew.org/QEMU/20231117173916.3658-1-n.ostren=
kov@gmail.com/</a></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">=D0=BF=D0=BD, 18 =D0=B4=D0=B5=D0=BA. 2023=E2=80=AF=
=D0=B3., 13:40 Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmail.com=
" target=3D"_blank">n.ostrenkov@gmail.com</a>&gt;:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"auto">ping<div dir=3D"auto">=
<a href=3D"https://patchew.org/QEMU/20231117173916.3658-1-n.ostrenkov@gmail=
.com/" rel=3D"noreferrer" target=3D"_blank">https://patchew.org/QEMU/202311=
17173916.3658-1-n.ostrenkov@gmail.com/</a><br></div></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 17 =D0=BD=
=D0=BE=D1=8F=D0=B1. 2023=E2=80=AF=D0=B3., 20:39 Nikita Ostrenkov &lt;<a hre=
f=3D"mailto:n.ostrenkov@gmail.com" rel=3D"noreferrer" target=3D"_blank">n.o=
strenkov@gmail.com</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">From MCF5253 Reference manual <a href=3D"https://www.nxp.com/do=
cs/en/reference-manual/MCF5253RM.pdf" rel=3D"noreferrer noreferrer noreferr=
er" target=3D"_blank">https://www.nxp.com/docs/en/reference-manual/MCF5253R=
M.pdf</a><br>
<br>
Host mode: Port Change Detect. The controller sets this bit to a one when o=
n any port a Connect Status occurs, a PortEnable/Disable Change occurs, an =
Over Current Change occurs, or the Force Port Resume bit is set as theresul=
t of a J-K transition on the suspended port.<br>
<br>
Signed-off-by: Nikita Ostrenkov &lt;<a href=3D"mailto:n.ostrenkov@gmail.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">n.ostrenkov@gmail.com</a>=
&gt;<br>
---<br>
=C2=A0hw/usb/hcd-xhci.c | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
index 4b60114207..1b2f4ac721 100644<br>
--- a/hw/usb/hcd-xhci.c<br>
+++ b/hw/usb/hcd-xhci.c<br>
@@ -2627,6 +2627,7 @@ static void xhci_port_notify(XHCIPort *port, uint32_t=
 bits)<br>
=C2=A0 =C2=A0 =C2=A0if (!xhci_running(port-&gt;xhci)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 port-&gt;xhci-&gt;usbsts |=3D USBSTS_PCD;<br>
=C2=A0 =C2=A0 =C2=A0xhci_event(port-&gt;xhci, &amp;ev, 0);<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>
</blockquote></div>
</blockquote></div>

--000000000000c607b806112f88d8--

