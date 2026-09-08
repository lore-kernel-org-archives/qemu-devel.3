Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FE7C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sBG-0001Ya-Jc; Tue, 08 Sep 2026 05:31:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3sBD-0001Xf-Dx
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:31:51 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3sBB-0007Kt-3Y
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:31:51 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8726acc5eadso30584787b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 02:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788859906; cv=none;
 d=google.com; s=arc-20260327;
 b=iRbTN+QPTlPFFwdq5YZlfLaGar7P/kbykWd1JkHNeAjj5V4fcYcrDi7Hg1KeUw+aA2
 BXC9Bs8IeoeUJ3C84MSpFzQ0OGosWdJZWelsu8rPKs8RrAAFZNDZNBy+niR9OuSXzgcy
 aLBAEjSxVemTe9lCG40VdJYHHOW0W1T4nmWwE3ESK0LXtuQa4y49tjiAWczgJTwonRF1
 b4cIfFH93/UhvJf2yy0w0JwmGpd/Q0gSvU7w1Q82kj3bM4EwwfQoXync+rxG4qAnM02g
 T+erPSlIquqyFVZ3sJw753bnlntqyaQOA0hj6RHS3giIIj9j9mT+6pP46XxmlACTw6+J
 YhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7GKDo1etqBehuVleDyKR7C+x1la3ki921G0KqZ87U4U=;
 fh=fVPfpHMeJX2gxPKYTBQCzQO60hB2p26ro2vRuUEPsJ4=;
 b=UMMrixWazub2JIBW7puWmqCgUerAN0AtnZh1727nmpdXd5yQHxIEbr/BUzFhLXv8KX
 GGpVLY8Lyfi/nAxpmKzdsx/JMeTJMwbGJnwzuPeb9GnHlrgcgNjYEQkMvD2sAqi96xhr
 AUP3iVOdJxrW+cRNOdsMbaMBVcFfXn/Q3iIoa8mGVjmW4uZ4d0AvzVeWCtVVP/W0eU7E
 q3cf7EaDpHGqD1hVhN6ru5cXsyF2bPBi+qsMcrIERaGb3CoWqnssv3HSOEmDKPdmAgY6
 aPiOv7it9vfRSFMoVJ7c4xlY3PqKSVQ3o3+hNEAmK222pGfQdxlvKaIQgcKc6nBQnWiw
 PERA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788859906; x=1789464706; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7GKDo1etqBehuVleDyKR7C+x1la3ki921G0KqZ87U4U=;
 b=LYsNDB3QfC/87aBOSLj9JYt1Y7qUqbdxWp4RfreuVCKU4zvNGRUdkuJ4iiZccaX+fg
 Uvb+J4Mkn28ToIvX6L7p7ELx0HolTOPoMfNFopLNijBJITjQjArq9kXucpG2nHcuYE7H
 HEugtOc6YGL+WB+MeCNqFvEzfxTB6+fPRMMK3xwiEGG/49cjdhwHYYJfOUYZMuW4RjJB
 A6RxTC2M1KJyCDHIbgoqmGIfA+xM0INcIUbvCAe3e5pGfcodwP2ycQMkMoThkwO0Ucjo
 ppZ5sd5bKtQunDj9J1ME86BD7TUhKuEs+MBI1NHrwjAZU/j+IZz1hAuRdmnMY70X/8/S
 d9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859906; x=1789464706;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7GKDo1etqBehuVleDyKR7C+x1la3ki921G0KqZ87U4U=;
 b=tGHVE5OPMiWboJyOHaaQAi8rpAK7vTpZyxdcxI66EpP7zWik8QlHiPfb/8btcek2Wy
 AZxH0XyCOWrsk3IorsRuNeF28/iPjH0J7ACeTBWd3Srb4p/AuoYOEKqZfcVhosjGse5d
 lPsZJ9gkel4aWq4Nw0TTBl1r3dpWXbqdGhrWcmQPXBAmIRwiPY22M38Yo371UGbDNad+
 oOhUCr6PzovXBfT4evLoyKfFzd+OoinXz2aWcWxMOLyt/O+RBXknC4aSgtvGiyyWoB+I
 Hb+TZWwVZ0MHaPAN9N/5uK9aUjALkdOur1EBkcBewOCdofJ3D1GdHMx9UoihAv9HTis/
 QTcA==
X-Gm-Message-State: AFuF++mSf/1RgKul9CLlMno0uPE+p8C5wx3mFAsEvKg6AUYXjm2bWDkg
 RoQSHMh4EjUapxOxH+hVlUGn0cmh8aEDBDXY1LTdGbrhydFLmcOC8FxGtVUE1N10E8reTJhuBIE
 XVRD6l49cgLsR6chgyh/iv9whjh2UBHEPW1+1tV5UbQ==
X-Gm-Gg: AYBFou0oEV4YcduUiBMN1lMN/C3nxp1n3Ja/5Q3kNoj10XxbZuKsymslXJYlpo2h8gr
 rYADPfbKk90jTvU9puj1v3BJafWEKUV7vGeF0qkFeIYovMPAu/8X5sS0Hc1SfouHwzV0ZM46TLj
 QTXxiDXf7kPy0QOSxHChGPJga7XKPbDfT3fggWGWfvm2hHihPgBgoKDLTJaZuNoKUNofFM9maXz
 IfC2jNKUCFg1WBpe2xLk1CxL6cla6fEeKYkMhwCmr3YX408p8EPHOnC4LDpCZA1S8aY23JJIYSO
 uHcaAAzUhFxERx4Zk3OI+ZSj4Ikm8YuKOZQ8mzDTFKGb7AUEfqV+9vR72wAiCB78m8rnIB0RWTN
 smOu6oESPMbBxktQX3fJ1yLq1l7KD
X-Received: by 2002:a05:690c:22c6:b0:81f:64e8:cac5 with SMTP id
 00721157ae682-87124c7cf59mr112994797b3.7.1788859905900; Tue, 08 Sep 2026
 02:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260906194438.93046-1-gilles.grimaud@univ-lille.fr>
 <20260906194438.93046-4-gilles.grimaud@univ-lille.fr>
In-Reply-To: <20260906194438.93046-4-gilles.grimaud@univ-lille.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 10:31:33 +0100
X-Gm-Features: AcwNN1W1giourbBeIRogk9CNzzLL8nFkg8QVidsTpxr9rU5lc86AYCb_wkoRxkM
Message-ID: <CAFEAcA_O=k4=9Y1tnmuv0_Bfn8rfAzZ1gdR3br80=obYgObuFg@mail.gmail.com>
Subject: Re: [PATCH v3 03/36] target/arm: support Cortex-M0+ MPU
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Sun, 6 Sept 2026 at 20:44, Gilles Grimaud
<gilles.grimaud@univ-lille.fr> wrote:
>
> Cortex-M0+ implementations may provide an Armv6-M PMSA MPU with eight
> regions. QEMU uses its historical v7m/PMSAv7 naming for M-profile code
> shared by v6-M and v7-M, but currently exposes, allocates and migrates the
> existing region model only when ARM_FEATURE_V7 is set. This prevents a
> Cortex-M0+ board from enabling its optional MPU.
>
> Allow non-v8 M-profile CPUs to use the existing PMSAv7 state, migration
> state and translation path. Restrict the shared register model to the v6-M
> layout: do not expose the v7-M alias registers or TEX bits, and reject
> region sizes below the v6-M minimum of 256 bytes.
>
> The dedicated PMSAv8 path remains selected first for v8-M CPUs. Expose the
> pmsav7-dregion property and clear region state on reset.

I think I would split this into more than one patch; all these
things are distinct changes:
 * don't expose RBAR and RASR alias registers when Main Extension not present
 * TEX bits are RES0
 * region size minimum check is wrong
 * change if() conditions to include v6M when we are asking "is this PMSAv7?"


> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  hw/intc/armv7m_nvic.c | 27 ++++++++++++++++++++++++++-
>  target/arm/cpu.c      | 12 +++++++++---
>  target/arm/machine.c  |  3 ++-
>  target/arm/ptw.c      | 10 +++++++---
>  4 files changed, 44 insertions(+), 8 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index c1ceb7450f..a702bd0c38 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1405,6 +1405,11 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>              return cpu->env.pmsav8.rbar[attrs.secure][region];
>          }
>
> +        if (offset != 0xd9c &&
> +            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            goto bad_offset;
> +        }
> +
>          if (region >= cpu->pmsav7_dregion) {
>              return 0;
>          }
> @@ -1432,6 +1437,11 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
>              return cpu->env.pmsav8.rlar[attrs.secure][region];
>          }
>
> +        if (offset != 0xda0 &&
> +            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            goto bad_offset;
> +        }
> +
>          if (region >= cpu->pmsav7_dregion) {
>              return 0;
>          }
> @@ -1919,6 +1929,11 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>              return;
>          }
>
> +        if (offset != 0xd9c &&
> +            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            goto bad_offset;
> +        }
> +
>          if (value & (1 << 4)) {
>              /* VALID bit means use the region number specified in this
>               * value and also update MPU_RNR.REGION with that value.
> @@ -1969,12 +1984,22 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
>              return;
>          }
>
> +        if (offset != 0xda0 &&
> +            !arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            goto bad_offset;
> +        }

These alias registers don't exist on v8M without the Main Extension
either. We should model that by rearranging the case lines like this:

    case 0xda4: /* MPU_RBAR_A1 */
    case 0xdac: /* MPU_RBAR_A2 */
    case 0xdb4: /* MPU_RBAR_A3 */
        if (!arm_feature(&cpu->env, ARM_FEATURE_M_MAIN)) {
            /* These aliases are not present for v6M or v8M without Main */
            goto bad_offset;
        }
        /* fall through */
    case 0xd9c: /* MPU_RBAR */
    {
        [existing code here]

(similarly for the other 3 places.)



> +
>          if (region >= cpu->pmsav7_dregion) {
>              return;
>          }
>
>          cpu->env.pmsav7.drsr[region] = value & 0xff3f;
> -        cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
> +        } else {
> +            /* Armv6-M has XN, AP, S, C and B, but no TEX field. */
> +            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x1707;
> +        }
>          tlb_flush(CPU(cpu));
>          break;
>      }

This part is OK.

> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 77aa78f00e..f58a1db843 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -617,7 +617,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType type)
>                             sizeof(*env->pmsav8.rlar[M_REG_S])
>                             * cpu->pmsav7_dregion);
>                  }
> -            } else if (arm_feature(env, ARM_FEATURE_V7)) {
> +            } else if (arm_feature(env, ARM_FEATURE_V7) ||
> +                       arm_feature(env, ARM_FEATURE_M)) {
>                  memset(env->pmsav7.drbar, 0,
>                         sizeof(*env->pmsav7.drbar) * cpu->pmsav7_dregion);
>                  memset(env->pmsav7.drsr, 0,
> @@ -1656,7 +1657,11 @@ static void arm_cpu_post_init(Object *obj)
>  #ifndef CONFIG_USER_ONLY
>      if (arm_feature(&cpu->env, ARM_FEATURE_PMSA)) {
>          qdev_property_add_static(DEVICE(obj), &arm_cpu_has_mpu_property);
> -        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
> +        /*
> +         * QEMU's PMSAv7 state also models the Armv6-M MPU register layout.
> +         */
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7) ||
> +            arm_feature(&cpu->env, ARM_FEATURE_M)) {
>              qdev_property_add_static(DEVICE(obj),
>                                       &arm_cpu_pmsav7_dregion_property);
>          }
> @@ -2332,7 +2337,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
>      }
>
>      if (arm_feature(env, ARM_FEATURE_PMSA) &&
> -        arm_feature(env, ARM_FEATURE_V7)) {
> +        (arm_feature(env, ARM_FEATURE_V7) ||
> +         arm_feature(env, ARM_FEATURE_M))) {
>          uint32_t nr = cpu->pmsav7_dregion;
>
>          if (nr > 0xff) {
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 7005f4e5d7..53a2734d25 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -584,7 +584,8 @@ static bool pmsav7_needed(void *opaque)
>      CPUARMState *env = &cpu->env;
>
>      return arm_feature(env, ARM_FEATURE_PMSA) &&
> -           arm_feature(env, ARM_FEATURE_V7) &&
> +           (arm_feature(env, ARM_FEATURE_V7) ||
> +            arm_feature(env, ARM_FEATURE_M)) &&
>             !arm_feature(env, ARM_FEATURE_V8);
>  }
>
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index a29de0385f..6cb8a8394a 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -2748,9 +2748,12 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
>                  continue;
>              }
>
> -            if (!rsize) {
> +            if (!rsize ||
> +                (arm_feature(env, ARM_FEATURE_M) &&
> +                 !arm_feature(env, ARM_FEATURE_V7) && rsize < 7)) {
>                  qemu_log_mask(LOG_GUEST_ERROR,
> -                              "DRSR[%d]: Rsize field cannot be 0\n", n);
> +                              "DRSR[%d]: invalid Rsize field 0x%x\n",
> +                              n, rsize);
>                  continue;
>              }
>              rsize++;

We don't get this "minimum size check" right for v7M either,
because that wants a SIZE field of at least 4. The zero check
is only correct for R-profile.

It's not strictly necessary to fix this bug as part of adding
cortex-m0+ support, because we already get this wrong for other
M-profile CPUs, and a correctly programmed guest won't run into it.
If we want to do it, then better as a separate patch that fixes both
v6M and v7M, something like:

    /* minimum valid value for rsize varies between v7R, v6M, v7M */
    uint32_t rsize_min = 1;
    if (arm_feature(env, ARM_FEATURE_M) {
        rsize_min = arm_feature(env, ARM_FEATURE_V7) ? 4 : 7;
    }

    for (n = ... )  {
        ...
        if (rsize < rsize_min) {
            log and continue;
        }



> @@ -3901,7 +3904,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
>              /* PMSAv8 */
>              ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
>                                         result, fi);
> -        } else if (arm_feature(env, ARM_FEATURE_V7)) {
> +        } else if (arm_feature(env, ARM_FEATURE_V7) ||
> +                   arm_feature(env, ARM_FEATURE_M)) {
>              /* PMSAv7 */
>              ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
>                                         result, fi);

I think these other if condition changes are all OK.

thanks
-- PMM

