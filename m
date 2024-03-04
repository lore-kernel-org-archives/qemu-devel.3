Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C29EC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCPY-000154-0C; Mon, 04 Mar 2024 12:47:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCPH-00013V-3l
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:47:33 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhCPF-0003lq-GV
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:47:18 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513173e8191so5793677e87.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709574434; x=1710179234; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AhTq9DUb8f2D9qWOSH+xKWPF6qp0fQsGLfPI1Bm8Bsk=;
 b=nuSoklIYIZtBS7dVNPvexIJgWmItKAi1r9J/Jco7dBkDK5cF2IjGFXeP5oVG0YV1pi
 hNmklNBigeBvFX/7vK+aAlftcTD8IJJjn59RUK0ZTapkWFQ6abSXPTPBKiCDLqt3bCFA
 6ZktRee6u55BbEynpapNk3ciQa6znAFFj1WjgR3nSkFA6hWia9Lo4pEtTwzErmwYbXxP
 Wjby/G54nHJcl1QDbjwx+HR5ZS+OPR5wmSNreitTQ9F2NW/BcTBQYHMHR3E7UdSG9wjw
 TggLk3v/wyseY8vI+oWl23CmCX6vWtchIICNh2SFtzgJ5JAeYcQWwFbY1WwjnJWuZHJR
 IAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574434; x=1710179234;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AhTq9DUb8f2D9qWOSH+xKWPF6qp0fQsGLfPI1Bm8Bsk=;
 b=bO1ahvC4BcFaFMrnlExYA8a6jDcUlpFrzZv/imOH/u8/keslANG/1yD0RXMqJh4nqp
 NycGEtPGmswHCE6ne66H+JrQiXcPTcb3FVr4DmBwhOxymVu/uEv73C3oFTS6S2MY9UsQ
 gcl/bKOaljgGbBL8oaRaz7gW8/7P6ASkGjnC3WwbwdsM/iWa8t/6oc+ElELxz79uJCXn
 QmMAF8k7euhRlDHpyDuqyrwDb6ZRN2MRzGOFbi4CDh2sx7Q/pmz+8JadwrO7lbcVs6tz
 qV+r5+k1y27OCnk2laAKS7re734JkWtsJlcE1lkFnIz+sBvrr7A40/TV0BWIQVC0xrjA
 HiJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCULvwlpNXub25auRmMSwCVu3MhfSN6YqZi+wLJYS0WMKOMTVLWEqRWvszR4DhjEiSNuwv11ZO4X/ahAWRrnAayt7BEGZb8=
X-Gm-Message-State: AOJu0YwkKkZCHo2inrJ25jAgABN9WtjcMFHg7ugAdwQlU9PnkpKf85xK
 fKCPtUz9dMrJj5ylsSkkFWRd2a3hle04n9zYqnUpWFrg4LlrS4SuWzuPDpcBUPmh3S10N8U9Kca
 4Iz2Td/jmJ++GzKsQEwx8vuNuEGp/dv5DGfYNwW3dHNrk2Qde
X-Google-Smtp-Source: AGHT+IGDYMZeQmsynqIaHOkqqb64aVkXNQXt+a7tXxvmaRPqFJ2ZnAXtXwiTOMpO8TaOSMDgO+p0tIqaYSS2dh0W/lE=
X-Received: by 2002:a05:6512:2397:b0:513:32c7:1803 with SMTP id
 c23-20020a056512239700b0051332c71803mr8386901lfv.19.1709574434226; Mon, 04
 Mar 2024 09:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
 <20240303-elf2dmp-v1-1-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-1-bea6649fe3e6@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 17:47:03 +0000
Message-ID: <CAFEAcA_22ATJ14ZjudsNePWoUWXV7WOjU+9oZBfuWgiyRCb=pQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] contrib/elf2dmp: Always check for PA resolution
 failure
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 3 Mar 2024 at 10:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Not checking PA resolution failure can result in NULL deference.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  contrib/elf2dmp/addrspace.c | 46 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
>
> diff --git a/contrib/elf2dmp/addrspace.c b/contrib/elf2dmp/addrspace.c
> index 6f608a517b1e..980a7aa5f8fb 100644
> --- a/contrib/elf2dmp/addrspace.c
> +++ b/contrib/elf2dmp/addrspace.c
> @@ -22,7 +22,7 @@ static struct pa_block *pa_space_find_block(struct pa_space *ps, uint64_t pa)
>      return NULL;
>  }
>
> -static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
> +static void *pa_space_resolve(struct pa_space *ps, uint64_t pa)
>  {
>      struct pa_block *block = pa_space_find_block(ps, pa);
>
> @@ -33,6 +33,19 @@ static uint8_t *pa_space_resolve(struct pa_space *ps, uint64_t pa)
>      return block->addr + (pa - block->paddr);
>  }
>
> +static int pa_space_read64(struct pa_space *ps, uint64_t pa, uint64_t *value)
> +{
> +    uint64_t *resolved = pa_space_resolve(ps, pa);
> +
> +    if (!resolved) {
> +        return 1;
> +    }
> +
> +    *value = *resolved;
> +
> +    return 0;
> +}

This is effectively returning a bool, so we could use a 'bool'
for the return type. I also think it would be preferable to
have the return type be 'true for success, false for failure':
in the callsites, having

   if (!get_pml4e(vs, va, &pml4e) || !is_present(pml4e)) {
          return INVALID_PA;
      }

seems to me to read more clearly ("if we couldn't get the PML,
or the PML isn't present, then...").

thanks
-- PMM

