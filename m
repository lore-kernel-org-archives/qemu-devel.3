Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F829C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 15:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxpk4-0000Ji-LS; Fri, 19 Apr 2024 11:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rxpji-0000IG-JN
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:01:10 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dmamfmgm@gmail.com>)
 id 1rxpjg-0006TI-Kh
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:01:10 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ac8c73cf88so1385921eaf.2
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713538866; x=1714143666; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ACxBBJOA+emlb/h3xmxhn7a0TY1p/wNbKCO/z0Lbx44=;
 b=JDEeAQlemhaZeHwMRxFS1CcEfH+fsQtS9SFHSAJSBgVUzUNJWAPus7HYKTITzOE0OM
 VyHFNg/fR2bFii0otlibUQMxWYJ2hahwHYviKMFP2JI/hc7UiDiFoA8JCxFjfqUdAlKv
 M/fL8qydVNxxnRSj9+8i30uqm5Np4UFbldgYy3aBmeOwFnPsXiH55BgPwhPMiVPFhD8E
 CwwyiMQiU1kK26j1LVFhwLyOYGWnrktLE48lT9p/HIZ3qScbLWeLc6yQZS8cGtm3m7Ue
 /FiM5L2bGjqS4xxB6wp28r6KvZaqk9eTnzmYwEwQpAQJC3LviR0R0K/dpRD+2iHicd3/
 I9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713538866; x=1714143666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ACxBBJOA+emlb/h3xmxhn7a0TY1p/wNbKCO/z0Lbx44=;
 b=O523hLbj8hBBJidro18F9h7YFYXixR0FXtfbUNzc0Qf1rZLEgRwaiAaXj32r2+0pIK
 GLTbcw6Vvvvh2kHPgmba5KSPdW6hr2SbAMSYUWXMea4pAiENXbV/ErRxvV5/kil2Ie6Q
 pBoAwNIWK6pNChmxKRjO+BAgLxa2FHpmBjO7N98ii0cyqZXedjdQaTYMj4uHwfbH5hV0
 78gtvrkAVIXUfqnF6KF4qGx87RxRiD2UUP9uw3zEY2Tnc4+fRlkIv1FrpASNE1d0q/y9
 sXYQTl8NrI6/Kqmb2sbhcjhrn8BmGf46UHjYz1PqFBZJaNXaOV5z/CT0gLZFDzY6BPSg
 /1GQ==
X-Gm-Message-State: AOJu0YyXx9pZIqiUfoRjoaJMqp31PeHvBZP6V/Dl8FzEnXRg9OZr55WV
 9LXc1CK2EYXp0B/UHFlXI8UbuSGsDbhjM2C67SWLhzAy9ihl2aQMXk7GTBMdzIvwmd/Fv3zk0UK
 IpeECqgrSuk2XxtTkfQQMynxZjx0=
X-Google-Smtp-Source: AGHT+IGesqdiSCIndWEwiQNKO4APJCDxKTzHEKdTXKlDpDlfvjyAQ1rhdz7kAlz7DJAjOTnDGxJ/TBQpFh+srJkA03o=
X-Received: by 2002:a05:6218:2808:b0:17e:f422:5e48 with SMTP id
 vv8-20020a056218280800b0017ef4225e48mr3062406rwc.13.1713538865085; Fri, 19
 Apr 2024 08:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <CACBuX0To1QWpOTE-HfbXv=tUVWVL0=pvn-+E28EL_mWuqfZ-sw@mail.gmail.com>
 <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
In-Reply-To: <dcaed5da-5e94-4cb6-b5b8-0a571eac371b@tls.msk.ru>
From: Cord Amfmgm <dmamfmgm@gmail.com>
Date: Fri, 19 Apr 2024 10:00:53 -0500
Message-ID: <CACBuX0TotN9Kgpuyv2fyJEL2095ZzDzHO1hKB0WbMNnqve-yqA@mail.gmail.com>
Subject: Re: hw/usb/hcd-ohci: Fix #1510, #303: pid not IN or OUT
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000005cc2e50616745bb3"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=dmamfmgm@gmail.com; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, HTML_MESSAGE=0.001,
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

--0000000000005cc2e50616745bb3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

This just got lost somehow. It is still an issue (see
https://gitlab.com/qemu-project/qemu/-/issues/1510 ). I believe this change
fixes the issue.

On Thu, Apr 18, 2024 at 10:43=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> w=
rote:

> 06.02.2024 10:13, Cord Amfmgm wrote:
> > This changes the ohci validation to not assert if invalid
> > data is fed to the ohci controller. The poc suggested in
> > https://bugs.launchpad.net/qemu/+bug/1907042
> > and then migrated to bug #303 does the following to
> > feed it a SETUP pid and EndPt of 1:
> >
> >          uint32_t MaxPacket =3D 64;
> >          uint32_t TDFormat =3D 0;
> >          uint32_t Skip =3D 0;
> >          uint32_t Speed =3D 0;
> >          uint32_t Direction =3D 0;  /* #define OHCI_TD_DIR_SETUP 0 */
> >          uint32_t EndPt =3D 1;
> >          uint32_t FuncAddress =3D 0;
> >          ed->attr =3D (MaxPacket << 16) | (TDFormat << 15) | (Skip << 1=
4)
> >                     | (Speed << 13) | (Direction << 11) | (EndPt << 7)
> >                     | FuncAddress;
> >          ed->tailp =3D /*TDQTailPntr=3D */ 0;
> >          ed->headp =3D ((/*TDQHeadPntr=3D */ &td[0]) & 0xfffffff0)
> >                     | (/* ToggleCarry=3D */ 0 << 1);
> >          ed->next_ed =3D (/* NextED=3D */ 0 & 0xfffffff0)
> >
> > qemu-fuzz also caught the same issue in #1510. They are
> > both fixed by this patch.
> >
> > The if (td.cbp > td.be) logic in ohci_service_td() causes an
> > ohci_die(). My understanding of the OHCI spec 4.3.1.2
> > Table 4-2 allows td.cbp to be one byte more than td.be to
> > signal the buffer has zero length. The new check in qemu
> > appears to have been added since qemu-4.2. This patch
> > includes both fixes since they are located very close
> > together.
> >
> > Signed-off-by: David Hubbard <dmamfmgm@gmail.com>
>
> Wonder if this got lost somehow.  Or is it not needed?
>
> Thanks,
>
> /mjt
>
> > diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> > index d73b53f33c..a53808126f 100644
> > --- a/hw/usb/hcd-ohci.c
> > +++ b/hw/usb/hcd-ohci.c
> > @@ -927,6 +927,11 @@ static int ohci_service_td(OHCIState *ohci,
> > struct ohci_ed *ed)
> >       case OHCI_TD_DIR_SETUP:
> >           str =3D "setup";
> >           pid =3D USB_TOKEN_SETUP;
> > +        if (OHCI_BM(ed->flags, ED_EN) > 0) {  /* setup only allowed to
> ep 0 */
> > +            trace_usb_ohci_td_bad_pid(str, ed->flags, td.flags);
> > +            ohci_die(ohci);
> > +            return 1;
> > +        }
> >           break;
> >       default:
> >           trace_usb_ohci_td_bad_direction(dir);
> > @@ -936,8 +941,8 @@ static int ohci_service_td(OHCIState *ohci, struct
> > ohci_ed *ed)
> >           if ((td.cbp & 0xfffff000) !=3D (td.be & 0xfffff000)) {
> >               len =3D (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
> >           } else {
> > -            if (td.cbp > td.be) {
> > -                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
> > +            if (td.cbp > td.be + 1) {
> > +                trace_usb_ohci_td_bad_buf(td.cbp, td.be);
> >                   ohci_die(ohci);
> >                   return 1;
> >               }
> > diff --git a/hw/usb/trace-events b/hw/usb/trace-events
> > index ed7dc210d3..b47d082fa3 100644
> > --- a/hw/usb/trace-events
> > +++ b/hw/usb/trace-events
> > @@ -28,6 +28,8 @@ usb_ohci_iso_td_data_overrun(int ret, ssize_t len)
> > "DataOverrun %d > %zu"
> >   usb_ohci_iso_td_data_underrun(int ret) "DataUnderrun %d"
> >   usb_ohci_iso_td_nak(int ret) "got NAK/STALL %d"
> >   usb_ohci_iso_td_bad_response(int ret) "Bad device response %d"
> > +usb_ohci_td_bad_buf(uint32_t cbp, uint32_t be) "Bad cbp =3D 0x%x > be =
=3D
> 0x%x"
> > +usb_ohci_td_bad_pid(const char *s, uint32_t edf, uint32_t tdf) "Bad
> > pid %s: ed.flags 0x%x td.flags 0x%x"
> >   usb_ohci_port_attach(int index) "port #%d"
> >   usb_ohci_port_detach(int index) "port #%d"
> >   usb_ohci_port_wakeup(int index) "port #%d"
> >
>
>

--0000000000005cc2e50616745bb3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Michael,<div><br></div><div>This just got lost somehow.=
 It is still an issue (see=C2=A0<a href=3D"https://gitlab.com/qemu-project/=
qemu/-/issues/1510">https://gitlab.com/qemu-project/qemu/-/issues/1510</a> =
). I believe this change fixes the issue.</div></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 18, 2024 at 10:4=
3=E2=80=AFAM Michael Tokarev &lt;<a href=3D"mailto:mjt@tls.msk.ru">mjt@tls.=
msk.ru</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">06.02.2024 10:13, Cord Amfmgm wrote:<br>
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
/mjt<br>
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
&gt; <br>
<br>
</blockquote></div>

--0000000000005cc2e50616745bb3--

