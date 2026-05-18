Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C72CCD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 19:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP3ou-0006eL-2S; Mon, 18 May 2026 15:40:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3or-0006dD-S9
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:40:05 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wP3oq-0003Tv-2h
 for qemu-devel@nongnu.org; Mon, 18 May 2026 15:40:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso14193815e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 12:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779133202; x=1779738002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nZYoXjmmAV8cuGf7V32Wc+33KaO56HAAVaQ0Csg7u70=;
 b=LRJhb1D89tr75PzuPgun4jTnhYV4MmvRj1dQCtUlhhGCjC1vEjE2Ur/if2rwmprla9
 Xp2YaEJDqbyPkpkC5nf4yqoR4VzPjqfi00s8zTU/a1SsjdS4pC5qIM0SQxysf5HWcZuT
 wvNnDbTMAiqPl0M1Fx/UYchQP1R2ALNmSTbfX8Vfk6a8xLdoODm5zcv5C4o7+/yrSUxQ
 Cte5K/cTLnWKRr8J6JVCDAAzEVWEk6IlXfd3NYER5qpNjljMfLeRD1EcsacPfPCLw4qO
 TASuiY4w9j5B/ou9R7ub51NiJlWGM6ulYISZ3f1s67bVvogWwkFeWqpQGn0/yj5GK9Mu
 QBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779133202; x=1779738002;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZYoXjmmAV8cuGf7V32Wc+33KaO56HAAVaQ0Csg7u70=;
 b=VhLNxgByttJTevwCtk/GmDSJ383HSJWuupA94hIsqcwhrym7n3X27n3iAdyGi7Wt1j
 7e7Vu/8P8Ejnfi+D42C5hoxnSkccXf2nkilH7kzm77RgWBN5Ka3KSM6/LhmmjhLHxRWu
 m6+XcRYPMFWlqjGVEMcIzakNfTBhQHMSj71WH2SA/Wfk/TVSoDbjo4AobcYd40hwYTk0
 QIvUQXU8xQ02XBE/3EtSJfYGrTmTIhvCHPpLxs8bYOk5K0xDUpY1+TTiPAgRAKRjq2Fc
 ntqyL83PqvJOnEIxuyiRkarYTnvgqEk9p88ox4f8zeMbPdRz2Qp520D+mA+wwbJb6JuF
 UGRg==
X-Gm-Message-State: AOJu0Yz8ePX6TmeIpg+8njLFcRyq+WrCJPNYQT4fmlUExXa6NsogrLp2
 UMRnuNmiLxUgbFEWGTSEA785A2I3i6yORSRieALZer4wtE4AyJhuiJp7jZK/uGE/i/6B7yVg8Xm
 4cqtTa74=
X-Gm-Gg: Acq92OHcMyn5rZYxx54G7trsxxamVwzH+ej/HwqLhreCzF0sibOKL8HI00gIyUgN93o
 YTE/0kC9ppK1gOHcRM9UWDpdQDQ5i5RuaFIXmflwBOjJF54Qguyg/SGAYwdPZII/f7mdbYfMWGr
 gcbA/cfrDzK5pE0KnnYWi1DcflP0DMOdodXLkR4SCySKL8iuP4CCKvp4GlknhrEqvYnqseTZA4M
 jQSPU0oqR1eCDiR6yC8Q8QhjUjpREn5rq8GcgvM+ST/TevYh9BFakiViqJLk1kYY8PcN6U3czJy
 acy8fSfa9iXeYfuhl7TCOEqUVmc61wPeRy73edaMQXbwUrI9out5fAIpsZMrO53oZUkpImhdTrY
 V0WeR0nb9V5oEJ/9p6+qRHNtRZos5+lmbU/gQ7OtwuIGC4d6G5qkkSBBr+XkKuux/MV0RH5npDt
 k8+mbJzMk3LIr936CiNy7+0e8=
X-Received: by 2002:a05:600c:a406:b0:48a:6798:52e9 with SMTP id
 5b1f17b1804b1-48fe59b06acmr220496215e9.0.1779133202215; 
 Mon, 18 May 2026 12:40:02 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe537c788sm261560975e9.12.2026.05.18.12.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:40:01 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A7B765F7B1;
 Mon, 18 May 2026 20:40:00 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Lucas Amaral <lucaaamaral@gmail.com>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,
 dmitry.osipenko@collabora.com,  marcandre.lureau@redhat.com,
 visitorckw@gmail.com
Subject: Re: [PATCH v5 1/4] ui: introduce GRAPHIC_FLAGS_VK for Vulkan scanout
In-Reply-To: <20260317182049.33848-2-lucaaamaral@gmail.com> (Lucas Amaral's
 message of "Tue, 17 Mar 2026 15:20:46 -0300")
References: <20260317182049.33848-1-lucaaamaral@gmail.com>
 <20260317182049.33848-2-lucaaamaral@gmail.com>
User-Agent: mu4e 1.14.1; emacs 30.1
Date: Mon, 18 May 2026 20:40:00 +0100
Message-ID: <87h5o4cxrj.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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

Lucas Amaral <lucaaamaral@gmail.com> writes:

> Define GRAPHIC_FLAGS_VK (bit 2) in the console flags for future
> Vulkan scanout support.  The compatibility check currently returns
> an error indicating the feature is not yet implemented.
>
> This prepares the display framework for direct Vulkan scanout
> alongside the existing GL and DMABUF paths.
>
> Signed-off-by: Lucas Amaral <lucaaamaral@gmail.com>
> ---
>  include/ui/console.h | 2 ++
>  ui/console.c         | 7 +++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 3677a9d3..19ac06e0 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -361,6 +361,8 @@ enum {
>      GRAPHIC_FLAGS_GL       =3D 1 << 0,
>      /* require a console/display with DMABUF import */
>      GRAPHIC_FLAGS_DMABUF   =3D 1 << 1,
> +    /* TODO: require a console/display with Vulkan scanout */

You can drop the TODO: here

> +    GRAPHIC_FLAGS_VK       =3D 1 << 2,
>  };
>=20=20
>  typedef struct GraphicHwOps {
> diff --git a/ui/console.c b/ui/console.c
> index f445db11..424ee195 100644
> --- a/ui/console.c
> +++ b/ui/console.c
> @@ -594,6 +594,13 @@ static bool console_compatible_with(QemuConsole *con,
>          return false;
>      }
>=20=20
> +    if (flags & GRAPHIC_FLAGS_VK) {
> +        /* TODO: check for Vulkan scanout support in display backend
> */
> +        error_setg(errp,
> +                   "Vulkan scanout not yet implemented");
> +        return false;
> +    }
> +
>      return true;
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

