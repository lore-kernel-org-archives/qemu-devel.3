Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F160AF4BB68
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwNY-0008AI-Kd; Tue, 24 Feb 2026 12:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwNV-00089p-Kw
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:39:21 -0500
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwNS-0003y9-CY
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:39:20 -0500
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-64ca09f2056so646702d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:39:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771954755; cv=none;
 d=google.com; s=arc-20240605;
 b=ZjVOmcL7Bagj8e1RhWLwV/dpnLdHhorw7QMl3evPrOIiqZR7+jCm4Ll8AtwoM+VEuY
 mrd0YFl9pR0Nj468fZtcs+mwrLRQ6/Slf0HP1rPEqwWaKoaqx6YhZ6Kq6CcsmFH0qbqG
 57p8WB8MFU/UVpwEohY8ep859GrhFQ/zrd44xVREkPJuE/6pQTBtU4D6vFOjzpDO2ogP
 lZ5dDMvJG2xFIdmSoDvvy3di3WN0r6AsfQHbHnmr4gpDx9v6ei+c0SaYrLya41PoYipi
 FtF7c8zw4/1oOyOmNezw1e9KG7Quu99RNXGJm64wGCpI3eEqgiKEUd+yVOud8hBcVJzi
 ZvVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=tkIbci1DAFaxW/t/+Jin9X+O8itoBxS3vfyDbF3HHmE=;
 fh=R84pXDYvJznuJb5dunrikqaEeI9MgwuEGgEYHxBIZ1A=;
 b=CVlGvR9l0fGNxPJ4SnEh0yQ6ZgFyTRrV2G1HLOLVYVQy5dXWTb8xBug0Mn2Oz+0FZb
 nQ6Fogkx4mHQ0TfymZUnMs4bkoR61GhOXlxak/PY0wBh0db+Rks3RrFxNBPvRAER8FzA
 G9BkoFWWwmlon4S8MIs+le0KsQU9jzSWeH9DiKD0aWrogcZSgnsSXzwoT9NfvxpoOhtL
 vSk8oGhpY8D05aSURNkdNW9sP0fsGZrWw9kCmI/6e/MtA2m4b44OKodDVfm4LU5Sny/t
 tkYTzlRCBXuBrfwQrug92CPZ4+6W7JJfsWPJl/RkHDGUCd1L4KDW2L6mXY9xRr7dvVq4
 MaNA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771954755; x=1772559555; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tkIbci1DAFaxW/t/+Jin9X+O8itoBxS3vfyDbF3HHmE=;
 b=FM5TWpJJe5zmK3GgDH2fk4X6Qi/ebRsc7/ckQlGspQBryTSvsP2BEZX1MHBP6Ttl3F
 sGkem+6TLLcDTjvWSy7Zp4AgIX5bHFveeYJ8AJ8KJlm5L/GM1g20K/fCWO08xE5yba/B
 NrUiFJj/Xxq1AQXTMdUIcC01GWrpJ8EJn+R1qgPB8pyYRi9I0e8mGtReSNP23ZgDgIAO
 0tKovOoPnGZAEx3e4QHj9xRtHRn6UW2r+yCVvnUpefUxyRien7ht0ce/NNYXQPU9s5Uk
 YO6gnv6TsLM+GP52AwW1gDkKCITwUP+4AZ78s02lC6RVPg24p/HadzNiFTg42L5lvJCT
 4pOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771954755; x=1772559555;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tkIbci1DAFaxW/t/+Jin9X+O8itoBxS3vfyDbF3HHmE=;
 b=W1DtLm5jQb0p+pRuNwDaQAxzhBophDqK720OKqk/y+uuswn1EpiPgczK0JUEKoDZDA
 BY3ISNY3i0KI4UkCnR3nh12TKcDKH4SE2oI4rx4kmnMwAyOVT9ZbPguFRm1RUhXMTzBB
 YxSLlLf04F31lx0xIdXz6qh/76RCxJXYKsZpUF5aCf/H36jXoQ4oFJceBL5F2VnwjRlA
 OZClFn+D1hgO+ukNXcBMbo1Bye11XMl3bQ+1JOM8tevXxB8nbL7wGZlNzo3/A7/PRPbl
 P7WEMpJLP0jnocfwxRGF/c8QNMzkM3zGtvZalibxIv307anxsmjB3M/uxNRjz90PQcyv
 VhXQ==
X-Gm-Message-State: AOJu0YxEtSV3YooA3lar4Vzw98fDTsfBRolEwLSQWuAxIZIaKkudm5SE
 ajhh0fL9tcZGGdzmGJc1laHvt+kKLcep/W5gpjGkZDh0EgzhV7bFYCdoWE4UeZfKynnboyjRnml
 9XhBarOWU19wT+zCe/0LPbtLbXNKlvM4WPHrfdNJekg==
X-Gm-Gg: ATEYQzwwoxeTNis2VXlsOrgD2KjENQ+Go8l9Bv2WGAK+wZbTPCcdLtu1w3vaed1YbFK
 epemKZ9XLhhEgNdcWdH4y3Ggkp1MbnbTgvEsCVpwuwgSag9i4MXiVk2Gl7qFu9QteerThSVnJ3q
 qp3/27SnBEwJLDr8y6/ZNvYUbsQwzVBHO+GEdtvwBtVU08eEeQCzoGZG9XyQM3KId1isKx9k/VR
 sQAJUG8SQpNY6FXzgZqJP1wQ1lYkooHGgIjoEHAjprDFhgpjHBj5Bcm7qho0MRQIb8KnYlxK+Yp
 GQ4yLZsLqt0m4eXAIsQiQj9/NzGwIz9C5QMoDt7M5MZpNW1lX+1XWn0iZvVvcC7d/4Q=
X-Received: by 2002:a05:690e:e87:b0:64a:d18a:66bd with SMTP id
 956f58d0204a3-64c787d5328mr11475825d50.16.1771954755189; Tue, 24 Feb 2026
 09:39:15 -0800 (PST)
MIME-Version: 1.0
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-10-alex.bennee@linaro.org>
In-Reply-To: <20260219171810.602667-10-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:39:03 +0000
X-Gm-Features: AaiRm50pMo8gde-D1qm7vZm0Bhas8-SQLHZ6xUQkqf2U50DUphIzgmXP8vVT_eA
Message-ID: <CAFEAcA-BG9s3LoC_QZeKmpbok03h6N++F2tcOVSORvrRBKkfyA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 09/14] target/tricore: move cpu_reset from
 tricore_cpu_realizefn
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
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

On Thu, 19 Feb 2026 at 17:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Implement a proper cpu reset handler for tricore cpus.
>
> Message-ID: <20260108143423.1378674-11-alex.bennee@linaro.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/tricore/cpu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 04319e107ba..c3dda9f6a54 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -24,6 +24,7 @@
>  #include "qemu/error-report.h"
>  #include "tcg/debug-assert.h"
>  #include "accel/tcg/cpu-ops.h"
> +#include "system/reset.h"
>
>  static inline void set_feature(CPUTriCoreState *env, int feature)
>  {
> @@ -81,6 +82,12 @@ static void tricore_cpu_reset_hold(Object *obj, ResetT=
ype type)
>      cpu_state_reset(cpu_env(cs));
>  }
>
> +static void tricore_cpu_reset(void *opaque)
> +{
> +    CPUState *cs =3D opaque;
> +    cpu_reset(cs);
> +}
> +
>  static bool tricore_cpu_has_work(CPUState *cs)
>  {
>      return true;
> @@ -120,8 +127,8 @@ static void tricore_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>      if (tricore_has_feature(env, TRICORE_FEATURE_131)) {
>          set_feature(env, TRICORE_FEATURE_13);
>      }
> -    cpu_reset(cs);
>      qemu_init_vcpu(cs);
> +    qemu_register_reset(tricore_cpu_reset, cs);


We should arrange for CPUs to be reset in the board code, not in
the realize function of the CPU itself.

thanks
-- PMM

