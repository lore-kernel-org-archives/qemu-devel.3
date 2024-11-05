Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4B8D2B92F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 14:23:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8KSE-0004Uh-Ow; Tue, 05 Nov 2024 09:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8KS9-0004U8-V7
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:22:42 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8KS8-0004qK-9n
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 09:22:41 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5cedea84d77so2288977a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 06:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730816558; x=1731421358; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e+O8wEaYDT7N003T3XKKqDpUO0MnxeOW2tpsI0oa4x4=;
 b=OlHnL0jy3z96pkl+o9gC5YN3gbQ/QcCPFBP/TlVkb24lxcfxRGqAw1pbwhxPYkgIYv
 AeOUKZZfJoTp21PfyDJYZFLIzUrAYS4CC2P8Jw3ZwiOOx+jYb6YxBLM+Eg6b238DEA/j
 Y32WrQ000dL8mec7z0iZS3vMlnmMi+Uqdwej6Gyqm4FGUDcSfgyuNo+A6pRKwaEA8HWp
 O/JUvsucKGMeGl3Z14PjIdwER/nw1MklcACuqAA3r21rA0hsC4S4tcfWNIIQsbKYgQxq
 jigvpoAYqP2gSx2hwtewFgO8WI0hXnFn7ncdSxF+DQTeZ2Fgr0W3Gz/lQS0KwwbThKXj
 7mnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730816558; x=1731421358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e+O8wEaYDT7N003T3XKKqDpUO0MnxeOW2tpsI0oa4x4=;
 b=GoD1Xq+gLBnJMdyIX0WC3UsFE2IuMUeg5D2jFzCTV0v70GHngBUa5bjq0H9XnkmFfS
 FtoLLIUoCIzoURx3lvY+ARVtRMMSzkeJWJuwa8AzUuj2D9ySw8feRn7+HFN9NeIMTQIS
 rJgweMjxdFA2TWJfi9+TaqQZDDU32jFS9E0ot99wA9LqHFBKFZu1jr3+TA/sD71fnxoh
 0czuJkIgC2Z41u5iGHKTLqrL3QVepl7RluBUssYkZ2us+OKIHMFdtiG7j84bBU1JPB72
 qghBrWRKEnAukklXEP6UGlptzpKt38b+V4n1nNqXjjtzytvrJhgSQbr5Q9z+kMM7XBzM
 IHPA==
X-Gm-Message-State: AOJu0YwWp/YUypij4idNnF0BEiqGeY1oNDF7YxDpAO2GBxnttqqSPrEf
 EDWyjYfOPvyTOMxihZHTpPkQEi6bZqHjSiYk/9usWbaJX1cVro0z2e6A5JKSgp5Pmx6VX0rUQ5a
 zDJQwkDY2LJbEe+CNYFOyxat6qMfZ2Te0OyRugQ==
X-Google-Smtp-Source: AGHT+IHYqtk8V1auaFuZfpaBr3yYQeHDoyUnp5Y8WwPvA2OJ8OfNxdkO33/CatK5ZXXskVUXVIfJLToA+1x232LakVM=
X-Received: by 2002:a05:6402:13d5:b0:5ce:cf30:6840 with SMTP id
 4fb4d7f45d1cf-5cecf306bc0mr9787275a12.14.1730816558419; Tue, 05 Nov 2024
 06:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20241104001900.682660-1-npiggin@gmail.com>
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2024 14:22:27 +0000
Message-ID: <CAFEAcA9-211YehAQpD3jg7KEAUS3F+h4uKNVD1AH7zwsQPtYMQ@mail.gmail.com>
Subject: Re: [PULL 00/67] ppc-for-9.2-1 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 4 Nov 2024 at 00:20, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The following changes since commit 92ec7805190313c9e628f8fc4eb4f932c15247bd:
>
>   Merge tag 'pull-riscv-to-apply-20241031-1' of https://github.com/alistair23/qemu into staging (2024-10-31 16:34:25 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.2-1-20241104
>
> for you to fetch changes up to bd4be4d9bd20a252e677239a18b6409ecee98f56:
>
>   MAINTAINERS: Remove myself as reviewer (2024-11-04 10:09:36 +1000)
>
> ----------------------------------------------------------------
> * Various bug fixes
> * Big cleanup of deprecated machines
> * Power11 support for spapr
> * XIVE improvements
> * Goodbye Cedric and David as ppc reviewers, thank you both o7
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

