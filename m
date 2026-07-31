Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7018C54F54
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:16:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wplDJ-0000Kk-6f; Fri, 31 Jul 2026 07:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wplDH-0000KM-JE
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:15:39 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wplDE-0001BF-Cv
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 07:15:38 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6688acd1a51so1081796d50.3
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 04:15:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785496534; cv=none;
 d=google.com; s=arc-20260327;
 b=iiBKwUOXILR36g5weZoh29FI4KBaWWhX06cbMsPEfN/EhpQBJah8L+9k8rbn0EzVGu
 RpBfEgE5mcmzHLRDdgJljzHX7GyUsQEBxS/vuGtEJNpymz1EGDcFwOTK7OCVvoSGhfxp
 +8pIOKimg4VsNpLZoQlWHt9SgKSKkgm896EjhYOFfFZStQ2LdnUhcrLR+M9CsEBG2oGG
 rHqP41KNOUBkl5J51vhBHIpkNKAkMUEk7hkVnmDhAw6nt2DHiIG6hbZq5aT6yJqhao+K
 dF7HitjCuhDTd94RoXQfKjcTvMzSE7OibW+ZF2HGgMstRmIf4LELRmBZlHSjxVvln3FA
 eRnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zXFbAPEIomg84gCkIGAVnHi0vMeB7bxnsVA6omErrGs=;
 fh=xChv7ieWS1sj6jE9IHpGYXOFSuW+3i48YUpPGYmP/DA=;
 b=k/KCQ5x4VWUbq66cFETb4TlVbUilnVe4Ra0lJgAtk9wgh9thDF/0bhj+z9C5a6JnfN
 7B4NsQp8afkVVpKBAgmk5ti8L6glsgLXzxtNSTcMhBqylPImDBHL9+uZlMfjhWHJSrbV
 0kWZ3/KZn3jLh2vftrWYs0xvw7Wgif7bF/oD05Erf2TN7ext/RtSI1o1eRahezGd4JL8
 0CQO/CserlUftQreh+eGhhI2XX3pGsUriw8l+cmYhivrzndMHJwYJGWeHNszNnFBaflV
 VdCfRVaWB3SrgOu0ZJV/M17fhFRJcGlZBr8jicy9m5byHvmlF4+vhLYxor9O7kt8WWR7
 u6Iw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785496534; x=1786101334; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zXFbAPEIomg84gCkIGAVnHi0vMeB7bxnsVA6omErrGs=;
 b=iiCQRv5KNBa7lhjccHB2X5Bi4/TOsgTyrdr7L0lD2QpzCqIHSquauQJl1rB7c8QPpB
 PqbGR6TMDNJwgXmmowNpz0V5V5dzEoM3dxrId/ZB/6ci2+SmKne0cpD1OvMaReznt73G
 y67u/L1VnfAlHaq8kcB9NrhxvqDOvknnNu9W8y2zqCsrIJBgT2EQDmF2LHaAmH3iK+b7
 BIsK34x84M6Kz3Y3L9NI8193oLimNcH0MOkZtnIAqQwkwlIT1FbEmrA2JLvZReT4kilp
 3+w8hR/r/9IryJAkywGBtMEv/DirTWujJ8m2q3cFlgKERs4Miof1bg4XsABTsLuEymJ1
 tYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785496534; x=1786101334;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zXFbAPEIomg84gCkIGAVnHi0vMeB7bxnsVA6omErrGs=;
 b=N3McGGIclt11NYO5v5l7IjzHMrp+wYpnCuNtwse25fxaP+1CbARqWxdCJo4rmac+CI
 k9v8gIuMwlUVvLqg9mkDqUblb+4EAwq63IPuZBNmcBC+zdRWvlr9nQqnLMoLYa7LbO7x
 W8pTdIDPqxjo2MgUlkoDtr1SEM7bpDYZKY7o7RA8H8ZdbmxOFXHvgW7/FcZEZDOZlQow
 kvoPEohYeFZzeFkL5mc/iw6c0MNfeWT09gjOJu+Xi6ORiH1uzmtpqs/7zWAzyA884jpN
 MUdxt/Q/HkBWXrnt6Pnnrp493+Fi1KOqOW316lS/k48cx4s5iKthef3uVKv2SCpbhILE
 VvwA==
X-Gm-Message-State: AOJu0YyhslcqqzIKTyQzHaCDa/ED0oCZV4KNeTE4/F4Z13B5OqXSWtnO
 wqF2NteK+uHtUX9YEA5gRZNrem3ahV3MwMGeO5/W6JjQUHoTZEvhGVSliRn9261SB1rnGdttkMf
 TpgTuuJMjO6l4/qdEiNwiZ2kE0VpsLDMBIFR+4PBZ5A==
X-Gm-Gg: AR+sD12oFq8ok25BjmfwDrSFCj93r3S0+crkbIF3GDP9u/6fcXJAEKLZhxa/7HDMktG
 GRiwsc8Tf6iNiVoOTBMjp0fQIh3/S4eKzXLCBw+U1P/9FE1muy6CYyPaJuhfPSbLNqUR2oS/tyz
 xSTFo9TCsA48WgNlBP6/J/VnvKHSvLNj9csh7Bp3XAffbTEr+w39A146eNPW6niiwChLGM8mWzW
 SOoPpgL8YWu4AGeQSP6oafkKzYvoX3QBsJQkd8q7+/DSkXI28udNN1t+aTzFNUFm6KdfTi1X7zC
 W2fGgwHgGMB5NhOPvuzrD1cVy5cIpb6y1NZ/O4dhCAOrmdELsmuXgj/Atrm6fA7HknXQV8Qxmd0
 tK5841Or+g6LavGguqtiQph+O4HFo
X-Received: by 2002:a05:690e:138b:b0:667:9e0d:24ab with SMTP id
 956f58d0204a3-6694a0b9d33mr566664d50.36.1785496519225; Fri, 31 Jul 2026
 04:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260723233605.805-1-simonxhy0404@gmail.com>
 <20260723233605.805-3-simonxhy0404@gmail.com>
In-Reply-To: <20260723233605.805-3-simonxhy0404@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 31 Jul 2026 12:15:07 +0100
X-Gm-Features: AUfX_mxtEf66yTQsa41Lhs9ODf9hm7uQRQvDXKcUg1GlFPxZsGj6dYqP6aLAY5o
Message-ID: <CAFEAcA-1PZ5=tKEk-A65WQUKjGP0P3PvFKFCxFbiEQEq+ohvxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/arm/armsse: add Arm Corstone SSE-310
To: Simon Xu <simonxhy0404@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Owen Giles <owen.giles@hpe.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Robert Elliott <elliott@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 24 Jul 2026 at 00:36, Simon Xu <simonxhy0404@gmail.com> wrote:
>
> Add Arm Corstone SSE-310 model.
> - Include new NPU power policy unit and configuration interface in device
> list as unimplemented devices.
> - sys_version and iidr values from the "SSE-310 with M85 and U55 FPGA"
> documentation for the mps3-an555.
> - Refractor comments and code pertaining to both the SSE-300 and SSE-310.
> - Add support for SSE-310 in the iotkit files.
> - Add SSE-310 PIDR and CIDR registers according to the SSE-310 TRM.
>
> Arm Corstone SSE-310 TRM:
> https://developer.arm.com/documentation/102778/0000/
>
> Reviewed-by: Owen Giles <owen.giles@hpe.com>
> Reviewed-by: Robert Elliott <elliott@hpe.com>
> Signed-off-by: Simon Xu <simonxhy0404@gmail.com>
> ---
>  hw/arm/armsse.c                 | 208 +++++++++++++++++++++++++++++++-
>  hw/misc/iotkit-secctl.c         |  18 +++
>  hw/misc/iotkit-sysctl.c         |  60 +++++++--
>  hw/misc/iotkit-sysinfo.c        |  12 +-
>  include/hw/arm/armsse-version.h |   2 +
>  include/hw/arm/armsse.h         |   1 +
>  6 files changed, 287 insertions(+), 14 deletions(-)

I would prefer if we split this patch up into smaller pieces.
Adding the secctl handling, the sysctl handling, sysinfo, and
the main armsse support itself are all pieces that are easier to
review separately. If you'd split this patch up I would have
been able to mark some of the subpatches as reviewed already.

> diff --git a/hw/arm/armsse.c b/hw/arm/armsse.c
> index ddb210c895..1847c73322 100644
> --- a/hw/arm/armsse.c
> +++ b/hw/arm/armsse.c
> @@ -26,7 +26,7 @@
>  #include "hw/core/qdev-clock.h"
>
>  /*
> - * The SSE-300 puts some devices in different places to the
> + * The SSE-300 and SSE-310 put some devices in different places to the
>   * SSE-200 (and original IoTKit). We use an array of these structs
>   * to define how each variant lays out these devices. (Parts of the
>   * SoC that are the same for all variants aren't handled via these
> @@ -118,6 +118,18 @@ static const Property sse300_properties[] = {
>      DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
>  };
>
> +static const Property sse310_properties[] = {
> +    DEFINE_PROP_LINK("memory", ARMSSE, board_memory, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
> +    DEFINE_PROP_UINT32("EXP_NUMIRQ", ARMSSE, exp_numirq, 64),
> +    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 21),
> +    DEFINE_PROP_UINT32("init-svtor", ARMSSE, init_svtor, 0x10000000),
> +    DEFINE_PROP_BOOL("CPU0_FPU", ARMSSE, cpu_fpu[0], true),
> +    DEFINE_PROP_BOOL("CPU0_DSP", ARMSSE, cpu_dsp[0], true),
> +    DEFINE_PROP_UINT32("CPU0_MPU_NS", ARMSSE, cpu_mpu_ns[0], 8),
> +    DEFINE_PROP_UINT32("CPU0_MPU_S", ARMSSE, cpu_mpu_s[0], 8),
> +};
> +
>  static const ARMSSEDeviceInfo iotkit_devices[] = {
>      {
>          .name = "timer0",
> @@ -480,6 +492,146 @@ static const ARMSSEDeviceInfo sse300_devices[] = {
>      }
>  };
>
> +static const ARMSSEDeviceInfo sse310_devices[] = {
> +    {

This is a very long block of data about the SSE310 devices
which is almost but not quite identical to the existing one
for SSE300. It would be easier to review if your commit message
stated which devices are new in the SSE310 memory map and
which have moved compared to the SSE300.

> +        .name = "timer0",
> +        .type = TYPE_SSE_TIMER,
> +        .index = 0,
> +        .addr = 0x48000000,
> +        .ppc = 0,
> +        .ppc_port = 0,
> +        .irq = 3,
> +    },

> +    {
> +        .name = "s32ktimer",
> +        .type = TYPE_CMSDK_APB_TIMER,
> +        .index = 0,
> +        .addr = 0x4802f000,
> +        .ppc = 1,
> +        .ppc_port = 0,
> +        .irq = 2,
> +        .slowclk = true,
> +    },
> +    {
> +        .name = "s32kwatchdog",
> +        .type = TYPE_CMSDK_APB_WATCHDOG,
> +        .index = 0,
> +        .addr = 0x5802e000,

This is different to what we set for SSE-300, and it looks
like that's a bug in the SSE-300 implementation. This is
the "SLOWCLK Watchdog", and both the SSE-300 and SSE-310
docs list it as being only in the Secure access region
(0x58....), and not in the NS region (0x48...). We should
fix the SSE-300 bug.

> +        .ppc = NO_PPC,
> +        .irq = NMI_0,
> +        .slowclk = true,
> +    },

> diff --git a/hw/misc/iotkit-sysctl.c b/hw/misc/iotkit-sysctl.c
> index dff89c677f..e6b1fe5d32 100644
> --- a/hw/misc/iotkit-sysctl.c
> +++ b/hw/misc/iotkit-sysctl.c

> @@ -193,6 +204,7 @@ static uint64_t iotkit_sysctl_read(void *opaque, hwaddr offset,
>              break;
>          case ARMSSE_SSE300:
>              /* In SSE300 this is reserved (for INITSVTOR2) */
> +        case ARMSSE_SSE310:

For this and the others similar, you should put the two "case" lines
together, and update the comment.

>              goto bad_offset;
>          default:
>              g_assert_not_reached();

As well as all the registers that are the same as SSE300, the
SSE310 has one extra register in the sysctl block: PPUINTSTAT, at
offset 0x128. We don't implement the PPUs in QEMU, but we should at
least implement this register as RAZ with a LOG_UNIMP log if the guest
tries to read it.

> diff --git a/hw/misc/iotkit-sysinfo.c b/hw/misc/iotkit-sysinfo.c
> index 19f089e6ee..21e161bdc2 100644
> --- a/hw/misc/iotkit-sysinfo.c
> +++ b/hw/misc/iotkit-sysinfo.c
> @@ -58,6 +58,12 @@ static const int sysinfo_sse300_id[] = {
>      0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
>  };
>
> +static const int sysinfo_sse310_id[] = {
> +    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
> +    0x58, 0xb8, 0x2b, 0x00, /* PID0..PID3 */
> +    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
> +};
> +
>  static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
>                                      unsigned size)
>  {
> @@ -68,13 +74,13 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
>      case A_SYS_VERSION:
>          r = s->sys_version;
>          break;
> -
>      case A_SYS_CONFIG:
>          r = s->sys_config;
>          break;
>      case A_SYS_CONFIG1:
>          switch (s->sse_version) {
>          case ARMSSE_SSE300:
> +        case ARMSSE_SSE310:
>              return 0;
>              break;
>          default:
> @@ -84,6 +90,7 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
>      case A_IIDR:
>          switch (s->sse_version) {
>          case ARMSSE_SSE300:
> +        case ARMSSE_SSE310:
>              return s->iidr;
>              break;
>          default:
> @@ -95,6 +102,9 @@ static uint64_t iotkit_sysinfo_read(void *opaque, hwaddr offset,
>          case ARMSSE_SSE300:
>              r = sysinfo_sse300_id[(offset - A_PID4) / 4];
>              break;
> +        case ARMSSE_SSE310:
> +            r = sysinfo_sse310_id[(offset - A_PID4) / 4];
> +            break;
>          default:
>              r = sysinfo_id[(offset - A_PID4) / 4];
>              break;

As well as these changes to sysinfo, which are all fine, the SSE310
has an extra SYS_CONFIG2 register which the SSE300 does not. We
can hardwire it to "return 0" like we do for SYS_CONFIG1,
because the only interesting field in it is "is there an NPU
present", which for us is always "no".

> diff --git a/include/hw/arm/armsse.h b/include/hw/arm/armsse.h
> index bdf2d4db8e..d0dcba1fbb 100644
> --- a/include/hw/arm/armsse.h
> +++ b/include/hw/arm/armsse.h
> @@ -127,6 +127,7 @@ OBJECT_DECLARE_TYPE(ARMSSE, ARMSSEClass,
>  #define TYPE_IOTKIT "iotkit"
>  #define TYPE_SSE200 "sse-200"
>  #define TYPE_SSE300 "sse-300"
> +#define TYPE_SSE310 "sse-310"

There's a comment at the top of this file starting "Currently we model:"
which documents what we implement. We should add SSE-310 to that.
(I forgot to do this for SSE-300, unfortunately.)

thanks
-- PMM

