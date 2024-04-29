Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I4D-0000Nn-H5; Sun, 28 Apr 2024 23:52:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I49-0000I2-Hk; Sun, 28 Apr 2024 23:52:34 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I46-00088B-L5; Sun, 28 Apr 2024 23:52:31 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4daaa559464so1123945e0c.2; 
 Sun, 28 Apr 2024 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362749; x=1714967549; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f0/WqjT51VC0Jp2loiFnz7qPiAwo7CYOj5TZd7WtvbA=;
 b=PPDXh4QVUANpH4wJSyUrPrax6deTkgU2NvBh8KfvX9NBwQPjOjJzcsQk5SNLM/5BE2
 O/siUFXOc1AiUtlk+de5NGP/F9K7nrJTptbChwGZ31QVaaitOjsyNbm8YNoYa6cLe4NF
 JprW96DEuS5j80/Tu5kzRG15TcywrtJ4IHieaDEcR0U7YhTyjx4MCi8DtRXw3GAvke5H
 8CqhxQR1Urna8YB1MOC34kfU0mMeUG6K30uUjFJTFKKos1nhvPWyn5M/G6fO097QwIoH
 Ofd3ubFcVwjXatmca2cpxJHQ2beIaCR9xPMnLzm+kM4mH9xiFublDlT4lf0jpL/YSZkr
 X7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362749; x=1714967549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f0/WqjT51VC0Jp2loiFnz7qPiAwo7CYOj5TZd7WtvbA=;
 b=r+d2hGZfQU6iGKbgF8tZufJ5AF/kPjnBoNdoGAJZBvM0Z4cTYFTkMEcvn05t4L5Y4j
 TGKpjs4Ui7aMu9YYiTBvOTVYR9+l2p+gDvuz5e5TtEeRKmLoOszt9+bDPMZnoX4mKKzL
 oz2XBEgjiz71suSQno7KFP3rdx1N92uyDo4LRQtHlYmpFH9BTCDM9fixzGaCLwfxx4GI
 AVAR8bY9LUPmModo+7jFjbBsEAlhqZ5acPs5gFA92kLOL/QPAJxL/e/zT50/ty8qj55l
 +IlktnJayuuOvEYBs7hArtNnL5sSu+IgwUQKr7cnapwLCXamKj13CtKf/lrxM0vQjXHf
 A/Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXp40osqD0jX4qMgcbqqrUdq2jk8lWZ3rZLM9EMK4//utyPG8T7LMfptN7OafrpjTlQYNuuwRYzpOhbrhTrM0Txi2Vr9J+SgIpBHxNexRjuKYqg6XCwP6Q0L6E=
X-Gm-Message-State: AOJu0YxnByLM4bBTcuUTwDnBUBtPqofqE2+Not/KIiqarcEN3R+fIJZp
 pTvBjjMRzdhIBfJfU6djlvo60n607zdK8xuGkS3sdQ5AHfO8v+jDWc72ZJjxF262VfujZqn0tcP
 MeFHmK1BCfLF4Zb9zJA8NJpXSFJ0=
X-Google-Smtp-Source: AGHT+IGCZN7Xgl3TtC9ylGHvDHdCVCPTVw/07rVPtdQS6dPGiyGiGzYW5rxyMz2MxI1MQuB/WZkSsdpsX5qOQEfNaZI=
X-Received: by 2002:a05:6122:4691:b0:4da:e977:1fb7 with SMTP id
 di17-20020a056122469100b004dae9771fb7mr6890244vkb.15.1714362748720; Sun, 28
 Apr 2024 20:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-8-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-8-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:52:02 +1000
Message-ID: <CAKmqyKNVn9KMsU4d2WW_Gwgcu=M7WetRBJPnZUgQVjVKttC4zg@mail.gmail.com>
Subject: Re: [PATCH 10/12] tests/data/acpi/rebuild-expected-aml.sh: Add RISC-V
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Fri, Mar 15, 2024 at 11:10=E2=80=AFPM Sunil V L <sunilvl@ventanamicro.co=
m> wrote:
>
> Update the list of supported architectures to include RISC-V.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/re=
build-expected-aml.sh
> index dcf2e2f221..c1092fb8ba 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -12,7 +12,7 @@
>  # This work is licensed under the terms of the GNU GPLv2.
>  # See the COPYING.LIB file in the top-level directory.
>
> -qemu_arches=3D"x86_64 aarch64"
> +qemu_arches=3D"x86_64 aarch64 riscv64"
>
>  if [ ! -e "tests/qtest/bios-tables-test" ]; then
>      echo "Test: bios-tables-test is required! Run make check before this=
 script."
> @@ -36,7 +36,8 @@ fi
>  if [ -z "$qemu_bins" ]; then
>      echo "Only the following architectures are currently supported: $qem=
u_arches"
>      echo "None of these configured!"
> -    echo "To fix, run configure --target-list=3Dx86_64-softmmu,aarch64-s=
oftmmu"
> +    echo "To fix, run configure \
> +         --target-list=3Dx86_64-softmmu,aarch64-softmmu,riscv64-softmmu"
>      exit 1;
>  fi
>
> --
> 2.40.1
>

