Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B22C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiHIl-0007SH-4j; Wed, 12 Feb 2025 13:17:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiHIg-0007P1-69
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tiHId-0004Hk-Ba
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 13:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739384245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2ppYSiZ49FRAqnOLdMKnSsqVw1O5Bi0/tNqWW8vvucc=;
 b=aOzvbDywTD9SYGUDptt/1/stYKBurGyK7Ms5YUyRP0kjnYACWkhVn7zf5LmPEUYxV33jMx
 iIsnvCwK//4g4K79lHSkgyMoMmD+s88epieQzNf+ZBEQfvySsH5wJ8n3CQ+sM3OmNh23r0
 PnnSQV5j6+giQ3dM8E2bIXCdvOlWwUs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-yIOAGbWgNSa2rizaprYA-g-1; Wed, 12 Feb 2025 13:17:24 -0500
X-MC-Unique: yIOAGbWgNSa2rizaprYA-g-1
X-Mimecast-MFC-AGG-ID: yIOAGbWgNSa2rizaprYA-g
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-38dd1bdf360so2156342f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 10:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739384243; x=1739989043;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2ppYSiZ49FRAqnOLdMKnSsqVw1O5Bi0/tNqWW8vvucc=;
 b=tgSt/KanKQ77Uoos2Y5MLygA4eoj9AEoEySRIPogZ9iORqlqB3LO3uB+z+6xOFxPhH
 MMU6bo1l1kaU2vYO4igrKIRAe/Z68p664WVeXmjuKQ34BdO0x8Ov36pyCgnIfMbKDKLn
 4Zg4anQCsZ5X+8rDJAi/Is1mE5WI9QjoxCU9YbgG4da4pLVywnCX7HrxTQhQR0NKZIqy
 ye/oASpt/jVR3GcynX3VBfI5jNSKYQVLiouuqQ1N9TfTtT5185OChjAtILTTyo4bP32P
 CgXAIMCJuKImQmPo1LN440i2iNcHCsa/IW6JPPA/3N6p3DyYUCBohxpnPZd6o1tZXd0k
 ajcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB2sicFjkKs7yGkgRdgmGrX3z4kDts97MNn+J8RzhWaTu7NdqDw685Akyqpx+3hwWoEwIQt8900snX@nongnu.org
X-Gm-Message-State: AOJu0Yxir2nDTmgTq3iXN9djWZmSre0j3fvSOuDXNDvQotkmwomrhqnp
 tFQa+rv8C5Fn7zDUMFK53+PhRTEtExk0+UfGjjkIcmww7ppj2IW+RxzTZUNbfLoeSkkWBzV4/6X
 I/tAp3a4vl1R5dXISP0L1IKHAf6+uYK7F2g29gyjLf093fleUsb9lQCZMl/QqJzjN1azGuNL/UN
 7k1jPJWGNNAP47PVV4wEIULS+rJcw=
X-Gm-Gg: ASbGnctwlq2amsBdqyZzVW/KSsm5r335tiPpBKfSJMXw+vK1jfdr66B9COkSI0UoFxN
 2Mio/GZ7+tPAVG2iSCiHoROYBmn4GNvKPEt6bHf4dNolK+Jgikhgip1Y9pedq
X-Received: by 2002:a5d:64cf:0:b0:38d:ddf2:afe9 with SMTP id
 ffacd0b85a97d-38dea256d45mr3951790f8f.1.1739384242979; 
 Wed, 12 Feb 2025 10:17:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHZx9qPkbyrT38iyPf1Rj7t2hXNJ3Uea68YaVdq687/zcum0I2GzcAZ0h2qSMVg4jiQ7C17naA2SEUofWT+os=
X-Received: by 2002:a5d:64cf:0:b0:38d:ddf2:afe9 with SMTP id
 ffacd0b85a97d-38dea256d45mr3951772f8f.1.1739384242680; Wed, 12 Feb 2025
 10:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20250211214328.640374-1-kwolf@redhat.com>
 <20250211214328.640374-9-kwolf@redhat.com>
 <7fe0ba58-8d91-49c7-8f93-d17f42c74fbc@redhat.com>
 <Z6zbLVVWu4zxwdVE@redhat.com>
In-Reply-To: <Z6zbLVVWu4zxwdVE@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Feb 2025 19:17:12 +0100
X-Gm-Features: AWEUYZk958kicyCMWeAzimEz2qJc0g_4W_3rG6b4JTKBB8CCKkcyrZ3y4pRXZyE
Message-ID: <CABgObfZ2fgBxwOne0up-y3-beYYf-3yy8JM_wSrHxyxgYR=F7w@mail.gmail.com>
Subject: Re: [PATCH 08/11] rust/block: Add driver module
To: Kevin Wolf <kwolf@redhat.com>
Cc: "open list:Block layer core" <qemu-block@nongnu.org>,
 Hanna Czenczek <hreitz@redhat.com>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000e9cf85062df5f310"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000e9cf85062df5f310
Content-Type: text/plain; charset="UTF-8"

Il mer 12 feb 2025, 18:32 Kevin Wolf <kwolf@redhat.com> ha scritto:

> > > +        mut buf: MaybeUninit<T>,
> >
> > I think Rust doesn't guarantee no copies here, so maybe this could be
>
> Do you think that in practice the compiler won't optimise the copy away?
>

It's possiblr that it does not, because it has to build the io::Result and
stick the result of assume_init() in there. It all depends on the amount of
inlining perhaps?

I think Box<MaybeUninit>> is the only way to guarantee no copies
(assume_init for Box was only stabilized recently but it can be emulated
with Box::into_raw and Box::from_raw).

>    pub async fn read_uninit<T: SizedIoBuffer>(
> >        &self,
> >        offset: u64,
> >        buf: &mut MaybeUninit<T>,
> >     ) -> io::Result<&mut T>
> >
> > using assume_init_mut().
>
> Are you sure that callers are ok with only getting a &mut T rather than
> an owned T?
>

The one you have would need to be adjusted but it would work.

Another possibility by the way is to have "pub async fn read_obj<T:
SizedIoBuffer>(&self, offset: u64) -> io::Result<T>" and hide the usage of
MaybeUninit inside the function... That one doesn't even try to avoid
copies though.

Paolo



> Kevin
>
>

--000000000000e9cf85062df5f310
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 12 feb 2025, 18:32 Kevin Wolf &lt;<a href=3D"ma=
ilto:kwolf@redhat.com" target=3D"_blank" rel=3D"noreferrer">kwolf@redhat.co=
m</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 mut buf: MaybeUninit&lt;T&gt;,<br>
&gt; <br>
&gt; I think Rust doesn&#39;t guarantee no copies here, so maybe this could=
 be<br>
<br>
Do you think that in practice the compiler won&#39;t optimise the copy away=
?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
>It&#39;s possiblr that it does not, because it has to build the io::Result=
 and stick the result of assume_init() in there. It all depends on the amou=
nt of inlining perhaps?</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I think Box&lt;MaybeUninit&gt;&gt; is the only way to guarantee no copies (=
assume_init for Box was only stabilized recently but it can be emulated wit=
h Box::into_raw and Box::from_raw).</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">&gt;=C2=A0 =C2=A0 pub async fn read_uninit&lt;T: SizedIoBuffe=
r&gt;(<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;self,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset: u64,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 buf: &amp;mut MaybeUninit&lt;T&gt;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0) -&gt; io::Result&lt;&amp;mut T&gt;<br>
&gt; <br>
&gt; using assume_init_mut().<br>
<br>
Are you sure that callers are ok with only getting a &amp;mut T rather than=
<br>
an owned T?<br></blockquote></div></div><div dir=3D"auto"><br></div><div di=
r=3D"auto">The one you have would need to be adjusted but it would work.</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">Another possibility by the=
 way is to have &quot;pub async fn read_obj&lt;T: SizedIoBuffer&gt;(&amp;se=
lf, offset: u64) -&gt; io::Result&lt;T&gt;&quot; and hide the usage of Mayb=
eUninit inside the function... That one doesn&#39;t even try to avoid copie=
s though.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Kevin<br>
<br>
</blockquote></div></div></div>

--000000000000e9cf85062df5f310--


