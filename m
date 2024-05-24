Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FA5C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 10:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sASaS-0006Qw-R4; Fri, 24 May 2024 06:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sASaP-0006Pt-Fn
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:55:45 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sASaM-0007vU-Np
 for qemu-devel@nongnu.org; Fri, 24 May 2024 06:55:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6f8edde1013so612316b3a.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 03:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1716548018; x=1717152818;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XWSlU3lw1V6vNVqxuIBD3eAdB6nrF1a1WYX7J1apcJk=;
 b=INrd+3kcLJe1+ZENSBKYxlum/nT+z1+M3nvBToTt+Jodfc8bPi/Kq7DkVm7jR8WXBf
 OibJfcJDwjcLcvwiqUuH9z0RyC3yltcY6pi9PcvFFpNOrHnMX9/E3nkCn/E7NArn61iy
 ByGUpGhx6txoLRP5FlbXhkifg1xhYdD5Vs4qVJQI17BcKtUQZdorEeP6GunaqIAZ9pk5
 bfPWl632bSjDpsG6UeRtfWdk5bRdAe50qELqh/kQDJXtOO1quoQnvX7Q/m4PiEl03/g8
 ZOxK7nGJWNbrc7qkHMTrt7F8s5Xx4Bee9snD54wDaR3LSG0dF9ROkGROfuEqfYf0smL8
 ERXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716548018; x=1717152818;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XWSlU3lw1V6vNVqxuIBD3eAdB6nrF1a1WYX7J1apcJk=;
 b=aFJjIThSMSQlYxLyCLIBglq1lrAcW/hQjgLqseOJK7fAHu0BaYgvWND1UMfRVWoAbm
 dtfy9wDzw98d5Eks3QyALNKPv6VUXqw4HBLwIR2sB0/Beryz4/uugergh8E3RWAMn/eN
 gyQsdCS4NuHDK8rZOUJoot7mxmHQmXbNTKsrUL7K4NN0nBLSQ5ltADp8fClGZltd/7ye
 63Cewi33aYXUmi7RqS0aexZoYpG0KjEixDe/r0J4qYJYJaey9eLksLKVV3Yz7O5a605Q
 1irNZpcJe5CgWmSY56DxhS7a5Or7+71o8NVZTYg+Ak3Jlis7dLQ4rZDAWi94HwXabdcJ
 aXSw==
X-Gm-Message-State: AOJu0YyZ1Rus57riLPXHizZoVw4DXMmEOjF3NoH9mPfLvkmPrmhZgLmA
 /HVTVHZujTxcjFfBjvwOdecg15MguLGQ8l82TKo3AnZ48fvvQP4yPUUcY5T5KfGFr1XxNBhH6cR
 Kc6CIhGXe8p5qHWKgO5hQbz6qE0lk7qkM92Zmkw==
X-Google-Smtp-Source: AGHT+IE9W2JwvaARuKoihNNpHxEOfTBagB2HTT8Tm/CtZdhRJKfp5+GQULWlwutJjwyNxfHOsbIijsMeq8Gn1bEXH5w=
X-Received: by 2002:a05:6a00:1d8d:b0:6e5:43b5:953b with SMTP id
 d2e1a72fcca58-6f8f34bcd74mr1728349b3a.14.1716548017429; Fri, 24 May 2024
 03:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1716531409.git.yong.huang@smartx.com>
 <878c8f093f3fc2f584b5c31cb2490d9f6a12131a.1716531409.git.yong.huang@smartx.com>
 <CAE8KmOyXhvYHOw2MOSbwSetC7jyFNFsf0E81O0wQ1WEGGXY-TQ@mail.gmail.com>
In-Reply-To: <CAE8KmOyXhvYHOw2MOSbwSetC7jyFNFsf0E81O0wQ1WEGGXY-TQ@mail.gmail.com>
From: Yong Huang <yong.huang@smartx.com>
Date: Fri, 24 May 2024 18:53:21 +0800
Message-ID: <CAK9dgmZOSTQhhJjXN32MupjW9o+3HTPnwNgYhx4Z-mY6kVYGHg@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi-disk: Fix crash for VM configured with USB CDROM
 after live migration
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>
Content-Type: multipart/alternative; boundary="000000000000d1bc78061930fa3c"
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

--000000000000d1bc78061930fa3c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 6:01=E2=80=AFPM Prasad Pandit <ppandit@redhat.com> =
wrote:

> Hello Hyman,
>
> * Is this the same patch series as sent before..?
>   ->
> https://lists.nongnu.org/archive/html/qemu-devel/2024-04/msg00816.html

Yes, exactly the same, I just refine the comment


>
>
> On Fri, 24 May 2024 at 12:02, Hyman Huang <yong.huang@smartx.com> wrote:
> > For VMs configured with the USB CDROM device:
> >
> > -drive
> file=3D/path/to/local/file,id=3Ddrive-usb-disk0,media=3Dcdrom,readonly=3D=
on...
> > -device usb-storage,drive=3Ddrive-usb-disk0,id=3Dusb-disk0...
> >
> > QEMU process may crash after live migration,
> > Do the live migration repeatedly, crash may happen after live migratoin=
,
>
> * Does live migration work many times before QEMU crashes on the
> destination side? OR QEMU crashes at the very first migration?
>
> >    at
> /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86_64/include/qemu/io=
v.h:49
>
> * This qemu version looks quite old. Is the issue reproducible with
> the latest QEMU version 9.0?
>

I'm not testing the latest QEMU version while theoretically it is
reproducible, I'll check it and give a conclusion.


>
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > +static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest
> *req)
> > +{
> > +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> > +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> > +
> > +    if (s->migrate_emulate_scsi_request) {
> > +        scsi_disk_save_request(f, req);
> > +    }
> > +}
> > +
> >  static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req)
> >  {
> >      SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> > @@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f,
> SCSIRequest *req)
> >      qemu_iovec_init_external(&r->qiov, &r->iov, 1);
> >  }
> >
> > +static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest
> *req)
> > +{
> > +    SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);
> > +    SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
> > +
> > +    if (s->migrate_emulate_scsi_request) {
> > +        scsi_disk_load_request(f, req);
> > +    }
> > +}
> > +
> >  /*
> >   * scsi_handle_rw_error has two return values.  False means that the
> error
> >   * must be ignored, true means that the error has been processed and t=
he
> > @@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops =
=3D
> {
> >      .read_data    =3D scsi_disk_emulate_read_data,
> >      .write_data   =3D scsi_disk_emulate_write_data,
> >      .get_buf      =3D scsi_get_buf,
> > +    .load_request =3D scsi_disk_emulate_load_request,
> > +    .save_request =3D scsi_disk_emulate_save_request,
> >  };
> >
> >  static const SCSIReqOps scsi_disk_dma_reqops =3D {
> > @@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] =3D {
> >  static int scsi_disk_pre_save(void *opaque)
> >  {
> >      SCSIDiskState *dev =3D opaque;
> > -    dev->migrate_emulate_scsi_request =3D false;
> > +    dev->migrate_emulate_scsi_request =3D true;
> >
>
> * This patch seems to add support for migrating SCSI requests. While
> it looks okay, not sure if it is required, how likely is someone to
> configure a VM to use CDROM?
>

I'm not sure this usage is common but in our production environment,
it is used.


>
> *  Should the CDROM device be reset on the destination if no requests
> are found? ie. if (scsi_req_get_buf -> scsi_get_buf() returns NULL)?
>

IMHO, resetting the CDROM device may be a work around because
the request *SHOULD *not be lost. No requests are found may be
caused by other reasons, resetting the CD ROM seems crude.
The path that executes the scsi_get_buf() is in a USB mass storage
device,  and it called by the UHCI controller originally, which just
handles the Frame List blindly, reset solution is kind of complicated
in implementation

Migrating the requests may be a graceful solution.

Thanks for the comments,
Yong


> Thank you.
> ---
>   - Prasad
>
>

--=20
Best regards

--000000000000d1bc78061930fa3c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif"><br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, May 24, 20=
24 at 6:01=E2=80=AFPM Prasad Pandit &lt;<a href=3D"mailto:ppandit@redhat.co=
m">ppandit@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-st=
yle:solid;border-left-color:rgb(204,204,204);padding-left:1ex">Hello Hyman,=
<br>
<br>
* Is this the same patch series as sent before..?<br>
=C2=A0 -&gt; <a href=3D"https://lists.nongnu.org/archive/html/qemu-devel/20=
24-04/msg00816.html" rel=3D"noreferrer" target=3D"_blank">https://lists.non=
gnu.org/archive/html/qemu-devel/2024-04/msg00816.html</a></blockquote><div>=
<div style=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gm=
ail_default"></div><div style=3D"font-family:&quot;comic sans ms&quot;,sans=
-serif" class=3D"gmail_default">Yes, exactly the same, I just refine the co=
mment</div></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;=
border-left-color:rgb(204,204,204);padding-left:1ex"><br>
<br>
On Fri, 24 May 2024 at 12:02, Hyman Huang &lt;<a href=3D"mailto:yong.huang@=
smartx.com" target=3D"_blank">yong.huang@smartx.com</a>&gt; wrote:<br>
&gt; For VMs configured with the USB CDROM device:<br>
&gt;<br>
&gt; -drive file=3D/path/to/local/file,id=3Ddrive-usb-disk0,media=3Dcdrom,r=
eadonly=3Don...<br>
&gt; -device usb-storage,drive=3Ddrive-usb-disk0,id=3Dusb-disk0...<br>
&gt;<br>
&gt; QEMU process may crash after live migration,<br>
&gt; Do the live migration repeatedly, crash may happen after live migratoi=
n,<br>
<br>
* Does live migration work many times before QEMU crashes on the<br>
destination side? OR QEMU crashes at the very first migration?<br>
<br>
&gt;=C2=A0 =C2=A0 at /usr/src/debug/qemu-6-6.2.0-75.7.oe1.smartx.git.40.x86=
_64/include/qemu/iov.h:49<br>
<br>
* This qemu version looks quite old. Is the issue reproducible with<br>
the latest QEMU version 9.0?<br></blockquote><div><br></div><div><div class=
=3D"gmail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,san=
s-serif">I&#39;m not testing the latest QEMU version while theoretically it=
 is</span></div><div class=3D"gmail_default"><span style=3D"font-family:&qu=
ot;comic sans ms&quot;,sans-serif">reproducible, I&#39;ll check it and give=
 a conclusion. =C2=A0</span></div></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-style:solid;border-left-color:rgb(204,204,204);padding-left:1ex">
<br>
&gt; diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c<br>
&gt; +static void scsi_disk_emulate_save_request(QEMUFile *f, SCSIRequest *=
req)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);<br=
>
&gt; +=C2=A0 =C2=A0 SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r-&=
gt;<a href=3D"http://req.dev" rel=3D"noreferrer" target=3D"_blank">req.dev<=
/a>);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;migrate_emulate_scsi_request) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_disk_save_request(f, req);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void scsi_disk_load_request(QEMUFile *f, SCSIRequest *req=
)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req=
);<br>
&gt; @@ -183,6 +193,16 @@ static void scsi_disk_load_request(QEMUFile *f, S=
CSIRequest *req)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 qemu_iovec_init_external(&amp;r-&gt;qiov, &amp;r-&=
gt;iov, 1);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static void scsi_disk_emulate_load_request(QEMUFile *f, SCSIRequest *=
req)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 SCSIDiskReq *r =3D DO_UPCAST(SCSIDiskReq, req, req);<br=
>
&gt; +=C2=A0 =C2=A0 SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r-&=
gt;<a href=3D"http://req.dev" rel=3D"noreferrer" target=3D"_blank">req.dev<=
/a>);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;migrate_emulate_scsi_request) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 scsi_disk_load_request(f, req);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* scsi_handle_rw_error has two return values.=C2=A0 False =
means that the error<br>
&gt;=C2=A0 =C2=A0* must be ignored, true means that the error has been proc=
essed and the<br>
&gt; @@ -2593,6 +2613,8 @@ static const SCSIReqOps scsi_disk_emulate_reqops=
 =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .read_data=C2=A0 =C2=A0 =3D scsi_disk_emulate_read=
_data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .write_data=C2=A0 =C2=A0=3D scsi_disk_emulate_writ=
e_data,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 .get_buf=C2=A0 =C2=A0 =C2=A0 =3D scsi_get_buf,<br>
&gt; +=C2=A0 =C2=A0 .load_request =3D scsi_disk_emulate_load_request,<br>
&gt; +=C2=A0 =C2=A0 .save_request =3D scsi_disk_emulate_save_request,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static const SCSIReqOps scsi_disk_dma_reqops =3D {<br>
&gt; @@ -3137,7 +3159,7 @@ static Property scsi_hd_properties[] =3D {<br>
&gt;=C2=A0 static int scsi_disk_pre_save(void *opaque)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 SCSIDiskState *dev =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 dev-&gt;migrate_emulate_scsi_request =3D false;<br>
&gt; +=C2=A0 =C2=A0 dev-&gt;migrate_emulate_scsi_request =3D true;<br>
&gt;<br>
<br>
* This patch seems to add support for migrating SCSI requests. While<br>
it looks okay, not sure if it is required, how likely is someone to<br>
configure a VM to use CDROM?<br></blockquote><div><br></div><div><div style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif" class=3D"gmail_defaul=
t">I&#39;m not sure this usage is common=C2=A0but in our production environ=
ment,=C2=A0</div><div style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif" class=3D"gmail_default">it is used.</div></div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-=
width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);paddin=
g-left:1ex">
<br>
*=C2=A0 Should the CDROM device be reset on the destination if no requests<=
br>
are found? ie. if (scsi_req_get_buf -&gt; scsi_get_buf() returns NULL)?<br>=
</blockquote><div><br></div><div><div class=3D"gmail_default"><span style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">IMHO, resetting the C=
DROM device may be a work around because</span></div><div class=3D"gmail_de=
fault"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">the=
 request <b>SHOULD </b>not be lost.=C2=A0No requests are found may be</span=
></div><div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif=
">caused by other reasons, resetting the CD ROM seems crude.</font></div><d=
iv class=3D"gmail_default"><div class=3D"gmail_default"><span style=3D"font=
-family:&quot;comic sans ms&quot;,sans-serif">The path that=C2=A0</span><sp=
an style=3D"font-family:&quot;comic sans ms&quot;,sans-serif">executes the =
scsi_get_buf()<span class=3D"gmail-Apple-converted-space">=C2=A0</span></sp=
an>is in<span style=3D"font-family:&quot;comic sans ms&quot;,sans-serif"><s=
pan class=3D"gmail-Apple-converted-space">=C2=A0</span>a USB mass storage</=
span></div><div class=3D"gmail_default"><span style=3D"font-family:&quot;co=
mic sans ms&quot;,sans-serif">device, =C2=A0and it=C2=A0</span><span style=
=3D"font-family:&quot;comic sans ms&quot;,sans-serif">called<span class=3D"=
gmail-Apple-converted-space">=C2=A0</span></span>by the UHCI<span style=3D"=
font-family:&quot;comic sans ms&quot;,sans-serif"><span class=3D"gmail-Appl=
e-converted-space">=C2=A0</span>controller originally, which just</span></d=
iv><div class=3D"gmail_default"><span style=3D"font-family:&quot;comic sans=
 ms&quot;,sans-serif">handles the Frame List=C2=A0</span><span style=3D"fon=
t-family:&quot;comic sans ms&quot;,sans-serif">blindly, reset solution is k=
ind of complicated</span></div><div class=3D"gmail_default"><font face=3D"c=
omic sans ms, sans-serif">in implementation</font></div><div class=3D"gmail=
_default"><font face=3D"comic sans ms, sans-serif"><br></font></div></div><=
div class=3D"gmail_default"><font face=3D"comic sans ms, sans-serif">Migrat=
ing=C2=A0</font><span style=3D"font-family:&quot;comic sans ms&quot;,sans-s=
erif">the requests may be a graceful solution.</span></div><div class=3D"gm=
ail_default"><span style=3D"font-family:&quot;comic sans ms&quot;,sans-seri=
f"><br></span></div><div class=3D"gmail_default"><span style=3D"font-family=
:&quot;comic sans ms&quot;,sans-serif">Thanks for the comments,</span></div=
><div class=3D"gmail_default"><span style=3D"font-family:&quot;comic sans m=
s&quot;,sans-serif">Yong</span></div><div class=3D"gmail_default"><br></div=
></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;=
border-left-width:1px;border-left-style:solid;border-left-color:rgb(204,204=
,204);padding-left:1ex">
<br>
Thank you.<br>
---<br>
=C2=A0 - Prasad<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><font face=3D"comic sans ms, sans-serif">Best regards</font>=
</div></div></div>

--000000000000d1bc78061930fa3c--

