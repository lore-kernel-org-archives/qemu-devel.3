Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF9FC8302F
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 23:24:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWNqt-0006DN-8x; Mon, 30 Jun 2025 19:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uWNqr-0006Ce-Ds; Mon, 30 Jun 2025 19:23:53 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uWNqp-0000HZ-LN; Mon, 30 Jun 2025 19:23:53 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4e9c6b44477so1917397137.3; 
 Mon, 30 Jun 2025 16:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751325830; x=1751930630; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oRv/ZGebEpExuq0d5LPY93uI4zzW3lexV9Zn/HcsrL0=;
 b=G00SKDttqsR235zqcFQvwbtECVtrQ3G4uvdxXyl28TC3RlMoZdm7I8eCwNZvUYnLkU
 9eLGJd/DEigCLdaGU2g58WCvayW5wsB7jlAZNayoW21JEZ9kSJ1wYhsGsXfAxcIpTzvv
 TyMZPJZra4r/gfOnc+VCjoh0KobzBzd1m8BsHOFMGqGqs7YcIu9U488OJ0IxbGQkrsgX
 9gI5ayml//6GyLCsNCPIo4zYnbsWXKRh95KX4sdQK1/7NoL1ThLUYwzCnFFytJqMvoCC
 u4xTjEs26UJO16c5rQysjuedQTfrd2F1nUMzX09T+SLjfC6+osSGKIuKA4n8thHWd2UH
 kY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751325830; x=1751930630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oRv/ZGebEpExuq0d5LPY93uI4zzW3lexV9Zn/HcsrL0=;
 b=Ue2LQBIzyNTIL90IFb9B7ZRHoWsSE1bvGbYRm3exBqrUUINsBrxeg2tdb4NFybA9ho
 WDx384CYbSQfakZm3RFvmcfSMwJokgYio4Ad9fnisOK5rD+nCrnQ54quxcb0tokE7A9C
 +6xgOYYOORo9dk8GqfxLrsjQ3Bo7Wt5jC9x4gPAzREy+PNQPEB2iB4fUdHnMqgGxCV4L
 yxwt15YVOLY1q1u6uXweOoxhwg0lUU6RlU6RvVYJ4Pnusflug+LNtuBCD/rBI8748/Oc
 ZW/+Q7XFfxnNAUVQq2oHyRhqqEYnLTGLU97pG0W5LfJGhf+awVlugtrPlcu9iJVKmetw
 KoWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtSirnr1nTCM5ktiJUEdwaNXdQlur/Qo/evFVWHEv2aNzbj3wbzgeYxkpShK/L3cRct7p8jESkCd1IpA==@nongnu.org,
 AJvYcCXWjkAkN+aJaESwBliwSpAUVgcme1LJGtC6CE+6C8V7QQPUXfxHu98iZy0RABJip2wDXfDAQ+Ie0bV7@nongnu.org
X-Gm-Message-State: AOJu0YxJb3KeNGZTS3wH9jpCgHtnn/FKb+HWl8rv49Vimg5YH3Wdfl9p
 xW4TbdSwCSZflMvTkDc9PnycGPCXX10TAkgUZAsZ5kuVXOBPlC999NmEZD25yjtUOcH40ivkbXn
 dgOaNVCYvXYvd5QODj23KyPUTqRBLGgE=
X-Gm-Gg: ASbGnctO5EhmxWAWia9u2mTUe740ZssOFo8TG8Fmcd9K3d19AsZzBn/HmLdllcQ3wn5
 yDh0HlSr/rSyB689kJIj6OtEHLPpg9bCtbaE/pdAbBmMsUOHcSL8pF92sh//leP1ELWgtpl7Iwz
 86tFsz2XTvjm3OIoWS8CNm7qoavtZb4cpTTsua8lbLicpNSNUYHnToZCkeYXLWyCNrKcSC6nqdE
 A==
X-Google-Smtp-Source: AGHT+IFjNnwaoiQ3IoSAXWXaGky8MgKs9gicP6qu4hgSWRmDXMZbDXkYGRRoeIZlUDlNSgjtkN6unuy1ErI1KW/I08E=
X-Received: by 2002:a05:6102:d8e:b0:4e6:d7af:a7b1 with SMTP id
 ada2fe7eead31-4ee4f6a056emr10234852137.10.1751325829946; Mon, 30 Jun 2025
 16:23:49 -0700 (PDT)
MIME-Version: 1.0
References: <20250616150034827wuHs_ffe3Qm8cqFXT7HeW@zte.com.cn>
In-Reply-To: <20250616150034827wuHs_ffe3Qm8cqFXT7HeW@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 1 Jul 2025 09:23:24 +1000
X-Gm-Features: Ac12FXwF2xOEvf6BhMb7rNdLuogvOGBRb5p6eoD8c1n37_bUknr_sGacLyTtTLY
Message-ID: <CAKmqyKP-edaygvvoW+=j4mRBT3YNs8Q++EHH0nDNY=qmhqJq5g@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] migration: Fix migration failure when aia is
 configured as aplic-imsic
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Mon, Jun 16, 2025 at 5:02=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> Address an error in migration when aia is configured as 'aplic-imsic' in
> riscv kvm vm by adding riscv_aplic_state_needed() and
> riscv_imsic_state_needed() to determine whether the corresponding sates a=
re
> needed.
>
> Previously, the fields in the vmsds of 'riscv_aplic' and 'riscv_imsic' ca=
n
> only be initialized under certain special conditions in commit 95a97b3fd2=
.
> However, the corresponding ses of these vmsds are inserted into the
> savevm_state.handlers unconditionally. This led to migration failure
> characterized by uninitialized fields when save vm state:
> qemu-system-riscv64: ../migration/vmstate.c:433: vmstate_save_state_v:
> Assertion 'first_elem || !n_elems || !size' failed.
>
> Fixes: 95a97b3fd2 ("target/riscv: update APLIC and IMSIC to support KVM A=
IA")
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  Changes in v3:
>  - Increase version_id and minimum_version_id
>
>  hw/intc/riscv_aplic.c | 12 ++++++++++--
>  hw/intc/riscv_imsic.c | 10 ++++++++--
>  2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8bcd9f4697..4fa5f7597b 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -962,10 +962,18 @@ static const Property riscv_aplic_properties[] =3D =
{
>      DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>  };
>
> +static bool riscv_aplic_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    return riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
>  static const VMStateDescription vmstate_riscv_aplic =3D {
>      .name =3D "riscv_aplic",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
> +    .needed =3D riscv_aplic_state_needed,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_UINT32(domaincfg, RISCVAPLICState),
>              VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> diff --git a/hw/intc/riscv_imsic.c b/hw/intc/riscv_imsic.c
> index 2169988167..6174e1a05d 100644
> --- a/hw/intc/riscv_imsic.c
> +++ b/hw/intc/riscv_imsic.c
> @@ -398,10 +398,16 @@ static const Property riscv_imsic_properties[] =3D =
{
>      DEFINE_PROP_UINT32("num-irqs", RISCVIMSICState, num_irqs, 0),
>  };
>
> +static bool riscv_imsic_state_needed(void *opaque)
> +{
> +    return !kvm_irqchip_in_kernel();
> +}
> +
>  static const VMStateDescription vmstate_riscv_imsic =3D {
>      .name =3D "riscv_imsic",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 2,
> +    .needed =3D riscv_imsic_state_needed,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_VARRAY_UINT32(eidelivery, RISCVIMSICState,
>                                    num_pages, 0,
> --
> 2.27.0
>

