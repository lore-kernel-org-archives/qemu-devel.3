Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896E3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I0b-0005uh-UM; Sun, 28 Apr 2024 23:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I0Z-0005pJ-Kn; Sun, 28 Apr 2024 23:48:51 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I0X-0007iT-RW; Sun, 28 Apr 2024 23:48:51 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4dac88c79f2so1248693e0c.1; 
 Sun, 28 Apr 2024 20:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362528; x=1714967328; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oHOc9D23JqyBCmNAk+vsQzpv7nGT+rqRLt6cYkNKsC4=;
 b=OuymwyqiTIUyrsUOOm5se7Sz94Aqmsi9kkJt0a+lxxyE52ptEYPzj7BIDuR4Mn1uzv
 OnqfzWSZ8dXZJ8B8TWhavII++ATuhOR01OYZzTEQJ7nkryL/5EO2HIURsP1ErDTdge9W
 l1MaloCLULqDrVCsnXQAzl0vUUy10NJXWVWGBxO6/K15OM0f7solpyi/8CEkCyOdOP8F
 L9cN/3MScpwmRXWaTWro3fxkOlplAyR+YgmTRCfwXE4jurEzJYmWem5RXRA1+XsEId6D
 qZtz1jZ/ZzCf/AN3OEhv69G943jS3pr3QyiX4tCyckox4RK4bus8ghNpwGkZ7VWlvtX0
 Aqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362528; x=1714967328;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oHOc9D23JqyBCmNAk+vsQzpv7nGT+rqRLt6cYkNKsC4=;
 b=TcvNTI7/DTfXc2dg55cTtdFzXnNPkcktYmngKM74Wvqq21//R/Tb5D1FrTwqDmMn5h
 0SMu9tsXELA0C2feGElcHu8n4MQsZAFN8eWn71AalVak0z4p8+rICJeLH85McRDakVWV
 U6I353lqzd7vQ1S0GOwwnvauLBQ8EwvBRSTks3pinJXC/KeweMZNJSGUZbnAcEcVbkQT
 SFz8P6e1EF/RDI/xGBEcaIIFBPGRjjMMk2lgG6GkxJnzp3fGvidtERTXeIBKZQpLjZU+
 FFwvPB7WPd4n4ioC/YdGN6YwLCIXmEctJJZbV0wxl7RD1vE8QxfYdkL9/jbPqcHAxaao
 dqVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRMB9DoOXd62tDHFmeMShtXSYsHl7pX9GVpxvI650XzUJwd51o14jw6+uH+Tff4k2cKzi4bUXuDT8h/u976LKpoyURkBQPGnRUbikuASK7AJ/9inuO1G1AyEU=
X-Gm-Message-State: AOJu0YxXCZrS3M4ZepcLI04bkupohdVY6wGMG+Ct7MX+6ADFznz1StkU
 m3r9oKjdprjLmaRzT/8SHv++dXd4/YflHtL1N4mdxGqSTOLbtB66If5EIZ6PRyh6WqeubZKLMis
 rBoncQWn+pzpwRmE8NxnqSNDNg3k=
X-Google-Smtp-Source: AGHT+IE5TiLI50GY+wb6yvBn1f2eFlPde5HNeXJ3l9oxNeKnSU2Yf9Qei1YWFkMrYlq4LmTwD3uYSFuzDw8pm6KxpX4=
X-Received: by 2002:a05:6122:2522:b0:4d8:7359:4c25 with SMTP id
 cl34-20020a056122252200b004d873594c25mr9997240vkb.12.1714362528131; Sun, 28
 Apr 2024 20:48:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-6-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-6-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:48:22 +1000
Message-ID: <CAKmqyKMRJnNJPZq=zYKR++se22N-PqoA+eMiQ=eHv54b+ogKmQ@mail.gmail.com>
Subject: Re: [PATCH 08/12] meson.build: Add RISC-V to the edk2-target list
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Anup Patel <apatel@ventanamicro.com>, Haibo1 Xu <haibo1.xu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa32.google.com
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

On Fri, Mar 15, 2024 at 11:09=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> so that ACPI table test can be supported.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index b8ded80cbe..bf50688593 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -93,7 +93,7 @@ else
>    iasl =3D find_program(get_option('iasl'), required: true)
>  endif
>
> -edk2_targets =3D [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x8=
6_64-softmmu' ]
> +edk2_targets =3D [ 'arm-softmmu', 'aarch64-softmmu', 'i386-softmmu', 'x8=
6_64-softmmu', 'riscv64-softmmu' ]
>  unpack_edk2_blobs =3D false
>  foreach target : edk2_targets
>    if target in target_dirs
> --
> 2.40.1
>

