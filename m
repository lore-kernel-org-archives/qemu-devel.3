Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691BCE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 03:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tN1wN-00046Y-99; Sun, 15 Dec 2024 22:38:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN1wL-00046P-FD
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:38:37 -0500
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tN1wJ-0004JK-Ua
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 22:38:37 -0500
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-4afdf8520c2so1050062137.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 19:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734320314; x=1734925114; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5Auj5bXvIU3M/ZhTOO5T/5v0/M+U3l9IKRi2L9eQWQ=;
 b=JKFEXDB7iAYCfSbVA4FnKWK09cDjlP5Nct2ijrCWB5WLelrFD3FfwGPH7Dmr8/ujqo
 6TjbiKeJoEOZNduOBZ1TN2KoZ4f9mrwdTbhwQdcQqLx5zuKoyzYlYrGQvG0CjE+Mxwxb
 IkWRWNqP5z9ITW+yjmOzd/OHSLYtgtMfYd5WaVI04UfYiTVDNdBkVltaNqtzGtoFUOFh
 l+hf9izfZkoD3qh7POtNzkSHpJGeiwl6y8A9VbKm12a7rWxW1fs8KSAz+U5I94YHLLPb
 4jvIw2Ct/vQva6qCZMkkRlzVFF4n3w9ZsHxqV1P352RTkZxN7RxQtafR1bpfzZW9t3Ll
 sBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734320314; x=1734925114;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5Auj5bXvIU3M/ZhTOO5T/5v0/M+U3l9IKRi2L9eQWQ=;
 b=on05l43RzazWtVDwyIQsbBeG/iIXnbodpa/zYU9gUhleZMjazZ9Yy32kpz1/Ci2CPd
 ndP8B8RCLysPom2KNvSfghjXm1xTul6s22VZToX5f2Du3Qjp09jiuoFekBiY+iDW8NcQ
 rDq1cKoNHZFSDYCCtXL0Gon/aM5ZhXeq+fDGa3nqADUydysFrHIR6PxsOL2DvYCNvEhx
 nO7ZWgnRshxcW27aAjSyVqqaRlXouUZnxir4D1nNmfYR5SAUXhPXbJXH9oPC2QO1UE0l
 z1BNFnwBL/w3pbDkHyjesPN9r9RMakPbo+PZLRL6zOSzcjCiIihgpwqOjJTqSPI/K1Q8
 5c2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCURBzBHwzepI0yTrjO9OGotnfr4jn3302FH5J5oqYRJgmjlAOvE7QEuSJHjOpZ+uc0kBX8O0qz+qOi7@nongnu.org
X-Gm-Message-State: AOJu0Yyb2UOqDl2jOuMy5hhxzb0WINMc3ZM58dD2oAczGdqV+r8Iyv8A
 V/mmW1aWahkorcREGsRM/wCDCrXPCiUNXMe/rYnYdPUARhcn5p65sqUh3pT1xhvZCWU+7I/bYnS
 Efndqtd0mIKREDMpfxYPTsa/ESZ8=
X-Gm-Gg: ASbGnctPaGJDP/4UYLgbEQ9L7M8w6151YjgGBYeCSUoMAhdDrfpgmPizcyeDqkIpOYm
 u/GteJhgK1EhRzFS9IoeeZj6H9zelZy51shNmFcKuvTKJnvHTAjZG+9POpfxAo9NhdIwc
X-Google-Smtp-Source: AGHT+IE/3eg8u06pcWg0r9WtT2b69NXT5IgfpSE7JvyDe/KCac26TZ/BOoWjS2IuTm2i2snmnJHEMz8wzbxZUKBD6vU=
X-Received: by 2002:a05:6102:3e85:b0:4b1:5cc6:92df with SMTP id
 ada2fe7eead31-4b25d9d5deemr9371253137.0.1734320314157; Sun, 15 Dec 2024
 19:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241212090059.94167-1-heinrich.schuchardt@canonical.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Dec 2024 13:38:08 +1000
Message-ID: <CAKmqyKObo+01P6WUK9OpkPHX++htMdYK+r+7HA27mLEVyi0+rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pc-bios: add missing riscv64 descriptor
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
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

On Thu, Dec 12, 2024 at 7:01=E2=80=AFPM Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Without descriptor libvirt cannot discover the EDK II binaries via
> the qemu:///system connection.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  pc-bios/descriptors/60-edk2-riscv64.json | 31 ++++++++++++++++++++++++
>  pc-bios/descriptors/meson.build          |  3 ++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/descriptors/60-edk2-riscv64.json
>
> diff --git a/pc-bios/descriptors/60-edk2-riscv64.json b/pc-bios/descripto=
rs/60-edk2-riscv64.json
> new file mode 100644
> index 0000000000..14811ca307
> --- /dev/null
> +++ b/pc-bios/descriptors/60-edk2-riscv64.json
> @@ -0,0 +1,31 @@
> +{
> +    "description": "UEFI firmware for riscv64",
> +    "interface-types": [
> +        "uefi"
> +    ],
> +    "mapping": {
> +        "device": "flash",
> +        "executable": {
> +            "filename": "@DATADIR@/edk2-riscv-code.fd",
> +            "format": "raw"
> +        },
> +        "nvram-template": {
> +            "filename": "@DATADIR@/edk2-riscv-vars.fd",
> +            "format": "raw"
> +        }
> +    },
> +    "targets": [
> +        {
> +            "architecture": "riscv64",
> +            "machines": [
> +                "virt*"
> +            ]
> +        }
> +    ],
> +    "features": [
> +
> +    ],
> +    "tags": [
> +
> +    ]
> +}
> diff --git a/pc-bios/descriptors/meson.build b/pc-bios/descriptors/meson.=
build
> index afb5a959cc..cdd0be01a3 100644
> --- a/pc-bios/descriptors/meson.build
> +++ b/pc-bios/descriptors/meson.build
> @@ -6,7 +6,8 @@ if unpack_edk2_blobs and get_option('install_blobs')
>      '60-edk2-arm.json',
>      '60-edk2-i386.json',
>      '60-edk2-x86_64.json',
> -    '60-edk2-loongarch64.json'
> +    '60-edk2-loongarch64.json',
> +    '60-edk2-riscv64.json'
>    ]
>      configure_file(input: files(f),
>                     output: f,
> --
> 2.45.2
>
>

