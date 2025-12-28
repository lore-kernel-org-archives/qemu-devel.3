Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFDED3B7E5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 16:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZtVb-0003f6-7J; Sun, 28 Dec 2025 11:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZtVa-0003eq-Cy
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:20:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZtVY-0008Ex-As
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 11:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766938838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o33AJvkWyX2AZyLNFiTTGHT53sGDLKh+xd+jG+dlOwg=;
 b=gIixj/+yck8fdgfWKrOMNO3TXJi7DE/uLUHqtgW52YKjOp6uPjUrtc8yINxxUWa4v67D4C
 hvmrWAhNGVfeu4BcDyxasrNdrS16EE/tBCI+rZ94wKIuMrc3PQY9fyV4jKHdjrFHKfzpNd
 nVafVLO+Ii16rJ1YON01hF2pPzZurI8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-NDQMrV-uNbKkaMSSOfdwnw-1; Sun, 28 Dec 2025 11:20:36 -0500
X-MC-Unique: NDQMrV-uNbKkaMSSOfdwnw-1
X-Mimecast-MFC-AGG-ID: NDQMrV-uNbKkaMSSOfdwnw_1766938836
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47d28e7960fso27922355e9.0
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 08:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766938836; x=1767543636; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o33AJvkWyX2AZyLNFiTTGHT53sGDLKh+xd+jG+dlOwg=;
 b=CVAK3xzWhYVr0xjf9tWSzmuamiCxcDlBEJjfY8vlq3f+0nqc1gbuipgWo4PRpJeydl
 8Dym8iEu/ZdA35OJJzZ54KStB943wne+n9d7cDpD+Sr8APrqjgufTYjEceZZy/6+N2Jd
 +htFqyblVn3/CjoK9CfPQp5Y2buLeankSkrRfzKdHcPUbCM2tVYMmdBXw1oA0EFdyN6V
 Zmh0uBv51gUrU0K//sh9MyEv8EANP7h+CuOqyVOP2TjPi5M/xL25Ua6frB0PAdt+IpK6
 p1IJ00Rc2XA33y7qVCVwIeUYAXDdQfnWlXT3b97rRJ8OZYNcXos30Jwv4j/RpdOAb/MQ
 d0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766938836; x=1767543636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o33AJvkWyX2AZyLNFiTTGHT53sGDLKh+xd+jG+dlOwg=;
 b=iHu9dypZq4QO57Os1j/04pdkpsAXKoJ2xTXTQdtRa8+Z7/HyZwJGDQh384VS6xWwOw
 z83M0ul/xYW1K4K17xH2fT5hpze2XnZB9qATafJd3FOja7H0ZxJnWYHCWI/r0/6dTEfH
 uJHSa4lxtAmT8OQlgQWvG6d7QSgJf6z2IuAfqd7PZPC971FMj7xPFb3CoE6pv4Cg3dLC
 AKF7UweEyZPi/dZJos1d29GBMD8YvmBFx7XJRD1Vqk6JOY4rAJ5BrAJvTVepymwdARsU
 1gsdaJ4PAlKXqxl1RZqhFCffPVaLugu4duf83W6WNHvqOwi4XSTl3XJY8DJHhtvsSvIg
 dlbQ==
X-Gm-Message-State: AOJu0YwzSspxb3JkuDP7eE13c9x8MlFWhwUFLBiAN+DWGiS2zfzrhlBl
 Jl3p0xhCrTyKtOY1Q8HSSLvJaTK6JXLJ/5rsET28X97WE6YY01Z1cHyyo79IBoDdCIMglMgIU1o
 W+CqOU9LEhPB1i22Iw2afEH4xdCJWeoHZHUh2PauUdp5JKCsubEN+Awt6IlhMcHbHwrHY7Aipbm
 Q+tEpnIbiHRPGamiG6DF8L3eUQpGCPaU4=
X-Gm-Gg: AY/fxX4e4DFrStcDM2FcfXf5Goosg6zsZ6HWZWpg9Hb1u2XElpBqIkOh6zJeeZwL5Lv
 D7+mN3raeywGX82ZolSdD5QiPY81gUFkqc4r3dxbMUXNz/DONa4KBI5Unfu8TEOtuKBH2mF4vfg
 9WhANIinlksk+m0qHPgLtDl1TNUYHSbp56e7kY+/aDvBNOn+Pu/l9VY+dx2+CvO5xN7E4L6Xnru
 GtZgfo5T3ZYlXRSnruVLAr034HxIJfyUNEB2uqim7y6jMO3B7Jjm36qKBspo99kFiGQHyg=
X-Received: by 2002:a05:600c:19c8:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-47d1955797amr328617895e9.16.1766938835604; 
 Sun, 28 Dec 2025 08:20:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG22IMWFZjgFtxHVYUrgXSscHh/4pvaZjzqb1vPMlN/9L+5PMjqJpV4QXne4eTrMRnR2o0X4NYFvv2PFnQUwtM=
X-Received: by 2002:a05:600c:19c8:b0:475:de68:3c30 with SMTP id
 5b1f17b1804b1-47d1955797amr328617665e9.16.1766938835156; Sun, 28 Dec 2025
 08:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-17-philmd@linaro.org>
 <CABgObfa9gHpK3CR8Aa6MA4YqfaMs3bn70pba58QQ2+32+xwxzQ@mail.gmail.com>
 <e0b99887-934e-4587-9410-b090a4fcfdc8@linaro.org>
 <5e44a3e7-5eb3-4220-9193-8eb86690535c@linaro.org>
 <CABgObfaXgpdPe32ks+xkzOuNxvJMJhsfpvtjFobBJTueR1X24A@mail.gmail.com>
 <913b7541-d8f0-47b9-8523-9e1389bf4f84@linaro.org>
 <CABgObfYXW7RqZjqHVQd8T-RfZvy8oxb7-uWK0Au1W5VXzHVSNA@mail.gmail.com>
 <1b73aeb0-fa3f-4ced-9c07-5f0accebc324@linaro.org>
In-Reply-To: <1b73aeb0-fa3f-4ced-9c07-5f0accebc324@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 28 Dec 2025 17:20:23 +0100
X-Gm-Features: AQt7F2rflyNEB_AvlGtd4gZVKqDuNDpIDfpEgCLXUhUBqFuj-w-Bv6xoz1BtHio
Message-ID: <CABgObfbquY+4KqQn+o5nKhWPuFJnOB_LYTJzVCjF-GgH8VcQNg@mail.gmail.com>
Subject: Re: [PATCH v3 16/25] system: Allow restricting the legacy ld/st_he()
 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="0000000000009c1846064705812a"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--0000000000009c1846064705812a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il dom 28 dic 2025, 17:00 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> On 28/12/25 16:38, Paolo Bonzini wrote:
> >
> >
> > Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g
> > <mailto:philmd@linaro.org>> ha scritto:
> >
> >      > Perhaps the source of the confusion is that they are in bswap.h
> >     but they
> >      > (quite obviously since it's host endianness) never swap?
> >
> >     Hmm, maybe not well named API then.
> >
> >
> > The name is fine, the placement maybe a bit less; they could be moved
> > out of bswap.h but it's not really necessary to do it now.
>
> Indeed not needed now, but already done to figure this API ;) This
> helped me to understand what we don't need is "DO_STN_LDN_P(he)"
> because this is a convoluted expansion to a plain memcpy().
>

Without having seen your code, I will note that the simple conversion to
memcpy() only works for little endian hosts. On big endian, you also need
to adjust the first byte, like

   memcpy(p, ((uint8_t*)&val) + sizeof(val) - n, n);

And likewise for ldn_he_p. (Apologize if you had noticed it, just trying to
avoid a possible round trip over the holidays!)

Paolo


> >     OK. Let's consider the following patches removed then:
> >
> >     - 03/25 system: Use explicit endianness in subpage_ops::read/write(=
)
> >     - 14/25 system: Use explicit endianness in ram_device::read/write()
> >     - 16/25 system: Allow restricting legacy ld/st_he() 'native-endian'
> API
> >
> >     All the series I posted this week build fine without them.
> >
> >
> > Great, the other change I suggested was about the handling of MO_BSWAP
> > but it can be done separately.
>
> This request is not ignored, but I plan to address it on top to keep
> current changes simple enough.
>
> >
> > If you don't want to repost and prefer to drop patch 14, we will also
> > remove DEVICE_NATIVE_ENDIAN from subpages in a second step, for example
> > by using "HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_ENDIAN" a=
s
> > in the ram_device ops.
>
> Yeah, that would even be smth like "DEVICE_ENDIANNESS_IS_IRRELEVANT", as
> we call directly the ld/st_unaligned helpers. I'll think about that later=
.
>
>

--0000000000009c1846064705812a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote gmail_quote_container"><di=
v dir=3D"ltr" class=3D"gmail_attr">Il dom 28 dic 2025, 17:00 Philippe Mathi=
eu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a=
>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">On 28/12/25 16:38, Paolo Bonzini wrote:<br>
&gt; <br>
&gt; <br>
&gt; Il dom 28 dic 2025, 16:14 Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"m=
ailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferrer">philmd@linaro=
.org</a> <br>
&gt; &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=
=3D"noreferrer">philmd@linaro.org</a>&gt;&gt; ha scritto:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; Perhaps the source of the confusion is that t=
hey are in bswap.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0but they<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; (quite obviously since it&#39;s host endianne=
ss) never swap?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hmm, maybe not well named API then.<br>
&gt; <br>
&gt; <br>
&gt; The name is fine, the placement maybe a bit less; they could be moved =
<br>
&gt; out of bswap.h but it&#39;s not really necessary to do it now.<br>
<br>
Indeed not needed now, but already done to figure this API ;) This<br>
helped me to understand what we don&#39;t need is &quot;DO_STN_LDN_P(he)&qu=
ot;<br>
because this is a convoluted expansion to a plain memcpy().<br></blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Without having s=
een your code, I will note that the simple conversion to memcpy() only work=
s for little endian hosts. On big endian, you also need to adjust the first=
 byte, like</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=
=A0memcpy(p, ((uint8_t*)&amp;val) + sizeof(val) - n, n);</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">And likewise for ldn_he_p. (Apologize if y=
ou had noticed it, just trying to avoid a possible round trip over the holi=
days!)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quo=
te_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0OK. Let&#39;s consider the following patches remove=
d then:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0- 03/25 system: Use explicit endianness in subpage_=
ops::read/write()<br>
&gt;=C2=A0 =C2=A0 =C2=A0- 14/25 system: Use explicit endianness in ram_devi=
ce::read/write()<br>
&gt;=C2=A0 =C2=A0 =C2=A0- 16/25 system: Allow restricting legacy ld/st_he()=
 &#39;native-endian&#39; API<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0All the series I posted this week build fine withou=
t them.<br>
&gt; <br>
&gt; <br>
&gt; Great, the other change I suggested was about the handling of MO_BSWAP=
 <br>
&gt; but it can be done separately.<br>
<br>
This request is not ignored, but I plan to address it on top to keep<br>
current changes simple enough.<br>
<br>
&gt; <br>
&gt; If you don&#39;t want to repost and prefer to drop patch 14, we will a=
lso <br>
&gt; remove DEVICE_NATIVE_ENDIAN from subpages in a second step, for exampl=
e <br>
&gt; by using &quot;HOST_BIG_ENDIAN ? DEVICE_BIG_ENDIAN : DEVICE_LITTLE_END=
IAN&quot; as <br>
&gt; in the ram_device ops.<br>
<br>
Yeah, that would even be smth like &quot;DEVICE_ENDIANNESS_IS_IRRELEVANT&qu=
ot;, as<br>
we call directly the ld/st_unaligned helpers. I&#39;ll think about that lat=
er.<br>
<br>
</blockquote></div></div></div>

--0000000000009c1846064705812a--


