Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6543BC19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:10:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngRr-0000yx-5r; Thu, 27 Feb 2025 11:09:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1tngQx-0008U3-Lj
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:08:23 -0500
Received: from mail-qk1-x72b.google.com ([2607:f8b0:4864:20::72b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1tngQs-0000Db-W2
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:08:22 -0500
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-7c08b14baa9so97944885a.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740672493; x=1741277293; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LucYlR7wGBOJBB79VNJsJIy+ebAKyb8vWkC9gTxKADU=;
 b=tQEG/9WdqJN5JGmqEvs0/V3I8Do6TffAUkSPKpem6PnvEf9mU8/8iQIDdTaJp+FkEg
 LlZ0OqSNzA7ZKsnSRPU8EPA29tzmiulwutswNC/ASwQCNyjsVbmHGKEEnucwLDspUWBp
 A3GgWSgpKeOdrMsmmGp5GgjtYUrS9Z7vkX71b9G8G2G71/g0eM9nuK5qYabxxZNZgWGQ
 Wf+XGXuR5uUKrzwRFTAjZiiLW3E34saYXY8U3l989bqCS0zMKXomUtRUr5o4FY8xgYlD
 fY4r/IHGzO+9XOv6UWWdOJOGyReQsn8WuVymVMmrQ9FZy9BWB8E8uWdQ6GxrY80fxqpi
 /8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672493; x=1741277293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LucYlR7wGBOJBB79VNJsJIy+ebAKyb8vWkC9gTxKADU=;
 b=uea2lUmOJXAzDZIzhWn0/pmg3cnQrvTfUazUtubsXsE+a3V37piuScTE/98bFotEF0
 tVChXQiUeXyTXts8OOfTBrCUZhrft0Ok9Yx//fUggL1B5Qdt2SQiR0feGQ9N9F6yPjE3
 O1PeP4PGzZuRmQ5VhHAV7La6xGquylnJuT8dUzgIyJWZlz1Av8PbMAWx7Qo9mS8UWKPm
 03qotLfhDyLRwm11sc4Y2jxvHJzB5c0qOLXGs8a8qQF/N2Uvwz0ZIIIfqETQA0+aFJpT
 hh9p+UIoi6dcPRQ7Sf5PDO+Ym/rbrQX5yOlfHqsltwuCoExslXNl5WRXKVgmipgcTZnz
 Qdwg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHCLtCtdnQrLqbTjaZBG/fPKr3zO+Vy8Sl3lRwv4gPjob4Kphkhw+YtPIea3OBBbqpBRtIeYzv2zQS@nongnu.org
X-Gm-Message-State: AOJu0YwIxpPmDArCfb0d+UNAghU81p9dpYRkB7tjNpl2Foj5ptC/VTZi
 x0A6wXxX3YLjh6+UF82LNxn46a2i44aLKvAvuiADVcUQpjiVgjfw7eJ7Xm0TF/IpHbG5n47XQqB
 ji+vDVFCOEgg3rtY7YCxfmPF3/A9Yp7RUe5/H
X-Gm-Gg: ASbGncvAfG/6N/D4je0LUTTCwkMbi1ibUpnBiE6e4AuRKehkjtJ0jsEfR7bGINn3AmI
 epAb4WNUKBCFh6n/6fuXOTtnr5DSpouLc3kbCd7kS1m5sOi9Fuy67z5SzaA/sQPXfEvEDTfYGCm
 SIXdr1+Ib0ZacbJvfhJWH+4d+E9Vu1oWXL37mqdQ==
X-Google-Smtp-Source: AGHT+IE8wR4B5OLygyB7K4WdFT7kQMxbPhofu4o3njERpe5XX3551jgGTnWqCHvJ9jIp2OzxV/hWsCDytc03r7dKhk0=
X-Received: by 2002:a05:620a:450a:b0:7c0:9df3:a0d7 with SMTP id
 af79cd13be357-7c23c039803mr1779508485a.41.1740672493256; Thu, 27 Feb 2025
 08:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20250227154003.1646017-1-venture@google.com>
 <CAFEAcA_wR-M3+BhZY0MFjv3OfoyL2gvukduvKZ6ksKwUKmdB6Q@mail.gmail.com>
 <CAO=noty89OsH=vGmemL7eLcR2wV6n4XG9a2HfT7Uzo8EPRy4PQ@mail.gmail.com>
 <CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com>
In-Reply-To: <CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com>
From: Patrick Venture <venture@google.com>
Date: Thu, 27 Feb 2025 08:08:01 -0800
X-Gm-Features: AQ5f1JrEwx0ajtKdC1OwMVLACziYm9s_oiSxA8Tkx4sf6DvrX9OLlG1rT-OXiU4
Message-ID: <CAO=notwcXTU9v4c_Hz=Si=QLrM5HNymYEO0ry4Td30GYUZqBwg@mail.gmail.com>
Subject: Re: [PATCH] hw/net: npcm7xx_emc: fix alignment to eth_hdr
To: Peter Maydell <peter.maydell@linaro.org>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000a26448062f21e571"
Received-SPF: pass client-ip=2607:f8b0:4864:20::72b;
 envelope-from=venture@google.com; helo=mail-qk1-x72b.google.com
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

--000000000000a26448062f21e571
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 8:01=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org>
wrote:

> On Thu, 27 Feb 2025 at 15:55, Patrick Venture <venture@google.com> wrote:
> >
> >
> >
> > On Thu, Feb 27, 2025 at 7:52=E2=80=AFAM Peter Maydell <peter.maydell@li=
naro.org>
> wrote:
> >>
> >> On Thu, 27 Feb 2025 at 15:40, Patrick Venture <venture@google.com>
> wrote:
> >> >
> >> > 'const struct eth_header', which requires 2 byte alignment
> >> >
> >> > Signed-off-by: Patrick Venture <venture@google.com>
> >> > ---
> >> >  hw/net/npcm7xx_emc.c | 7 ++++++-
> >> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
> >> > index e06f652629..11ed4a9e6a 100644
> >> > --- a/hw/net/npcm7xx_emc.c
> >> > +++ b/hw/net/npcm7xx_emc.c
> >> > @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientState *nc)
> >> >  static bool emc_receive_filter1(NPCM7xxEMCState *emc, const uint8_t
> *buf,
> >> >                                  size_t len, const char **fail_reaso=
n)
> >> >  {
> >> > -    eth_pkt_types_e pkt_type =3D
> get_eth_packet_type(PKT_GET_ETH_HDR(buf));
> >> > +    struct eth_header eth_hdr =3D {};
> >> > +    eth_pkt_types_e pkt_type;
> >> > +
> >> > +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
> >> > +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
> >> > +    pkt_type =3D get_eth_packet_type(&eth_hdr);
> >>
> >> Maybe better to mark struct eth_header as QEMU_PACKED?
> >> Compare commit f8b94b4c5201 ("net: mark struct ip_header as
> >> QEMU_PACKED"). The handling of these header structs in eth.h
> >> is in general pretty suspect IMHO. We do the same
> >> "get_eth_packet_type(PKT_GET_ETH_HDR(buf))" in other devices,
> >> so this isn't just this device's bug.
>
> > Roger that. We saw this in the two NICs we happened to be testing that
> day, and yeah, I grepped and just figured that those other NICs were doin=
g
> something with their buffer allocations that we didn't. I'll give
> QEMU_PACKED  whirl.
>
> You might find you need to make some fixes to other
> devices to get the QEMU_PACKED change to compile (do an
> all-targets build to test that). For instance for the
> ip_header change I had to first fix virtio-net.c in commit
> 5814c0846793715. The kind of thing that will need fixing is
> if there are places where code takes the address of the
> h_proto field and puts it into a uint16_t* : the compiler
> will complain about that. A quick grep suggests that the
> rocker_of_dpa.c code might be doing something like this, but
> hopefully that's it.
>

Thanks for the head's up.

>
> thanks
> -- PMM
>

--000000000000a26448062f21e571
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 27,=
 2025 at 8:01=E2=80=AFAM Peter Maydell &lt;<a href=3D"mailto:peter.maydell@=
linaro.org">peter.maydell@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Thu, 27 Feb 2025 at 15:55, Patrick V=
enture &lt;<a href=3D"mailto:venture@google.com" target=3D"_blank">venture@=
google.com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; On Thu, Feb 27, 2025 at 7:52=E2=80=AFAM Peter Maydell &lt;<a href=3D"m=
ailto:peter.maydell@linaro.org" target=3D"_blank">peter.maydell@linaro.org<=
/a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Thu, 27 Feb 2025 at 15:40, Patrick Venture &lt;<a href=3D"mailt=
o:venture@google.com" target=3D"_blank">venture@google.com</a>&gt; wrote:<b=
r>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &#39;const struct eth_header&#39;, which requires 2 byte alig=
nment<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Signed-off-by: Patrick Venture &lt;<a href=3D"mailto:venture@=
google.com" target=3D"_blank">venture@google.com</a>&gt;<br>
&gt;&gt; &gt; ---<br>
&gt;&gt; &gt;=C2=A0 hw/net/npcm7xx_emc.c | 7 ++++++-<br>
&gt;&gt; &gt;=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c<br>
&gt;&gt; &gt; index e06f652629..11ed4a9e6a 100644<br>
&gt;&gt; &gt; --- a/hw/net/npcm7xx_emc.c<br>
&gt;&gt; &gt; +++ b/hw/net/npcm7xx_emc.c<br>
&gt;&gt; &gt; @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientSta=
te *nc)<br>
&gt;&gt; &gt;=C2=A0 static bool emc_receive_filter1(NPCM7xxEMCState *emc, c=
onst uint8_t *buf,<br>
&gt;&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 size_t len, const =
char **fail_reason)<br>
&gt;&gt; &gt;=C2=A0 {<br>
&gt;&gt; &gt; -=C2=A0 =C2=A0 eth_pkt_types_e pkt_type =3D get_eth_packet_ty=
pe(PKT_GET_ETH_HDR(buf));<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 struct eth_header eth_hdr =3D {};<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 eth_pkt_types_e pkt_type;<br>
&gt;&gt; &gt; +<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 memcpy(&amp;eth_hdr, PKT_GET_ETH_HDR(buf),<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(sizeof(eth_hdr) &g=
t; len) ? len : sizeof(eth_hdr));<br>
&gt;&gt; &gt; +=C2=A0 =C2=A0 pkt_type =3D get_eth_packet_type(&amp;eth_hdr)=
;<br>
&gt;&gt;<br>
&gt;&gt; Maybe better to mark struct eth_header as QEMU_PACKED?<br>
&gt;&gt; Compare commit f8b94b4c5201 (&quot;net: mark struct ip_header as<b=
r>
&gt;&gt; QEMU_PACKED&quot;). The handling of these header structs in eth.h<=
br>
&gt;&gt; is in general pretty suspect IMHO. We do the same<br>
&gt;&gt; &quot;get_eth_packet_type(PKT_GET_ETH_HDR(buf))&quot; in other dev=
ices,<br>
&gt;&gt; so this isn&#39;t just this device&#39;s bug.<br>
<br>
&gt; Roger that. We saw this in the two NICs we happened to be testing that=
 day, and yeah, I grepped and just figured that those other NICs were doing=
 something with their buffer allocations that we didn&#39;t. I&#39;ll give =
QEMU_PACKED=C2=A0 whirl.<br>
<br>
You might find you need to make some fixes to other<br>
devices to get the QEMU_PACKED change to compile (do an<br>
all-targets build to test that). For instance for the<br>
ip_header change I had to first fix virtio-net.c in commit<br>
5814c0846793715. The kind of thing that will need fixing is<br>
if there are places where code takes the address of the<br>
h_proto field and puts it into a uint16_t* : the compiler<br>
will complain about that. A quick grep suggests that the<br>
rocker_of_dpa.c code might be doing something like this, but<br>
hopefully that&#39;s it.<br></blockquote><div><br></div><div>Thanks for the=
 head&#39;s up.=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div>

--000000000000a26448062f21e571--

