Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B6BC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 15:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfL5B-0000z9-MA; Tue, 04 Feb 2025 10:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfL58-0000y5-LL
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:43:22 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tfL57-0007Wf-6X
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 10:43:22 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e580d6211c8so5810778276.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 07:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738683800; x=1739288600; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qdHfe0Uk43sFsa7hqxlIZdLKy67gdQ4KBBaUPlCyPOY=;
 b=F8Huk1FBxsgqim2c2izkgTSvvC26QxBCbptx1EJID5RLrSV8EPU5sL+4ngKFyuWfJv
 orznkB87pDutHDAk/6PTgjUAm6EX9T5EPzyV/yHiY6PfmIF5UTcsRpqIcr7BsXU/dpHD
 JI6ULBlSHaguOYFwE4yFjmw9etdk1b1F38ckr+IEVIzCK4kgXgvTkZh/LXFc+aUmypIk
 pQuG2wg1SIe+TAbfHx7fSCt4SwM6kIbf+OJtxK23sg728PsDt+PObfxZIrA9UsCGkq2J
 0Wg/OEF2f5idCH6s5HjSVPYXPtzusBWWrGrp2mv7q5X/lAgv6kACY22Xh8GGKyW8XuQE
 elDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738683800; x=1739288600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qdHfe0Uk43sFsa7hqxlIZdLKy67gdQ4KBBaUPlCyPOY=;
 b=Xtqd+BUGF32ZkXrC6n23A+9Lyac7XY4tKk1vbDrBobma1/HD7iZWFDDf6M4dC8+Wtb
 XP44CRAvfhFBYnu9KU5qTffLhHxsRXDVnenyT+Dxjto9fFY+cRPDJkVsBuu0v0dNjm1Y
 hk2lt1Q0FzVA8Uol523YO7/eTw8zRM+MknehAz9q3n19SUimXVb7q7yYhGKMzdFMryCr
 C78EAGoOkX5XVm5PVTGGOuP12JzH4CSfsH7aLUbi0cVvET6DP+Ky4RvnASzTuNVYlOTb
 zrNV3ixKw7R3V8pWus6b3DE5/kLcorpH6tUMrxDAqucEM+luzn90FhJT78hopbBXAMVF
 t+6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXqDmLtBkfovtG3QYo9+rzrfGZ6x4IUAdQiYakvqsIGTIeEOeWpXUWzSA1qYeRnNd/XSZ870YJVWwd@nongnu.org
X-Gm-Message-State: AOJu0YxmRacdAF4CTyrN4ci4+Ul1XP9oWCOVdkQhvXYf86hsEZzz+zai
 9j66ugtXD59mItZlnfAOdAEhzbA9uiwMk9YigHhT04oef41De5gPqI386J/kKlY89ltCioVfzLi
 H548W8b3QSvBgXKb28d6avAopukXmGQ/7iEA+dQ==
X-Gm-Gg: ASbGnctc1kLgewRyV6McJrNjVR+Wa9yWVheKrJqEAWyw6OC0QPuHHlQj17Vier8XdLZ
 9xgyA2yg5NprfzY0tLbW62Dq5YejfECPGELdrzQBxNk3rbQGV5wu+LLC9X+82UiL8p/Q+LhxwGw
 ==
X-Google-Smtp-Source: AGHT+IGvwzeP2weLuWg3iK6BmZCY5P5Ro+Wywd01a++/U4Qk7PGDyw74qZupq74w+1pjH4E98HVpCiXJbxksfr6apfk=
X-Received: by 2002:a05:6902:220d:b0:e44:e084:52c0 with SMTP id
 3f1490d57ef6-e58a4b1aea9mr20537180276.23.1738683800117; Tue, 04 Feb 2025
 07:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20241226082800.2887689-1-wuhaotsh@google.com>
 <20241226082800.2887689-6-wuhaotsh@google.com>
In-Reply-To: <20241226082800.2887689-6-wuhaotsh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2025 15:43:08 +0000
X-Gm-Features: AWEUYZnbP7Ny17e2vKnQzkXN03gJ6193JxkCFYhQ0AnHTyZG-C-oZTgKK4l7lJI
Message-ID: <CAFEAcA_bwhiPo6Ye17GKoVE7RpjpHBm29Kw9EvRUVY6DgF71iQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] hw/misc: Rename npcm7xx_gcr to npcm_gcr
To: Hao Wu <wuhaotsh@google.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, titusr@google.com, mimik-dev@google.com, 
 hskinnemoen@google.com, venture@google.com, pbonzini@redhat.com, 
 jasowang@redhat.com, alistair@alistair23.me
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

q

On Thu, 26 Dec 2024 at 08:28, Hao Wu <wuhaotsh@google.com> wrote:
>
> NPCM7XX and NPCM8XX have a different set of GCRs and the GCR module
> needs to fit both. This commit changes the name of the GCR module.
> Future commits will add the support for NPCM8XX GCRs.
>
> Signed-off-by: Hao Wu <wuhaotsh@google.com>
> ---
>  hw/misc/meson.build                           | 2 +-
>  hw/misc/{npcm7xx_gcr.c => npcm_gcr.c}         | 2 +-
>  include/hw/arm/npcm7xx.h                      | 2 +-
>  include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} | 6 +++---
>  4 files changed, 6 insertions(+), 6 deletions(-)
>  rename hw/misc/{npcm7xx_gcr.c => npcm_gcr.c} (99%)
>  rename include/hw/misc/{npcm7xx_gcr.h => npcm_gcr.h} (96%)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

