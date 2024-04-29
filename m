Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DEDBC19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1I5k-0002cJ-5x; Sun, 28 Apr 2024 23:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I5f-0002bO-S7; Sun, 28 Apr 2024 23:54:08 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s1I5c-0008H6-QQ; Sun, 28 Apr 2024 23:54:06 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-7f00a9fc1f4so675888241.2; 
 Sun, 28 Apr 2024 20:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714362842; x=1714967642; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7dgUWsHYpbbhlXlR+BJ7ZnWLEwWj1cUFlUVxhU5bESM=;
 b=GLcK6hyGAOD05phRB0eP7GXnCBUV4zBaipb4xXE7jCuAvt8XuoRU6LZtcckG/WNzVJ
 NJwdjdRgCLDr2TT878/CO+evvh5liNm/X4Alfu7YuYTih+hqNAUJbgON2bhTpZcfh22u
 V+kZGBNqCRk1vEoUoWoZOUMGXLvdDEkicbkaAwY+O3ai2EsTFRocuqgrNWHhfVu9kIqc
 OLI2lKkbs0zkFb8Y0DNmmLIxFhbwfl0HJbbOmxHLBbHdmSOA/LyI+PGL2ugrc/4Tu+RB
 dEWEmrcXYjVXH9MV/3HGDj7XXs6ofrB6UBEmLQSAcJ5bNSZiQRP1m5cqHEdkBPNRT+EV
 WyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714362842; x=1714967642;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7dgUWsHYpbbhlXlR+BJ7ZnWLEwWj1cUFlUVxhU5bESM=;
 b=li/eyhQJyqBVELCA4rJknOYNK9VaaO7NGGnYse2lRzKmuOk9MLxqfMBgYi3cbFJhKx
 WaMFq5AdFDxjvs9mMWbv69KaCx3Uv9GEOfq6agTmdyTqiKbYlLQ5k+El6ReVuPU54Kyp
 XCJw0HngKdvTXOxcpMndn6e+oIa/pmMnhD+xGv1ZZI4/TPFFzqZ8FvdUXoMdExg9e9Mu
 syIeF0Toiy9KwUHW7EcybSbzYxokZXqbKp7rae5XKUxHRaIHsVOQB5k9QmeYFY4ddM6E
 adCN2Uafk6he/CZRFyEte6siTU38AlLmOtJUiUFqCMC+PxNFXqD+wR/2+E8BqR4nj3V0
 nERg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWttbCx9rmETFYY5ZZG+WBHv5hyVaUG07zQaDWvptw9oyiwIjlv90AaqVHhjQ0eEIZDBAlcLfTjWlJ5dZIu2q6B2E99NAlUEVPwdHnjTtpOZjPOFoRWCdiJTQQ=
X-Gm-Message-State: AOJu0YxNCGVtdbGayeVukcTwuGHbnkRVYlNxW3G29kLfTegJK7nkV2OH
 JT2OMN6qwGvx1lIeDYRpqCEFRmuq479/Jj8xw5o+MNTincYddD86smMcNL0b2ikj0BuDQrh1DhO
 O5e3v3T+j/iugYfBNhIpne9w/uNU=
X-Google-Smtp-Source: AGHT+IEP9veUUyds/EHYHCJX6+xdT1+kPsG3wWQR9l1JUDD+SRRnRHsBXlAX2wTVjC8+SJjXcT7Dwqx274lUWpRanmI=
X-Received: by 2002:a05:6122:369f:b0:4d8:5e2f:c235 with SMTP id
 ec31-20020a056122369f00b004d85e2fc235mr9152576vkb.0.1714362841832; Sun, 28
 Apr 2024 20:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240315130924.2378849-1-sunilvl@ventanamicro.com>
 <20240315130924.2378849-10-sunilvl@ventanamicro.com>
In-Reply-To: <20240315130924.2378849-10-sunilvl@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Apr 2024 13:53:35 +1000
Message-ID: <CAKmqyKOSfF+kUK1OyDWRRgV4tkJ=cKQW2J4-_5vh11UNwmC2Zg@mail.gmail.com>
Subject: Re: [PATCH 12/12] tests/qtest/bios-tables-test.c: Enable basic
 testing for RISC-V
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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
> Add basic ACPI table testing for RISC-V.
>
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index c492438ced..033acc8958 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1923,6 +1923,30 @@ static void test_acpi_microvm_acpi_erst(void)
>  }
>  #endif /* CONFIG_POSIX */
>
> +static void test_acpi_riscv64_virt_tcg(void)
> +{
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .arch =3D "riscv64",
> +        .tcg_only =3D true,
> +        .uefi_fl1 =3D "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-riscv-vars.fd",
> +        .ram_start =3D 0x80000000ULL,
> +        .scan_len =3D 128ULL * 1024 * 1024,
> +    };
> +
> +    /*
> +     * RHCT will have ISA string encoded. To reduce the effort
> +     * of updating expected AML file for any new default ISA extension,
> +     * use the profile rva22s64. Once profile is ratified, there may
> +     * not be new extension possible.
> +     */
> +    test_acpi_one("-cpu rva22s64 -device virtio-blk-device,drive=3Dhd0 "
> +                  "-drive file=3Dtests/data/uefi-boot-images/bios-tables=
-test.riscv64.iso.qcow2,id=3Dhd0",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data =3D {
> @@ -2342,6 +2366,10 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_=
viot);
>              }
>          }
> +    } else if (strcmp(arch, "riscv64") =3D=3D 0) {
> +        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
> +            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
> +        }
>      }
>      ret =3D g_test_run();
>      boot_sector_cleanup(disk);
> --
> 2.40.1
>

