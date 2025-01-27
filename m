Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6795DC02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 14:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcQIc-0001d9-AV; Mon, 27 Jan 2025 09:41:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQII-0001Yt-8v
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:40:55 -0500
Received: from mail-yb1-xb31.google.com ([2607:f8b0:4864:20::b31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcQIF-0006RA-Ow
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 09:40:54 -0500
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso7981518276.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 06:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737988850; x=1738593650; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igU26OaUrMHkAXEoLTt8pG5PSWfGZgJYsR8vT4NBQwE=;
 b=WX7KbO8nW4PWmep6BqLN8RFpSPInS7wivcyLumHhkSvP0gjm6rxsOoJJtMkzY0jtpx
 W+62lOmy6Py6krznlXHJx3EOezl70XBmnV8M375bVzg3NTK5BVrZUyHJAJBDivDUDTK5
 kc+L/j3DX3fGbHrBmZmV1fdM/I71Mg1N+PK01oEAj8w2XRt7FF2xyDO8J/2PhBtpaI5S
 gG/L3T2VJlAbf0K53hZFbjxBqFmpbHyNO2AxWUUU60pHQ+7UHpszP+YtSiRjGtpUJUZt
 3djz/4Dwwu5nRAWEZj+DkM1zheKQMEDatagsywRKY5ArSrwEDIPmh4X2fzYRnaa1iWNY
 eHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737988850; x=1738593650;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=igU26OaUrMHkAXEoLTt8pG5PSWfGZgJYsR8vT4NBQwE=;
 b=SBZKOS6w3XIHc3M88p1NJnjVlGU+Svka2sPfK19LG2xBqldDnZ4GR7moi2mSeZwAl5
 H3dwi16cRdRkWpJCIiddb7LB0foVLCUhK5MyMR1+jF7peldgdrqX390b6FKZSIsWNjCV
 5cD8ETU5ngYVCgdBvg7F9Dl30Ofyt7gq6jSNesrfAhXCaadyLU2ZWy3CupbUxSqfg/7N
 J6lTFYK7dIMuXWaW9SYeJxL6rfmkioCW6vKZ1Ae1JxFhhjyBQ4L3wARVgW+O73c+NCk2
 5zOtzkTnYXZrsvGY+TUYh406yccz0fdCSRQYtfjr+GzVSI88NZF2KFORveGP6aIzvm37
 BgQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWly5skCD4EF06J+E45L67mCAHqSNGnXrjQNDP2dz9UivZ8yRKU/Gmfos+fhUQMjEJ4/wY+HfUeZ5io@nongnu.org
X-Gm-Message-State: AOJu0Ywvvi6LgDXlIPb8NvNW4+TNC59N40tsTKTNm3Xj5znJXArwsURX
 A/YjfpFp9cAxBWTtT0lzsrpYEVtFrRVXW6U4J9VMcHlNHQuEV/yDId0cTDrSPHCYlulR/0HsbL1
 o2P6lgeR4BqMuhEIi+FvuYYhWlg82ZCokIjXLI0cNvs49dh2D
X-Gm-Gg: ASbGncsueU2UWgU+4f8GOJYpcNJz/phO1jtiTzka0HpQqDcRFqPSOnh8b66yA6Mt4fn
 fItUFRKJnTjlksOrhm1O9qsg2mC6k9owUNg/+JSo1rQuxGL0qVlw0oBG/zk/am0g=
X-Google-Smtp-Source: AGHT+IFfaRyhvV7urGrf57AGB3++zAPDOhnxz3iU86D/kmW6ah6Y4136QOjysGAkiU6fYoQyUFWBPEZMtnZXUupfj3g=
X-Received: by 2002:a05:6902:110d:b0:e57:99a0:eda6 with SMTP id
 3f1490d57ef6-e57b1096d49mr29668651276.25.1737988850333; Mon, 27 Jan 2025
 06:40:50 -0800 (PST)
MIME-Version: 1.0
References: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
In-Reply-To: <20241219061658.805-1-andrew.yuan@jaguarmicro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 14:40:38 +0000
X-Gm-Features: AWEUYZnDOAZDZ2sLCyf__3Ae86IoqVoE_TmIXRkA5ABP3xjK8KcYbSTAxHNFZ1E
Message-ID: <CAFEAcA96ZLjOhBT9rhNhuk32ve0Qv4hUVuTTtgE=DBApbN98Pg@mail.gmail.com>
Subject: Re: [PATCH v3] hw/net: cadence_gem: feat: add logic for the
 DISABLE_MASK bit in type2_compare_x_word_1
To: "Andrew.Yuan" <andrew.yuan@jaguarmicro.com>
Cc: philmd@linaro.org, edgar.iglesias@gmail.com, alistair@alistair23.me, 
 jasowang@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b31;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Edgar or Alistair -- could one of you review this
cadence GEM patch, please?

On Thu, 19 Dec 2024 at 06:17, Andrew.Yuan <andrew.yuan@jaguarmicro.com> wro=
te:
>
> From: Andrew Yuan <andrew.yuan@jaguarmicro.com>
>
> As in the Cadence IP for Gigabit Ethernet MAC Part Number: IP7014 IP Rev:=
 R1p12 - Doc Rev: 1.3 User Guide,
> if the DISABLE_MASK bit in type2_compare_x_word_1 is set,
> mask_value in type2_compare_x_word_0 is used as an additional 2 byte Comp=
are Value
>
> Signed-off-by: Andrew Yuan <andrew.yuan@jaguarmicro.com>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/net/cadence_gem.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index 3fce01315f..7bd176951e 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -909,8 +909,8 @@ static int get_queue_from_screen(CadenceGEMState *s, =
uint8_t *rxbuf_ptr,
>
>          /* Compare A, B, C */
>          for (j =3D 0; j < 3; j++) {
> -            uint32_t cr0, cr1, mask, compare;
> -            uint16_t rx_cmp;
> +            uint32_t cr0, cr1, mask, compare, disable_mask;
> +            uint32_t rx_cmp;
>              int offset;
>              int cr_idx =3D extract32(reg, R_SCREENING_TYPE2_REG0_COMPARE=
_A_SHIFT + j * 6,
>                                     R_SCREENING_TYPE2_REG0_COMPARE_A_LENG=
TH);
> @@ -946,9 +946,23 @@ static int get_queue_from_screen(CadenceGEMState *s,=
 uint8_t *rxbuf_ptr,
>                  break;
>              }
>
> -            rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
> -            mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE)=
;
> -            compare =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_=
VALUE);
> +            disable_mask =3D
> +                FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1, DISABLE_MASK);
> +            if (disable_mask) {
> +                /*
> +                 * If disable_mask is set,
> +                 * mask_value is used as an additional 2 byte Compare Va=
lue.
> +                 * To simple, set mask =3D 0xFFFFFFFF, if disable_mask i=
s set.
> +                 */
> +                rx_cmp =3D ldl_le_p(rxbuf_ptr + offset);
> +                mask =3D 0xFFFFFFFF;
> +                compare =3D cr0;
> +            } else {
> +                rx_cmp =3D lduw_le_p(rxbuf_ptr + offset);

Is the change in behaviour in the !disable_mask codepath here
intentional? Previously we use one byte from rxbuf_ptr[offset],
duplicated into both halves of rx_cmp; now we will load two
different bytes from rxbuf_ptr[offset] and rxbuf_ptr[offset + 1].

If this is intended, we should say so in the commit message.


> +                mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VA=
LUE);
> +                compare =3D
> +                    FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, COMPARE_VALU=
E);
> +            }
>
>              if ((rx_cmp & mask) =3D=3D (compare & mask)) {
>                  matched =3D true;
> --
> 2.25.1

thanks
-- PMM

