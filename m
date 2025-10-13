Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C21CCD18D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 14:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8JBI-0003Cl-Sd; Mon, 13 Oct 2025 10:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8JBG-0003By-9z
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:05:43 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v8JB9-0002AI-Nr
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 10:05:42 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-6353e91a04aso4534494d50.2
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760364332; x=1760969132; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9l46JjeZiu1BMV5wUaWsW4A92fE98oMzJFrRyS3dnSg=;
 b=e0dtK6Dv3s4hWlw7A7tnCZ6wdJthX1Y+aa+oZpyDnXR7QkfHdkTp7FC/bGPIQZaUdU
 L8xk0msF6SX1yU1plYXiEiyAHUR90jq6C4GnqcjaedtdIKrLa4cHjf0i+/WA7MdEHQcV
 MNMkcTgMxc3azJemmRyPQVWegEHY9MYAUrt67R0jWRfq8HX9fgvkOTh9E78nobmKMP76
 TLfRRML43Z7CYp6nKxSwNrmEFfXxC45JGbI+9xRI9+EbJ2jxXL3XHLg0TWbvrfEVOA8O
 HgNKD3U7+a3Wvz9TAAKZEophvuafrhgreZCTQd5sTM6ZSgkyuDs6mcTXJljga+xhoJYR
 FNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760364332; x=1760969132;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9l46JjeZiu1BMV5wUaWsW4A92fE98oMzJFrRyS3dnSg=;
 b=YYFk1KsXpp1XQGn2ye8c8ikXzIQa/o9ehbSSuzaRxFXgsdqyrfkyY5l7zrPttxWoBT
 UlnUN4UDEVKqd4VIHqkaChTnc9G6u6RW0L8ps+S0kRdjoQzVlN55TrnurcoJi1dIEXeP
 Vlw9x/PHEpO0c9PwlIrKd/sRFDOYbyXBZBPhISQqknUp58uuqNq13wUxpHQCfjjwvLY9
 RI2+JyaI+YJQCkT6j4AJ8lpbQsLMxFt94giwR3cJhZN/HRQ/PNEJnOe2wXAFupCkrDSw
 yIiQujQr9DCfN8qAeIVT0O6fg+N9FfNxyCRFrwOukQgkKOpuu71Jl7yuFsvIBbf+S/ri
 hUEw==
X-Gm-Message-State: AOJu0YyZQFgDsG0HNblzcbTr92vC5haDXuAVl5OI7rRYtc0lBvOHuulx
 dHUgjCy63c350jNwliYpLzlWPVnVde5A+k9XXrc1IcgMeYl7Hb5HHMz1w+DRD6BnXVVSlBL4j1E
 fhEqssWR/Quj6Z1OxVsJ3IId/z2Rtv3SCK/fyzvZnpkmw+f6vAG6y
X-Gm-Gg: ASbGnctL19mNZfGf33jgI9g+Sc/nnBzBQXLazvGC3ABPwEHIIZEpl1c98nTrJ5tCHts
 slbcKq5DIxwjqrxgysUR/cS14ZL0empCoavu82zGEsdGAebYy4YEui/F7lVeXHlXDyrJD50VpQ+
 2TWOGXH8LAdVXWjKS9l93JYoKdHfzVlzEbIVDWPPuhYy2HWasjxPDIGP8Xw5jSGcqZoYLNMbw8/
 KA8uD0eLJ72TdWn77kgdSzl9IUPj94iCVGOHu+9AbjmytBI6gRz
X-Google-Smtp-Source: AGHT+IGYJkdtw1tYwqcowgG+b55nFswVDVeJE4gCb29hFo0SfEDlQS4iBLxtYNcDYvIWzvA0AYULQ/RVNDJ6pAq6DO4=
X-Received: by 2002:a05:690c:6c90:b0:781:258:d87a with SMTP id
 00721157ae682-7810258f27dmr227499357b3.33.1760364331818; Mon, 13 Oct 2025
 07:05:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251010201917.685716-1-richard.henderson@linaro.org>
 <20251010201917.685716-4-richard.henderson@linaro.org>
In-Reply-To: <20251010201917.685716-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Oct 2025 15:05:19 +0100
X-Gm-Features: AS18NWCXwC119tILLg9SkSrcATPC1dlSge4QwqtxoyD8sk0pB8Y2uGCzVApmX0c
Message-ID: <CAFEAcA8G3CB49XiME3-HhPUiOec63=NNF6Dg7q=+05hv8ToLQQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] target/arm: Add AIE to ARMVAParameters
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 10 Oct 2025 at 21:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Allow the bit to be set in TCR2;
> extract the bit in aa64_va_parameters.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h |  1 +
>  target/arm/helper.c    | 30 +++++++++++++++++++++---------
>  2 files changed, 22 insertions(+), 9 deletions(-)


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

