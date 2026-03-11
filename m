Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714D9103E2F6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 23:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0TMP-0000RZ-VT; Wed, 11 Mar 2026 19:53:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TMN-0000QS-Va
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:53:04 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w0TML-0005Ll-R3
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 19:53:03 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66281b1018bso652379a12.2
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 16:53:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773273179; cv=none;
 d=google.com; s=arc-20240605;
 b=a6DAadNQKTipm4fRIgDgXh2T7pzV4+s3oZHSTAgMwg/h/tz2pRg2mTowZyQgLksTex
 5Tq5szde87itduw/o6OFl7jXBCq0vYyquzfE1PDKFXgl8Tz2aIn3b1/W4sJxrdxwOjCb
 W+c+vKc07/8tPe7Y2SuW+IU4fniHw7gT6Sykl6dODlBn9IKMY1+NXIYUedunkSi150gc
 pD/ybVmEDOgpE+N0b8C/dg0mBbWKKgGsmU0Kjb0CadYF44uM1BQ/c2np4k/wi9cI6mhQ
 FW+HnPxJs84IK0IttBbwsnYC9qp4A+I6AT+V2O/xGYN8VpzwTfGGbTVWGTVU1AtQhNvn
 850A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UhQHjF9q+p9fGzU2JUO7c8QZS+lzIAIkim+ngfBvEpk=;
 fh=EA5lNrskj9eU3tms1wug88iqibitgV3nbmnd6m7O+eA=;
 b=EnQPXtRH02rb3Tz0Ogt0WMPBG7Nkwji0be02Pc4M9Z3LwoyFqGTEMyZTge5na4nK6n
 Bzu4RvrfuS5gDrnBwVnXZb1VQSdrMkFyrbeyJ8rnfNElxiHHA4QgSL45U0Hsts4M+E30
 0/Bsn8y+61J0YA+6cXx6dD4gZy8m/d8UjfzGrvl8DandScn+FEScSMo67/lx1Weq9cRg
 ksKPC0kSpoQY0Sjhz6s85UgUP4Qn82rHrfAlJTDXQQiwghiVZTajCQU6NWRb4jeBZcsc
 Hwb3y4cABQ/ZpkkTQMpmwR53iX1z389YM2I2utX0/BnGsImgttQgLqZm+1X9IyoWK8RM
 pDLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773273179; x=1773877979; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UhQHjF9q+p9fGzU2JUO7c8QZS+lzIAIkim+ngfBvEpk=;
 b=YhXVrFi5MnVaNkMC6zuxhzTAuKUn7yQTGAkA5hTZF3+XH9qLBhA8ZJLwYU9Kzroe8z
 PfaJ1u1u8K6CRB65UnJ02HPUajPTsEMT58zZRdbMfz+rx029C5cUZC1xwq777ZFFbJ2M
 iXHbyvAjNfoAiwbpyC9Y09PRHA/UH6cv21U0aqjjWscQfqnPBvCKMkG0u1+dr4DKMa9g
 QZAYt/r9RFLgKM+aK8mUVbBBrQynab4moA3lsMOLBFA1UeIu0CuR4jy6WCQQnX3V5K0H
 HyIp+I1dmunUhhY6UFmykyvnHo+/Vx9wk0tn/bduajgRLxkWjJQqfadiId4GZSJHJeNX
 RVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773273179; x=1773877979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UhQHjF9q+p9fGzU2JUO7c8QZS+lzIAIkim+ngfBvEpk=;
 b=lLPryqVXHciIrgWQGnOEsofbLeDlAUGPaFcLoUtCWYar7zuMIbb8CLxHzPlveiimhf
 K8cbMSmAxLRCZ1xMeRk/D/IKlOG13E+J1P7FKzciPNoGYQCV6OvcXk4T0OQNzVzBjL7O
 Y0vGHIu+8vfcUb+Qulu66y67Ef4K1jD889XVcWZP3mAu+yhfaJcOE62BzVN3zsNVpdD+
 0n2SLW5czPUMkDy3E1IPKTIm34JwlqLyZydsxvpjfN5f5qx9uFKx1IxbsspApLa45E2y
 gxje8PvSjZrV3rbrXbIizLzUrhkMdrurCGCpWUktRUFX6Qpg8A8P8JURqSP9nMGKQhO5
 AQ0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpZtAYiU/wjegZOXYdpLBtRM+chZrrurbmw4lZHcif2Av1mRRxJn5PnPjFMBn7zLiwhSixKVyx6OQL@nongnu.org
X-Gm-Message-State: AOJu0Yzm/dDrBTNxt5mLKOpNyBq5EKiM7zAH8dhiU+oZQLZ4MGebOr5t
 ZrFhbROFrx8R2hAwnNR6Cqk4YZweSDLE1BT5Q5o/tPcTtvksg31dHNHJrarg6mkaM37XamLG4bu
 Z/7ixv/fWEDIjI877q/2TY0NDSqgUSKE=
X-Gm-Gg: ATEYQzxqtdd4zCrfW2tjR94yM9bBGSW9/2fSZWvgBqXhVeTE5LGMl6qI2Gsx8Zl3W22
 Hs447PAFcGhD76iS6w33zOZhI+gkA+bkLkshcfNLJV/CXDKjwlVXRMTmwLhVqMMkPdpQ2I7P3V/
 x1qAKoPHbutCt2DcNw6v6KE4DIEzluq5PyOGxE0RyEuH2kNoPZVPYu1ZdhgO5YvX9ZiI1rzLT6f
 ieW+PRxilDPD+lg21R/h3xyUacHdb+p3k+nmtTVdcJIUKdyw9XznERYcBUpT0EkKKAqGljRdJo4
 ixA0TkJVRt/udo8iArKjzeffTTQFNcuYWl737g==
X-Received: by 2002:a05:6402:1471:b0:661:39a2:f530 with SMTP id
 4fb4d7f45d1cf-663196d11a0mr2525808a12.12.1773273179314; Wed, 11 Mar 2026
 16:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260305171729291ZzfxmqZ48P2Tbz9TGCtST@zte.com.cn>
 <20260305172234066xnMiqu5iMbkRnaOh-pYss@zte.com.cn>
In-Reply-To: <20260305172234066xnMiqu5iMbkRnaOh-pYss@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 12 Mar 2026 09:52:33 +1000
X-Gm-Features: AaiRm51Rm4j932eYjsHOKSWgkKuDiF1b-1orb56ofExc6VSSGMaPYeyEJ5PDRLk
Message-ID: <CAKmqyKMQecb6Of2G-BNa-sx3tHKNv1JbY7L+DjY9bDSZLBsntQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v2_2=2F3=5D_hw=2Fintc=2Friscv=5Faplic=3A_Add_in=2Dkerne?=
 =?UTF-8?Q?l_aplic_save_and_restore_function=C2=A0=C2=A0?=
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, peterx@redhat.com, 
 farosas@suse.de, chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
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

On Thu, Mar 5, 2026 at 7:24=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Add save and restore function if riscv_use_emulated_aplic return
> false, it is to get and set APLIC irqchip state from KVM kernel.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aplic.c         | 200 ++++++++++++++++++++++++++++------
>  include/hw/intc/riscv_aplic.h |   4 +
>  2 files changed, 173 insertions(+), 31 deletions(-)
>
> diff --git a/hw/intc/riscv_aplic.c b/hw/intc/riscv_aplic.c
> index 8f70043111..88b79e9ab2 100644
> --- a/hw/intc/riscv_aplic.c
> +++ b/hw/intc/riscv_aplic.c
> @@ -922,14 +922,7 @@ static void riscv_aplic_realize(DeviceState *dev, Er=
ror **errp)
>          }
>
>          aplic->bitfield_words =3D (aplic->num_irqs + 31) >> 5;
> -        aplic->sourcecfg =3D g_new0(uint32_t, aplic->num_irqs);
>          aplic->state =3D g_new0(uint32_t, aplic->num_irqs);
> -        aplic->target =3D g_new0(uint32_t, aplic->num_irqs);
> -        if (!aplic->msimode) {
> -            for (i =3D 0; i < aplic->num_irqs; i++) {
> -                aplic->target[i] =3D 1;
> -            }
> -        }
>          aplic->idelivery =3D g_new0(uint32_t, aplic->num_harts);
>          aplic->iforce =3D g_new0(uint32_t, aplic->num_harts);
>          aplic->ithreshold =3D g_new0(uint32_t, aplic->num_harts);
> @@ -941,6 +934,19 @@ static void riscv_aplic_realize(DeviceState *dev, Er=
ror **errp)
>          if (kvm_enabled()) {
>              aplic->kvm_splitmode =3D true;
>          }
> +    } else {
> +        aplic->nr_words =3D BITS_TO_U32S(aplic->num_irqs);
> +        aplic->setip =3D g_new0(uint32_t, aplic->nr_words);
> +        aplic->clrip =3D g_new0(uint32_t, aplic->nr_words);
> +        aplic->setie =3D g_new0(uint32_t, aplic->nr_words);
> +    }
> +
> +    aplic->sourcecfg =3D g_new0(uint32_t, aplic->num_irqs);
> +    aplic->target =3D g_new0(uint32_t, aplic->num_irqs);
> +    if (!aplic->msimode) {
> +        for (i =3D 0; i < aplic->num_irqs; i++) {
> +            aplic->target[i] =3D 1;
> +        }
>      }
>
>      /*
> @@ -968,47 +974,179 @@ static const Property riscv_aplic_properties[] =3D=
 {
>      DEFINE_PROP_BOOL("mmode", RISCVAPLICState, mmode, 0),
>  };
>
> -static bool riscv_aplic_state_needed(void *opaque)
> +static bool riscv_aplic_emul_state_needed(void *opaque)
>  {
>      RISCVAPLICState *aplic =3D opaque;
>
>      return riscv_use_emulated_aplic(aplic->msimode);
>  }
>
> +static const VMStateDescription vmstate_riscv_aplic_emul =3D {
> +    .name =3D "riscv_aplic_emul",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D riscv_aplic_emul_state_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +                              num_irqs, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> +        VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> +        VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> +                              num_harts, 0,
> +                              vmstate_info_uint32, uint32_t),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static bool riscv_aplic_in_kernel_state_needed(void *opaque)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    return !riscv_use_emulated_aplic(aplic->msimode);
> +}
> +
> +static int riscv_aplic_in_kernel_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        for (uint32_t i =3D 0; i < aplic->nr_words; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIP_BASE + i * 4,
> +                                     aplic->setip + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_CLRIP_BASE + i * 4,
> +                                     aplic->clrip + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIE_BASE + i * 4,
> +                                     aplic->setie + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_in_kernel_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        for (uint32_t i =3D 0; i < aplic->nr_words; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIP_BASE + i * 4,
> +                                     aplic->setip + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_CLRIP_BASE + i * 4,
> +                                     aplic->clrip + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SETIE_BASE + i * 4,
> +                                     aplic->setie + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static const VMStateDescription vmstate_riscv_aplic_in_kernel =3D {
> +    .name =3D "riscv_aplic_in_kernel",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D riscv_aplic_in_kernel_state_needed,
> +    .pre_save =3D riscv_aplic_in_kernel_pre_save,
> +    .post_load =3D riscv_aplic_in_kernel_post_load,
> +    .fields =3D (const VMStateField[]) {
> +            VMSTATE_VARRAY_UINT32(setip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(clrip, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_VARRAY_UINT32(setie, RISCVAPLICState,
> +                                  nr_words, 0,
> +                                  vmstate_info_uint32, uint32_t),
> +            VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int riscv_aplic_pre_save(void *opaque)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMA=
INCFG,
> +                                 &aplic->domaincfg, false);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENM=
SI,
> +                                 &aplic->genmsi, false);
> +
> +        for (uint32_t i =3D 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, false);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, false);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +static int riscv_aplic_post_load(void *opaque, int version_id)
> +{
> +    RISCVAPLICState *aplic =3D opaque;
> +
> +    if (!riscv_use_emulated_aplic(aplic->msimode)) {
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_DOMA=
INCFG,
> +                                 &aplic->domaincfg, true);
> +        kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC, APLIC_GENM=
SI,
> +                                 &aplic->genmsi, true);
> +
> +        for (uint32_t i =3D 1; i < aplic->num_irqs; i++) {
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_SOURCECFG_BASE + (i - 1) * 4,
> +                                     aplic->sourcecfg + i, true);
> +            kvm_riscv_aia_access_reg(KVM_DEV_RISCV_AIA_GRP_APLIC,
> +                                     APLIC_TARGET_BASE + (i - 1) * 4,
> +                                     aplic->target + i, true);
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_riscv_aplic =3D {
>      .name =3D "riscv_aplic",
> -    .version_id =3D 3,
> -    .minimum_version_id =3D 3,
> -    .needed =3D riscv_aplic_state_needed,
> +    .version_id =3D 4,
> +    .minimum_version_id =3D 4,
> +    .pre_save =3D riscv_aplic_pre_save,
> +    .post_load =3D riscv_aplic_post_load,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_UINT32(domaincfg, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(mmsicfgaddrH, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(smsicfgaddrH, RISCVAPLICState),
>              VMSTATE_UINT32(genmsi, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddr, RISCVAPLICState),
> -            VMSTATE_UINT32(kvm_msicfgaddrH, RISCVAPLICState),
> -            VMSTATE_VARRAY_UINT32(sourcecfg, RISCVAPLICState,
> -                                  num_irqs, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(state, RISCVAPLICState,
> +            VMSTATE_VARRAY_UINT32(sourcecfg , RISCVAPLICState,
>                                    num_irqs, 0,
>                                    vmstate_info_uint32, uint32_t),
>              VMSTATE_VARRAY_UINT32(target, RISCVAPLICState,
>                                    num_irqs, 0,
>                                    vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(idelivery, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(iforce, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
> -            VMSTATE_VARRAY_UINT32(ithreshold, RISCVAPLICState,
> -                                  num_harts, 0,
> -                                  vmstate_info_uint32, uint32_t),
>              VMSTATE_END_OF_LIST()
> -        }
> +    },
> +    .subsections =3D (const VMStateDescription * const []) {
> +        &vmstate_riscv_aplic_emul,
> +        &vmstate_riscv_aplic_in_kernel,
> +        NULL
> +    }
>  };
>
>  static void riscv_aplic_class_init(ObjectClass *klass, const void *data)
> diff --git a/include/hw/intc/riscv_aplic.h b/include/hw/intc/riscv_aplic.=
h
> index c7a4d4ad01..1976bea68c 100644
> --- a/include/hw/intc/riscv_aplic.h
> +++ b/include/hw/intc/riscv_aplic.h
> @@ -53,6 +53,9 @@ struct RISCVAPLICState {
>      uint32_t *idelivery;
>      uint32_t *iforce;
>      uint32_t *ithreshold;
> +    uint32_t *setip;
> +    uint32_t *clrip;
> +    uint32_t *setie;
>
>      /* topology */
>  #define QEMU_APLIC_MAX_CHILDREN        16
> @@ -66,6 +69,7 @@ struct RISCVAPLICState {
>      uint32_t num_harts;
>      uint32_t iprio_mask;
>      uint32_t num_irqs;
> +    uint32_t nr_words;
>      bool msimode;
>      bool mmode;
>
> --
> 2.27.0
>

