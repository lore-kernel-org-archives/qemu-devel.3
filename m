Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AB8C9832F
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 17:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAsLA-00025j-PU; Sun, 27 Sep 2026 13:07:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAsKy-00025H-Fg
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:06:53 -0400
Received: from mout.gmx.net ([212.227.17.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1xAsKw-00026w-9i
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 13:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1790528787; x=1791133587; i=deller@gmx.de;
 bh=bapBLR0EnkAQ5QQVrn6RgPe96UU40nbfj9Tn/YwDu7M=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=IJfrbIhLOhRlqLpCRJIGqlu3R62hXcNoM+25SMZGjOK+QHphN2STCn6joC+531FQ
 pmKBp2BekQfsNburve5NkeF3okHPPhgB5uQeC3LfWrdhn8Eur0SFznX7ZW/6b6RTX
 OqLRDJPcDqnrVyd4cUvPQh3t2wPbaf5GaTf6b4l6HsHg3oDR3NE0BURvlRyVKc8vH
 s3p9L//XpbksY9HPMNWOGA924BGoeZEChjedH2g0dc1cO5DQE/I4E6Qqmd/dBRl6o
 bMHsMlOTbddTCSeIw3Br0MmGA/SsewANVMl9CqBqXp2cp/EV61IoA6mZ5IAjLDLt4
 8XbjsNrjUeoflXQGOw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRTNF-1xOqJC1ICj-00YHuT; Sun, 27
 Sep 2026 19:06:27 +0200
Message-ID: <66244f63-7027-4f4d-a4ad-c2e678ba46ab@gmx.de>
Date: Sun, 27 Sep 2026 19:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/5] input/hid: add horizontal pan to pointer event
 path
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Thomas Lambertz <patch@thomaslambertz.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex Golovko <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-2-soumyajyotisarkar23@gmail.com>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260331170823.72511-2-soumyajyotisarkar23@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UWIQErExNEnAyijx9smc6KM2Fle7TPgE1cJqh34TZPoFtRHXLWz
 Qi11XpNhcxOEkA8LCg8O+9h2VkIQFxvbmiUSNFcfxZ53ZJX1v42cjSVBfRNdZw4Y0kkqg4q
 l2YSU87szHT3klfyK1Bd5XVnVMX2rBV+QOPplbe+S8DTTHmulQIzswY31a+hlW7knFfAOKg
 i7LOWei66wxjrpX1QzMyA==
UI-OutboundReport: notjunk:1;M01:P0:oS9NrgGaAWs=;Y9Q311agQXPmFQkSU/PcT+01ocY
 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
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
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
> Add support for horizontal wheel scrolling (pan) in the HID mouse
> implementation. Extend the HIDPointerEvent structure with "pan" field
> to track horizontal scroll deltas, similar to the existing 'dz' field
> for vertical scrolling.
>=20
> Map INPUT_BUTTON_WHEEL_LEFT and INPUT_BUTTON_WHEEL_RIGHT to pan delta
> changes in the event handler. Integrate pan field handling into event
> compression logic and queue management to ensure consistent behavior wit=
h
> vertical wheel events.
>=20
> This changes enables subsequent patches to implement
> multiplier based scaling and protocol aware reporting for horizontal
> scrolling.
>=20
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>

Reviewed-by: Helge Deller <deller@gmx.de>


> ---
>   hw/input/hid.c         | 13 ++++++++++++-
>   include/hw/input/hid.h |  1 +
>   2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index de24cd0ef0..457dbb0096 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -152,6 +152,10 @@ static void hid_pointer_event(DeviceState *dev, Qem=
uConsole *src,
>                   e->dz--;
>               } else if (btn->button =3D=3D INPUT_BUTTON_WHEEL_DOWN) {
>                   e->dz++;
> +            } else if (btn->button =3D=3D INPUT_BUTTON_WHEEL_LEFT) {
> +                e->pan--;
> +            } else if (btn->button =3D=3D INPUT_BUTTON_WHEEL_RIGHT) {
> +                e->pan++;
>               }
>           } else {
>               e->buttons_state &=3D ~bmap[btn->button];
> @@ -208,6 +212,8 @@ static void hid_pointer_sync(DeviceState *dev)
>           }
>           prev->dz +=3D curr->dz;
>           curr->dz =3D 0;
> +        prev->pan +=3D curr->pan;
> +        curr->pan =3D 0;
>       } else {
>           /* prepare next (clear rel, copy abs + btns) */
>           if (hs->kind =3D=3D HID_MOUSE) {
> @@ -218,6 +224,7 @@ static void hid_pointer_sync(DeviceState *dev)
>               next->ydy =3D curr->ydy;
>           }
>           next->dz =3D 0;
> +        next->pan =3D 0;
>           next->buttons_state =3D curr->buttons_state;
>           /* make current guest visible, notify guest */
>           hs->n++;
> @@ -357,7 +364,7 @@ void hid_pointer_activate(HIDState *hs)
>=20
>   int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
>   {
> -    int dx, dy, dz, l;
> +    int dx, dy, dz, pan, l;
>       int index;
>       HIDPointerEvent *e;
>=20
> @@ -381,9 +388,13 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, in=
t len)
>       }
>       dz =3D int_clamp(e->dz, -127, 127);
>       e->dz -=3D dz;
> +    pan =3D int_clamp(e->pan, -127, 127);
> +    e->pan -=3D pan;
> +
>=20
>       if (hs->n &&
>           !e->dz &&
> +        !e->pan &&
>           (hs->kind =3D=3D HID_TABLET || (!e->xdx && !e->ydy))) {
>           /* that deals with this event */
>           QUEUE_INCR(hs->head);
> diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
> index 6a9d7bf466..1bb1778ee7 100644
> --- a/include/hw/input/hid.h
> +++ b/include/hw/input/hid.h
> @@ -10,6 +10,7 @@
>   typedef struct HIDPointerEvent {
>       int32_t xdx, ydy; /* relative iff it's a mouse, otherwise absolute=
 */
>       int32_t dz, buttons_state;
> +    int32_t pan;
>   } HIDPointerEvent;
>=20
>   #define QUEUE_LENGTH    16 /* should be enough for a triple-click */
> --
> 2.53.0


