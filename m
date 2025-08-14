Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482ACCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 08:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umTn2-0006hO-UH; Thu, 14 Aug 2025 04:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1umTmv-0006h8-TM
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:58:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1umTmr-0000Rt-JH
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 04:58:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755161886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5DNWtLF61djgZ+etk1OGn/UTwyKZuCJAu5M1ytIBIXY=;
 b=ONV77HS8K56Lv3uLb6N+AvfD3uDPKwkPi4VhSYRqRT8Hgs7+7Yn7vqK9YnXZK/iYw/qxMb
 DSYVxfEjquaYsOw6u2AqX1lW9so4XBI4JJKVzhoOfWvO3XA1Qw2wItvaAnOvclh6L+JkVJ
 GzPKD0e3oBpdEIBfftyccp07jeMOZzI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-XhwUW-jrPyWfrI40qB2O2Q-1; Thu, 14 Aug 2025 04:58:02 -0400
X-MC-Unique: XhwUW-jrPyWfrI40qB2O2Q-1
X-Mimecast-MFC-AGG-ID: XhwUW-jrPyWfrI40qB2O2Q_1755161881
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-70a9f636685so23961596d6.3
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 01:58:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755161881; x=1755766681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5DNWtLF61djgZ+etk1OGn/UTwyKZuCJAu5M1ytIBIXY=;
 b=khJUxDAlfEaH5B13FyhYDvHoQo7RVSDjeaf+FYphgECPjWVO7xD2+WX3zPZ7uJrRZ2
 E4tX6cT8EotPFoWv6g0bIgBxYTqejx4oLXIGcpYInA5cN5jpgIxWbdE+NlK6nyoGd4sQ
 ht7x8W4Soc+g2pA4XaMHBUuVfskSwoNUPcP3AgqWliqH0mFG1NpxRA7N2MUmnRJZHBuN
 6EFLdWqQJw9zezj5FP7nb6VgHpVKtCCcYbHjRXJZxHow3vBdA1tIVC7frqZs7xHsIRb/
 6u8Y2bt/NpJFOSWC2G/vn0wXa/Id+dZyDnAGvYthfDTjPImUl+VYcl4i5BDe2TACPm5k
 81fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjHz1i4CFIlyKlHvC2ifKWSqICvscWYojdYKtUfAXlCkQR8yo+RzRcYkkr9M20Jw5lYu4jhFEC6suK@nongnu.org
X-Gm-Message-State: AOJu0YwEOUdmQJ76KAmamxEqqd25QEwrgOS4wOZg74V793ysXeBxdvZU
 1LEuYTAUb843+xvYOv6qZz2XR07VsWi2oHFSb40/JaFmVYWtQDG0YDEQ4Z1FKPaHh++6Esq34Dc
 iOjGzG5Ws6BJc0yA18vHm5zUrq/GUiPoEUWfIkUBTSo25O84Tux+0PvEnoMCDud8yYhA5yBYOdd
 Y1W4W5wyR5pSQx+IZahGmUqIN/RzOcZQU=
X-Gm-Gg: ASbGncvG1Bsi+1dP+2yiQavNxVGyWX27ciiWHty4F/IDBY4lsvVSIEQJxzlOCod3hCh
 0qyUNZHwcWPw9xDfw8u+fCsPEgr//qmb6J9tk1QRvx9HsKCIsz2qeG8x6Gyk9jyhReSKuhdGOU5
 SFpO/EF5xxdw/XGSZ4FT528Jc=
X-Received: by 2002:ad4:5946:0:b0:707:70b7:376d with SMTP id
 6a1803df08f44-70ae6d37163mr31754946d6.1.1755161881657; 
 Thu, 14 Aug 2025 01:58:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqtDbe04PqKJb/aw8HiLB9vNLsWWF+5M/GynDFjgu+RSKlUO2iGwG/dUmSNHRKQNYAkIGEpDHcOTWp8o06YJI=
X-Received: by 2002:ad4:5946:0:b0:707:70b7:376d with SMTP id
 6a1803df08f44-70ae6d37163mr31754746d6.1.1755161881285; Thu, 14 Aug 2025
 01:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMcbCpSQS5yWUCcGum6nWq=+HTaxFmJjm57_cgmJp+fMtC1JQ@mail.gmail.com>
 <aJCTJf67oTZseYUr@redhat.com>
 <23a9cb5f-dda8-403d-964d-b27338d6c94a@redhat.com>
In-Reply-To: <23a9cb5f-dda8-403d-964d-b27338d6c94a@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Thu, 14 Aug 2025 11:57:50 +0300
X-Gm-Features: Ac12FXxYj7x1vBlyAvo2q99_2TkgkAuQ6wUo3HYUVS9v6nuhfampPgKZBhvBIXM
Message-ID: <CAPMcbCq3sjZeUNX=xhc3mKEFi04DzDngt_SbVK2ELccyDv5zUQ@mail.gmail.com>
Subject: Re: QGA installation issue on Windows
To: =?UTF-8?B?TWljaGFsIFByw612b3puw61r?= <mprivozn@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jan Tomko <jtomko@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000007529a1063c4f7854"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
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

--0000000000007529a1063c4f7854
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 11:06=E2=80=AFAM Michal Pr=C3=ADvozn=C3=ADk <mprivo=
zn@redhat.com>
wrote:

> On 8/4/25 13:01, Daniel P. Berrang=C3=A9 wrote:
> > On Mon, Aug 04, 2025 at 01:54:09PM +0300, Kostiantyn Kostiuk wrote:
> >> Hi Michal,
> >>
> >> I want to discuss your patch
> >>
> https://gitlab.com/qemu-project/qemu/-/commit/c6f5dd7ac8ef62dcdec4cdeda14=
67c658161afff
> >>
> >> Unfortunately, we found bad behaviour on Windows. On Windows, we run Q=
GA
> >> with `-d --retry-path` options by default, so we expect that QGA will
> start
> >> even without the vioserial driver and will wait for communication
> >> forever.
> >>
> >> This worked previously, but after your patch QGA service fails if the
> >> vioserial communication channel is missing. This behavior is totally
> >> unacceptable for us.
> >>
> >> You send this patch to fix a Linux problem, but it causes a Windows
> problem.
> >> So, what we need on Windows, if --retry-path specified, we should igno=
re
> >> any channel error and retry the connection. If -d and --retry-path are
> >> specified, it should become a daemon first to make Windows Service
> Manager
> >> happy.
>
> The original problem I tried to fix was (and I am bit hazy on all the
> details): when somebody built their own kernel but forgot to enable
> virtio-serial then qemu-ga would fail to initialize but with a
> completely irrelevant error message.
>
> >
> > This looks pretty simple to fix - in the initialize_agent() method, if
> > channel_init() fails, then simply ignore the failure if 'retry_path'
> > is set, because the later code in run_agent() will already correctly
> > retry the connection.
>
> Yeah, do you want me to post such patch?
>

If you agree with Daniel's idea, I will post a patch.



Best Regards,
Kostiantyn Kostiuk.


>
> Michal
>
>

--0000000000007529a1063c4f7854
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Aug 14,=
 2025 at 11:06=E2=80=AFAM Michal Pr=C3=ADvozn=C3=ADk &lt;<a href=3D"mailto:=
mprivozn@redhat.com">mprivozn@redhat.com</a>&gt; wrote:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">On 8/4/25 13:01, Daniel P. Berrang=
=C3=A9 wrote:<br>
&gt; On Mon, Aug 04, 2025 at 01:54:09PM +0300, Kostiantyn Kostiuk wrote:<br=
>
&gt;&gt; Hi Michal,<br>
&gt;&gt;<br>
&gt;&gt; I want to discuss your patch<br>
&gt;&gt; <a href=3D"https://gitlab.com/qemu-project/qemu/-/commit/c6f5dd7ac=
8ef62dcdec4cdeda1467c658161afff" rel=3D"noreferrer" target=3D"_blank">https=
://gitlab.com/qemu-project/qemu/-/commit/c6f5dd7ac8ef62dcdec4cdeda1467c6581=
61afff</a><br>
&gt;&gt;<br>
&gt;&gt; Unfortunately, we found bad behaviour on Windows. On Windows, we r=
un QGA<br>
&gt;&gt; with `-d --retry-path` options by default, so we expect that QGA w=
ill start<br>
&gt;&gt; even without the vioserial driver and will wait for communication<=
br>
&gt;&gt; forever.<br>
&gt;&gt;<br>
&gt;&gt; This worked previously, but after your patch QGA service fails if =
the<br>
&gt;&gt; vioserial communication channel is missing. This behavior is total=
ly<br>
&gt;&gt; unacceptable for us.<br>
&gt;&gt;<br>
&gt;&gt; You send this patch to fix a Linux problem, but it causes a Window=
s problem.<br>
&gt;&gt; So, what we need on Windows, if --retry-path specified, we should =
ignore<br>
&gt;&gt; any channel error and retry the connection. If -d and --retry-path=
 are<br>
&gt;&gt; specified, it should become a daemon first to make Windows Service=
 Manager<br>
&gt;&gt; happy.<br>
<br>
The original problem I tried to fix was (and I am bit hazy on all the<br>
details): when somebody built their own kernel but forgot to enable<br>
virtio-serial then qemu-ga would fail to initialize but with a<br>
completely irrelevant error message.<br>
<br>
&gt; <br>
&gt; This looks pretty simple to fix - in the initialize_agent() method, if=
<br>
&gt; channel_init() fails, then simply ignore the failure if &#39;retry_pat=
h&#39;<br>
&gt; is set, because the later code in run_agent() will already correctly<b=
r>
&gt; retry the connection.<br>
<br>
Yeah, do you want me to post such patch?<br></blockquote><div><br></div><di=
v>If you agree with Daniel&#39;s idea, I will post a patch. <br></div><div>=
<br></div><div><br></div><div><div><br clear=3D"all"></div><div><div dir=3D=
"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><d=
iv>Kostiantyn Kostiuk.</div></div></div></div></div><div>=C2=A0</div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">
<br>
Michal<br>
<br>
</blockquote></div></div>

--0000000000007529a1063c4f7854--


