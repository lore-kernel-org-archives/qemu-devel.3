Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5212CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 03:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snVDy-0000jK-Fq; Sun, 08 Sep 2024 23:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snVDw-0000h5-EG; Sun, 08 Sep 2024 23:37:56 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snVDu-0001Wq-RP; Sun, 08 Sep 2024 23:37:56 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-49bd27b3507so1039528137.2; 
 Sun, 08 Sep 2024 20:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725853073; x=1726457873; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRHlXSEu1mrsCQ3j/cH0duvaXhLZZSVknBPv8ucgyzk=;
 b=NnF86VD4iUaD85+aX50XssUAYJItm6mbndm/FFUGUowOTsyZuqzx4BYFD1HI7OPqn3
 J6DjhFy40Bc67Q8EpUBNVIjad38Vw/03MuLDjzH9XZCeOfDIOvOl3kU2GYxXnKp3U935
 APaj3Cp3aKskqXGML3mtmpJZW4rufJ7oFbb4sG79Q7QwfzQgSsKf7yiDWJewrYji+B6c
 kE38R5vElIBLJwA2aftfjJbKwnumyHh7hIpwx9lJSw0f4h2V6/pAsVdvLFPJxI+Q2khx
 Z7c+HAqfM78bwgDv9dELNGeQPCwGnaoXd0DewatKxCbpYpMftO5gV/a2ew0sHMxbM/Y8
 wX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725853073; x=1726457873;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gRHlXSEu1mrsCQ3j/cH0duvaXhLZZSVknBPv8ucgyzk=;
 b=dN3A0NVp28dOdEmnK9gghw2wjX61a7Ump0C4+nSOrc2QAaNqimg71nT+hdb4l1uIXE
 sVWm/z15I6LBLYWm2z/rm/Tz2qnFWzYAWkOIfoyNFSw2anljnt+HF5Ou3NqiuGouMrl6
 WyPPLPQdvjXvT8rF0GNPWNCZy5di1V2RU3ayTnlfCCFpBlWqvelhHf1PgBuk9qcbSRL7
 Nnll0aPNrgqwk4n8kpw2tKQUMDFT32Hxc8vuauvbPt0vRz94+3ttMv8lnDMrRjyyY5E8
 TmUMgALh7miOPXWWxaKXHXC5b52P34gaXQNV6zuHv6qAWHjWFX6HEK2SINmMSRlMHmt6
 T2cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtHs20PJ+Mew5y76gswUJc6LNVr6p0ALrmUxW7/MXIvuvNrufU7ppv1o5txD712FJy0RILXip/rnA+qQ==@nongnu.org,
 AJvYcCX2QiL5gnMi/vvuvSKb2wLzQhMGnCpf5/g3WRfL6gk8kgXTC5RwCYOOwCh6mbL4jw8b9MLTdtTWn56l@nongnu.org
X-Gm-Message-State: AOJu0Yxbe6kpDhxut6bpL0cj7gdAspeFoMi219kRnZzLetWX6ikTK7xl
 OGKxTv1uY8yQ70vQaWu/5SIDqsqmoBTPCZSdOoMuh4YE9XKIiT8nbtzQWrq+dPYTJTsVVufIFxd
 tDOfBijOiIHSV2xc/FzeiDRu6zgU=
X-Google-Smtp-Source: AGHT+IG5LqgyhdeB6JT8Q3018zAG9aCyo3tzpN+lYqaObGNuDayUVLe87wajuRNWuU3Nf+oAsnheipfsblSG0hHtdPM=
X-Received: by 2002:a05:6102:32cd:b0:493:f097:e5b7 with SMTP id
 ada2fe7eead31-49bde130e3dmr8447128137.1.1725853073198; Sun, 08 Sep 2024
 20:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240828083651.203861-1-alexghiti@rivosinc.com>
In-Reply-To: <20240828083651.203861-1-alexghiti@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 13:37:27 +1000
Message-ID: <CAKmqyKOTgTYqrN1gBxfugfeFS3FgKBHXJR8JqqcfC8b2f_M9PQ@mail.gmail.com>
Subject: Re: [PATCH v3] target: riscv: Add Svvptc extension support
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe31.google.com
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

On Wed, Aug 28, 2024 at 6:37=E2=80=AFPM Alexandre Ghiti <alexghiti@rivosinc=
.com> wrote:
>
> The Svvptc extension describes a uarch that does not cache invalid TLB
> entries: that's the case for qemu so there is nothing particular to
> implement other than the introduction of this extension.
>
> Since qemu already exposes Svvptc behaviour, let's enable it by default
> since it allows to drastically reduce the number of sfence.vma emitted
> by S-mode.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> Changes in v3:
> - Rebase on top of master
> - Change 1.12 to 1.13 spec version (drew)
>
> Changes in v2:
> - Rebase on top of master
> - Enable Svvptc by default
>
>  target/riscv/cpu.c     | 2 ++
>  target/riscv/cpu_cfg.h | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..cabe698f2f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -197,6 +197,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
>      ISA_EXT_DATA_ENTRY(xtheadbs, PRIV_VERSION_1_11_0, ext_xtheadbs),
> @@ -1509,6 +1510,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[]=
 =3D {
>      MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
>      MULTI_EXT_CFG_BOOL("svnapot", ext_svnapot, false),
>      MULTI_EXT_CFG_BOOL("svpbmt", ext_svpbmt, false),
> +    MULTI_EXT_CFG_BOOL("svvptc", ext_svvptc, true),
>
>      MULTI_EXT_CFG_BOOL("zicntr", ext_zicntr, true),
>      MULTI_EXT_CFG_BOOL("zihpm", ext_zihpm, true),
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b272fb826..7d16048a76 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -81,6 +81,7 @@ struct RISCVCPUConfig {
>      bool ext_svinval;
>      bool ext_svnapot;
>      bool ext_svpbmt;
> +    bool ext_svvptc;
>      bool ext_zdinx;
>      bool ext_zaamo;
>      bool ext_zacas;
> --
> 2.39.2
>
>

