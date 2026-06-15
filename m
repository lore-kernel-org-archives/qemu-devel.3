Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C753CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYzBA-0007JH-2U; Mon, 15 Jun 2026 00:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYzB7-0007IX-HK
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:44:05 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wYzB0-0003Xc-2W
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:44:05 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69155ca09d8so3086652a12.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 21:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781498626; cv=none;
 d=google.com; s=arc-20240605;
 b=WudmjaJueiPhut0VkCfpJcGVC0fmAiEZKqaRFWZzFrKWGdfJl6PjJfXSrnLp+lZlsS
 01ZQChuiWRy19+F44/D8Sm+dFKcvyGH0nJM+sHq75+wiSq/yoQKw+Ni6is9a36n93fyc
 WjaBC+v1uc+UJTT5MkVtu2T0y7isO0tQ4GHKnhn7YvTWjpsvb2p9hi7Jb99yuorocqbf
 Gjb2f65HSQw2Dulpjw9Nks1UpdBAHTkezyfO7ihCVXgSIFfM6S2cZJVI9qOIxcn/gxUJ
 LELDFiuIXqJwaqOzuw6HdtVej0S4xlg4G5Me/J+SakOh0LsGAgj3CfiQMnrTdDkxOijt
 hcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DrcGPMbuxyxKnqdIu36LaepVNElvzfbfxu1uxA8QwOA=;
 fh=XKJtyJI0IdRXlCOcf2TGDy3yE6PCg6rfXJTb7EAQDMA=;
 b=iGyKK8Z1XBN/oAk9ilJzANj2m0BsG5PY5Hj4+Fizo3CmqNoXCV5TrGbcZ9orncqb7M
 1YLHC3hceapuZ4t7xxfzPzlgpH6rxWIE4bDKJlO2IlrYznkQB1Q0djnXOfpqV1PfBNjd
 UIYvg0wDvcuhXokZzX9ZmGnMzmxtnerBRgaPIi7aGcVC8sUGSELjdn8v38xOQ7Wu2srl
 ppImle49VDdwZGAQ4C50KM9UvebUZmZwKYM4m3CLUdKmZUiYq1mgf01PixVt54xjfDCW
 +yyb6y1tXJ8GvkoL1D9kwa70YGSL8YENXMi0OpXyNksGRu9mnDQDDUbZvTqarQef3Bk0
 Qrfw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781498626; x=1782103426; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrcGPMbuxyxKnqdIu36LaepVNElvzfbfxu1uxA8QwOA=;
 b=C0dp1AXBpdwOFzjp2RymlNnUcFAvU7sFlI6KEtWNm42DDtWwHDr67bXOOmd8ym78jc
 7TU6KPPAFAJKuiuaDxbmHBuHK0k7RBsK+QevGhxsUx5x+tsQbuOgfaCIpdE5yGouURE9
 sSRuY5JolG+LNw8IO3wviQIbRAiwTjxvYfHbNJ7GslVHJlF+osIb4esGwJjcTucZbIfp
 1fb30sWD75Q2S61rWEyCyNpG745KfOFZiJbU1lZ00mr4LNNk55e0IkV+sPAuZA/Y9+ww
 /euQW+J2A6KoU7lYoekini7JeltwabfTLsnnQKBKdfxTA3GjathuULyngnYEBGt2yQQ/
 gSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781498626; x=1782103426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DrcGPMbuxyxKnqdIu36LaepVNElvzfbfxu1uxA8QwOA=;
 b=KodJ9FlhZQ0Q1F9jyxeSoJf6L7pcM92zmNV0oShbZ0P+hQ86mGCkKDgNOBvnegiGnQ
 LQDd+XOMA3PVRFqUoMBsf9ZtBBfZwNlW55MkXRhx8zZaPO608QFrCQLaBY6gPpBi6cQN
 3txbvqMsO7Puk08U9tQShjZEN6INWZcwbNKYM2hlKvMlUC+dCi96ExE3/i62y/gMuzRB
 x4Qh0K5dYvggEalBkUXKTCFzS6iQo5WAvKfs4qsI0yQB3zbNi2PUPEVT040mKL+ve0hu
 FdjxRPGv29vsX9DMH6THB6P6NTHkdcNWGWriSjyK+8YMSIl+sofLxMQIspQoXlGG9BPO
 MQZA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9IniQxDbt4Govxd0qqN5HqEgy2xdkMHrpIRipCFOwXiAA35IODIjMqcNNzoOdIvsSwTrX32hp4I4h1@nongnu.org
X-Gm-Message-State: AOJu0Yy1BTkISp14ScqYvkvsrkjyEzl6PuwHm3Wm7XZ4+K+HgXdezQf0
 VIAPEU4t92yU8HzhGlELyuqpDx2llg8p0i0pTEGx7KdqnL0sCUIs+xHXoEfIZimFHeVz23EH2xD
 0taWHxzY7v1r9A1LkqqEjIq2FT7m2ppM=
X-Gm-Gg: Acq92OGh6/RtStArTayGh4O4hphzQUdfG8oao+DA+A+likg3gkACpYvSJiEf/sUw3Ol
 fscxSDOrIXV3d40kL0U+3wku6aebCZEzY6wuU1PwOvNN8q9syNRz3iqxO1NRl21wxcDEXSNz+pe
 3Lv/Odpt00aJxIbctytAJbGGRmlePWT2+V0RAVrRGMQbOudnpM+GhpK+h80jM4Bdl93t/vp3vm4
 5s8MFRFkXWJ5V+iCcM566l6K5OJG8lO74inapBtLiCfOtU/YhsWt0mfic0oSNYJvzIRk4nzNsBK
 Zdsujm49H45SEIgCI0JZHa0kxT0Uh6cTeDUNMw==
X-Received: by 2002:a05:6402:530e:b0:68c:bf82:884c with SMTP id
 4fb4d7f45d1cf-693778c3aeemr5092069a12.6.1781498625959; Sun, 14 Jun 2026
 21:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-6-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-6-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 14:43:19 +1000
X-Gm-Features: AVVi8CeZ_RyHdElm9_hhwOfbp0QCgGS0SiTey-Rb_WQqu8aTMJZfv7COEXaI87A
Message-ID: <CAKmqyKMoxRONCgs_ZVPykigCR476ZiHeVJ5ETxWkruq8vPpjJg@mail.gmail.com>
Subject: Re: [PATCH v8 05/12] hw/riscv/aia: Configure stride for the M-mode
 IMSIC
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 3, 2026 at 5:04=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> riscv_create_aia() currently hard-codes the M-IMSIC at one 4 KiB page
> per hart and gives callers no way to widen it.
>
> Add an m_imsic_stride parameter that supplies the per hart byte
> stride directly. The virt machine passes IMSIC_HART_SIZE(0)
> (=3D 4 KiB), preserving its existing compact layout.
>
> The parameter only changes how the slots are spaced, with the rest of
> each slot reserved. This allows future platforms that have different
> layouts to control the stride.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

With a `uint32_t`

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/aia.h  | 1 +
>  hw/riscv/aia.c  | 3 ++-
>  hw/riscv/virt.c | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/aia.h b/hw/riscv/aia.h
> index 5ad0a902be0d..452e78b9d7ad 100644
> --- a/hw/riscv/aia.h
> +++ b/hw/riscv/aia.h
> @@ -14,6 +14,7 @@
>  uint32_t imsic_num_bits(uint32_t count);
>
>  DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             hwaddr m_imsic_stride,
>                               uint16_t num_sources,
>                               const MemMapEntry *aplic_m,
>                               const MemMapEntry *aplic_s,
> diff --git a/hw/riscv/aia.c b/hw/riscv/aia.c
> index 82ea9d48ea75..840f84d26b98 100644
> --- a/hw/riscv/aia.c
> +++ b/hw/riscv/aia.c
> @@ -25,6 +25,7 @@ uint32_t imsic_num_bits(uint32_t count)
>  }
>
>  DeviceState *riscv_create_aia(bool msimode, int aia_guests,
> +                             hwaddr m_imsic_stride,
>                               uint16_t num_sources,
>                               const MemMapEntry *aplic_m,
>                               const MemMapEntry *aplic_s,
> @@ -47,7 +48,7 @@ DeviceState *riscv_create_aia(bool msimode, int aia_gue=
sts,
>              /* Per-socket M-level IMSICs */
>              addr =3D imsic_m->base + socket * (1U << IMSIC_MMIO_GROUP_MI=
N_SHIFT);
>              for (i =3D 0; i < hart_count; i++) {
> -                riscv_imsic_create(addr + i * IMSIC_HART_SIZE(0),
> +                riscv_imsic_create(addr + i * m_imsic_stride,
>                                     base_hartid + i, true, 1,
>                                     num_msis);
>              }
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 4cd941a6aac6..529bb2fc0132 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1549,6 +1549,7 @@ static void virt_machine_init(MachineState *machine=
)
>          } else {
>              s->irqchip[i] =3D riscv_create_aia(s->aia_type =3D=3D VIRT_A=
IA_TYPE_APLIC_IMSIC,
>                                               s->aia_guests,
> +                                             IMSIC_HART_SIZE(0),
>                                               s->num_sources,
>                                               &s->memmap[VIRT_APLIC_M],
>                                               &s->memmap[VIRT_APLIC_S],
> --
> 2.47.3
>
>

