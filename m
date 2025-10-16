Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C14CCCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 11:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Ll7-0008Rk-Ry; Thu, 16 Oct 2025 07:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v9Ll4-0008Rb-SC
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hzuo@redhat.com>) id 1v9Lkz-0005u4-F1
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 07:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760612566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DkBq/qcZW6wZ4GMc62Bhodtt5KthaAjZUS05vqkNsBQ=;
 b=bCBmtE4slIqqzT8YvaK1KcBq/SUvSeOSf7/m4wKc3Dn+wpa6feqSPY1tIkCjFwIKvID/Br
 fi2ZE+kFWVlZSoAuAGwFiGzZVjuRfcIh6VckfedvPzuhdGSKDmTxOaptXQdqNpgIzqEfq7
 n2m6ywcDDesicO/KutWrC3Xv8RnoziY=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-IrOxEX-gNQKyEqluAZzpVw-1; Thu, 16 Oct 2025 07:02:45 -0400
X-MC-Unique: IrOxEX-gNQKyEqluAZzpVw-1
X-Mimecast-MFC-AGG-ID: IrOxEX-gNQKyEqluAZzpVw_1760612564
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-63d241c46f0so857450d50.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 04:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760612564; x=1761217364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DkBq/qcZW6wZ4GMc62Bhodtt5KthaAjZUS05vqkNsBQ=;
 b=wzqJ9CpsuHQQCaSuVJb5F0hFQMRfsEe9eUi9c8eS7g80UQAKC+t1Xxk7ew/0cMTIoH
 Cd7Rf0lmo5qybAnxIRtmehs4p16Z8Ar6iHfrzoklLSq4nye5EO3pHykMGCDFpzUTWmQm
 qs4hSTI4JNKm7HwzME58ij+N/jV3eHYis7ZW8G9wsOiD3j0ULwlZzi186kGCIy3USOHD
 5PUvf3b/jZgj8+rAAEvd//ClaP0YQNOtF1+JSpxjJ/ejSahZhSkktpc3xzzlfmlya/ea
 vq6ODL1uMLD2nHrcQZVNxJjLz7oGfQtOAHJ+lAm653RBE8+hkxvQcVX1JJiKaIVCDlW3
 IgqA==
X-Gm-Message-State: AOJu0YySeW9BbxU/nXT7d3IDOOh2G1z97BBwYAIm5jxz1ER6enngVorg
 0LDVqXXbU21amCpo2NbKpYN6WIxvQQ4/A//qq1sDgRw63a7wVxw6wPe43TKdZl3EA+TGaAtBio7
 Ro91En0D68iFR+ZWWBZ9d8QuzrGXCci/N8S5hVC4AYR80gODXsJ3erEUUWpM/+XOQ6W7G8ECEVK
 iw4eC0UdhWhyKsdXhGKpsPKvQ4snLTL54=
X-Gm-Gg: ASbGncsPZuANSngV1rYbOtOl/eUpOnxXxzqcqI7VTmuNJdSIeCEXf088uMoKt5b4qa4
 XylRT2tXfx2Q4ZvyVh+GbowvUZ+b0qdMsXZkUIwZZUcLVkbDjWpsGgbAxU2ovyfuB5ZrxlqRWqn
 bfnLUh+y4QpgTfEw4UlRLodxO/VOnQl3wmJMBHIeOvdxtdRSMyE7nzdwms
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr19310245d50.51.1760612564339; 
 Thu, 16 Oct 2025 04:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR58M7ItxQUCR1zLIHEuJb2SCsfT9ro+kH1x29gQhfJ4BMMq0SgR7P7CzNxW3FM2O+qOWyf6Qj+VStcCQxzW0=
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr19310224d50.51.1760612563924; Thu, 16 Oct 2025
 04:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250925023235.1899458-1-hzuo@redhat.com>
 <da5919bf-2739-4d28-b27e-ab09bdaee97b@linaro.org>
In-Reply-To: <da5919bf-2739-4d28-b27e-ab09bdaee97b@linaro.org>
From: Houqi Zuo <hzuo@redhat.com>
Date: Thu, 16 Oct 2025 19:02:07 +0800
X-Gm-Features: AS18NWCLU-kzuKmgNHvWqrGnDRO8KMZF9ZT5wz2uOLHqbZb6ZkHDEgdB_A_Bkg8
Message-ID: <CALnvhAYAsCGRPmae=_wRpDuM98zZYZ4e=0=nj3vuJ4D0VwnBWw@mail.gmail.com>
Subject: Re: [PATCH v4] net/tap-linux.c: avoid abort when setting invalid fd
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>, Michael Tsirkin <mst@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000075d4f90641448ed3"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hzuo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_REMOTE_IMAGE=0.01 autolearn=no autolearn_force=no
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

--00000000000075d4f90641448ed3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,
Thanks for your feedback!

Thanks & Best Regards!

---
Houqi (Nick) Zuo | =E5=B7=A6=E5=8E=9A=E7=A5=BA
ADDR: 9/F, North Tower C, Raycom Infotech Park, No.2 Ke Xueyuan Nanlu,
Haidian District, Beijing 100190
EMAIL: hzuo@redhat.com
Google Chat: Houqi Zuo          Slack: Houqi Zuo

Red Hat respects your work life balance. Therefore, there is no need
to reply to this email out of your office hours.
<https://mojo.redhat.com/docs/DOC-1199578>


<https://red.ht/sig>


On Thu, Oct 16, 2025 at 4:09=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Nick,
>
> On 25/9/25 04:32, Houqi (Nick) Zuo wrote:
> > When QEMU creates a tap device automatically and the tap device is
> > manually removed from the host while the guest is running, the tap
> > device file descriptor becomes invalid. Later, when the guest executes
> > shutdown, the tap_fd_set_vnet_hdr_len() function may be called and
> > abort QEMU with a core dump when attempting to use the invalid fd.
> >
> > This patch removes many abort() calls in this file. If the fd is found
> > to be in a bad state (e.g., EBADFD or ENODEV), the related function
> > will print an error message.
> >
> > The expected behavior for this negative test case is that QEMU should
> > report an error but continue running rather than aborting.
>
>
> > Fixes: 0caed25cd171c611781589b5402161d27d57229c ("virtio: Call
> set_features during reset")
> >
> > Signed-off-by: Houqi (Nick) Zuo <hzuo@redhat.com>
> > ---
> >   net/tap-linux.c | 13 ++++++++-----
> >   1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/tap-linux.c b/net/tap-linux.c
> > index e832810665..24e63a0b54 100644
> > --- a/net/tap-linux.c
> > +++ b/net/tap-linux.c
> > @@ -206,15 +206,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)
> >       if (ioctl(fd, TUNSETVNETHDRSZ, &len) =3D=3D -1) {
> >           fprintf(stderr, "TUNSETVNETHDRSZ ioctl() failed: %s.
> Exiting.\n",
> >                   strerror(errno));
>
> Remove "Exiting".
>
> While here, can you replace fprintf() -> error_report()?
>
> > -        abort();
>
> If we don't exit anymore, this function should return some value
> indicating the failure, and the callers should check it.
>
> >       }
> >   }
>
> Regards,
>
> Phil.
>
>

--00000000000075d4f90641448ed3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span class=3D"gmail_default" style=3D"font-size:larg=
e">Hi=C2=A0</span><span style=3D"color:rgb(31,31,31);font-size:0.875rem;fon=
t-weight:bold;font-family:&quot;Google Sans&quot;,Roboto,RobotoDraft,Helvet=
ica,Arial,sans-serif">Philippe<span class=3D"gmail_default" style=3D"font-s=
ize:large">,</span></span></div><div class=3D"gmail_default" style=3D"font-=
size:large">Thanks for your feedback!</div><div><div dir=3D"ltr" class=3D"g=
mail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><f=
ont size=3D"1"><br></font></div><div><font size=3D"1">Thanks &amp; Best Reg=
ards!<br></font></div><div><font size=3D"1"><br></font></div><font size=3D"=
1">---</font><div><font size=3D"1">Houqi (Nick) Zuo | =E5=B7=A6=E5=8E=9A=E7=
=A5=BA<br>ADDR: 9/F, North Tower C, Raycom Infotech Park,=C2=A0No.2 Ke Xuey=
uan Nanlu, Haidian District, Beijing 100190<br>EMAIL: <a href=3D"mailto:hzu=
o@redhat.com" target=3D"_blank">hzuo@redhat.com</a><br>Google Chat: Houqi Z=
uo=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Slack: Houqi Zuo</font><div><div dir=
=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr=
"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><pre style=3D"white-sp=
ace:pre-wrap;color:rgb(80,0,80)"><p style=3D"color:rgb(0,0,0);white-space:n=
ormal;margin:0px"><a href=3D"https://mojo.redhat.com/docs/DOC-1199578" styl=
e=3D"color:rgb(17,85,204);font-family:arial,sans-serif" target=3D"_blank"><=
font size=3D"1">Red Hat respects your work life balance. Therefore, there i=
s no need to reply to this email out of your office hours.</font></a></p></=
pre><table width=3D"101" height=3D"16" border=3D"0" style=3D"color:rgb(33,3=
3,33)"><tbody><tr><td width=3D"100px"><a href=3D"https://red.ht/sig" rel=3D=
"noopener noreferrer" style=3D"color:rgb(17,85,204)" target=3D"_blank"><div=
 style=3D"display:inline-block"><font face=3D"arial, sans-serif" size=3D"1"=
><img src=3D"https://static.redhat.com/libs/redhat/brand-assets/latest/corp=
/logo.png" width=3D"90" height=3D"auto"><span style=3D"color:rgb(204,0,0);f=
ont-weight:bold;background-color:rgb(253,253,253)"><br></span></font></div>=
</a></td></tr></tbody></table></div></div></div></div></div></div></div></d=
iv></div></div></div></div></div><br></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 16, =
2025 at 4:09=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:p=
hilmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Hi Nick,<br>
<br>
On 25/9/25 04:32, Houqi (Nick) Zuo wrote:<br>
&gt; When QEMU creates a tap device automatically and the tap device is<br>
&gt; manually removed from the host while the guest is running, the tap<br>
&gt; device file descriptor becomes invalid. Later, when the guest executes=
<br>
&gt; shutdown, the tap_fd_set_vnet_hdr_len() function may be called and<br>
&gt; abort QEMU with a core dump when attempting to use the invalid fd.<br>
&gt; <br>
&gt; This patch removes many abort() calls in this file. If the fd is found=
<br>
&gt; to be in a bad state (e.g., EBADFD or ENODEV), the related function<br=
>
&gt; will print an error message.<br>
&gt; <br>
&gt; The expected behavior for this negative test case is that QEMU should<=
br>
&gt; report an error but continue running rather than aborting.<br>
<br>
<br>
&gt; Fixes: 0caed25cd171c611781589b5402161d27d57229c (&quot;virtio: Call se=
t_features during reset&quot;)<br>
&gt; <br>
&gt; Signed-off-by: Houqi (Nick) Zuo &lt;<a href=3D"mailto:hzuo@redhat.com"=
 target=3D"_blank">hzuo@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0net/tap-linux.c | 13 ++++++++-----<br>
&gt;=C2=A0 =C2=A01 file changed, 8 insertions(+), 5 deletions(-)<br>
&gt; <br>
&gt; diff --git a/net/tap-linux.c b/net/tap-linux.c<br>
&gt; index e832810665..24e63a0b54 100644<br>
&gt; --- a/net/tap-linux.c<br>
&gt; +++ b/net/tap-linux.c<br>
&gt; @@ -206,15 +206,16 @@ void tap_fd_set_vnet_hdr_len(int fd, int len)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ioctl(fd, TUNSETVNETHDRSZ, &amp;len) =3D=
=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;TUNSETVN=
ETHDRSZ ioctl() failed: %s. Exiting.\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st=
rerror(errno));<br>
<br>
Remove &quot;Exiting&quot;.<br>
<br>
While here, can you replace fprintf() -&gt; error_report()?<br>
<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 abort();<br>
<br>
If we don&#39;t exit anymore, this function should return some value<br>
indicating the failure, and the callers should check it.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div>

--00000000000075d4f90641448ed3--


