Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF22DC197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 18:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnis5-0008Le-DB; Thu, 27 Feb 2025 13:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnis0-0008K8-OF
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:44:30 -0500
Received: from mail-yb1-xb2f.google.com ([2607:f8b0:4864:20::b2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnirx-0003yz-Gg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 13:44:28 -0500
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e589c258663so1525018276.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 10:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740681860; x=1741286660; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tZVkcKKAl6NTFE7ZS5YKtyl4sdgiqPbOaIwKxrt6xrM=;
 b=SPGvImEG08zddycxCK9AgL2rU+4CDrOLtVcpS39N3fpKnsf9KCZZM9dc1jQUSbZpMm
 waRu7mDr6LZIfiEN9LW12zrxqKtBbbAmsEdUBQoaDqbguklcW8VoOwhIgOjXcN8CoQC+
 cmZv8Xt0rdPuEKzTdK2+8CxG56T4vULrtPC1iRFLNmiUOdHZDCb3Sai/vur48Ek/2Mp4
 km4IbAxBAKBr6iwmfbPVt10wNuwdrHpHs7ZD1sbuUkpZCvuanQ+v762cQxdkRo9LSacl
 bQRJMAyDUE8IgdDYDOVhYLOpYF2lvBchP2ZNNILcMCfyM1m+qo7XKU/1W43apZkH8Pk2
 3mmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740681860; x=1741286660;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tZVkcKKAl6NTFE7ZS5YKtyl4sdgiqPbOaIwKxrt6xrM=;
 b=E9AzFf65KAX3ZTnNUC3KR/SSSGNGnq5NcJF1CX29h2/Xl5aPILJ29MDvY/PYSiKRr7
 AN1u1fvtNAiZoq8L8blyHPQfEQc5WJ2K5bDvd4I7jqV+Qop38nBj19wCVBdSe5bk32SX
 Zw99cGPsjY/0ms1Fl/1l726Sg+DUPsDjulBO58vMjkER9XTUs74/ierlJGNP/FR+X1CJ
 6W37GDE4NIU82NHqEdY7xCGCbkNDBy3UPT0iiAjaCOdHc3HQ6RpEfoU5TDOnHQQJTJtP
 yWIsqA0ylZwtFXTgKBrM8lNxCgmBHG0ChWUU7VRncTkMzCW2VDoxQuu3SHZ9bdkqszgG
 Ssxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT6/f6csKomSWHIs+dx48HgOZ17pfOmM0E6lXEVvyK2tedB+OtLqDzwHrF5W8V7TemXWEqXYmPg25+@nongnu.org
X-Gm-Message-State: AOJu0YyT7pdNB+dqZ7J7eh8SumotqlvDHLRgswhkqBzAFLu2le5UrKVV
 1D078l05sDduzV6JDnZRxZ40v9nzaJeQWucrlloyKzplbYDUpb7rIJQXGIfaFTsxmxVP5yQ5Dpv
 z4EQsbJ+vKo6koMDNS60gNCy6TCKV8Y7Q/M2HrA==
X-Gm-Gg: ASbGncteS1bwnimNZGCaHXDohy0aPZ+URmYuUGWVfb0B3ErONTriKd4xIPCbvn8E1aE
 PScE+2I4pAb2wPWc6MiWRwUGf0mfYzce3vGHYu25kXNIHfCjy0+T8I4cvG47uuCdaWqM3+94nS1
 007IASY3rl
X-Google-Smtp-Source: AGHT+IE4GmQeUmwyP6L/1syC04gpP8lK8gCQHEi02wS/Xas+hwP4++AcKfi0Wb2y4UfgGVfjgGtMzYe2uAV6GyzO9SY=
X-Received: by 2002:a05:6902:e93:b0:e4d:25c6:c398 with SMTP id
 3f1490d57ef6-e60b2e93d0bmr247660276.1.1740681860605; Thu, 27 Feb 2025
 10:44:20 -0800 (PST)
MIME-Version: 1.0
References: <20250227154003.1646017-1-venture@google.com>
 <CAFEAcA_wR-M3+BhZY0MFjv3OfoyL2gvukduvKZ6ksKwUKmdB6Q@mail.gmail.com>
 <CAO=noty89OsH=vGmemL7eLcR2wV6n4XG9a2HfT7Uzo8EPRy4PQ@mail.gmail.com>
 <CAFEAcA-gyMTz-KpmamyXcKX9QOL=yYHDMPRF2Xji_uJbG02WpA@mail.gmail.com>
 <CAO=notwcXTU9v4c_Hz=Si=QLrM5HNymYEO0ry4Td30GYUZqBwg@mail.gmail.com>
 <CAO=notxXT3m26=GxryTwJSqLQBfxrCCXV9ffdBGdYokxxnHz=A@mail.gmail.com>
In-Reply-To: <CAO=notxXT3m26=GxryTwJSqLQBfxrCCXV9ffdBGdYokxxnHz=A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2025 18:44:08 +0000
X-Gm-Features: AQ5f1Johh4YRhSxYpvK-BelDemFxW9ipNuBd9w1Klk1RK_F5waPcuAh4XSVRrNw
Message-ID: <CAFEAcA8x6Lj2uUVtESC9TAMrS-wkRAF3HT3Wj3JN5i6oQmm4mQ@mail.gmail.com>
Subject: Re: [PATCH] hw/net: npcm7xx_emc: fix alignment to eth_hdr
To: Patrick Venture <venture@google.com>
Cc: kfting@nuvoton.com, wuhaotsh@google.com, jasowang@redhat.com, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2f.google.com
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

On Thu, 27 Feb 2025 at 18:12, Patrick Venture <venture@google.com> wrote:
>
>
>
> On Thu, Feb 27, 2025 at 8:08=E2=80=AFAM Patrick Venture <venture@google.c=
om> wrote:
>>
>>
>>
>> On Thu, Feb 27, 2025 at 8:01=E2=80=AFAM Peter Maydell <peter.maydell@lin=
aro.org> wrote:
>>>
>>> On Thu, 27 Feb 2025 at 15:55, Patrick Venture <venture@google.com> wrot=
e:
>>> >
>>> >
>>> >
>>> > On Thu, Feb 27, 2025 at 7:52=E2=80=AFAM Peter Maydell <peter.maydell@=
linaro.org> wrote:
>>> >>
>>> >> On Thu, 27 Feb 2025 at 15:40, Patrick Venture <venture@google.com> w=
rote:
>>> >> >
>>> >> > 'const struct eth_header', which requires 2 byte alignment
>>> >> >
>>> >> > Signed-off-by: Patrick Venture <venture@google.com>
>>> >> > ---
>>> >> >  hw/net/npcm7xx_emc.c | 7 ++++++-
>>> >> >  1 file changed, 6 insertions(+), 1 deletion(-)
>>> >> >
>>> >> > diff --git a/hw/net/npcm7xx_emc.c b/hw/net/npcm7xx_emc.c
>>> >> > index e06f652629..11ed4a9e6a 100644
>>> >> > --- a/hw/net/npcm7xx_emc.c
>>> >> > +++ b/hw/net/npcm7xx_emc.c
>>> >> > @@ -424,7 +424,12 @@ static bool emc_can_receive(NetClientState *n=
c)
>>> >> >  static bool emc_receive_filter1(NPCM7xxEMCState *emc, const uint8=
_t *buf,
>>> >> >                                  size_t len, const char **fail_rea=
son)
>>> >> >  {
>>> >> > -    eth_pkt_types_e pkt_type =3D get_eth_packet_type(PKT_GET_ETH_=
HDR(buf));
>>> >> > +    struct eth_header eth_hdr =3D {};
>>> >> > +    eth_pkt_types_e pkt_type;
>>> >> > +
>>> >> > +    memcpy(&eth_hdr, PKT_GET_ETH_HDR(buf),
>>> >> > +           (sizeof(eth_hdr) > len) ? len : sizeof(eth_hdr));
>>> >> > +    pkt_type =3D get_eth_packet_type(&eth_hdr);
>>> >>
>>> >> Maybe better to mark struct eth_header as QEMU_PACKED?
>>> >> Compare commit f8b94b4c5201 ("net: mark struct ip_header as
>>> >> QEMU_PACKED"). The handling of these header structs in eth.h
>>> >> is in general pretty suspect IMHO. We do the same
>>> >> "get_eth_packet_type(PKT_GET_ETH_HDR(buf))" in other devices,
>>> >> so this isn't just this device's bug.
>>>
>>> > Roger that. We saw this in the two NICs we happened to be testing tha=
t day, and yeah, I grepped and just figured that those other NICs were doin=
g something with their buffer allocations that we didn't. I'll give QEMU_PA=
CKED  whirl.
>>>
>>> You might find you need to make some fixes to other
>>> devices to get the QEMU_PACKED change to compile (do an
>>> all-targets build to test that). For instance for the
>>> ip_header change I had to first fix virtio-net.c in commit
>>> 5814c0846793715. The kind of thing that will need fixing is
>>> if there are places where code takes the address of the
>>> h_proto field and puts it into a uint16_t* : the compiler
>>> will complain about that. A quick grep suggests that the
>>> rocker_of_dpa.c code might be doing something like this, but
>>> hopefully that's it.
>
>
> Ok, so digging, and I see that vlanhdr is used similarly in the rocker_of=
_dpa.c code, so, without trying to bit off the yak shave of fixing all ethe=
rnet headers, but in reality ethernet packets are packed structures, should=
 we just make them all packed and bite that bullet?

If you want to do all of them that's probably the long term
right thing. But the patchset structure would be a series
of "fix X that assumes struct A is not packed", "fix Y
that assumes struct A is not packed", "mark struct A packed",
"fix Z that assumes struct B is not packed", "mark struct B
packed", etc -- so I don't mind if you stop partway through
without doing all of them. (After all, that's exactly what
I did with only doing ip_header :-))

thanks
-- PMM

