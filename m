Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E2FD9E1F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 23:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvkqv-0001Qg-KV; Thu, 26 Feb 2026 18:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvkqt-0001PP-Sg
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:33:03 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vvkqr-000874-C7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 18:33:02 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-65f980cea07so2160169a12.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 15:33:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772148780; cv=none;
 d=google.com; s=arc-20240605;
 b=Xqa9d1VTESf/NPHpoW6LTfpZCfYI8a9IpCUql14GrmInT0irtI4kkD4A2iOzJYRpnn
 eS6LgoLC8JQeRZyWii7RNiJ7kkGqsA/9PHYaiMqCZ2PFDIryyAr30HnNPiZeuvo1/uBJ
 AYR61LDvudjcVLoQoruyNbZmP2X51xMqotjXpyzgPO1musZJkZuWw0mum8ynGQNKq/Mx
 1hBIhhxQcxPaejmLd3h6eIlAP9iFCSBUs4MsLGNKIuOIaG7s7pk666DirpTo0h0tV/8N
 tiA5XPMCyrIiK2BvkJ65acyZlCAOrXNnlq2CuiUGnZhFOaMlVAvo1etPDTZ18TyNLSTh
 mWzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R38QMhZ0gEM6+wz+fYRPAJ1LAc/0i3M3WKQv0O4Oed4=;
 fh=02yfZO3MCi97EyXeoLg1BYIgpUdGEMk3Yh61+offrCA=;
 b=USuBOLAS/9Lfyj9Wy7ds29QCTKoISPMQ4icMQ8d+DZSFjMtpcSM8sv4S69orLsY0Zv
 RCBkjcRX4ZtXDu4fzQ4LrrUL/AGmhSeo5fm2ywigCu28dIrxLFP8YC+dbkLX3304BmI8
 Q7NusGmEoFL53Lx9GLT4bXWm0sJg3ZPEVesxsqLfdVIxqvgue4IHimtf7zbTTGUi7Sfc
 QVOBep+/geYR2EEe3lVkYj456wI9n0tMaRmDutV/3nzHxyOmlk3IxfCk5K8d+ewVCm4O
 EFlYjZi4KYyoMj2qw+W9F+gv5G8jIdvSOi186Gi6ublOFskDelP8xFZeW3LhqbV+TbXl
 2+4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772148780; x=1772753580; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R38QMhZ0gEM6+wz+fYRPAJ1LAc/0i3M3WKQv0O4Oed4=;
 b=HN3IU2kH7mwGDQ7P1P5ifa6URnpGMeYc08zZAgm5Ae61x1z8iAAHlKsR3XQlLt7X2e
 XoFojTzpd9mz8Hkw8OxVB+sHIKRzHZAVAA7Yn1H+KDzFfMMsoqX7hy7+iQe9h/ElYxoQ
 x05spVRKIzERO4YNwMAAa24JMdmx3R1u3SW+L6BE5tj/X6Ldy8LF0zRLVnOwggKARxZi
 UGOXR8DBoaYf8WwyB3URlK3642St9q8JTIqPn7IyqSS3OKCXQz/MdWZXNZzf1Rs94VYZ
 W1cTxUHlXECJ7jg456lAywYX5xT6znNuHmqXZCkY56YkX7MsOz/v/K6Pis8u9fbBo/xA
 bg8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772148780; x=1772753580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R38QMhZ0gEM6+wz+fYRPAJ1LAc/0i3M3WKQv0O4Oed4=;
 b=CpG1bcwI7IEiJ2DleU1mpHJQcDJu/fNsP4/0laCRLtQgTs6OkJDTen7+QVr0wWYiKf
 mXVHk7wWJ5RxnZA+hr4fAOY6USdTDyE2yovAi1hLungnYxhU8ooPlER9Ln7V0brKRkXI
 9l4UStTfjxnRtXEQMI+LPtae/o0vdPNHT5gp7Wisxt5FmjqyH/gMHsU4rj6YJ95Bn19D
 7JNRyQ+/j2+roqTwTnEc2urrV/1Y6Mak7ifuJ6BN0WrivI6tmBm+tmW+nMmf6wY7sTtS
 31/Y6kOSzt00z0BfiQd3rOtggJC+THa8lvALNlHOc847HYzUjRTekLoSNXxS3BDkFYFY
 j4Tw==
X-Gm-Message-State: AOJu0YyOPCo89EuZHPvb0lz55gNrVsWmvZ0kXlW3k+hTBQyDtAtuyHRx
 FW0Cpljmpw+HqTqq8yAUpwDf3Obzp83ymJZmzQtPo3HPw8NN8qWaxrSslyT+xk8oVkRbxVc19j7
 //4wcpFa6Y/JPe52j7ZV059eXsVQVELU=
X-Gm-Gg: ATEYQzwXCF9t4rssdyOGq86Oa2jKN1UmQy4GF6k2NAPZMJGNqcJvNxsNQ7/CRlPUvCT
 YC/+HamGPuwi+Ou13xwGmlPMt77N2WPzyc7wzN9BfHnCCaBVgSltuuwDei2UiLhitVNf2my7RG/
 s5CtgSfCLUKl/5terzIZFxCoRdYonAKfIEUfewfd2xeAOZTtj1vW/1sm0R0DhOPhXdze9YrTSjQ
 LaV2Rq2KSDe9qtqTjiCM6bUKMnU6kaE84QVgKcGnq/mbMeouWpPJ0m1K5C8Zj+AEk0prl/JSBH9
 o36AL5v5DDAWOLfaNQbCid9HY53dztEgfwz/qXCI5Ft4WJIK
X-Received: by 2002:a05:6402:2706:b0:65f:aecc:4f1d with SMTP id
 4fb4d7f45d1cf-65fddceeaa9mr545791a12.24.1772148779618; Thu, 26 Feb 2026
 15:32:59 -0800 (PST)
MIME-Version: 1.0
References: <20260225102016.200654-1-djordje.todorovic@htecgroup.com>
 <20260225102016.200654-8-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260225102016.200654-8-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 27 Feb 2026 09:32:33 +1000
X-Gm-Features: AaiRm53pZYHqHh_mK_RHsuFk_208oCKEy0uYGj7nqr1br9fbAJuk_LF6xJyQqFA
Message-ID: <CAKmqyKOr0mbz0xksnO-=n0Z3cGbY0FqPTnwfY-7WaesZKewHwg@mail.gmail.com>
Subject: Re: [PATCH v2 07/16] hw/riscv: Check endianness for fw_dynamic fields
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Feb 25, 2026 at 8:20=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> For riscvbe target, the fields for OpenSBI's fw_payload
> need to be in target endian.
> ---
>  hw/riscv/boot.c         | 14 ++++++++++++++
>  include/hw/riscv/boot.h |  5 +++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 6dab521a6b..f13264a87f 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -396,19 +396,33 @@ void riscv_rom_copy_firmware_info(MachineState *mac=
hine,
>      size_t dinfo_len;
>
>      if (riscv_is_32bit(harts)) {
> +#if TARGET_BIG_ENDIAN

This will need to be done without adding any TARGET_BIG_ENDIAN macros.
We don't want to have custom built binaries

Alistair

> +        dinfo32.magic =3D cpu_to_be32(FW_DYNAMIC_INFO_MAGIC_VALUE);
> +        dinfo32.version =3D cpu_to_be32(FW_DYNAMIC_INFO_VERSION);
> +        dinfo32.next_mode =3D cpu_to_be32(FW_DYNAMIC_INFO_NEXT_MODE_S);
> +        dinfo32.next_addr =3D cpu_to_be32(kernel_entry);
> +#else
>          dinfo32.magic =3D cpu_to_le32(FW_DYNAMIC_INFO_MAGIC_VALUE);
>          dinfo32.version =3D cpu_to_le32(FW_DYNAMIC_INFO_VERSION);
>          dinfo32.next_mode =3D cpu_to_le32(FW_DYNAMIC_INFO_NEXT_MODE_S);
>          dinfo32.next_addr =3D cpu_to_le32(kernel_entry);
> +#endif
>          dinfo32.options =3D 0;
>          dinfo32.boot_hart =3D 0;
>          dinfo_ptr =3D &dinfo32;
>          dinfo_len =3D sizeof(dinfo32);
>      } else {
> +#if TARGET_BIG_ENDIAN
> +        dinfo64.magic =3D cpu_to_be64(FW_DYNAMIC_INFO_MAGIC_VALUE);
> +        dinfo64.version =3D cpu_to_be64(FW_DYNAMIC_INFO_VERSION);
> +        dinfo64.next_mode =3D cpu_to_be64(FW_DYNAMIC_INFO_NEXT_MODE_S);
> +        dinfo64.next_addr =3D cpu_to_be64(kernel_entry);
> +#else
>          dinfo64.magic =3D cpu_to_le64(FW_DYNAMIC_INFO_MAGIC_VALUE);
>          dinfo64.version =3D cpu_to_le64(FW_DYNAMIC_INFO_VERSION);
>          dinfo64.next_mode =3D cpu_to_le64(FW_DYNAMIC_INFO_NEXT_MODE_S);
>          dinfo64.next_addr =3D cpu_to_le64(kernel_entry);
> +#endif
>          dinfo64.options =3D 0;
>          dinfo64.boot_hart =3D 0;
>          dinfo_ptr =3D &dinfo64;
> diff --git a/include/hw/riscv/boot.h b/include/hw/riscv/boot.h
> index f00b3ca122..6a6b796eee 100644
> --- a/include/hw/riscv/boot.h
> +++ b/include/hw/riscv/boot.h
> @@ -24,8 +24,13 @@
>  #include "hw/core/loader.h"
>  #include "hw/riscv/riscv_hart.h"
>
> +#if TARGET_BIG_ENDIAN
> +#define RISCV32_BIOS_BIN    "opensbi-riscv32be-generic-fw_dynamic.bin"
> +#define RISCV64_BIOS_BIN    "opensbi-riscv64be-generic-fw_dynamic.bin"
> +#else
>  #define RISCV32_BIOS_BIN    "opensbi-riscv32-generic-fw_dynamic.bin"
>  #define RISCV64_BIOS_BIN    "opensbi-riscv64-generic-fw_dynamic.bin"
> +#endif
>
>  typedef struct RISCVBootInfo {
>      ssize_t kernel_size;
> --
> 2.34.1

