Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303BCC87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiJ3y-0000kJ-Ut; Sat, 02 Aug 2025 16:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ3w-0000gq-Vu
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:42:41 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiJ3v-0006RB-Dn
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:42:40 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-71b6703ba32so22184387b3.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754167358; x=1754772158; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Sy8RyOzMB+5ZS3lQW3wwyupDzR3Fjd3ksRNc9jbILHI=;
 b=YRiL9Rg9FBgIKf4tBuMtWRRgKOARTUiA6ITPpRiEOiK/14oOBi48RfMfOPcQmzRb4o
 nSuQLU8jwekVOwuLi+Iw8hwwqYhnosiOtQVkwrM6qgVK5Ja1j9igtYQ50DV11aZwrOXu
 3YQQVJ2VJSJlGQetbnCD+JB9A0NIupqNwL1HOY6mb7FYCUSoKX9vOMQYkJ8idiavNSkf
 A9dxOsJhiTPUQNP7QJ8TfDs2RbD6ENHw9jy3H/zUU01O5VQnLyDiZvvRWaeHv6Qt0sS6
 ouoSJnT92Ly8y799BrSiY3R8GFRrMXstcfFO+Yvuac3KxvPxXmVzh0KSw3uY/HPxLQgS
 ydOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754167358; x=1754772158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sy8RyOzMB+5ZS3lQW3wwyupDzR3Fjd3ksRNc9jbILHI=;
 b=IjRpK7sKdXYgcNvjFdJEH4GpGK2ZBz8X1lgkdsG88vBLKrnUbtArmkURiCROdh5ZjD
 DRc+TbSPAxu7+dnNS9qub6LW9OaR0wKaIU+PUSxBJ2tV2+tRxalVdV5jBZoB5rxGP+iH
 5of89F6EKpZxWDdxYnyHHGwHolylc8Ztmk/t+64F3ayy0sZO7ozq+4A7IQ6N1QCsmmLy
 DqbjzyITTPnWVKcFR4uxeejjxqfTgexlRimYZgNlkjqIid4VtBzKjfMMMRg6RGejowEm
 GxYWSw5uGi2FWWoBzH2J2BH1YPf0O1R+QyKbahQAUVanPnqYxnNcSkQN7X8B/TIvdDqk
 xxpw==
X-Gm-Message-State: AOJu0YwVb3Hz3E6Qb8bukFJZ3FFsjjTn89cObozyeSNL6P4GEkihWoQC
 P+amM4FAmpRvzDQ79278m+fZqT1qIiU26om8GirNxSguPDsZ3jdYi7/n4hEPT0NK9pWoSrCBEYx
 Bs/3+LIi2l7bABupIb7UxI2Z7WucXVBRh0BnRfHhMxw==
X-Gm-Gg: ASbGncvDpmHqJP7OZYU27c/6h97LMofs24f2xCQtaQZ9QHGt/KMKtXBUK8+MiGOSqyw
 XKZvXAXQ612aaCld5owwtHzfsDDiaLjNADssmD39JK9oMOr6J4jYH6gklKXEoPKaKAu8dfH068V
 5WpPAejL+QqWi5K2Ywy4xodbbL7yns56vLLm/Ov5Y6BLTv4iNA7+WCQ6vv+IC1tZRLxNaOWAd42
 GXh7mPtfCA5lmnnEQc=
X-Google-Smtp-Source: AGHT+IFm7AtpTa2B7p/EZ+41Id0j/1vF39MnsclezTmKX5qmEAIZS7Mlh3wDaoKCyR4I3KOh+if05gSu5AFV11/ADdg=
X-Received: by 2002:a05:690c:7010:b0:71a:41e2:b553 with SMTP id
 00721157ae682-71b7f5958fbmr55841817b3.26.1754167358347; Sat, 02 Aug 2025
 13:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-89-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-89-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:42:27 +0100
X-Gm-Features: Ac12FXziAbVmK1ynEl7DMbPxLKKDmBD1CWBFilgoTRp0uOg-JnUYskQDNtwFCj4
Message-ID: <CAFEAcA8vu4Dow6_MZXd_G82XHNCjfyJ8e37pgEXxY_+dCFMvAQ@mail.gmail.com>
Subject: Re: [PATCH 88/89] linux-user/s390x: Move target_psw_t to signal.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove struct target_pt_regs as unused.
> Move target_psw_t to signal.c, as it is used there.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/s390x/target_syscall.h | 22 ----------------------
>  linux-user/s390x/signal.c         |  5 +++++
>  2 files changed, 5 insertions(+), 22 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

