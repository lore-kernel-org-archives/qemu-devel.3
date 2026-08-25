Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74136C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 06:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wykZm-0005o5-5t; Tue, 25 Aug 2026 02:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wykZj-0005nI-BL
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:23:59 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <163wangjack@gmail.com>)
 id 1wykZh-0007Oe-3L
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 02:23:58 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-395cf2535acso573239a91.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 23:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787639035; x=1788243835; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hjroD+dikGlpnVEI/GXyzccjDkDqMKQQY3NUKga7WrY=;
 b=dAgx3lwJhMGaUIfgCQdhWA7KkzFUgAU6wHTJF+nK7SbWdJabXi2k69jdNHQhSqkOFg
 Ov3SkppvjcQaQzaO4oihm+1kEH3n65l0/IGIzS23Y6NeFMezrVvTIvwWmMgqCF+y/Vr6
 6rEqE5UR6D9lr2EbS27ck5xPCGaAjTI3pU4a9g/lqpfegr9uTiclIZnpETXKXzPi4zra
 xdhJleSHrnqF4yyDoFjGDILw2TYrBwWtfKAJtetw4ZSSVw1POC3c6VmSE6+LbfFJztbk
 0HPyis6zfcTWr+7G+lYOgaRA0KR1VAReYpLNPNHNFgPQsGY0NZDJfU5sa4QmFlBh5p36
 ZGug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787639035; x=1788243835;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hjroD+dikGlpnVEI/GXyzccjDkDqMKQQY3NUKga7WrY=;
 b=HN6yEe5AUad9r0xdg+MGv4xHGc16W3jdvFFRIKx/X1FFu2x+6jwLXRvNJ8pbVIOeKV
 BsWvb5WOcFtzapf+Egyo1gIljjMbLZdluNuf/Sc4Zb62Pjyz1aGUh99F7X3CFdX3iMvj
 TqGZ5yjRMhNquh5pgn3isuOdglwhsTQcp9a1k5Qp1SmnwxXR/SVqhrNXuhQk4XBjRCSW
 TPZbyTpXPbaZ5rfyHwDmAvaWxzYYTvH/Y/o2usdJmkmLPGsnCjwVZkO83HMjtu7+DNmE
 BiCI3nDiZJrMzV8Z+yS5rbSuHMHBR5T7Qz0Y7WpuN9haYPloIG+FHL7rETmFZBXmOS3f
 PDHQ==
X-Gm-Message-State: AFuF++lJ0tATHfjTLLTo4HWkCfYRl3hHgBB/7QBw/6jTryro79Vd0is1
 8+i9NDlmKb2+gJmidsEX8h220JRBz65nFg8jrvpdj6rI5UbDuvK5sn8i
X-Gm-Gg: AR+sD11NIjSXn/w4RWwASUfFfwj4GybujkIiw2hwrMsRlW1HA3M0nRbYejiPvzXUGiJ
 tVXXh8V/r6NMgC4MSR0Q9tFVfGx8PAPFCsfYZxv7OfHlQPsDQjIs9QEwKAvri1Ah46RbmMD5EtL
 udaUVhw25OFBXj9XaEuUQokZGLobjXCLq6+mAyYNyldJjfn3dCPm0bpwj+ofzgWVRcbHYN4eck/
 F/C26JNze2GkwZp7XS3T+qRzb1xFrWUW4aulB2aGfuJ/yuViBB5OVdaoDEsc7zCu4pTdJ+tpGU2
 bUNQ1mB6el3+HtSAbll7NxweN9W51rJob280Z/uNt7U2RcoAiOSkFpCKrAc6+6gzfc7Ybu1jzF/
 UV5KQ0vwjYsAGxfd3WzF/+MG3F66lDKMWY8MLfIjkg31L2N1o8ChaLffr8nKddQASreKXbhPRQ1
 XwWlkc3CsroVHOLypeb1igvV/SDazifeyqDRRgyhkOysML5WOAPi5zXuLgfBw60Z4QBObM
X-Received: by 2002:a17:90a:d88e:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-39645aaa842mr4708297a91.5.1787639035371; 
 Mon, 24 Aug 2026 23:23:55 -0700 (PDT)
Received: from smtpclient.apple ([117.55.237.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d989cesm2466402a91.16.2026.08.24.23.23.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Aug 2026 23:23:54 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3 2/5] hw/arm: Rename ax3000-boards as axiado-boards
From: Jack Wang <163wangjack@gmail.com>
In-Reply-To: <20260825021155.2475879-3-kchiu@axiado.com>
Date: Tue, 25 Aug 2026 14:23:38 +0800
Cc: qemu-devel@nongnu.org,
 peter.maydell@linaro.org,
 qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D58CC33-E235-47A7-A9E9-5345CB67ED61@gmail.com>
References: <20260825021155.2475879-3-kchiu@axiado.com>
To: kchiu@axiado.com
X-Mailer: Apple Mail (2.3864.600.51.1.1)
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=163wangjack@gmail.com; helo=mail-pj1-x1032.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_STARTS_WITH_NUMS=0.738, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


> On Mon, 24 Aug 2026 19:11:52 -0700, Kuan-Jui Chiu <kchiu@axiado.com> =
wrote:
> Rename header file ax3000-boards.h as axiado-boards.h for sharing =
across
> different Axiado SoC series
>=20
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
> hw/arm/ax3000-boards.c                              | 2 +-
> hw/arm/ax3000-evk.c                                 | 2 +-
> include/hw/arm/{ax3000-boards.h =3D> axiado-boards.h} | 0
> 3 files changed, 2 insertions(+), 2 deletions(-)
> rename include/hw/arm/{ax3000-boards.h =3D> axiado-boards.h} (100%)
>=20
> diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
> index 4b8deec15c..1b645b7f43 100644
> --- a/hw/arm/ax3000-boards.c
> +++ b/hw/arm/ax3000-boards.c
> @@ -7,7 +7,7 @@
>  */
>=20
> #include "qemu/osdep.h"
> -#include "hw/arm/ax3000-boards.h"
> +#include "hw/arm/axiado-boards.h"
> #include "hw/arm/boot.h"
> #include "hw/arm/machines-qom.h"
> #include "qemu/error-report.h"
> diff --git a/hw/arm/ax3000-evk.c b/hw/arm/ax3000-evk.c
> index a170848871..f491de7521 100644
> --- a/hw/arm/ax3000-evk.c
> +++ b/hw/arm/ax3000-evk.c
> @@ -7,7 +7,7 @@
>  */
>=20
> #include "qemu/osdep.h"
> -#include "hw/arm/ax3000-boards.h"
> +#include "hw/arm/axiado-boards.h"
>=20
> static void axiado_scm3003_class_init(ObjectClass *oc, const void =
*data)
> {
> diff --git a/include/hw/arm/ax3000-boards.h =
b/include/hw/arm/axiado-boards.h
> similarity index 100%
> rename from include/hw/arm/ax3000-boards.h
> rename to include/hw/arm/axiado-boards.h
> --=20
> 2.34.1
>=20
>=20
>=20
>=20
LGTM, and previous problem I pointed in v2 is fixed
Reviewed-by: Jack Wang <163wangjack@gmail.com>

