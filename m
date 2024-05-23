Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B780C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 10:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA5sp-0003Vw-Au; Thu, 23 May 2024 06:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5sc-0003LH-5L
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:41:03 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA5sa-0003ZT-61
 for qemu-devel@nongnu.org; Thu, 23 May 2024 06:41:01 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-51f74fa2a82so7948642e87.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716460858; x=1717065658; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+dPJa0TCgok+810qPb2xUJAjsfW/V6jy5fSIXRbjRA0=;
 b=HskVJnJd1KC5PiK3aa/T1tQ3vYJmbrM/Rvkln0yI+Dj9aWmLo3WR2Df0bhL/9eP7TV
 UEH7JKn60ABu/oSHSCLMlHw5f98l2v5XfXtZcLLWmXdqE1tyE3RS3n45KF9TdKUqXqVl
 BpUZ59cQ4CSl5rjG0fj+Z3374BSucG6/3nBPlWHLf5TA+pxIWJnaIeJl+5ldFO23e+Kx
 EPzgkx6HUIvE52M1i/bne6WwPfXDL09rzbI9rr+9a43auFgmeXh7/nvq9//TK5Yo+SMN
 fCohT6HIlzjulO0b5aK246obVTg1tVWSgSjwBO4lZNVT8zZDn8QIH9BuAnqo55N72l3b
 VA1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716460858; x=1717065658;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+dPJa0TCgok+810qPb2xUJAjsfW/V6jy5fSIXRbjRA0=;
 b=kpK698BysxeX9bfjNqfSeMrwI2+fGQFdvkX400LlKR70gfmBR8Iil07z5YZqYHqyDn
 fJFv/lPbTCXpibAV7YxTI7WR1QUUT+nr5pJsINPaTx5RUSHB55qZYvltQNZ/9OgoCe+P
 VV6j2EFhkJWcg9F0q4DsAjmPSJ33Kl7OoC4qJV4al2B927m7dyAG/kXASBI7KCwi+ZiJ
 0YVDivboYnEq7/Gyfyh//fm8xTkEURc6RvY3TiAo7a4Eh5KWaezEyw+GhFzdalkKANwt
 UjfdNVjF29RWnYsq6Asy5/u6Kw7vyAr8H/RBYEMXDfrG0Y2MSns9Q7s0qGrx8wHaQ6N6
 if1w==
X-Gm-Message-State: AOJu0YxhiNGszCG0EsFhBQg2uyZqZr3UBuigpEABun9Z2/gSiKuMyUTD
 bLTJy2XJ9YmP9IgA9uy+bZ16dZq4mW7Pn2H2HfmEJvvMOIMQ2SToA6iCRHg5nssMLKdqoRJOpQP
 qkeAWOm5pMSvBdl/dibOmoEf9sbfC3Uy65SWX6vQdnh5iT821
X-Google-Smtp-Source: AGHT+IFwbgzaCO3WWgh6VVsqfTOM8d6yL3NoV94Xo8zu1MrLdJcDfH2mQVOgMKFBvEm5jDhUEd7Tnn4TIXG9oL/cTAI=
X-Received: by 2002:ac2:41d6:0:b0:522:34a9:a7e7 with SMTP id
 2adb3069b0e04-526bf26813emr3825015e87.22.1716460857924; Thu, 23 May 2024
 03:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-11-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 11:40:46 +0100
Message-ID: <CAFEAcA_p3c-NJs-JeKM4fL-Ry=B4CkO=VAB8=DuShVoXC27tnA@mail.gmail.com>
Subject: Re: [PATCH 10/57] target/arm: Convert XAR to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  4 ++++
>  target/arm/tcg/translate-a64.c | 43 +++++++++++-----------------------
>  2 files changed, 18 insertions(+), 29 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

