Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBFFCA6007
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 15:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEq5O-0005B9-FS; Thu, 08 Oct 2026 11:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xEq5K-0005Aw-Mv
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 11:31:07 -0400
Received: from mail-ed2-x08.google.com ([2a00:1450:4864:33::8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1xEq5G-0000cU-DJ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 11:31:06 -0400
Received: by mail-ed2-x08.google.com with SMTP id
 4fb4d7f45d1cf-6ad83f018e0so3180607a12.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 08:31:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791473460; cv=none;
 d=google.com; s=arc-20260327;
 b=W4nMftOdI480kR4PV44VsfYWXMXbL5IB5YqjvXM4EckMyDQpg6YL9DEGWYkfw7j9cF
 Pg6vUivNAadyuU7BahtTMabhYiDKio2UIpTkDahFnwxXK+ltXYGOlkawBmvR6n7QSBxQ
 9782ubHZl1S1prt2lGSYLD9q6afyPzfRpOPSa00Vk+d+6+SpGauEdbHKM89TjaHN0ST5
 EsRZcHmIF0nVqn4w348Mw650zPjFfUAoPpz9yrPVmGPEYxiVNh0YRgsra4r4CwmCfDc9
 npcJBkuBWHo1r3HZxbs5Ur8s7mIihKAaGWOkcDJF3oEWl7ItxVsty2Fbmtq+NThOiUYo
 XHyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AkcLqWpDR/LjsaIQ9wbHdTndYBRk4ucFm1pQnfQCzS0=;
 fh=HWCo4T5zj8sY/g+gpZgfkMS/B9KaznbohreIuTcQsiw=;
 b=q1MsCvqYpxNCLN3xBEdxQvor3rvjlQqGvL+2M20OuNO7qvCLeotl4mxduffvQhioZu
 vEMsShn1GUPQcviSTeeUpyxE7RTGVakhBg8W+UJ+UQAGhd9ZmjicwvrLF1bR2Q6/9RgX
 XX0WGluWfGvLXPXcT97ZwedHLgfVDcNAIjIPlQ5rCtrnEJxREsPnLON4deHFrVC3taRu
 DKFo2d1AGt22+liWPb+YmKyx77exWrXYoj/zi7CD3H8qU4MT0Lo8DFGMg015+7kZ27Tq
 EatexcLfNNHcXPj8WVvTj4nv7Asfl4YmjsqLhiarT7UivG+bhnF1OhAkEdvTFjeGkD41
 toqA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791473460; x=1792078260; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AkcLqWpDR/LjsaIQ9wbHdTndYBRk4ucFm1pQnfQCzS0=;
 b=qXgkZIwCng1RNf+RlptzLjaqCSaF3in9L3z4HvAubrxAYDC5kGPproSYkPJLh5IXAJ
 BEtb3b3iSTTvVwcc0LlEBQSWdhCAykuNXgUQ+ssdrLqYdEWnLr12BST/fWTTIFQpmzlL
 A9fFgGHgHPFl3oCE/mKh3KF05wNddqIQB/iBHHWOtcPCcBh05hNhGNS+EfeUNtWJDLfC
 SgD8s4kr2Q691j2x4eOchOudhPdioj8JmZIjBelqMLy3EdlB2bErsl/ofvrCg1+BQHwA
 aR5PtWkyWcyDjjmEmcezky8CS8qyaPhtMYc2RXsKEMdTAj4RTnsCyodMShpNsjOywy/a
 jBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791473460; x=1792078260;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AkcLqWpDR/LjsaIQ9wbHdTndYBRk4ucFm1pQnfQCzS0=;
 b=KzaWniBWOBbxB/q+61g05gCD16MCAWXBr+li+PxnMpET03ljDFvRTtCrna+JWiijXf
 qYQ9DfLZ0caWutfLsyXJCBMXacm0NoMJi+YNdfGfU7ZONnFbUi3NrCQCWLitWIh/gUFE
 MvZ169baB6Kn3ss89SC47FBP75wsUkwSpOp/t0SLko5/Bs3JD5b979BTejco6RaR/F6U
 T/tTB8ud7LwHKDbD/SnwMQ6kNJm3z7CqJzBWGByhdH3B1oUAsd1hbx+BrFGQJF8wrOzB
 46qKGGvm+JoqkefbKBc21+IPWEBd2KkfP8VJvyEowMfLBiwTEs/xr37rczCx3dQrauVq
 xpFg==
X-Gm-Message-State: AFq9FYJ5uWrsMd6JZvNG/g6x/uGQpx1zorLG+U73kWxVWJy3kzSGtrZw
 Ffw+E+TrPCd+apsGFlHwSJenId2J0SZL9lPASmVPnqCbCs04wxtV2Y5bgVndTCjMNKrawuBY7Ut
 z6NgkTWJEkiPBPrLkT3DD/5iU6r1ecpo=
X-Gm-Gg: AYBFou0biriMcuneTR9GNzKYG7+GzJPb0BCVuh1ToKfmiGI+qdlS/OmjHTvAYzQJyN3
 RL1IpA4LagDB1X5jwrRVVUUUf028tqbCa6W8fT6P8S65hXTLk3ZSrm7dl8P4CvYL5FoRja1AnGH
 3AYfa+gCABQTppEADt8i9hNwEZFkK3jR1rkvR48cJbXWPTUblazcXUgFOkNNbIX2sn/gklEyz3A
 QNsVI0PcQpkIoZ9CT2m8B8kf9BGmLih2Qvd0c8uFJH2VmsSdi8WwQdONlBcpGeL0QtmN6vcgY9F
 PGnbGqHDoW4bT6YAWWur6ld+ZpvDbXimwEo1rcxC/6o+Tvfv3N/e9LJRTlN+YKLyDlGs9T1j8ri
 bhM1nBlkqmii1JlL7nlH+ypBJ8GK9k+uZ2Wn5Ge7m147OHvSsCGvxXmb+Hq6aVtjagiBlGlV9pF
 kwVleC405UNxk55DTsOevY
X-Received: by 2002:a05:6402:4604:b0:6ac:765e:def2 with SMTP id
 4fb4d7f45d1cf-6aff5752943mr4982363a12.41.1791473459719; Thu, 08 Oct 2026
 08:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-3-soumyajyotisarkar23@gmail.com>
 <87tsn9zsib.fsf@draig.linaro.org>
In-Reply-To: <87tsn9zsib.fsf@draig.linaro.org>
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Date: Thu, 8 Oct 2026 21:00:47 +0530
X-Gm-Features: AclHuK_EY3rWRtQ7fu08wD8MhxlLUsUhTNIymYb_NAc1cIQm-TI7aAy21r9eiY8
Message-ID: <CAGkZZ+v6SObrBGFW4+Uoew4aHto0oCGbFGjCQexkgwEdJ+MbKw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] usb/hid: add enhanced wheel mouse report
 descriptor and packet size
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Lambertz <patch@thomaslambertz.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@freebsd.org>
Content-Type: multipart/alternative; boundary="00000000000030f126065d55eb8a"
Received-SPF: pass client-ip=2a00:1450:4864:33::8;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-ed2-x08.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01 autolearn=ham autolearn_force=no
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

--00000000000030f126065d55eb8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 2:01=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:

> Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com> writes:
>
> > Build on top of the simple mouse HID report descriptor with an enhanced
> version
> > that supports report IDs and feature reports for high resolution mouse
> > wheel control. As per the documentation structure.
> >
> > Check:
> https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-bc5c-9f7=
9ad7bb66e/wheel.docx
> >
> > Changes:
> > - Increase HID descriptor length from 52 to 144 bytes
> > - Add report IDs (0x01 input, 0x02 feature)
> > - Implement feature reports for wheel/pan resolution multipliers
> > - Add AC Pan (horizontal scroll) usage
> > - Increase endpoint packet size from 4 to 6 bytes for pan byte
> >
> > This enables guests to configure resolution multipliers (+-1, +-4, +-8,
> +-16)
> > to control scroll acceleration and precision.
> >
> > Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> > ---
> >  hw/usb/dev-hid.c | 126 +++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 95 insertions(+), 31 deletions(-)
> >
> > diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
> > index ae19d60203..49e23c2319 100644
> > --- a/hw/usb/dev-hid.c
> > +++ b/hw/usb/dev-hid.c
> > @@ -93,7 +93,7 @@ static const USBDescIface desc_iface_mouse =3D {
> >                  0x00,          /*  u8  country_code */
> >                  0x01,          /*  u8  num_descriptors */
> >                  USB_DT_REPORT, /*  u8  type: Report */
> > -                52, 0,         /*  u16 len */
> > +                144, 0,        /*  u16 len */
>
>



> Is this effectively just sizeof(qemu_mouse_hid_report_descriptor)? Could
> we use that instead of hard coding constants in the descriptor? Are
> there a limited number of sizes or are these a flexible stream of bytes?
>

Yes, that is an option, before the valiue was 52 (hardcoded) then I
modified it to 144.
But the thing is the qemu_mouse_hid_report_descriptor is quite sensitive.
Like, from my testing: windows was being too sensitive.
Like when testing with other sizes by modifying the descriptor,
with the slightest of change it was not sensing
the mouse anymore... So to avoid the hassle, a hardcoded descriptor
would be a more viable option design wise, in my opinion.
This would help provide a proper cap and value for
further changes in the descriptor size.

Perhaps, I can do this in the actual patch: I could add a comment
regarding this descriptor size sensitivity and adopt the
sizeof(qemu_mouse_hid_report_descriptor) mentioning about
the 52->144 size change and the windows issue with it.

Would this be a viable approach?



> >              },
> >          },
> >      },
> > @@ -101,7 +101,7 @@ static const USBDescIface desc_iface_mouse =3D {
> >          {
> >              .bEndpointAddress      =3D USB_DIR_IN | 0x01,
> >              .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
> > -            .wMaxPacketSize        =3D 4,
> > +            .wMaxPacketSize        =3D 6,
> >              .bInterval             =3D 0x0a,
> >          },
> >      },
> > @@ -124,7 +124,7 @@ static const USBDescIface desc_iface_mouse2 =3D {
> >                  0x00,          /*  u8  country_code */
> >                  0x01,          /*  u8  num_descriptors */
> >                  USB_DT_REPORT, /*  u8  type: Report */
> > -                52, 0,         /*  u16 len */
> > +                144, 0,        /*  u16 len */
> >              },
> >          },
> >      },
> > @@ -132,7 +132,7 @@ static const USBDescIface desc_iface_mouse2 =3D {
> >          {
> >              .bEndpointAddress      =3D USB_DIR_IN | 0x01,
> >              .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
> > -            .wMaxPacketSize        =3D 4,
> > +            .wMaxPacketSize        =3D 6,
> >              .bInterval             =3D 7, /* 2 ^ (8-1) * 125 usecs =3D=
 8 ms
> */
> >          },
> >      },
> > @@ -454,33 +454,97 @@ static const USBDesc desc_keyboard2 =3D {
> >  };
> >
> >  static const uint8_t qemu_mouse_hid_report_descriptor[] =3D {
> > -    0x05, 0x01,              /* Usage Page (Generic Desktop) */
> > -    0x09, 0x02,              /* Usage (Mouse) */
> > -    0xa1, 0x01,              /* Collection (Application) */
> > -    0x09, 0x01,              /*   Usage (Pointer) */
> > -    0xa1, 0x00,              /*   Collection (Physical) */
> > -    0x05, 0x09,              /*     Usage Page (Button) */
> > -    0x19, 0x01,              /*     Usage Minimum (1) */
> > -    0x29, 0x05,              /*     Usage Maximum (5) */
> > -    0x15, 0x00,              /*     Logical Minimum (0) */
> > -    0x25, 0x01,              /*     Logical Maximum (1) */
> > -    0x95, 0x05,              /*     Report Count (5) */
> > -    0x75, 0x01,              /*     Report Size (1) */
> > -    0x81, 0x02,              /*     Input (Data, Variable, Absolute) *=
/
> > -    0x95, 0x01,              /*     Report Count (1) */
> > -    0x75, 0x03,              /*     Report Size (3) */
> > -    0x81, 0x01,              /*     Input (Constant) */
> > -    0x05, 0x01,              /*     Usage Page (Generic Desktop) */
> > -    0x09, 0x30,              /*     Usage (X) */
> > -    0x09, 0x31,              /*     Usage (Y) */
> > -    0x09, 0x38,              /*     Usage (Wheel) */
> > -    0x15, 0x81,              /*     Logical Minimum (-0x7f) */
> > -    0x25, 0x7f,              /*     Logical Maximum (0x7f) */
> > -    0x75, 0x08,              /*     Report Size (8) */
> > -    0x95, 0x03,              /*     Report Count (3) */
> > -    0x81, 0x06,              /*     Input (Data, Variable, Relative) *=
/
> > -    0xc0,            /*   End Collection */
> > -    0xc0,            /* End Collection */
> > +    0x05, 0x01,     /* Usage Page (Generic Desktop) */
> > +    0x09, 0x02,     /* Usage (Mouse) */
> > +    0xA1, 0x01,     /* Collection (Application) */
> > +
> > +    0x09, 0x02,     /* Usage (Mouse) */
> > +    0xA1, 0x02,     /* Collection (Logical) */
> > +
> > +    0x85, 0x01,     /* Report ID (0x01) */
> > +    0x09, 0x01,     /* Usage (Pointer) */
> > +    0xA1, 0x00,     /* Collection (Physical) */
> > +
> > +    0x05, 0x09,     /* Usage Page (Button) */
> > +    0x19, 0x01,     /* Usage Minimum (1) */
> > +    0x29, 0x05,     /* Usage Maximum (5) */
> > +    0x15, 0x00,     /* Logical Minimum (0) */
> > +    0x25, 0x01,     /* Logical Maximum (1) */
> > +    0x95, 0x05,     /* Report Count (5) */
> > +    0x75, 0x01,     /* Report Size (1) */
> > +    0x81, 0x02,     /* Input (Data,Var,Abs) */
> > +
> > +    0x95, 0x01,     /*  Report Count (1) */
> > +    0x75, 0x03,     /*  Report Size (3) */
> > +    0x81, 0x01,     /*  Input (Const) */
> > +
> > +    0x05, 0x01,     /*  Usage Page (Generic Desktop) */
> > +    0x09, 0x30,     /*  Usage (X) */
> > +    0x09, 0x31,     /*  Usage (Y) */
> > +    0x95, 0x02,     /*  Report Count (2) */
> > +    0x75, 0x08,     /*  Report Size (8) */
> > +    0x15, 0x81,     /*  Logical Minimum (-127) */
> > +    0x25, 0x7F,     /*  Logical Maximum (127) */
> > +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> > +
> > +    /* Vertical wheel logical collection */
> > +    0xA1, 0x02,     /*  Collection (Logical) */
> > +
> > +    0x85, 0x02,     /*  Report ID (0x02) */
> > +    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
> > +    0x15, 0x00,     /*  Logical Minimum (0) */
> > +    0x25, 0x01,     /*  Logical Maximum (1) */
> > +    0x35, 0x01,     /*  Physical Minimum (1) */
> > +    0x45, 0x04,     /*  Physical Maximum (4) */
> > +    0x75, 0x02,     /*  Report Size (2) */
> > +    0x95, 0x01,     /*  Report Count (1) */
> > +    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
> > +
> > +    0x85, 0x01,     /*  Report ID (0x01) */
> > +    0x09, 0x38,     /*  Usage (Wheel) */
> > +    0x35, 0x00,     /*  Physical Minimum (0) */
> > +    0x45, 0x00,     /*  Physical Maximum (0) */
> > +    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
> > +    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
> > +    0x75, 0x08,     /*  Report Size (8) */
> > +    0x95, 0x01,     /*  Report Count (1) */
> > +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> > +
> > +    0xC0,           /*  End Collection */
> > +
> > +    /* Horizontal wheel logical collection */
> > +    0xA1, 0x02,     /*  Collection (Logical) */
> > +
> > +    0x85, 0x02,     /*  Report ID (0x02) */
> > +    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
> > +    0x15, 0x00,     /*  Logical Minimum (0) */
> > +    0x25, 0x01,     /*  Logical Maximum (1) */
> > +    0x35, 0x01,     /*  Physical Minimum (1) */
> > +    0x45, 0x04,     /*  Physical Maximum (4) */
> > +    0x75, 0x02,     /*  Report Size (2) */
> > +    0x95, 0x01,     /*  Report Count (1) */
> > +    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
> > +
> > +    0x35, 0x00,     /*  Physical Minimum (0) */
> > +    0x45, 0x00,     /*  Physical Maximum (0) */
> > +    0x75, 0x04,     /*  Report Size (4) */
> > +    0x95, 0x01,     /*  Report Count (1) */
> > +    0xB1, 0x01,     /*  Feature (Const) */
> > +
> > +    0x85, 0x01,     /*  Report ID (0x01) */
> > +    0x05, 0x0C,     /*  Usage Page (Consumer Devices) */
> > +    0x0A, 0x38, 0x02,   /*  Usage (AC Pan) */
> > +    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
> > +    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
> > +    0x75, 0x08,     /*  Report Size (8) */
> > +    0x95, 0x01,     /*  Report Count (1) */
> > +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> > +
> > +    0xC0,           /*  End Collection */
> > +
> > +    0xC0,           /*  End Collection (Physical) */
> > +    0xC0,           /*  End Collection (Logical) */
> > +    0xC0            /*  End Collection (Application) */
> >  };
> >
> >  static const uint8_t qemu_tablet_hid_report_descriptor[] =3D {
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

Thank you,
Soumyajyotii Ssarkar

--00000000000030f126065d55eb8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><span style=3D"background-color:transpare=
nt">On Mon, Sep 28, 2026 at 2:01=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D=
"mailto:alex.bennee@linaro.org">alex.bennee@linaro.org</a>&gt; wrote:</span=
></div><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Soumyajyotii Ssarkar &lt;<a href=3D"mailto=
:soumyajyotisarkar23@gmail.com" target=3D"_blank">soumyajyotisarkar23@gmail=
.com</a>&gt; writes:<br>
<br>
&gt; Build on top of the simple mouse HID report descriptor with an enhance=
d version<br>
&gt; that supports report IDs and feature reports for high resolution mouse=
<br>
&gt; wheel control. As per the documentation structure.<br>
&gt;<br>
&gt; Check: <a href=3D"https://download.microsoft.com/download/b/d/1/bd1f7e=
f4-7d72-419e-bc5c-9f79ad7bb66e/wheel.docx" rel=3D"noreferrer" target=3D"_bl=
ank">https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-bc5c-=
9f79ad7bb66e/wheel.docx</a><br>
&gt;<br>
&gt; Changes:<br>
&gt; - Increase HID descriptor length from 52 to 144 bytes<br>
&gt; - Add report IDs (0x01 input, 0x02 feature)<br>
&gt; - Implement feature reports for wheel/pan resolution multipliers<br>
&gt; - Add AC Pan (horizontal scroll) usage<br>
&gt; - Increase endpoint packet size from 4 to 6 bytes for pan byte<br>
&gt;<br>
&gt; This enables guests to configure resolution multipliers (+-1, +-4, +-8=
, +-16)<br>
&gt; to control scroll acceleration and precision.<br>
&gt;<br>
&gt; Signed-off-by: Soumyajyotii Ssarkar &lt;<a href=3D"mailto:soumyajyotis=
arkar23@gmail.com" target=3D"_blank">soumyajyotisarkar23@gmail.com</a>&gt;<=
br>
&gt; ---<br>
&gt;=C2=A0 hw/usb/dev-hid.c | 126 +++++++++++++++++++++++++++++++++++------=
------<br>
&gt;=C2=A0 1 file changed, 95 insertions(+), 31 deletions(-)<br>
&gt;<br>
&gt; diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c<br>
&gt; index ae19d60203..49e23c2319 100644<br>
&gt; --- a/hw/usb/dev-hid.c<br>
&gt; +++ b/hw/usb/dev-hid.c<br>
&gt; @@ -93,7 +93,7 @@ static const USBDescIface desc_iface_mouse =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 u8=C2=A0 country_code */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 u8=C2=A0 num_descriptors */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 USB_DT_R=
EPORT, /*=C2=A0 u8=C2=A0 type: Report */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 52, 0,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 u16 len */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 144, 0,=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 u16 len */<br>
<br></blockquote><div><br></div><div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
Is this effectively just sizeof(qemu_mouse_hid_report_descriptor)? Could<br=
>
we use that instead of hard coding constants in the descriptor? Are<br>
there a limited number of sizes or are these a flexible stream of bytes?<br=
></blockquote><div><br></div><div>Yes, that is an option, before the valiue=
 was 52 (hardcoded) then=C2=A0<span style=3D"background-color:transparent">=
I modified it to 144.</span></div><div><span style=3D"background-color:tran=
sparent">B</span><span style=3D"background-color:transparent">ut the thing=
=C2=A0</span><span style=3D"background-color:transparent">is the qemu_mouse=
_hid_report_d</span><span style=3D"background-color:transparent">escriptor=
=C2=A0is quite sensitive.</span></div><div><span style=3D"background-color:=
transparent">Like,=C2=A0</span><span style=3D"background-color:transparent"=
>from my testing: windows was being too sensitive.</span></div><div><span s=
tyle=3D"background-color:transparent">Like when testing with other sizes=C2=
=A0</span><span style=3D"background-color:transparent">by modifying the des=
criptor,</span></div><div><span style=3D"background-color:transparent">with=
 the slightest of change it was not=C2=A0</span><span style=3D"background-c=
olor:transparent">sensing=C2=A0</span></div><div><span style=3D"background-=
color:transparent">the mouse anymore... So to=C2=A0</span>avoid the hassle<=
span style=3D"background-color:transparent">,=C2=A0</span><span style=3D"ba=
ckground-color:transparent">a hardcoded descriptor</span></div><div><span s=
tyle=3D"background-color:transparent">would be a more viable option design =
wise, in my opinion.</span></div><div><span style=3D"background-color:trans=
parent">This would help provide a proper cap and value for</span></div><div=
><span style=3D"background-color:transparent">further changes in the descri=
ptor size.</span></div><div><br></div><div>Perhaps, I can do this in the ac=
tual patch: I could add a comment</div><div>regarding this descriptor size =
sensitivity and adopt the</div><div>sizeof(qemu_mouse_hid_report_descriptor=
)=C2=A0<span style=3D"background-color:transparent">mentioning about</span>=
</div><div><span style=3D"background-color:transparent">the 52-&gt;144 size=
 change and the windows issue with it.</span></div><div><br></div><div>Woul=
d this be a viable approach?</div><div><br></div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -101,7 +101,7 @@ static const USBDescIface desc_iface_mouse =3D {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bEndpointAddress=C2=
=A0 =C2=A0 =C2=A0 =3D USB_DIR_IN | 0x01,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bmAttributes=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D USB_ENDPOINT_XFER_INT,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wMaxPacketSize=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wMaxPacketSize=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bInterval=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 0x0a,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -124,7 +124,7 @@ static const USBDescIface desc_iface_mouse2 =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 u8=C2=A0 country_code */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01,=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 u8=C2=A0 num_descriptors */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 USB_DT_R=
EPORT, /*=C2=A0 u8=C2=A0 type: Report */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 52, 0,=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 u16 len */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 144, 0,=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 u16 len */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -132,7 +132,7 @@ static const USBDescIface desc_iface_mouse2 =3D {<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bEndpointAddress=C2=
=A0 =C2=A0 =C2=A0 =3D USB_DIR_IN | 0x01,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bmAttributes=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D USB_ENDPOINT_XFER_INT,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wMaxPacketSize=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .wMaxPacketSize=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =3D 6,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .bInterval=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 7, /* 2 ^ (8-1) * 125 usecs =3D 8=
 ms */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0 =C2=A0 },<br>
&gt; @@ -454,33 +454,97 @@ static const USBDesc desc_keyboard2 =3D {<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static const uint8_t qemu_mouse_hid_report_descriptor[] =3D {<br=
>
&gt; -=C2=A0 =C2=A0 0x05, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Usage Page (Generic Desktop) */<br>
&gt; -=C2=A0 =C2=A0 0x09, 0x02,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Usage (Mouse) */<br>
&gt; -=C2=A0 =C2=A0 0xa1, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /* Collection (Application) */<br>
&gt; -=C2=A0 =C2=A0 0x09, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0Usage (Pointer) */<br>
&gt; -=C2=A0 =C2=A0 0xa1, 0x00,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0Collection (Physical) */<br>
&gt; -=C2=A0 =C2=A0 0x05, 0x09,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage Page (Button) */<br>
&gt; -=C2=A0 =C2=A0 0x19, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage Minimum (1) */<br>
&gt; -=C2=A0 =C2=A0 0x29, 0x05,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage Maximum (5) */<br>
&gt; -=C2=A0 =C2=A0 0x15, 0x00,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Logical Minimum (0) */<br>
&gt; -=C2=A0 =C2=A0 0x25, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Logical Maximum (1) */<br>
&gt; -=C2=A0 =C2=A0 0x95, 0x05,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Report Count (5) */<br>
&gt; -=C2=A0 =C2=A0 0x75, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Report Size (1) */<br>
&gt; -=C2=A0 =C2=A0 0x81, 0x02,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Input (Data, Variable, Absolute) */<br>
&gt; -=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Report Count (1) */<br>
&gt; -=C2=A0 =C2=A0 0x75, 0x03,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Report Size (3) */<br>
&gt; -=C2=A0 =C2=A0 0x81, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Input (Constant) */<br>
&gt; -=C2=A0 =C2=A0 0x05, 0x01,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage Page (Generic Desktop) */<br>
&gt; -=C2=A0 =C2=A0 0x09, 0x30,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage (X) */<br>
&gt; -=C2=A0 =C2=A0 0x09, 0x31,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage (Y) */<br>
&gt; -=C2=A0 =C2=A0 0x09, 0x38,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Usage (Wheel) */<br>
&gt; -=C2=A0 =C2=A0 0x15, 0x81,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Logical Minimum (-0x7f) */<br>
&gt; -=C2=A0 =C2=A0 0x25, 0x7f,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Logical Maximum (0x7f) */<br>
&gt; -=C2=A0 =C2=A0 0x75, 0x08,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Report Size (8) */<br>
&gt; -=C2=A0 =C2=A0 0x95, 0x03,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Report Count (3) */<br>
&gt; -=C2=A0 =C2=A0 0x81, 0x06,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 /*=C2=A0 =C2=A0 =C2=A0Input (Data, Variable, Relative) */<br>
&gt; -=C2=A0 =C2=A0 0xc0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0=
 =C2=A0End Collection */<br>
&gt; -=C2=A0 =C2=A0 0xc0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* End C=
ollection */<br>
&gt; +=C2=A0 =C2=A0 0x05, 0x01,=C2=A0 =C2=A0 =C2=A0/* Usage Page (Generic D=
esktop) */<br>
&gt; +=C2=A0 =C2=A0 0x09, 0x02,=C2=A0 =C2=A0 =C2=A0/* Usage (Mouse) */<br>
&gt; +=C2=A0 =C2=A0 0xA1, 0x01,=C2=A0 =C2=A0 =C2=A0/* Collection (Applicati=
on) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x09, 0x02,=C2=A0 =C2=A0 =C2=A0/* Usage (Mouse) */<br>
&gt; +=C2=A0 =C2=A0 0xA1, 0x02,=C2=A0 =C2=A0 =C2=A0/* Collection (Logical) =
*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x85, 0x01,=C2=A0 =C2=A0 =C2=A0/* Report ID (0x01) */<b=
r>
&gt; +=C2=A0 =C2=A0 0x09, 0x01,=C2=A0 =C2=A0 =C2=A0/* Usage (Pointer) */<br=
>
&gt; +=C2=A0 =C2=A0 0xA1, 0x00,=C2=A0 =C2=A0 =C2=A0/* Collection (Physical)=
 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x05, 0x09,=C2=A0 =C2=A0 =C2=A0/* Usage Page (Button) *=
/<br>
&gt; +=C2=A0 =C2=A0 0x19, 0x01,=C2=A0 =C2=A0 =C2=A0/* Usage Minimum (1) */<=
br>
&gt; +=C2=A0 =C2=A0 0x29, 0x05,=C2=A0 =C2=A0 =C2=A0/* Usage Maximum (5) */<=
br>
&gt; +=C2=A0 =C2=A0 0x15, 0x00,=C2=A0 =C2=A0 =C2=A0/* Logical Minimum (0) *=
/<br>
&gt; +=C2=A0 =C2=A0 0x25, 0x01,=C2=A0 =C2=A0 =C2=A0/* Logical Maximum (1) *=
/<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x05,=C2=A0 =C2=A0 =C2=A0/* Report Count (5) */<b=
r>
&gt; +=C2=A0 =C2=A0 0x75, 0x01,=C2=A0 =C2=A0 =C2=A0/* Report Size (1) */<br=
>
&gt; +=C2=A0 =C2=A0 0x81, 0x02,=C2=A0 =C2=A0 =C2=A0/* Input (Data,Var,Abs) =
*/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (1=
) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x03,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (3)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x81, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Input (Const) *=
/<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x05, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage Page (Gen=
eric Desktop) */<br>
&gt; +=C2=A0 =C2=A0 0x09, 0x30,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage (X) */<br=
>
&gt; +=C2=A0 =C2=A0 0x09, 0x31,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage (Y) */<br=
>
&gt; +=C2=A0 =C2=A0 0x95, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (2=
) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x08,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (8)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x15, 0x81,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Minimum=
 (-127) */<br>
&gt; +=C2=A0 =C2=A0 0x25, 0x7F,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Maximum=
 (127) */<br>
&gt; +=C2=A0 =C2=A0 0x81, 0x06,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Input (Data,Var=
,Rel) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Vertical wheel logical collection */<br>
&gt; +=C2=A0 =C2=A0 0xA1, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Collection (Log=
ical) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x85, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report ID (0x02=
) */<br>
&gt; +=C2=A0 =C2=A0 0x09, 0x48,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage (Resoluti=
on Multiplier) */<br>
&gt; +=C2=A0 =C2=A0 0x15, 0x00,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Minimum=
 (0) */<br>
&gt; +=C2=A0 =C2=A0 0x25, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Maximum=
 (1) */<br>
&gt; +=C2=A0 =C2=A0 0x35, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Minimu=
m (1) */<br>
&gt; +=C2=A0 =C2=A0 0x45, 0x04,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Maximu=
m (4) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (2)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (1=
) */<br>
&gt; +=C2=A0 =C2=A0 0xB1, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Feature (Data,V=
ar,Abs) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x85, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report ID (0x01=
) */<br>
&gt; +=C2=A0 =C2=A0 0x09, 0x38,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage (Wheel) *=
/<br>
&gt; +=C2=A0 =C2=A0 0x35, 0x00,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Minimu=
m (0) */<br>
&gt; +=C2=A0 =C2=A0 0x45, 0x00,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Maximu=
m (0) */<br>
&gt; +=C2=A0 =C2=A0 0x15, 0x81,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Minimum=
 (-0x7f) */<br>
&gt; +=C2=A0 =C2=A0 0x25, 0x7F,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Maximum=
 (0x7f) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x08,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (8)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (1=
) */<br>
&gt; +=C2=A0 =C2=A0 0x81, 0x06,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Input (Data,Var=
,Rel) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0xC0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =
End Collection */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Horizontal wheel logical collection */<br>
&gt; +=C2=A0 =C2=A0 0xA1, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Collection (Log=
ical) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x85, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report ID (0x02=
) */<br>
&gt; +=C2=A0 =C2=A0 0x09, 0x48,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage (Resoluti=
on Multiplier) */<br>
&gt; +=C2=A0 =C2=A0 0x15, 0x00,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Minimum=
 (0) */<br>
&gt; +=C2=A0 =C2=A0 0x25, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Maximum=
 (1) */<br>
&gt; +=C2=A0 =C2=A0 0x35, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Minimu=
m (1) */<br>
&gt; +=C2=A0 =C2=A0 0x45, 0x04,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Maximu=
m (4) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (2)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (1=
) */<br>
&gt; +=C2=A0 =C2=A0 0xB1, 0x02,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Feature (Data,V=
ar,Abs) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x35, 0x00,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Minimu=
m (0) */<br>
&gt; +=C2=A0 =C2=A0 0x45, 0x00,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Physical Maximu=
m (0) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x04,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (4)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (1=
) */<br>
&gt; +=C2=A0 =C2=A0 0xB1, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Feature (Const)=
 */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0x85, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report ID (0x01=
) */<br>
&gt; +=C2=A0 =C2=A0 0x05, 0x0C,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Usage Page (Con=
sumer Devices) */<br>
&gt; +=C2=A0 =C2=A0 0x0A, 0x38, 0x02,=C2=A0 =C2=A0/*=C2=A0 Usage (AC Pan) *=
/<br>
&gt; +=C2=A0 =C2=A0 0x15, 0x81,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Minimum=
 (-0x7f) */<br>
&gt; +=C2=A0 =C2=A0 0x25, 0x7F,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Logical Maximum=
 (0x7f) */<br>
&gt; +=C2=A0 =C2=A0 0x75, 0x08,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Size (8)=
 */<br>
&gt; +=C2=A0 =C2=A0 0x95, 0x01,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Report Count (1=
) */<br>
&gt; +=C2=A0 =C2=A0 0x81, 0x06,=C2=A0 =C2=A0 =C2=A0/*=C2=A0 Input (Data,Var=
,Rel) */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0xC0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =
End Collection */<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 0xC0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =
End Collection (Physical) */<br>
&gt; +=C2=A0 =C2=A0 0xC0,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*=C2=A0 =
End Collection (Logical) */<br>
&gt; +=C2=A0 =C2=A0 0xC0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*=C2=A0 =
End Collection (Application) */<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static const uint8_t qemu_tablet_hid_report_descriptor[] =3D {<b=
r>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br></blockquote><div><br></div><div>Thank=
 you,</div><div>Soumyajyotii Ssarkar=C2=A0</div></div></div>

--00000000000030f126065d55eb8a--

