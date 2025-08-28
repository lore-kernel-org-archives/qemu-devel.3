Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF67EC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIW-0007ju-BX; Thu, 28 Aug 2025 13:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdtL-0003Sf-OV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:46:24 -0400
Received: from [2607:f8b0:4864:20::b12e] (helo=mail-yx1-xb12e.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdtC-0001Mo-PM
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:46:16 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-5fe42994547so312847d50.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392367; x=1756997167; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vjJfXl4jttb4KKwarRwrXGeqfwHtBXFQ0xRBk5/6NBc=;
 b=ZPBEBSuiTkmkSmk7k09DfT4Zrna5jjHElT6vdkwh8QxF5zuMf0uzBNx8qzMy6l+mky
 7C54RP8IPjwPLqgfRakHOijLm1mrI8ADkcnP49kmw+l9uQ8A+Bf/+CrWSU1CCRQWFZEk
 jrtgQ1PISzkRHcl40bA/KxIPEdNHmcbhi1ryRjFzchXJ6UBZlqtCZcxKboy1cQ8o2Whv
 CIrtRqrOpOIkkvvdun3OI0RIRA7rXNT8G6yJ1Dzcc9pHlyUCqvJq91z5bW5pw8D85xHK
 BpZ15NM7Gu0nMbLudWtqaS4ggY0ZtoQCRvZPCPd/H/N1EyWv7TTv5+Ex+xqylQM+GLfx
 7iDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392367; x=1756997167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vjJfXl4jttb4KKwarRwrXGeqfwHtBXFQ0xRBk5/6NBc=;
 b=Ju5rqHqzT9AyJlkzD0X86KmpaAlZNlyYZzuBNiWaVABHnPl0ZQc6jiCechL1hkyMPy
 85Ee3ItMcZwRSM6SPx6e46THUq+Yt5cA4YFzxC+JkFzOA53IX/tQ9Ly0b4G7Mr5AhiEx
 AcdwcrDS/IDJHBAhIiY96GPs6QFUNjKvVEbpP03+LBplEaTMfZJUpHJag+355d3Hujmi
 4PPPNENOE6Rv6vzqmPaHxpL5aBGvGYFzwsWokIt/qsr6V/6v/m8brb1WSpZsMtFwGjjE
 IAgq4eWxdbPeahifdZD9Y5YBKmV5o4SX0kaL2WNPE3Ro1C7R3C9tGWyfay1/m79qkOab
 FaUg==
X-Gm-Message-State: AOJu0Yyf+vyoZbK57gECZnN9rhf55y6W4vmNT5bRx1Z1nhDFAz/3jf8t
 CXmLO8/1RGj32c7kt65ZokjU64xjoRs+ni2rhuDkfYQyFgoXz2aCVhfUQRngX9t5RdqQ9mtQuw4
 EhOJsRU4qG3ducpJ5oTUA2XXn7/oLy8dd2sYyY0VkeJKcrz7wjQNN
X-Gm-Gg: ASbGnctLXiWpOOWLQpPNolpzUQJFVW+eYCAwvWLbGolBo86SZSRQiRo1QAOEIAri1Sl
 tQZAm6TLijpNLfus2uaVVYLNUSAbJTu8avEn1BV9omAJoLMlzZBPBjSA5UI/d0H2QVsT3fDrMU6
 znknlDHq935l0QTNNGB/IyFKp9JlGVWYbnzp+TmWrdarl6fxo9mgQphTgz3OxPfyJk02lygLMzW
 +d2HRwlf7AEbnXiE84=
X-Google-Smtp-Source: AGHT+IHq3GxvTBSbabrpnW2/rDRzEjPQIAzgbV/1n24GFfeZV2u0Dku4y9dGGOMu1s6ykaWGIxdFILEaBU2dv+W5UkY=
X-Received: by 2002:a05:690c:f90:b0:721:80a:abce with SMTP id
 00721157ae682-721080ab0eamr177040697b3.9.1756392367246; Thu, 28 Aug 2025
 07:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-35-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:45:55 +0100
X-Gm-Features: Ac12FXycsx_ZmeDvmAQl3HPvRdOKkdQthS7NWiAw3Xj096FEF0ZE_1bqBCuSYFU
Message-ID: <CAFEAcA8KkuLBBX2N95KXShO69mxgtMCeVgjZ7oaDQpw5SOa8fA@mail.gmail.com>
Subject: Re: [PATCH v3 34/87] linux-user/x86_64: Fix dump of fs_base, gs_base
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2607:f8b0:4864:20::b12e
 (failed)
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, 28 Aug 2025 at 13:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We were storing the selector, not the base.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/x86_64/elfload.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

