Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F41EA8554
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 04:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSUU-0005sD-58; Mon, 09 Mar 2026 00:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSUR-0005rG-3F
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:45:11 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSUN-0004dS-Vt
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:45:10 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6618bc129acso4726685a12.2
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 21:45:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773031503; cv=none;
 d=google.com; s=arc-20240605;
 b=fWO2sdiSueNmmgXruvfsru0Fz6kXcDmi3Azwitjp0swfh2ivpKmJsq09mXx+RNsZKg
 mJS+1/xCFEozCGaYRvogOvLO84WdHPHH6xW6ySa2YFtORst7hjbGppG//fEx+jS6FQQ0
 8lG+fBHvj20PYvsXv/P+wvO4+uS74wT/mHVduHY5k7d/EliyfcK8Cd/PvKS0wz+330cw
 AncdZnjobOa2LiP7L9+xnRK6S3OFvmvq+bI990JVLoT2tIuiq1q/dStBnkX7qxR1xtP3
 UK1+trDw0aanzcTuMe2/qvkBBfs8fzaL+lX4ivXxl/F2sD6skuEKVz48zd+oXeAkTAPL
 KBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PaSwNeOqRgaOrD0H2+26cGxQiwrUeWX8HbDRj0HS5j8=;
 fh=qxpwc2DaGgPKaO/QSF0Ck4QddgiR8TmLs2bG4fnvclA=;
 b=E+MXFcxWLD3kXaCt2bOQRTzO2PKmxDHydQOq1iTbRCWmA1PSY1IjJ3Ed+VgvoBMisS
 ksSSRIE5K2+Ozv1SxqEaRb7SLrffiww/XLvFftfYxn4BdIMrWqsdclK4PXHvCqsZvYau
 b83yUYeR4l+sf4HLilvWAWj4rfueSM3pxq15Yc6thw1a09uFHWETVXDcQq8ZBvxt+XDV
 Lysg8DoQGo7+2rC74WsXiPx/0lqZU8Koo/iDS7T9vfy4Spr1P0Eb4HeMeM/qW0VNVhvR
 8Kzp8ncvLOtmjAoVB0BNQqHnp+9V0t0X22PW3+f1YFLtwZEecjPlZtvZHNRedSrSr7vj
 tpOg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773031503; x=1773636303; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PaSwNeOqRgaOrD0H2+26cGxQiwrUeWX8HbDRj0HS5j8=;
 b=DoPFDOHfFG4zPq2hOvfwVrbrpqXWphzMAN345Kf9Lklgg3g+uKpOR+v1IQDSEQn+ky
 nQ8fero1VWk2wTFkWWq/QQqebHhjnlsp2u336Hxm3GbyWyvZCTC59lrHwzaXIe+g4pUq
 ANGJqrpwwbQZExLUiWbaq8eKWTToOUDHGbRAS/nGuqHnpu7t+SQr7UoKadaUxTk+V54m
 lJtfuiL4r2kPQPxnioccLLLkU0W7SBO8kbua3k7vMarR08gLtTD3/F0Nwu2TiLRQW0Ny
 vL7ZLv0pS1wL3WRlNWc4O99e0n5zI2OAYq7tJl8Vp8bQGqhgJsUoFNutSr9EX9sqGIZH
 u4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773031503; x=1773636303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PaSwNeOqRgaOrD0H2+26cGxQiwrUeWX8HbDRj0HS5j8=;
 b=BVxdgdrbriFEmvP+Obi3qHQd2Zus/CXK/Gz8wE/w+VLNK6bXKabbef7T1Hx+5eTq0n
 vLXEiO/VGSIgn3ARhw3NaoBb79ZI7AqkHrfJLws3GbL2ggWA4Em6ZI9epM3NqmXl7JSn
 7ABwldVQRzgpRxm9DURzF9LxzvVT041R2Eu/uJW5jg/NWKlrljif0FAV5Gk96SQrPtzx
 7GUziSxst6dN1CuSif0xmZ1AaWFQAKPKa3LQ1X6KLTlPDMSLYnFd4MvjCMJxFj3eI4f9
 uSNb4UUdRXSxLezDscwhZ9bLNIGLTup9drYXY3W4NKwYYuw+D407SJE7fMWAPmDiQ46q
 3znw==
X-Gm-Message-State: AOJu0YxbSWGqS1UzvBDM8HUENwJ7rUuApJmh/Xy9Y02gXXzCQfYC5E6U
 8MDrcV7l3uLYGJ1tprxmFeewrWaDiILLmFXzHnCUV2dm8+zT3STxrtZI2N+gfY0Qgp5EWTTD7es
 C0EpcNnplyOWSMp6AVoh+pAmdkNzieL0=
X-Gm-Gg: ATEYQzzcQD7JjMo4huvoxrlNEACaPKlGIQkFvu1sBTJQ0EwGbE3ARWtMrsq7y8eh0qg
 /wOgDWQcrKsuKkQmSYUB7zWHEQyjRSjlDZpS7oLnSkyHjrw+mwrJ0vj4I6wTyRX3Cl+VLIoAmgh
 tKTnNHbFKRMg79JF4QQZOcD8ZO5dP4oOdUrw6BCNDva76xcBthwDSeTd5ibPPPL2jLfZUDO1HPk
 N/mTTp95oFZtN38u6JheSrHkavWo8RFYRwtbcttfyjLOi4QQyPFDxD2reJkuupmSk8aBjC5EGtX
 JzqygiPxC48H0kwdo/mVEcerv0oyFk1lVXS9iw==
X-Received: by 2002:a05:6402:3551:b0:659:3ddc:d06b with SMTP id
 4fb4d7f45d1cf-6619d4cc651mr5008701a12.9.1773031502567; Sun, 08 Mar 2026
 21:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-2-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-2-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 14:44:35 +1000
X-Gm-Features: AaiRm53MD6slnrJAehmUjO_z7BZbq2puiXMXquznKLXcpKakIv4yEd5X4HzICVU
Message-ID: <CAKmqyKPP1=Hg9uNHF4HTF2=dJGwb8EDmR10CZoT3DQdYKL-25A@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] target/riscv: Add cfg properties for Zvfbfa
 extensions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> The Zvfbfa extension adds more complete BF16 vector compute support
> and requires the Zve32f and Zfbfmin extensions.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c                | 1 +
>  target/riscv/cpu_cfg_fields.h.inc | 1 +
>  target/riscv/tcg/tcg-cpu.c        | 8 ++++++++
>  3 files changed, 10 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9be79622f4..2ddc26c837 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -189,6 +189,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zve64f, PRIV_VERSION_1_10_0, ext_zve64f),
>      ISA_EXT_DATA_ENTRY(zve64d, PRIV_VERSION_1_10_0, ext_zve64d),
>      ISA_EXT_DATA_ENTRY(zve64x, PRIV_VERSION_1_10_0, ext_zve64x),
> +    ISA_EXT_DATA_ENTRY(zvfbfa, PRIV_VERSION_1_13_0, ext_zvfbfa),
>      ISA_EXT_DATA_ENTRY(zvfbfmin, PRIV_VERSION_1_12_0, ext_zvfbfmin),
>      ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
>      ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fie=
lds.h.inc
> index 70ec650abf..3696f02ee0 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -99,6 +99,7 @@ BOOL_FIELD(ext_zvks)
>  BOOL_FIELD(ext_zvksc)
>  BOOL_FIELD(ext_zvksg)
>  BOOL_FIELD(ext_zmmul)
> +BOOL_FIELD(ext_zvfbfa)
>  BOOL_FIELD(ext_zvfbfmin)
>  BOOL_FIELD(ext_zvfbfwma)
>  BOOL_FIELD(ext_zvfh)
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 988b2d905f..720ff0c2a3 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -720,6 +720,14 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          return;
>      }
>
> +    if (cpu->cfg.ext_zvfbfa) {
> +        if (!cpu->cfg.ext_zve32f || !cpu->cfg.ext_zfbfmin) {
> +            error_setg(errp, "Zvfbfa extension requires Zve32f extension=
 "
> +                             "and Zfbfmin extension");
> +            return;
> +        }
> +    }
> +
>      if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_z=
finx) {
>          error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx"=
);
>          return;
> --
> 2.52.0
>
>

