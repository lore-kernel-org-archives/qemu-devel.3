Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BD7D729F9
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 18:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH63P-00044Z-KA; Fri, 29 Nov 2024 13:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jvilaca@redhat.com>)
 id 1tH63M-000447-Ex
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:49:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jvilaca@redhat.com>)
 id 1tH63K-0006Er-JW
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 13:49:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732906155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2yZBIADuNRBVwjO9ucT9y/I86XtW5PuLAHlgFGjHx1w=;
 b=gBQnAIUTub8a/oOLwOqELi/N1NHpviQJXIgMFkK2KT1KBk7ebTQx5j4B+AB9oiAhT79I2P
 ok+YjZynB3FJmEnZ9eYK+yshiKI8ERuelhXGeEt+ACn3pPu2ehLAh+GuWqGo2UjHBQXs8o
 HdpQOUhgcvmVx5VGJmt3xEPTLFU7SX8=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-118-aNKsvZnhOPm8mKcO0Ap-UA-1; Fri, 29 Nov 2024 13:49:14 -0500
X-MC-Unique: aNKsvZnhOPm8mKcO0Ap-UA-1
X-Mimecast-MFC-AGG-ID: aNKsvZnhOPm8mKcO0Ap-UA
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3ea3f5aff1eso1395182b6e.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 10:49:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732906153; x=1733510953;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2yZBIADuNRBVwjO9ucT9y/I86XtW5PuLAHlgFGjHx1w=;
 b=KrLH12jA+fkXaStS7+IbJGcAjElS+16YHDlB1zez3mlbr4xzpMfWPB6NfaS4ApNscS
 iWPod810Ylm4gNpO7yPWKy/H4uTvxMSRzQ3vB+Y6awDnWU0EhzvNhDsubPViwjQGRFEg
 kfdTd0iBYHwmhTRgdrTgR3XBA2/2jqoCWmrbueMgB4BjMKsmm7keCn7p4VnbWc+tezhQ
 a6ygML0T/31uGWLVFa7eoonJxGbpHBS5EuscOEEnD2I66LsUO1RWgFfA1ZPS9mlVxzXW
 33KmrLudURJ+qNmw0oWHFb45PDxYbKAh/I4+jz33dCJVVVK2bKcGXSJh9paGLyHjOC+O
 dbKA==
X-Gm-Message-State: AOJu0YyFfBs+d0KrCc4Dma/G2dSaqMVo0mB2Fb8JraneLaReR5hhZEO8
 1xAlgtOxw3fCJ7u5XKlHBV3DMYj0ChXYUdMEEOhqwtFOnX7Tob+lwHJeiEdiSPPmEgr2qfYJ+df
 FVPjxhDt+FCucGeETWm+pCELeZVaDDSpFLbaBxewf5fIzAT8qKknxKHi1nZ5B4UTeUoYdAcaojU
 9AZoWT8EpI4qIR9Oc7XGxM7HJBIvc=
X-Gm-Gg: ASbGncvMvQxDDHML9T19azAYw8T1V6EtvKiCYLWmRakaL0+OmotsUl1JO0yXas6gdtv
 nYF7jR76575I1MHotparkUmHYrXptz7mC6ecLpxr92BqLI1jzlrrZtooIaTXDAKg=
X-Received: by 2002:a05:6808:191c:b0:3ea:6244:71f7 with SMTP id
 5614622812f47-3ea6dd9caa5mr10251822b6e.38.1732906153134; 
 Fri, 29 Nov 2024 10:49:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYDaLSMtHit7wSyUxhPd48/Bw8UkKxUB8ArI1s84RREVqMHvHICd/zdSoscLVLEEK3Etec4ESjHbS1obxeZuc=
X-Received: by 2002:a05:6808:191c:b0:3ea:6244:71f7 with SMTP id
 5614622812f47-3ea6dd9caa5mr10251812b6e.38.1732906152767; Fri, 29 Nov 2024
 10:49:12 -0800 (PST)
MIME-Version: 1.0
References: <CAOw09wu31aROKJaYA7igHR_toegozssDXsTBNuUhusoRX+Yvng@mail.gmail.com>
 <Z0na9lvoTM2V4iFY@redhat.com>
In-Reply-To: <Z0na9lvoTM2V4iFY@redhat.com>
From: =?UTF-8?B?Sm/Do28gVmlsYcOnYQ==?= <jvilaca@redhat.com>
Date: Fri, 29 Nov 2024 18:49:02 +0000
Message-ID: <CAOw09wsgvYs48-vBMVKSrPdUAWkYN9xWww=gL7wjbZbHNsRuDw@mail.gmail.com>
Subject: Re: How to query the number of processes queueing for the CPU inside
 the VM
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000aa52a4062811a7f2"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jvilaca@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000aa52a4062811a7f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

That's exactly it. How can we proceed to get it into guest-get-cpustat?

On Fri, Nov 29, 2024 at 3:17=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Nov 29, 2024 at 02:38:52PM +0000, Jo=C3=A3o Vila=C3=A7a wrote:
> > In KubeVirt, through libvirt, we need to know the number of processes
> > queued for the CPU inside the VM.
> >
> > Can we get this information through the qemu-guest-agent?
>
> The only CPU stats related command in QGA is 'guest-get-cpustat's
> returning:
>
> # @user: Time spent in user mode
> #
> # @nice: Time spent in user mode with low priority (nice)
> #
> # @system: Time spent in system mode
> #
> # @idle: Time spent in the idle task
> #
> # @iowait: Time waiting for I/O to complete (since Linux 2.5.41)
> #
> # @irq: Time servicing interrupts (since Linux 2.6.0-test4)
> #
> # @softirq: Time servicing softirqs (since Linux 2.6.0-test4)
> #
> # @steal: Stolen time by host (since Linux 2.6.11)
> #
> # @guest: ime spent running a virtual CPU for guest operating systems
> #     under the  control of the Linux kernel (since Linux 2.6.24)
> #
> # @guestnice: Time spent running a niced guest (since Linux 2.6.33)
>
> none of which match your rquest
>
> Essentially what you're asking for seems to be the "load average" which
> is a measure of waiting runnable tasks, over some period (1, 5, 15 minute=
s
> typically).
>
> I imagine guest-get-cpustat could be enhanced to include load info withou=
t
> too much work.
>
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

--=20
kind regards,
Jo=C3=A3o Vila=C3=A7a

--000000000000aa52a4062811a7f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">That&#39;s exactly it. How can we proceed to=C2=A0get=C2=
=A0it into=C2=A0guest-get-cpustat?</div><br><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 29, 2024 at 3:17=E2=80=AFPM D=
aniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@=
redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">On Fri, Nov 29, 2024 at 02:38:52PM +0000, Jo=C3=A3o Vila=C3=A7a =
wrote:<br>
&gt; In KubeVirt, through libvirt, we need to know the number of processes<=
br>
&gt; queued for the CPU inside the VM.<br>
&gt; <br>
&gt; Can we get this information through the qemu-guest-agent?<br>
<br>
The only CPU stats related command in QGA is &#39;guest-get-cpustat&#39;s<b=
r>
returning:<br>
<br>
# @user: Time spent in user mode<br>
#<br>
# @nice: Time spent in user mode with low priority (nice)<br>
#<br>
# @system: Time spent in system mode<br>
#<br>
# @idle: Time spent in the idle task<br>
#<br>
# @iowait: Time waiting for I/O to complete (since Linux 2.5.41)<br>
#<br>
# @irq: Time servicing interrupts (since Linux 2.6.0-test4)<br>
#<br>
# @softirq: Time servicing softirqs (since Linux 2.6.0-test4)<br>
#<br>
# @steal: Stolen time by host (since Linux 2.6.11)<br>
#<br>
# @guest: ime spent running a virtual CPU for guest operating systems<br>
#=C2=A0 =C2=A0 =C2=A0under the=C2=A0 control of the Linux kernel (since Lin=
ux 2.6.24)<br>
#<br>
# @guestnice: Time spent running a niced guest (since Linux 2.6.33)<br>
<br>
none of which match your rquest<br>
<br>
Essentially what you&#39;re asking for seems to be the &quot;load average&q=
uot; which<br>
is a measure of waiting runnable tasks, over some period (1, 5, 15 minutes<=
br>
typically).<br>
<br>
I imagine guest-get-cpustat could be enhanced to include load info without<=
br>
too much work.<br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D"http=
s://www.flickr.com/photos/dberrange" rel=3D"noreferrer" target=3D"_blank">h=
ttps://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com" rel=3D"n=
oreferrer" target=3D"_blank">https://fstop138.berrange.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer" target=3D"_bla=
nk">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a href=3D=
"https://www.instagram.com/dberrange" rel=3D"noreferrer" target=3D"_blank">=
https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature"><div dir=3D"ltr"><font color=3D"#888888" face=3D"arial, sans-seri=
f">kind regards,<br><div>Jo=C3=A3o Vila=C3=A7a</div><div><br></div></font><=
/div></div>

--000000000000aa52a4062811a7f2--


