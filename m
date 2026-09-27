Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89D6AC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 20:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAvNL-00048R-0Y; Sun, 27 Sep 2026 16:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAvNG-00048E-3D
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:21:26 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAvND-0004Mz-NS
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 16:21:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790540475; x=1791145275; i=deller@gmx.de;
 bh=0g70Y4bYIwEJTLzdsisABtd5vzYCXXduvMzumPx1jyk=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=Y/jFJ9c08a+l2gYspFJ6vGD4g2Kw+YzBIvh2xgC/JynBfmGG6SSbdfv0QHlnN5jG
 /Rl5FYwDxNcNDPAr/4hQZ7+dUYRomZa4MvPvGGj30YTLjcFUXkJQlMDnZGynYrAY3
 +wpxI3gCC1cssqebQrBfpBfNU7Rd4S6lSUAnviRa8BJ6ywj99R/Gjes6kaUbKWy86
 TozjGMK3PM0y9aCruCuzbZ0AQz82k3K+Vy7j5nQ2qB2yVKTFnBN3NxKDGxdrgGSiU
 bNMT13fc/SFJaIUxFUwqe9YqTpO5C4iV2xp30hzToK+P1rWiuUH7GceKbqdB/pS7C
 sej8p5FIi2hW9O5fiA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTiPl-1xIF6c06gf-00IqDJ; Sun, 27
 Sep 2026 22:21:15 +0200
Message-ID: <8faecb5d-464d-46ce-a4e7-e805c83123e7@gmx.de>
Date: Sun, 27 Sep 2026 22:21:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] input/hid: apply multiplier scaling with residual
 accumulation
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-6-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260331170823.72511-6-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XEdwlAKBFqIWcETIky9dsUC1M6bpHAhbEOiGs6vwnLD9fdt2Wx
 6/s4MjNcVx1EWzJM97pVcmGpMaBP/V5f4L1dCKwadIxdbLS2HRFBgbF4R/amdzVl7HD1hVC
 kykYYeyA21/3wtLY1Gxl6bsGZXQZDUJ7+cLHoemNMkRJBHf/8m87GrbPNGWvPPIbxFrL2N4
 eb6BW1JzUKKHNeFmKb3LQ==
UI-OutboundReport: notjunk:1;M01:P0:CNXVyCltm3w=;GECKWJtOUiOqthYeB8a1j6KaRrq
 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
 ZpipPsBIj7+jkJ7bif50LpkPHw==
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 3/31/26 19:08, Soumyajyotii Ssarkar wrote:
> Implement multiplier-based scaling with residual accumulation for
> fine-grained mouse wheel and pan sensitivity control in report mode.
>=20
> Applies divisor based scaling (1, 4, 8, 16) based on negotiated
> multiplier values.
> Then uses residual based approach to prevent precision loss:
>=20
>    residual +=3D delta
>    output =3D residual / divisor
>    residual -=3D output * divisor
>=20
> Residual state preserved across VM migrations via VMState.
>=20
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>   hw/input/hid.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
>   include/hw/input/hid.h |  2 ++
>   2 files changed, 62 insertions(+)
>=20
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index d0b7af7c13..9b800faeb0 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -365,6 +365,7 @@ void hid_pointer_activate(HIDState *hs)
>   int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
>   {
>       int dx, dy, dz, pan, l;
> +    int wheel_divisor, pan_divisor;
>       int index;
>       HIDPointerEvent *e;
>=20
> @@ -392,6 +393,54 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, in=
t len)
>       e->pan -=3D pan;
>=20
>=20
> +    if (hs->kind =3D=3D HID_MOUSE && hs->protocol !=3D 0) {

shouldn't this better be "hs->protocol =3D=3D 1" ?


> +        switch (hs->ptr.wheel_multiplier & 0x03) {
> +        case 0:
> +            wheel_divisor =3D 1;
> +            break;
> +        case 1:
> +            wheel_divisor =3D 4;
> +            break;
> +        case 2:
> +            wheel_divisor =3D 8;
> +            break;
> +        default:
> +            wheel_divisor =3D 16;
> +            break;
> +        }
> +
> +        switch (hs->ptr.pan_multiplier & 0x03) {
> +        case 0:
> +            pan_divisor =3D 1;
> +            break;
> +        case 1:
> +            pan_divisor =3D 4;
> +            break;
> +        case 2:
> +            pan_divisor =3D 8;
> +            break;
> +        default:
> +            pan_divisor =3D 16;
> +            break;
> +        }
> +
> +        if (wheel_divisor > 1) {
> +            hs->ptr.wheel_residual +=3D dz;
> +            dz =3D hs->ptr.wheel_residual / wheel_divisor;
> +            hs->ptr.wheel_residual -=3D dz * wheel_divisor;
> +        } else {
> +            hs->ptr.wheel_residual =3D 0;
> +        }

maybe instead of the whole above: ?

	if (hs->ptr.wheel_multiplier & 0x03) {
             wheel_divisor =3D 2 << (hs->ptr.wheel_multiplier & 0x03);
             hs->ptr.wheel_residual +=3D dz;
             dz =3D hs->ptr.wheel_residual / wheel_divisor;
             hs->ptr.wheel_residual -=3D dz * wheel_divisor;
         } else {
             hs->ptr.wheel_residual =3D 0;
         }

> +
> +        if (pan_divisor > 1) {
> +            hs->ptr.pan_residual +=3D pan;
> +            pan =3D hs->ptr.pan_residual / pan_divisor;
> +            hs->ptr.pan_residual -=3D pan * pan_divisor;
> +        } else {
> +            hs->ptr.pan_residual =3D 0;
> +        }

same here.


> +    }
> +
>       if (hs->n &&
>           !e->dz &&
>           !e->pan &&
> @@ -405,6 +454,7 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int=
 len)
>       dz =3D 0 - dz;
>       pan =3D 0 - pan;
>       l =3D 0;
> +

drop this change.

>       switch (hs->kind) {
>       case HID_MOUSE:
>           if (hs->protocol =3D=3D 0) {
> @@ -528,6 +578,11 @@ void hid_reset(HIDState *hs)
>       case HID_MOUSE:
>       case HID_TABLET:
>           memset(hs->ptr.queue, 0, sizeof(hs->ptr.queue));
> +        hs->ptr.mouse_grabbed =3D 0;
> +        hs->ptr.wheel_multiplier =3D 0;
> +        hs->ptr.pan_multiplier =3D 0;
> +        hs->ptr.wheel_residual =3D 0;
> +        hs->ptr.pan_residual =3D 0;

and move that in an own patch.

Otherwise the patch seems ok.
I suggest you resend the series with the proposed changes and
make sure it applies against git head.

Thanks!
Helge

