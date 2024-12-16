Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDF0E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 05:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN3hC-0004JB-7n; Mon, 16 Dec 2024 00:31:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3gx-0004Gn-Gv; Mon, 16 Dec 2024 00:30:55 -0500
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN3gm-0008QP-Oo; Mon, 16 Dec 2024 00:30:51 -0500
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-5187aa2c97dso1098500e0c.2; 
 Sun, 15 Dec 2024 21:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734327037; x=1734931837; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTBHQHQGxQjoIgsvjXNKqi1s+x2i0J8CHQQ19MySAjg=;
 b=BkqmjtlEeX2JI61O+2J6r6XsYUlHkSriCl/5r4xmRxOA/8ApHY8399sDfW4Eim3zxD
 tUEfE5lyFRCdLYP3PjtYapQiJu+7JSDfIk3rOzb39qVxsI6ssSe75tsflSdm1+lroAeU
 c6LtwgsItSowJXDOYB13585yqZGdWVzv4JCXSU56IEOCgrxZnWpOE7WOw2onSlQJ1Jp/
 Y/9OpWNuIjZkJ3iXP3oFuEf9Kbei1AxcXSWZFJ6JO+Q6Xak7i9sFGiPYCByRSu7QFGXr
 IEKtq2E9pdUg9LnmWmt4DsSACuAIaWKoceXRmxvHkBkOCpV/ZEd4RpKCvGq1S4NVwjap
 bYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734327037; x=1734931837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rTBHQHQGxQjoIgsvjXNKqi1s+x2i0J8CHQQ19MySAjg=;
 b=Wu7eJFO+bJfLvWxAEzJrBQfR6eVigAJDFve489s2oHXDX9fPbY9JQNaChh8fBl3ued
 jtqgfCkkH48rSlRV7nF819iqCcBNjLWwP/JxrUDAuJbsRQ/g7q+IRv8LLwJ7yyGc/n8h
 p97srBOWjsem67X/POCNl4exwx7lyLcxtpiEc+2jo5sQ+UInknI7rJGefs92YaF6kbpX
 dM7sT2IG73qlVIAp6lwSXKhuLBSfDNLsoY7a5fklD0UfrM1emhoC35U2iPfriw1Y0B/9
 a9bPzukO2CEThdUKBMO3pl2WoepESXVNdoO7A7no8cYH1Mcf+P3Z0p9WZIjB8ZHe/fF0
 e6EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVl5KqqZe4rWNeuXbGyiaH6KYIGV5t0enRv7frc5YciM5zQcCkgRQ+68FhiOfV3pqVRixir+ES/0W+c@nongnu.org,
 AJvYcCWW0A1KfCtFl3PfJJmLeVZqW+zTc4A1hvkwwXTucP4h5iMweiGbEpoJQAJbAg2lNCnNPP/2TZ1cKXX8tw==@nongnu.org
X-Gm-Message-State: AOJu0YyfswHw2xz/b3BV7g15uBwu6dUgW8uVHxQIXRAzQy1ui4Hm3tpc
 V4eRREn1F0ELRGD9ShyXuP15eZKLg2UiPRryLgCdVvMqNd72tjv73H+N9qr3vzB/3REGb3/IJZK
 jMfqA498ZxPbVvULKwOGCr6viI1Y=
X-Gm-Gg: ASbGncslSdEUMf78rzj2Bd020HUeYVBUYVDX8lq5c/HL7dE4fMyAnFe+4VqBcmUD0Cf
 Md1cZhojdlsWQg6Xp8F7rplRxUOGtpfjxzJfO+95Lbx6u58dIuTaggl3dp5S2pUUJyz5d
X-Google-Smtp-Source: AGHT+IGUfy37jrTKyN5UG/W0PYeHrbuaWJ3w4BbOKdYxhcNu+OWdZ1vUht3BxZTLflmHqS33152yqekk1CLTiLD412s=
X-Received: by 2002:a05:6102:3e93:b0:4af:de39:c55 with SMTP id
 ada2fe7eead31-4b25dc60ef3mr9731793137.27.1734327036716; Sun, 15 Dec 2024
 21:30:36 -0800 (PST)
MIME-Version: 1.0
References: <20241205073622.46052-1-xiaoou@iscas.ac.cn>
In-Reply-To: <20241205073622.46052-1-xiaoou@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 15:30:10 +1000
Message-ID: <CAKmqyKOPvv8mTmGdTB1CmNwmDZkuis=_TWHQUD=KYHNg5fOncg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

