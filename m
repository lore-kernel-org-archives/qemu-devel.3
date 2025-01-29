Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAC1C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwgN-0000Pk-2V; Tue, 28 Jan 2025 20:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwgK-0000Ic-W8; Tue, 28 Jan 2025 20:15:53 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwgG-0007o8-2w; Tue, 28 Jan 2025 20:15:52 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-85c4557fce0so1209594241.3; 
 Tue, 28 Jan 2025 17:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738113345; x=1738718145; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dQREnR0nSHu4UAlqjJslsV5Yc6dzx240fkyzYMW/bZk=;
 b=P3nMEpdk/qRxxGw127bgN6IqMr3XMryQJEVa4KpOQfq41Rm54RIsM62vLLjMdfo4zT
 bwHGW1eyEQaEbmQBiNafXNekxluy2j7QVvZ/E0nwvxcdnGtDAfdqkGVa1fgUryjrtmUx
 STP0yO1aZoyIVsd0CTgLUrRteP4dyI494QDyc+aTDV2AIUbFBPbBxb5/s/YvNAKZMYeJ
 +jDizrjf/l13f/GcKXB2rbvFrYAg0hOb9r+AuDTi7KJTHpqAq4voXbJJDsWKREdX8Zmd
 DCjy6a3g9554yyKTr+LWxVDrjNGDMizpDJVIxMrJl/buCPq9zn3mqaMwdqLL7OnTPtB9
 7riQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738113345; x=1738718145;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQREnR0nSHu4UAlqjJslsV5Yc6dzx240fkyzYMW/bZk=;
 b=W+cqdzBRzlqRZx7BE4xuINz962iE6f/3IomjHEi8S0cQ3m7p7jh6avlP94NI6Sv2Tm
 BomWguqhFDdydHyErKhw7dQoNK5DQEiBK0oTQ0gij23sAymiVd5U2Jixmo5hNBDYPWz3
 5iw0+e/ky0FWhigdNHbPXE4+qFTKJeSms7Oc0tV8PJTCUKnGbWbkgPt2iQRQ2Cz363sN
 ZDyvNBnqUMZ+t4VvlkrRKhC5ZUUGFZ3hWMEWabKfqoIvs9cFz5VHivYpZXBrOP/KTOvC
 ev/Xw7b2C28m+tK89UMvmbzMXTZ6mUUbwoqZwC02BRSKkergx/X2DdOb9K7u/LI/zCky
 hRKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr0uFz7BgO+424lDk4TpbsVfLD3/MOX79Xk96untlIswZkW97xTQoRx9YM9j40eVJnJYhoBfhBDc3M@nongnu.org
X-Gm-Message-State: AOJu0YwydkB3VAc2pFrT26L2EDgWrBrEK/lM/mqEFayefS9mFDQ+kARn
 3+YhJmMCgG6bL0WYuILri1f5ZXuZNOmELg4Y1WIc9HYKCOnUxiCGc22fEOSQV0acLfJ/KCpaZ0e
 dZLtlc9ONvfRNmIAMQFOHKe3/MV17bg==
X-Gm-Gg: ASbGncvs4xD5Gui6T2uqGmTQCaPATzjxrub8LP0EarrZDGf/yxadCozxlNfcLsbZcdD
 ZqNTdQbeTeaQSt0/75o0LyWOl3JIX7kUQtkDffSytfS9lJ680qZDSvQ2JnVGfEqRGfTrnPKyEgK
 88I1p/02XJh3lc5+F0dXi+rnBoQA==
X-Google-Smtp-Source: AGHT+IHKHYdh+oqaCk9frtr7nnMYtc16tAQrrTKrK7DSgdmviNw7rERGcP1gj12sMrgwi84dbLMi6RA3o+uFyneCXq8=
X-Received: by 2002:a05:6122:d87:b0:518:7ab7:afbc with SMTP id
 71dfb90a1353d-51e9e3f8bd4mr1874759e0c.7.1738113345393; Tue, 28 Jan 2025
 17:15:45 -0800 (PST)
MIME-Version: 1.0
References: <20250114190001.1650942-1-dbarboza@ventanamicro.com>
 <20250114190001.1650942-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250114190001.1650942-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:15:19 +1000
X-Gm-Features: AWEUYZmFrKCAN57oSI4zzzh7OoBbL8WrLXXGSV_9w5O1lhArT5tmzXxt4DILcKg
Message-ID: <CAKmqyKMgUfhD=vai=C7zbpHaGw++wiQbMh2uRmHCiUOao1PBZQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/riscv: use RVB in RVA22U64
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Wed, Jan 15, 2025 at 5:04=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From the time we added RVA22U64 until now the spec didn't declare 'RVB'
> as a dependency, using zba/zbb/zbs instead. Since then the RVA22 spec
> [1] added the following in the 'RVA22U64 Mandatory Extensions' section:
>
> "B Bit-manipulation instructions
>
> Note: The B extension comprises the Zba, Zbb, and Zbs extensions. At the
> time of RVA22U64's ratification, the B extension had not yet been
> defined, and so RVA22U64 explicitly mandated Zba, Zbb, and Zbs instead.
> Mandating B is equivalent."
>
> It is also equivalent to QEMU (see riscv_cpu_validate_b() in
> target/riscv/tcg/tcg-cpu.c).
>
> Finally, RVA23U64 [2] directly mentions RVB as a mandatory extension,
> not citing zba/zbb/zbs.
>
> To make it clear that RVA23U64 will extend RVA22U64 (i.e. RVA22 is a
> parent of RVA23), use RVB in RVA22U64 as well.
>
> (bios-tables-test change: RVB added to riscv,isa)
>
> [1] https://github.com/riscv/riscv-profiles/blob/main/src/profiles.adoc#6=
1-rva22u64-profile
> [2] https://github.com/riscv/riscv-profiles/blob/main/src/rva23-profile.a=
doc#rva23u64-profile
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                |   2 +-
>  tests/data/acpi/riscv64/virt/RHCT | Bin 398 -> 400 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b187ef2e4b..6fb4d5f374 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2351,7 +2351,7 @@ static const PropertyInfo prop_marchid =3D {
>  static RISCVCPUProfile RVA22U64 =3D {
>      .parent =3D NULL,
>      .name =3D "rva22u64",
> -    .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVU,
> +    .misa_ext =3D RVI | RVM | RVA | RVF | RVD | RVC | RVB | RVU,
>      .priv_spec =3D RISCV_PROFILE_ATTR_UNUSED,
>      .satp_mode =3D RISCV_PROFILE_ATTR_UNUSED,
>      .ext_offsets =3D {
> diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/=
virt/RHCT
> index b14ec15e553200760a63aad65586913d31ea2edc..13c8025b868051485be5ba629=
74a22971a07bc6a 100644
> GIT binary patch
> delta 53
> zcmeBUp1{l%<l!7LfsuiM@#{n`13^7TMg~>JqB1j+%-qDZl;ot1UQ&#clNpsc(ij;S
> I3K$s}0ARKZK>z>%
>
> delta 52
> zcmbQh+{ern<l!9B$H>6Im@tvcKtP9)kwJyAsLaeHGdD3UC3&N_6yxMHMkS6EMh1pF
> HMg|4|IwT82
>
> --
> 2.47.1
>
>

