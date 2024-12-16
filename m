Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50E5E7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 05:24:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN3Zr-0002Ch-Nd; Mon, 16 Dec 2024 00:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3Zp-0002CB-99; Mon, 16 Dec 2024 00:23:29 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3Zm-0007TK-E0; Mon, 16 Dec 2024 00:23:28 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-51889930cb1so1000907e0c.0; 
 Sun, 15 Dec 2024 21:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734326603; x=1734931403; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2WzYcVRm23iTLUtH2a8hod11FuenaP1GFcRFipp7R4=;
 b=LYklHQxKrl1l8lJ+MkRekTppqLSp42JJuEmnsKcIz7QLMta7yttiY/tGcNm1voWDPk
 rWxBcUNJBU5PmMre6z9HXkCNaEe4ndc7dc9fyiseUgG17RXaGP7ObsTxr2XO3bvPOzuF
 SsGH4zK2ePMUiaV6UhU+ghlvVwWHAbRp91VXMh1EFpOtvrMllw3GjZbsM7PGFiUSqcTM
 8r3KucA6pchAZikwkOuYjKVpZTXtkbe8KoDvdbgnY5439U5mYY7S5I6ume0VEAfBIIDl
 62ST8YrY0bVYM+l3GBhm+Kg2aXCnVjiAJL+kBWnsOY7f277Iar/TVg5BdKyeEj7iKpdQ
 eKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734326603; x=1734931403;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2WzYcVRm23iTLUtH2a8hod11FuenaP1GFcRFipp7R4=;
 b=mxljhC6x+VZ8DYnKooJ3IHqDFaJD6lP/Tu+ZtDvyi3ELrzWza0fmX487t6fkBY8zdk
 mivz7qz53L7IoMSg/c8TdXckUOcU1WNUzIqvWDPz60EIgBNiZnCtwiOvxwLruoC50/gY
 hwnP0BHK9rmeWgzU9H5Vcgbmba5TemE5QMbcR1yd/hQGnAA2/d6tZahdT18aGsSaGS2Y
 KK559rOwaMfi9h9INImiombXeNJQYa3hQqS578d8TkzLxsDtJ2cSjFDwYjMdEQyiW5O/
 mwn9Nz22qQVOgrNRI5/pstO2Lqrm+iErJxPLvfNy9yOBVbm5JiBq4oS9i/XniH+QJ1Ue
 2VNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXppdtLVNSFT89uwCt8PMg2lQLb8U4FCTxcGXF+SfUxkekn0gSQBdjz3LYORScDNSFbVOKvyaRIPTwQ@nongnu.org,
 AJvYcCXuCb60v/9LWbaos+je4uSxaDl+YsNQPc88UNCC7lX37fFL3VLeV/X7h5kp/9wcGI/jdGyFfBjvrn9Sew==@nongnu.org
X-Gm-Message-State: AOJu0Yyxapay6Kcqa1kw0ducFM3wdUbV0+D9F4APsrDaaDELRZ1mjSQM
 GKefM8+Bnm/2YwOyGAaAPUfsO+hm/E0Ab6KNKxKo28Q+wCE9Qqq0GgQFFppX76Tdu0X9Eu5/Z61
 M+jCtg4p1trqqAhCRQ3atXQAAlWM=
X-Gm-Gg: ASbGncv7TDwZH+f8l+k5yuQNSIiLy6EPxTWPQVOhxapP8Ef9cli+Am5on0xMbD0tU+X
 nUtb/3y82+lOrZj2KX6grspVJCqo9bh9SxZXJABQveLh3nF/PvOAG61SgZjFxW3Wev61A
X-Google-Smtp-Source: AGHT+IGh2JDwuI1zep3vfwYaOjum1fLPCJw2Zbp8johkvS74khRUtkQy+xchxaLy5qC3q0dIYRLxyuPX/QvxgtbHFOs=
X-Received: by 2002:a05:6102:b02:b0:4af:dcbe:4767 with SMTP id
 ada2fe7eead31-4b25d98d34bmr9398004137.10.1734326603612; Sun, 15 Dec 2024
 21:23:23 -0800 (PST)
MIME-Version: 1.0
References: <20241205073622.46052-1-xiaoou@iscas.ac.cn>
In-Reply-To: <20241205073622.46052-1-xiaoou@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 15:22:57 +1000
Message-ID: <CAKmqyKPxfhOGGrLymaNtymiWZ9SQbV1iBvsc+4QhtzTwraYtHQ@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: add support for RV64 Xiangshan Nanhu CPU
To: MollyChen <xiaoou@iscas.ac.cn>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Thu, Dec 5, 2024 at 5:38=E2=80=AFPM MollyChen <xiaoou@iscas.ac.cn> wrote=
:
>
> Add a CPU entry for the RV64 XiangShan NANHU CPU which
> supports single-core and dual-core configurations. More
> details can be found at
> https://docs.xiangshan.cc/zh-cn/latest/integration/overview
>
> Signed-off-by: MollyChen <xiaoou@iscas.ac.cn>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu-qom.h |  1 +
>  target/riscv/cpu.c     | 29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 6547642287..d56b067bf2 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -50,6 +50,7 @@
>  #define TYPE_RISCV_CPU_THEAD_C906       RISCV_CPU_TYPE_NAME("thead-c906"=
)
>  #define TYPE_RISCV_CPU_VEYRON_V1        RISCV_CPU_TYPE_NAME("veyron-v1")
>  #define TYPE_RISCV_CPU_TT_ASCALON       RISCV_CPU_TYPE_NAME("tt-ascalon"=
)
> +#define TYPE_RISCV_CPU_XIANGSHAN_NANHU  RISCV_CPU_TYPE_NAME("xiangshan-n=
anhu")
>  #define TYPE_RISCV_CPU_HOST             RISCV_CPU_TYPE_NAME("host")
>
>  OBJECT_DECLARE_CPU_TYPE(RISCVCPU, RISCVCPUClass, RISCV_CPU)
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8447ad0dfb..38baaa39f8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -645,6 +645,34 @@ static void rv64_tt_ascalon_cpu_init(Object *obj)
>  #endif
>  }
>
> +static void rv64_xiangshan_nanhu_cpu_init(Object *obj)
> +{
> +    CPURISCVState *env =3D &RISCV_CPU(obj)->env;
> +    RISCVCPU *cpu =3D RISCV_CPU(obj);
> +
> +    riscv_cpu_set_misa_ext(env, RVG | RVC | RVB | RVS | RVU);
> +    env->priv_ver =3D PRIV_VERSION_1_12_0;
> +
> +    /* Enable ISA extensions */
> +    cpu->cfg.ext_zbc =3D true;
> +    cpu->cfg.ext_zbkb =3D true;
> +    cpu->cfg.ext_zbkc =3D true;
> +    cpu->cfg.ext_zbkx =3D true;
> +    cpu->cfg.ext_zknd =3D true;
> +    cpu->cfg.ext_zkne =3D true;
> +    cpu->cfg.ext_zknh =3D true;
> +    cpu->cfg.ext_zksed =3D true;
> +    cpu->cfg.ext_zksh =3D true;
> +    cpu->cfg.ext_svinval =3D true;
> +
> +    cpu->cfg.mmu =3D true;
> +    cpu->cfg.pmp =3D true;
> +
> +#ifndef CONFIG_USER_ONLY
> +    set_satp_mode_max_supported(cpu, VM_1_10_SV39);
> +#endif
> +}
> +
>  #ifdef CONFIG_TCG
>  static void rv128_base_cpu_init(Object *obj)
>  {
> @@ -3050,6 +3078,7 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_THEAD_C906, MXL_RV64,  rv64_thead_c=
906_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_TT_ASCALON, MXL_RV64,  rv64_tt_asca=
lon_cpu_init),
>      DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_VEYRON_V1,  MXL_RV64,  rv64_veyron_=
v1_cpu_init),
> +    DEFINE_VENDOR_CPU(TYPE_RISCV_CPU_XIANGSHAN_NANHU, MXL_RV64, rv64_xia=
ngshan_nanhu_cpu_init),
>  #ifdef CONFIG_TCG
>      DEFINE_DYNAMIC_CPU(TYPE_RISCV_CPU_BASE128,   MXL_RV128, rv128_base_c=
pu_init),
>  #endif /* CONFIG_TCG */
> --
> 2.34.1
>
>

