Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C69CA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:04:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4Cn-0002ci-1R; Mon, 01 Sep 2025 09:04:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut4Ck-0002Zy-KJ
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:04:14 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ut4Ch-0005wn-OM
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:04:14 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-affc2eb83c5so348609366b.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731849; x=1757336649; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX69E6QOIJE7U4cNB+0scsBRFjpC4rOUc2ysvanrftI=;
 b=jGxyv7nLu4eSfJYoRqofNPa4WbzZdQ9pk9z7HxUueeWLINsmj/meVUTllSbPla0ca9
 hcthgwR/6VCfwS83jjG5oph0SHQuqPgqbbg50Ya9+wiG2v1IvQSCet0VrAv6PDRbIzEX
 zD+jVNdCZf2/IYj9M1mPTGw/NqAedvMj3x5YhJ/LP9QqwUDitphpLBTRLuQDRNpRa7Mz
 fzVyhjV1Bf+V7fqNuoYLhtRvUtQzSpExDGj6O49dAA3ZUliAKtsS/IkEXkHUq763Jq1g
 N5c1biZ4s1f0aCPUY5X5a9uxpGvga4CK2vhML7dEKKJTYX4axvpUYMWfPHc4ITj+bGKZ
 sOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731849; x=1757336649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX69E6QOIJE7U4cNB+0scsBRFjpC4rOUc2ysvanrftI=;
 b=mF0e1rXTuRcOHWROeO81EMaFtBQ5mu9HjaDEq+NWucYcT4pxhLIT86Kw2epUJhlpzE
 dFmfMffR1se6FhOmE9DkHs5+zeXmFu5PRGwdZbiztDmdoWXksUj2CnD/ntoFnKKnfiMR
 F1FH+VHptJWsDHxE5q1nS87brIkCq43SofntkjqqS3ZclhLGDrYDxmlaNoBJz9TLw5xL
 BriOtOLEHMsNVCdArZN9BLc5B4+5AF3y2mZU5AlReL5spL/7VgDhMDPK9CR8BAa6//om
 zz82iWPmRdAhgmfLnTbmqIsl6vvtrUuyxDq9Pt/oWuMQef+2rb/px6JVsG1vcgAnW2vd
 zqqQ==
X-Gm-Message-State: AOJu0YzRHb8MBuepYK0aQSRH/XibHC8h3YD9z0Q2UOseoykIH0EhnueE
 C5PXkQtoCpn77Cn735h4K0MjPaWjvFE8P33BlplwoqkzfmWEYXejc7+kRMgBZ7bg/L2R1WnXjRF
 YWrVVWXGOVBNQhXRFUvLUkgdsyz9iNyMyimexp3Q+iA==
X-Gm-Gg: ASbGncs6edUcsPWOXmU8rXh4BXby0j0JYuRw5bg8bWqWkMZQxrBv+H7C5IpAQeCi/sR
 8cyNQ1065fdiTcW9FZu2PGgNMnzkIagqRXtMhdngdb+ubWSoF2D3PWwN/LTUlS42T9sRgKHQBfJ
 crtYvP3GiHVJ8bXT+FC4is4+tFdvcRbl0IF4tEm4M1ymGn1ESf7cCph6bl1Q5C8mL2lQwr6zUqQ
 KDaVxvKegXx823L9GP10F6fPmG04g==
X-Google-Smtp-Source: AGHT+IERDfC9tNkenxaoRknSmYVaaCZXFAiY1du5RmynL3n07AV0iSwcZHWBewgNQjrgfc/WMK6Lxd6R8Y/Juz7ZC/Y=
X-Received: by 2002:a17:907:2da7:b0:afe:7909:f42a with SMTP id
 a640c23a62f3a-b01d97744a5mr735612866b.51.1756731849008; Mon, 01 Sep 2025
 06:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-5-alex.bennee@linaro.org>
In-Reply-To: <20250901125304.1047624-5-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 1 Sep 2025 16:03:42 +0300
X-Gm-Features: Ac12FXwCaYvfktUGsPLolX4eNn__mVF5Az2zFjDbiHdG_6x14Mq7uoRsOSHu2IY
Message-ID: <CAAjaMXaJ3JEnFLyKbgG5ef9XOOL+c8P3-3U_OrMULxtg6JG70A@mail.gmail.com>
Subject: Re: [PATCH 4/4] hw/arm: expose Error * to arm_load_dtb
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Mon, Sep 1, 2025 at 3:54=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:
>
> Currently all calls to arm_load_dtb will result in an exit if we fail.
> By passing Error * we can use &error_fatal and properly set the error
> report.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>


>  include/hw/arm/boot.h |  3 ++-
>  hw/arm/boot.c         | 35 +++++++++++++++--------------------
>  hw/arm/virt.c         |  6 +++---
>  3 files changed, 20 insertions(+), 24 deletions(-)
>
> diff --git a/include/hw/arm/boot.h b/include/hw/arm/boot.h
> index a2e22bda8a5..fdb99c0c1ee 100644
> --- a/include/hw/arm/boot.h
> +++ b/include/hw/arm/boot.h
> @@ -164,6 +164,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
>   * @addr_limit: upper limit of the available memory area at @addr
>   * @as:         address space to load image to
>   * @cpu:        ARM CPU object
> + * @errp:       Error object, often &error_fatal
>   *
>   * Load a device tree supplied by the machine or by the user  with the
>   * '-dtb' command line option, and put it at offset @addr in target
> @@ -181,7 +182,7 @@ AddressSpace *arm_boot_address_space(ARMCPU *cpu,
>   */
>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms,
> -                 ARMCPU *cpu);
> +                 ARMCPU *cpu, Error **errp);
>
>  /* Write a secure board setup routine with a dummy handler for SMCs */
>  void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index f9d0bc7011e..d28ae8b86ab 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -517,7 +517,7 @@ static void fdt_add_psci_node(void *fdt, ARMCPU *armc=
pu)
>
>  int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms,
> -                 ARMCPU *cpu)
> +                 ARMCPU *cpu, Error **errp)
>  {
>      g_autofree void *fdt =3D NULL;
>      g_auto(GStrv) node_path =3D NULL;
> @@ -525,25 +525,24 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>      uint32_t acells, scells;
>      unsigned int i;
>      hwaddr mem_base, mem_len;
> -    Error *err =3D NULL;
>
>      if (binfo->dtb_filename) {
>          g_autofree char *filename =3D qemu_find_file(QEMU_FILE_TYPE_DTB,
>                                                     binfo->dtb_filename);
>          if (!filename) {
> -            fprintf(stderr, "Couldn't open dtb file %s\n", binfo->dtb_fi=
lename);
> +            error_setg(errp, "Couldn't open dtb file %s", binfo->dtb_fil=
ename);
>              return -1;
>          }
>
>          fdt =3D load_device_tree(filename, &size);
>          if (!fdt) {
> -            fprintf(stderr, "Couldn't open dtb file %s\n", filename);
> +            error_setg(errp, "Couldn't open dtb file %s", filename);
>              return -1;
>          }
>      } else {
>          fdt =3D binfo->get_dtb(binfo, &size);
>          if (!fdt) {
> -            fprintf(stderr, "Board was unable to create a dtb blob\n");
> +            error_setg(errp, "Board was unable to create a dtb blob");
>              return -1;
>          }
>      }
> @@ -561,7 +560,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>      scells =3D qemu_fdt_getprop_cell(fdt, "/", "#size-cells",
>                                     NULL, &error_fatal);
>      if (acells =3D=3D 0 || scells =3D=3D 0) {
> -        fprintf(stderr, "dtb file invalid (#address-cells or #size-cells=
 0)\n");
> +        error_setg(errp, "dtb file invalid (#address-cells or #size-cell=
s 0)");
>          return -1;
>      }
>
> @@ -569,15 +568,13 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>          /* This is user error so deserves a friendlier error message
>           * than the failure of setprop_sized_cells would provide
>           */
> -        fprintf(stderr, "qemu: dtb file not compatible with "
> -                "RAM size > 4GB\n");
> +        error_setg(errp, "qemu: dtb file not compatible with RAM size > =
4GB");
>          return -1;
>      }
>
>      /* nop all root nodes matching /memory or /memory@unit-address */
> -    node_path =3D qemu_fdt_node_unit_path(fdt, "memory", &err);
> -    if (err) {
> -        error_report_err(err);
> +    node_path =3D qemu_fdt_node_unit_path(fdt, "memory", errp);
> +    if (!node_path) {
>          return -1;
>      }
>      while (node_path[n]) {
> @@ -607,7 +604,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>              rc =3D fdt_add_memory_node(fdt, acells, mem_base,
>                                       scells, mem_len, i);
>              if (rc < 0) {
> -                fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
> +                error_setg(errp, "couldn't add /memory@%"PRIx64" node",
>                          mem_base);
>                  return -1;
>              }
> @@ -618,7 +615,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>          rc =3D fdt_add_memory_node(fdt, acells, binfo->loader_start,
>                                   scells, binfo->ram_size, -1);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't add /memory@%"PRIx64" node\n",
> +            error_setg(errp, "couldn't add /memory@%"PRIx64" node",
>                      binfo->loader_start);
>              return -1;
>          }
> @@ -633,7 +630,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>          rc =3D qemu_fdt_setprop_string(fdt, "/chosen", "bootargs",
>                                       ms->kernel_cmdline);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't set /chosen/bootargs\n");
> +            error_setg(errp, "couldn't set /chosen/bootargs");
>              return -1;
>          }
>      }
> @@ -642,7 +639,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>          rc =3D qemu_fdt_setprop_sized_cells(fdt, "/chosen", "linux,initr=
d-start",
>                                            acells, binfo->initrd_start);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't set /chosen/linux,initrd-start\n")=
;
> +            error_setg(errp, "couldn't set /chosen/linux,initrd-start");
>              return -1;
>          }
>
> @@ -651,7 +648,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>                                            binfo->initrd_start +
>                                            binfo->initrd_size);
>          if (rc < 0) {
> -            fprintf(stderr, "couldn't set /chosen/linux,initrd-end\n");
> +            error_setg(errp, "couldn't set /chosen/linux,initrd-end");
>              return -1;
>          }
>      }
> @@ -1321,10 +1318,8 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms=
, struct arm_boot_info *info)
>       * decided whether to enable PSCI and set the psci-conduit CPU prope=
rties.
>       */
>      if (!info->skip_dtb_autoload && have_dtb(info)) {
> -        if (arm_load_dtb(info->dtb_start, info, info->dtb_limit,
> -                         as, ms, cpu) < 0) {
> -            exit(1);
> -        }
> +        arm_load_dtb(info->dtb_start, info, info->dtb_limit,
> +                     as, ms, cpu, &error_fatal);
>      }
>  }
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 9326cfc895f..6061e0ddb50 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1803,9 +1803,9 @@ void virt_machine_done(Notifier *notifier, void *da=
ta)
>                                         vms->memmap[VIRT_PLATFORM_BUS].si=
ze,
>                                         vms->irqmap[VIRT_PLATFORM_BUS]);
>      }
> -    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as, ms, cpu=
) < 0) {
> -        exit(1);
> -    }
> +
> +    arm_load_dtb(info->dtb_start, info, info->dtb_limit,
> +                 as, ms, cpu, &error_fatal);
>
>      pci_bus_add_fw_cfg_extra_pci_roots(vms->fw_cfg, vms->bus,
>                                         &error_abort);
> --
> 2.47.2
>
>

