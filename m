Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA396CCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 14:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vArG4-0001z0-Ol; Mon, 20 Oct 2025 10:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArG3-0001yW-1M
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:53:11 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vArFu-0004ei-Fi
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 10:53:10 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-781014f4e12so55400027b3.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 07:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760971980; x=1761576780; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XUGiSMlcmt18CxYz+vf/EOQCgZHjh36uo0NuPzN1UXU=;
 b=Y+WQPmNGnAcIA5iUJ1E71bXu3nmm1811cG220MbuoJ0TFGfsn+SJRxBw7GXeWKI7Cn
 1F1XRUhgdZE6coA5ec/Z6YkWDHimU5Gkp+U0Bf/0WVKfoRj312POih5y3LT6vbNAH4yr
 ig2aFnvf9f+ZGono2l4hrcSKhGiodbkgunazPCezcHGA1H92xEbpRl0ugdbjbnCFH8Pu
 dRpHMJfXTNLxG5DYycBajAaE0datEszfEun3ivXVS3RWQraj+c9nUv6kn4H4RiWtbKCD
 WOhWY+nWV8y3yKxuwFHLgwkl4sfU31Ge8AaBavNhdPSv3PaL58vXVsHkL4mRhqxy8NhL
 1knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760971980; x=1761576780;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XUGiSMlcmt18CxYz+vf/EOQCgZHjh36uo0NuPzN1UXU=;
 b=hZIe5FV14GIB4RZ0xmK2GiRV6MpjhBOFr00lQGw9VGds30vSZDwC5+9nYLLcF+vgwF
 3Wroe3tx1nwkzi1m+7o8FiPPN/xwIIhuysrDFk3iwrppoyRRetVg14jFXQYgyV9DfDyT
 vIjqA3arCzzF+jwDQwpI4zEUpqaoHZ1V08RKY83KBJ6q+l4hI5yDJV25VUnybh9VvpwI
 j9gen0qK0/igPyr6m63im/ASZuqPyKenK4Lgf6ZKKs2O8xFiky1kJVWLuwcLYb49Y7Be
 UrflCsdN/uPm5Fa3wCLd0yGDuSbUxbVO1Knp4yFTw/FHkiV3fip0QltGCT8c2ZSbM6Db
 /7zA==
X-Gm-Message-State: AOJu0YzQN93AuOa9V3M1WdanPlt3ruiisdDDYgJL9P9X5ajSGmVrfboC
 E21D26RnOLI9kJJUq/HoLMmxanc8UnC6WXAkTgch/ww5HoAnRXW5z8279iCRSXqnf3tc44DQh7f
 x26y5WmxmjenYvP7qaWuOJ5GOJUvGDknu98H0TMYQ3w==
X-Gm-Gg: ASbGncsYFx0qoCBkOuGxp68LQ7CLhEzxSgVoeIc+5aB08RxpqP4bTdSemTa/h0cYkJR
 dhb6i+6l94lVuI/B+c9X3jABimLLN5cj4nw1VMDjzQghcw0swzGHBqnn7r9h2bqhJOYoVINewHv
 e4GC62RnkB2vvanUEvVetFCpsmw+NWSs6eeZJAT7kw08lUXdYIdJH7N0FzkImhMuUbLQxc96Dc6
 hRo41g0moi6fwQ7pLhV1F09vjaIhpp4/l3Urqc9a46YRPJw65idGEgazRE1EA==
X-Google-Smtp-Source: AGHT+IEwPC50t121rmzGAexjxCqsCiT1Fu+VdcKI+IeNz2I819nIpuelI8Bswa4C+909fW/rEFXSpnokGh7ZBnARpTo=
X-Received: by 2002:a05:690e:1407:b0:63e:2b26:a8ad with SMTP id
 956f58d0204a3-63e2b26c295mr6425272d50.38.1760971979709; Mon, 20 Oct 2025
 07:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20251014200718.422022-1-richard.henderson@linaro.org>
 <20251014200718.422022-35-richard.henderson@linaro.org>
In-Reply-To: <20251014200718.422022-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Oct 2025 15:52:47 +0100
X-Gm-Features: AS18NWA4z-Jp0HeDgmRoUHcS9CtavLW06qaJuueFDSD6C3gzisoH0k_brfm9x98
Message-ID: <CAFEAcA8dW08ZUJ1MnBvQfeimpxszphkNZAv4cLw6EgshZtSLvA@mail.gmail.com>
Subject: Re: [PATCH v2 34/37] target/arm: Implement TLBIP VAE3, VALE3
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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

On Tue, 14 Oct 2025 at 21:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/tlb-insns.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

