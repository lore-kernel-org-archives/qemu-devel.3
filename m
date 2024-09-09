Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D1DCE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 03:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snVA2-0002mh-VO; Sun, 08 Sep 2024 23:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snVA0-0002iS-H2; Sun, 08 Sep 2024 23:33:52 -0400
Received: from mail-ua1-x92e.google.com ([2607:f8b0:4864:20::92e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1snV9y-00015x-T5; Sun, 08 Sep 2024 23:33:52 -0400
Received: by mail-ua1-x92e.google.com with SMTP id
 a1e0cc1a2514c-846b934981aso1066614241.3; 
 Sun, 08 Sep 2024 20:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725852829; x=1726457629; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34pXcUuZBK32AU4GR1tsQMirfvh+1wOS46Lzw00mQzg=;
 b=ZuNjrQFel7R1jy6DBP6ihJZguxw9ff67ICsuWL10v/z9j9gb4InRBo5n6zE4ETyK0w
 QZotSS9NamNe4GbwX6gJ4G9f6SEkpwLRxSG6N8eWPSdU485Xriv5KTHq8WZX+7W/hLaj
 f00l2vNU7C9uY3Pa2V1rpuFEzJr8PYZlo0V9abiBqYnnJ9ktkKlbzkBsDgcI6J/+EJ6b
 QIFx8c1Z/9KdEEk9N8syLNN3ob+GRvr4T0/ljlkFp0agEO9oy0EsGA54pH1s02yoVVcM
 XTE57Nl6grF+Jl5r8x3cXt6Y2o9stvbIrwd61ZThMz+PqM0L9b3e4lV/KKG8UI+oqyz5
 YwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725852829; x=1726457629;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=34pXcUuZBK32AU4GR1tsQMirfvh+1wOS46Lzw00mQzg=;
 b=Zmnqhr5Y5aUyfk4qEGP0apd0reZgMlo322D0ARMVwyWI/16wcTtkiJ9sR6lX7aSmVC
 U/x161sJmFWWZ3b+iJU7CTpcMpbXunoYnf6AZtnDzZnbGsSbzsXtwcSODPE2qDM0Z6so
 a6tvfUAOEi6WC9VtvwRaTV3zK3nBGMEER3tWgkRvK/gFiIXzAUfxFt+aKfsxWA6aSVQf
 3PG72iQiRkl/KZpfEnoGHM0j0nj0Sa1BnbEzInZj3CxsK2It+hZxFMBV0FdPHbuP2qte
 wdFsKQ+zfGSi4VbwbcKDJQdwpQylhJOPVJtmGOkQTCJJs5m7jilqIM9xw+hD3+K0CcO9
 hVog==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrLU+JNWBEvhbGPnPp7Fd3Hj7ddXJz2Hyi3ot+OE9CoJdd9D32GYYMCztTwQ3jgvMUQgVmBhPjSnLk8Q==@nongnu.org,
 AJvYcCWvylV0ZB5VwGjT4Zl0kICVlE23hknYOMF4AHBMxTA/pzfUwN0it1kX/RDnYuMTqR9Fe0U8QR8CYxCZ@nongnu.org
X-Gm-Message-State: AOJu0YyOAtoV7VZJLpQ7roCRKNy4+wSBgHa66Me05HYnkyGSmWrZgJBS
 iXVREgHT1+M6xwRL2LzT+3dUpxo+q3gZk2go0FaMglo6HuEs+4kY/2LRndFZ9ifUJ0DmscLBFO4
 /GoBHo/JniVsHZhG52lyW8VCZrKg=
X-Google-Smtp-Source: AGHT+IHTGfU+0MWOuEB38mlvSQRMb+KfwuPyEbflz5vpU1CaqKmXuA3QO8kWQE1VcfWuWlNoCbJIQxWAY0ZzpXDm2Sg=
X-Received: by 2002:a05:6102:290f:b0:49a:211a:f08d with SMTP id
 ada2fe7eead31-49bde2e9e09mr10671085137.24.1725852829262; Sun, 08 Sep 2024
 20:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240828083651.203861-1-alexghiti@rivosinc.com>
In-Reply-To: <20240828083651.203861-1-alexghiti@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Sep 2024 13:33:23 +1000
Message-ID: <CAKmqyKOCW=AYmnha0-pewMSHsQK6VBMXF6Lj-zh2wdbgxUGcvg@mail.gmail.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::92e;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92e.google.com
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

