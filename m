Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097B5CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB6m4-0004aL-9u; Mon, 28 Sep 2026 04:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xB6m2-0004aC-Ty
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:31:46 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xB6m0-0000r1-Pe
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 04:31:46 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4843cedd129so1489400f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 01:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790584303; x=1791189103; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FN71fA6hXR0XZW4uMGFS2c6uiiEQQkvQOqzzciVi4mQ=;
 b=Z+8DT5gBd/rYdTVgRHJEDA+qeO521IdOaeqeHfVb0h5Ys3BtWNbRcjjSeMK5PZ2NI1
 e5tbLKVHpbvFBebj4Hi48ZN1rH62M4IvO/NkV6r1e2xfbydmQP/o4boMC7AR59VBVakO
 pqa9r5Wj0RRouvkul4p1RgTpq+qgbRrrGy6OHoDdshmfhixQ0H0uM4H2UBAuLxaGGCym
 ifI1KBdGtOPeovujh5gd8Hw5JF40afGZ71XWr2sz3cvTHE+TJTFmle61oYbDWl1z89SU
 xFIhUbY15WbZnb8XYfdT1uUFmHU0dB2ZcI05ik+qgKoHScSsr79R7Ibpo64ejZ/Yh0MD
 d7qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790584303; x=1791189103;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FN71fA6hXR0XZW4uMGFS2c6uiiEQQkvQOqzzciVi4mQ=;
 b=xq+Y936lzP10zEFqrQ9bWbzBGXHFVE7Xn2uLCLT1ymqcsbeVejFwgigx4yKYlFWw4C
 YZk5X17M81KUrIOl6sAO89jTU1MX/y6eVHf61gNS8IV/0dQgrmAQjBCD/Cp4wYMupw7A
 Ka1OFod/5CvsB9AjKoYaNnIGn0BOMy4wKjgOmVXVM1F+t+XtjBjMac1Rd+j6qEd9E4Kw
 UnjUE6LUK4n4VG33D+Rn0FXQA5PH4WYpNIXIAMel7prhqJRLz8R3qeASSsgsrhC5aEfg
 tAT3yx89t6YGTQtgb8LPVgOiDiw13Sz+oGekecJZKlSmJ/IQhUHo7uKfPRr66OzPEMZa
 E2Tw==
X-Gm-Message-State: AFq9FYJQZmtPpK48bw9Tv7nEQg+i85lZ3S7xvV1jy6IEEW4QaigQaP6I
 n9pZ7wc4gnWEZNulPo6cjMyLRiBLy1G2/x7KH2D9djwm3LIbTx8Hu0fqk0b+76g0ZRA=
X-Gm-Gg: AYBFou2qLrFG1XZ2yxFrvhUXm6MGR5TH/U6X82TdCx65bRXk4jRpmIX4SUHyVrakByG
 vKxDlQOCtXForzSGNlcn8RioJkzM3bPhxKZ+M2IWX1+x1NF4NIaS6PLCWNpNzIGiqRGc3vHTqmV
 l637vmRY7yazJRaZl7niItaOWZBgrDoMxLV45JvaYc/kMeg03elt0p1/NkBoPDywT+tLGQF5UtK
 Bpp30vJYDSNgmX8ydiK+m7xpKnWmAYw2RCbgPauj3BHSYSZEVSPnhnk0zViD59YlKEVO2JT2OVN
 UC9QxDAzQdOfSqgF4vtMpXpNOZXw3CrN5NZUKdGp+zqk5ZspLSz4fZz8ozGesUSZiFuueqwcHJt
 W+PfoUx+Ze1+AkJi7jGnDQoROhFucUlbDvAd/ecLlZpX9USo9gWdEwxMOxZq4C7fe7K9Aa42xEJ
 0T/IgyFmeI8Fd6Xh3LdnXX1kdVkbi9uR98fOWXj18VNXBQi8Su5vi2pz4VotIi3rrwBGBdfQ==
X-Received: by 2002:a05:6000:4305:b0:487:27f6:a4e8 with SMTP id
 ffacd0b85a97d-488716c3488mr24268575f8f.56.1790584302786; 
 Mon, 28 Sep 2026 01:31:42 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30b9aesm23969779f8f.5.2026.09.28.01.31.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 01:31:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C0B5E5F832;
 Mon, 28 Sep 2026 09:31:40 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Thomas Lambertz <patch@thomaslambertz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alex Golovko
 <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
Subject: Re: [RFC PATCH 2/5] usb/hid: add enhanced wheel mouse report
 descriptor and packet size
In-Reply-To: <20260331170823.72511-3-soumyajyotisarkar23@gmail.com>
 (Soumyajyotii Ssarkar's message of "Tue, 31 Mar 2026 22:38:20 +0530")
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-3-soumyajyotisarkar23@gmail.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 28 Sep 2026 09:31:40 +0100
Message-ID: <87tsn9zsib.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com> writes:

> Build on top of the simple mouse HID report descriptor with an enhanced v=
ersion
> that supports report IDs and feature reports for high resolution mouse
> wheel control. As per the documentation structure.
>
> Check: https://download.microsoft.com/download/b/d/1/bd1f7ef4-7d72-419e-b=
c5c-9f79ad7bb66e/wheel.docx
>
> Changes:
> - Increase HID descriptor length from 52 to 144 bytes
> - Add report IDs (0x01 input, 0x02 feature)
> - Implement feature reports for wheel/pan resolution multipliers
> - Add AC Pan (horizontal scroll) usage
> - Increase endpoint packet size from 4 to 6 bytes for pan byte
>
> This enables guests to configure resolution multipliers (+-1, +-4, +-8, +=
-16)
> to control scroll acceleration and precision.
>
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>  hw/usb/dev-hid.c | 126 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 95 insertions(+), 31 deletions(-)
>
> diff --git a/hw/usb/dev-hid.c b/hw/usb/dev-hid.c
> index ae19d60203..49e23c2319 100644
> --- a/hw/usb/dev-hid.c
> +++ b/hw/usb/dev-hid.c
> @@ -93,7 +93,7 @@ static const USBDescIface desc_iface_mouse =3D {
>                  0x00,          /*  u8  country_code */
>                  0x01,          /*  u8  num_descriptors */
>                  USB_DT_REPORT, /*  u8  type: Report */
> -                52, 0,         /*  u16 len */
> +                144, 0,        /*  u16 len */

Is this effectively just sizeof(qemu_mouse_hid_report_descriptor)? Could
we use that instead of hard coding constants in the descriptor? Are
there a limited number of sizes or are these a flexible stream of bytes?

>              },
>          },
>      },
> @@ -101,7 +101,7 @@ static const USBDescIface desc_iface_mouse =3D {
>          {
>              .bEndpointAddress      =3D USB_DIR_IN | 0x01,
>              .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
> -            .wMaxPacketSize        =3D 4,
> +            .wMaxPacketSize        =3D 6,
>              .bInterval             =3D 0x0a,
>          },
>      },
> @@ -124,7 +124,7 @@ static const USBDescIface desc_iface_mouse2 =3D {
>                  0x00,          /*  u8  country_code */
>                  0x01,          /*  u8  num_descriptors */
>                  USB_DT_REPORT, /*  u8  type: Report */
> -                52, 0,         /*  u16 len */
> +                144, 0,        /*  u16 len */
>              },
>          },
>      },
> @@ -132,7 +132,7 @@ static const USBDescIface desc_iface_mouse2 =3D {
>          {
>              .bEndpointAddress      =3D USB_DIR_IN | 0x01,
>              .bmAttributes          =3D USB_ENDPOINT_XFER_INT,
> -            .wMaxPacketSize        =3D 4,
> +            .wMaxPacketSize        =3D 6,
>              .bInterval             =3D 7, /* 2 ^ (8-1) * 125 usecs =3D 8=
 ms */
>          },
>      },
> @@ -454,33 +454,97 @@ static const USBDesc desc_keyboard2 =3D {
>  };
>
>  static const uint8_t qemu_mouse_hid_report_descriptor[] =3D {
> -    0x05, 0x01,		/* Usage Page (Generic Desktop) */
> -    0x09, 0x02,		/* Usage (Mouse) */
> -    0xa1, 0x01,		/* Collection (Application) */
> -    0x09, 0x01,		/*   Usage (Pointer) */
> -    0xa1, 0x00,		/*   Collection (Physical) */
> -    0x05, 0x09,		/*     Usage Page (Button) */
> -    0x19, 0x01,		/*     Usage Minimum (1) */
> -    0x29, 0x05,		/*     Usage Maximum (5) */
> -    0x15, 0x00,		/*     Logical Minimum (0) */
> -    0x25, 0x01,		/*     Logical Maximum (1) */
> -    0x95, 0x05,		/*     Report Count (5) */
> -    0x75, 0x01,		/*     Report Size (1) */
> -    0x81, 0x02,		/*     Input (Data, Variable, Absolute) */
> -    0x95, 0x01,		/*     Report Count (1) */
> -    0x75, 0x03,		/*     Report Size (3) */
> -    0x81, 0x01,		/*     Input (Constant) */
> -    0x05, 0x01,		/*     Usage Page (Generic Desktop) */
> -    0x09, 0x30,		/*     Usage (X) */
> -    0x09, 0x31,		/*     Usage (Y) */
> -    0x09, 0x38,		/*     Usage (Wheel) */
> -    0x15, 0x81,		/*     Logical Minimum (-0x7f) */
> -    0x25, 0x7f,		/*     Logical Maximum (0x7f) */
> -    0x75, 0x08,		/*     Report Size (8) */
> -    0x95, 0x03,		/*     Report Count (3) */
> -    0x81, 0x06,		/*     Input (Data, Variable, Relative) */
> -    0xc0,		/*   End Collection */
> -    0xc0,		/* End Collection */
> +    0x05, 0x01,     /* Usage Page (Generic Desktop) */
> +    0x09, 0x02,     /* Usage (Mouse) */
> +    0xA1, 0x01,     /* Collection (Application) */
> +
> +    0x09, 0x02,     /* Usage (Mouse) */
> +    0xA1, 0x02,     /* Collection (Logical) */
> +
> +    0x85, 0x01,     /* Report ID (0x01) */
> +    0x09, 0x01,     /* Usage (Pointer) */
> +    0xA1, 0x00,     /* Collection (Physical) */
> +
> +    0x05, 0x09,     /* Usage Page (Button) */
> +    0x19, 0x01,     /* Usage Minimum (1) */
> +    0x29, 0x05,     /* Usage Maximum (5) */
> +    0x15, 0x00,     /* Logical Minimum (0) */
> +    0x25, 0x01,     /* Logical Maximum (1) */
> +    0x95, 0x05,     /* Report Count (5) */
> +    0x75, 0x01,     /* Report Size (1) */
> +    0x81, 0x02,     /* Input (Data,Var,Abs) */
> +
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0x75, 0x03,     /*  Report Size (3) */
> +    0x81, 0x01,     /*  Input (Const) */
> +
> +    0x05, 0x01,     /*  Usage Page (Generic Desktop) */
> +    0x09, 0x30,     /*  Usage (X) */
> +    0x09, 0x31,     /*  Usage (Y) */
> +    0x95, 0x02,     /*  Report Count (2) */
> +    0x75, 0x08,     /*  Report Size (8) */
> +    0x15, 0x81,     /*  Logical Minimum (-127) */
> +    0x25, 0x7F,     /*  Logical Maximum (127) */
> +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> +
> +    /* Vertical wheel logical collection */
> +    0xA1, 0x02,     /*  Collection (Logical) */
> +
> +    0x85, 0x02,     /*  Report ID (0x02) */
> +    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
> +    0x15, 0x00,     /*  Logical Minimum (0) */
> +    0x25, 0x01,     /*  Logical Maximum (1) */
> +    0x35, 0x01,     /*  Physical Minimum (1) */
> +    0x45, 0x04,     /*  Physical Maximum (4) */
> +    0x75, 0x02,     /*  Report Size (2) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
> +
> +    0x85, 0x01,     /*  Report ID (0x01) */
> +    0x09, 0x38,     /*  Usage (Wheel) */
> +    0x35, 0x00,     /*  Physical Minimum (0) */
> +    0x45, 0x00,     /*  Physical Maximum (0) */
> +    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
> +    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
> +    0x75, 0x08,     /*  Report Size (8) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> +
> +    0xC0,           /*  End Collection */
> +
> +    /* Horizontal wheel logical collection */
> +    0xA1, 0x02,     /*  Collection (Logical) */
> +
> +    0x85, 0x02,     /*  Report ID (0x02) */
> +    0x09, 0x48,     /*  Usage (Resolution Multiplier) */
> +    0x15, 0x00,     /*  Logical Minimum (0) */
> +    0x25, 0x01,     /*  Logical Maximum (1) */
> +    0x35, 0x01,     /*  Physical Minimum (1) */
> +    0x45, 0x04,     /*  Physical Maximum (4) */
> +    0x75, 0x02,     /*  Report Size (2) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0xB1, 0x02,     /*  Feature (Data,Var,Abs) */
> +
> +    0x35, 0x00,     /*  Physical Minimum (0) */
> +    0x45, 0x00,     /*  Physical Maximum (0) */
> +    0x75, 0x04,     /*  Report Size (4) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0xB1, 0x01,     /*  Feature (Const) */
> +
> +    0x85, 0x01,     /*  Report ID (0x01) */
> +    0x05, 0x0C,     /*  Usage Page (Consumer Devices) */
> +    0x0A, 0x38, 0x02,   /*  Usage (AC Pan) */
> +    0x15, 0x81,     /*  Logical Minimum (-0x7f) */
> +    0x25, 0x7F,     /*  Logical Maximum (0x7f) */
> +    0x75, 0x08,     /*  Report Size (8) */
> +    0x95, 0x01,     /*  Report Count (1) */
> +    0x81, 0x06,     /*  Input (Data,Var,Rel) */
> +
> +    0xC0,           /*  End Collection */
> +
> +    0xC0,           /*  End Collection (Physical) */
> +    0xC0,           /*  End Collection (Logical) */
> +    0xC0            /*  End Collection (Application) */
>  };
>
>  static const uint8_t qemu_tablet_hid_report_descriptor[] =3D {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

