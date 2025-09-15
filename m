Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA922CA0EE8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 01:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uxyOR-0006gi-Qx; Sun, 14 Sep 2025 21:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxyOI-0006e0-6v
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 21:52:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uxyO2-0003U1-NS
 for qemu-devel@nongnu.org; Sun, 14 Sep 2025 21:52:24 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b0418f6fc27so622051166b.3
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 18:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757901120; x=1758505920; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqmgw6yw863S+JEZhpJI5nXVJoZKOzradCBjcW1lB+k=;
 b=JeIZBpS9vFJog0Nz5dNSpKZRyTaLEzm/FmzHi9ZauD9ca/LMky8drLABP/Ig5ITJPk
 TANeOreJ/RGZdtFZbJq1oS4zHft0BvYeN8g7ap50NFdu/v4DvxoEkQJD0JeiENAwsHtz
 3SZtzyE+vZpMmOG6K2H3Ebn/0cpNkaG8rj4UbhFM9HL9aEY481H4y+BJ31gKC7mgwbQh
 fs8lMtxEcb9QYJrpd32F0FuHoiSQEHijQsGbBYJY6coYp7ac4k3Y0mkiq4dtbb+Fs3aI
 ftwps6p56mPdyOBia/rkRpcX3s7wsa53gUQgZkNkJFohTcdVqjoTQfeSH5IhTKASLQJW
 QbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757901120; x=1758505920;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iqmgw6yw863S+JEZhpJI5nXVJoZKOzradCBjcW1lB+k=;
 b=t84GaegpPjw/gAN45Kx1q0djBs/x1DbXUKGTGWXsegWqhAkcR0x9saVn5vmlzMrWu0
 gYCNBMKoyZ0rzzvbz007yKyr6B34ZzOwTUDVP7tYWKMEVZu9uT0B86fRzOhNa8NmOiBg
 gx6EpaSJvif43ta+n4l6gcX0xTN89fcXTrlo+Ws65qVjBgzh0aMN8WLIbDiD0fqDQ7zo
 v+AEjnUckPrylXHtUVcOZ7jzwP04+Yaxm4JT0peLREarIlGBivgciKsfFcDksm57+3/x
 qNSi/0M4SiYDZKEjK2dYVgKYYamwo6lQyDp9spFsoc4XXSKvOBm21DtAADmxKY4zTdmL
 k4CQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQwLk1kVG7KmMcoALzulKQfoTyNxon0QVJA1Al3VarJPD699jHMNk7NjOvaYmWLnuMx1qoiDBMCT3k@nongnu.org
X-Gm-Message-State: AOJu0YxZh338yK0jUPBDzREh7EVDgfacV8CM5D4rBScX/IYJ95Iyqyma
 625JpsQaQyRDVMjuFBQfhwY1uA6KthRrNRefHCuSLeObYKq2nEDC1EoIA6PmAlw1iE1QYoz++cn
 Kb9cJXOnup1jymSw/YrIydOc6b0NQzzo=
X-Gm-Gg: ASbGncspgo5Zzc2rMKm1SuDMzDNhQ2/cILQL+2029hykxgGY9aDqRL7VZ6rGi/yVBi1
 DmSs/Vv8tw1caGK2wsqiGtn3uOJuv7Zu5c8ouM+aZMjIv8mqPR1MkvG+J5QzDHlpM9NVNzh6nge
 W6/qf4HVIs5TbxUdqgkHiEEp9KPfnTsobNwlpxPTTUNIAkHdmtgowtZnXVAoIs/JXt00HL+MNFf
 VMDj/Tn0eM2BY2a0LoeY6iBmWCXkFamt0bhHg==
X-Google-Smtp-Source: AGHT+IFXff4JtgnPRRCOjFGDOtdrpSyX+7wrgW1PslY22BLvdFL6RFwurjvmzso0IOWYWoexzXyaaijG9c+0l8D3h3g=
X-Received: by 2002:a17:907:97d2:b0:b04:31c6:a434 with SMTP id
 a640c23a62f3a-b07c324cf12mr1063368666b.0.1757901120152; Sun, 14 Sep 2025
 18:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250811034454.189208-1-z_bajeer@yeah.net>
In-Reply-To: <20250811034454.189208-1-z_bajeer@yeah.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 11:51:33 +1000
X-Gm-Features: AS18NWAtqy7PQixv0DK8JTMvqrzHtODNbbIsgpsWlLFPiyfZyuKHS48pUv0Fod4
Message-ID: <CAKmqyKPwZWmFcKhwC_88tTJ5Fh1hGr6Xn9wB5vjXoQpoWZH8QQ@mail.gmail.com>
Subject: Re: [PATCH v2] aplic: fix mask for smsiaddrcfgh
To: Yang Jialong <z_bajeer@yeah.net>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, yangjialong@rvcore.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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

On Mon, Aug 11, 2025 at 1:59=E2=80=AFPM Yang Jialong <z_bajeer@yeah.net> wr=
ote:
>
> 4.5.4. Supervisor MSI address configuration (smsiaddrcfg and
>   smsiaddrcfgh)
> smsiaddrcfgh:
>         bits 22:20 LHXS(WARL)
>         bits 11:0  High Base PPN(WARL)
>
> Signed-off-by: Yang Jialong <z_bajeer@yeah.net>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/intc/riscv_aplic.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> v1 --> v2:
> - fix calculation of MSI address.
> - In Supervisor mode, lhxw/hhxs/hhxw fields are in mmsiaddrcfgh register.
> - And lhxs field is in smsiaddrcfgh.
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index a1d9fa5085..2dd54cafaa 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -96,7 +96,7 @@
>      (APLIC_xMSICFGADDR_PPN_HHX_MASK(__hhxw) << \
>       APLIC_xMSICFGADDR_PPN_HHX_SHIFT(__hhxs))
>
> -#define APLIC_xMSICFGADDRH_VALID_MASK   \
> +#define APLIC_MMSICFGADDRH_VALID_MASK   \
>      (APLIC_xMSICFGADDRH_L | \
>       (APLIC_xMSICFGADDRH_HHXS_MASK << APLIC_xMSICFGADDRH_HHXS_SHIFT) | \
>       (APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
> @@ -104,6 +104,10 @@
>       (APLIC_xMSICFGADDRH_LHXW_MASK << APLIC_xMSICFGADDRH_LHXW_SHIFT) | \
>       APLIC_xMSICFGADDRH_BAPPN_MASK)
>
> +#define APLIC_SMSICFGADDRH_VALID_MASK   \
> +    ((APLIC_xMSICFGADDRH_LHXS_MASK << APLIC_xMSICFGADDRH_LHXS_SHIFT) | \
> +     APLIC_xMSICFGADDRH_BAPPN_MASK)
> +
>  #define APLIC_SETIP_BASE               0x1c00
>  #define APLIC_SETIPNUM                 0x1cdc
>
> @@ -409,13 +413,8 @@ static void riscv_aplic_msi_send(RISCVAPLICState *ap=
lic,
>          msicfgaddr =3D aplic->kvm_msicfgaddr;
>          msicfgaddrH =3D ((uint64_t)aplic->kvm_msicfgaddrH << 32);
>      } else {
> -        if (aplic->mmode) {
> -            msicfgaddr =3D aplic_m->mmsicfgaddr;
> -            msicfgaddrH =3D aplic_m->mmsicfgaddrH;
> -        } else {
> -            msicfgaddr =3D aplic_m->smsicfgaddr;
> -            msicfgaddrH =3D aplic_m->smsicfgaddrH;
> -        }
> +        msicfgaddr =3D aplic_m->mmsicfgaddr;
> +        msicfgaddrH =3D aplic_m->mmsicfgaddrH;
>      }
>
>      lhxs =3D (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
> @@ -427,6 +426,14 @@ static void riscv_aplic_msi_send(RISCVAPLICState *ap=
lic,
>      hhxw =3D (msicfgaddrH >> APLIC_xMSICFGADDRH_HHXW_SHIFT) &
>              APLIC_xMSICFGADDRH_HHXW_MASK;
>
> +    if (!aplic->kvm_splitmode && !aplic->mmode) {
> +        msicfgaddrH =3D aplic_m->smsicfgaddrH;
> +        msicfgaddr =3D aplic_m->smsicfgaddr;
> +
> +        lhxs =3D (msicfgaddrH >> APLIC_xMSICFGADDRH_LHXS_SHIFT) &
> +            APLIC_xMSICFGADDRH_LHXS_MASK;
> +    }
> +
>      group_idx =3D hart_idx >> lhxw;
>
>      addr =3D msicfgaddr;
> @@ -771,7 +778,7 @@ static void riscv_aplic_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>      } else if (aplic->mmode && aplic->msimode &&
>                 (addr =3D=3D APLIC_MMSICFGADDRH)) {
>          if (!(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
> -            aplic->mmsicfgaddrH =3D value & APLIC_xMSICFGADDRH_VALID_MAS=
K;
> +            aplic->mmsicfgaddrH =3D value & APLIC_MMSICFGADDRH_VALID_MAS=
K;
>          }
>      } else if (aplic->mmode && aplic->msimode &&
>                 (addr =3D=3D APLIC_SMSICFGADDR)) {
> @@ -792,7 +799,7 @@ static void riscv_aplic_write(void *opaque, hwaddr ad=
dr, uint64_t value,
>                 (addr =3D=3D APLIC_SMSICFGADDRH)) {
>          if (aplic->num_children &&
>              !(aplic->mmsicfgaddrH & APLIC_xMSICFGADDRH_L)) {
> -            aplic->smsicfgaddrH =3D value & APLIC_xMSICFGADDRH_VALID_MAS=
K;
> +            aplic->smsicfgaddrH =3D value & APLIC_SMSICFGADDRH_VALID_MAS=
K;
>          }
>      } else if ((APLIC_SETIP_BASE <=3D addr) &&
>              (addr < (APLIC_SETIP_BASE + aplic->bitfield_words * 4))) {
> --
> 2.34.1
>
>

