Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA32C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:35:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIwD-0003sk-Ek; Sat, 02 Aug 2025 16:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIte-0007Px-On
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:32:02 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiItd-0004ag-5g
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:32:02 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e8ff3ef84d7so259469276.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166720; x=1754771520; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=otDYK8wDyeSmHfNY0B+CmxlhHnN9+NmdNH7pdKypXB0=;
 b=VSsnAWZm0dW23uMJEd/n+gWeUqBQz/V1VE4qDKAKPnB1t8ggNR26YczhsrSm+yxVCt
 Cb0vnPhA9UsZJO4psSwTMdVokpyUCoyAIA4BEpdvVJzHVHC4e9dvnOGBehM42nYcIqFR
 krwRXy83zZ956GaGIjkQUqPJ7YgL7J2rvDQ8grZyK869juAhM+NF3MQG8X9eJ7HoUHSa
 WFXWCc4uSSUkxIKHCZIdl3cA60wo79YRyWqc6i4IoG5R8ZPk+pRaHY0Ja+o8E4l0dRwV
 FNESHDjkLiQwwUN7rxOqSqzK70BrKUI57LgrG0snMPBu/qSBJQDhK6hbtTACIC+QVzkj
 0iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166720; x=1754771520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otDYK8wDyeSmHfNY0B+CmxlhHnN9+NmdNH7pdKypXB0=;
 b=aqzzjzQR65Qv8ND/fg9Q6t0Wxd0wQo8JfPTFhtHurbEd4kwozgdntyWRJgJfqcwwgG
 Jryw1anrwFvx68WItDgrRCxRtYCEiYned7dchelylV46xlsM4e0Hqtlod5I03tvDcs5o
 BNPWX5cDbWo28iSyw/L/qrcQgGiZRvKLzG70LMs5uSO6A3WweehpwnymXx5gEv5DsaF6
 2TMdN4rUqau89Ii9mO7K67KStjp+HgfkIwMmR+0WnVcggCFjPGCWXs+Mmm3KwVgcSBH+
 kCSeSjqG3XDIqS5O4jFveBywkWIKZhZUjKGX9srYQURs0QVOIPjDzBY3q2x+m2jg//+5
 8Vdg==
X-Gm-Message-State: AOJu0YylYkyfUs3dPjY0avDvfzN3NBpsoMGAYqdLxfl+OqlGa6dtB+u7
 swHLGcwsUxvFkTolrXKv9lExpTZemSc5e4EFid16rqqR5AWo/yE5Wb2pCdtmugYxKTM12C1PRcZ
 Z0ZvmXQK4pMZDQDQliJ3gkVVbZejeQ2JriyVNA33AxzsbGuuXdTzD
X-Gm-Gg: ASbGncsCPMG4KcAJnakxCJWX/oYJsyISLBJyBf4oYnbm56oSTj4/UNqnuI9+EVL83GZ
 C9xpGszRnzPOoL5MMz224ovepqaZCx0/tTItRcpJdgki3XIP3Nn7L7fNHsFw9dD/QvGadgj2WC6
 Kd9rcQgpdJbEr7BB8JfezSWipi2+5XQcFnhjjhv4JlH87IuCxaUv0r4u56Awyi5mmYzT5I4eje4
 iByVSb1
X-Google-Smtp-Source: AGHT+IFbfgSh6/Qbwi4hCxTmK2nj4fxBre45uviGi4KpjBcB8amXnFbHDhcru1f8QfQBYXOxX/QhPeX0lGYHHJbPxnw=
X-Received: by 2002:a05:6902:4187:b0:e8f:d72a:8ba1 with SMTP id
 3f1490d57ef6-e8fee00812dmr4565424276.14.1754166719727; Sat, 02 Aug 2025
 13:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-78-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-78-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:31:48 +0100
X-Gm-Features: Ac12FXxvP9Y7LPXcKGWHuvZa-bRpIpsnUOEe9goX8akR4bW32oIbmfOZ8e2TXsQ
Message-ID: <CAFEAcA8e03Bwk4ri2ZAU-SqPzF_F4uZfdMjdfvY4K5+XRynxAA@mail.gmail.com>
Subject: Re: [PATCH 77/89] linux-user: Move elf parameters to
 xtensa/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Wed, 30 Jul 2025 at 01:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/xtensa/target_elf.h | 4 ++++
>  linux-user/elfload.c           | 9 ---------
>  2 files changed, 4 insertions(+), 9 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

