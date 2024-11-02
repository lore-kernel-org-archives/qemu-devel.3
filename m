Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71164E677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 10:52:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7Biv-0001Ur-2G; Sat, 02 Nov 2024 06:51:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t7Bit-0001Uf-HX
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 06:51:15 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1t7Bir-0006Xe-VA
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 06:51:15 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7b148919e82so185704485a.0
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2024 03:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730544673; x=1731149473; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=V/CuPBxOaPUksthtvanxN+Sr5/HQPk0LNiKwqtBK+MU=;
 b=mnvduXgkx4G7rN3a/HrnQpZjxXO7ldBYkPJkPYbls2wo8JzoETtr7YBnWc+9uTtGQX
 NpKNk0CAO6Qj/E3sEd2+wby7NhR5TITgEmV37peSUw4s+Pb8GUm6qwLDJuqZIyZNWn3r
 Xl6+ZVyVD8UMJ411wJ1X6amg2Ano1FseJNzwGTHFhW1Wgz6jS6BD4R/q2A1Yy3II+JZ+
 Lpbvmlzr+QTXyXQOdKHShXCSW5zDkXqXSjFx2Gf7kc2qKjfiUenhkwr/OEhI/A2e4hGm
 UapcTg5IWNc7Ku//Hk2prrWRpbAOmFIy8MJslA43vfX+RN7ovx9H0m9CfQ3v1oc3XMKb
 ueHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730544673; x=1731149473;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V/CuPBxOaPUksthtvanxN+Sr5/HQPk0LNiKwqtBK+MU=;
 b=YFSiQKfxshL4ZaHVt1Po7D9ZhKQ0Pk2VV8qnjyV+ZyoQtIJWhDqzJ78Pg9PITwuKlj
 gtgs3E8gJw/mu3O6djsnhC136iPFZEVwUSiHMGrL125hZwY+iNsLKFx94+Sj4HTHHbBd
 k7MN6Kbf0MTkibiMmP+eUFfTJGrm050NH+ueXYUXkK8EmqZTknwOxEXaif8/2zuMPsVh
 f22AsF7aRe9PSCYDdbVIRlg//1Y9+cw85oItEoDmFrfnJ7HuxZOtQLj0X9/3xsxgz/M6
 pp4+UpWX5EXHCBo/cMOZfts5Byvtf5LQ3IK+d7cQjSdHKQriS9+r/yz1ERUOGPJ8EHLQ
 zr0Q==
X-Gm-Message-State: AOJu0YwIBgdPk/NRXE17JDuKntWH0EASbh/RCe8eZnckMqoZMyf/r8dI
 O2hEnmDFu6hcgubvL0VJE0/zufeqn0aJYSDWpO0DhQOW87YZSaYsS74ATpuFxWE4Wtoi1FZpUa0
 t7Zj6nnH5MxqlsZGnGB2aJVBtNIY=
X-Google-Smtp-Source: AGHT+IFMXRXyaj7T+IZ4JqejIDU2bJXQQf+DwtFKMR7Q/6Llt4/jZB8zU8Di2ZJh/1EQSJh4bQTx/6foJI6XPq7vYFI=
X-Received: by 2002:a05:620a:248f:b0:7b1:1269:44b4 with SMTP id
 af79cd13be357-7b2f24f0015mr1497298885a.36.1730544672602; Sat, 02 Nov 2024
 03:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
 <20241015085150.219486-8-marcandre.lureau@redhat.com>
 <CAFEAcA8DztPbmp_PavV9EGs=1RUeszDOpGRtwVexQbcCOXWO0A@mail.gmail.com>
In-Reply-To: <CAFEAcA8DztPbmp_PavV9EGs=1RUeszDOpGRtwVexQbcCOXWO0A@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 2 Nov 2024 14:51:01 +0400
Message-ID: <CAJ+F1CK5N6ZH_VfR-VAFqo0or6TVWvCViSEYUh3wCj0HmqsO3w@mail.gmail.com>
Subject: Re: [PULL 7/8] chardev/mux: implement detach of frontends from mux
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Roman Penyaev <r.peniaev@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007a82ae0625ebd4c8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000007a82ae0625ebd4c8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Nov 1, 2024 at 7:26=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org>
wrote:

> On Tue, 15 Oct 2024 at 09:52, <marcandre.lureau@redhat.com> wrote:
> >
> > From: Roman Penyaev <r.peniaev@gmail.com>
> >
> > With bitset management now it becomes feasible to implement
> > the logic of detaching frontends from multiplexer.
> >
> > Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
> > Cc: "Marc-Andr=C3=A9 Lureau" <marcandre.lureau@redhat.com>
> > Cc: qemu-devel@nongnu.org
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > Message-ID: <20241014152408.427700-8-r.peniaev@gmail.com>
>
> Hi; Coverity reports an issue with this patch. I think
> it's probably a bit confused, but on the other hand
> I read the code and am also a bit confused so we could
> probably adjust it to be clearer...
>
> > +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
> > +{
> > +    unsigned int bit;
> > +
> > +    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);
>
> Why are we calling find_next_bit() here? Coverity
> points out that it can return MAX_MUX, which means that
> if the caller passed in MAX_MUX then we will try to
> dereference d->backends[MAX_MUX] which is off the
> end of the array.
>
> What I was expecting this code to do was to check
> "is the bit actually currently set?", which would be
>    if (!(d->mux_bitset & (1 << bit))) {
>        ...
>    }
>

It's actually sort of checking the tag bit is set:

    bit =3D find_next_bit(&d->mux_bitset, MAX_MUX, tag);
    if (bit !=3D tag) { // <- here
        return false;

The function should probably assert(tag < MAX_MUX) though, that will help
coverity I guess


> Why do we want to find the next bit set after the
> 'tag' bit ?
>
> > +    if (bit !=3D tag) {
> > +        return false;
> > +    }
> > +
> > +    d->mux_bitset &=3D ~(1 << bit);
> > +    d->backends[bit] =3D NULL;
> > +
> > +    return true;
> > +}
>
> (This is CID 1563776.)
>
> thanks
> -- PMM
>
>

--=20
Marc-Andr=C3=A9 Lureau

--0000000000007a82ae0625ebd4c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 1, 2024 at 7:26=E2=80=
=AFPM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linaro.org">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">On Tue, 15 Oct 2024 at 09:52, &lt;<a href=3D"mailto:marcan=
dre.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt=
; wrote:<br>
&gt;<br>
&gt; From: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com" target=
=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
&gt;<br>
&gt; With bitset management now it becomes feasible to implement<br>
&gt; the logic of detaching frontends from multiplexer.<br>
&gt;<br>
&gt; Signed-off-by: Roman Penyaev &lt;<a href=3D"mailto:r.peniaev@gmail.com=
" target=3D"_blank">r.peniaev@gmail.com</a>&gt;<br>
&gt; Cc: &quot;Marc-Andr=C3=A9 Lureau&quot; &lt;<a href=3D"mailto:marcandre=
.lureau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<b=
r>
&gt; Cc: <a href=3D"mailto:qemu-devel@nongnu.org" target=3D"_blank">qemu-de=
vel@nongnu.org</a><br>
&gt; Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lu=
reau@redhat.com" target=3D"_blank">marcandre.lureau@redhat.com</a>&gt;<br>
&gt; Message-ID: &lt;<a href=3D"mailto:20241014152408.427700-8-r.peniaev@gm=
ail.com" target=3D"_blank">20241014152408.427700-8-r.peniaev@gmail.com</a>&=
gt;<br>
<br>
Hi; Coverity reports an issue with this patch. I think<br>
it&#39;s probably a bit confused, but on the other hand<br>
I read the code and am also a bit confused so we could<br>
probably adjust it to be clearer...<br>
<br>
&gt; +bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 unsigned int bit;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 bit =3D find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, t=
ag);<br>
<br>
Why are we calling find_next_bit() here? Coverity<br>
points out that it can return MAX_MUX, which means that<br>
if the caller passed in MAX_MUX then we will try to<br>
dereference d-&gt;backends[MAX_MUX] which is off the<br>
end of the array.<br>
<br>
What I was expecting this code to do was to check<br>
&quot;is the bit actually currently set?&quot;, which would be<br>
=C2=A0 =C2=A0if (!(d-&gt;mux_bitset &amp; (1 &lt;&lt; bit))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
=C2=A0 =C2=A0}<br></blockquote><div><br></div><div>It&#39;s actually sort o=
f checking the tag bit is set:<br></div><div><br></div><div>=C2=A0 =C2=A0 b=
it =3D find_next_bit(&amp;d-&gt;mux_bitset, MAX_MUX, tag);<br>=C2=A0 =C2=A0=
 if (bit !=3D tag) { // &lt;- here<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 return fa=
lse;<br></div><div>=C2=A0</div><div>The function should probably assert(tag=
 &lt; MAX_MUX) though, that will help coverity I guess</div><div><br></div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Why do we want to find the next bit set after the<br>
&#39;tag&#39; bit ?<br>
<br>
&gt; +=C2=A0 =C2=A0 if (bit !=3D tag) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 d-&gt;mux_bitset &amp;=3D ~(1 &lt;&lt; bit);<br>
&gt; +=C2=A0 =C2=A0 d-&gt;backends[bit] =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt; +}<br>
<br>
(This is CID 1563776.)<br>
<br>
thanks<br>
-- PMM<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--0000000000007a82ae0625ebd4c8--

