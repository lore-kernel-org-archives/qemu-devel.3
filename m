Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6F0C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 20:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4RIi-0000ql-FF; Tue, 07 May 2024 16:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s4RIe-0000qO-Sd
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:20:33 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1s4RIY-0007If-Lq
 for qemu-devel@nongnu.org; Tue, 07 May 2024 16:20:28 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-47f1100e05bso445677137.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 13:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715113225; x=1715718025; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2flm7HEJirpC5j9XGWqujVZQXGgfIwtVcJ7Eoi0Uxc8=;
 b=HuqGSnG7ZltZnsobINZGmZUcqlv76IOEdoTtYOsD9w2yCCh6e79jUk+9H5aTIGUhhs
 69gSOaOrUt0B5Uy4aWAW/zZ5bEFwVKvxPfHXd01iCcdZZeKgr5uslLwlQ2o9xVYtHyqw
 Wa1CLVAwbNpU3zvVQq8PcJj6o6czlR5SS/jUdO5gdZL35VegmPGCT3wZW5ZeDg/GoPNt
 zZn/+Y+BMU7FMUvzviL9WGXbgfKHiQ0tmxOXWxLqsXHbS4XUZMoPgfO95usV/9qdmFOt
 QxOfutyN+46I+DaSXS2V0D35UZAevJVASoFo3r3ZjPqB8kywPYrdl8ctHwKdUgd0e6Se
 AE8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715113225; x=1715718025;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2flm7HEJirpC5j9XGWqujVZQXGgfIwtVcJ7Eoi0Uxc8=;
 b=B6FFr14jcz169aWB+Twmldu7Eb3y6d8bhNEIMBo+uRk6MQws1IOWaodYfnp1Mmu/QY
 uV/4d9ftwPTcvNGa/ZvTdM784P65hkiZIWYmDHlToECu9pd9+8+pzLjWCjgpwQCO5xo3
 zrTRJ0XcFYhaSfogNbDiuLJDTX8xwI/WXcSjdTr+I0Ra7PPtUKry83+oNJ0pYEBD59po
 0oJSd4YJuVSpz9QeNQ64m6TADGZRHKH4L73oxBOCi8BkRiZHi9isnyB6SEiGeWCuMtZp
 ZxJyxS5rFbv8Hyh/PSNI0VIm+sFhR/+8C+8PVzVdauFXwKZOIwKU2vEgM0PlREMhnjEg
 X9hQ==
X-Gm-Message-State: AOJu0Yx9S9ShiZbEdgud+rpnTzKzvpbdmN32vORCXLB5LkjMT39TAgql
 cnflHoSmVwAbkgDqwr+xxFIAy3v8PfiMJz9IQ1IzLW1UNHrxjP+w+c4nVblIfDLqpJliKh3+gxQ
 VYe9gtOhPRHrv0BHECdsoSdqFiolFcg==
X-Google-Smtp-Source: AGHT+IH+kgEmvVhyV9/pD5jyDV15rOjZ+qqMsUo7vKD5kD+DigLUYRt7ptqF2tmooGrZBMiiByRA3rNKyD6QeaYx81E=
X-Received: by 2002:a67:f295:0:b0:47e:b21d:f4a0 with SMTP id
 ada2fe7eead31-47f3c376d91mr426242137.35.1715113223505; Tue, 07 May 2024
 13:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
 <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
In-Reply-To: <CACBuX0Q_JOp1xGKZjnrBguiXVcM-ApfVrOs9UQE2B7sq=f5vLQ@mail.gmail.com>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Tue, 7 May 2024 15:20:12 -0500
Message-ID: <CACBuX0SUvsip=hj5NbE3g5gCxSmdRKbK-k=ZQz819TDEfvtXgw@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006fcf7a0617e2ea7f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=dmamfmgm@gmail.com; helo=mail-vs1-xe2a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000006fcf7a0617e2ea7f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 3:43=E2=80=AFPM Cord Amfmgm <dmamfmgm@gmail.com> wr=
ote:

> On Thu, Apr 18, 2024 at 10:43=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru>=
 wrote:
>
>> 06.02.2024 10:13, Cord Amfmgm wrote:
>> > This changes the ohci validation to not assert if invalid
>> > data is fed to the ohci controller. The poc suggested in
>> > https://bugs.launchpad.net/qemu/+bug/1907042
>> > and then migrated to bug #303 does the following to
>> > feed it a SETUP pid and EndPt of 1:
>> >
>> >          uint32_t MaxPacket =3D 64;
>> >          uint32_t TDFormat =3D 0;
>> >          uint32_t Skip =3D 0;
>> >          uint32_t Speed =3D 0;
>> >          uint32_t Direction =3D 0;  /* #define OHCI_TD_DIR_SETUP 0 */
>> >          uint32_t EndPt =3D 1;
>> >          uint32_t FuncAddress =3D 0;
>> >          ed->attr =3D (MaxPacket << 16) | (TDFormat << 15) | (Skip << =
14)
>> >                     | (Speed << 13) | (Direction << 11) | (EndPt << 7)
>> >                     | FuncAddress;
>> >          ed->tailp =3D /*TDQTailPntr=3D */ 0;
>> >          ed->headp =3D ((/*TDQHeadPntr=3D */ &td[0]) & 0xfffffff0)
>> >                     | (/* ToggleCarry=3D */ 0 << 1);
>> >          ed->next_ed =3D (/* NextED=3D */ 0 & 0xfffffff0)
>> >
>> > qemu-fuzz also caught the same issue in #1510. They are
>> > both fixed by this patch.
>> >
>> > The if (td.cbp > td.be) logic in ohci_service_td() causes an
>> > ohci_die(). My understanding of the OHCI spec 4.3.1.2
>> > Table 4-2 allows td.cbp to be one byte more than td.be to
>> > signal the buffer has zero length. The new check in qemu
>> > appears to have been added since qemu-4.2. This patch
>> > includes both fixes since they are located very close
>> > together.
>> >
>> > Signed-off-by: David Hubbard <dmamfmgm@gmail.com>
>>
>> Wonder if this got lost somehow.  Or is it not needed?
>>
>> Thanks,
>>
>> /mjt
>>
>
> Friendly ping! Gerd, can you chime in with how you would like to approach
> this? I still need this patch to unblock my qemu workflow - custom OS
> development.
>
>

Can I please ask for an update on this? I'm attempting to figure out if
this patch has been rejected and I need to resubmit / rework it at HEAD?


>
>> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
>> > index d73b53f33c..a53808126f 100644
>> > --- a/hw/usb/hcd-ohci.c
>> > +++ b/hw/usb/hcd-ohci.c
>> > @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
>> > struct ohci_ed *ed)
>> >       case OHCI_TD_DIR_SETUP:
>> >           str =3D "setup";
>> >           pid =3D USB_TOKEN_SETUP;
>> > +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed t=
o
>> ep 0 */
>> > +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
>> > +            ohci_die(ohci);
>> > +            return 1;
>> > +        }
>> >           break;
>> >       default:
>> >           trace_usb_ohci_td_bad_direction(dir);
>> > @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
>> > ohci_ed *ed)
>> >           if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
>> >               len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
>> >           } else {
>> > -            if (td.cbp > td.be) {
>> > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
>> > +            if (td.cbp > td.be + 1) {
>> > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
>> >                   ohci_die(ohci);
>> >                   return 1;
>> >               }
>> > diff --git a/hw/usb/trace-events b/hw/usb/trace-events
>> > index ed7dc210d3..b47d082fa3 100644
>> > --- a/hw/usb/trace-events
>> > +++ b/hw/usb/trace-events
>> > @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
>> > "DataOverrun %d > %zu"
>> >   usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
>> >   usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
>> >   usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
>> > +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp =3D 0x%x > be=
 =3D
>> 0x%x"
>> > +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad
>> > pid %s: ed.flags 0x%x td.flags 0x%x"
>> >   usb_ohci_port_attach(int index) "port #%d"
>> >   usb_ohci_port_detach(int index) "port #%d"
>> >   usb_ohci_port_wakeup(int index) "port #%d"
>> >
>>
>

--0000000000006fcf7a0617e2ea7f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 24, 2024 at 3:43=E2=80=AF=
PM Cord Amfmgm &lt;<a href=3D"mailto:dmamfmgm@gmail.com">dmamfmgm@gmail.com=
</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
<div dir=3D"ltr"><div dir=3D"ltr">On Thu, Apr 18, 2024 at 10:43=E2=80=AFAM =
Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru" target=3D"_blank">mjt=
@tls.msk.ru</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">06.02.2024 10:13, Cord Amfmgm wrote:<=
br>
&gt; This changes the ohci validation to not assert if invalid<br>
&gt; data is fed to the ohci controller. The poc suggested in<br>
&gt; <a href=3D"https://bugs.launchpad.net/qemu/+bug/1907042" rel=3D"norefe=
rrer" target=3D"_blank">https://bugs.launchpad.net/qemu/+bug/1907042</a><br=
>
&gt; and then migrated to bug #303 does the following to<br>
&gt; feed it a SETUP pid and EndPt of 1:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t MaxPacket =3D 64;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t TDFormat =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t Skip =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t Speed =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t Direction =3D 0;=C2=A0 /* #=
define OHCI_TD_DIR_SETUP 0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t EndPt =3D 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t FuncAddress =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;attr =3D (MaxPacket &lt;&lt; =
16) | (TDFormat &lt;&lt; 15) | (Skip &lt;&lt; 14)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| (Speed &lt;&lt; 13) | (Direction &lt;&lt; 11) | (EndPt &lt;&lt; 7)<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| FuncAddress;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;tailp =3D /*TDQTailPntr=3D */=
 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;headp =3D ((/*TDQHeadPntr=3D =
*/ &amp;td[0]) &amp; 0xfffffff0)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| (/* ToggleCarry=3D */ 0 &lt;&lt; 1);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ed-&gt;next_ed =3D (/* NextED=3D */ =
0 &amp; 0xfffffff0)<br>
&gt; <br>
&gt; qemu-fuzz also caught the same issue in #1510. They are<br>
&gt; both fixed by this patch.<br>
&gt; <br>
&gt; The if (td.cbp &gt; <a href=3D"http://td.be" rel=3D"noreferrer" target=
=3D"_blank">td.be</a>) logic in ohci_service_td() causes an<br>
&gt; ohci_die(). My understanding of the OHCI spec 4.3.1.2<br>
&gt; Table 4-2 allows td.cbp to be one byte more than <a href=3D"http://td.=
be" rel=3D"noreferrer" target=3D"_blank">td.be</a> to<br>
&gt; signal the buffer has zero length. The new check in qemu<br>
&gt; appears to have been added since qemu-4.2. This patch<br>
&gt; includes both fixes since they are located very close<br>
&gt; together.<br>
&gt; <br>
&gt; Signed-off-by: David Hubbard &lt;<a href=3D"mailto:dmamfmgm@gmail.com"=
 target=3D"_blank">dmamfmgm@gmail.com</a>&gt;<br>
<br>
Wonder if this got lost somehow.=C2=A0 Or is it not needed?<br>
<br>
Thanks,<br>
<br>
/mjt<br></blockquote><div><br></div><div>Friendly ping! Gerd, can you chime=
 in with how you would like to approach this? I still need this patch to un=
block my qemu workflow - custom OS development.</div><div>=C2=A0</div></div=
></div></blockquote><div><br></div><div>Can I please ask for an update on t=
his? I&#39;m attempting to figure out if this patch has been rejected and I=
 need to resubmit / rework it at HEAD?</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c<br>
&gt; index d73b53f33c..a53808126f 100644<br>
&gt; --- a/hw/usb/hcd-ohci.c<br>
&gt; +++ b/hw/usb/hcd-ohci.c<br>
&gt; @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,<br>
&gt; struct ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case OHCI_TD_DIR_SETUP:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0str =3D &quot;setup&quot;;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pid =3D USB_TOKEN_SETUP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (OHCI_BM(ed-&gt;flags, ED_EN) &gt; 0) =
{=C2=A0 /* setup only allowed to ep 0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohci_td_bad_pid(s=
tr, ed-&gt;flags, td.flags);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ohci_die(ohci);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_ohci_td_bad_directio=
n(dir);<br>
&gt; @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct=
<br>
&gt; ohci_ed *ed)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((td.cbp &amp; 0xfffff000) =
!=3D (<a href=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</=
a> &amp; 0xfffff000)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D (<a href=
=3D"http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> &amp; 0xff=
f) + 0x1001 - (td.cbp &amp; 0xfff);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a>) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_iso_td_bad_cc_overrun(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer"=
 target=3D"_blank">td.be</a>);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (td.cbp &gt; <a href=3D"=
http://td.be" rel=3D"noreferrer" target=3D"_blank">td.be</a> + 1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_usb_ohc=
i_td_bad_buf(td.cbp, <a href=3D"http://td.be" rel=3D"noreferrer" target=3D"=
_blank">td.be</a>);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0oh=
ci_die(ohci);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0re=
turn 1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/usb/trace-events b/hw/usb/trace-events<br>
&gt; index ed7dc210d3..b47d082fa3 100644<br>
&gt; --- a/hw/usb/trace-events<br>
&gt; +++ b/hw/usb/trace-events<br>
&gt; @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)<b=
r>
&gt; &quot;DataOverrun %d &gt; %zu&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_iso_td_data_underrun(int ret) &quot;DataUnderrun =
%d&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_iso_td_nak(int ret) &quot;got NAK/STALL %d&quot;<=
br>
&gt;=C2=A0 =C2=A0usb_ohci_iso_td_bad_response(int ret) &quot;Bad device res=
ponse %d&quot;<br>
&gt; +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) &quot;Bad cbp =3D 0x%x=
 &gt; be =3D 0x%x&quot;<br>
&gt; +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) &quot;=
Bad<br>
&gt; pid %s: ed.flags 0x%x td.flags 0x%x&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_port_attach(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_port_detach(int index) &quot;port #%d&quot;<br>
&gt;=C2=A0 =C2=A0usb_ohci_port_wakeup(int index) &quot;port #%d&quot;<br>
&gt;<br>
</blockquote></div></div>
</blockquote></div></div>

--0000000000006fcf7a0617e2ea7f--

