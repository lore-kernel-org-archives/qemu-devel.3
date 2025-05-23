Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9523C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 05:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIKmt-0000Ob-KV; Fri, 23 May 2025 01:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uIKmo-0000OA-GS; Fri, 23 May 2025 01:17:38 -0400
Received: from mail-vk1-xa33.google.com ([2607:f8b0:4864:20::a33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uIKml-0006af-O9; Fri, 23 May 2025 01:17:38 -0400
Received: by mail-vk1-xa33.google.com with SMTP id
 71dfb90a1353d-52410fb2afeso5748866e0c.3; 
 Thu, 22 May 2025 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747977454; x=1748582254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJMRmx/pYEwa9T6EEOgKU1jspKNqvj9etLxJNDGFFAU=;
 b=aKGHsZKgLmG3VmxocuoFN5x9x8Ytw5fduckFXUTc77cw7laY5o9OOXRfKxPJ3+VS3x
 Hctg7bGHlPhDWScoKyPDkkwKylv6O0H0jKqashVBjeneL+80i/o918P8tWwEtM3thJFE
 TbKNxlpXU/7H3XiLgqhSjOZCePJmdwhIIG37PQm7c1pvmOt2VvCdUPHRWwo5Bo43on+O
 +stbYSUTnUNFlg7rjEaSEDNahUOfG9YE/PJzt/BslNy53WNzhWZ009d94UupfmaNpiOr
 gWlJtTbyEWQRq8FsP/b1oyMbAS8R+UbPL0oNaCDMRy8gks9MlYhuRH0RqVWRnyeRjUYt
 Wedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747977454; x=1748582254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJMRmx/pYEwa9T6EEOgKU1jspKNqvj9etLxJNDGFFAU=;
 b=W9DpOIKs3+M1rl7YD2a5Q+fq091B5yKkPf5DXwj8TKczw/dDlBmCcWXed+Vz0PQcY6
 U8OEE+CBewzNzKf1AbofN1tSsIAYo/tpsFumaBZvp4lRoo2Giu/Dfh5rL8kb0sHMvoNO
 Om/utSM+whAyHJgConUmI4y6kcQdhLXNFIyOQYbATzuDsMhGdaBa4XZkHXPh7Crw8JBS
 auUENKIRLXJFvI5Hehq3rJn7DRmXPA3Y6IxmEs0x8G4GEBvNlIhWfoHHp3bBSZPa6bOc
 NCVuaBEdyWaN6z1RrhIysYic6dwW9KYKWD3o96OqNvhbtYV9yCOlAFmyILxcU/z7KEbr
 WhvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWJhNMpy390NBEXAIZW9YTXyP0uW1x39NuMGxo0Q1cuI3yGYOx+XtBlf5A++6m0vX9xIgAx91vA6RN@nongnu.org,
 AJvYcCX+UMF8KatuwimcUL8Ymd1P6AFyRm5W3Q/VrCIt8zeyVjlhAs/HxHI2TnknuWo5mkIawfwLx54GjTAAVqH9@nongnu.org
X-Gm-Message-State: AOJu0YyRDuGGmFK+NDLsL83ZaLK0Rou5qSrcvO2oKK2U48k1lKIUwP+i
 RSGC59Tg4uoMCLR0vD5y+Ryl+erZqAPH/xO5JHVCnVVMImZ5/r+tNVkTDmRmmIklQTHPcw6Thoz
 RQiJ0M9KorOQPqCiN/NBxJIBnnath6ic=
X-Gm-Gg: ASbGncsQQj59HkCbTWAeTG2RNUHRJPphsIbfaGy8LhFQKzvDTLKc6gb3mYybrBeCkCO
 h8xbAaR2YmJw6RvHI9RsCX7GL00ZGmp8FHGeii277pMfB/gYa3U+sHL48ObjE/DONdDmwmzRjmJ
 mXqprR2hkNhHyw4BT3SqC1oOUaf/tPtkHM40j4hBf3xZyzRbCtXX0DrgLSRxruMWsNFDh/xURyA
 g==
X-Google-Smtp-Source: AGHT+IHQJDKxSgb9M8XoodvTkaQ0mxIBj2DOMHLX2TPrJmFM0hAV+REaPvGBGMUT9ID67P8SQv6I4vngNXEziPXZ/E0=
X-Received: by 2002:a05:6122:7cf:b0:520:98ec:b25c with SMTP id
 71dfb90a1353d-52f1fcc506dmr1180962e0c.1.1747977453762; Thu, 22 May 2025
 22:17:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250522113344.823294-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250522113344.823294-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 May 2025 15:17:07 +1000
X-Gm-Features: AX0GCFsKYcsHVANWiGBEAMw-HiOuN1juC0s0aomK_HDZxClkArUGcyHDZ13Owoc
Message-ID: <CAKmqyKNcmG=ZnAOaVHK6EW_gyMBm0ZC0nZ1-+tHcqU3DQTejwA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/cpu.c: fix zama16b order in isa_edata_arr[]
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a33;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa33.google.com
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

On Thu, May 22, 2025 at 9:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Put it after zalrsc and before zawrs.
>
> Cc: qemu-trivial@nongnu.org
> Fixes: a60ce58fd9 ("target/riscv: Support Zama16b extension")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 629ac37501..fe21e0fb44 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -127,8 +127,8 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> -    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zalrsc, PRIV_VERSION_1_12_0, ext_zalrsc),
> +    ISA_EXT_DATA_ENTRY(zama16b, PRIV_VERSION_1_13_0, ext_zama16b),
>      ISA_EXT_DATA_ENTRY(zawrs, PRIV_VERSION_1_12_0, ext_zawrs),
>      ISA_EXT_DATA_ENTRY(zfa, PRIV_VERSION_1_12_0, ext_zfa),
>      ISA_EXT_DATA_ENTRY(zfbfmin, PRIV_VERSION_1_12_0, ext_zfbfmin),
> --
> 2.49.0
>
>

