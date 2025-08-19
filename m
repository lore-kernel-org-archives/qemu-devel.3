Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8312CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 14:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoNQU-0005xX-5f; Tue, 19 Aug 2025 10:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNQK-0005vw-B7
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:34:57 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uoNQH-00077w-Uc
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 10:34:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-afca3e71009so940034466b.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755614086; x=1756218886; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XJa0RDfxPtogaD/F8ZfiiXBNjguBmJbxPOmd7+KMC1Q=;
 b=RvPjHxBz6rJRINiMngd0lzTloHVAcz6hwd2B+nFrTpIArhD90lgYM+vyJthVr5i6mU
 5XDF12caaGQchWiFxXJmuGFHAc1Ywrk8QD6BhKcYy+nYoWnlO+tC4NLZB0NwI4o9jPQg
 py9kmEXFRLW8IhY1iSL7gMEVv9b+dtOJhRxehYhmovZ06AfCxS2lF4OhydDaYTh166Nz
 +U4TNNlksCKAankCcYyCGodEyVQSH1WnjszW2hlbWBKX4tGFtRwD5WEuoTrcZ1i8UxYs
 7HIkqfYiW3Q45oCLKM7m3rU9BNIpI5TnMehugeA3UC7PBknFtZLJbU/WRErV3iJ52XWD
 zJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755614086; x=1756218886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XJa0RDfxPtogaD/F8ZfiiXBNjguBmJbxPOmd7+KMC1Q=;
 b=P88CsMfNWyi0W/JcNC2L/1EpB9vfqwXEauE7l30YDkNQpyTzaasb7sLb9C7lPDRRh9
 MSVkCknjnxRvxrJLaH5yLNGvCRCgeDk4AX4ojzUhJvKGyfAcSkDB9RXkWa4S8okqA94b
 COskRCXNwvD98h3CXSmhvtNL3Q8up5+w2qimcG6OK3dW+vAqUMJJM8RUfJzqVsMxdJEX
 txfuNunQDYR7gBFByhwv1pBLmLkUMvKXcvJCcTDJIO7ykGtIfCwQLC2IOjqa8zhiDJTg
 3EZjSRVXa0HaoEfFqTbBEBP/SgeoIyJwyHfXFWl9/DvcN8CZONL63nCK5P4RpOouCvyV
 jxlA==
X-Gm-Message-State: AOJu0YwHZR8A3Jz64gk49J5t2JD9Z2uUrw1IqGHBZtRsmfFRRzsnIAnS
 5FVh+GxdIXjCxVFd68jqQAvpnbYb/MUNZNOdNbJV+3FAE+vpBnmx4u0u0RqSnVPfpsVQvYVMG9l
 LuxfBjhss55MtvtYQPt5CuV7nYXzFhSBrhbB3KwvCVA==
X-Gm-Gg: ASbGncuweIppZO2yKyKgZFuDz0TYEDPYwhmglquzcMNRR62J13+86snx2LoKM3Ldwzm
 X2ZL206U9SiDVzyu2/WJqdu+SYSoCWyv/0ehuBwDMh2tv2m9JKhuJbgId7++OgbgulnQpKh5ctf
 F4HlxBRthbgJQvrCW8s89qo3Jh75VfH3G1OiX8OkotZb7HqWazZpRd1+IoF97GqwySATkXWVVq4
 uRjCwoY
X-Google-Smtp-Source: AGHT+IHTmEbnqbY3uZIwBe+qAK7SNacJsMEXRYuVDOPUyUzk/KzX/DeqYCcjj5BQAy8PRfXUOE2O2baNRxUJJJa9LXM=
X-Received: by 2002:a17:907:7ba8:b0:af9:a381:aee1 with SMTP id
 a640c23a62f3a-afdde8c4c83mr287279266b.0.1755614086353; Tue, 19 Aug 2025
 07:34:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250815122653.701782-1-richard.henderson@linaro.org>
 <20250815122653.701782-7-richard.henderson@linaro.org>
In-Reply-To: <20250815122653.701782-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Aug 2025 15:34:33 +0100
X-Gm-Features: Ac12FXy0SIgoX-mflY909JneK68YyJ7Ee7i_vPYMmevJN-jTU52bOH4Y4Aekd4I
Message-ID: <CAFEAcA8E88Wz4mdGuTrqpUxXxo01ZPeKG2Yg4ygkqN5dwuGRWg@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/arm: Implement FEAT_LSE128
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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

On Fri, 15 Aug 2025 at 13:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This feature contains the LDCLRP, LDSETP, and SWPP instructions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu-features.h      |  5 ++++
>  target/arm/tcg/translate-a64.c | 49 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/a64.decode      |  7 +++++
>  3 files changed, 61 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

