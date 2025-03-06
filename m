Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A8BC19F32
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 02:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq1Cq-0006Nw-AG; Wed, 05 Mar 2025 21:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1Co-0006NO-2x
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:43:26 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq1Cl-0005w2-Jm
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 21:43:25 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51eb1818d4fso184060e0c.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 18:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741229002; x=1741833802; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bV3RDLkbkbUz0xAOJXg8VVVkrPgV9ceRQzudYvzxgVs=;
 b=G0fRqSy41C+TtXva8dg4NlBkZ+hcXXY3R+sZww+2SLY1uULxG/ze2HSsNm7BbQvyop
 Kbj1BLbK25Lm7/eXauvnqrNFTFgMhY+Pg14g/hOP++kZnrs6KB/8f+uxriEl6y0eGp2u
 s4blrauxOzEThKXJSWnlJEC4ix0CZpkTh+dyY1qpdLZl/IJnrhbKZsq1EbPlRF9mHSBl
 xJ6++FIohR8TbMQwAxfrlAconDyXvSdpl7w5iFa8GGAd1SdJB8MEzUEuHQKPRJNsEnpS
 bIbX8Ujp+AZaXRyr313o1IFIvv19qZ+lKCks7vJbSg75THagkNCWNqtkIVfnAWCbsqdA
 OsBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741229002; x=1741833802;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bV3RDLkbkbUz0xAOJXg8VVVkrPgV9ceRQzudYvzxgVs=;
 b=evhKGICQ8gijD/4H7JX0X+LQBPwLQFVMEOQPFMgOKkXDjJd3Tg4P8rYAm/VqesKc6m
 ALanHWKdpBRw5H6HTpFdYAjr119snh/P0NMi/Mlt6vobTS2OrPV1B08TVdoUc9U8ygqd
 Ml/4V4o9sd+TBPEnuIq4Ur8c2r2bg71DjMl84VZQnnFqEqlPxztOL+wWifpljJBGxZvv
 H515VuoE5nlLu1qm9DUvmuu4E3PI4LWvb3dNfsPc0UBYmtre6sWXxdcjOtBCzYurtouu
 aqVsvAiRSvFMYFs8z13clcHMx/abKtootja+Sk+1B/I4Y8RDzQDOHr3BAwWmJQG3I0iz
 p0xw==
X-Gm-Message-State: AOJu0Yzkdfvj0SFKf54PW/RxtyFBnIvg2LfhVJbfGtbUfgAgHUa24iRn
 cTN6Ao7qBEFyEcUV05xWGpcriP7BtIBg/ztGNNExdF03uDr3MRLA8yMsP2Yq4EJ3ahHFLOcIYZl
 ZA6bD3elBmFNBbL1sTX75sSS2sY8=
X-Gm-Gg: ASbGnctmQThK7KGmN5M3sA6e0Z5lRb/2B1TcWfn17dh4eeHakC0/KF5fazzxwA0ws30
 zAfXyPvYeFtM3hmQVW+er8Ih6OSazTHMIaafh/UxIkV/z9bvFUO8oxz5moipu4VEqEu1v9C+pON
 pNSXglgEQXwI8N9hf7j1e9sA3Rjgw+9hMOWngBsu0jLmWVoWXoUcI+oIqX
X-Google-Smtp-Source: AGHT+IGaYwlfF4z7Iw/VbN6oE2KOiwH/7hpi+TPqIPOZ5fYetvk6kA3Sm5I7H7ts6tltpxjzyN+5sf27ZVeY1LtK/f0=
X-Received: by 2002:a05:6102:508b:b0:4c1:806a:3b44 with SMTP id
 ada2fe7eead31-4c2e273e778mr3930922137.2.1741229002221; Wed, 05 Mar 2025
 18:43:22 -0800 (PST)
MIME-Version: 1.0
References: <20250218165757.554178-1-pbonzini@redhat.com>
 <20250218165757.554178-8-pbonzini@redhat.com>
In-Reply-To: <20250218165757.554178-8-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 12:42:55 +1000
X-Gm-Features: AQ5f1JoqLDYrPypd6rQ_wnxgtXuDhbvPIYpPofA9fh4l5hU3tZD6yFxbXNtQe3A
Message-ID: <CAKmqyKO+-8q2oa9e=UM2SzkFZvvNsqU=yN0QyAp52m_kWtR3Tg@mail.gmail.com>
Subject: Re: [PATCH 7/7] target/riscv: move satp_mode.{map,
 init} out of CPUConfig
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Wed, Feb 19, 2025 at 3:00=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> They are used to provide the nice QOM properties for svNN,
> but the canonical source of the CPU configuration is now
> cpu->cfg.max_satp_mode.  Store them in the ArchCPU struct.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     | 14 ++++++++++++++
>  target/riscv/cpu_cfg.h | 14 --------------
>  target/riscv/cpu.c     | 32 ++++++++++++++++----------------
>  3 files changed, 30 insertions(+), 30 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index f9b223bf8a7..df7a05e7d15 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -492,6 +492,19 @@ struct CPUArchState {
>      uint64_t rnmi_excpvec;
>  };
>
> +/*
> + * map is a 16-bit bitmap: the most significant set bit in map is the ma=
ximum
> + * satp mode that is supported. It may be chosen by the user and must re=
spect
> + * what qemu implements (valid_1_10_32/64) and what the hw is capable of
> + * (supported bitmap below).
> + *
> + * init is a 16-bit bitmap used to make sure the user selected a correct
> + * configuration as per the specification.
> + */
> +typedef struct {
> +    uint16_t map, init;
> +} RISCVSATPModes;
> +
>  /*
>   * RISCVCPU:
>   * @env: #CPURISCVState
> @@ -508,6 +521,7 @@ struct ArchCPU {
>
>      /* Configuration Settings */
>      RISCVCPUConfig cfg;
> +    RISCVSATPModes satp_modes;
>
>      QEMUTimer *pmu_timer;
>      /* A bitmask of Available programmable counters */
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 1d7fff8decd..7b7067d5bee 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -21,19 +21,6 @@
>  #ifndef RISCV_CPU_CFG_H
>  #define RISCV_CPU_CFG_H
>
> -/*
> - * map is a 16-bit bitmap: the most significant set bit in map is the ma=
ximum
> - * satp mode that is supported. It may be chosen by the user and must re=
spect
> - * what qemu implements (valid_1_10_32/64) and what the hw is capable of
> - * (supported bitmap below).
> - *
> - * init is a 16-bit bitmap used to make sure the user selected a correct
> - * configuration as per the specification.
> - */
> -typedef struct {
> -    uint16_t map, init;
> -} RISCVSATPMap;
> -
>  struct RISCVCPUConfig {
>      bool ext_zba;
>      bool ext_zbb;
> @@ -191,7 +178,6 @@ struct RISCVCPUConfig {
>
>  #ifndef CONFIG_USER_ONLY
>      int8_t max_satp_mode;
> -    RISCVSATPMap satp_mode;
>  #endif
>  };
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 86a048b62c5..8ab7fe2e286 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1197,8 +1197,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>          return;
>      }
>
> -    if (cpu->cfg.satp_mode.map =3D=3D 0) {
> -        if (cpu->cfg.satp_mode.init =3D=3D 0) {
> +    if (cpu->satp_modes.map =3D=3D 0) {
> +        if (cpu->satp_modes.init =3D=3D 0) {
>              /* If unset by the user, we fallback to the default satp mod=
e. */
>              set_satp_mode_default_map(cpu);
>          } else {
> @@ -1208,7 +1208,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>               * valid_vm_1_10_32/64.
>               */
>              for (int i =3D 1; i < 16; ++i) {
> -                if ((cpu->cfg.satp_mode.init & (1 << i)) &&
> +                if ((cpu->satp_modes.init & (1 << i)) &&
>                      supported & (1 << i)) {
>                      for (int j =3D i - 1; j >=3D 0; --j) {
>                          if (supported & (1 << j)) {
> @@ -1222,7 +1222,7 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>          return;
>      }
>
> -    satp_mode_map_max =3D satp_mode_max_from_map(cpu->cfg.satp_mode.map)=
;
> +    satp_mode_map_max =3D satp_mode_max_from_map(cpu->satp_modes.map);
>
>      /* Make sure the user asked for a supported configuration (HW and qe=
mu) */
>      if (satp_mode_map_max > cpu->cfg.max_satp_mode) {
> @@ -1238,8 +1238,8 @@ static void riscv_cpu_satp_mode_finalize(RISCVCPU *=
cpu, Error **errp)
>       */
>      if (!rv32) {
>          for (int i =3D satp_mode_map_max - 1; i >=3D 0; --i) {
> -            if (!(cpu->cfg.satp_mode.map & (1 << i)) &&
> -                (cpu->cfg.satp_mode.init & (1 << i)) &&
> +            if (!(cpu->satp_modes.map & (1 << i)) &&
> +                (cpu->satp_modes.init & (1 << i)) &&
>                  (supported & (1 << i))) {
>                  error_setg(errp, "cannot disable %s satp mode if %s "
>                             "is enabled", satp_mode_str(i, false),
> @@ -1327,11 +1327,11 @@ bool riscv_cpu_accelerator_compatible(RISCVCPU *c=
pu)
>  static void cpu_riscv_get_satp(Object *obj, Visitor *v, const char *name=
,
>                                 void *opaque, Error **errp)
>  {
> -    RISCVSATPMap *satp_map =3D opaque;
> +    RISCVSATPModes *satp_modes =3D opaque;
>      uint8_t satp =3D satp_mode_from_str(name);
>      bool value;
>
> -    value =3D satp_map->map & (1 << satp);
> +    value =3D satp_modes->map & (1 << satp);
>
>      visit_type_bool(v, name, &value, errp);
>  }
> @@ -1339,7 +1339,7 @@ static void cpu_riscv_get_satp(Object *obj, Visitor=
 *v, const char *name,
>  static void cpu_riscv_set_satp(Object *obj, Visitor *v, const char *name=
,
>                                 void *opaque, Error **errp)
>  {
> -    RISCVSATPMap *satp_map =3D opaque;
> +    RISCVSATPModes *satp_modes =3D opaque;
>      uint8_t satp =3D satp_mode_from_str(name);
>      bool value;
>
> @@ -1347,8 +1347,8 @@ static void cpu_riscv_set_satp(Object *obj, Visitor=
 *v, const char *name,
>          return;
>      }
>
> -    satp_map->map =3D deposit32(satp_map->map, satp, 1, value);
> -    satp_map->init |=3D 1 << satp;
> +    satp_modes->map =3D deposit32(satp_modes->map, satp, 1, value);
> +    satp_modes->init |=3D 1 << satp;
>  }
>
>  void riscv_add_satp_mode_properties(Object *obj)
> @@ -1357,16 +1357,16 @@ void riscv_add_satp_mode_properties(Object *obj)
>
>      if (cpu->env.misa_mxl =3D=3D MXL_RV32) {
>          object_property_add(obj, "sv32", "bool", cpu_riscv_get_satp,
> -                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mod=
e);
> +                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
>      } else {
>          object_property_add(obj, "sv39", "bool", cpu_riscv_get_satp,
> -                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mod=
e);
> +                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
>          object_property_add(obj, "sv48", "bool", cpu_riscv_get_satp,
> -                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mod=
e);
> +                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
>          object_property_add(obj, "sv57", "bool", cpu_riscv_get_satp,
> -                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mod=
e);
> +                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
>          object_property_add(obj, "sv64", "bool", cpu_riscv_get_satp,
> -                            cpu_riscv_set_satp, NULL, &cpu->cfg.satp_mod=
e);
> +                            cpu_riscv_set_satp, NULL, &cpu->satp_modes);
>      }
>  }
>
> --
> 2.48.1
>
>

