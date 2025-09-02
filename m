Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E26CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNRb-0001Co-GG; Tue, 02 Sep 2025 05:36:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNRP-0001An-P9
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:36:41 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNRO-0000Cv-3t
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:36:39 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-71d71bcab6fso41406017b3.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756805772; x=1757410572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2LJcBK2Nxk93I3hh/W0KFq8M8Jt+Hly5IvK/eLqHJm4=;
 b=vBDcZ5+wklAiPyMdeS+8yl0iZ72y22YNvClG+xklBfwz8dP+LUuo1eMqloQH9FPjJx
 nijTJP0PUQmPGM1A8duLNZvKi/v00HR5mxiXbUCvSlMDyruwGLIyEBW61JLy2j2b9EJ0
 q60nk2xmMnLWp+/4Nj78LOGreBEwrWe0qOwVA2VaLg9ohwjTdp2SuTpbjqEug/C4zuT+
 qu2J/gHen/4dn2endRjYPdXbAutsK6npEQLwz+07KMw33fOzsNJWwGbadt1E8ArmSrIn
 6VNt797NWQwk+d30XcwlI4qZh/jmgKO4VFfGYB38iC69Z2GJz+S0lLgtwMtfXsimC44b
 2ZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756805772; x=1757410572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2LJcBK2Nxk93I3hh/W0KFq8M8Jt+Hly5IvK/eLqHJm4=;
 b=AF961aGO1fYTflDIbuswmTaUzzeR7VXP7+WmquX2AfBiFjE/Fk2tx3ydTZWSJNDfv/
 HHRhrdR/lVbHy6QlzQv903YQLEh+msVWss6my7HXnfmRFIQODMy6JrGZEomyOeLSWcaD
 SlM1B4NJ9IcooovkX673mjEURBUtXZdGSqQ2zMkrfF3KwsRPRfj2ht+FUWD7JwyX4PUt
 DI6qdSKe9ALLiikj+ITpiKFTVU94JEHua/Su9mRjtA0Lwexn2VEGSwaMsw7Zx67d5gfF
 g5DmQoxng913J4K+BiGO9v9JhpFptJi4k4i8Pva0sAgj5XPyEJBCD3iaFh3AuTkpBP3g
 bgaQ==
X-Gm-Message-State: AOJu0YwpWc+8EdPTy6eQSxe3M0ZD6BpupeQx2eQxuGU+HA+ovO6AYrIi
 f8CSCsFt27O7I+0+L93TGsUXKql897tDNcD9TkaMqM9/xxQx4MlReLnAeWMyW6FoLqBKkWgYQRT
 tfSTsnKtRTOkmWau0KqJ7qmGGOQJcOOLtphTlDLzDwg==
X-Gm-Gg: ASbGncuUfjk+P/HoGzr9G8ws/uY7lZ2Yq0ZrTmG42XI/Fva+k58Hf1rSe3gNYeQLrqb
 2DGmNxnIOkSncZ6lHc30o1mPM2M2Dvy1dJAEwdkkDhGd70UDsgUH7GTY2ayU3TQatmhLjfxKKWJ
 JuWUTsU6xTXm0n4xp/6pEclZBpHd4J0JnM2PhvALlvrQsYeyjP7moZIdv4NW3WbjQU6CgYYlh9o
 MbYY/ys
X-Google-Smtp-Source: AGHT+IGX9IrqxRibbIa/pv8Qv+majty5KnKDFeroAGD3QDYayhcImiuXbNflNXsVclRFRtYp7a23gwGBArW4v0iQaCY=
X-Received: by 2002:a05:690c:6906:b0:723:94a3:f456 with SMTP id
 00721157ae682-72394a407b7mr55392397b3.23.1756805771851; Tue, 02 Sep 2025
 02:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
 <20250901125304.1047624-3-alex.bennee@linaro.org>
In-Reply-To: <20250901125304.1047624-3-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 10:36:00 +0100
X-Gm-Features: Ac12FXwOwK6vzlisH6KTuV1FKKSy7vj0yeDkGBBgU_7hzOknpjQSgzM9iYJbmF4
Message-ID: <CAFEAcA8WNFs5HGScaB1bs-u8bHT1MbS8BvWXefx-eSd7dCsz=Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/arm: use g_autofree for fdt in arm_load_dtb
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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

On Mon, 1 Sept 2025 at 13:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> With the fdt being protected by g_autofree we can skip the goto fail
> and bail out straight away. The only thing we must take care of is
> stealing the pointer in the one case when we do need it to survive.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  hw/arm/boot.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 56fd13b9f7c..749f2d08341 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -519,7 +519,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
>                   hwaddr addr_limit, AddressSpace *as, MachineState *ms,
>                   ARMCPU *cpu)
>  {
> -    void *fdt =3D NULL;
> +    g_autofree void *fdt =3D NULL;
>      int size, rc, n =3D 0;
>      uint32_t acells, scells;
>      unsigned int i;


> @@ -673,14 +672,10 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot=
_info *binfo,
>
>      if (fdt !=3D ms->fdt) {
>          g_free(ms->fdt);
> -        ms->fdt =3D fdt;
> +        ms->fdt =3D g_steal_pointer(&fdt);
>      }
>
>      return size;
> -> -fail:
> -    g_free(fdt);
> -    return -1;
>  }

Previously, if we get to the end of the function and fdt =3D=3D ms->fdt
then we continue to use that DTB, and we don't free it.
After this change, if fdt =3D=3D ms->fdt then we will skip the
g_steal_pointer() and the g_autofree will free the memory,
but leave ms->fdt still pointing to it.

Since arm_load_dtb() is only called once it's a bit unclear
to me whether this can happen -- I think you would need to have
a board-specific arm_boot_info::get_dtb function which returned
the MachineState::fdt pointer. But as this is supposed to
just be a refactoring patch and the previous code clearly was
written to account for the possibility of fdt =3D=3D ms->fdt,
I think we should continue to handle that case.

thanks
-- PMM

