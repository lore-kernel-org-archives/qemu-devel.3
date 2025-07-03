Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C5C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 23:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXTUs-0000rO-H6; Thu, 03 Jul 2025 19:37:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTUr-0000r3-39; Thu, 03 Jul 2025 19:37:41 -0400
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXTUp-000283-C0; Thu, 03 Jul 2025 19:37:40 -0400
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-88131f0badcso199527241.2; 
 Thu, 03 Jul 2025 16:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751585857; x=1752190657; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CiH0dO9xaQS0h7mvAzmMvteIkFQrlKpWzGvGxcCJ7Kw=;
 b=lq10Xfrqcdt5EH93cLeplAgTGgK3464L3iPbd0SJ2fISJNCgM67apAD2xeg+kXYaP6
 7JSrO5FPh7s5H/B/LB2vatfOFE8KXna7+8vxmHWCBzSwTf5fYPbICeVjDs2rU2epX/Sp
 KawMpHI7MlB7M8WE1Fy5m4jZYJdgkyiCl6iYvkxEEBixV1hSUuc6RAwoeqvdqOD45T55
 8bCeEjfxnoPWZBm6O6+DPM3T1lQIPk3xfbDkgdcI2pYR5bJKxFMqYadoHdF3D1gUZsex
 zwlksjrKg7+YW/FtxC2HVI139C5N4PNumjH2RKrCRqd/QYoDqJczIxzfm+ihb9r9By74
 LwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751585857; x=1752190657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CiH0dO9xaQS0h7mvAzmMvteIkFQrlKpWzGvGxcCJ7Kw=;
 b=wNXkgnhs47YcVk0N8ZUQ8/jAPPKJTqE/PmHBBFc08zJACjBuQKiVJNJkXdnURiy6oH
 8QzNl+gOLZZdsuvcK4c6GJmzbent/HGMKmMPamyKy/kqpSen8NM0382MV3/RJ9tXZcyV
 Miz0DzlwCmhSuKWjonBII65SP4mBKK0AUET8/wc5qdl7yHAueEcRmvvATayI/rcufDOW
 CUSmouSdsvQViXsLIruL+3GjPELIShSvd6RPc0zImTJ95AMWCuAqIKnNuLAsSLtz7r9l
 xsDdkLE7Z+PxfaauDzalbfwBkboX4Wx7NBrm7J4IfTII2gpSjHbUHzKfjdTjBnCl59xl
 NeTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtMVKLhGJxjNCvM3d1vXv9C0chN0CaBtF+qYLDPd+xQiVfFMYMso3N3NEn2f8nMbhubNoDuvQMDgt7LA==@nongnu.org,
 AJvYcCW2yhWBHL1FJrstkRhmtlfavttSrMs+WGveE3RP6toGYERf+uTuENMp05nkx9p4Wh49WMmIUwEGk6C+@nongnu.org
X-Gm-Message-State: AOJu0YwzsnWDKQF8UW+LpTRDagQtFeztewtUnunCYO9AHfIgEmlHKdPm
 z/5uoaFnY7YggyDdzFLBbXBfRq1xN0cLD9Go1dv17cUdE4pbpjfzsZ+Hp9uBcrpZUEejr2wwbW8
 FzYeTbdqfX6dtFN50Iz4FoIKj8CGRNUM=
X-Gm-Gg: ASbGnctp3YA1W7I2eEXPIHQwPn3mv6Qly6CDAMz3am65FhnNlc4WMvmZ8OVjrG4+FDo
 MeQHdoJqJ7YaSUKdKqKLmfdpcc8oZheBQSnzlSpWAdmZIJkIVt+0ID0szKc0Qb7L75zhMExRpJn
 Fkar35Sl8NJuUFhJC4J9guv7jit4mM/mHHWgjT7hubpu8Tyc9OV0LpGfjmyrfa2TOEzQ1Kt5U4d
 w==
X-Google-Smtp-Source: AGHT+IFOAaSaetZ/yXLzkES+BWGx+GHMN+a8ko9QX+qiJ8vev8NzSSK/e6Nt4LcOg9TSSiFQqfljcIexkPp5zJ8liSA=
X-Received: by 2002:a05:6102:8029:b0:4e5:c51b:ace4 with SMTP id
 ada2fe7eead31-4f2f23fccd0mr7396137.20.1751585857487; Thu, 03 Jul 2025
 16:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250616150034827wuHs_ffe3Qm8cqFXT7HeW@zte.com.cn>
In-Reply-To: <20250616150034827wuHs_ffe3Qm8cqFXT7HeW@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 09:37:11 +1000
X-Gm-Features: Ac12FXx3D1FLgn8PayxMzOH4IWuyH3lvX508uZp6_k-yiMAYZL_LW3PNktkuPR4
Message-ID: <CAKmqyKPZTp3HGU3xAwQRv5KDFpoYALqgWwEr8Ut2h4ShmKKnsw@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] migration: Fix migration failure when aia is
 configured as aplic-imsic
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

