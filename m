Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918CAC2D0CB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 05:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFRL2-0003Z1-VE; Thu, 15 May 2025 01:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRL0-0003VJ-Uf
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:40:58 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uFRKy-000827-Gv
 for qemu-devel@nongnu.org; Thu, 15 May 2025 01:40:58 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-86715793b1fso160571241.0
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 22:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747287655; x=1747892455; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZSVeM3LRQG9aUu2pX9wO2V6t5wJWgcNtlWamghHkgfE=;
 b=YQktDH0j4koY9mc9ZqV1ROpT9lA0JPRrsgEHrzcfGsdHAc2bN23QKUypMmJFJSKecp
 /Fer/7feKZdn2qUy3mPVHvIkcIbgPfeKNiVgWw2Xh39jP95JquiS6VH14YanOFuMAJNu
 wnFGUYCw/yKcrGq+LAfzoWmyljiZlmOcuc8MjGdCu/Dx3G8NvMxtjwWMTwQhWY4SbU32
 qqZLc7yb+NsH1LY+2kOy8H/0ry2EL6g8ZfscYGnA4RdJTIgIu9Cf5MrVOvOcbbw2rETu
 83/vb8rcB0HHprkkYAyQo1KUfH3C/2aOGpCibEh8iuqoOgT82RDw73ygMbvR2DAuYmio
 FJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747287655; x=1747892455;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZSVeM3LRQG9aUu2pX9wO2V6t5wJWgcNtlWamghHkgfE=;
 b=cNsSTUG2ZdhAVI/pY6Xy6nexf3i9jBTSZBvB0rH5OXYDtWxuEfS7yA/QKI6JtNhJy0
 8DbLCj6KqpzhsFCDyrO5xaz2oAFNcbnyH7XHBRGhUEGiSp14TPruNyeUlRhGpDenKBpQ
 P+MUAsQUYId8S+WcXZcnq7FjS6YHHFUiWsR843Awgwxcf8Y/zd1sQxgTR9eOpxxjlvkj
 Q0x9Fj2kyLv5OOPPBDbIiiHg+23D1aJRq2zheJT130yUc0/FVbSE0feeNfdUtTK/sU0i
 8JDGPp42MgQvfObdgrpU/t/wTX6QPzCvL8fDhnrjSMTxiVJ/ncLNCOTPZpAnjOPnGR3R
 qV5g==
X-Gm-Message-State: AOJu0Yx1hUc83tYHEHlpsjEWjUjqIe++tZT/QohDZsosgykrc+a1OkJn
 Fn8xOQSg0Zp2X6HvSi94Btt6J0iQGSLKRyV26dABeDR/i7XlWdqTry99gmlReW2jVBmXHgZgNOl
 KJEAGLKxQlQvD853PpDP3JSpdcKJ60w==
X-Gm-Gg: ASbGncsT+U4anGpxP3SyIrkGDnyCi9BANwWqLWRlv66TaFdoVY8+g7TYOWyq7QyqVNX
 8VZHu0kIIPMeBbQsSSfM/3r4qhEc+Y/YcXEF7md50g5k+ip35IqmvAUNeiAdCAE6O06wv1AIVz9
 VM6ijJtfn+qjjmqQoXMBRc7AGX+Ey7zYWPUcHzwbWpIVyMHAXqVvR+vkRFPtRcEbs=
X-Google-Smtp-Source: AGHT+IGiWG2JmE/tHFBNHtDNI4CJEBQezIaBi7KMEnyzMdtVf2iO9vJwqUH9oCTnxFB00V3NZxd4CzB3lGGLg0Dni70=
X-Received: by 2002:a05:6102:4b84:b0:4c1:91e0:d5d6 with SMTP id
 ada2fe7eead31-4df9561eeeemr791179137.12.1747287654708; Wed, 14 May 2025
 22:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250512095226.93621-1-pbonzini@redhat.com>
 <20250512095226.93621-21-pbonzini@redhat.com>
In-Reply-To: <20250512095226.93621-21-pbonzini@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 May 2025 15:40:28 +1000
X-Gm-Features: AX0GCFuqBTZ0tzSSXC7hZqrYdPskWOooXzdb6NeXU68raDcxVM5FkoXdkNVGaxE
Message-ID: <CAKmqyKPjeD0BgdGKdiYEdfo1kAz1szdT0WX=yzaG=bJwgOCXCg@mail.gmail.com>
Subject: Re: [PATCH 20/26] target/riscv: generalize custom CSR functionality
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, dbarboza@ventanamicro.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Mon, May 12, 2025 at 7:54=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> While at it, constify it so that the RISCVCSR array in RISCVCPUDef
> can also be const.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h    | 15 ++++++++++++---
>  target/riscv/cpu.c    | 25 ++++++++++++++++++++++++-
>  target/riscv/csr.c    |  2 +-
>  target/riscv/th_csr.c | 21 +++------------------
>  4 files changed, 40 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 8a8d61f8099..f68af8cb124 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -537,6 +537,8 @@ struct ArchCPU {
>      const GPtrArray *decoders;
>  };
>
> +typedef struct RISCVCSR RISCVCSR;
> +
>  typedef struct RISCVCPUDef {
>      RISCVMXL misa_mxl_max;  /* max mxl for this cpu */
>      RISCVCPUProfile *profile;
> @@ -545,6 +547,7 @@ typedef struct RISCVCPUDef {
>      int32_t vext_spec;
>      RISCVCPUConfig cfg;
>      bool bare;
> +    const RISCVCSR *custom_csrs;
>  } RISCVCPUDef;
>
>  /**
> @@ -891,6 +894,12 @@ typedef struct {
>      uint32_t min_priv_ver;
>  } riscv_csr_operations;
>
> +struct RISCVCSR {
> +    int csrno;
> +    bool (*insertion_test)(RISCVCPU *cpu);
> +    riscv_csr_operations csr_ops;
> +};
> +
>  /* CSR function table constants */
>  enum {
>      CSR_TABLE_SIZE =3D 0x1000
> @@ -945,7 +954,7 @@ extern riscv_csr_operations csr_ops[CSR_TABLE_SIZE];
>  extern const bool valid_vm_1_10_32[], valid_vm_1_10_64[];
>
>  void riscv_get_csr_ops(int csrno, riscv_csr_operations *ops);
> -void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops);
> +void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops);
>
>  void riscv_cpu_register_gdb_regs_for_features(CPUState *cs);
>
> @@ -954,8 +963,8 @@ target_ulong riscv_new_csr_seed(target_ulong new_valu=
e,
>
>  const char *satp_mode_str(uint8_t satp_mode, bool is_32_bit);
>
> -/* Implemented in th_csr.c */
> -void th_register_custom_csrs(RISCVCPU *cpu);
> +/* In th_csr.c */
> +extern const RISCVCSR th_csr_list[];
>
>  const char *priv_spec_to_str(int priv_version);
>  #endif /* RISCV_CPU_H */
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 171f27fdd87..bc45815383d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -485,6 +485,19 @@ static void set_satp_mode_default_map(RISCVCPU *cpu)
>  }
>  #endif
>
> +#ifndef CONFIG_USER_ONLY
> +static void riscv_register_custom_csrs(RISCVCPU *cpu, const RISCVCSR *cs=
r_list)
> +{
> +    for (size_t i =3D 0; csr_list[i].csr_ops.name; i++) {
> +        int csrno =3D csr_list[i].csrno;
> +        const riscv_csr_operations *csr_ops =3D &csr_list[i].csr_ops;
> +        if (!csr_list[i].insertion_test || csr_list[i].insertion_test(cp=
u)) {
> +            riscv_set_csr_ops(csrno, csr_ops);
> +        }
> +    }
> +}
> +#endif
> +
>  #if defined(TARGET_RISCV64)
>  static void rv64_thead_c906_cpu_init(Object *obj)
>  {
> @@ -511,7 +524,7 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>      cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> -    th_register_custom_csrs(cpu);
> +    riscv_register_custom_csrs(cpu, th_csr_list);
>  #endif
>
>      /* inherited from parent obj via riscv_cpu_init() */
> @@ -1304,6 +1317,11 @@ static void riscv_cpu_init(Object *obj)
>      if (mcc->def->vext_spec !=3D RISCV_PROFILE_ATTR_UNUSED) {
>          cpu->env.vext_ver =3D mcc->def->vext_spec;
>      }
> +#ifndef CONFIG_USER_ONLY
> +    if (mcc->def->custom_csrs) {
> +        riscv_register_custom_csrs(cpu, mcc->def->custom_csrs);
> +    }
> +#endif
>  }
>
>  typedef struct misa_ext_info {
> @@ -2906,6 +2924,11 @@ static void riscv_cpu_class_base_init(ObjectClass =
*c, const void *data)
>          mcc->def->misa_ext |=3D def->misa_ext;
>
>          riscv_cpu_cfg_merge(&mcc->def->cfg, &def->cfg);
> +
> +        if (def->custom_csrs) {
> +            assert(!mcc->def->custom_csrs);
> +            mcc->def->custom_csrs =3D def->custom_csrs;
> +        }
>      }
>
>      if (!object_class_is_abstract(c)) {
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 74760f98cca..833d06237ae 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -38,7 +38,7 @@ void riscv_get_csr_ops(int csrno, riscv_csr_operations =
*ops)
>      *ops =3D csr_ops[csrno & (CSR_TABLE_SIZE - 1)];
>  }
>
> -void riscv_set_csr_ops(int csrno, riscv_csr_operations *ops)
> +void riscv_set_csr_ops(int csrno, const riscv_csr_operations *ops)
>  {
>      csr_ops[csrno & (CSR_TABLE_SIZE - 1)] =3D *ops;
>  }
> diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
> index 969a9fe3c80..49eb7bbab5f 100644
> --- a/target/riscv/th_csr.c
> +++ b/target/riscv/th_csr.c
> @@ -27,12 +27,6 @@
>  #define TH_SXSTATUS_MAEE        BIT(21)
>  #define TH_SXSTATUS_THEADISAEE  BIT(22)
>
> -typedef struct {
> -    int csrno;
> -    bool (*insertion_test)(RISCVCPU *cpu);
> -    riscv_csr_operations csr_ops;
> -} riscv_csr;
> -
>  static RISCVException smode(CPURISCVState *env, int csrno)
>  {
>      if (riscv_has_ext(env, RVS)) {
> @@ -55,20 +49,11 @@ static RISCVException read_th_sxstatus(CPURISCVState =
*env, int csrno,
>      return RISCV_EXCP_NONE;
>  }
>
> -static riscv_csr th_csr_list[] =3D {
> +const RISCVCSR th_csr_list[] =3D {
>      {
>          .csrno =3D CSR_TH_SXSTATUS,
>          .insertion_test =3D test_thead_mvendorid,
>          .csr_ops =3D { "th.sxstatus", smode, read_th_sxstatus }
> -    }
> +    },
> +    { }
>  };
> -void th_register_custom_csrs(RISCVCPU *cpu)
> -{
> -    for (size_t i =3D 0; i < ARRAY_SIZE(th_csr_list); i++) {
> -        int csrno =3D th_csr_list[i].csrno;
> -        riscv_csr_operations *csr_ops =3D &th_csr_list[i].csr_ops;
> -        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_t=
est(cpu)) {
> -            riscv_set_csr_ops(csrno, csr_ops);
> -        }
> -    }
> -}
> --
> 2.49.0
>

