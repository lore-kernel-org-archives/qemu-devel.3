Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EE5E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:41:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNacf-0001Af-2i; Tue, 17 Dec 2024 11:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNacd-0001AU-QM
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tNacc-0000ol-6b
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734453630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QT5XAi3VeCL08Ldzx0pcvaqmh7pIhOo6NyCCjwApyE0=;
 b=e8jvPIsr0LbVXGjy0tfXCl+5Z2KtL2lFbty8+skz+bA+rVXxZEm59eDOLRpJ5qUI8bOcDD
 8bkKbK+KZbWofsrRTn8xKg/dM9VK5OAGTBJlHDjfPKURhJ3HqB/Ff/HWTO7rASSH2L+38A
 pzCS8/uYlLLPFN6kWqjhnNgMzlzoQR4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-CBMAl09uMlWRRcPgRfxBAQ-1; Tue, 17 Dec 2024 11:40:28 -0500
X-MC-Unique: CBMAl09uMlWRRcPgRfxBAQ-1
X-Mimecast-MFC-AGG-ID: CBMAl09uMlWRRcPgRfxBAQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4361b090d23so14327965e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 08:40:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734453627; x=1735058427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QT5XAi3VeCL08Ldzx0pcvaqmh7pIhOo6NyCCjwApyE0=;
 b=rpDOPcoz6hls+cvlqQ7ym4EU5DjhAYqRhucpd3OqJZTsA2sQMjBYs9TRJTMu/dhsQy
 czAiwHQfIqsp1WCDzYMbjTRg4fl73tvkTyvLnvQ91VhaB3aS15wAR4YiuJNXK7X1PZgG
 09bTLiSxsn1o47BpBYgvU6xGK5Vz1PJ7/YM0wAXlw1q9dMKlpNNTCurYQKON1APoniN/
 p8EfIyTwQdWtOKI/v0a+AztZHrdD6MxeZfov+aLj5UUBvWs+71evbfTkoNIxashzA7lK
 HvHmpVCT3ei5WrJDG1q7EHLEO6rcM5GF9DEx9I+FRK89C+g8Bev9JCzU0xUeyQw6ZJhy
 vkEg==
X-Gm-Message-State: AOJu0YxiMbsJPCU7zeNnb8Eq8s729q7EzRXulwBWdPWO/Tcb04eRUGgY
 T4/tqKm5PCFwJn2YB6eGmcEkgBMxwZKgCR2+6WsF/hIL0z0qMGIVTdAoIAenIIgmb/uOdNdHAqg
 ZgY8HOEbz1hHMJ73An5ngYl8lAtu9h0Kd81XV3pGYjEEQ8BUZzbQ05AbvR41wixpdLKyHx7X4yq
 kqWEpmNjD1zRP2lSVYxDr7HSAA5ig=
X-Gm-Gg: ASbGncusgWyGIcpFfwhO6F+/hytiKrcwuMhiu/bARlVmjhpx21/bvVVeWHv57LZJkKj
 OIpwbc61q4hx5XJfnAfAlcCB3E+F6/SBTOve40w==
X-Received: by 2002:a05:6000:71a:b0:385:e17a:ce6f with SMTP id
 ffacd0b85a97d-38880acce62mr15111346f8f.24.1734453627292; 
 Tue, 17 Dec 2024 08:40:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgNAgc247RVGluYEL/AbibV6+knwjw5EamWxuuUi+wLVS7rIdVFyDc9WVFvuUnbAvZK9YzN/T3sGeS00QdEDk=
X-Received: by 2002:a05:6000:71a:b0:385:e17a:ce6f with SMTP id
 ffacd0b85a97d-38880acce62mr15111328f8f.24.1734453626951; Tue, 17 Dec 2024
 08:40:26 -0800 (PST)
MIME-Version: 1.0
References: <20241209123717.99077-1-pbonzini@redhat.com>
 <20241209123717.99077-27-pbonzini@redhat.com>
 <Z2GjLOppRcHFBpAT@intel.com>
In-Reply-To: <Z2GjLOppRcHFBpAT@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 17 Dec 2024 17:40:14 +0100
Message-ID: <CABgObfYE8z5QeVSWT7odaPcZYNfW0Ox1gNmGyCvj0YRTsDEGrg@mail.gmail.com>
Subject: Re: [PATCH 26/26] rust: callbacks: allow passing optional callbacks
 as ()
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: multipart/alternative; boundary="0000000000005076f8062979f4fe"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000005076f8062979f4fe
Content-Type: text/plain; charset="UTF-8"

Il mar 17 dic 2024, 16:55 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> On Mon, Dec 09, 2024 at 01:37:17PM +0100, Paolo Bonzini wrote:
> > Date: Mon,  9 Dec 2024 13:37:17 +0100
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > Subject: [PATCH 26/26] rust: callbacks: allow passing optional callbacks
> as
> >  ()
> > X-Mailer: git-send-email 2.47.1
> >
> > In some cases, callbacks are optional.  Using "Some(function)" and "None"
> > does not work well, because when someone writes "None" the compiler does
> > not know what to use for "F" in "Option<F>".
>
> I understand the direct use case is MemoryRegionOps, which has optional
> callbacks. However, I'm not quite sure how exactly it should be applied
> to C bindings and how it will play with Option<callback>.
>

You wouldn't use Option<callback> at all, using () instead of None; the
difference is that () does not have a parameter while None does (and the
compiler cannot infer it). But I am okay with leaving this patch behind
until there's a need.

Paolo

Could u pls provide a simple example?
>
> > Therefore, adopt () to mean a "null" callback.  It is possible to enforce
> > that a callback is valid by adding a "let _: () = F::ASSERT_IS_SOME"
> before
> > the invocation of F::call.
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/qemu-api/src/callbacks.rs | 97 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >
> > diff --git a/rust/qemu-api/src/callbacks.rs b/rust/qemu-api/src/
> callbacks.rs
> > index 6401d807198..83c681d6478 100644
> > --- a/rust/qemu-api/src/callbacks.rs
> > +++ b/rust/qemu-api/src/callbacks.rs
> > @@ -76,6 +76,31 @@
> >  /// call_it(&move |_| String::from(x), "hello workd");
>
> typo: s/workd/word/ (in previous patch :-))
>
>

--0000000000005076f8062979f4fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 17 dic 2024, 16:55 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Mo=
n, Dec 09, 2024 at 01:37:17PM +0100, Paolo Bonzini wrote:<br>
&gt; Date: Mon,=C2=A0 9 Dec 2024 13:37:17 +0100<br>
&gt; From: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=
=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; Subject: [PATCH 26/26] rust: callbacks: allow passing optional callbac=
ks as<br>
&gt;=C2=A0 ()<br>
&gt; X-Mailer: git-send-email 2.47.1<br>
&gt; <br>
&gt; In some cases, callbacks are optional.=C2=A0 Using &quot;Some(function=
)&quot; and &quot;None&quot;<br>
&gt; does not work well, because when someone writes &quot;None&quot; the c=
ompiler does<br>
&gt; not know what to use for &quot;F&quot; in &quot;Option&lt;F&gt;&quot;.=
<br>
<br>
I understand the direct use case is MemoryRegionOps, which has optional<br>
callbacks. However, I&#39;m not quite sure how exactly it should be applied=
<br>
to C bindings and how it will play with Option&lt;callback&gt;.<br></blockq=
uote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">You wouldn&#=
39;t use Option&lt;callback&gt; at all, using () instead of None; the diffe=
rence is that () does not have a parameter while None does (and the compile=
r cannot infer it). But I am okay with leaving this patch behind until ther=
e&#39;s a need.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote =
gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Could u pls provide a simple example?<br>
<br>
&gt; Therefore, adopt () to mean a &quot;null&quot; callback.=C2=A0 It is p=
ossible to enforce<br>
&gt; that a callback is valid by adding a &quot;let _: () =3D F::ASSERT_IS_=
SOME&quot; before<br>
&gt; the invocation of F::call.<br>
&gt; <br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://callbacks.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">callbacks.rs</a> | 97 +++++++++++++++++++=
+++++++++++++++<br>
&gt;=C2=A0 1 file changed, 97 insertions(+)<br>
&gt; <br>
&gt; diff --git a/rust/qemu-api/src/<a href=3D"http://callbacks.rs" rel=3D"=
noreferrer noreferrer" target=3D"_blank">callbacks.rs</a> b/rust/qemu-api/s=
rc/<a href=3D"http://callbacks.rs" rel=3D"noreferrer noreferrer" target=3D"=
_blank">callbacks.rs</a><br>
&gt; index 6401d807198..83c681d6478 100644<br>
&gt; --- a/rust/qemu-api/src/<a href=3D"http://callbacks.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">callbacks.rs</a><br>
&gt; +++ b/rust/qemu-api/src/<a href=3D"http://callbacks.rs" rel=3D"norefer=
rer noreferrer" target=3D"_blank">callbacks.rs</a><br>
&gt; @@ -76,6 +76,31 @@<br>
&gt;=C2=A0 /// call_it(&amp;move |_| String::from(x), &quot;hello workd&quo=
t;);<br>
<br>
typo: s/workd/word/ (in previous patch :-))<br>
<br>
</blockquote></div></div></div>

--0000000000005076f8062979f4fe--


