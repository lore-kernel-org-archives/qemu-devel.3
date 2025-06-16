Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6869FC71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 10:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6qU-00012Y-Lx; Mon, 16 Jun 2025 06:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uR6qS-00011j-VX
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:13:41 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uR6qQ-0004uF-Nd
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 06:13:40 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e4b1acf41so32060557b3.3
 for <qemu-devel@nongnu.org>; Mon, 16 Jun 2025 03:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750068817; x=1750673617; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=myMoC59CrVV7DJJf0TQM0d5I4yp7MeVuM7bqJULYDGY=;
 b=cL2ZacSiaI2YNVpblJJuJwBrBaR+wWwzjOTYvwC7A+lSkVBMGtRt/PwTdRKLXeT/FS
 bIK2wS13Z36aWOhtU4C0Tw2xByGAS9J1jH8h4c3+m8bjqoI+Wal2GDZ+X/ukxGXl09eF
 UIUNGWx74ZHMITCL4nTvTx6XsXTB2Pkx5gdBBZnOgzyzpECDS8vc3adxX6MEvUtmkDLK
 alevDaBFxCVgs7F4iU/GVeDdb6an9SZv6n8HBUPhek04o77r4/sWrVWlMetosACpw1rH
 Tfwz3vW3MXa+LtCaQcTc6JXrIxe0447OxxUpt8fi7HX2k7L2hHCM0SEmCI9+Ww0Lp63e
 ding==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750068817; x=1750673617;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=myMoC59CrVV7DJJf0TQM0d5I4yp7MeVuM7bqJULYDGY=;
 b=PHlzkLuIghOsC66kcr4kXqcNr1V9JEWY7RqzpvcEYR9W3GFEQyeggdsu/6d38Rs1fD
 S6pUbPrgqoXJKmxEL0+a1wPEn6R69IPV+9lHLUpgOiXz9Pjzui8GqYohr3Cx2WJjniu2
 o7HAaVTUhi3Yk7uxEDzZPxA/e7P7cMhNomyNEdgb63n+UtZlAzQmL/IyAugjgBBIjwuy
 OiM3pzE4+QwClqzfYnCxV/u3f5Am+BvqKaI+yvDflyjrJ5Y79JQvbgIlFdL2twMovb58
 eYjt3z12rJdB7Qgl3EqY866bbBBvygRUIF5momcnpx691uwDIwTrJR98k5z37eNyAGe5
 uRqQ==
X-Gm-Message-State: AOJu0YzfhzvqJo2G43eaA2Qx8Uf3/x3TetcYwFsGbVtDTh+R/VQM/XC0
 ijypFlcjFFxXkH0gr3tA3IHQqoaiejBt7jWLY4ZA+4OLR6xyfVHbKf/yzHNqZJ0IEL3j4NktuaB
 FwU0qqTP4yIUjhe0Zxr1Bp8shsWZz+QtucF6SMvlcwwkeRu3+lPVd
X-Gm-Gg: ASbGncsc8gXdA2/7ZEELTEYAidvF2UuzC3AHe2BRWfr3oARQdptq07vvw+Ie+hvlM71
 gY6MEZg3eXWs5Wx+2AELs625bG4QKF9loKXRDd67IK753o3MiHef3SBTgVSgd8NwRKtnniYRV9H
 EJrFPvqdlq/rhH6O/+aUPbG5ZJ2Y+sVt/Xwd1xQr1E4Pxv
X-Google-Smtp-Source: AGHT+IG7j9zzc9ysCTsFdtrBbadhSFcdbHCXkbwAXIANFzHJjjNbzGxvFRkhAsEHwZxiCWkB/Bk8aMuggeWOFiAtJOs=
X-Received: by 2002:a05:690c:6c83:b0:70e:2cba:868c with SMTP id
 00721157ae682-71175489fbcmr130999717b3.11.1750068816810; Mon, 16 Jun 2025
 03:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250613-cache-v1-1-ee9f4a9ba81b@gmx.net>
In-Reply-To: <20250613-cache-v1-1-ee9f4a9ba81b@gmx.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jun 2025 11:13:24 +0100
X-Gm-Features: AX0GCFuqr27nCnG67__hZM7mlT9RKestBHDucyc2KumW6HcZns63UIdsT2f-Y1o
Message-ID: <CAFEAcA9ZS-8YKwboEYz_rWCFr5ezu3UOdhRaww3eJ2=cUKVeyA@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm: Fix return value of SYS_cacheflush
To: =?UTF-8?B?Si4gTmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Fri, 13 Jun 2025 at 17:02, J. Neusch=C3=A4fer <j.neuschaefer@gmx.net> wr=
ote:
>
> Although the emulated cacheflush syscall does nothing, it still needs to
> return zero to indicate success.
>
> Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  linux-user/arm/cpu_loop.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/linux-user/arm/cpu_loop.c b/linux-user/arm/cpu_loop.c
> index e8417d040691a04a3edc0f5508f047571beac8fa..33f63951a958a5a48ced2d1e1=
87264d691e5c940 100644
> --- a/linux-user/arm/cpu_loop.c
> +++ b/linux-user/arm/cpu_loop.c
> @@ -363,6 +363,7 @@ void cpu_loop(CPUARMState *env)
>                      switch (n) {
>                      case ARM_NR_cacheflush:
>                          /* nop */
> +                        env->regs[0] =3D 0;
>                          break;
>                      case ARM_NR_set_tls:
>                          cpu_set_tls(env, env->regs[0]);

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
and queued to target-arm.next. Interesting that nobody's
noticed this in all these years...

(If we were really enthusiastic we could make it fail for
the "end < start || flags" condition the kernel tests, but
that seems unnecessary. The kernel also checks for access
permissions, which would be harder.)

thanks
-- PMM

