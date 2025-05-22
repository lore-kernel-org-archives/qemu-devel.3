Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB91C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 00:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHthX-0002yD-K2; Wed, 21 May 2025 20:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHthT-0002xm-SL; Wed, 21 May 2025 20:22:20 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHthO-0002EO-Np; Wed, 21 May 2025 20:22:19 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-52eea8111easo1258557e0c.2; 
 Wed, 21 May 2025 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747873331; x=1748478131; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOyfWSQLFx6Jw83Cj5iUwm8JEPjCG2LmXDVmK1ukVv4=;
 b=LJ40bgxa/79NUkpuAIHmGUyYG8450D/g8vpwrL72Zo+30pmaFE5FtDUqK2mIjyFRYB
 NfE0wjnHW5XmZt6WFlRGDDz1lCKEHY7h8oXH5r7InOk4kPeI3eW+kA/GhPbcmnQNhHCr
 4xYR2kihzbpj+LN9xh6gZDSbkAodLEElAcko8Jfw5iGZGUl8eBNrtRf5ia4vCcubIOG/
 5SDbnFPebAMDiVEMGM0LeaqxilsGvIB7wbUbPnPnWUzv/EwrqQLSf+l90lM5quDK8EcP
 Wbyxnegh6XXu6A1sBCgWOqz80ffiDSsi30wGk+662E+gptZwvehd6rRnyBMy2+9hCZXu
 VIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747873331; x=1748478131;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOyfWSQLFx6Jw83Cj5iUwm8JEPjCG2LmXDVmK1ukVv4=;
 b=EcxkotYYWxCKfuNlGB9YNaLjOZ7Oxeq3UizTmRhoKvnG6iGMsCOppLqCUPHIj/Gfyv
 ZpTmTTAx2H75uVz96Y7UuA5Xsj6DRD2zkjv2dCUR8sD5No6lJaOzBgLenKYgubOfJ3ak
 3VFIUbLJGCgjPDghJHvQ4ICnftZ9+9D0bs2LIpZxGQJZEz0hnah7Wa/XDSRWqMjMOs/O
 XpwxtIw+rI7NkJ6KIpoJRYAD8ya7J+qZI499n7HzmYrwmGpcQ38q8ADYZfieAQc8pUC8
 vidOA2ZlPrueK0z5C8U5TUDz1WT1apRbXpKdNEhdIx6KhzT1Rb01bGcOBQQwtv+B3ws5
 McvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnyvM1Xs0BmTh1iAKJxy5p0Qm6E42ZAOSoX0e1Obr5Vt+3l4gDFhXHp52bxVfPF3so9X1NkAnr4+6F@nongnu.org
X-Gm-Message-State: AOJu0YzrVBXae3uq6MBFxkhwUnoMdjkO0fyo4AnvQoHe1jg6bZuQfS80
 idVCux3kQF+8f8C1sJy/O8RslkIaWzaHAqiHdgdWI/15nfWs4fXIioIiA/8+5kpy7yJ/lB2qemJ
 o+EjyzP86zWGaOss7NXn2KvWTIzaPc8o=
X-Gm-Gg: ASbGncu7X8+ANqeC+SK2r8pqJdFIT6317oD5rOYAABR0EA6yL+Twdh5qJQKAs1JDbOU
 q4cYC2EgONgWQ1KN4zU76Y5uIsootILKWxGECWpVhSDtxJccNOOlGDnb5NNYObFZrneK50Tlcjd
 zgUpjX4L73ng5hvsGQIXe4lL26EYrkj77uI+K/HNLTUzfeLb1CQx7kJdsCpIty9YLxch012/095
 Q==
X-Google-Smtp-Source: AGHT+IGlms1bKdBelDN860O5qh6G1mSfyx7mR0/YJoEXTjv9BrT4uM6cj3xxGkMXXYJhMDNBcFdFiEHN3Ah9/by4Whk=
X-Received: by 2002:a05:6122:1b0d:b0:52a:9178:d281 with SMTP id
 71dfb90a1353d-52dbcc56d5emr20556234e0c.2.1747873331446; Wed, 21 May 2025
 17:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250425094452.17013-1-jay.chang@sifive.com>
 <20250425094452.17013-2-jay.chang@sifive.com>
In-Reply-To: <20250425094452.17013-2-jay.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 22 May 2025 10:21:45 +1000
X-Gm-Features: AX0GCFvoWfE-l76DeVmb-OOeD-_IOlmykR2LV4kquQw4plPfLY88CK2I35aOOdg
Message-ID: <CAKmqyKNNdOfGLiBS5ATFLaJBEV+GBG9S=3SY-un5hLYCFgBBdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Extend PMP region up to 64
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Fri, Apr 25, 2025 at 7:45=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> According to the RISC-V Privileged Specification (version >1.12),
> RV32 supports 16 CSRs (pmpcfg0=E2=80=93pmpcfg15) to configure 64 PMP regi=
ons
> (pmpaddr0=E2=80=93pmpaddr63).
>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Jay Chang <jay.chang@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_bits.h |  60 +++++++++++++++++++
>  target/riscv/csr.c      | 124 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 182 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a30317c617..e6b3e28386 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -372,6 +372,18 @@
>  #define CSR_PMPCFG1         0x3a1
>  #define CSR_PMPCFG2         0x3a2
>  #define CSR_PMPCFG3         0x3a3
> +#define CSR_PMPCFG4         0x3a4
> +#define CSR_PMPCFG5         0x3a5
> +#define CSR_PMPCFG6         0x3a6
> +#define CSR_PMPCFG7         0x3a7
> +#define CSR_PMPCFG8         0x3a8
> +#define CSR_PMPCFG9         0x3a9
> +#define CSR_PMPCFG10        0x3aa
> +#define CSR_PMPCFG11        0x3ab
> +#define CSR_PMPCFG12        0x3ac
> +#define CSR_PMPCFG13        0x3ad
> +#define CSR_PMPCFG14        0x3ae
> +#define CSR_PMPCFG15        0x3af
>  #define CSR_PMPADDR0        0x3b0
>  #define CSR_PMPADDR1        0x3b1
>  #define CSR_PMPADDR2        0x3b2
> @@ -388,6 +400,54 @@
>  #define CSR_PMPADDR13       0x3bd
>  #define CSR_PMPADDR14       0x3be
>  #define CSR_PMPADDR15       0x3bf
> +#define CSR_PMPADDR16       0x3c0
> +#define CSR_PMPADDR17       0x3c1
> +#define CSR_PMPADDR18       0x3c2
> +#define CSR_PMPADDR19       0x3c3
> +#define CSR_PMPADDR20       0x3c4
> +#define CSR_PMPADDR21       0x3c5
> +#define CSR_PMPADDR22       0x3c6
> +#define CSR_PMPADDR23       0x3c7
> +#define CSR_PMPADDR24       0x3c8
> +#define CSR_PMPADDR25       0x3c9
> +#define CSR_PMPADDR26       0x3ca
> +#define CSR_PMPADDR27       0x3cb
> +#define CSR_PMPADDR28       0x3cc
> +#define CSR_PMPADDR29       0x3cd
> +#define CSR_PMPADDR30       0x3ce
> +#define CSR_PMPADDR31       0x3cf
> +#define CSR_PMPADDR32       0x3d0
> +#define CSR_PMPADDR33       0x3d1
> +#define CSR_PMPADDR34       0x3d2
> +#define CSR_PMPADDR35       0x3d3
> +#define CSR_PMPADDR36       0x3d4
> +#define CSR_PMPADDR37       0x3d5
> +#define CSR_PMPADDR38       0x3d6
> +#define CSR_PMPADDR39       0x3d7
> +#define CSR_PMPADDR40       0x3d8
> +#define CSR_PMPADDR41       0x3d9
> +#define CSR_PMPADDR42       0x3da
> +#define CSR_PMPADDR43       0x3db
> +#define CSR_PMPADDR44       0x3dc
> +#define CSR_PMPADDR45       0x3dd
> +#define CSR_PMPADDR46       0x3de
> +#define CSR_PMPADDR47       0x3df
> +#define CSR_PMPADDR48       0x3e0
> +#define CSR_PMPADDR49       0x3e1
> +#define CSR_PMPADDR50       0x3e2
> +#define CSR_PMPADDR51       0x3e3
> +#define CSR_PMPADDR52       0x3e4
> +#define CSR_PMPADDR53       0x3e5
> +#define CSR_PMPADDR54       0x3e6
> +#define CSR_PMPADDR55       0x3e7
> +#define CSR_PMPADDR56       0x3e8
> +#define CSR_PMPADDR57       0x3e9
> +#define CSR_PMPADDR58       0x3ea
> +#define CSR_PMPADDR59       0x3eb
> +#define CSR_PMPADDR60       0x3ec
> +#define CSR_PMPADDR61       0x3ed
> +#define CSR_PMPADDR62       0x3ee
> +#define CSR_PMPADDR63       0x3ef
>
>  /* RNMI */
>  #define CSR_MNSCRATCH       0x740
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 560b45d10d..41cf469615 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -6093,6 +6093,30 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>      [CSR_PMPCFG1]    =3D { "pmpcfg1",   pmp, read_pmpcfg,  write_pmpcfg =
 },
>      [CSR_PMPCFG2]    =3D { "pmpcfg2",   pmp, read_pmpcfg,  write_pmpcfg =
 },
>      [CSR_PMPCFG3]    =3D { "pmpcfg3",   pmp, read_pmpcfg,  write_pmpcfg =
 },
> +    [CSR_PMPCFG4]    =3D { "pmpcfg4",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG5]    =3D { "pmpcfg5",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG6]    =3D { "pmpcfg6",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG7]    =3D { "pmpcfg7",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG8]    =3D { "pmpcfg8",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG9]    =3D { "pmpcfg9",   pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG10]   =3D { "pmpcfg10",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG11]   =3D { "pmpcfg11",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG12]   =3D { "pmpcfg12",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG13]   =3D { "pmpcfg13",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG14]   =3D { "pmpcfg14",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPCFG15]   =3D { "pmpcfg15",  pmp, read_pmpcfg,  write_pmpcfg,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
>      [CSR_PMPADDR0]   =3D { "pmpaddr0",  pmp, read_pmpaddr, write_pmpaddr=
 },
>      [CSR_PMPADDR1]   =3D { "pmpaddr1",  pmp, read_pmpaddr, write_pmpaddr=
 },
>      [CSR_PMPADDR2]   =3D { "pmpaddr2",  pmp, read_pmpaddr, write_pmpaddr=
 },
> @@ -6107,8 +6131,104 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D =
{
>      [CSR_PMPADDR11]  =3D { "pmpaddr11", pmp, read_pmpaddr, write_pmpaddr=
 },
>      [CSR_PMPADDR12]  =3D { "pmpaddr12", pmp, read_pmpaddr, write_pmpaddr=
 },
>      [CSR_PMPADDR13]  =3D { "pmpaddr13", pmp, read_pmpaddr, write_pmpaddr=
 },
> -    [CSR_PMPADDR14] =3D  { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr=
 },
> -    [CSR_PMPADDR15] =3D  { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr=
 },
> +    [CSR_PMPADDR14]  =3D { "pmpaddr14", pmp, read_pmpaddr, write_pmpaddr=
 },
> +    [CSR_PMPADDR15]  =3D { "pmpaddr15", pmp, read_pmpaddr, write_pmpaddr=
 },
> +    [CSR_PMPADDR16]  =3D { "pmpaddr16", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR17]  =3D { "pmpaddr17", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR18]  =3D { "pmpaddr18", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR19]  =3D { "pmpaddr19", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR20]  =3D { "pmpaddr20", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR21]  =3D { "pmpaddr21", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR22]  =3D { "pmpaddr22", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR23]  =3D { "pmpaddr23", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR24]  =3D { "pmpaddr24", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR25]  =3D { "pmpaddr25", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR26]  =3D { "pmpaddr26", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR27]  =3D { "pmpaddr27", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR28]  =3D { "pmpaddr28", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR29]  =3D { "pmpaddr29", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR30]  =3D { "pmpaddr30", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR31]  =3D { "pmpaddr31", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR32]  =3D { "pmpaddr32", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR33]  =3D { "pmpaddr33", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR34]  =3D { "pmpaddr34", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR35]  =3D { "pmpaddr35", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR36]  =3D { "pmpaddr36", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR37]  =3D { "pmpaddr37", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR38]  =3D { "pmpaddr38", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR39]  =3D { "pmpaddr39", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR40]  =3D { "pmpaddr40", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR41]  =3D { "pmpaddr41", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR42]  =3D { "pmpaddr42", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR43]  =3D { "pmpaddr43", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR44]  =3D { "pmpaddr44", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR45]  =3D { "pmpaddr45", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR46]  =3D { "pmpaddr46", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR47]  =3D { "pmpaddr47", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR48]  =3D { "pmpaddr48", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR49]  =3D { "pmpaddr49", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR50]  =3D { "pmpaddr50", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR51]  =3D { "pmpaddr51", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR52]  =3D { "pmpaddr52", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR53]  =3D { "pmpaddr53", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR54]  =3D { "pmpaddr54", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR55]  =3D { "pmpaddr55", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR56]  =3D { "pmpaddr56", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR57]  =3D { "pmpaddr57", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR58]  =3D { "pmpaddr58", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR59]  =3D { "pmpaddr59", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR60]  =3D { "pmpaddr60", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR61]  =3D { "pmpaddr61", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR62]  =3D { "pmpaddr62", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
> +    [CSR_PMPADDR63]  =3D { "pmpaddr63", pmp, read_pmpaddr, write_pmpaddr=
,
> +                         .min_priv_ver =3D PRIV_VERSION_1_12_0          =
 },
>
>      /* Debug CSRs */
>      [CSR_TSELECT]   =3D  { "tselect",  debug, read_tselect,  write_tsele=
ct  },
> --
> 2.48.1
>
>

