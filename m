Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1C8CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:48:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFt-00035L-VO; Thu, 28 Aug 2025 13:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbwb-0004Q7-EP
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:41:33 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1urbwZ-0006DC-KR
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 08:41:33 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-61c4f73cf20so1566951a12.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 05:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756384890; x=1756989690; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JMQ6mNN1qJHOswDd/UqFQ1lKqurpQQ1An6/zOUe9OOU=;
 b=JWH7T0Ht3PF/H6sKGdwDslRHw1egXza8bHY7JBjwpaXis2H+yDClcbd6DzOOPDoVyY
 bQZG/IPLM+WOp/tARF1TNVdeKiXfAYRTVjGLw4cR4q0lJ1eunKN+H8su3v5py6HTMtB3
 encUx+LkZa9+X2vt6AOcOYceoaUar0gEaI/FvzpMp7ALaAnGv6ck1DFTYU6itwK/qoDM
 3QJpT87VP7rssbJ3GA99PHgOsnYNOO/5o1VFbUSYuduj44HeKf/hImc/npCm/fhXmZe5
 TQNhQr6p9Fhvb7PsrBjS2h9numSFoSFw33CP8QLMebjgFGqHv+uw25J2RduPjXShy/Rh
 E4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756384890; x=1756989690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JMQ6mNN1qJHOswDd/UqFQ1lKqurpQQ1An6/zOUe9OOU=;
 b=l7AC2EbJp30hI1eD6gGdBhkLX2A4q8eWgrIfwVCwhvL+CNeXuH1l5ncsX3w4RkB0J5
 fula8P8bkMZXC1aKrGDUVg/jgYgPF9mpXYaqI/Bch7Wgp2T0GksaVWtF1Znybaxnv2du
 uVdcTQz47YYQrpZ9XE8UfQ2cr1oojvxs0ZqDQzrkuJ/xxt10vII/eNcott/Kn9yVlPJi
 aUHJl2NSAjQfISAdTaI2xyGkr95eLcCl1SRYCKT+2q6r99nj5+P//ZMAfaXwcTjFWKzk
 nsC4iFao2+iL2sc0TVJN8vcOnIV9wX3TPfQOZswERYy4Cpu46VCCfNDAonM+cAc/Ql25
 RDOQ==
X-Gm-Message-State: AOJu0Yw4qjcmaE4p4vB9sRhFiuCbPMfuNzcH1v+Pr46DGyDf4B4cQ69C
 FqChlzq/MWyOfXYzHr/KX5bPL19I5BTU+6k5I/cZV9VhcfTFpRpzI3KVqsDgtH207wLMD67gECz
 Xm2/xLwbi0XQ1AFlqLrIPHxUGJ3Xzv2mITM6lLYiWJn3VPKaST91hHlZsOQ==
X-Gm-Gg: ASbGnct27RZrZ7B3phUsagLMEqoqKd/Z4DX2O31OTDCnhykhN6iMmFCS1E1bTNGrHau
 NTvflBVM35iWIMuDWnk+1FDbt6JGdn0cqgC387L5uBxRTuCmTAdFHbv8Xq63AquG7oVCYY+yT/5
 4O6k/vtCSuG4SN613cQY6KNvrafphjWhLWMI0fD+1gbA0SGU27YzYUQpghFbwcNdKj/3LpgW44D
 B1WTBVAW38aZjRcr34zBw6UVjuTCw==
X-Google-Smtp-Source: AGHT+IF3yyptflGVFifRVKc7BOGQDbOBUK+7uTMBa8kL11nVQ6QW0qWE7P9cJBIQwqUgeqgxDN6ddceRpkO5sSkbAN8=
X-Received: by 2002:a17:906:c10f:b0:afe:e03c:2d70 with SMTP id
 a640c23a62f3a-afee03c325dmr243322566b.16.1756384889786; Thu, 28 Aug 2025
 05:41:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
 <20250827010453.4059782-16-richard.henderson@linaro.org>
In-Reply-To: <20250827010453.4059782-16-richard.henderson@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 28 Aug 2025 15:41:03 +0300
X-Gm-Features: Ac12FXxMSxBk14S28-wEQWcGRZlgWItJO6EZpFvGWInyvQwR6xdhl7772GVKw_0
Message-ID: <CAAjaMXYjJsxhBY=W6J7yaG20MiAszRjrUJGWbC6=ZYDhs42EUQ@mail.gmail.com>
Subject: Re: [PATCH 11/61] target/arm: Rename all ARMCPRegInfo from opaque to
 ri
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, Aug 27, 2025 at 4:11=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These pointers are no opaque, they have a specific type.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  target/arm/cpregs.h | 10 +++++-----
>  target/arm/helper.c |  6 +++---
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/target/arm/cpregs.h b/target/arm/cpregs.h
> index c9506aa6d5..3344a02bd3 100644
> --- a/target/arm/cpregs.h
> +++ b/target/arm/cpregs.h
> @@ -841,15 +841,15 @@ typedef struct ARMCPRegInfo ARMCPRegInfo;
>   * Access functions for coprocessor registers. These cannot fail and
>   * may not raise exceptions.
>   */
> -typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *opaque);
> -typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *opaque,
> +typedef uint64_t CPReadFn(CPUARMState *env, const ARMCPRegInfo *ri);
> +typedef void CPWriteFn(CPUARMState *env, const ARMCPRegInfo *ri,
>                         uint64_t value);
>  /* Access permission check functions for coprocessor registers. */
>  typedef CPAccessResult CPAccessFn(CPUARMState *env,
> -                                  const ARMCPRegInfo *opaque,
> +                                  const ARMCPRegInfo *ri,
>                                    bool isread);
>  /* Hook function for register reset */
> -typedef void CPResetFn(CPUARMState *env, const ARMCPRegInfo *opaque);
> +typedef void CPResetFn(CPUARMState *env, const ARMCPRegInfo *ri);
>
>  #define CP_ANY 0xff
>
> @@ -1075,7 +1075,7 @@ void raw_write(CPUARMState *env, const ARMCPRegInfo=
 *ri, uint64_t value);
>   * CPResetFn that does nothing, for use if no reset is required even
>   * if fieldoffset is non zero.
>   */
> -void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque);
> +void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri);
>
>  /*
>   * Return true if this reginfo struct's field in the cpu state struct
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d230f9e766..e03cbc0394 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1067,7 +1067,7 @@ static const ARMCPRegInfo v6k_cp_reginfo[] =3D {
>        .resetvalue =3D 0 },
>  };
>
> -static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *op=
aque)
> +static void arm_gt_cntfrq_reset(CPUARMState *env, const ARMCPRegInfo *ri=
)
>  {
>      ARMCPU *cpu =3D env_archcpu(env);
>
> @@ -5407,7 +5407,7 @@ static const ARMCPRegInfo rndr_reginfo[] =3D {
>        .access =3D PL0_R, .readfn =3D rndr_readfn },
>  };
>
> -static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *opaque,
> +static void dccvap_writefn(CPUARMState *env, const ARMCPRegInfo *ri,
>                            uint64_t value)
>  {
>  #ifdef CONFIG_TCG
> @@ -7730,7 +7730,7 @@ uint64_t arm_cp_read_zero(CPUARMState *env, const A=
RMCPRegInfo *ri)
>      return 0;
>  }
>
> -void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *opaque)
> +void arm_cp_reset_ignore(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      /* Helper coprocessor reset function for do-nothing-on-reset registe=
rs */
>  }
> --
> 2.43.0
>
>

