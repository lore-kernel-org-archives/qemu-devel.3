Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06774C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 08:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuncL-0001HR-87; Fri, 14 Aug 2026 04:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wuncJ-0001Gi-Ju
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:50:19 -0400
Received: from mail-yx1-xb130.google.com ([2607:f8b0:4864:20::b130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wuncG-0004Zu-Mu
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 04:50:19 -0400
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-66c70f0e0e6so597287d50.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2026 01:50:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786697415; cv=none;
 d=google.com; s=arc-20260327;
 b=VQEcifXjw2VcTXlgdn4ykZX1k0P9v5aPEXYWI785jA7xs/Rl3JcHEIhizwGhGQbmpT
 YXdz5TdSFFX3UvfI/lmZX4zcut4qtaFjAi/oYdFCk5CaxWvTPYC8sy8qgFmfrGQhxA+l
 PGyy8bgkK32UaCscqd33f41oigN8N0djappm8vcqh+EkZVaO+lEMeDvkj7qN1rygFH0C
 onhpOnbqR7yfDkuzWsNtKOaKLMxjIXytb2KfwaaGv2FlNofCGgfzK/sRGe6R9ImWgRvP
 MD8Y2I36/9LNoLLAMxCyJPsMZhAL6e8raH9D0ssvDtjNaoG1nnoLdjGMhhTSQd6Lq5QY
 xK0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5ug2Cwv5CY9AJzlLXhtbf4pElyeEH/Yo0tsTt3yjTOo=;
 fh=zRNh30C6eo+SccpBSZ0xYa8/oxmUsEvaFi9YJ97S6RU=;
 b=YVIBO3agYxwPV2WAkA+js+MJ4/4ASjs1jBhCxnDso9LJLiCc9lxb5Ytvbaezly+WyE
 4prXOmtV88JVlSXXgJGu9DOL3/TVAcU92IaHF2o1kGFOPZnMiUZTj4MCpPLjS0UyU117
 Ii98FmDmO546P0jKiDfgnY4pMDyQCmRaoNxgTEBDjLx07YoNXBz/y3bysQfpyknQ6XN9
 6Cdk9HjPdd5qL4D2KvSxfKDtcvRA7ul2pWNd5bsrmEd01CWNETB7JiJxSm8MpFAK8jpd
 s+pP+5MnR+NvXH3/E6NisW/D+pyMN29SBKp4Coa9r4F9i2mJbnDWOxTqEgUrcUmt8U6z
 swiA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786697415; x=1787302215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5ug2Cwv5CY9AJzlLXhtbf4pElyeEH/Yo0tsTt3yjTOo=;
 b=dV/wbSnP4yKjT95HyjOKL+yNhoirPoPB4J6o8p6O/Rax54IlxjA0BHjj6Mn/jieGEu
 KKK0p6wgjT/kaU265KcTK7BRrViaeXmxTPjxY+rYkYy/q6d+ju533LCRMYsIYhl/y/ou
 HTSoBC8vgjEm5PAG7NXijnWTNwStEciPKCmb12/RF0olORJo37uC0kmEo7K9stuQ1tW+
 POkxIKVBuT9wqnC6NciNJ7/IoD7N+mbxTZA3OGrveCABtgvI1Lk7vEuWco373BJE+KRm
 Vsf7bEOAOJn9qak/3QTQaIS7lpI+YXFInnreeSPlxaz0LQ7hJfv/JmIZelC3H6TrsZvG
 xHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786697415; x=1787302215;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5ug2Cwv5CY9AJzlLXhtbf4pElyeEH/Yo0tsTt3yjTOo=;
 b=OzI6SR0FfaqazMFQlumblPxUaKn7Ze1Zigmzlu7SgZnu5bO1mmPaGB36YilzDlyYRk
 8Ai5EPT2EPGIXOjGXsq0AlSiqHJRmp1wjmY501TDGTSBYG7NcCW/b1fq8h9EM9ENJSYs
 j9Ju1n1rLG/BTJ9wUq2Ak1Uwy/DT1D14rARD3c9nwdHkgQLgnsZTCZEh7TwRuJgSAy01
 SPU3hXYDQJlat2fpTD367SkkXWR8QBvuGQ6VsrDOGXjm94ZaU8VLCXidrm/E4v4J/uZk
 l8hrSl5vVI2lBRwFT5v3Obye0Af/er7XtfFTVaMHXAqFpuhIr47wL3Ld4dg1gwzBL7Jy
 HIMA==
X-Gm-Message-State: AOJu0YwFDwJrT6GJmAKgNsLY4kGXemFUD3c2ax845ntDR1GIm/e5kHz+
 bufAf+ID5rWtQ3OGw5FVLzCXkdYUpY37Z4mbJWLRVQZmuX1aN7IUYmrCTstraSkE2q/Y/cV+xGk
 T4j8g2pVFIjogDX1hgtzr31RGcMn1opw=
X-Gm-Gg: AR+sD12/jYin3gv2ITMSyirzAk84dh174FcHVrCl6/wqhzAdPMlR0RzQcwl0FeT0I4Z
 CLgMuAO1RP+GDrAQP+HsMWsDrKAoUFsO5nA6mplacje7oRwB9XY0/fXX41pNwiUz0qrs1+10ULw
 NHqC3J4md99yfv6WBdTrHIX6qiPj7Quq/LwJWCI+hEs1lfNZh3ng1ANnaMX5irwz0BFYtof4/0k
 enFanyfsk00sHXmGCrpWzhc9bkAMo2KYLpOxpZhg4MZf2dzqdnSqhryuKDRdq6ooHuo0BT1WyG9
 WXtabrGS6e5JdM3Sl37g3yn8KOLKjYrCgUNBQe21xcF3Ens8EDkfatQ=
X-Received: by 2002:a53:d645:0:b0:66c:5045:d9aa with SMTP id
 956f58d0204a3-66c72c81967mr1236135d50.29.1786697414955; Fri, 14 Aug 2026
 01:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260729105904.272939-1-xinxie908@gmail.com>
 <20260729105904.272939-2-xinxie908@gmail.com>
In-Reply-To: <20260729105904.272939-2-xinxie908@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Fri, 14 Aug 2026 16:50:03 +0800
X-Gm-Features: AUfX_mznuXqkAog_imAg2PoCVfyZfdTgWnR7V6SGw08zn5I14p25jN1botuRwhg
Message-ID: <CAEUhbmXYYzy8=Sj7cBvFGLx8ArERHqHF6wtECLp_9yz+7_dm0A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hw/sd: add Kendryte K230 SDHCI controller
To: Xin Xie <xinxie908@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b130;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yx1-xb130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Jul 29, 2026 at 7:56=E2=80=AFPM Xin Xie <xinxie908@gmail.com> wrote=
:
>
> Add a minimal K230 SDHCI model based on the generic SDHCI model. Reuse
> the generic commands and data paths while providing the extended register
> layout and documented reset values.
>
> K230 SDHCI controller contains the standard SDHCI register block followed
> by preset, extension pointer, PHY and vendor-specific registers. This mod=
el
> implements the preset and extension pointer registers as read-only, retai=
n
> writes to most PHY and vendor-specific registers, and keep PHY_PWRGOOD
> asserted so that the K230 SDK reset sequence can complete.
>

Please split the k230_sdhci model into 2 separate models:

- One is generic Synopsys DesignWare Mobile Storage Host Controller IP
model (hw/sd/dw_mshc.c)
- Optional Canann K230 specific wrapper glue model to the dw_mshc IP
(if the generic Synopsys DesignWare MSHC IP model, or plus some unimp
region, is good enough to make the software happy, no need to create
this one)

> The SDHCI version is set to 3 due to the absence of ADMA3 support in the
> generic model.
>
> Signed-off-by: Xin Xie <xinxie908@gmail.com>
> ---
>  MAINTAINERS                |   2 +
>  hw/sd/Kconfig              |   4 +
>  hw/sd/k230_sdhci.c         | 311 +++++++++++++++++++++++++++++++++++++
>  hw/sd/meson.build          |   1 +
>  include/hw/sd/k230_sdhci.h |  82 ++++++++++
>  5 files changed, 400 insertions(+)
>  create mode 100644 hw/sd/k230_sdhci.c
>  create mode 100644 include/hw/sd/k230_sdhci.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6171cc7494..06285352c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1826,8 +1826,10 @@ S: Maintained
>  F: docs/system/riscv/k230.rst
>  F: hw/riscv/k230.c
>  F: hw/watchdog/k230_wdt.c
> +F: hw/sd/k230_sdhci.c
>  F: include/hw/riscv/k230.h
>  F: include/hw/watchdog/k230_wdt.h
> +F: include/hw/sd/k230_sdhci.h
>  F: tests/qtest/k230-wdt-test.c
>
>  RX Machines
> diff --git a/hw/sd/Kconfig b/hw/sd/Kconfig
> index 633b9afec9..e9a5d63b4d 100644
> --- a/hw/sd/Kconfig
> +++ b/hw/sd/Kconfig
> @@ -23,3 +23,7 @@ config SDHCI_PCI
>  config CADENCE_SDHCI
>      bool
>      select SDHCI
> +
> +config K230_SDHCI
> +    bool
> +    select SDHCI
> diff --git a/hw/sd/k230_sdhci.c b/hw/sd/k230_sdhci.c
> new file mode 100644
> index 0000000000..34c972a2f7
> --- /dev/null
> +++ b/hw/sd/k230_sdhci.c
> @@ -0,0 +1,311 @@
> +/*
> + * Kendryte K230 SDHCI controller
> + *
> + * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "hw/sd/k230_sdhci.h"
> +#include "hw/sd/sdhci-internal.h"
> +#include "migration/vmstate.h"
> +
> +/*
> + * The TRM describes an SDHCI v4.20 DWC MSHC, including the v4 block-cou=
nt
> + * mode, ADMA3, and extension-area registers.  QEMU's generic controller
> + * supports up to v3 and does not implement those v4 transfer semantics.
> + */
> +#define K230_SDHCI_SPEC_VERSION 3
> +
> +/*
> + * K230's Capabilities registers describe more functionality than the ge=
neric
> + * QEMU SDHCI data path currently implements.  Do not expose the followi=
ng TRM
> + * capabilities to the guest:
> + *
> + * - ASYNC_INT requires an SDIO card-interrupt input and asynchronous in=
terrupt
> + *   signalling while the SD clock is stopped.  SDBus has no such input.
> + * - TIMER_RETUNING and RETUNING_MODE require a re-tuning timer and gene=
ration
> + *   of a re-tuning request.  The generic controller only completes an i=
nitial
> + *   command-based tuning operation; it never schedules periodic re-tuni=
ng.
> + * - ADMA3 requires the SDHCI v4.20 ADMA3 descriptor and command semanti=
cs,
> + *   whereas the generic controller implements SDMA and ADMA2 only.
> + */
> +#define K230_SDHCI_CAPABILITIES_UNSUPPORTED \
> +    (R_SDHC_CAPAB_ASYNC_INT_MASK | \
> +     R_SDHC_CAPAB_TIMER_RETUNING_MASK | \
> +     R_SDHC_CAPAB_RETUNING_MODE_MASK | \
> +     R_SDHC_CAPAB_ADMA3_MASK)

The reset value of the capability does not agree with the TRM. Please
confirm the value on the real hardware, or just use the value from the
TRM.

> +#define K230_SDHCI_CAPAREG_IMPLEMENTED \
> +    (K230_SDHCI_CAPAREG_RESET & ~K230_SDHCI_CAPABILITIES_UNSUPPORTED)
> +
> +#define K230_LO8(value)     ((value) & 0xff)
> +#define K230_HI8(value)     (((value) >> 8) & 0xff)
> +
> +static const uint8_t k230_sdhci_preset_reset[K230_SDHCI_PRESET_SIZE] =3D=
 {
> +    [K230_SDHCI_PRESET_INIT - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_INIT_RESET),
> +    [K230_SDHCI_PRESET_INIT - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_INIT_RESET),
> +    [K230_SDHCI_PRESET_DEFAULT_SPEED - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_DEFAULT_SPEED_RESET),
> +    [K230_SDHCI_PRESET_DEFAULT_SPEED - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_DEFAULT_SPEED_RESET),
> +    [K230_SDHCI_PRESET_HIGH_SPEED - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_HIGH_SPEED_RESET),
> +    [K230_SDHCI_PRESET_HIGH_SPEED - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_HIGH_SPEED_RESET),
> +    [K230_SDHCI_PRESET_SDR12 - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_SDR12_RESET),
> +    [K230_SDHCI_PRESET_SDR12 - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_SDR12_RESET),
> +    [K230_SDHCI_PRESET_SDR25 - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_SDR25_RESET),
> +    [K230_SDHCI_PRESET_SDR25 - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_SDR25_RESET),
> +    [K230_SDHCI_PRESET_SDR50 - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_SDR50_RESET),
> +    [K230_SDHCI_PRESET_SDR50 - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_SDR50_RESET),
> +    [K230_SDHCI_PRESET_SDR104 - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_SDR104_RESET),
> +    [K230_SDHCI_PRESET_SDR104 - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_SDR104_RESET),
> +    [K230_SDHCI_PRESET_DDR50 - K230_SDHCI_PRESET_BASE] =3D
> +        K230_LO8(K230_SDHCI_PRESET_DDR50_RESET),
> +    [K230_SDHCI_PRESET_DDR50 - K230_SDHCI_PRESET_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_PRESET_DDR50_RESET),
> +};
> +
> +static uint64_t k230_sdhci_preset_read(void *opaque, hwaddr addr,
> +                                      unsigned int size)
> +{
> +    return ldn_le_p(&k230_sdhci_preset_reset[addr], size);
> +}
> +
> +static void k230_sdhci_preset_write(void *opaque, hwaddr addr, uint64_t =
value,
> +                                   unsigned int size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "K230 SDHCI: write to read-only Preset Value register =
"
> +                  "0x%03" HWADDR_PRIx "\n",
> +                  K230_SDHCI_PRESET_BASE + addr);
> +}
> +
> +static const MemoryRegionOps k230_sdhci_preset_ops =3D {
> +    .read =3D k230_sdhci_preset_read,
> +    .write =3D k230_sdhci_preset_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +        .unaligned =3D false,
> +    },
> +};
> +
> +static const uint8_t k230_sdhci_pointer_reset[K230_SDHCI_POINTER_SIZE] =
=3D {
> +    [K230_SDHCI_P_UHS2_SETTINGS - K230_SDHCI_POINTER_BASE] =3D
> +        K230_LO8(K230_SDHCI_P_UHS2_SETTINGS_RESET),
> +    [K230_SDHCI_P_UHS2_SETTINGS - K230_SDHCI_POINTER_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_P_UHS2_SETTINGS_RESET),
> +    [K230_SDHCI_P_UHS2_HOST_CAPAB - K230_SDHCI_POINTER_BASE] =3D
> +        K230_LO8(K230_SDHCI_P_UHS2_HOST_CAPAB_RESET),
> +    [K230_SDHCI_P_UHS2_HOST_CAPAB - K230_SDHCI_POINTER_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_P_UHS2_HOST_CAPAB_RESET),
> +    [K230_SDHCI_P_UHS2_TEST - K230_SDHCI_POINTER_BASE] =3D
> +        K230_LO8(K230_SDHCI_P_UHS2_TEST_RESET),
> +    [K230_SDHCI_P_UHS2_TEST - K230_SDHCI_POINTER_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_P_UHS2_TEST_RESET),
> +    [K230_SDHCI_P_EMBEDDED_CNTRL - K230_SDHCI_POINTER_BASE] =3D
> +        K230_LO8(K230_SDHCI_P_EMBEDDED_CNTRL_RESET),
> +    [K230_SDHCI_P_EMBEDDED_CNTRL - K230_SDHCI_POINTER_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_P_EMBEDDED_CNTRL_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA1 - K230_SDHCI_POINTER_BASE] =3D
> +        K230_LO8(K230_SDHCI_P_VENDOR_AREA1_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA1 - K230_SDHCI_POINTER_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_P_VENDOR_AREA1_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA2 - K230_SDHCI_POINTER_BASE] =3D
> +        K230_LO8(K230_SDHCI_P_VENDOR_AREA2_RESET),
> +    [K230_SDHCI_P_VENDOR_AREA2 - K230_SDHCI_POINTER_BASE + 1] =3D
> +        K230_HI8(K230_SDHCI_P_VENDOR_AREA2_RESET),
> +};
> +
> +static uint64_t k230_sdhci_pointer_read(void *opaque, hwaddr addr,
> +                                       unsigned int size)
> +{
> +    return ldn_le_p(&k230_sdhci_pointer_reset[addr], size);
> +}
> +
> +static void k230_sdhci_pointer_write(void *opaque, hwaddr addr, uint64_t=
 value,
> +                                    unsigned int size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "K230 SDHCI: write to read-only pointer register "
> +                  "0x%03" HWADDR_PRIx "\n",
> +                  K230_SDHCI_POINTER_BASE + addr);
> +}
> +
> +static const MemoryRegionOps k230_sdhci_pointer_ops =3D {
> +    .read =3D k230_sdhci_pointer_read,
> +    .write =3D k230_sdhci_pointer_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +        .unaligned =3D false,
> +    },
> +};
> +
> +/*
> + * K230 uses the standard SDHCI register set at offset zero, followed by
> + * UHS-II, DWC MSHC PHY, Embedded Control, and vendor-specific blocks. M=
ost
> + * side effects of analogue PHY behaviors not simulated.
> + *
> + * PHY_PWRGOOD is the sole synthesized status bit.  Real hardware assert=
s it
> + * after PHY power and reset sequencing; the SDK driver polls it during =
every
> + * full controller reset.  A virtual PHY has no settling interval or fai=
lure
> + * condition, so the bit is permanently asserted and cannot be cleared b=
y a
> + * guest write.
> + */
> +static uint64_t k230_sdhci_fallback_read(void *opaque, hwaddr addr,
> +                                        unsigned int size)
> +{
> +    K230SDHCIState *s =3D opaque;
> +    uint64_t value =3D ldn_le_p(&s->fallback_regs[addr], size);
> +
> +    if (ranges_overlap(addr, size, K230_SDHCI_PHY_CNFG,
> +                       sizeof(uint32_t)) && addr <=3D K230_SDHCI_PHY_CNF=
G) {
> +        unsigned int shift =3D (K230_SDHCI_PHY_CNFG - addr) * 8;
> +
> +        value |=3D (uint64_t)K230_SDHCI_PHY_CNFG_PWRGOOD << shift;
> +    }
> +
> +    return value;
> +}
> +
> +static void k230_sdhci_fallback_write(void *opaque, hwaddr addr,
> +                                     uint64_t value, unsigned int size)
> +{
> +    K230SDHCIState *s =3D opaque;
> +
> +    stn_le_p(&s->fallback_regs[addr], size, value);
> +
> +    /* PWRGOOD reflects PHY state and is not software writable. */
> +    s->fallback_regs[K230_SDHCI_PHY_CNFG] |=3D
> +        K230_SDHCI_PHY_CNFG_PWRGOOD;
> +}
> +
> +static const MemoryRegionOps k230_sdhci_fallback_ops =3D {
> +    .read =3D k230_sdhci_fallback_read,
> +    .write =3D k230_sdhci_fallback_write,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 4,
> +        .unaligned =3D false,
> +    },
> +};
> +
> +static void k230_sdhci_reset(DeviceState *dev)
> +{
> +    K230SDHCIState *s =3D K230_SDHCI(dev);
> +
> +    memset(s->fallback_regs, 0, sizeof(s->fallback_regs));
> +    s->fallback_regs[K230_SDHCI_PHY_CNFG] =3D
> +        K230_SDHCI_PHY_CNFG_PWRGOOD;
> +    device_cold_reset(DEVICE(&s->sdhci));
> +}
> +
> +static void k230_sdhci_realize(DeviceState *dev, Error **errp)
> +{
> +    K230SDHCIState *s =3D K230_SDHCI(dev);
> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
> +    SysBusDevice *sdhci_sbd =3D SYS_BUS_DEVICE(&s->sdhci);
> +
> +    memory_region_init(&s->container, OBJECT(s), "k230.sdhci-container",
> +                       K230_SDHCI_REG_SIZE);
> +    sysbus_init_mmio(sbd, &s->container);
> +
> +    memory_region_init_io(&s->iomem_fallback, OBJECT(s),
> +                          &k230_sdhci_fallback_ops, s,
> +                          "k230.sdhci-fallback",
> +                          K230_SDHCI_REG_SIZE);
> +    memory_region_add_subregion(&s->container, 0, &s->iomem_fallback);
> +
> +    if (!sysbus_realize(sdhci_sbd, errp)) {
> +        return;
> +    }
> +    memory_region_add_subregion_overlap(
> +        &s->container, 0, sysbus_mmio_get_region(sdhci_sbd, 0), 1);
> +
> +    memory_region_init_io(&s->iomem_preset, OBJECT(s),
> +                          &k230_sdhci_preset_ops, s,
> +                          "k230.sdhci-preset", K230_SDHCI_PRESET_SIZE);
> +    memory_region_add_subregion_overlap(&s->container,
> +                                        K230_SDHCI_PRESET_BASE,
> +                                        &s->iomem_preset, 2);
> +
> +    memory_region_init_io(&s->iomem_pointer, OBJECT(s),
> +                          &k230_sdhci_pointer_ops, s,
> +                          "k230.sdhci-pointers", K230_SDHCI_POINTER_SIZE=
);
> +    memory_region_add_subregion_overlap(&s->container,
> +                                        K230_SDHCI_POINTER_BASE,
> +                                        &s->iomem_pointer, 2);
> +
> +    sysbus_pass_irq(sbd, sdhci_sbd);
> +    s->bus =3D qdev_get_child_bus(DEVICE(sdhci_sbd), "sd-bus");
> +}
> +
> +static const VMStateDescription vmstate_k230_sdhci =3D {
> +    .name =3D TYPE_K230_SDHCI,
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINT8_ARRAY(fallback_regs, K230SDHCIState,
> +                            K230_SDHCI_REG_SIZE),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};
> +
> +static void k230_sdhci_instance_init(Object *obj)
> +{
> +    K230SDHCIState *s =3D K230_SDHCI(obj);
> +
> +    object_initialize_child(obj, "generic-sdhci", &s->sdhci,
> +                            TYPE_SYSBUS_SDHCI);
> +
> +    object_property_set_uint(OBJECT(&s->sdhci), "sd-spec-version",
> +                             K230_SDHCI_SPEC_VERSION,
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->sdhci), "capareg",
> +                             K230_SDHCI_CAPAREG_IMPLEMENTED,
> +                             &error_abort);
> +    object_property_set_uint(OBJECT(&s->sdhci), "uhs", UHS_I, &error_abo=
rt);
> +}
> +
> +static void k230_sdhci_class_init(ObjectClass *klass, const void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +
> +    dc->desc =3D "Kendryte K230 SDHCI Controller";
> +    dc->realize =3D k230_sdhci_realize;
> +    device_class_set_legacy_reset(dc, k230_sdhci_reset);
> +    dc->vmsd =3D &vmstate_k230_sdhci;
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +}
> +
> +static const TypeInfo k230_sdhci_type_info =3D {
> +    .name =3D TYPE_K230_SDHCI,
> +    .parent =3D TYPE_SYS_BUS_DEVICE,
> +    .instance_size =3D sizeof(K230SDHCIState),
> +    .instance_init =3D k230_sdhci_instance_init,
> +    .class_init =3D k230_sdhci_class_init,
> +};
> +
> +static void k230_sdhci_register_types(void)
> +{
> +    type_register_static(&k230_sdhci_type_info);
> +}
> +
> +type_init(k230_sdhci_register_types)
> diff --git a/hw/sd/meson.build b/hw/sd/meson.build
> index b43d45bc56..a109635233 100644
> --- a/hw/sd/meson.build
> +++ b/hw/sd/meson.build
> @@ -10,3 +10,4 @@ system_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files=
('aspeed_sdhci.c'))
>  system_ss.add(when: 'CONFIG_ALLWINNER_H3', if_true: files('allwinner-sdh=
ost.c'))
>  system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_sdhci.c'))
>  system_ss.add(when: 'CONFIG_CADENCE_SDHCI', if_true: files('cadence_sdhc=
i.c'))
> +system_ss.add(when: 'CONFIG_K230_SDHCI', if_true: files('k230_sdhci.c'))
> diff --git a/include/hw/sd/k230_sdhci.h b/include/hw/sd/k230_sdhci.h
> new file mode 100644
> index 0000000000..a8389f1de4
> --- /dev/null
> +++ b/include/hw/sd/k230_sdhci.h
> @@ -0,0 +1,82 @@
> +/*
> + * Kendryte K230 SDHCI controller
> + *
> + * Copyright (c) 2026 Xin Xie <xinxie908@gmail.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_SD_K230_SDHCI_H
> +#define HW_SD_K230_SDHCI_H
> +
> +#include "qemu/bitops.h"
> +#include "hw/sd/sdhci.h"
> +#include "qom/object.h"
> +
> +#define TYPE_K230_SDHCI "k230.sdhci"
> +OBJECT_DECLARE_SIMPLE_TYPE(K230SDHCIState, K230_SDHCI)
> +
> +#define K230_SDHCI_REG_SIZE             0x1000
> +
> +/* K230 TRM reset values for Capabilities Registers 1 and 2. */
> +#define K230_SDHCI_CAPABILITIES1_RESET  0x256ec881ULL
> +#define K230_SDHCI_CAPABILITIES2_RESET  0x0800a177ULL
> +#define K230_SDHCI_CAPAREG_RESET \
> +    ((K230_SDHCI_CAPABILITIES2_RESET << 32) \
> +    | K230_SDHCI_CAPABILITIES1_RESET)
> +
> +/* SDHCI Preset Value registers. */
> +#define K230_SDHCI_PRESET_BASE           0x060
> +#define K230_SDHCI_PRESET_SIZE           0x010
> +#define K230_SDHCI_PRESET_INIT           0x060
> +#define K230_SDHCI_PRESET_DEFAULT_SPEED  0x062
> +#define K230_SDHCI_PRESET_HIGH_SPEED     0x064
> +#define K230_SDHCI_PRESET_SDR12          0x066
> +#define K230_SDHCI_PRESET_SDR25          0x068
> +#define K230_SDHCI_PRESET_SDR50          0x06a
> +#define K230_SDHCI_PRESET_SDR104         0x06c
> +#define K230_SDHCI_PRESET_DDR50          0x06e
> +#define K230_SDHCI_PRESET_INIT_RESET          0x00fa
> +#define K230_SDHCI_PRESET_DEFAULT_SPEED_RESET 0x0004
> +#define K230_SDHCI_PRESET_HIGH_SPEED_RESET    0x0002
> +#define K230_SDHCI_PRESET_SDR12_RESET         0x0004
> +#define K230_SDHCI_PRESET_SDR25_RESET         0x0002
> +#define K230_SDHCI_PRESET_SDR50_RESET         0x0001
> +#define K230_SDHCI_PRESET_SDR104_RESET        0x0000
> +#define K230_SDHCI_PRESET_DDR50_RESET         0x0002
> +
> +/* SDHCI v4 extension-area pointer registers. */
> +#define K230_SDHCI_POINTER_BASE         0x0e0
> +#define K230_SDHCI_POINTER_SIZE         0x00c
> +#define K230_SDHCI_P_UHS2_SETTINGS      0x0e0
> +#define K230_SDHCI_P_UHS2_HOST_CAPAB    0x0e2
> +#define K230_SDHCI_P_UHS2_TEST          0x0e4
> +#define K230_SDHCI_P_EMBEDDED_CNTRL     0x0e6
> +#define K230_SDHCI_P_VENDOR_AREA1       0x0e8
> +#define K230_SDHCI_P_VENDOR_AREA2       0x0ea
> +#define K230_SDHCI_P_UHS2_SETTINGS_RESET    0x0000
> +#define K230_SDHCI_P_UHS2_HOST_CAPAB_RESET  0x0f58
> +#define K230_SDHCI_P_UHS2_TEST_RESET        0x0f68
> +#define K230_SDHCI_P_EMBEDDED_CNTRL_RESET   0x0f6c
> +#define K230_SDHCI_P_VENDOR_AREA1_RESET     0x0500
> +#define K230_SDHCI_P_VENDOR_AREA2_RESET     0x0384
> +
> +/* DWC MSHC PHY register block. */

nits: remove the ending period.
Please fix this globally in this patch series.

> +#define K230_SDHCI_PHY_CNFG             0x300
> +#define K230_SDHCI_PHY_CNFG_RSTN        BIT(0)
> +#define K230_SDHCI_PHY_CNFG_PWRGOOD     BIT(1)
> +
> +struct K230SDHCIState {
> +    SysBusDevice parent_obj;
> +
> +    MemoryRegion container;
> +    MemoryRegion iomem_fallback;
> +    MemoryRegion iomem_preset;
> +    MemoryRegion iomem_pointer;
> +    BusState *bus;
> +    uint8_t fallback_regs[K230_SDHCI_REG_SIZE];
> +
> +    SDHCIState sdhci;
> +};
> +
> +#endif

Regards,
Bin

