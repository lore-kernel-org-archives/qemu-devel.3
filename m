Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E182C27C6E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 11:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI4zc-0003bk-5c; Fri, 14 Jun 2024 07:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI4zb-0003bY-2A
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:21:15 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sI4zZ-0002ci-0g
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 07:21:14 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a6269885572so544352166b.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 04:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718364071; x=1718968871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yaABqv84rYHxykGe0WIvn3NDl572X9PcVYZkK3pewYQ=;
 b=wvZSxlIg6LeGGnnMl38kRry/QU0CSu7rdXrmsFOq9Bx33I/Trtdqzw8pE0EplMBDbA
 kiccwjmgJNK3sRaOwnwiMu2PNjMxup+cBoEPuRpi62mOMDIL3j8risj4qmwvchLiCEu4
 pbyVZloAabfeth0ykl5t1tWztKSDoFElFPckuWz5Cie8spMKipbdDvgOzIKGDRX2fJZD
 vfzQX81PpwhHXyNAb1ifB9HYtrD+7owrn7sknS2PQO9uNttIolB3zOe9DYV9rwKiscJl
 Ikk1LKY8jgSdtNPXDjzmefwtdJ7aTU4aqwBq4Gv1v/1hRCmjx5IabDXVJbbH4juCEjHx
 blCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718364071; x=1718968871;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yaABqv84rYHxykGe0WIvn3NDl572X9PcVYZkK3pewYQ=;
 b=mIkk7Ju650w27I5Iv29oPQx1v86M2EwR0m9t52/QS9d8dTi1KUx7/DrJPkU/7m4ATG
 9CkycJs5t6SiRWmgaezWhC2umi3N/nqrGSNHsmS608NajXELKa1pMaA7dIL+42IPL6Uk
 7CJWTXzGy9GyJcMd/fTnBAWyF0dlXYrzHK31MIIEGgAa1T0I5RNKdmL7OCI/Hezq2DTk
 4OBN7XgMNp0Mq9FIPA+U8Ob8CthLxk0d8vk+aBuvk9CQiaAZ22gFi3rAh+Ji4G1VOcUk
 Um22LCL+aAIZlr3iEP5yygVhI549iWJWdjNwWk5UXEZbMpqdFTx31Ahb0oWgzGRQN3XG
 0EDA==
X-Gm-Message-State: AOJu0YwEwZTi3quAvAKFpSWyl2SAGe8fvAHVX6vyCL2muFOvyzm/A0Ih
 0uiIRWdSoUWDq7KOJmU3XotOVtrrGD72O8DzOyC/gByKqg6IC2ha98tRj0VOWto=
X-Google-Smtp-Source: AGHT+IGtU36/YLNiyoB/ecTIQFr8QITEh5Rlv6MWR01k7B+XOaqYZ0f/94Rzm93P7lsfse3lpFosQw==
X-Received: by 2002:a17:906:71d3:b0:a6f:6c3e:69c7 with SMTP id
 a640c23a62f3a-a6f6c3e83bfmr28425666b.10.1718364071078; 
 Fri, 14 Jun 2024 04:21:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f56dd2daasm174910266b.97.2024.06.14.04.21.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jun 2024 04:21:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 129B35F794;
 Fri, 14 Jun 2024 12:21:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  peter.maydell@linaro.org,
 richard.henderson@linaro.org
Subject: Re: [PATCH v2 6/9] target/arm: Factor out code for setting MTE TCF0
 field
In-Reply-To: <20240613172103.2987519-7-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Thu, 13 Jun 2024 17:21:00 +0000")
References: <20240613172103.2987519-1-gustavo.romero@linaro.org>
 <20240613172103.2987519-7-gustavo.romero@linaro.org>
Date: Fri, 14 Jun 2024 12:21:10 +0100
Message-ID: <87h6dvvkgp.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  linux-user/aarch64/target_prctl.h | 22 ++-----------
>  target/arm/mte.h                  | 53 +++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+), 20 deletions(-)
>  create mode 100644 target/arm/mte.h
>
> diff --git a/linux-user/aarch64/target_prctl.h b/linux-user/aarch64/targe=
t_prctl.h
> index aa8e203c15..8a11404222 100644
> --- a/linux-user/aarch64/target_prctl.h
> +++ b/linux-user/aarch64/target_prctl.h
> @@ -7,6 +7,7 @@
>  #define AARCH64_TARGET_PRCTL_H
>=20=20
>  #include "target/arm/cpu-features.h"
> +#include "target/arm/mte.h"

We are moving a helper that is TCG only but using the common code path.
I suspect the prototype better belongs in target/arm/tcg/mte_helper.h or
possibly target/arm/tcg/mte_user_helper.h if we are just using it for
user-mode.

>=20=20
>  static abi_long do_prctl_sve_get_vl(CPUArchState *env)
>  {
> @@ -173,26 +174,7 @@ static abi_long do_prctl_set_tagged_addr_ctrl(CPUArc=
hState *env, abi_long arg2)
>      env->tagged_addr_enable =3D arg2 & PR_TAGGED_ADDR_ENABLE;
>=20=20
>      if (cpu_isar_feature(aa64_mte, cpu)) {
> -        /*
> -         * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> -         *
> -         * The kernel has a per-cpu configuration for the sysadmin,
> -         * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> -         * which qemu does not implement.
> -         *
> -         * Because there is no performance difference between the modes,=
 and
> -         * because SYNC is most useful for debugging MTE errors, choose =
SYNC
> -         * as the preferred mode.  With this preference, and the way the=
 API
> -         * uses only two bits, there is no way for the program to select
> -         * ASYMM mode.
> -         */
> -        unsigned tcf =3D 0;
> -        if (arg2 & PR_MTE_TCF_SYNC) {
> -            tcf =3D 1;
> -        } else if (arg2 & PR_MTE_TCF_ASYNC) {
> -            tcf =3D 2;
> -        }
> -        env->cp15.sctlr_el[1] =3D deposit64(env->cp15.sctlr_el[1], 38, 2=
, tcf);
> +        set_mte_tcf0(env, arg2);
>=20=20
>          /*
>           * Write PR_MTE_TAG to GCR_EL1[Exclude].
> diff --git a/target/arm/mte.h b/target/arm/mte.h
> new file mode 100644
> index 0000000000..89712aad70
> --- /dev/null
> +++ b/target/arm/mte.h
> @@ -0,0 +1,53 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * Copyright (c) 2024 Linaro, Ltd.
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
> + */
> +
> +#ifndef MTE_H
> +#define MTE_H
> +
> +#ifdef CONFIG_TCG
> +#ifdef CONFIG_USER_ONLY
> +#include "sys/prctl.h"
> +
> +static void set_mte_tcf0(CPUArchState *env, abi_long value)

Same comments as Phil regarding should it be inline, add a prefix etc...

> +{
> +    /*
> +     * Write PR_MTE_TCF to SCTLR_EL1[TCF0].
> +     *
> +     * The kernel has a per-cpu configuration for the sysadmin,
> +     * /sys/devices/system/cpu/cpu<N>/mte_tcf_preferred,
> +     * which qemu does not implement.
> +     *
> +     * Because there is no performance difference between the modes, and
> +     * because SYNC is most useful for debugging MTE errors, choose SYNC
> +     * as the preferred mode.  With this preference, and the way the API
> +     * uses only two bits, there is no way for the program to select
> +     * ASYMM mode.
> +     */
> +    unsigned tcf =3D 0;
> +    if (value & PR_MTE_TCF_SYNC) {
> +        tcf =3D 1;
> +    } else if (value & PR_MTE_TCF_ASYNC) {
> +        tcf =3D 2;
> +    }
> +    env->cp15.sctlr_el[1] =3D deposit64(env->cp15.sctlr_el[1], 38, 2, tc=
f);
> +}
> +#endif /* CONFIG_USER_ONLY */
> +#endif /* CONFIG_TCG */
> +
> +#endif /* MTE_H */

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

