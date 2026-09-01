Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADF6C61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 17:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1SfI-0007Fn-TE; Tue, 01 Sep 2026 13:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1SfG-0007EU-MT
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:52:54 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1x1SfD-0003Jf-Tu
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 13:52:54 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so950635e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788285170; x=1788889970; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=vxVrMcjTp9d44QOfwg9Ae5iqjbM1/OsoddojrKC5OEA=;
 b=JkOnRUEc82g8INNIfRudjl5MJR3u9FKgkQqNQHTWtX/Scl0jsNpLfViZ2QShT8TvU0
 lJYegUX345h4t3YYkUzFxjEcxPRfJHe/+aP4X8PEhDHaAkq4X/Wcgh2S83dvSTDM3Prq
 +DeUFYrvBlgdFfGYa/08BbQY6kQ4FQ/FM7MjswIVtnH2P2GZldqQ1flc24nm7o5o+Yf+
 V+DGBIm793vuoVUqRmF4VfI52ACX8e/nZuvnKzBRSxCuxzVAHyDe2gGrB9Xv2b2VFX87
 hm1ntRf+I8MD74bhnfPVrNX++LDzg9KbgQxRKZvKcKqVmqcBMbxk6jjXArQUbYvWc9sY
 4CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788285170; x=1788889970;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxVrMcjTp9d44QOfwg9Ae5iqjbM1/OsoddojrKC5OEA=;
 b=dzaRyspLxwhVZq3SQa2WrJ6Nuan2zNK4IUcYMFtvj3vzHHDs9YLf4ptid9SuDV8O+C
 FANODiitO4yWZuijnZDTQU76Dv2ngDMJez0rlW9rX9F4v6/RsUorkheu6wrP/rvRdjU+
 Xt719dACvd7pWRNDibXokZYj7gtExUrvgNb18eqfi7yxeD7de9wDwIfCQHFoDGqvm62X
 zcNzbOGH86H+qp/L7DmvUHFTX0sARj6HY8Gq+OTdzIrDcnlzUgwNWPXEFZC0xLEk38gZ
 mfnWDliyQ0iSmoZCKb9QH1/433U5hQnd18qgWLOc7bgieLmXimpBv29AO/+fT+KDFXQS
 B47A==
X-Gm-Message-State: AFuF++lJEfrxryVPMfZgp8vwICq5dWLKKdtOm3RnqBDE6JPjEz5B3DjX
 EG3Lz7lTtUGzt76WSsxsPT3tHWcv6v9onOC4TcGVle/de2d4lcA834nSnh0BD+99UU0=
X-Gm-Gg: AR+sD12oN/Ju4Vi61su+TxMdLSC86UIYE9W9jVZTHDA+D9HKcohYNa8tRq7xT/sY5JZ
 YKa7isnZhBoPrVSVCzDVLPEZmdafbH2s2aZZz51CBloZlg+6cDrUePIobOoAuN9/s727rwYUV8w
 uNP672aBs4+czGby+e2EKOrKwi/uzRCQqDEJ8S1WWEGzsFEZ41PQWRumCsgAqIEFTSw4dhI7eVG
 lQTTWEv6ZO0FMri6cxYtUEx1GvXEZ1sAPTjSDNMO+ge0hu8c0mq7BRXXHBX7qYQOwaAx3L1QF3/
 Hnnw04y0NId5bGoJd6LuXScnoJVX5UYjDndA22ebrMCuAdZQNk58370B22OU1FQnQs9TjZEwo5S
 3o6I+1n5Hq6IXaXr4gEBC03CRjK5RcCxd8nkYohWZscRVDZJU+vU3rcV9ISUdPKO90/PVMnsGP2
 S8pZ/RP6pKJAsHKs+ZYUM8UdslhgtH8O7r2C3gzrcYLnSCdnukdHy8zB5fM2Q5
X-Received: by 2002:a05:600c:1d8c:b0:499:4e47:eaf2 with SMTP id
 5b1f17b1804b1-49cdc417b87mr198583725e9.6.1788285169991; 
 Tue, 01 Sep 2026 10:52:49 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce464aa70sm3655225e9.6.2026.09.01.10.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 10:52:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E1B525F829;
 Tue, 01 Sep 2026 18:52:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH RFC v2 01/30] target/arm: support Cortex-M0+ MPU
In-Reply-To: <20260829234308.33725-2-gilles.grimaud@univ-lille.fr> (Gilles
 Grimaud's message of "Sun, 30 Aug 2026 01:42:35 +0200")
References: <20260829234308.33725-1-gilles.grimaud@univ-lille.fr>
 <20260829234308.33725-2-gilles.grimaud@univ-lille.fr>
User-Agent: mu4e 1.14.4-pre1; emacs 30.1
Date: Tue, 01 Sep 2026 18:52:47 +0100
Message-ID: <87wlt4uads.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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

Gilles Grimaud <gilles.grimaud@univ-lille.fr> writes:

> From: gilles grimaud <gilles.grimaud@univ-lille.fr>
>
> Cortex-M0+ implementations may provide an Armv6 PMSA MPU with eight regio=
ns. QEMU already marks M-profile CPUs as PMSA, but only exposes and allocat=
es the existing region model for Armv7 CPUs. This prevents a Cortex-M0+ boa=
rd from enabling its optional MPU.
>

Just a comment for all patches, you should ensure your editor wraps at
80 columns (72 for title) as patches are often read on terminals.

It's good habit to run through checkpatch.pl to pick up the minor
oft-forgotten stuff.

> Use QEMU's PMSAv7 state and translation path for the compatible
> Armv6-M MPU register layout. Permit CONTROL.nPRIV changes when the
> optional MPU is present and clear the region state on reset.

Hmm will need to think about this - the file is explicitly targeting the
armv7_nvic so we might want to consider renaming if indeed special
casing the differences is the right thing to do.

That does make the spread of changes about both nvic and cpu hard to
review. Is env->pmsav7.drbar related to env.v7m.vecbase[!attrs.secure]
for example.

>
> Signed-off-by: gilles grimaud <gilles.grimaud@univ-lille.fr>
> ---
>  hw/intc/armv7m_nvic.c     |  3 +++
>  target/arm/cpu.c          | 12 +++++++++---
>  target/arm/ptw.c          |  3 ++-
>  target/arm/tcg/m_helper.c | 10 +++++++++-
>  4 files changed, 23 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index a7651f831e..3140599ac1 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1626,6 +1626,9 @@ static void nvic_writel(NVICState *s, uint32_t offs=
et, uint32_t value,
>          break;
>      case 0xd08: /* Vector Table Offset.  */
>          cpu->env.v7m.vecbase[attrs.secure] =3D value & 0xffffff80;
> +        if (!arm_feature(&cpu->env, ARM_FEATURE_M_SECURITY)) {
> +            cpu->env.v7m.vecbase[!attrs.secure] =3D value & 0xffffff80;
> +        }
>          break;
>      case 0xd0c: /* Application Interrupt/Reset Control (AIRCR) */
>          if ((value >> R_V7M_AIRCR_VECTKEY_SHIFT) =3D=3D 0x05fa) {
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 77aa78f00e..f58a1db843 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -617,7 +617,8 @@ static void arm_cpu_reset_hold(Object *obj, ResetType=
 type)
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
> +         * QEMU's PMSAv7 state also models the Armv6-M MPU register layo=
ut.
> +         */
> +        if (arm_feature(&cpu->env, ARM_FEATURE_V7) ||
> +            arm_feature(&cpu->env, ARM_FEATURE_M)) {
>              qdev_property_add_static(DEVICE(obj),
>                                       &arm_cpu_pmsav7_dregion_property);
>          }
> @@ -2332,7 +2337,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>      }
>=20=20
>      if (arm_feature(env, ARM_FEATURE_PMSA) &&
> -        arm_feature(env, ARM_FEATURE_V7)) {
> +        (arm_feature(env, ARM_FEATURE_V7) ||
> +         arm_feature(env, ARM_FEATURE_M))) {
>          uint32_t nr =3D cpu->pmsav7_dregion;
>=20=20
>          if (nr > 0xff) {
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index a29de0385f..b366a8d3dd 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3901,7 +3901,8 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S=
1Translate *ptw,
>              /* PMSAv8 */
>              ret =3D get_phys_addr_pmsav8(env, ptw, address, access_type,
>                                         result, fi);
> -        } else if (arm_feature(env, ARM_FEATURE_V7)) {
> +        } else if (arm_feature(env, ARM_FEATURE_V7) ||
> +                   arm_feature(env, ARM_FEATURE_M)) {
>              /* PMSAv7 */

And again by definition this is PMSAv7, not v6 - you'll note we have
plenty of places where we do check against ARM_FEATURE_V6 (or V6K).

>              ret =3D get_phys_addr_pmsav7(env, ptw, address, access_type,
>                                         result, fi);
> diff --git a/target/arm/tcg/m_helper.c b/target/arm/tcg/m_helper.c
> index f4ba93b291..667b2a3cbd 100644
> --- a/target/arm/tcg/m_helper.c
> +++ b/target/arm/tcg/m_helper.c
> @@ -16,6 +16,7 @@
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
>  #include "exec/page-protection.h"
> +#include "exec/cputlb.h"
>  #ifdef CONFIG_TCG
>  #include "accel/tcg/cpu-ldst-common.h"
>  #include "semihosting/common-semi.h"
> @@ -2775,9 +2776,16 @@ void HELPER(v7m_msr)(CPUARMState *env, uint32_t ma=
skreg, uint32_t val)
>                             !arm_v7m_is_handler_mode(env))) {
>              write_v7m_control_spsel(env, (val & R_V7M_CONTROL_SPSEL_MASK=
) !=3D 0);
>          }
> -        if (cur_el > 0 && arm_feature(env, ARM_FEATURE_M_MAIN)) {
> +        if (cur_el > 0 && (arm_feature(env, ARM_FEATURE_M_MAIN) ||
> +                           env_archcpu(env)->has_mpu)) {
> +            uint32_t old_control =3D env->v7m.control[env->v7m.secure];
> +
>              env->v7m.control[env->v7m.secure] &=3D ~R_V7M_CONTROL_NPRIV_=
MASK;
>              env->v7m.control[env->v7m.secure] |=3D val & R_V7M_CONTROL_N=
PRIV_MASK;
> +            if ((old_control ^ env->v7m.control[env->v7m.secure]) &
> +                R_V7M_CONTROL_NPRIV_MASK) {
> +                tlb_flush(env_cpu(env));
> +            }
>          }
>          if (cpu_isar_feature(aa32_vfp_simd, env_archcpu(env))) {
>              /*

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

