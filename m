Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA769C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAVM-0006Aw-Kw; Fri, 28 Jun 2024 08:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAVK-0006AW-Iy
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:15:02 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAVG-000711-AF
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:15:02 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a70c0349b64so70329866b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719576895; x=1720181695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9N2RZOd2PrjHO40Jjqc6YMMgnVB+Yc48XMiOs3lZHBI=;
 b=jNLce32r04uOdJRW/lIoPCp4rNCHnGJ4MsICaZqANxj7Xu2K5una/fUHy5Nb+ubD/1
 aqCvDO/nqI0YUYb4U1sWYGJNvLX1Gtu6xn6JIfEjbWaHobzWg0YY51L86mrafUeYTr3u
 nuinb4A4WqDyp5RYIf86pRaubEjzga6M0/HADoEFv8mqEAp3pYID3G/4LdP+3e1H/4gz
 5x6iaJ72Cd9RxPjIf8Me2JwV+Kk7ewXs/mdsBED17+ctlNUPGJ6mRDT5SWXkITl7YhbH
 C+ktyhTgvS53cbNxiz1tmr+aw14cTDo1uEiy5ITcdCfURkMHd0qMwr0s4J/CylwgJbit
 8iSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719576895; x=1720181695;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9N2RZOd2PrjHO40Jjqc6YMMgnVB+Yc48XMiOs3lZHBI=;
 b=eMUKVOY30xwi51vj24L6bpda1SlAs0ua5Bn81+2RBStK6xa+qVcaEdGKgGM5vs3GzA
 2pAdH7DRWpXvjvXs6KGupI7LzCZP/Tc+PobLg7omH5+wTburVNYPop6uW0DYUeshcBd3
 JdnUvV9lj1jLDGJV3idYOyPjhPYRsL0osyBZqNl5AVtl5oKILVHuH0MAIFlDggf2Jkvw
 0Jx1OMUeLn0kHPw3lnIxDF1H2tQ8jiL/y+8bYcxsC+yD3YPXYsdWq/rLX1AcZ80icjlP
 +ENH5aSTsR19JReyrlmkf2swZDQK8gI6SozqMLCDVJYaG67GlKRxyD/pEB63BRmETbht
 Xh1g==
X-Gm-Message-State: AOJu0Yz0pTRf/iSYCW82VDOYuH8fZ4rak1XvROxCxi/Lsj/p9HLtbluz
 +I1NO+4Q2jumyHsbg8ruSbUOjnBHkt4XbFaE57brUo2b+aJv3lXa30oGG+tXLNQ=
X-Google-Smtp-Source: AGHT+IFouuXYiSYVhLv+iBYa/3GetIHEBc1c/Qx3SZ+sAVn+Cg08ifuaAa2o6gBwzsqRACzlA+8Xiw==
X-Received: by 2002:a17:907:d506:b0:a72:54cd:cff with SMTP id
 a640c23a62f3a-a7254cd117bmr1173813666b.52.1719576894545; 
 Fri, 28 Jun 2024 05:14:54 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08d0c1sm74045166b.164.2024.06.28.05.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:14:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1B4475F7A1;
 Fri, 28 Jun 2024 13:14:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,
 richard.henderson@linaro.org,  peter.maydell@linaro.org
Subject: Re: [PATCH v6 06/11] target/arm: Factor out code for setting MTE
 TCF0 field
In-Reply-To: <20240628050850.536447-7-gustavo.romero@linaro.org> (Gustavo
 Romero's message of "Fri, 28 Jun 2024 05:08:45 +0000")
References: <20240628050850.536447-1-gustavo.romero@linaro.org>
 <20240628050850.536447-7-gustavo.romero@linaro.org>
Date: Fri, 28 Jun 2024 13:14:52 +0100
Message-ID: <87zfr5nu0z.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Gustavo Romero <gustavo.romero@linaro.org> writes:

> Factor out the code used for setting the MTE TCF0 field from the prctl
> code into a convenient function. Other subsystems, like gdbstub, need to
> set this field as well, so keep it as a separate function to avoid
> duplication and ensure consistency in how this field is set across the
> board.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  linux-user/aarch64/meson.build       |  2 ++
>  linux-user/aarch64/mte_user_helper.c | 34 ++++++++++++++++++++++++++++
>  linux-user/aarch64/mte_user_helper.h | 25 ++++++++++++++++++++
>  linux-user/aarch64/target_prctl.h    | 22 ++----------------
>  4 files changed, 63 insertions(+), 20 deletions(-)
>  create mode 100644 linux-user/aarch64/mte_user_helper.c
>  create mode 100644 linux-user/aarch64/mte_user_helper.h
>
> diff --git a/linux-user/aarch64/meson.build b/linux-user/aarch64/meson.bu=
ild
> index 248c578d15..f75bb3cd75 100644
> --- a/linux-user/aarch64/meson.build
> +++ b/linux-user/aarch64/meson.build
> @@ -9,3 +9,5 @@ vdso_le_inc =3D gen_vdso.process('vdso-le.so',
>                                 extra_args: ['-r', '__kernel_rt_sigreturn=
'])
>=20=20
>  linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [vdso_be_inc, vdso_le=
_inc])
> +
> +linux_user_ss.add(when: 'TARGET_AARCH64', if_true: [files('mte_user_help=
er.c')])
> diff --git a/linux-user/aarch64/mte_user_helper.c b/linux-user/aarch64/mt=
e_user_helper.c
> new file mode 100644
> index 0000000000..8be6deaf03
> --- /dev/null
> +++ b/linux-user/aarch64/mte_user_helper.c
> @@ -0,0 +1,34 @@
> +/*
> + * ARM MemTag convenience functions.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#include <sys/prctl.h>

Aside from missing the osdep Phillipe pointed out including prctl.h here
is very suspect as its a system header. I assume if we need
PR_MTE_TCF_SYNC we should hoist the definition that linux-user uses into
a common header.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

