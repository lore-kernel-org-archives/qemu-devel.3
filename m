Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BC2C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4wY-0002zL-9A; Fri, 28 Feb 2025 13:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1to4wO-0002mI-8k
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:18:29 -0500
Received: from mail-vk1-xa36.google.com ([2607:f8b0:4864:20::a36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1to4wJ-0004Bq-C4
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:18:26 -0500
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-51eb1818d4fso2284850e0c.1
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 10:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740766698; x=1741371498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=srTJO2lNzFZqSDvzVH7guSxSjqkeUYfInuYUGuu8/Qs=;
 b=sPHqYl71sqmTOShFXtw7cSqCyHFxWK7J9oe4Ss5EVSa/5u9JqEZy86zIh0OX7jfmsM
 0jKQRiu55X3Kl5VxtSgZp3uuXkVcITPNLmOiJqSFtxHgDCa214wLnWbP0S2QzlrbNnqe
 exGGVLYn4EpJx2qDV3tzzL2SvVi3pVymbf+UXumD2Sd4sKJi76fgTBH0DpoaxNFcY+lJ
 zFcSJ3FAj9UI9Ao1MLSxhWYCJEGj/2AQhkp3bhPH4pvO5HOJtqkaTsWNqwiuv3WxdlC/
 OqWKalmfooqG58mX+DTe+w2O5ErcW4JSt8z3OvP2vs3ZA+dTX0nS9d2cvqhKqnzdICbI
 OHFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740766698; x=1741371498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srTJO2lNzFZqSDvzVH7guSxSjqkeUYfInuYUGuu8/Qs=;
 b=wTcXxybedZQocbOOGvjZM3pGr8GIbzI4A1XCsS70FA1UCBuNlCHpXTD5HVZ2pgszpI
 e68uQVVHcd5ky49+2bVLbBzRLTNI6n+Ge/hjk0PGhS/uuhhNo4ErgZuQPNxvl3TYwU19
 ak+9c7VK9n0gwzY99xnSNY27hpju+hr+eg1abm88UOxh4Z3hvRmHdTH1izR8UOF88zX+
 tz8czavL8fia6amaTHZMrid2JqXZxNgoeNORLqm3KFunWt2JEpHbDO4QawXkRieVPIq5
 jAbCZu9jcDxN23NfJfI6Ij5vk8OqSfGhKatqCp9UKYTkxhoebUhosrsxX4eYzc+Dmk6G
 DmPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOOgtNJDJuZoL3DngxdLXIm3LzWE0sXH5mI14cD6OHY5JZjxW9rcef3SYfc+FLYgYxXa63/E3ZHIYB@nongnu.org
X-Gm-Message-State: AOJu0YzpdY+caHtZyqFqUpe8wi/XuobMwCu7JmGbxpwABdklJuzV1VDy
 cFILavCWmIepn4ujD27T+zKczutiPHoAsO5NX3GZxUg8oJUDwdrugBkM36cqKtXMbM8w7iAbpc4
 aNCUYma0f/fYdgDmjxIHRsr+y3eA95heQf7lV
X-Gm-Gg: ASbGncsVtl4TM+I57D/rLFyj1Qs0e97/PuwnVX8vxYjPKXawBtDa7jwdFrZMadmGS9A
 tIZdXoFcCDWOYdzq8Re7Sp8GIBFu6vO5hN7S0RE2NnDxkHnZne8R9U4MhshD4IJC3ryv/wCsc+I
 GvgUepncKMYLzCYmVMUB0P81YgSbx8dggDZPHRAncMQg==
X-Google-Smtp-Source: AGHT+IG27hWGzW1LzN/eNXKtlJHqEQkTe1guHAmzSogCDgTEata0ycmPM3RW1EMrPvg/w07cHMJ8YoOYNn5lIfohzm8=
X-Received: by 2002:a05:6122:da2:b0:520:98ec:b25c with SMTP id
 71dfb90a1353d-5235b63ff89mr2661022e0c.1.1740766698058; Fri, 28 Feb 2025
 10:18:18 -0800 (PST)
MIME-Version: 1.0
References: <20250227154253.1653236-1-venture@google.com>
 <b300117fa0fc207eadccb663cdb043663ca79025.camel@codeconstruct.com.au>
In-Reply-To: <b300117fa0fc207eadccb663cdb043663ca79025.camel@codeconstruct.com.au>
From: Patrick Venture <venture@google.com>
Date: Fri, 28 Feb 2025 10:18:03 -0800
X-Gm-Features: AQ5f1Jou_OjKXf2GmIoJdtyUqqs1yiR9ECeQUL6tBl0URcVDVT-e7Vq8GYQREN0
Message-ID: <CAO=notw30NKaFtXSookieod-GQb_NeXiSU3MfT1BjYryPmSMew@mail.gmail.com>
Subject: Re: [PATCH] hw/net: ftgmac100: copy eth_hdr for alignment
To: Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: peter.maydell@linaro.org, clg@kaod.org, steven_lee@aspeedtech.com, 
 leetroy@gmail.com, jamin_lin@aspeedtech.com, joel@jms.id.au, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000ad302c062f37d4eb"
Received-SPF: pass client-ip=2607:f8b0:4864:20::a36;
 envelope-from=venture@google.com; helo=mail-vk1-xa36.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

--000000000000ad302c062f37d4eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:54=E2=80=AFPM Andrew Jeffery <andrew@codeconstruc=
t.com.au>
wrote:

> Hi Patrick,
>
> On Thu, 2025-02-27 at 15:42 +0000, Patrick Venture wrote:
> > eth_hdr requires 2 byte alignment
> >
> > Signed-off-by: Patrick Venture <venture@google.com>
> > ---
> >  hw/net/ftgmac100.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> > index 1f524d7a01..a33aaa01ee 100644
> > --- a/hw/net/ftgmac100.c
> > +++ b/hw/net/ftgmac100.c
> > @@ -989,12 +989,16 @@ static void ftgmac100_high_write(void *opaque,
> hwaddr addr,
> >  static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *buf,
> size_t len)
> >  {
> >      unsigned mcast_idx;
> > +    struct eth_header eth_hdr =3D {};
> >
> >      if (s->maccr & FTGMAC100_MACCR_RX_ALL) {
> >          return 1;
> >      }
> >
> > -    switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf))) {
> > +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
> > +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
>
> I don't think truncating the memcpy() in this way is what we want? The
> switched value may not be meaningful for small values of len.
>
> Perhaps return an error?
>
> > +
> > +    switch (get_eth_packet_type(&eth_hdr)) {
> >      case ETH_PKT_BCAST:
> >          if (!(s->maccr & FTGMAC100_MACCR_RX_BROADPKT)) {
> >              return 0;
> > @@ -1028,6 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState
> *nc, const uint8_t *buf,
> >  {
> >      FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_opaque(nc));
> >      FTGMAC100Desc bd;
> > +    struct eth_header eth_hdr =3D {};
> >      uint32_t flags =3D 0;
> >      uint64_t addr;
> >      uint32_t crc;
> > @@ -1036,7 +1041,11 @@ static ssize_t ftgmac100_receive(NetClientState
> *nc, const uint8_t *buf,
> >      uint32_t buf_len;
> >      size_t size =3D len;
> >      uint32_t first =3D FTGMAC100_RXDES0_FRS;
> > -    uint16_t proto =3D be16_to_cpu(PKT_GET_ETH_HDR(buf)->h_proto);
> > +    uint16_t proto;
> > +
> > +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
> > +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
>
> Again here.
>
> > +    proto =3D be16_to_cpu(eth_hdr.h_proto);
> >      int max_frame_size =3D ftgmac100_max_frame_size(s, proto);
> >
> >      if ((s->maccr & (FTGMAC100_MACCR_RXDMA_EN |
> FTGMAC100_MACCR_RXMAC_EN))
> > @@ -1061,7 +1070,7 @@ static ssize_t ftgmac100_receive(NetClientState
> *nc, const uint8_t *buf,
> >          flags |=3D FTGMAC100_RXDES0_FTL;
> >      }
> >
> > -    switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf))) {
> > +    switch (get_eth_packet_type(&eth_hdr)) {
> >      case ETH_PKT_BCAST:
> >          flags |=3D FTGMAC100_RXDES0_BROADCAST;
> >          break;
>
>
Thanks, I've been asked to fix eth_header to be correctly packed instead
and I'm still fixing the implications of that.

--000000000000ad302c062f37d4eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 27,=
 2025 at 9:54=E2=80=AFPM Andrew Jeffery &lt;<a href=3D"mailto:andrew@codeco=
nstruct.com.au">andrew@codeconstruct.com.au</a>&gt; wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">Hi Patrick,<br>
<br>
On Thu, 2025-02-27 at 15:42 +0000, Patrick Venture wrote:<br>
&gt; eth_hdr requires 2 byte alignment<br>
&gt; <br>
&gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@google.co=
m" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt; ---<br>
&gt; =C2=A0hw/net/ftgmac100.c | 15 ++++++++++++---<br>
&gt; =C2=A01 file changed, 12 insertions(+), 3 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c<br>
&gt; index 1f524d7a01..a33aaa01ee 100644<br>
&gt; --- a/hw/net/ftgmac100.c<br>
&gt; +++ b/hw/net/ftgmac100.c<br>
&gt; @@ -989,12 +989,16 @@ static void ftgmac100_high_write(void *opaque, h=
waddr addr,<br>
&gt; =C2=A0static int ftgmac100_filter(FTGMAC100State *s, const uint8_t *bu=
f, size_t len)<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 unsigned mcast_idx;<br>
&gt; +=C2=A0=C2=A0=C2=A0 struct eth_header eth_hdr =3D {};<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 if (s-&gt;maccr &amp; FTGMAC100_MACCR_RX_ALL)=
 {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; =C2=A0<br>
&gt; -=C2=A0=C2=A0=C2=A0 switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf)))=
 {<br>
&gt; +=C2=A0=C2=A0=C2=A0 memcpy(&amp;eth_hdr, PKT_GET_ETH_HDR(buf),<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (sizeof(=
eth_hdr) &gt; len) ? len : sizeof(eth_hdr));<br>
<br>
I don&#39;t think truncating the memcpy() in this way is what we want? The<=
br>
switched value may not be meaningful for small values of len.<br>
<br>
Perhaps return an error?<br>
<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0 switch (get_eth_packet_type(&amp;eth_hdr)) {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 case ETH_PKT_BCAST:<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(s-&gt;maccr &am=
p; FTGMAC100_MACCR_RX_BROADPKT)) {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return 0;<br>
&gt; @@ -1028,6 +1032,7 @@ static ssize_t ftgmac100_receive(NetClientState =
*nc, const uint8_t *buf,<br>
&gt; =C2=A0{<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 FTGMAC100State *s =3D FTGMAC100(qemu_get_nic_=
opaque(nc));<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 FTGMAC100Desc bd;<br>
&gt; +=C2=A0=C2=A0=C2=A0 struct eth_header eth_hdr =3D {};<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags =3D 0;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint64_t addr;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t crc;<br>
&gt; @@ -1036,7 +1041,11 @@ static ssize_t ftgmac100_receive(NetClientState=
 *nc, const uint8_t *buf,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t buf_len;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 size_t size =3D len;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t first =3D FTGMAC100_RXDES0_FRS;<br>
&gt; -=C2=A0=C2=A0=C2=A0 uint16_t proto =3D be16_to_cpu(PKT_GET_ETH_HDR(buf=
)-&gt;h_proto);<br>
&gt; +=C2=A0=C2=A0=C2=A0 uint16_t proto;<br>
&gt; +<br>
&gt; +=C2=A0=C2=A0=C2=A0 memcpy(&amp;eth_hdr, PKT_GET_ETH_HDR(buf),<br>
&gt; +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (sizeof(=
eth_hdr) &gt; len) ? len : sizeof(eth_hdr));<br>
<br>
Again here.<br>
<br>
&gt; +=C2=A0=C2=A0=C2=A0 proto =3D be16_to_cpu(eth_hdr.h_proto);<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 int max_frame_size =3D ftgmac100_max_frame_si=
ze(s, proto);<br>
&gt; =C2=A0<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 if ((s-&gt;maccr &amp; (FTGMAC100_MACCR_RXDMA=
_EN | FTGMAC100_MACCR_RXMAC_EN))<br>
&gt; @@ -1061,7 +1070,7 @@ static ssize_t ftgmac100_receive(NetClientState =
*nc, const uint8_t *buf,<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D FTGMAC100_=
RXDES0_FTL;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 }<br>
&gt; =C2=A0<br>
&gt; -=C2=A0=C2=A0=C2=A0 switch (get_eth_packet_type(PKT_GET_ETH_HDR(buf)))=
 {<br>
&gt; +=C2=A0=C2=A0=C2=A0 switch (get_eth_packet_type(&amp;eth_hdr)) {<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0 case ETH_PKT_BCAST:<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags |=3D FTGMAC100_=
RXDES0_BROADCAST;<br>
&gt; =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;<br>
<br></blockquote><div><br></div><div>Thanks, I&#39;ve been asked to fix eth=
_header to be correctly packed instead and I&#39;m still fixing the implica=
tions of that.</div><div>=C2=A0</div></div></div>

--000000000000ad302c062f37d4eb--

