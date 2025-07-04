Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA40C83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhZ2-0002nt-HT; Fri, 04 Jul 2025 10:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhYf-0002Fz-7G
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:38:43 -0400
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXhYd-0003pp-43
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:38:32 -0400
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e733e25bfc7so858075276.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639910; x=1752244710; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uxquwJ1KQj2ltiSQsA4aR/Z5LpXg/Wxv82in7rMxKLg=;
 b=LlABUHQSPP1TtVGYCGjpmhKRRCZ5KurD2sIJtCU0P/fg8Au976q+MkdPMy5L/7SND8
 jaqppBE4ReIeXjQXKEWHHzqRVBCGSrxmU478crIahQuCNECu4TdB7qySYNM9ryK1co6p
 B2Nqch/rzUAVZwqAesU5AvPvf9TlT+D2EsvRJRA4a2v1iKyE+hi4z6bTtI/w4ROZ3cHC
 cualhIAPibKyHrHafXLbNV2DakH7XEc6rWjVFsvX9wi0wsigc8J/lwN2J5MNGut4VCVW
 L6FlTxEFrT/vrmhH3MXWDCfwJujTWyNYoKmNb3rem+XuVYJAkV4ul7TGxwuwit6tlUUF
 QDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639910; x=1752244710;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uxquwJ1KQj2ltiSQsA4aR/Z5LpXg/Wxv82in7rMxKLg=;
 b=Jv3BmbtwRC8V9It4o4h6q38d8apaQe5Wf3eUpYfUxXsZ1IDXUCOyJEag7UiLOKi8d3
 7t/u5z+E/FmxtA6KiN955eFKNZMiIq2A+Pf1xFzJ07tU0wa5ANoAWoCM7o9St8jlAoDk
 0OgxPv0YbSQY2fmxefyaDTUmA4duYBxkzBGa4SDTPW6eWvjrR70WuOPcspEvRRbVFEmu
 miI5Y2eCu4q0DZU6ueVOO3GWekRGqM2OkUuSAZQXU/7R0lqqgPd0qVl+8HQFJcUTnS9r
 KnYFbe4KqnCmzWrDxjlpdSEVXPjZ1yILz8eWrlxaT+7TDfathoZ7w4TFwcqCHfgpbBGb
 Rp6A==
X-Gm-Message-State: AOJu0Yzutabv7MYH8AX6gxfb7/tjYqalkpEzCrgc/XVtzdmDC4MQ2RS1
 eFTwHb/Qs8CoKt5He7CYB5gPbbP9E/n8lU+oXii5Is6dQ1PB8oHpuD0UEqEHIVIa2BuiSFScrpJ
 s86d37FVlYZyToxcL6hFyKOVDJCzRd0HJqMCIyGMj3g==
X-Gm-Gg: ASbGncu7XL+zVr9DtlYh+nqksKjvwSON4Bid1C+EiJpQibDzWCQYPjd33DD7bfl2x8j
 dJBI7KCO785ToMO/JiHn79k82mOd64WzYvSZmq6AHzCwVnFH1v9m7b3skcsHaE/R9bOeZPM+X8y
 JC/aC819cXxtxGWZOLULzpp6ShwD1F+KE8m93j0AzFlUw2
X-Google-Smtp-Source: AGHT+IHM9YKWMmuf5XQ1UXn2nopkP9APOHYhyUaCOQ/u7/0zXvkGkc0mP7qkAwSlw1CieZ76+QcGdqs72FJVrLUx8Vk=
X-Received: by 2002:a05:690c:6e0c:b0:716:4ae0:7bf3 with SMTP id
 00721157ae682-71668d01382mr33148137b3.5.1751639909449; Fri, 04 Jul 2025
 07:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
 <20250704142112.1018902-71-richard.henderson@linaro.org>
In-Reply-To: <20250704142112.1018902-71-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jul 2025 15:38:16 +0100
X-Gm-Features: Ac12FXzsky8qIaJb2F8v95msaZoBTYWt1jv9jz5k7wUepDsSVpo-kE_raq_xIt8
Message-ID: <CAFEAcA_sSpR2E9um-hgudy6jaPGfvPpSELCWAOorbYCnizYiUg@mail.gmail.com>
Subject: Re: [PATCH v4 070/108] target/arm: Introduce pred_count_test
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
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

On Fri, 4 Jul 2025 at 15:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For WHILE, we have the count of enabled predicates, so we don't
> need to search to compute the PredTest result.  Reuse the logic
> that will shortly be required for counted predicates.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve_helper.c | 81 +++++++++++++++++++++----------------

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

