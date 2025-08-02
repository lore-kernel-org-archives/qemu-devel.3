Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AEB3C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:34:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIvM-0000iH-29; Sat, 02 Aug 2025 16:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIsI-0004zJ-6Y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:30:38 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIsG-0004SZ-HL
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:30:37 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71a27d982f1so27688537b3.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166635; x=1754771435; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Mw99Mh70/oJVRRUkI94aZkTJT+H2TLOuXqXMhujHNg=;
 b=ckhfRzKij9vtuWge8GGuwQB0/pZF7NEtSigDpXLPZHbpY3j6H4sfy+8EMHrh4ppQxM
 TYkahLubYoxqWsO2fD6v+sAIwUYE/aQMqIpE2l5BTKZ3qZ9eTBpEpxx9uSI0gqqLFpdu
 4AOCUD1ruXIlQEK+/fVa4YRQfqc0j0nw2LzoO0WSTyj5GfRX69K6Gh/87qer8AIYLwCT
 DDBG0WeZ2GyVUadR/slcODhYQI/y53fLfJ6ltMp7yGYKfx5bHPS+lsNilukZ1xU8vbvX
 cSA6V54ntI1G6eq0WXqPvUuE5IP4ucG/RKzyWd2CHHhmo4UC40kz30ez6gHGUeHVM8+6
 p0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166635; x=1754771435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Mw99Mh70/oJVRRUkI94aZkTJT+H2TLOuXqXMhujHNg=;
 b=alGlGhGgkTqdPAzzNZaPAB0BeMNGKdVnA8yPh7gyWVle1HIXPNbTx/082wZ/PLQtgs
 zyBagFCHzosyZBCE067Gs9SIy/IhTpkoxLpoopIf5z0WNI0HzjAAJlakAl1Kk/vLhQ83
 7k3cO2QydWuNZxi0tuq8EZbHeXsJcoLfJmqvM0lYJkLVRhXCfbC22hmwt+pMifeHH9Np
 6Xr6+Pi1lJaLvVPELiGQOnNQlHjkKRKRyPUp0P+vs4X4X50hRV8/koUli6etFV/HV7h5
 SeC2QgCXD9R8GHVxs3gbScUZD7/TKQ8G5dQzx7pt0J7WX+r4OTFRnbzvvC9BvabSpZym
 gUww==
X-Gm-Message-State: AOJu0YyeAeVJ/Te/NRjut98MeFqO5QAjpunpxXQNa0Vksu1uGJSVE894
 Cjhv6FFMCp2G7LHSri8tXw/Ns2Lzlbf4yYMxl744kCJzI2lp1BHfHPMCw8GMokd/5hOaT5F3StK
 CBYTSb98lmEAeaF4NSK4+gO3xB1d2VeeESYYS3NAVUA==
X-Gm-Gg: ASbGncs110OCRj1S6WsBSpdKV9ozo6x0X969pcwDueEzZGYUgS1KZQ4HtpmboKesIUC
 28lMJ+Xub67eoySe8B8cp5qBuiPC/tAc7R36oJCHdmDsOpIK4kN8G1M7VlgkRA4eBQde8uM018a
 917TbZBj8+2tnRxujzmhaFpO96KdNzYhrWktr8jVVI2ReERJEgRcqA8rZSSZCmC4djp9aY7Z93M
 ktl7dR4mVwa9vJBLmY=
X-Google-Smtp-Source: AGHT+IF3ooy4s/0XTEpeS5GTX5VEYLiCDwIm33ZUMxQVaxYg0HWjynBOSbR9gNmjFN0c/4z7nNSaZwj8BKK6vRU7IKc=
X-Received: by 2002:a05:690c:1a:b0:71a:22e1:b32c with SMTP id
 00721157ae682-71b7f5bc0d9mr51437657b3.4.1754166635109; Sat, 02 Aug 2025
 13:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-74-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-74-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:30:23 +0100
X-Gm-Features: Ac12FXw73Smju2GQ3s_q3K05FiM6QpIvaIoAIwReeCUwiXpqDperEIpQATKcBbo
Message-ID: <CAFEAcA9BJkceMySWTWF6+2+rtb8g=zhjozdxww0iDbKKXHtTbA@mail.gmail.com>
Subject: Re: [PATCH 73/89] linux-user: Move elf parameters to
 alpha/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Wed, 30 Jul 2025 at 01:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/alpha/target_elf.h | 3 +++
>  linux-user/elfload.c          | 7 -------
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/linux-user/alpha/target_elf.h b/linux-user/alpha/target_elf.h
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

