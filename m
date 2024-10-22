Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CC3D1715D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 04:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t363w-0000N6-5E; Tue, 22 Oct 2024 00:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t363u-0000Mj-HA
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:00:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t363r-0002zz-DC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 00:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729569592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KqwQ8K5nr+5/4hLsGkp1lksLREgqh4Qx9XjG8XBHcTI=;
 b=EqgV0kV/jDZHiQxeMgEuiPa1HiL/q0CuqStMlaMSnAwHeHodSD+/4deSpbSF2QHEUnaxXx
 ujW77NkywsH0G/xJV4ytmc1op1oy52Nyoz+y78TouAWnqw+k2I5Mruz0+6UPGWYgvvXZsT
 Y+1qnki1/UIrk0tmOf6VhX4UG3ahipY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-V1r91DhXMYaSHT_G35aicw-1; Mon, 21 Oct 2024 23:59:49 -0400
X-MC-Unique: V1r91DhXMYaSHT_G35aicw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d47127e69so2248219f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 20:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729569586; x=1730174386;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KqwQ8K5nr+5/4hLsGkp1lksLREgqh4Qx9XjG8XBHcTI=;
 b=THSyKDxufr9eBI0GzrOZBKRbyrPRcq/q9FfVDxbRLmFc9WDNKeFMAmH8yt1FHdQfPv
 qWJMAtp4y2DIzb+wZf6mWqjrhpPOlPy4uRa8Jb5oyYEffu05KeGq0pnGNYNDop526r/X
 +nLNvTs6b7XQYg8ZbkT/rzhOyoG3WXitlP20W2Nm4zw3Y10BsQDTyg4qlLoml0msNRhU
 ZTpXj8Uv86TV7g0XqhmlfktSKoYmrZC3gvgw+4DzPGcO6q3xZ/r3D7dP3oJgtZBgpQA2
 DqVqpNCCT67Hs629a+3hr5A3GNjZFLvSiP4sFOfkjSRB0nyfpYkj4YT+zFcBSOA3SBEC
 MDzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYnwZr0ZKL3G31JkcmtuhhAbwqFBauWg2PH2I9hfIE1cwl7gwBwuQt7yXpT4XlDcK/2EbD3+vkd5Zc@nongnu.org
X-Gm-Message-State: AOJu0YxYGsi43EHBSRJ8j3bDSTn8K8eQxQFvVvhtFquw/GAgsgIvU+At
 MR/rbYJTjlbFAh9d4hr09UNEWwPSEGZFzHE7EX2AeCuuODWP9AfqxW6mchq44luTje4+KD+MDIs
 2JA5BmTVX/KT8KujLhrsfJRMaOJ+mLWS4bi8kZrjRyFCMBZkEtep0Sbqt96q5vrDfaNPrULZrq4
 tVh7mN9KEzbvOvLKshJnfyFtx5LJI=
X-Received: by 2002:a05:6000:100d:b0:37d:4f1b:359 with SMTP id
 ffacd0b85a97d-37eb48a0f28mr8425625f8f.53.1729569586086; 
 Mon, 21 Oct 2024 20:59:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoHBwD1eBGvVDwEpmOOHbydv6BQXRrW9nlVLYQRYuPC0a2avJq/Api+VUqS7TM6n4ddj22CGmIayZKWxjuKNw=
X-Received: by 2002:a05:6000:100d:b0:37d:4f1b:359 with SMTP id
 ffacd0b85a97d-37eb48a0f28mr8425612f8f.53.1729569585620; Mon, 21 Oct 2024
 20:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20241015131735.518771-1-pbonzini@redhat.com>
 <20241015131735.518771-4-pbonzini@redhat.com>
 <ZxX1jSkJ3Muk11zC@intel.com>
 <CABgObfa6G0Seobc5jLsxEFSRXu4qf-1U7vEEix6pCX=wfsjsPw@mail.gmail.com>
 <ME0P300MB10407A693663615D8AD3F507954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P300MB10407A693663615D8AD3F507954C2@ME0P300MB1040.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 22 Oct 2024 05:59:34 +0200
Message-ID: <CABgObfZtY7yd4WtBcSNB8VhtZcEgLqsYFQ0fE_90oeRRryBbNA@mail.gmail.com>
Subject: Re: [PATCH 03/16] rust: pass rustc_args when building all crates
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000c401ac062508cc00"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000c401ac062508cc00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 22 ott 2024, 04:35 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > On Mon, Oct 21, 2024 at 8:16=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> =
wrote:
> >> unsafe_op_in_unsafe_fn is allowed in
> >> rust/qemu-api/src/lib.rs. So should we wrap the bindings in a separate
> >> lib (similar to the rust/bindings in the Linux kernel)?
> >>
> >> This way, the special lint settings can be applied only to the binding
> >> files, while the default lint checks can cover the other user
> >> development code.
> >>
> >> In addition, another thing that confuses me is why bindgen still
> >> generates code that does not follow the unsafe_op_in_unsafe_fn
> >> requirement. It seems that bindgen has supported unsafe_op_in_unsafe_f=
n
> >> since v0.62 [1, 2], but binding code we generated still violates
> >> unsafe_op_in_unsafe_fn. Is this a bug of bindgen?
> >
> > The plan is to support older versions of bindgen (0.60.x) as long as
> > Debian has them. One possibility to fix this is, as you said, to use a
> > completely separate crate. Another is to add #![allow()] to just the
> > bindings module, for example by changing bindgen.rs to
> >
> > #![allow(...)]
> > include!("bindgen.rs.inc")
> >
> > This is related to the fact that we don't have yet a good way to run
> > "clippy", because "cargo clippy" needs the bindgen.rs file. So we
> > should probably look at these issues at once.
> >
> > Paolo
>
> Since meson 0.6.0 clippy-driver can be used as a wrapper of rustc. So we
> can run clippy by:
>
>    mkdir build.clippy && cd build.clippy
>    RUSTC=3Dclippy-driver ../configure --enable-rust ...
>    ninja librust_x86_64_softmmu.a
>

True but it's less handy to have a separately-configured tree instead of
just "make clippy". Also the same is true of rustfmt and rustdoc (which
ideally would be part of the build so that doctests are also run by make
check-unit). So the question of how to emulate these other cargo tools is
open.

Paolo


> --
> Best Regards
> Junjie Mao
>
>

--000000000000c401ac062508cc00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 22 ott 2024, 04:35 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; On Mon, Oct 21, 2024 at 8:16=E2=80=AFAM Zhao Liu &lt;<a href=3D"mailto=
:zhao1.liu@intel.com" target=3D"_blank" rel=3D"noreferrer">zhao1.liu@intel.=
com</a>&gt; wrote:<br>
&gt;&gt; unsafe_op_in_unsafe_fn is allowed in<br>
&gt;&gt; rust/qemu-api/src/<a href=3D"http://lib.rs" rel=3D"noreferrer nore=
ferrer" target=3D"_blank">lib.rs</a>. So should we wrap the bindings in a s=
eparate<br>
&gt;&gt; lib (similar to the rust/bindings in the Linux kernel)?<br>
&gt;&gt;<br>
&gt;&gt; This way, the special lint settings can be applied only to the bin=
ding<br>
&gt;&gt; files, while the default lint checks can cover the other user<br>
&gt;&gt; development code.<br>
&gt;&gt;<br>
&gt;&gt; In addition, another thing that confuses me is why bindgen still<b=
r>
&gt;&gt; generates code that does not follow the unsafe_op_in_unsafe_fn<br>
&gt;&gt; requirement. It seems that bindgen has supported unsafe_op_in_unsa=
fe_fn<br>
&gt;&gt; since v0.62 [1, 2], but binding code we generated still violates<b=
r>
&gt;&gt; unsafe_op_in_unsafe_fn. Is this a bug of bindgen?<br>
&gt;<br>
&gt; The plan is to support older versions of bindgen (0.60.x) as long as<b=
r>
&gt; Debian has them. One possibility to fix this is, as you said, to use a=
<br>
&gt; completely separate crate. Another is to add #![allow()] to just the<b=
r>
&gt; bindings module, for example by changing <a href=3D"http://bindgen.rs"=
 rel=3D"noreferrer noreferrer" target=3D"_blank">bindgen.rs</a> to<br>
&gt;<br>
&gt; #![allow(...)]<br>
&gt; include!(&quot;bindgen.rs.inc&quot;)<br>
&gt;<br>
&gt; This is related to the fact that we don&#39;t have yet a good way to r=
un<br>
&gt; &quot;clippy&quot;, because &quot;cargo clippy&quot; needs the <a href=
=3D"http://bindgen.rs" rel=3D"noreferrer noreferrer" target=3D"_blank">bind=
gen.rs</a> file. So we<br>
&gt; should probably look at these issues at once.<br>
&gt;<br>
&gt; Paolo<br>
<br>
Since meson 0.6.0 clippy-driver can be used as a wrapper of rustc. So we<br=
>
can run clippy by:<br>
<br>
=C2=A0 =C2=A0mkdir build.clippy &amp;&amp; cd build.clippy<br>
=C2=A0 =C2=A0RUSTC=3Dclippy-driver ../configure --enable-rust ...<br>
=C2=A0 =C2=A0ninja librust_x86_64_softmmu.a<br></blockquote></div></div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">True but it&#39;s less handy to =
have a separately-configured tree instead of just &quot;make clippy&quot;. =
Also the same is true of rustfmt and rustdoc (which ideally would be part o=
f the build so that doctests are also run by make check-unit). So the quest=
ion of how to emulate these other cargo tools is open.=C2=A0</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
</blockquote></div></div></div>

--000000000000c401ac062508cc00--


