Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC24C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 14:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNCuV-0004EK-Af; Fri, 28 Jun 2024 10:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCuT-0004DT-1H
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:49:09 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sNCuR-0000Hu-G3
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 10:49:08 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57d2fc03740so911826a12.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719586146; x=1720190946; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=97DAXS2tfG8ccBKooFzNy0yi9pdqTX24aMCecatGfio=;
 b=vVXnyGjgiEY+s4wKQfnWaK6bAMYNE4kFyx5zLs2zKjhQ/ejwcbd+nB/YsZEfJj6mwk
 wD1cJssvSW7Ks2KoMqwEPuZ5FSZqF2QIi+kcAzaKjdI1cVa2kr8Gx6NAZiuGWhKfZ5Zq
 /W+YU8FrocRLmMiL+aOLu+8kkpFHhY4kWYlWBbbH7STgTP/DeEVWYSO9UMpxGDDkLVkY
 X/S7B5x+3/mRVKsnl+7gZqA3JIhrHZU2tUwkG/OG/lq+Vn9gNL/ASA9nTVYKz4g3Trbc
 SU2WcQLVntGwLfA3fUqEY96GHM3TtQ3RkGLbFiXSANiq6AN0VXKPCt1MoJllD/BOgXua
 pZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719586146; x=1720190946;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97DAXS2tfG8ccBKooFzNy0yi9pdqTX24aMCecatGfio=;
 b=vynb5l9L6PnukZQbtlEVpAS8I5SZDQiN7hhXnhUljHobBTgd0aSoETYBLTcTRkrExh
 dTJIBhCPGz33FHMxouPPFD9n+gX3ID5+a9GqWXq72ZguiRaTkHUqL2T8sGbvjc1RTl41
 Dv9m3qiB4WpOpcDALT0+L9jnjiI9HwpgLypnThoOaAuSp7vxKkxoKEjfyQgB9zf8OXqg
 3c/JIVXFenJfLQdoy5j2zUMnnlR9lt3n6VIIoHlgDpwEwPuJlTWhoWuOUvFWKBOvR/KS
 JSeN/hF/V2NOhhtVgzq5gYVkCafq4Q5CYw480lqTe8CtZQo88hvcZudm08nG5DndhV/Z
 FZjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIaF+CsptjiPRRifVYKjJhZ9HegeeMzyPN+bwMhe4OV8E4oifFDpFVy+XTR+0dDcYz4BHygvHDORPL5nyfV9jbJbTHW+0=
X-Gm-Message-State: AOJu0YzyjnZdZ+6J4aKGlPlGlDWWBs0fahUgHxmOsSkbp0QCbP4KYrA9
 R7NDqRoGm1PQubLUrcGn9W5ks3CsMmCvERviP2G2I2UjdvmvR8wk9ypoaQi8kowWddQGITytCH+
 d1QNELtpNbwYhKBthta2bibwYlY53oBnGFUAzNA==
X-Google-Smtp-Source: AGHT+IFqqsg73jHltvmZI/pdX1a85V/fZnxtGPAMNcP2UPxtF3zkF+e5kXtMNzzcsW4s73+De36sy1qtvt7JTQ1kK0w=
X-Received: by 2002:a05:6402:34ce:b0:586:1517:872c with SMTP id
 4fb4d7f45d1cf-58615178745mr2011348a12.15.1719586145812; Fri, 28 Jun 2024
 07:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
In-Reply-To: <20240621125906.1300995-1-sai.pavan.boddu@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jun 2024 15:48:55 +0100
Message-ID: <CAFEAcA9tMf5oQGtX51NvX04abyfNJCpaEbvSjYtfg-FdprjieQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Add boot-mode property for zynq
To: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, francisco.iglesias@amd.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 21 Jun 2024 at 13:59, Sai Pavan Boddu <sai.pavan.boddu@amd.com> wrote:
>
> Add a way to update the boot-mode via machine properties.
>
> Changes for V2:
>     Make boot-mode property work with string,
>     Fixed few code style issues,
>     Added zynq board doc.
> Changes for V3:
>     Mentioned about zynq doc in MAINTAINERS file,
>     Stick to small case for mentioning boot modes in doc,
>     fixed commit message to mention right property name.
> Changes for V4:
>     Use strncasecmp,
>     Fix boot mode names to use small case in few other places,
>     Fix code indentation.
>
> Sai Pavan Boddu (3):
>   hw/misc/zynq_slcr: Add boot-mode property
>   hw/arm/xilinx_zynq: Add boot-mode property
>   docs/system/arm: Add a doc for zynq board



Applied to target-arm.next, thanks.

-- PMM

