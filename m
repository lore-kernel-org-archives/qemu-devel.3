Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1C6FCA0ED1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 13:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umuMq-0002gV-0j; Fri, 15 Aug 2025 09:21:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuMg-0002f0-Ar
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:21:02 -0400
Received: from mail-yb1-xb2e.google.com ([2607:f8b0:4864:20::b2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1umuMe-0005Bg-FX
 for qemu-devel@nongnu.org; Fri, 15 Aug 2025 09:21:01 -0400
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e931c866031so1995431276.0
 for <qemu-devel@nongnu.org>; Fri, 15 Aug 2025 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755264059; x=1755868859; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Jl0r+rbUi+zNDnt9GYEcn4tCmMIlYQ3Y8PaQZCYiZIM=;
 b=GfcvhyW0I6w9FAsZz00qn1Q3/IBtu6v6HZioZfP0pK/eIrKLyFVybPudADy3MA1yfl
 Da4cvrkgV1Ka+ZHmXL4EC7luwLI3gzPOPN7wsGlEQxBI+UoWIyONCX3a6jfXQSnp2jIK
 +/k3bXaGYiBj6XSq1MtxAHGqBOBweJn5GqsJUsfCcvKmy9yJC4E3Ph7pFiLGiQYD/T+z
 3d/YwwPTv0QOSRx1ufm5aGBuT6h7VQ6cJMexzTTgM2EFblNWuTPBSIyaZclEBBUkEA7a
 By6ku0iLFLfVfWRiItxf6n/usUeK8/8gR0Axw1hASIxfO83mJpKRMJJ+bYTWF78XGCQY
 nshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755264059; x=1755868859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jl0r+rbUi+zNDnt9GYEcn4tCmMIlYQ3Y8PaQZCYiZIM=;
 b=DSR1R8apjTzDorfhAAPeKEolkgHXbDaj5Zh4Ch4YuCrMSDbPEpovi7rWxkbgaj1Z20
 Emj9pjMSlLM226n3PgcWcWPMAIh5EtVM5REh6HnwnBH5pPaup32pXQeDUmBqjskjYl2R
 wTgidyuKAlL05s9jZhOQbX5PqDKUQlY+oISkuvxxwQEI7EwB0w1WeEgYBUwZUAuNBJOI
 9ovD9XV9YoUasvQjAOWqxCxPJpMx7U2waSOxq4IDkYxt2j2FCpIl1tAmxAk3pDWjHcqb
 2CPpZ0HrmsRFnRvedfx78Fe3IN41wWokREOJOysQYpxdZdOyjGPUq2y2Ga7RvzjV8enN
 a5zQ==
X-Gm-Message-State: AOJu0YzGC9NuVb9D4Fn/3xj9vA6b9PBz16IU3CC0WhCdYTVFYqW4140+
 GUIPTCkqbvTS5cr1dh2u76dKwQuoyfDAKGa9IaOOj26GchjbcOuRFroxq2vz46wAJCh6G/PDZ1X
 uAJfx6tQQqrr3q12bu1rD7dHejCfz4GN1xo+vLsi+AA==
X-Gm-Gg: ASbGncsH5AehlpFLejX1qaUbm8rCMlczRW128Pkl2qncQ4ZO4SbeJT4ddHL4p7zc/oA
 GZtDYLGZT1eXRX7o5Hsi3HGDjBbE2EiRBFUJaJhaYel/xiZnqYfyOTBqT4eihd/21h0c9AG8ARG
 WbT7zs5amBaLnifmvFC3VjuVpa6ZWT+QfaxFSVc6Dj0MejCr5IkOgbZ6WbVS0tTT3r4FEv89Aky
 +PMegQvYHtYl2nFz/w=
X-Google-Smtp-Source: AGHT+IF3xZBIb4f4dFWr3FgwaXVQDjFfaoup0cUV+lCocecMX6jbL7H5VrlrLdBEVOA0pBPGIz9Z6Sv7JjvenmR3PSQ=
X-Received: by 2002:a05:6902:1024:b0:e93:11a2:ebc5 with SMTP id
 3f1490d57ef6-e93323be97dmr2111707276.17.1755264058708; Fri, 15 Aug 2025
 06:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-4-richard.henderson@linaro.org>
In-Reply-To: <20250803014019.416797-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Aug 2025 14:20:47 +0100
X-Gm-Features: Ac12FXzYCTmvypxVwb2RwwrMIVrSmTXIkrThYmX4kabbUNE8aSZD12uAlnCeNfU
Message-ID: <CAFEAcA_w+MsCYcVo+2m7FC0YGJfbJe6Hvz1WfaaAS_gXbqxAdw@mail.gmail.com>
Subject: Re: [PATCH 03/11] target/arm: Implement MIN/MAX (register)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2e.google.com
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

On Sun, 3 Aug 2025 at 02:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 22 ++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  5 +++++
>  2 files changed, 27 insertions(+)

(this also does the zext twice I think)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

