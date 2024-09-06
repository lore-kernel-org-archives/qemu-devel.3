Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691CECE7AA6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 02:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smP5a-00058w-Oo; Thu, 05 Sep 2024 22:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smP5Y-00057W-6O; Thu, 05 Sep 2024 22:52:44 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1smP5W-0002ai-Bo; Thu, 05 Sep 2024 22:52:43 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-49a6d056fa3so554826137.0; 
 Thu, 05 Sep 2024 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725591160; x=1726195960; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prmMmOT7mp9g8Kdm6I/q6iMcs26Jayp8brLYGhemFyw=;
 b=Ds3OL3mJ5yaICF1mQliG4ghAs9mf/SuZBfKISDjfFRDYLQAqtcCsQyuFhuHxE/ldQN
 OJTqa2ZyalPmr2THO5BHsdkj8WcQCvc/NTgNecRpzgChFJ+nGCqDfV3L8OO1Y4uGoKX2
 Z7PFZv7kDP7a0SAcl2HJWxUx53oEtdkI71TJTFL9oVda2Kw/1lHlpTgTlzSi6fsd9jEp
 py94ibCfTN7Zu0NEIOZ9cp0Lo48qJVlsh1t7LGfosr2YoOaoSKCfRZs6BxojB5I3Xfi4
 ejrpQEnZm8XyGw7Bk19dGozSPhWTDbTj5zx9CRE2lMhNviOJRcuRrhfwpEPPrhYPRRhS
 bgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725591160; x=1726195960;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prmMmOT7mp9g8Kdm6I/q6iMcs26Jayp8brLYGhemFyw=;
 b=caFFGK7Km4spLpQMA6ydt1Iha1/JFm+nU4emXrDmyRW+zEOG3ptM3kD20Px7/PTwNz
 fJjmcHTh9buscaeKQ99q2apG1D1MLV96uiGb95eZE1CHr6PuxT3L2GRkmRh86LNryk3w
 kczC7OrtuNYyZoK7g5d/JwagVvzVQlnFC1S0uueof+vIyxV8ZYl264XCPhnRRVp5eesH
 3dZday8aQwPDLAnPvu5ClIzf3ACGFsY8/OKMNV2Du6MHqGusSLmZ6DY3DZmUcSNUpyB6
 o0bFtZwv/guKt4bgHVgSl4RtkRcDhM8q80Rt9SJreIYfxevB0kFVIiMJYhA/QKc/gmof
 1pdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhnS51s/zQBWMuN823cms6nOELeJr80yUBEnx3uqEOmV0J9YzxWop47TMjbAW4UIfOTp4rFJTkTU47@nongnu.org
X-Gm-Message-State: AOJu0YwA4ErFFU5ILme4fH9ZcTFeroUAtxXquoir+Xx7igscSI+BJt7c
 l1vd7q5lFbsmV9HOnrSlkjXSzCbHP1ApLK/FOFuodjNrJkhlcNgzN96JRS4p/S2snD8fOGkvLs2
 xmS3b17i62FCNSKQb8UvZ3kepO6teDA==
X-Google-Smtp-Source: AGHT+IHT2zG1Gr7NaJLob5I6fP9bN+JTq2PghzwmnE9+2+CsNHf/Rq0EV7fbn9feo1ZV0XjvBf+/X6OmK/QcLlVq9eA=
X-Received: by 2002:a05:6102:d90:b0:498:d1a3:dea8 with SMTP id
 ada2fe7eead31-49bde25fffdmr1409146137.21.1725591160151; Thu, 05 Sep 2024
 19:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240819160742.27586-1-Ian.Brockbank@cirrus.com>
 <20240819160742.27586-5-Ian.Brockbank@cirrus.com>
In-Reply-To: <20240819160742.27586-5-Ian.Brockbank@cirrus.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Sep 2024 12:52:14 +1000
Message-ID: <CAKmqyKNtwGGT0LivxRn1Zmy0W8z9htNBBjpQmvP_Cik32vo0mw@mail.gmail.com>
Subject: Re: [PATCH 02/11 v2] target/riscv: Update CSR xintthresh in CLIC mode
To: Ian Brockbank <Ian.Brockbank@cirrus.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 20, 2024 at 2:11=E2=80=AFAM Ian Brockbank <Ian.Brockbank@cirrus=
.com> wrote:
>
> From: Ian Brockbank <ian.brockbank@cirrus.com>
>
> The interrupt-level threshold (xintthresh) CSR holds an 8-bit field
> for the threshold level of the associated privilege mode.
>
> For horizontal interrupts, only the ones with higher interrupt levels
> than the threshold level are allowed to preempt.
>
> Signed-off-by: Ian Brockbank <ian.brockbank@cirrus.com>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/cpu.h      |  2 ++
>  target/riscv/cpu_bits.h |  2 ++
>  target/riscv/csr.c      | 28 ++++++++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 95303f50d3..9b5f36ad0a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -260,6 +260,7 @@ struct CPUArchState {
>
>      uint64_t miclaim;
>      uint64_t mintstatus; /* clic-spec */
> +    target_ulong mintthresh; /* clic-spec */
>
>      uint64_t mie;
>      uint64_t mideleg;
> @@ -283,6 +284,7 @@ struct CPUArchState {
>      target_ulong stvec;
>      target_ulong sepc;
>      target_ulong scause;
> +    target_ulong sintthresh; /* clic-spec */
>
>      target_ulong mtvec;
>      target_ulong mepc;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 2e65495b54..ad45402370 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -166,6 +166,7 @@
>  #define CSR_MTVAL           0x343
>  #define CSR_MIP             0x344
>  #define CSR_MINTSTATUS      0xfb1 /* clic-spec-draft */
> +#define CSR_MINTTHRESH      0x347 /* clic-spec-draft */
>
>  /* Machine-Level Window to Indirectly Accessed Registers (AIA) */
>  #define CSR_MISELECT        0x350
> @@ -208,6 +209,7 @@
>  #define CSR_STVAL           0x143
>  #define CSR_SIP             0x144
>  #define CSR_SINTSTATUS      0xdb1 /* clic-spec-draft */
> +#define CSR_SINTTHRESH      0x147 /* clic-spec-draft */
>
>  /* Sstc supervisor CSRs */
>  #define CSR_STIMECMP        0x14D
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f9ed7b9079..9c824c0d8f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2903,6 +2903,18 @@ static int read_mintstatus(CPURISCVState *env, int=
 csrno, target_ulong *val)
>      return RISCV_EXCP_NONE;
>  }
>
> +static int read_mintthresh(CPURISCVState *env, int csrno, target_ulong *=
val)
> +{
> +    *val =3D env->mintthresh;
> +    return 0;
> +}
> +
> +static int write_mintthresh(CPURISCVState *env, int csrno, target_ulong =
val)
> +{
> +    env->mintthresh =3D val;

We should be clearing the upper bits on a write

Alistair

> +    return 0;
> +}
> +
>  /* Supervisor Trap Setup */
>  static RISCVException read_sstatus_i128(CPURISCVState *env, int csrno,
>                                          Int128 *val)
> @@ -3322,6 +3334,18 @@ static int read_sintstatus(CPURISCVState *env, int=
 csrno, target_ulong *val)
>      return RISCV_EXCP_NONE;
>  }
>
> +static int read_sintthresh(CPURISCVState *env, int csrno, target_ulong *=
val)
> +{
> +    *val =3D env->sintthresh;
> +    return 0;
> +}
> +
> +static int write_sintthresh(CPURISCVState *env, int csrno, target_ulong =
val)
> +{
> +    env->sintthresh =3D val;
> +    return 0;
> +}
> +
>  /* Supervisor Protection and Translation */
>  static RISCVException read_satp(CPURISCVState *env, int csrno,
>                                  target_ulong *val)
> @@ -5621,9 +5645,13 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>
>      /* Machine Mode Core Level Interrupt Controller */
>      [CSR_MINTSTATUS]     =3D { "mintstatus", clic,  read_mintstatus     =
  },
> +    [CSR_MINTTHRESH]     =3D { "mintthresh", clic,  read_mintthresh,
> +                             write_mintthresh },
>
>      /* Supervisor Mode Core Level Interrupt Controller */
>      [CSR_SINTSTATUS]     =3D { "sintstatus", clic,  read_sintstatus     =
  },
> +    [CSR_SINTTHRESH]     =3D { "sintthresh", clic,  read_sintthresh,
> +                             write_sintthresh },
>
>      [CSR_SCOUNTOVF]      =3D { "scountovf", sscofpmf,  read_scountovf,
>                               .min_priv_ver =3D PRIV_VERSION_1_12_0 },
> --
> 2.46.0.windows.1
> This message and any attachments may contain privileged and confidential =
information that is intended solely for the person(s) to whom it is address=
ed. If you are not an intended recipient you must not: read; copy; distribu=
te; discuss; take any action in or make any reliance upon the contents of t=
his message; nor open or read any attachment. If you have received this mes=
sage in error, please notify us as soon as possible on the following teleph=
one number and destroy this message including any attachments. Thank you. C=
irrus Logic International (UK) Ltd and Cirrus Logic International Semicondu=
ctor Ltd are companies registered in Scotland, with registered numbers SC08=
9839 and SC495735 respectively. Our registered office is at 7B Nightingale =
Way, Quartermile, Edinburgh, EH3 9EG, UK. Tel: +44 (0)131 272 7000. www.cir=
rus.com
>

