Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1412CD2A54D
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Dec 2025 21:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRGxI-0007KG-89; Thu, 04 Dec 2025 16:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRGxD-0007JJ-UY
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 16:33:36 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vRGxC-0007SD-0n
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 16:33:35 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-42e33956e76so768187f8f.3
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764884010; x=1765488810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YAaSfAWPfzHh3b8jSGr3t+ylz4TQOJlnP20KX6YUxAM=;
 b=mXjfHm+1MGyriTOj1MdA3xyrAr/iejDHnAWNTMJ9ke9nR5G0vL3e44qwZsF0GHCWJc
 Tg5d4HTvicD+QyGXN8FdRmPBRs0eHQKDC+8GC1K4giw+ZkERlJs7YG5W7msx51SJuJsZ
 eQkheQshIYIOd5WTaFZJfj0H2bx6pky1jZwHmrm4eN/vEyMijMYuF0B3lyJyvPkwNyI1
 hmUA5xRDAIiwtwI7DwTTXDMkfI+7lM+dwJrZOYMer+p0CaB4Isp1KCNHCyfghs2o9bIG
 CjHZLx2eqElNJQrys0ZrAczTrq22rJeULkzIHa3iFGATcE5MorD0u8NmhYLSHXtFkwB2
 j/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764884010; x=1765488810;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YAaSfAWPfzHh3b8jSGr3t+ylz4TQOJlnP20KX6YUxAM=;
 b=pz/6ot78JaqyEESNUUhkL/UaBmK+lYAqB9NmFprL155limybUOBa+RMbwRtq8wF9i5
 DvrB1dBMGCM4NTSH4//U9y+8S4hLEAiuzxTFu3FDgYuDvWh1TZrAdhPLaBTyXsLvoQIP
 rjhGO9O6wN+Cx4tRN6ghRYLpQUOKKKeVoEJLVI+kt/HU65FfLtIsQV5/nn908DSvvxJ0
 XnIkS63bRer6Iud8RSMdbjfOc7hCYBr95Rene9GJnhDL6XZRzkO1L311DToYFqn2S4/r
 U5VFmr3Mj1ebAIaB+OAnwneRzqmuI9IhGhgqTiuipJt8Neb88PaBzYvqVuNownYJdpRb
 Pugw==
X-Gm-Message-State: AOJu0YzsRjw4SaOTYP3XM4uvHJ6BX6Pl9P173vr/nTLr8ZH0QOqozymd
 SNEtTlCjHPKmG7JVWodIInCcfwcSOQn2/ILlGxyJdS6S7LZAnWzKnaRAocfofSSDcNw=
X-Gm-Gg: ASbGncsQKnO2T4+sfkxZtQyFJy3p808U/0tp0uTccpFgiYBAd/WR3BRxA6QIcMa9kZE
 Gg/hDMJitEabFWfY7HeXxLAqibCdI+39+1vbcG/iDPXlhkyJ+uqcJskV5qWH3qhrdr5r304kzKh
 MhlG/m0vz7AJOWfY4QvXB4NmosR5ohH/ZIKWqw82d+m+4PNc0fJgS5sZxAqm6X9+1EPYZjJ3ZOq
 6SexTtxRq2Ypxh/itacp+SssR0yFf9TqZwmOuzvqS8mEPjvQgJIdC0fHnmg0yhLTWnij8Hitwry
 XB+H8mFmNAxKtighZKjn5xBKfp+iG48R5PRp06QxHdZzV7WJJrsEloB19u86mK+AwlHVmKRvsMF
 KnWDKr3OHt6JNdvIadi55xl7KFaJkv45t+EY+zIIpvUB6zr/7Hce3l2Egh9fGQCnuIR8PG8U2O1
 n4cOW5GMn7Itw=
X-Google-Smtp-Source: AGHT+IH1umH0oCTkHIGIHfaBfeQup2WZn1YpykBVp79uhT97/GZEZwkwPYo5QK6ChaBnium+voKFVg==
X-Received: by 2002:a05:6000:611:b0:429:d1a8:3fa2 with SMTP id
 ffacd0b85a97d-42f731c553fmr8107989f8f.48.1764884010313; 
 Thu, 04 Dec 2025 13:33:30 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe8f85sm5282854f8f.5.2025.12.04.13.33.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Dec 2025 13:33:29 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B951B5F7E9;
 Thu, 04 Dec 2025 21:33:28 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jim MacArthur <jim.macarthur@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/dma/omap_dma.c: Use 64 bit maths for
 omap_dma_transfer_setup
In-Reply-To: <20251204193311.1281133-1-jim.macarthur@linaro.org> (Jim
 MacArthur's message of "Thu, 4 Dec 2025 19:33:11 +0000")
References: <20251204193311.1281133-1-jim.macarthur@linaro.org>
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Thu, 04 Dec 2025 21:33:28 +0000
Message-ID: <87qztarkyf.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

Jim MacArthur <jim.macarthur@linaro.org> writes:

> If both frame and element count are 65535, which appears valid from my
> reading of the OMAP5912 documentation, then some of the calculations
> will overflow the 32-bit signed integer range and produce a negative
> min_elems value.
>
> Raised by #3204 (https://gitlab.com/qemu-project/qemu/-/issues/3204).
>

nit:

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3204

> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>  hw/dma/omap_dma.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
> index 101f91f4a3..93e6503ff9 100644
> --- a/hw/dma/omap_dma.c
> +++ b/hw/dma/omap_dma.c
> @@ -504,9 +504,19 @@ static void omap_dma_transfer_setup(struct soc_dma_c=
h_s *dma)
>      struct omap_dma_channel_s *ch =3D dma->opaque;
>      struct omap_dma_s *s =3D dma->dma->opaque;
>      int frames, min_elems, elements[__omap_dma_intr_last];
> +    uint64_t frames64, frame64, elements64, element64;
>=20=20
>      a =3D &ch->active_set;
>=20=20
> +    /*
> +     * We do maths with the frame and element fields which exceeds
> +     * a signed 32-bit integer, so convert all these to 64 bit for futur=
e use.
> +     */
> +    frames64 =3D a->frames;
> +    frame64 =3D a->frame;
> +    elements64 =3D a->elements;
> +    element64 =3D a->element;
> +
>      src_p =3D &s->mpu->port[ch->port[0]];
>      dest_p =3D &s->mpu->port[ch->port[1]];
>      if ((!ch->constant_fill && !src_p->addr_valid(s->mpu, a->src)) ||
> @@ -527,7 +537,7 @@ static void omap_dma_transfer_setup(struct soc_dma_ch=
_s *dma)
>      /* Check all the conditions that terminate the transfer starting
>       * with those that can occur the soonest.  */
>  #define INTR_CHECK(cond, id, nelements) \
> -    if (cond) {         \
> +    if (cond && nelements <=3D INT_MAX) {         \
>          elements[id] =3D nelements;   \
>          if (elements[id] < min_elems)   \
>              min_elems =3D elements[id];   \
> @@ -547,24 +557,24 @@ static void omap_dma_transfer_setup(struct soc_dma_=
ch_s *dma)
>       * See also the TODO in omap_dma_channel_load.  */
>      INTR_CHECK(
>                      (ch->interrupts & LAST_FRAME_INTR) &&
> -                    ((a->frame < a->frames - 1) || !a->element),
> +                    ((frame64 < frames64 - 1) || !element64),
>                      omap_dma_intr_last_frame,
> -                    (a->frames - a->frame - 2) * a->elements +
> -                    (a->elements - a->element + 1))
> +                    (frames64 - frame64 - 2) * elements64 +
> +                    (elements64 - element64 + 1))
>      INTR_CHECK(
>                      ch->interrupts & HALF_FRAME_INTR,
>                      omap_dma_intr_half_frame,
> -                    (a->elements >> 1) +
> -                    (a->element >=3D (a->elements >> 1) ? a->elements : =
0) -
> -                    a->element)
> +                    (elements64 >> 1) +
> +                    (element64 >=3D (elements64 >> 1) ? elements64 : 0) -
> +                    element64)
>      INTR_CHECK(
>                      ch->sync && ch->fs && (ch->interrupts & END_FRAME_IN=
TR),
>                      omap_dma_intr_frame,
> -                    a->elements - a->element)
> +                    elements64 - element64)
>      INTR_CHECK(
>                      ch->sync && ch->fs && !ch->bs,
>                      omap_dma_intr_frame_sync,
> -                    a->elements - a->element)
> +                    elements64 - element64)
>=20=20
>      /* Packets */
>      INTR_CHECK(
> @@ -581,8 +591,8 @@ static void omap_dma_transfer_setup(struct soc_dma_ch=
_s *dma)
>      INTR_CHECK(
>                      1,
>                      omap_dma_intr_block,
> -                    (a->frames - a->frame - 1) * a->elements +
> -                    (a->elements - a->element))
> +                    (frames64 - frame64 - 1) * elements64 +
> +                    (elements64 - element64))
>=20=20
>      dma->bytes =3D min_elems * ch->data_type;

Can we also add a qtest for the device that checks for this (and can be
expanded for other unit tests later)?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

