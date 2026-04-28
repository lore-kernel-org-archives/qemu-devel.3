Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A0E7FF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:50:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYW1-0007J1-Ug; Mon, 27 Apr 2026 22:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYVv-0007II-Eq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:49:32 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYVt-0006zV-SP
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 22:49:31 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ba699316b42so1366633566b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 19:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777344567; cv=none;
 d=google.com; s=arc-20240605;
 b=Y3hUmU5l8Bl52L1ZSvA6Etvql7AlXeaeKP84JczN2U+2skO/otx0Hg9UL/dcyzC6XK
 mF8vnRO2NaYQw/+ZIW36jIkv+Qm5Z2jOQnSdPEOMWGeWBEXCQEGzSbpAImvcKE0qhEVs
 U6UbszeSEt3wAxJQUcgRSwCqxafo/qMnVmk7BZ/xoTc0jXbhB7Qjbvfth839u5JmxD47
 1bq7TeHsVYiJArngPKPSMVa7qOdVGpQ4QGNTI2I8G6lV2B59xsapI6dko50M38l/2BN4
 h10ZGIJQJnqIl4tCgeuEjwjweaXlfLoOXE8GpIw1jUz+3+9uAu619x4HANC0uyAGrUpN
 G6bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F00nuTXfBPVuxAOdquX0HKD5wVe8JDg9gyFIPzr6zXg=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=CvJA3NhK6SMDDMbjkxnfj5ZK6KEELZiw0MESqH+Ui1U55nbNBwaZtNgstXW/Naql6F
 tfeDMULAvaZ8kNd3ohhArKj2ficKFQs8YJA9ZQftDCqyM1ly83ypb38+70Po9MLaVGrB
 TAOihpc02aNG6+AlkXprjEVX9FnyZWWHjMUrwYiMfbBR700NxDmSvV4ncP7OdVytMBSa
 VPBzAbMobNH6UbnyEDJ2gvODeo33o4g5jkVyiGLg6ovQMI0vbWxXISce+6RAnGhIrSRV
 gYbUqjBD8ZTxKqmI6rBN+pRcbas9LnjIKb4a5YHFqvvXuwU3dyQgn+j6M7s08jqM+ome
 CwQA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777344567; x=1777949367; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F00nuTXfBPVuxAOdquX0HKD5wVe8JDg9gyFIPzr6zXg=;
 b=MSuJr8e6Sr0837J1GBR/AOwIrux7PtpGHRP58X2EUReeWrdJ9Yn6UVXd+vpvnmDTTC
 FeALz2GqknOqLeiQ4JWtUm6kWRc8Rmol+V4vMX0iAYfOwXq1nOIkzXLGsWU8cH4FBrxp
 REg5YI95fY9gSrKG3Qvj/Hta/vEoAkIkRhQGzioIPC5Zqyk7J+dOjW5WmfAfjr6HyLy/
 P9vCojtzJ/e9GuCAGvCl0vJIJtvK6vcRMNV/lTlwWGnc2a4N6ZosbIxOBbI5C6UdaPkb
 nIspWw1gcgeg2bniX/TAs5nBw3LFCHCT2iyzrnUGmbB+/LoL1sAiNmnAB1Bakh444Sr+
 vLRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777344567; x=1777949367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F00nuTXfBPVuxAOdquX0HKD5wVe8JDg9gyFIPzr6zXg=;
 b=R2L3a5LvMONkbS12IKAKWmyJ1l4TwaLW0Sw5+3sA6+ah0B7V5uoP6/ZsljP80Ugk+f
 9Tc5CS6AgDeIy/rCW0VmYMUL4N6g+aS6baLgInR8c7XDx31WsyFMJtpu1PHd+Toj82HY
 jp/7JDyc6Hv8u2fW+FXHXCFnOhtd3ZvQEITPI56CPWVUhvvK9aS/uIWjVg8607vRZAno
 HMLPMY0cVSyMMpF1bLVsNBUyIgJA8bEFB9Sy7p5vxLnOd0b7e2a+Hqyn6Al+IkiKmoxx
 XM6Txwsp+Rej9Zy5qYHJjngCUPBB2MpYtkoq1Qck4XZUBNZo6dArQrb5HYue9JmK32Hq
 m+aA==
X-Gm-Message-State: AOJu0YzRXrrGjOguZK0sN4wezV82EGTe6sxxET1YjquyN4PsThpG/VMM
 uWsQb6FXfuyzBdlRZzS7kmNpma781wo5Dnx2f1mMB1y9Rfg7BJln9k2j+ZIn1rzv7zl8ymbmiW8
 tpBKf4urTZv6NUJ+OwGcCUhWKb926OSI=
X-Gm-Gg: AeBDieu803F0wDuIMrhwbVdHWq3mgtutIF3qnOuWp+vfPIMIpDkI6zalQVUM7XKKS/8
 oMn+akc5BSEBuMLxkQ840Ig4CLmMUeXZFjV7YRJTPG3isdA1HXyCMDktPk/UAxwo60F/1xYkMYW
 tsr1gVQHoivx6CBn+5/wSZilAIr/jiWJ2peVmeM6loLlg1WTbKNcXD5LFvVVtof//BWogHrigbw
 PgKsP+HcsV4XuhM/bmgWTtMA9r9DfiDh/eXGLVo5pHR2GNAGe4dWO+Q0b3SOmepGOh/Z1wPvwn7
 JBsK6dVsF7igNCtmcjSPbZflHZL4Gc6DOzg/LeaS7VcrP0Us
X-Received: by 2002:a17:906:518e:20b0:ba6:8e19:a50a with SMTP id
 a640c23a62f3a-bb801ad05e9mr47646466b.12.1777344566568; Mon, 27 Apr 2026
 19:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
 <20260421093715.2995067-3-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-3-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 12:48:59 +1000
X-Gm-Features: AVHnY4J-KfTHECYbNgsDP2R4ZACPmkXmfD0-dYA7TMelOHa8XIWLeHq0Ncp8tCw
Message-ID: <CAKmqyKMQesH-M8Xj95RMXoQRg3583UKwXy2sjzR5u3riKW_KzQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/6] target/riscv: Add a helper to return the current
 effective priv mode
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
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

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> This helper returns the current effective privilege mode.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h        | 37 +++++++++++++++++++++++++++++++++++++
>  target/riscv/cpu_helper.c | 15 +++++----------
>  2 files changed, 42 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4c0676ed53b..672f0dab0fb 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -806,6 +806,43 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *=
env)
>  }
>  #endif
>
> +/*
> + * Returns the current effective privilege mode.
> + *
> + * @env: CPURISCVState
> + * @priv: The returned effective privilege mode.
> + * @virt: The returned effective virtualization mode.
> + *
> + * Returns true if the effective privilege mode is modified.
> + */
> +static inline QEMU_ALWAYS_INLINE
> +bool riscv_cpu_eff_priv(CPURISCVState *env, int *priv, bool *virt)
> +{
> +    int mode =3D env->priv;
> +    bool virt_enabled =3D false;
> +    bool mode_modified =3D false;
> +
> +#ifndef CONFIG_USER_ONLY
> +    if (mode =3D=3D PRV_M && get_field(env->mstatus, MSTATUS_MPRV)) {
> +        mode =3D get_field(env->mstatus, MSTATUS_MPP);
> +        virt_enabled =3D get_field(env->mstatus, MSTATUS_MPV) && (mode !=
=3D PRV_M);
> +        mode_modified =3D true;
> +    } else {
> +        virt_enabled =3D env->virt_enabled;
> +    }
> +#endif
> +
> +    if (priv) {
> +        *priv =3D mode;
> +    }
> +
> +    if (virt) {
> +        *virt =3D virt_enabled;
> +    }
> +
> +    return mode_modified;
> +}
> +
>  static inline bool riscv_cpu_allow_16bit_insn(const RISCVCPUConfig *cfg,
>                                                target_long priv_ver,
>                                                uint32_t misa_ext)
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 659150c6462..513bad21afa 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -45,19 +45,14 @@ int riscv_env_mmu_index(CPURISCVState *env, bool ifet=
ch)
>  #else
>      bool virt =3D env->virt_enabled;
>      int mode =3D env->priv;
> +    bool mode_modified =3D false;
>
>      /* All priv -> mmu_idx mapping are here */
>      if (!ifetch) {
> -        uint64_t status =3D env->mstatus;
> -
> -        if (mode =3D=3D PRV_M && get_field(status, MSTATUS_MPRV)) {
> -            mode =3D get_field(env->mstatus, MSTATUS_MPP);
> -            virt =3D get_field(env->mstatus, MSTATUS_MPV) &&
> -                   (mode !=3D PRV_M);
> -            if (virt) {
> -                status =3D env->vsstatus;
> -            }
> -        }
> +        mode_modified =3D riscv_cpu_eff_priv(env, &mode, &virt);
> +        uint64_t status =3D (mode_modified && virt) ? env->vsstatus :
> +                                                    env->mstatus;
> +
>          if (mode =3D=3D PRV_S && get_field(status, MSTATUS_SUM)) {
>              mode =3D MMUIdx_S_SUM;
>          }
> --
> 2.43.0
>
>

