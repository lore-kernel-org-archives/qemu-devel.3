Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CB9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 08:42:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0yaT-0000i5-Ph; Tue, 23 Sep 2025 04:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0yaP-0000hN-QS
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:41:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1v0ya9-0004S7-TV
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 04:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758616857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rOhsEX4wW1lawpmKISR50he0FpP3KCm7BHPobz6okE=;
 b=Pfz55tYzn5lnfavJawthOjXlgEP9ts7VuQDiTT6AorU3Bc5ExVjg7C91M6FgK/uZu4b7uo
 E0W5AVwecxawxdxtWUouAtS2rnq1LgLj7g5Mg1WG33MN/T96CnGkYtuFGosZnI/5Q6UBUn
 woGbBWZFGnDpoRwjb538SQ+P0ADhHjI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-1Hd0azRNNdeFiooqt5TI4g-1; Tue, 23 Sep 2025 04:40:55 -0400
X-MC-Unique: 1Hd0azRNNdeFiooqt5TI4g-1
X-Mimecast-MFC-AGG-ID: 1Hd0azRNNdeFiooqt5TI4g_1758616855
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so980940f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 01:40:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758616855; x=1759221655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rOhsEX4wW1lawpmKISR50he0FpP3KCm7BHPobz6okE=;
 b=AYSP5z5Ml/+vn2czbH4awFJqRioqNhn4FZz0VuXMzt5U8UjBWElSu/l2S4OSg6mrrL
 5dAQV6ec91gw32VHQpeSw6He9mKGqMUOip27ppBknrkMXT2iu5qvA3aRcLtPnw/ZWnfF
 OAioLyWTt26kbXhI7Ye+C7ZbKQYDAyvlxzPLFpUOBuO+iGM7hfBReDQomeqaagiF70pG
 iUYewY3cOzvBWRLkUqoh+yHKaeC0yGfNb1DNk1B2giwkgH0zcqQpwi0wOcpdF00g/Vlb
 EhFoot4jXsNRil3d5cUNiXI2lu9J+1V3L5N8W3TaMBs3WjUmjhB8fupvoruuAlTrOj2I
 H7GA==
X-Gm-Message-State: AOJu0YzNQqSnfTDLfh6PZpUWtev4V/YbDQZizM0r6Pxtr3chggGJGZ+3
 z12y4haX+0H9A4IKsi99yacAB4U1ABgi/wFpCb4CboqG5Fefbpe/sIFlzHbC2Qi380dK/0o+13Z
 VyifejM5F4WvBBhmdoe3gAh3ZTOgATcklGzxB9fj4+TmxOhRrG+bH13DT
X-Gm-Gg: ASbGncsC5GXMGeysuNiECb6VLIihFsUmXzYtoYfFQhkqiRH/DKQI1toGDyTKSyA2tgz
 i/hyrhJ327f4/gWZdDmpER4d0eLaAgak6nIzzUuYIRskvGbxYHDx4gnXaHTTfo0mYLzZP6bm4MB
 +KJRKSzIlpunsQv+9v/z+6COl6r28Zh1RIWWY1d2o1Thue1wxGOX83TKdDEU44JsoA/UUfcmau2
 gxqyl0Lm7mbvFnrad4sjJw7FopdWtXTc1XDI5t9dydrzpxkql5J2pcmv+6MeKvWwOPmhmdVf8Nw
 Y6DApCd+cl2/BXHnhYaKFxPSHOVq9FI=
X-Received: by 2002:a05:6000:2501:b0:3ec:dd26:6405 with SMTP id
 ffacd0b85a97d-405c74b9466mr1745620f8f.26.1758616854662; 
 Tue, 23 Sep 2025 01:40:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyl+tEU/fvTdtz7P3gPdbXsNpUu4lDBMaozoNrSScWwBruDPbB0Qqj3qCLZ03jQUdC49W7Jw==
X-Received: by 2002:a05:6000:2501:b0:3ec:dd26:6405 with SMTP id
 ffacd0b85a97d-405c74b9466mr1745586f8f.26.1758616854240; 
 Tue, 23 Sep 2025 01:40:54 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f9c62d083esm10919852f8f.32.2025.09.23.01.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Sep 2025 01:40:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:40:51 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] x86: ich9: fix default value of 'No Reboot' bit in GCS
Message-ID: <20250923104051.1b71d6ea@fedora>
In-Reply-To: <aNFcCQL7Ad_nnxMM@redhat.com>
References: <20250922132600.562193-1-imammedo@redhat.com>
 <aNFcCQL7Ad_nnxMM@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, 22 Sep 2025 15:24:09 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, Sep 22, 2025 at 03:26:00PM +0200, Igor Mammedov wrote:
> > [2] initialized 'No Reboot' bit to 1 by default. And due to quirk it ha=
ppened
> > to work with linux iTCO_wdt driver (which clears it on module load).
> >=20
> > However spec [1] states:
> > "
> > R/W. This bit is set when the =E2=80=9CNo Reboot=E2=80=9D strap (SPKR p=
in on
> > ICH9) is sampled high on PWROK.
> > "
> >=20
> > So it should be set only when  '-global ICH9-LPC.noreboot=3Dtrue' and c=
leared
> > when it's false (which should be default).
> >=20
> > Fix it to behave according to spec and set 'No Reboot' bit only when
> > '-global ICH9-LPC.noreboot=3Dtrue'. =20
>=20
> Is there a real-world problem you hit that is being solved by
> this change, or is it just a theoretical spec compliance fix ?

I've stumbled upon it when implementing ACPI watchdog POC

https://gitlab.com/imammedo/qemu/-/commits/wadt_poc
I'm not sure that watchdog table belongs to QEMU,
but the ICH fix definitely is.

(wrt watchdog, unless we want to configure it from QEMU CLI
incl. all logistics to propagate it up mgmt stack9(s),
it should be implemented in firmware as in real world)


> >=20
> > 1)
> > Intel I/O Controller Hub 9 (ICH9) Family Datasheet (rev: 004)
> > 2)
> > Fixes: 920557971b6 (ich9: add TCO interface emulation)
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/southbridge/ich9.h | 2 +-
> >  hw/isa/lpc_ich9.c             | 7 ++++++-
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich=
9.h
> > index 1e231e89c9..2c35dd0484 100644
> > --- a/include/hw/southbridge/ich9.h
> > +++ b/include/hw/southbridge/ich9.h
> > @@ -95,7 +95,7 @@ struct ICH9LPCState {
> >  #define ICH9_CC_OIC                             0x31FF
> >  #define ICH9_CC_OIC_AEN                         0x1
> >  #define ICH9_CC_GCS                             0x3410
> > -#define ICH9_CC_GCS_DEFAULT                     0x00000020
> > +#define ICH9_CC_GCS_DEFAULT                     0x00000000
> >  #define ICH9_CC_GCS_NO_REBOOT                   (1 << 5)
> > =20
> >  /* D28:F[0-5] */
> > diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
> > index 304dffac32..c9cb8f7779 100644
> > --- a/hw/isa/lpc_ich9.c
> > +++ b/hw/isa/lpc_ich9.c
> > @@ -132,6 +132,11 @@ static void ich9_cc_init(ICH9LPCState *lpc)
> >  static void ich9_cc_reset(ICH9LPCState *lpc)
> >  {
> >      uint8_t *c =3D lpc->chip_config;
> > +    uint32_t gcs =3D ICH9_CC_GCS_DEFAULT;
> > +
> > +    if (lpc->pin_strap.spkr_hi) {
> > +        gcs |=3D ICH9_CC_GCS_NO_REBOOT;
> > +    }
> > =20
> >      memset(lpc->chip_config, 0, sizeof(lpc->chip_config));
> > =20
> > @@ -142,7 +147,7 @@ static void ich9_cc_reset(ICH9LPCState *lpc)
> >      pci_set_long(c + ICH9_CC_D27IR, ICH9_CC_DIR_DEFAULT);
> >      pci_set_long(c + ICH9_CC_D26IR, ICH9_CC_DIR_DEFAULT);
> >      pci_set_long(c + ICH9_CC_D25IR, ICH9_CC_DIR_DEFAULT);
> > -    pci_set_long(c + ICH9_CC_GCS, ICH9_CC_GCS_DEFAULT);
> > +    pci_set_long(c + ICH9_CC_GCS, gcs);
> > =20
> >      ich9_cc_update(lpc);
> >  }
> > --=20
> > 2.47.3
> >=20
> >  =20
>=20
> With regards,
> Daniel


