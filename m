Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE57C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 05:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW7li-0001Cv-OR; Tue, 23 Jul 2024 01:08:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sW7lh-0001C9-7M
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:08:57 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wlosh@bsdimp.com>) id 1sW7le-0000Xe-SP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 01:08:56 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d153fec2fso1869455b3a.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 22:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1721711333; x=1722316133;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zpOWw/bJUfiZK8AILZ4TKX1VQHY3jjXvXT4UPa/o0p8=;
 b=CH+IpMhwLKkWO0XL3QN/dj5NUDYhv82q8C3bqIUXVgkO2kL7eMwfKJUMsr1FT7dnYm
 k+OqoP1JpzdUn7GEolCj1NLg+3cO4cDatcIX6q/SNolpTK9NVntSKM5w08px7CnGUWpl
 /jnuRRHA/Hm61kpCRo3Q2ZfuOyr2Re3O4rTAid+tesFR49iOLw6gVB//NNrMtqXPKqcc
 tP11NgLiq7NJ4je6sf68pgHacKumN36CKV55gWnlONdCJlmg0hweVXhn7z38UdDSUjvt
 psXE+p/lBOevs+QxzwCr+xax3hsnUTLKtbwLZNgeWuZQOM0rOGpj0sNz0ApV4mmp29ul
 wedA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721711333; x=1722316133;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zpOWw/bJUfiZK8AILZ4TKX1VQHY3jjXvXT4UPa/o0p8=;
 b=L9pYIcedqOsVZ+JA2lt400w9qPVAkf2YBtajvafbQcf9bme+CtLo9ZIAXj/oGASIQ9
 MMIGyTqwa14jsmJGoMF5klQ1XK1i4074GPiKPj8LMopju3+N1tDMv671BwkYZ7W+HWhb
 lWojbPdpevCSFGaxgeCWx9dIc0fl/y1EU51f82O/BHuXnPI3XaQaAHWj/XJt0Is9tREy
 DaA5Gd4TUDKlNjcrWo32Rs7JJoWgmmMwF2eLKn9hG15W1fNbSYxLt5y08vUyiby9w786
 idsZuzIqK6RGLGT8xLMaMERc/WJXx4E/qYaAf9im2T9eVlZE/iDuBAnfkKelw5TSWJzf
 fKng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjSUbtGTW7tfgkYIAG4c+fdutvDRHLYbXl2hW5DVh3KDPMccfn+sn24KXskiW0QKROP7eLvRglv0ZpxcUlRJcWfx+TghY=
X-Gm-Message-State: AOJu0YysEMWG3bPOkaDYk17wFxV4N+GnjHHk6K0wGJtXGXnZFasyn1nG
 /hoQlzHKd+UZfZEtIgewBI4sggMKBWc04ZkKa1vAyVjJxjqEwUzr9kJWwkLLuuux9mDIZvQ9xfS
 Afetel/hey/pQuyEv/chMO6LcQw67vCY2gYIpxw==
X-Google-Smtp-Source: AGHT+IEcjJw+DP15EeW+2dOAfqEKuqbgLCKHa9RiqYhqVZ5FBTgCJgesamELH0BUiqdAx5kv/QPEmmDDXJK1HQxS+FU=
X-Received: by 2002:a05:6a00:2192:b0:707:ffa4:de3f with SMTP id
 d2e1a72fcca58-70d0efee5d1mr12582439b3a.17.1721711333238; Mon, 22 Jul 2024
 22:08:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240722214313.89503-1-imp@bsdimp.com>
 <20240722214313.89503-15-imp@bsdimp.com>
 <f3c9d0c0-1cfd-46c8-8524-cffbe5180d3f@linaro.org>
 <CANCZdfpPrjt8G5WWRPdMNWyb=hskk7ZCVS3HEAcway=XO=K3ng@mail.gmail.com>
 <f2f6c27e-7625-471f-b888-0f3a870bb0c4@linaro.org>
 <0b7514dc-f9ed-4c48-be37-5a5de7b26229@linaro.org>
In-Reply-To: <0b7514dc-f9ed-4c48-be37-5a5de7b26229@linaro.org>
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 22 Jul 2024 23:08:41 -0600
Message-ID: <CANCZdfo0cw-T29wTg9dQVOE1zmyOxdm_DnxT+GvbPVGE7OWvzw@mail.gmail.com>
Subject: Re: [PATCH 14/14] bsd-user: Add aarch64 build to tree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, Kyle Evans <kevans@freebsd.org>, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000006c88ab061de328e3"
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=wlosh@bsdimp.com; helo=mail-pf1-x42b.google.com
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

--0000000000006c88ab061de328e3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 7:17=E2=80=AFPM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 7/23/24 08:11, Philippe Mathieu-Daud=C3=A9 wrote:
> > On 23/7/24 00:06, Warner Losh wrote:
> >>
> >>
> >> On Mon, Jul 22, 2024 at 3:54=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <
> philmd@linaro.org
> >> <mailto:philmd@linaro.org>> wrote:
> >>
> >>     Hi Warner,
> >>
> >>     On 22/7/24 23:43, Warner Losh wrote:
> >>      > Add the aarch64 bsd-user fragments needed to build the new
> >>     aarch64 code.
> >>      >
> >>      > Signed-off-by: Warner Losh <imp@bsdimp.com <mailto:
> imp@bsdimp.com>>
> >>      > ---
> >>      >   configs/targets/aarch64-bsd-user.mak | 3 +++
> >>      >   1 file changed, 3 insertions(+)
> >>      >   create mode 100644 configs/targets/aarch64-bsd-user.mak
> >>
> >>     Can we build aarch64 on Cirrus-CI? (not clear on
> >>     https://cirrus-ci.org/guide/FreeBSD/
> >>     <https://cirrus-ci.org/guide/FreeBSD/>). If so, could you add
> >>     a follow-up patch to build that on our CI, patching
> >>     .gitlab-ci.d/cirrus.yml?
> >>
> >>
> >> We can build aarch64 host for bsd-user for sure. I'll see if we can do
> it in cirrus CI.
> >> If so, I'll try to add it to cirrus.yml.
> >>
> >> This patch series adds aarch64 guest...
> >
> > Yes, we want to use a aarch64 FreeBSD host to build your FreeBSD
> > aarch64 bsd-user guest and test it. Am I wrong?
> >
>
> This is adding guest support, so your suggestion is orthogonal.
>

Yea...  It's a good suggestion, but not what I'm working on right now...

Warner

--0000000000006c88ab061de328e3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jul 22, 2024 at 7:17=E2=80=AF=
PM Richard Henderson &lt;<a href=3D"mailto:richard.henderson@linaro.org">ri=
chard.henderson@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">On 7/23/24 08:11, Philippe Mathieu-Daud=C3=A9 wro=
te:<br>
&gt; On 23/7/24 00:06, Warner Losh wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Mon, Jul 22, 2024 at 3:54=E2=80=AFPM Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linar=
o.org</a> <br>
&gt;&gt; &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">=
philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Hi Warner,<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 On 22/7/24 23:43, Warner Losh wrote:<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Add the aarch64 bsd-user fragments n=
eeded to build the new<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 aarch64 code.<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; Signed-off-by: Warner Losh &lt;<a hr=
ef=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a> &lt;mailt=
o:<a href=3D"mailto:imp@bsdimp.com" target=3D"_blank">imp@bsdimp.com</a>&gt=
;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt; ---<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0configs/targets/aarch64-=
bsd-user.mak | 3 +++<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A01 file changed, 3 insert=
ions(+)<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0=C2=A0 &gt;=C2=A0 =C2=A0create mode 100644 confi=
gs/targets/aarch64-bsd-user.mak<br>
&gt;&gt;<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 Can we build aarch64 on Cirrus-CI? (not clear o=
n<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 <a href=3D"https://cirrus-ci.org/guide/FreeBSD/=
" rel=3D"noreferrer" target=3D"_blank">https://cirrus-ci.org/guide/FreeBSD/=
</a><br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 &lt;<a href=3D"https://cirrus-ci.org/guide/Free=
BSD/" rel=3D"noreferrer" target=3D"_blank">https://cirrus-ci.org/guide/Free=
BSD/</a>&gt;). If so, could you add<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 a follow-up patch to build that on our CI, patc=
hing<br>
&gt;&gt; =C2=A0=C2=A0=C2=A0 .gitlab-ci.d/cirrus.yml?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; We can build aarch64 host for bsd-user for sure. I&#39;ll see if w=
e can do it in cirrus CI.<br>
&gt;&gt; If so, I&#39;ll try to add it to cirrus.yml.<br>
&gt;&gt;<br>
&gt;&gt; This patch series adds aarch64 guest...<br>
&gt; <br>
&gt; Yes, we want to use a aarch64 FreeBSD host to build your FreeBSD<br>
&gt; aarch64 bsd-user guest and test it. Am I wrong?<br>
&gt; <br>
<br>
This is adding guest support, so your suggestion is orthogonal.<br></blockq=
uote><div><br></div><div>Yea...=C2=A0 It&#39;s a good suggestion, but not w=
hat I&#39;m working on right now...</div><div><br></div><div>Warner <br></d=
iv></div></div>

--0000000000006c88ab061de328e3--

