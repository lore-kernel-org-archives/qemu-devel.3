Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2756D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 20:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t83wW-0006B7-4C; Mon, 04 Nov 2024 15:44:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t83wP-0006Af-VH
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:44:50 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1t83wN-0002tO-Lv
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 15:44:49 -0500
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-43163667f0eso39374385e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 12:44:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730753085; x=1731357885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bvnqOlUsA6jQ21zkt7e7Ne2llQsAOQQwDVmYy3lzmtM=;
 b=OS+887q+FDqkSXGeMhyHjPmUsDbWyhiLZho+IQ9ZxTz27POODZ1r7q0ycsp9dvQVvW
 /3QDBOz2E4Q17ceaxbPa8GFDLq21uS3mj4nUTb4hIyL76tn/ETj4by/f7s0IgPzYZXw3
 a9gY6GqO8x7wBRz2dMTgorEAsTaPEb9wTdkssQI6FwNMSqfyASX2pHB71rcOpO0tD0Q8
 YELeoGf0OSQX+SkqnLF9RZlExh6GaX27AqwbUFuIJX9+LRrwe8CsHU+3tJr1pYf/jGy+
 3uZvEizaKvlk3dG05SScRpTtRbgRwlVJmIsv6hm8VlPyngNQ5YtCDNyY0bE7dgkvdUZo
 Lr8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnzmsORYav25aiU/od0ohxyPpDK7zdbNBc4IRhzX3DF2C7c2YkFMoW7ptCPkZpvolIN9LpvJw4Sahq@nongnu.org
X-Gm-Message-State: AOJu0Yw9tpp2hhMw90L2H/sZfmeUvOBYL6pzYQwlJxpp9SXdjJiLT6wK
 VCMc3VRJ7TUlTq39qIC0kcSgSL6TvSr1gYrA6HBHb66dyJC+VhDD
X-Google-Smtp-Source: AGHT+IHXRb47hcHHYK1nKakDqKKlmBZ8F+1/YtDy478y7YGPVMhuHzpfw/TIVssQjtR+9av+ljijzg==
X-Received: by 2002:a05:600c:1d27:b0:431:52a3:d9ea with SMTP id
 5b1f17b1804b1-432831c1ff1mr125763855e9.0.1730753085317; 
 Mon, 04 Nov 2024 12:44:45 -0800 (PST)
Received: from tpx1 (ip-109-42-48-251.web.vodafone.de. [109.42.48.251])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917f0bsm189680105e9.17.2024.11.04.12.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 12:44:44 -0800 (PST)
Date: Mon, 4 Nov 2024 21:44:42 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/2] next-kbd: convert to use
 qemu_input_handler_register()
Message-ID: <20241104214442.74a3e5cd@tpx1>
In-Reply-To: <ZyicQT4eKlN07AHz@redhat.com>
References: <20241101201106.1432336-1-mark.cave-ayland@ilande.co.uk>
 <20241101201106.1432336-2-mark.cave-ayland@ilande.co.uk>
 <ZyicQT4eKlN07AHz@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.54; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f54.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Mon, 4 Nov 2024 10:04:49 +0000
schrieb Daniel P. Berrang=C3=A9 <berrange@redhat.com>:

> On Fri, Nov 01, 2024 at 08:11:05PM +0000, Mark Cave-Ayland wrote:
> > Convert the next-kbd device from the legacy UI qemu_add_kbd_event_handl=
er()
> > function to use qemu_input_handler_register().
> >=20
> > Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > ---
> >  hw/m68k/next-kbd.c | 166 ++++++++++++++++++++++++++++++---------------
> >  1 file changed, 111 insertions(+), 55 deletions(-)
> >=20
> > diff --git a/hw/m68k/next-kbd.c b/hw/m68k/next-kbd.c
> > index bc67810f31..283e98e9eb 100644
> > --- a/hw/m68k/next-kbd.c
> > +++ b/hw/m68k/next-kbd.c =20
>=20
>=20
> > -static const unsigned char next_keycodes[128] =3D {
> > -    0x00, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x50, 0x4F,
> > -    0x4E, 0x1E, 0x1F, 0x20, 0x1D, 0x1C, 0x1B, 0x00,
> > -    0x42, 0x43, 0x44, 0x45, 0x48, 0x47, 0x46, 0x06,
> > -    0x07, 0x08, 0x00, 0x00, 0x2A, 0x00, 0x39, 0x3A,
> > -    0x3B, 0x3C, 0x3D, 0x40, 0x3F, 0x3E, 0x2D, 0x2C,
> > -    0x2B, 0x26, 0x00, 0x00, 0x31, 0x32, 0x33, 0x34,
> > -    0x35, 0x37, 0x36, 0x2e, 0x2f, 0x30, 0x00, 0x00,
> > -    0x00, 0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
> > -    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 =20
>=20
> The original code used '0' (or equivalently 0x00) to
> indicate an unmapped scancode.
>=20
> > +#define NEXTKBD_NO_KEY 0xff =20
>=20
> Now you're using 0xff for missing mappings, but....
>=20
> > +
> > +static const int qcode_to_nextkbd_keycode[] =3D {
> > +    /* Make sure future additions are automatically set to NEXTKBD_NO_=
KEY */
> > +    [0 ... Q_KEY_CODE__MAX]    =3D NEXTKBD_NO_KEY,
> > +
> > +    [Q_KEY_CODE_ESC]           =3D 0x49,
> > +    [Q_KEY_CODE_1]             =3D 0x4a,
> > +    [Q_KEY_CODE_2]             =3D 0x4b,
> > +    [Q_KEY_CODE_3]             =3D 0x4c,
> > +    [Q_KEY_CODE_4]             =3D 0x4d,
> > +    [Q_KEY_CODE_5]             =3D 0x50,
> > +    [Q_KEY_CODE_6]             =3D 0x4f,
> > +    [Q_KEY_CODE_7]             =3D 0x4e,
> > +    [Q_KEY_CODE_8]             =3D 0x1e,
> > +    [Q_KEY_CODE_9]             =3D 0x1f,
> > +    [Q_KEY_CODE_0]             =3D 0x20,
> > +    [Q_KEY_CODE_MINUS]         =3D 0x1d,
> > +    [Q_KEY_CODE_EQUAL]         =3D 0x1c,
> > +    [Q_KEY_CODE_BACKSPACE]     =3D 0x1b,
> > +    [Q_KEY_CODE_TAB]           =3D 0x00, =20
>=20
> ...you've left 0x00 here and....
>=20
> > +
> > +    [Q_KEY_CODE_Q]             =3D 0x42,
> > +    [Q_KEY_CODE_W]             =3D 0x43,
> > +    [Q_KEY_CODE_E]             =3D 0x44,
> > +    [Q_KEY_CODE_R]             =3D 0x45,
> > +    [Q_KEY_CODE_T]             =3D 0x48,
> > +    [Q_KEY_CODE_Y]             =3D 0x47,
> > +    [Q_KEY_CODE_U]             =3D 0x46,
> > +    [Q_KEY_CODE_I]             =3D 0x06,
> > +    [Q_KEY_CODE_O]             =3D 0x07,
> > +    [Q_KEY_CODE_P]             =3D 0x08,
> > +    [Q_KEY_CODE_RET]           =3D 0x2a,
> > +    [Q_KEY_CODE_A]             =3D 0x39,
> > +    [Q_KEY_CODE_S]             =3D 0x3a,
> > +
> > +    [Q_KEY_CODE_D]             =3D 0x3b,
> > +    [Q_KEY_CODE_F]             =3D 0x3c,
> > +    [Q_KEY_CODE_G]             =3D 0x3d,
> > +    [Q_KEY_CODE_H]             =3D 0x40,
> > +    [Q_KEY_CODE_J]             =3D 0x3f,
> > +    [Q_KEY_CODE_K]             =3D 0x3e,
> > +    [Q_KEY_CODE_L]             =3D 0x2d,
> > +    [Q_KEY_CODE_SEMICOLON]     =3D 0x2c,
> > +    [Q_KEY_CODE_APOSTROPHE]    =3D 0x2b,
> > +    [Q_KEY_CODE_GRAVE_ACCENT]  =3D 0x26,
> > +    [Q_KEY_CODE_SHIFT]         =3D 0x00,
> > +    [Q_KEY_CODE_BACKSLASH]     =3D 0x00, =20
>=20
> ...here, and ...
>=20
>=20
>=20
> > +    [Q_KEY_CODE_Z]             =3D 0x31,
> > +    [Q_KEY_CODE_X]             =3D 0x32,
> > +    [Q_KEY_CODE_C]             =3D 0x33,
> > +    [Q_KEY_CODE_V]             =3D 0x34,
> > +
> > +    [Q_KEY_CODE_B]             =3D 0x35,
> > +    [Q_KEY_CODE_N]             =3D 0x37,
> > +    [Q_KEY_CODE_M]             =3D 0x36,
> > +    [Q_KEY_CODE_COMMA]         =3D 0x2e,
> > +    [Q_KEY_CODE_DOT]           =3D 0x2f,
> > +    [Q_KEY_CODE_SLASH]         =3D 0x30,
> > +    [Q_KEY_CODE_SHIFT_R]       =3D 0x00, =20
>=20
> ...here, which is surely not a correct conversion
>=20
> > +
> > +    [Q_KEY_CODE_SPC]           =3D 0x38,
> >  }; =20
>=20
>=20
> Those missing mappings definitely have values too.
>=20
> I can see the 'shift' and 'tab' keys on the real Next
> keyboard I have in front of me right now :-)
>=20
> Finding a reliable reference for the NeXT scancodes is very hard
> in my googling so far. The best I've come across so far is
>=20
> https://github.com/spenczar/usb-next/blob/main/keymap.h
>=20
> who has defined a mapping to USB HID codes, which seems to
> broadly match what's above here, plus has many of the gaps
> fixed.
>=20
> Do you know of any other decent references for scancodes ?

I guess the emulator "Previous" is the best and easiest resource:

 https://sourceforge.net/p/previous/code/HEAD/tree/trunk/src/keymap.c#l25

 HTH,
  Thomas

