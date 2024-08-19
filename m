Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C680C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:55:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftTo-0003yb-VQ; Sun, 18 Aug 2024 23:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftTo-0003xv-1B
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:54:52 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftTm-0000qO-FZ
 for qemu-devel@nongnu.org; Sun, 18 Aug 2024 23:54:51 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4f6c136a947so1848253e0c.1
 for <qemu-devel@nongnu.org>; Sun, 18 Aug 2024 20:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724039689; x=1724644489; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8BO6l7mC5NXpsvJ5wba4Hao4PwcJ20LnJHXCz45vtPE=;
 b=iweZm1JEePzmgaP3clrTbn/fMNd8gKvqXHmEsxyLhgSCdESGZu5skwCOZzJmA/IL7Z
 iztBdCsEWeRZkJt1Eayh4IqSmbzs1GUjG1fUlJtOV8WZXAxEU7oegXoFTBSB3E6fXFPs
 SidxCcto+T9GIGIK8/+3x/FQlUqMV1XbeUutUrq11zi0xRCWcS3UKgG/BSkHLpyPVBgJ
 Gpf4t2lKe4Gg/UxzHG1dyl8DebcpVq2uWIvLy8az8ODSYQJ+Xya+YIzFrYtXFf3+wl5e
 hmrjFC74Yn8CowZmSNwHSIGSdiB7OrDiU2faVOtmZ+T6rGrP4tYtH4SxnpFCFya6wLio
 zjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724039689; x=1724644489;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8BO6l7mC5NXpsvJ5wba4Hao4PwcJ20LnJHXCz45vtPE=;
 b=TuzUIFMJQbTdiieCwk72eVOXs5faIV81J2Ep1HbVLX/bDLiko9UxWCMg6/zmX40wwo
 c1armBJo+2a+0214INtd3/iISOdhbA8JkA7GIjkMcK7HzLaExn0QN9l+ehKCJNnnab+1
 odwpYC0xklYjVP+N8aaRtI8XfJzfpv96HLGOfqRzIRToOYLGhU6L41D+5TxL2nVNjvWd
 7AC624ssD/VZdgZ86Zowg6R8xfNiJI0dPj/PPL1WTLG8Qe1OBpYnQtWGhXbq0ZrLsIGU
 52EJyysFCEYlKEJA1UhbDqEePMeAmeQC1TLGg2Vkm6qxC6uWLzk2HScwntWldIiFVtXK
 eA0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVz5+KpODMTLGTdqtG3X8xEgPj9pmCl9NO4M+gGTj8ztoSnLHDxJEIqUeAt+ALdAn43DlUJjoYaJlMw@nongnu.org
X-Gm-Message-State: AOJu0YxwSeWX5N2KMSv4b9DYoLg84bajTQ2WwnFOXnFJ8owrj4TaP5vO
 LHb8MWwJUKVXvejuCpdn0CuGlLSURy2v8vbhLcG/fjG0EbaY/2KadkOzYgu0fFPdR5ukyHNfgjF
 Al/TLQnMgOKyMh+KkIrJ3xijTVPw=
X-Google-Smtp-Source: AGHT+IG3EkUEbNBzuCKrr4AXvmWM0C9xeumgbkKABbr6LbBGfrTiV1WblJd5GzUwxeffaPytyfH4S6/eqXnXuuGluig=
X-Received: by 2002:a05:6102:3ec9:b0:48f:db40:99e9 with SMTP id
 ada2fe7eead31-49779653069mr12622661137.0.1724039689280; Sun, 18 Aug 2024
 20:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <0e30216273f2f59916bc651350578d8e8bc3a75f.1723172696.git.haibo1.xu@intel.com>
 <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
In-Reply-To: <a6f7e1a4b20ff7eb199e94ca0c8aa2e6794ce5b2.1723172696.git.haibo1.xu@intel.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 13:54:23 +1000
Message-ID: <CAKmqyKMu3bHL61Fcoh3r3OeEyZ8BhJXq-TTRC19DqMKj2Xsw8g@mail.gmail.com>
Subject: Re: [PATCH 2/3] tests/qtest/bios-tables-test.c: Enable numamem
 testing for RISC-V
To: Haibo Xu <haibo1.xu@intel.com>
Cc: sunilvl@ventanamicro.com, alistair.francis@wdc.com, xiaobo55x@gmail.com, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Fri, Aug 9, 2024 at 12:50=E2=80=AFPM Haibo Xu <haibo1.xu@intel.com> wrot=
e:
>
> Add ACPI SRAT table test case for RISC-V when NUMA was enabled.
>
> Signed-off-by: Haibo Xu <haibo1.xu@intel.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/qtest/bios-tables-test.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index 36e5c0adde..e79f3a03df 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1706,6 +1706,32 @@ static void test_acpi_microvm_ioapic2_tcg(void)
>      free_test_data(&data);
>  }
>
> +static void test_acpi_riscv64_virt_tcg_numamem(void)
> +{
> +    test_data data =3D {
> +        .machine =3D "virt",
> +        .arch =3D "riscv64",
> +        .tcg_only =3D true,
> +        .uefi_fl1 =3D "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 =3D "pc-bios/edk2-riscv-vars.fd",
> +        .cd =3D "tests/data/uefi-boot-images/bios-tables-test.riscv64.is=
o.qcow2",
> +        .ram_start =3D 0x80000000ULL,
> +        .scan_len =3D 128ULL * 1024 * 1024,
> +    };
> +
> +    data.variant =3D ".numamem";
> +    /*
> +     * RHCT will have ISA string encoded. To reduce the effort
> +     * of updating expected AML file for any new default ISA extension,
> +     * use the profile rva22s64.
> +     */
> +    test_acpi_one(" -cpu rva22s64"
> +                  " -object memory-backend-ram,id=3Dram0,size=3D128M"
> +                  " -numa node,memdev=3Dram0",
> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_aarch64_virt_tcg_numamem(void)
>  {
>      test_data data =3D {
> @@ -2466,6 +2492,8 @@ int main(int argc, char *argv[])
>      } else if (strcmp(arch, "riscv64") =3D=3D 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {
>              qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
> +            qtest_add_func("acpi/virt/numamem",
> +                           test_acpi_riscv64_virt_tcg_numamem);
>          }
>      }
>      ret =3D g_test_run();
> --
> 2.34.1
>
>

