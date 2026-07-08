Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53D4C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:17:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPKg-0003As-K2; Wed, 08 Jul 2026 06:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whPKf-0003Ak-1n
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:16:45 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1whPKd-0005LR-3L
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:16:44 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-667971437d6so590702d50.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 03:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783505802; cv=none;
 d=google.com; s=arc-20260327;
 b=UF11CahtzkaBOgqq2S9dw034oIvSmCnBrHdFzsTFV89I6R9+67+swINR3HehgCqnK/
 Y19KR5MnWmE3ZuPuCsK8Br7shbrhYVSqVjzJlqXlY2I5+OkTWsMJD3016sEYRSw3XNzR
 Nq+vrd01V9V5mlUEot31XbUzQKRdkWR4ULSg9QDfDi0V3z/gnMBHA9ioDYrwtNZoOiuf
 3zWqqVXMNSIFY7AiAJIoNtEr9FDG4BbDVQpxE3PIrr72fQCOnNdIdPyhbW2TPuH4Cu8S
 8A0wMPcuf0xs7HOxF8x0TV4W3UNHGKXjhT1nXmRlXtR0/7Ok3Rx4+Sqs7owFyov3DSav
 T2FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=s5nwdvirrnAsNSNwDihRp/f50OIkPb0exypcDdx1POQ=;
 fh=XOP2k3dE3jbE2PUeMUBXC1zAce5ySRZRtW2gPxyIHoI=;
 b=Qsf4TCxXuvN+3F93qLqVP3y6HUX1WpB6+HWBsj0jle8DQlr6brI9/YaZaURIz4saXR
 rIVXQ2TvS5d2r+9CoVlQgYMLJqdmte/y8it7czeo7GaaIiCjx9nKmfDO40npbBORjipn
 AZcZE3cSC5PSFMrUkZ+zkwmCDMtSkC1X4qWbYoFIG94gQApQuWJ9alcw97Wk4T4s64B8
 JXAAeMzyi+6rZg1witg7/z/IL2Qu+b7+CB00KXXi/2lmc7EDSpS+0FLtiShp76i21UR2
 0C70o6j6gPbYcvXPOc2moZ2ZmiXCoCn+O4aSIft3DRoalL296JVegV6nYbGERRzQW/xS
 EgMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783505802; x=1784110602; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=s5nwdvirrnAsNSNwDihRp/f50OIkPb0exypcDdx1POQ=;
 b=b4FHRReGIlQezceD43VxnmdnKFYBaGgXG6a5Ac11gNjg4OzjGUT19Vc7j5E468ZrVZ
 JzgR3YahdnwzMxsgQ9C5fh5moPYwsKeKBzXCjBbmZE2cRCGlnTSwGpf2iFBgSPUGDXgZ
 +O86jLoU2YYL1l61M9pcjxUO+7ZnEmg3YWTQTSyDES/lZY+meKiQoWnc9DrkS/EYxjE/
 m3cWAeS+Ypt1AABd0T5PNiHfmaR2YbqSDfCbzINANLFUJzNmI948UrddCfDTYVHVaLLh
 YxIYFmE86mWFsIAQA24taK+h1TXH8nZipqGzMc2cIkZATKkNmOlnwZ3JxzktRnPm2mr7
 00Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783505802; x=1784110602;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=s5nwdvirrnAsNSNwDihRp/f50OIkPb0exypcDdx1POQ=;
 b=gWySpH02z+pK2PivyquqY1qUEdanSxJew9+eWOgK/pmP3eWf0K+/K83rgehGvv6SgO
 0GUe640sYkdsKdQvbeqc/pdVULgVZxve4mwMV1fyVcsnQG2Tpbyr/3+h3sAxEpobE9PZ
 pa8Ut4uSN6aI84m1koe8G5tKwJDaQMuzvnZAObkBt4uohpES14uSK7Yz+KF3eeWJunP8
 T0gLyP7YnbskzjZ4OOJP2Ek2ICIAfm8fuWQ5Aij1p+oBZro3fq5HC6MB12afPzWK0oZP
 tPtGqr9WaFcIDE2Z4T0cE5KGMW8WXeFKJQ9IjXcUiQhi2ZJH5rWm6F6W83XDwcQrCS6q
 GtYA==
X-Forwarded-Encrypted: i=1;
 AHgh+Row5BZiHEu19C1F8NpSsveG8c1EukTQNHfXGrcBfu6c78V/528xMF4i0JvetRFx0dVSHpiobQt+322/@nongnu.org
X-Gm-Message-State: AOJu0YyhRR4RokVJvC6xrwvJWLwIX48cFbkaf2QKvAQ4UmfzdXvDrNZP
 d98pAYotOOy+cnqNOlIF0HlRjMdg2PP7AB23QWu/ELaAI7obwz1Rom7y0JUjldwNMNK2IYC/+MG
 EpWa9CgEUxnMcX4AiJiqkmSKnFY2lz/g7BqBTdAr3xQ==
X-Gm-Gg: AfdE7cncW13WK9PSwRNnxrqPynoJw4xuX9DqEzHuQkQpsUYNfwYQTi6LgmTg0//pZzO
 3dRbHze3NlYdYct1gSoopBp+l5EociE/t86GEC5x5Fql6OtfULhAKWC9hlztPdpWD4uH/nNH0jp
 p4oRUeaykkXJnlcpF7CAC3x18p/55Y/iY5qM6Zjg8cG/54mX4Nx7evOtWaXC9P9iJzlKOEAZTsR
 VdcZUoyuIg9yDV0OmA8YlUF65efZDgrVuV5M93py4txTtFWFfXatRtNlbVYDK6GLP0aKyn3ZTRE
 Zf+IQkkuYCcycq5ViJiPjjQ9/2DwRyNp62GGXTRxxev1YQwKXZ/ZQMUV
X-Received: by 2002:a05:690e:4186:b0:661:1307:3d4f with SMTP id
 956f58d0204a3-6679f0dfb9cmr1289552d50.46.1783505801693; Wed, 08 Jul 2026
 03:16:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260703090814.2993188-1-mark.caveayland@nutanix.com>
 <20260703090814.2993188-9-mark.caveayland@nutanix.com>
In-Reply-To: <20260703090814.2993188-9-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2026 11:16:30 +0100
X-Gm-Features: AVVi8Cf_7jwsxvexNo7Ow4MGzpyYfWVNA64xLalO8emDB96bnkdaXYq1pAUk7Jg
Message-ID: <CAFEAcA-Agr3jDYfM466UtqNywfxxX6Vv6H30B8QQDMykQ0ktOg@mail.gmail.com>
Subject: Re: [PATCH 8/9] hw/i386/pc_sysfw.c: convert pflash0 and pflash1
 object props to class props
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 mtosatti@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Fri, 3 Jul 2026 at 10:09, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  include/hw/i386/pc.h | 2 ++
>  hw/i386/pc.c         | 8 ++++++++
>  hw/i386/pc_sysfw.c   | 7 +------
>  3 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 309de2eda1..16cb0ec01f 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -40,6 +40,8 @@ typedef struct PCMachineState {
>
>      Object *alias_pcspk;
>      Object *alias_rtc_time;
> +    Object *alias_pflash0;
> +    Object *alias_pflash1;
>
>      /* Configuration options: */
>      uint64_t max_ram_below_4g;
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 13c9c1bfc8..11eef176f4 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1762,6 +1762,14 @@ static void pc_machine_class_init(ObjectClass *oc, const void *data)
>                                     offsetof(X86MachineState, acpi_dev),
>                                     object_property_allow_set_link,
>                                     OBJ_PROP_LINK_STRONG);
> +    object_class_property_add_alias(oc, "pflash0",
> +                                    offsetof(PCMachineState, alias_pflash0),
> +                                    TYPE_PFLASH_CFI01,
> +                                    "drive");
> +    object_class_property_add_alias(oc, "pflash1",
> +                                    offsetof(PCMachineState, alias_pflash1),
> +                                    TYPE_PFLASH_CFI01,
> +                                    "drive");

Does making these class properties fix
https://gitlab.com/qemu-project/qemu/-/work_items/3254
(which is a report that "qemu-system-x86_64 -machine pc-q35,help"
doesn't list these properties) ?

thanks
-- PMM

