Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAC6C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 15:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrYt-0001Ls-Ak; Fri, 01 Aug 2025 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrAG-0003Zk-5g
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:55:20 -0400
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrAE-0007qn-IT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:55:19 -0400
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-71b49bbb95cso9785277b3.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060117; x=1754664917; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w+a2SEDdScWtsn38VhFDBEXUeed3xlk945gEWUrt3zI=;
 b=yU7f+p9pmIiaYUy4r6lg4n8w3SaIgriP6X825X7N2WyxF/V0Jgm/juOrWtNe8uJXFr
 QSiieqfQgsGMA8oGtOr+Lyhfc91nTUb3BzYTalAlTOVWYEhaBdv/pS4r/pHknlm1lMiB
 jFnuPtOyaf2ko51JDdWdaHaIq7kGGdCUmzDoe83CSq5q4+H2GrQ3Vjd6XRJQf0FRA8lN
 xgXCaItLqGgwTrcr5Er6tsMad253ofoYpdfQ6TU2kZVgTJpUgQCK2dNgjPa3FvpyFLjs
 CxCc+YCkcig7iFw9i89unnvwj2EXK+YnvFQFuD7KrcD5CZRBFLz+fgI9tcR/X68WZjKE
 wTrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060117; x=1754664917;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w+a2SEDdScWtsn38VhFDBEXUeed3xlk945gEWUrt3zI=;
 b=XAFYmmi8z9Qt/BfqvB2VEGARaRafU9ieIWk3kGxUvtoLHNXTS8rm+5MFSL1u5zvGn5
 2MVBSMC+pdxA/nWFpFNV2umXee2EccT8QN3va8MEg9KStqqLo3eHkI1udEPXVpOdp4Kl
 VpoodE4pizkbXBRsotUvO0mDXacVyxdVWUuF9lX6fA4oVSjkth4YR+b2RzggKwgdRg2h
 nIUjFZQsSy4irHFFXO/zTY6aq4zAiQ80N0NCDhR3pr7bYfcSJ84FMh4EU3u24ItNOiSU
 R+/btldtkVWlnEGVKl/0tg8AL3sHqcNiVO1q4l9bC5kJtD+VgCg9Uq5Laui6rkxpJB9q
 GxqQ==
X-Gm-Message-State: AOJu0YxTUhF+bKkKETn2YX4igV1g6C9Ze7Ie1Y9c6sUDv8jFk1ZLuk19
 J5/ANdSAW0pMiU1a8das5L5x+4hOAWF9N1gw19BGZlaX5EaKAgoewNv+uELLzzwaBftczDWUo51
 3mBO90rMkYYtckEt2Sf+fQ2IDUoXiPX+RH1S8vS9kJg==
X-Gm-Gg: ASbGncsrWnUkp0LlBZdRBJL/qfz5z7KBiFSmLaqKhVjcMS9YcQPScMxYW4+U9pQYZ6R
 iDDfxv1gWsbJAYjqKu+IZtZ7y/kj9BDN7/FqsqqJzshkOoMm62tMbGPXvTQzdjlrcdqo7y6zMWi
 JaT5P93gUiHns2pR8Ro9DmThNFK6ywspH/eeOc0uXKZr3SbVea/v8cYDJl70NuE2HG/ld6+uJ3y
 qTBYYQQlC0jHqjrYcE=
X-Google-Smtp-Source: AGHT+IGvW9kPRs0mCbTgz/280vjwD0WQPOLG/r069nR0itDpJrWIXVPcf+ofyupMAomBMQ2IRJ5+bDUCh8HA/yCV1OY=
X-Received: by 2002:a05:690c:9c08:b0:71a:2d5f:49b1 with SMTP id
 00721157ae682-71a465ef2c1mr144264707b3.4.1754060117143; Fri, 01 Aug 2025
 07:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-8-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:55:05 +0100
X-Gm-Features: Ac12FXyPHEYG_pYQDzxMSU30AXeVmEGb3btJMWqxjYnbmdkKJUWjZNj674YwuTI
Message-ID: <CAFEAcA8O7HRMW6DT0D1a6n-OY0cCZ6h2QKS7aHGKAazhtiSg1w@mail.gmail.com>
Subject: Re: [PATCH 07/89] linux-user: Move get_elf_hwcap to mips/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Wed, 30 Jul 2025 at 01:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h       |  2 +-
>  linux-user/elfload.c      | 52 +-----------------------------------
>  linux-user/mips/elfload.c | 55 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 52 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

