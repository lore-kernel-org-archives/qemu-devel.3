Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37DA1088E58
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 01:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w32Qr-0004vA-WD; Wed, 18 Mar 2026 21:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w32Qp-0004uE-Oo
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 21:44:16 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w32Qm-0006ul-J0
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 21:44:15 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b97b7e0368eso55069366b.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 18:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773884651; cv=none;
 d=google.com; s=arc-20240605;
 b=db/RKF19C0xZm3Mwe7WCUiVawFj2iZ6dFFDy0s6tWIDe1OGimcWwBOnvYXNreZ51Yf
 kveO3fXkfpeLwjJR+hx/I8p1i7CLFlFXW7yfXAbsO5igKrHu5ZC76W09t0DBc3sp/IFY
 4Jp2ytEN4BA6ZCt4dFu9b6rp3S0a9rBTsCbMswqKe1kvX6H00doN1CHyxaHKZUXlP3/m
 ijNQXWiB9eihmslmDb99KRcwHwD4o3JzOImLtlbZEkCbfL6LYhnZWrIvnQ47xr/HGmBp
 b7cvaGomBzi9Ha80OG2MQIdB3iAP3BF6q5esfWNhQY/bNbC0reLuU4yK83rJkkMMuGuk
 GaLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zPABj/ZH6U7RBqZofFfksVIr97NrQwgix9d6mOzviSM=;
 fh=isFeZ2AwKaaxFIfz2uS3WOPJiql7cgU/iXMx0HMiBxc=;
 b=N3oEV+jEOXSkr9q+3Qr6M7bFDvWTarlVl6PSbqMfgx4L4y3mAPztfLczzoNVCMSlyf
 1f06Lzk7x/58n4oV2wusMv0C1blFz0OZ8uo4qW+9NUi/fZ96LGp8MeVD+TfH73gxiWmF
 L7xmEUAfKSFWTFfl10Q9vt6l34wkYHPNcIj4JJROpvd6Jgsy2LrwQu9PKDoO9hPpgPE9
 YpwqAN4Z25xOAHmuXGf2ZNSBLhuEOIgdWqtqXesRDx0dgRm/PvNURaeE013h1Xvj3j88
 tQe8+IhuBUP+OYvd+0l+LX81H4ctBcDicV/bNRYqHQwOpsaUUdejRdzWb/zmWckYXI2R
 K1PA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773884651; x=1774489451; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zPABj/ZH6U7RBqZofFfksVIr97NrQwgix9d6mOzviSM=;
 b=Eyh4HyZ2l1tjhhdchiPQO9LGf+mJGZ6N65ndjR4n+MgPUkxyZheFiYoXeEPReVvatk
 JHLQvbO1AOXQSpRLN6w0UWFyFSE2eo+Kg8Ypz9WVcWZmp9GGVIIKfrX/+Gn3ppCoURF5
 KRP27eqsVTqtH35BnmUNPMTtviN6De/YyoZ7R+tVaNLZGn17TVL/fISf5fvXVkIxbBpS
 GHSLHrigTv1KhY/GExyB+VqL64LEpJHbv6hDS8blmdq36OR46tGD21lX3wbeacixXnsF
 56S1vGFogmQX2Ynvsu/zSihmdOaXwxnlBEYwKSTAXe4BV4nSEuUaXDlZU6pP5T+vPEMC
 jShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773884651; x=1774489451;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zPABj/ZH6U7RBqZofFfksVIr97NrQwgix9d6mOzviSM=;
 b=MoAXm1wmhxW7heyEsUAd6A2nOQnJxURJpxefTumc58NOvYCYBaRjyXbzfe2VcSJPUe
 9oa45fi7ySmaP2uV72Z249gtDJ/rl8rzeH6oFhuFF5Jq+ZWQvzMwc3Nw4RBSbKgDVdtt
 bJO+lOEXDdZn+GuM/nvZ0tfPdx2aaCzPEowTY/lUMDaR/Kwo2NMRZ0cdNsz7AZC6yUtA
 BpnkqSxJNRBurbh0wzMWi+GAXY8lWQBHm4PKgsqBSzb1bcll+LeMCwsozQgVVD8FU/pe
 ur2dv2T9+SnabF+/H+k0k1g0HINo+MfJff2zVC71FKw9sZrIKCQSwBvaJoNtbITxGMio
 EQEQ==
X-Gm-Message-State: AOJu0YwSazFxuGnOq8zG/yW9OeQpc3QtrXOELzWMFIS2A3j+bkKfcky6
 jeh2950qrlnDyhbUQcrJQawl/SyYahsXo/xKyCoPDZAVMHJl6km3kLaKJMprzh+flvlVPmmChVu
 OZ6vVTNZJFtoQmDzg8jWBOBBmduBk+Dw=
X-Gm-Gg: ATEYQzy5eEWvYyJr6ERvTpybDxGC/qHv67J1o4bu4lAgDv2qdRLQIz2lWLvDus3L4uN
 yfOB4SxemelG2nc7Azz+nH3CmsHV+Rjk8TzciTDCO0Ik+DdX/u591+mCf1gPYUj1GfPsMKoihWP
 5ziteucTMX/+l643z4CEahx2zmZy9hP3D0+JIS0XVx6oI2VQfjhSkuWighRwKW2ivkdZ3wlL9Am
 2/ExEoKKCiIXBdKNsACtGPAU+MA2HUYuH1f8c3iNlxkKG9cZakdzFqVisg4CEyYR74St4bToDAS
 x+unxlusd9orq3Yan3nXXXE2o+fh23Y69gdZbGBZVF6xlG8S
X-Received: by 2002:a17:907:3fa2:b0:b93:3792:4b03 with SMTP id
 a640c23a62f3a-b97f4a7e7e1mr310986266b.32.1773884650142; Wed, 18 Mar 2026
 18:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260318103122.97244-1-philmd@linaro.org>
 <20260318103122.97244-2-philmd@linaro.org>
In-Reply-To: <20260318103122.97244-2-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 19 Mar 2026 11:43:43 +1000
X-Gm-Features: AaiRm51MxuAk7Nqv-ibJSXLy2B_mtFPvwBtnFUFSOSRywnr7-vYBG3Pb_zO_XWI
Message-ID: <CAKmqyKMNXkcZcknHEYWbFWKb0KduWLXdeW-mZErY1q7EJrp+hg@mail.gmail.com>
Subject: Re: [PATCH-for-11.1 01/16] hw/riscv: Mark RISC-V specific peripherals
 as little-endian
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Weiwei Li <liwei1518@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?= <frederic.petrot@univ-grenoble-alpes.fr>, 
 Vijai Kumar K <vijai@behindbytes.com>, Anton Johansson <anjo@rev.ng>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Mar 18, 2026 at 8:34=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> These devices are only used by the RISC-V targets, which are
> only built as little-endian. Therefore the DEVICE_NATIVE_ENDIAN
> definition expand to DEVICE_LITTLE_ENDIAN (besides, the
> DEVICE_BIG_ENDIAN case isn't tested). Simplify directly
> using DEVICE_LITTLE_ENDIAN.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/char/ibex_uart.c     | 2 +-
>  hw/char/shakti_uart.c   | 2 +-
>  hw/char/sifive_uart.c   | 2 +-
>  hw/misc/sifive_e_aon.c  | 2 +-
>  hw/misc/sifive_e_prci.c | 2 +-
>  hw/misc/sifive_u_otp.c  | 2 +-
>  hw/misc/sifive_u_prci.c | 2 +-
>  hw/riscv/riscv-iommu.c  | 2 +-
>  hw/sd/cadence_sdhci.c   | 2 +-
>  hw/timer/ibex_timer.c   | 2 +-
>  hw/timer/sifive_pwm.c   | 2 +-
>  11 files changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> index 127d219df3c..26ed1aea140 100644
> --- a/hw/char/ibex_uart.c
> +++ b/hw/char/ibex_uart.c
> @@ -470,7 +470,7 @@ static void fifo_trigger_update(void *opaque)
>  static const MemoryRegionOps ibex_uart_ops =3D {
>      .read =3D ibex_uart_read,
>      .write =3D ibex_uart_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl.min_access_size =3D 4,
>      .impl.max_access_size =3D 4,
>  };
> diff --git a/hw/char/shakti_uart.c b/hw/char/shakti_uart.c
> index 2d1bc9cb8e2..d38920a03a0 100644
> --- a/hw/char/shakti_uart.c
> +++ b/hw/char/shakti_uart.c
> @@ -103,7 +103,7 @@ static void shakti_uart_write(void *opaque, hwaddr ad=
dr,
>  static const MemoryRegionOps shakti_uart_ops =3D {
>      .read =3D shakti_uart_read,
>      .write =3D shakti_uart_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {.min_access_size =3D 1, .max_access_size =3D 4},
>      .valid =3D {.min_access_size =3D 1, .max_access_size =3D 4},
>  };
> diff --git a/hw/char/sifive_uart.c b/hw/char/sifive_uart.c
> index af17cf9a6ce..4e31842df5c 100644
> --- a/hw/char/sifive_uart.c
> +++ b/hw/char/sifive_uart.c
> @@ -206,7 +206,7 @@ static void fifo_trigger_update(void *opaque)
>  static const MemoryRegionOps sifive_uart_ops =3D {
>      .read =3D sifive_uart_read,
>      .write =3D sifive_uart_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4
> diff --git a/hw/misc/sifive_e_aon.c b/hw/misc/sifive_e_aon.c
> index e78f4f56725..ff2a7c18235 100644
> --- a/hw/misc/sifive_e_aon.c
> +++ b/hw/misc/sifive_e_aon.c
> @@ -250,7 +250,7 @@ sifive_e_aon_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps sifive_e_aon_ops =3D {
>      .read =3D sifive_e_aon_read,
>      .write =3D sifive_e_aon_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4
> diff --git a/hw/misc/sifive_e_prci.c b/hw/misc/sifive_e_prci.c
> index 400664aabae..a4a60e7b406 100644
> --- a/hw/misc/sifive_e_prci.c
> +++ b/hw/misc/sifive_e_prci.c
> @@ -75,7 +75,7 @@ static void sifive_e_prci_write(void *opaque, hwaddr ad=
dr,
>  static const MemoryRegionOps sifive_e_prci_ops =3D {
>      .read =3D sifive_e_prci_read,
>      .write =3D sifive_e_prci_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4
> diff --git a/hw/misc/sifive_u_otp.c b/hw/misc/sifive_u_otp.c
> index 7205374bc39..cececd4f7a8 100644
> --- a/hw/misc/sifive_u_otp.c
> +++ b/hw/misc/sifive_u_otp.c
> @@ -187,7 +187,7 @@ static void sifive_u_otp_write(void *opaque, hwaddr a=
ddr,
>  static const MemoryRegionOps sifive_u_otp_ops =3D {
>      .read =3D sifive_u_otp_read,
>      .write =3D sifive_u_otp_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4
> diff --git a/hw/misc/sifive_u_prci.c b/hw/misc/sifive_u_prci.c
> index f51588623ab..4674d5925ea 100644
> --- a/hw/misc/sifive_u_prci.c
> +++ b/hw/misc/sifive_u_prci.c
> @@ -112,7 +112,7 @@ static void sifive_u_prci_write(void *opaque, hwaddr =
addr,
>  static const MemoryRegionOps sifive_u_prci_ops =3D {
>      .read =3D sifive_u_prci_read,
>      .write =3D sifive_u_prci_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 98345b1280b..ef5d7df2385 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2375,7 +2375,7 @@ static MemTxResult riscv_iommu_mmio_read(void *opaq=
ue, hwaddr addr,
>  static const MemoryRegionOps riscv_iommu_mmio_ops =3D {
>      .read_with_attrs =3D riscv_iommu_mmio_read,
>      .write_with_attrs =3D riscv_iommu_mmio_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 8,
> diff --git a/hw/sd/cadence_sdhci.c b/hw/sd/cadence_sdhci.c
> index d576855a1a8..8476baf67fb 100644
> --- a/hw/sd/cadence_sdhci.c
> +++ b/hw/sd/cadence_sdhci.c
> @@ -122,7 +122,7 @@ static void cadence_sdhci_write(void *opaque, hwaddr =
addr, uint64_t val,
>  static const MemoryRegionOps cadence_sdhci_ops =3D {
>      .read =3D cadence_sdhci_read,
>      .write =3D cadence_sdhci_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> diff --git a/hw/timer/ibex_timer.c b/hw/timer/ibex_timer.c
> index ee186521893..0f12531934d 100644
> --- a/hw/timer/ibex_timer.c
> +++ b/hw/timer/ibex_timer.c
> @@ -234,7 +234,7 @@ static void ibex_timer_write(void *opaque, hwaddr add=
r,
>  static const MemoryRegionOps ibex_timer_ops =3D {
>      .read =3D ibex_timer_read,
>      .write =3D ibex_timer_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>      .impl.min_access_size =3D 4,
>      .impl.max_access_size =3D 4,
>  };
> diff --git a/hw/timer/sifive_pwm.c b/hw/timer/sifive_pwm.c
> index 780eaa50799..4f4f566cd4b 100644
> --- a/hw/timer/sifive_pwm.c
> +++ b/hw/timer/sifive_pwm.c
> @@ -388,7 +388,7 @@ static void sifive_pwm_reset(DeviceState *dev)
>  static const MemoryRegionOps sifive_pwm_ops =3D {
>      .read =3D sifive_pwm_read,
>      .write =3D sifive_pwm_write,
> -    .endianness =3D DEVICE_NATIVE_ENDIAN,
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>  };
>
>  static const VMStateDescription vmstate_sifive_pwm =3D {
> --
> 2.53.0
>
>

