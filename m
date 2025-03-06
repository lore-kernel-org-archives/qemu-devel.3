Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714F1C19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpzra-0004ja-Oi; Wed, 05 Mar 2025 20:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzrY-0004jG-PD
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:17:24 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tpzrR-0005UN-UU
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:17:24 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-523a5dbe070so50474e0c.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741223836; x=1741828636; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G6ZE1izSOrE2SDS5HRswZUsHYuYNU9xlFVugsd8beI0=;
 b=glfZGB+QHJ1EYl/fpSKDpr2XR3mYPZXGhxCXChteEqAy02ycOTplRfXmKYElDqoVPe
 RJvxljcmJI/fg4qUcHtI4Z1/gBOThQsN44qlJFgnn6JYpvHgocVPJZUDLFm61Ty6amh1
 JoM73SiJn5SE64Qtnbu6KsK8b2ZXfxm+mDzvY//yCPdESIGACkcU4YHdJnFXuOrAX4A6
 CRNOKZL/+2Z9RIO+nz+YRfkdCv1jrg+zyYv7BJRpJXqGKvVUQEha0bh0YirbMNA/nsRl
 quU0BHcvJ0qtcSM0zfbod6Q4tx07sYgPgC99IF1CKc4YrjQGr1AWpQwp55iXOU9VN0aK
 p1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741223836; x=1741828636;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G6ZE1izSOrE2SDS5HRswZUsHYuYNU9xlFVugsd8beI0=;
 b=xMnTtTjr/7Nsnvwuh13iBG9SiMp6vJzuI/mHt/j97Ldf1AmTNYSupYxbhSxs7DJEWI
 dnDQGyAxFvd5kHhESvkRgHp2KQSu0Hgw2HzDIQKlhk/POOdIwpgwg8u7FpYwmuOGqflh
 NGnSVX9eTunRK1tesm6Dhb9zw2+xA6YaIwdUuBWzsQl1aOml/dBD/XrPrRAxOe9envP5
 FwjujR9I4VDiBzzmpO4yLShO+jX9oBVNLGL3uuQ5QAwUqR2iQc68ZHvsqQCgWH2KXlCO
 RDrZhYFES2uZJ6JCbIQ9vFVjtewDzTKz7hasM7TsNBdZK9lLdIK6KR5Hi6ceYCu20CMt
 2r6Q==
X-Gm-Message-State: AOJu0YwIzgPlW2tDCYs5IkBo0KhN3DHFZezppci+PLw9uGNsLwhtAeI5
 SYDRldn9nE4X/ualjZbm3rBP6TkjVeTF+q+OHyKCBquEhSVHZkDA2Uh2bwJ5Qt4SDAbMlq90IaC
 2zNDkwut7qQhUPpPu+6JvXwRoAhi2usonb8fz/g==
X-Gm-Gg: ASbGnctZ0lHQsGi9vyrH3X5+MuMwE1laZuKwCR5XTAAGcmhl5Zdz4J1kb20wO0dmBVC
 Th8Oe5rS1bB5qa2oGBgAPHy2U9n86IfLVOQqvrU8ykZT6LJ+3INGdSDDkOFa0jWYJLjacvSvTwO
 CY0CEQQGvKokISTvcDKgmucpyIIWlTlHN/Ubk2fLvPmMDI+j17zp5pyjP6
X-Google-Smtp-Source: AGHT+IGepBO4V8LbFqTK4GK92kDHzU1dStd3C78GLCyJkMNBMgsZbSO4zhUuCfzOD4N4wpxZtpx+Vzw5pExz3hpik8E=
X-Received: by 2002:a05:6102:dd0:b0:4bb:d062:447 with SMTP id
 ada2fe7eead31-4c2e2707657mr3563890137.5.1741223836619; Wed, 05 Mar 2025
 17:17:16 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-3-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-3-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 11:16:50 +1000
X-Gm-Features: AQ5f1Jq9PrRc8Iprk3GS821vjIqyMlL5U3Svbw7D45dVeBpV6AYldTbGJwgrBUg
Message-ID: <CAKmqyKMdUONoXD69m3RH1PeoLLtL8qT-eXweVh9WHEZM5Feufg@mail.gmail.com>
Subject: Re: [PATCH 2/7] target/riscv: env->misa_mxl is a constant
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Wed, Feb 19, 2025 at 3:01=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> There is nothing that overwrites env->misa_mxl, so it is a constant.  Do

The idea is that misa_mxl can change, although that's not supported now.

> not let a corrupted migration stream change the value; changing misa_mxl

Does this actually happen? If the migration data is corrupted won't we
have all sorts of strange issues?

Alistair

> would have a snowball effect on, for example, the valid VM modes.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  target/riscv/machine.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index d8445244ab2..c3d8e7c4005 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -375,6 +375,18 @@ static const VMStateDescription vmstate_ssp =3D {
>      }
>  };
>
> +static bool riscv_validate_misa_mxl(void *opaque, int version_id)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(opaque);
> +    CPURISCVState *env =3D &cpu->env;
> +    RISCVCPUClass *mcc =3D RISCV_CPU_GET_CLASS(cpu);
> +    uint32_t misa_mxl_saved =3D env->misa_mxl;
> +
> +    /* Preserve misa_mxl even if the migration stream corrupted it  */
> +    env->misa_mxl =3D mcc->misa_mxl_max;
> +    return misa_mxl_saved =3D=3D mcc->misa_mxl_max;
> +}
> +
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
>      .version_id =3D 10,
> @@ -394,6 +406,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINTTL(env.priv_ver, RISCVCPU),
>          VMSTATE_UINTTL(env.vext_ver, RISCVCPU),
>          VMSTATE_UINT32(env.misa_mxl, RISCVCPU),
> +        VMSTATE_VALIDATE("MXL must match", riscv_validate_misa_mxl),
>          VMSTATE_UINT32(env.misa_ext, RISCVCPU),
>          VMSTATE_UNUSED(4),
>          VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
> --
> 2.48.1
>
>

