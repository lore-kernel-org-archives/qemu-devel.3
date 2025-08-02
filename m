Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49562C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 20:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiIvQ-0000yv-4v; Sat, 02 Aug 2025 16:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIt0-0006us-1f
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:31:22 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiIsy-0004Vq-7S
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 16:31:21 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e8fe929b147so1240592276.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 13:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754166678; x=1754771478; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3czQ1t/Fw+FDXEo92fTbNL4OZVgoTYHhaZecMi9/6Ho=;
 b=raU//OSfhLl+EFVegqqVh3hYl8YIqvQO7zLy9AL2lBf5gQyJSv1a73nQyej65HCZCe
 /mCRbRlBaKeTMWGFKZvlPziZetjxRxQMD285ViSPDUMzJu1q8C9kM1O9RU6deFpn7/My
 4twvLcMbRBijXddDkBrmdE+rHoSnf7hzqsSBAdmKqjveW5rUMT2N1CwFW/0piQXGHpM/
 yGMFvxoNJ7x1IIQmVeYo1qao4KkW2GZVy3qYpCWp389uhQqWMIj15l0SSHDD7MQLIu2I
 yVC0Y6WNeF9OsrrMFkbjLhnSRuNJ476etnFPkfvAVHj45icwB0bbDo2vLE+B/S9X1gym
 5UCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754166678; x=1754771478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3czQ1t/Fw+FDXEo92fTbNL4OZVgoTYHhaZecMi9/6Ho=;
 b=T3UMIwzqCXY4A9KXYpjJHqkuydThLhzYumICXJsECKID46kO/TvPudbmS5Wy8PyjPv
 I77i0JqSm09xAThajMpyobkXIA30FTP/huwoj0z1OEfgZ6kHsNDObnH7U2QkG4WTj4tn
 5fhmnNHGgblHbNoUFJx1yqTtiZHQAu2FBIlt8ISVvit936C+6D1c0fLz13OhZjaZ9A60
 X3ZViq67gEbirBZ8uWmIo1dZhANj2+/YIkG7Qtfpm5A/KXUoXRm3d8vQf/Z/HS5TZI0f
 smlPkiYKicZQIETRTMdAlJqe4Trj3JmEMFP8cFT+ze2LRgrkjZgtRnLxDRro2dkKtp4a
 92oA==
X-Gm-Message-State: AOJu0YzeCEJVuoctMXwRaRKcUjswr++3oNw7R47G+08K1fAalbROQiik
 WjYlV6gsLLRy/kaEwbJABZRoT1IzqS/AKyH1lXtnh4X66uFH3WWWQyoPbuMSjuu59XYZlNps4p3
 OWAhXTerIO8AmS0BFWCzDO7+sX5YWV909HfZtKZUUrQ==
X-Gm-Gg: ASbGncsmQyWaHKF1fkazm2HNRepyF01haEzaulUAxHuCa7BYuefr8uVTfJu5Lhp7UYx
 MHsxkhhSBy4Coj7GYTzojiGha6JVCW8DSWEE/vHUVQX5I2NzXO3xWEWaiugjHJBauHyw/g0RAgM
 MxNOIvfPPU1JcVWda/vK0NKzFrzuskq7uhlputemAS42p1S44n6Cyq2hWiFc/qRlw5B0yGg8Dxt
 EByl6nH
X-Google-Smtp-Source: AGHT+IE8pj3kEyxaOxqZcjSkWwkfBxA/PSmsxO9fRYy+2EwNL2WeX5eJgM1HYneeHGDnUIs2Cnlcr5c0hl9GBJ5fe2U=
X-Received: by 2002:a05:690c:398:b0:71a:44df:6b8a with SMTP id
 00721157ae682-71b7ed16e12mr56130817b3.1.1754166678470; Sat, 02 Aug 2025
 13:31:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-76-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-76-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Aug 2025 21:31:07 +0100
X-Gm-Features: Ac12FXyBblnat5shhD0CrjjecFTxuhGDM-_5oqTkecQ3dq8Zs62SFrYUPmfHG34
Message-ID: <CAFEAcA-ZSSVAdNXYhWHTW6qzC_CfbXLtGMPg5bKK1NRrRdJT6w@mail.gmail.com>
Subject: Re: [PATCH 75/89] linux-user: Move elf parameters to
 riscv/target_elf.h
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/riscv/target_elf.h | 10 ++++++++++
>  linux-user/elfload.c          | 14 --------------
>  2 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

