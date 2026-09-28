Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA083C9833F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:01:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBui-0004h7-TO; Mon, 28 Sep 2026 10:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBBuY-0004cl-3R
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:00:56 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xBBuU-00038p-B0
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 10:00:53 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffa15f67fso10830915e9.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790604048; x=1791208848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LBbN8Oo6oa6n+1aLPrPR5Awrkq9UXBigcfmWzrk2yEA=;
 b=LUEonE3FUbE7rB24bgub9x38XJYIrAwZx/8vBan1NwVsdMFyiQOq8w59IP7uFzouEr
 BGp8VGTggWlGOPJCROPPu7Kj6Hu6Qq+lgO+UQWs0Xt+0a8GdaVADEck8QbCNsoylqgfc
 Uuzsbw8LFfxg6DlwgPcVTvWVjdGaN96h0XRlvwg+hzMBmDwNgGaAd7UtsQZtyWH+c8gw
 A3gK5xY+NvKwAWUIvgHMpdBWCpDRBXoF0IZSgywVSQn1fsIOo4biciC9yXCigr7Z/mKa
 3M7xY8VqaNDkiC/Bs9bYtLTNGAwpt8x3HSJ0SnD3pGKGid9u7kMynghj1SYRmUgea2CM
 dSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790604048; x=1791208848;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LBbN8Oo6oa6n+1aLPrPR5Awrkq9UXBigcfmWzrk2yEA=;
 b=qfWrcf02cSE6YnOBNv9wypPSgm/s4Xl6YcoFi6TGZO5hPhKEP2H/+0ymhdNF8dm2nn
 0F5goSeXuRBX1hif+IgKfHJBBYYnwkwAZqm2R4sW+SL/Y77RKuwNkKvFcVS69bFDMTvq
 fYW++YWNok96kiVMm8V3YiIdORTUjxxcYTXdLDcO/Dyjrp8yE4hBCrbgAeq71dJiN2S7
 t4DZyFD4Pl87ukbmvp+ixYOwfm7QaHUK2OTL/iDDUDm3gCJiXTFBfcgTCvpNdMV2LKsC
 H5VV8ElUG7v98aqKAKK2L5nzgPlQW8EsAa49gcwiKLiFaJSewfglB1TSaiV/AiC1a7pB
 JYCg==
X-Gm-Message-State: AFuF++koLu1ePtIaXm6KkCJSyJD4o0TzACKcsKTzEf7fixsrGM00aR8O
 ZZDf8sqzk9WY5ElmLx8dKqgXOxsXRLTZKCLKQ6/0tBjrDzG+rKnSjfgrLFxMOxeS5Uw=
X-Gm-Gg: AYBFou2CjL4tZbzn+fmV7aOmlCeKj6G7iCl3q3bXI628O1NgiErcaJQK74rrbmmrjG6
 UBfCuzHv82qyYS2dMsz9A3VKa+llrXVQRHXqjeMLcdm4s9/R5h2gJOA9Z3r70cWsDAD0NtG2i24
 N72sN8338zjQ7biBss0A8HjNBndsKLHzQS89MgHY7Hfoja34nCO9yf2fncyAZTHUGYZcAMpgA/b
 TkxVMQVg5NgbUkaUy+rg1gJ5ldiZyT7rSB3WI3nv21fjZb5/4mUd9Y8lDQNQj1ECviM9uNq077H
 4A9eaGrLnFbEIvbq4GbL/VNDFRoxweSWlogrfh3ZvMIyWDVUKwbuYdYk0puyMouUESVAE/CNXci
 eDslBeAFO1WL3AfOMmdiHGgjR6Wns33EkLEniWduMbwGRFKUryQdKSHGx9ulb10+JTl2hvv8DUj
 fqqS6SU2f9MvbRlIuSZptELSAjon8UzJqkd+60BLKw9F8oLGrUBV5/e5Si8L8fBEwLZ6KjxQ==
X-Received: by 2002:a05:600c:1c25:b0:49f:ce78:3561 with SMTP id
 5b1f17b1804b1-49fe66f19demr255506385e9.18.1790604048219; 
 Mon, 28 Sep 2026 07:00:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a007fd182csm44625565e9.2.2026.09.28.07.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:00:46 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AF1125F8C1;
 Mon, 28 Sep 2026 15:00:45 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,
 Soumyajyotii Ssarkar <sarkarsoumyajyoti23@gmail.com>,  Michael Tokarev
 <mjt@tls.msk.ru>,  Thomas Lambertz <patch@thomaslambertz.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Alex Golovko
 <alex@browserling.com>, ShengYi Hung <aokblast@FreeBSD.org>
Subject: Re: [RFC PATCH 5/5] input/hid: apply multiplier scaling with
 residual accumulation
In-Reply-To: <20260331170823.72511-6-soumyajyotisarkar23@gmail.com>
 (Soumyajyotii Ssarkar's message of "Tue, 31 Mar 2026 22:38:23 +0530")
References: <20260331170823.72511-1-soumyajyotisarkar23@gmail.com>
 <20260331170823.72511-6-soumyajyotisarkar23@gmail.com>
User-Agent: mu4e 1.14.4-pre4; emacs 30.1
Date: Mon, 28 Sep 2026 15:00:45 +0100
Message-ID: <87se2ta31u.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm2-x10.google.com
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

> Implement multiplier-based scaling with residual accumulation for
> fine-grained mouse wheel and pan sensitivity control in report mode.
>
> Applies divisor based scaling (1, 4, 8, 16) based on negotiated
> multiplier values.
> Then uses residual based approach to prevent precision loss:
>
>   residual +=3D delta
>   output =3D residual / divisor
>   residual -=3D output * divisor
>
> Residual state preserved across VM migrations via VMState.
>
> Signed-off-by: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> ---
>  hw/input/hid.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/input/hid.h |  2 ++
>  2 files changed, 62 insertions(+)
>
> diff --git a/hw/input/hid.c b/hw/input/hid.c
> index d0b7af7c13..9b800faeb0 100644
> --- a/hw/input/hid.c
> +++ b/hw/input/hid.c
> @@ -365,6 +365,7 @@ void hid_pointer_activate(HIDState *hs)
>  int hid_pointer_poll(HIDState *hs, uint8_t *buf, int len)
>  {
>      int dx, dy, dz, pan, l;
> +    int wheel_divisor, pan_divisor;
>      int index;
>      HIDPointerEvent *e;
>
> @@ -392,6 +393,54 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int=
 len)
>      e->pan -=3D pan;
>
>
> +    if (hs->kind =3D=3D HID_MOUSE && hs->protocol !=3D 0) {
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
> +
> +        if (pan_divisor > 1) {
> +            hs->ptr.pan_residual +=3D pan;
> +            pan =3D hs->ptr.pan_residual / pan_divisor;
> +            hs->ptr.pan_residual -=3D pan * pan_divisor;
> +        } else {
> +            hs->ptr.pan_residual =3D 0;
> +        }
> +    }
> +
>      if (hs->n &&
>          !e->dz &&
>          !e->pan &&
> @@ -405,6 +454,7 @@ int hid_pointer_poll(HIDState *hs, uint8_t *buf, int =
len)
>      dz =3D 0 - dz;
>      pan =3D 0 - pan;
>      l =3D 0;
> +
>      switch (hs->kind) {
>      case HID_MOUSE:
>          if (hs->protocol =3D=3D 0) {
> @@ -528,6 +578,11 @@ void hid_reset(HIDState *hs)
>      case HID_MOUSE:
>      case HID_TABLET:
>          memset(hs->ptr.queue, 0, sizeof(hs->ptr.queue));
> +        hs->ptr.mouse_grabbed =3D 0;
> +        hs->ptr.wheel_multiplier =3D 0;
> +        hs->ptr.pan_multiplier =3D 0;
> +        hs->ptr.wheel_residual =3D 0;
> +        hs->ptr.pan_residual =3D 0;
>          break;
>      }
>      hs->head =3D 0;
> @@ -619,6 +674,7 @@ static const VMStateDescription vmstate_hid_ptr_queue=
 =3D {
>          VMSTATE_INT32(xdx, HIDPointerEvent),
>          VMSTATE_INT32(ydy, HIDPointerEvent),
>          VMSTATE_INT32(dz, HIDPointerEvent),
> +        VMSTATE_INT32(pan, HIDPointerEvent),
>          VMSTATE_INT32(buttons_state, HIDPointerEvent),
>          VMSTATE_END_OF_LIST()
>      }
> @@ -636,6 +692,10 @@ const VMStateDescription vmstate_hid_ptr_device =3D {
>          VMSTATE_UINT32(n, HIDState),
>          VMSTATE_INT32(protocol, HIDState),
>          VMSTATE_UINT8(idle, HIDState),
> +        VMSTATE_UINT8(ptr.wheel_multiplier, HIDState),
> +        VMSTATE_UINT8(ptr.pan_multiplier, HIDState),
> +        VMSTATE_INT32(ptr.wheel_residual, HIDState),
> +        VMSTATE_INT32(ptr.pan_residual, HIDState),
>          VMSTATE_END_OF_LIST(),

If you update migration state you also need to ensure that older systems
can be migrated to newer ones. There are some docs in docs/devel that
give some guidance on handling these cases.=20

>      }
>  };
> diff --git a/include/hw/input/hid.h b/include/hw/input/hid.h
> index 1a1941d371..db902fa023 100644
> --- a/include/hw/input/hid.h
> +++ b/include/hw/input/hid.h
> @@ -25,6 +25,8 @@ typedef struct HIDMouseState {
>      int mouse_grabbed;
>      uint8_t wheel_multiplier;
>      uint8_t pan_multiplier;
> +    int32_t wheel_residual;
> +    int32_t pan_residual;
>  } HIDMouseState;
>
>  typedef struct HIDKeyboardState {

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

