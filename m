Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C19C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 16:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tngKt-00082b-ER; Thu, 27 Feb 2025 11:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tngKa-0007kd-KK
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:01:55 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tngKT-0007Pk-Vo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 11:01:47 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so864867276.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 08:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740672099; x=1741276899; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6KeP6LOaPnp3jRIIoz0WXOkqKl2xTX9I/6K/ONhVA9Y=;
 b=CTy70L7XX0htERVoai4K+KXne2UiosY9q75gVoa+/1gAmQ6nZkjCqljSclUrW8gf6t
 CIj4VKKQD80chm4CijzfKrRXoYUl9pyHzqKin7BBZCJkELeMlpmJBzYDCz4SV9PiPNWU
 h8UBmxmw+6wxQLUnTZYGBL3DPIgQqoUECUooeFbOCJyH67lDauAt9t9G5/Pvx1p9ibRZ
 RyCWiCWPzpVM4xLWLI4YzZQKERc1+mQGBQJm7CGnT0ff3/BvEgju4GGd8ZH1IxeCgW5t
 TvlUV2HS826Rox9XpXcSMHOoGgjo//VgcotjTlrSChy7Gyh1FOff5O0sXJlVQdJyqmdk
 8aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740672099; x=1741276899;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6KeP6LOaPnp3jRIIoz0WXOkqKl2xTX9I/6K/ONhVA9Y=;
 b=Kr0nffcK4nXT8zZU1vYQOAokpey/r1mYUHEYbY52Ff6kYKDpz8EnC6TGjHdvUiBS5p
 KVijfM7glv5NpVUQUw7yUIl4v1Cw+MHRjGRPgpBk6QubO6JmP3YWXEnzHfNJjppsE4fu
 6y1CDmEO24FiisBELWoMrxzMR5ZtOigeRWeS7bjvEoOV+6TL5eN/daV0GoZRzCBXofnA
 sArYDyx27UqqLHa99oN4xEhZEsuUZJCOXm+B0kIIYZzLjM+U7eUkiGXGbI4MfeupLJ38
 fpjq/FKyZ7z7lnRvGGlkVVr7AAej/kOsMqtq2UvSj/p/PPrk0JK1WbX35GghC+s4DPal
 6mfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFkMzGxyFfNAI6i4cuHk3XmXdIgdffK8W+rJhfgngJX6qQ6if0C3Vev2ZjoUqVDGg7wtOCXsHB7OK7@nongnu.org
X-Gm-Message-State: AOJu0Yy1UdvWD8zMvGI8XTR/HppJdojh/aHgNwP7Xu+dzLP1KixRF3ne
 FiI4Ej+KoDjHqehT3A4Uvnlub0si4B65JGnS6F3e8GXKC74B94hqAwzpmormrztyXLeUvsE4fKZ
 8s/0zZtIb61jb5P9pxiQ9MzzP/fDMl5ajnEcIog==
X-Gm-Gg: ASbGncvX7foWnDE2PTtippK0Z1ZyQ6RjqOTmtJP9rAgdi7Fe9QrWEjz+NOmEqX/dOeG
 jCyCUdVP5uHpwuIesaxwNGkDSEylLh/VxbLdifmuEYiV4ZIE7ISMXGA4EVkeBBZ+C9WAiU6jbvO
 47tR10LJ6z
X-Google-Smtp-Source: AGHT+IGAF/uuF05FH3O/KQ396OjJ3YfGtDLGcGrtpPG0iILHXgnhL5t/jmkc3FYHuM0PSlhlVG4BwBZ9ftEd2fvBfgU=
X-Received: by 2002:a05:6902:12c5:b0:e5a:e774:d238 with SMTP id
 3f1490d57ef6-e608a6a17d9mr7395085276.2.1740672097916; Thu, 27 Feb 2025
 08:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20250227154003.1646017-1-venture@google.com>
 <CAFEAcA_wR-M3+BhZY0MFjv3OfoyL2gvukduvKZ6ksKwUKmdB6Q@mail.gmail.com>
 <CAO=noty89OsH=vGmemL7eLcR2wV6n4XG9a2HfT7Uzo8EPRy4PQ@mail.gmail.com>
In-Reply-To: <CAO=noty89OsH=vGmemL7eLcR2wV6n4XG9a2HfT7Uzo8EPRy4PQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 16:01:25 +0000
X-Gm-Features: AQ5f1JpdX-BJ2ftWF8KTni0lYlT_dpMnvPWSa2ybbaJ5v_e_lnPcTguNtDdg9o8
Message-ID: <CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com>
Subject: Re: [PATCH] hw/net: npcm7xx_emc: fix alignment to eth_hdr
To: Patrick Venture <venture@google.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Thu, 27 Feb 2025 at 15:55, Patrick Venture <venture@google.com> wrote:
>
>
>
> On Thu, Feb 27, 2025 at 7:52=E2=80=AFAM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
>>
>> On Thu, 27 Feb 2025 at 15:40, Patrick Venture <venture@google.com> wrote=
:
>> >
>> > 'const struct eth_header', which requires 2 byte alignment
>> >
>> > Signed-off-by: Patrick Venture <venture@google.com>
>> > ---
>> >  hw/net/npcm7xx_emc.c | 7 ++++++-
>> >  1 file changed, 6 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
>> > index e06f652629..11ed4a9e6a 100644
>> > --- a/hw/net/npcm7xx_emc.c
>> > +++ b/hw/net/npcm7xx_emc.c
>> > @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientState *nc)
>> >  static bool emc_receive_filter1(NPCM7xxEMCState *emc, const uint8_t *=
buf,
>> >                                  size_t len, const char **fail_reason)
>> >  {
>> > -    eth_pkt_types_e pkt_type =3D get_eth_packet_type(PKT_GET_ETH_HDR(=
buf));
>> > +    struct eth_header eth_hdr =3D {};
>> > +    eth_pkt_types_e pkt_type;
>> > +
>> > +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
>> > +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
>> > +    pkt_type =3D get_eth_packet_type(&eth_hdr);
>>
>> Maybe better to mark struct eth_header as QEMU_PACKED?
>> Compare commit f8b94b4c5201 ("net: mark struct ip_header as
>> QEMU_PACKED"). The handling of these header structs in eth.h
>> is in general pretty suspect IMHO. We do the same
>> "get_eth_packet_type(PKT_GET_ETH_HDR(buf))" in other devices,
>> so this isn't just this device's bug.

> Roger that. We saw this in the two NICs we happened to be testing that da=
y, and yeah, I grepped and just figured that those other NICs were doing so=
mething with their buffer allocations that we didn't. I'll give QEMU_PACKED=
  whirl.

You might find you need to make some fixes to other
devices to get the QEMU_PACKED change to compile (do an
all-targets build to test that). For instance for the
ip_header change I had to first fix virtio-net.c in commit
5814c0846793715. The kind of thing that will need fixing is
if there are places where code takes the address of the
h_proto field and puts it into a uint16_t* : the compiler
will complain about that. A quick grep suggests that the
rocker_of_dpa.c code might be doing something like this, but
hopefully that's it.

thanks
-- PMM

