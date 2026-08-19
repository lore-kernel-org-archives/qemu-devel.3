Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DDEC5DF6D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wweQx-0004NE-Vj; Wed, 19 Aug 2026 07:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wweQw-0004Mw-Qw
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:26:14 -0400
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wweQv-0005em-8c
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 07:26:14 -0400
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-81ed2a06b9eso9853187b3.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 04:26:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787138772; cv=none;
 d=google.com; s=arc-20260327;
 b=gy3fFR13J03VPaQ5dDIDrGxwAgl4Dm2jFw0Ugp4ElX2QYmGP66nr8qQWlGeukZL6pY
 D8o+wxpJPM9NQ2gBzLkNDC+LGg3L/uASg+ABZe+QGBNQVn68I+zINqk45D1OZmA8D74u
 2x5pJ6z2yOPS127AkqiNW9okBNe1FxAzhZn6DFyONRWQarEDqnuJy3samLO/0Jo1mOaL
 n8+g/IRcjQ0uIipYEM/h+vwFP9DJevTxEA5Q3AxvFKHX4wObCuFuizys+m3oo3GkysHr
 LW3Txaz+xN6AWf36u4jxi6+1MExPbW1hZA6Ypl9V3fQzckKJ/0JLVMIzNKgGvW0jVWC+
 iHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ipcJFee5478B9NZNLhi95Xhr/8cc0krERqYO6Ha7Kfw=;
 fh=tuBt10PaCY6S/hjYOjUP9ev8y0AOb40h2JKexeZqE90=;
 b=mnpPrKFj9Tp4dgs3yDQt4K7kFi4G09t2O7tpBS4WTvDei88qHx2huqiJKF56pOLHft
 g03Xw2D1VTDHnKAmOS3Ymh3khcKD+F7183ADbC3L1Cg9kdD07lWmw5QmAsauzPLy5gc5
 3DJmd9NCARIS+XSgxEBsWPUYDfsNbngkhjFAjdH8sfbWCwPVRWCM50WQbXduU3XO1t0k
 7N9gpLBTaU02AVt+9r/5JczJMOjTTVl9ByIz9EPiUjuG8SwORzZE3JO4ttyrUc51GkGR
 GWHFPIthwLwI9M+h9lOI9JFK269luhFWr/kg3dlJYvMQ+emmjPVDzviyoxJXVo3qJLXL
 43rQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787138772; x=1787743572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ipcJFee5478B9NZNLhi95Xhr/8cc0krERqYO6Ha7Kfw=;
 b=aCqHBS/xjuIdcFwwDpL6/d6c5tCBij3lxSMmt0oZbPkWUGz3ayo0ALiZJnnZJHQfEd
 TZPzWyNAFKptA2Oro1QBTYiBT8LZT5zCGer5jJUdg0eoq6hV09ZbJvo5pYQzw3RPVEy9
 GDhV4UBR21MdLNZ587azdyJxCZaHoJbrjQOoxLGMxN0soGsSSSm4G62QQq+USuHD+m6K
 DWJDHe8WEBy9qdHbeb8NTqeSzT1QkkHZgUbFiUX06y1E09i79LXKoraOlnOA84cgfFF+
 YRvFDJ/V/fteRguuXwU9E+xzQ/c+jkJa2U73redHEv+Fby6LnS83aUMqj17Scy2nXjqz
 A0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787138772; x=1787743572;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ipcJFee5478B9NZNLhi95Xhr/8cc0krERqYO6Ha7Kfw=;
 b=FGZ40m2aQa+C0WQDHjqiLQd2vFh6TzBWOIEYvdVx9g1asSs3gzH0CCSHNx+DhhxwC6
 5a2AFcfMKt0KA88fg+HOWMW1TAl4RfN8bh86TJi4DdCX0lbfnxS7taFZaGoC94sd3pyS
 iG4QjgbSrtnQt4xfda+0nirh2nxZ5aEwi9P0Ef/XC1UiwWAO1+of+5b7cjGh01rDkHs3
 7BtDz1B3jubbGeqfV3IGkxL22YNJibP3AqNSL1lrbVFCrGka4FnfKT30v1Vwz5qVpH7L
 SERWOi83vAfLQ4k4qO1jNMsxPfSUNak2qKjYfg9vrc22Pi07P7EVs13sGHSEPNV5IEHl
 XLXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoKmwezcOXprv6f8tRBHufBzziVqUm5d9lgpcAN/22e6BqHW3jYBuyPsu8TOGguE3GAkz0CQ4ESCM79@nongnu.org
X-Gm-Message-State: AFuF++nbVxUIEtzZzZIadnU+jn2F+9UJuLVuXBnjR8FNYn5fLAitsyAh
 wb9GoBrR1f194AhNqpjfd+X91TFSgnUIkXOAAn0JgbLZDBqXJz7PrygCPqrB8hnMO9AUgI919aI
 L3aukkyPlIyrYBjdrZpAaIVens2RB/ME=
X-Gm-Gg: AR+sD10mOeaKSRjrc5NsllpcVj+LblpXjETV/HknxZ6Q5n2jyrUs+dFizQcUMnSWJ74
 uuyjTYYcbPzkWHn8ES+KqfdlgEQpV4qyZY9SsUr3EwAqCWuXyxfn7TKV5sXbx/kunIs7ovHhHWW
 HbfcJEnTTHjNxhCT0sHiCVo+/hl0O0HnLLGms0HrH8iRNQtdBmFCkZxRdXo5/7n+dPSqEhqtp2q
 LBhW5ASl2wKCknt+btNurFD4yHt4Ugm9b3aXiVPKrmv21eg16eca+Ic2E2oS+MldvQEp4qqyhJm
 7zUnP4W1ULHu0JDPdolR22Ymvll97PYf/FPLPr335sIZh5kzM0zUoW5gGcRJqqcZAyiUt3Nuf6x
 e
X-Received: by 2002:a05:690c:9a82:b0:825:c3fc:e63f with SMTP id
 00721157ae682-844e32b732cmr18044497b3.8.1787138771852; Wed, 19 Aug 2026
 04:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250926140144.1998694-1-berrange@redhat.com>
 <20250926140144.1998694-33-berrange@redhat.com>
 <178708450916.1320462.1427984683087351414.b4-review@b4>
 <d807df94-16d5-28a8-756e-b7971068e2c7@eik.bme.hu>
In-Reply-To: <d807df94-16d5-28a8-756e-b7971068e2c7@eik.bme.hu>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 19 Aug 2026 15:25:58 +0400
X-Gm-Features: AcwNN1VuB95kr--sW0yF0NL65rFUrlJmoDbVY1bz2dqTbSEv335k6TOrtVJLKuA
Message-ID: <CAJ+F1CL3r13bj9kKS8uyeo6S4o3rY-6pB_=2pjcgCQ7r9tHwYA@mail.gmail.com>
Subject: Re: [PATCH v2 32/32] hw/display: mark most display adapters as
 insecure
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zoltan

On Wed, Aug 19, 2026 at 3:18=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Wed, 19 Aug 2026, marcandre.lureau@redhat.com wrote:
> >> Most of thte display adapters are emulating old hardware which is not
> >> relevant to virtualization use cases.
> >>
> >> The exceptions that should be considered secure are Cirrus (PCI, not
> >> ISA), Bochs, QXL, RAMFB, VGA (PCI, MMIO, not ISA) and VMWare VGA.
> >>
> >> The Cirrus PCI decision is borderline. It has been heavily used with
> >> virtualization in the past, but these days VGA / RAMFB are strongly
> >> recommended instead. Due to its historical usage though, we can
> >> consider the code fairly mature, even if no longer hugely relevant
> >> to virtualization use cases.
> >>
> >> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> >> Message-ID: <20250926140144.1998694-33-berrange@redhat.com>
> >>
> >> diff --git a/hw/display/artist.c b/hw/display/artist.c
> >> index 3c884c92437c..caab4d1d4c52 100644
> >> --- a/hw/display/artist.c
> >> +++ b/hw/display/artist.c
> >> @@ -1504,6 +1504,7 @@ static const TypeInfo artist_info =3D {
> >>      .instance_size =3D sizeof(ARTISTState),
> >>      .instance_init =3D artist_initfn,
> >>      .class_init    =3D artist_class_init,
> >> +    .secure        =3D false,
> >>  };
> >>
> >>  static void artist_register_types(void)
> >> diff --git a/hw/display/ati.c b/hw/display/ati.c
> >> index f7c0006a879d..6e332e02d2fb 100644
> >> --- a/hw/display/ati.c
> >> +++ b/hw/display/ati.c
> >> @@ -1080,6 +1080,7 @@ static const TypeInfo ati_vga_info =3D {
> >>      .instance_size =3D sizeof(ATIVGAState),
> >>      .class_init =3D ati_vga_class_init,
> >>      .instance_init =3D ati_vga_init,
> >> +    .secure =3D false,
>
> I've missed the original series but why isn't the default false and
> devices that are secured set it to true? That way a new device would not
> be set secure unless the author explicitly sets it which seems better tha=
n
> assuming devices are secure when most of them aren't. Or if false is
> already the default why is it set everywhere? Isn't it enough to mark
> secure devices?

Isn't it already the case, since fields are 0-initialized? I think
Daniel just tried to go through it and make it explicit what is secure
or not.

