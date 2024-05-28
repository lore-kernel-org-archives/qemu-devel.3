Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C296C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz0x-0005fl-Kc; Tue, 28 May 2024 11:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz0v-0005fO-UJ
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:45:25 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz0e-0005Ug-8o
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:45:25 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5785199e0d6so1451674a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911107; x=1717515907; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QbuCnmNTuvX5b2r3agw3dICJ8BBaGtRmibsL4YBvmf0=;
 b=E4RWkX+uMuI9XnJA4206Ak8wYUGrkiWxNXb6YcI2uIux12tXYGNOXYaoYJUfL34IDD
 NYuGBATFkHM5kOJS+69Na/1O9Vo0VQ++q1VwoX8PLsZ9kfWl6bUB5+NnrBGXmSeOiu4f
 tZpgJJ6tbvacgEgaLjzus1smVz7qE+Q5bivqQI6CwjU2C2MB+l+s+8rPfPxL7iP/eDLX
 TQiKYBLS7f6siYo0UhtR/xWYYIJ3uz+TDJcwtj8YNd7MHTRKPalXtzd5UxBfDqTUyrXr
 yP3uA5gqVgcvXOKXaw2YISE3VPkSIL9hTCWp/NGIkBDJsfsiOegucHh6vbwIRqwWRZRL
 STRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911107; x=1717515907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QbuCnmNTuvX5b2r3agw3dICJ8BBaGtRmibsL4YBvmf0=;
 b=O9Z0O8rbWB7LXNA1x7+dJ9u+daS4hmDxIg0xMW6TezIkAWcmLq8N45YC/wTEzK2GyM
 evG2ltho+ezL7MrfMeFcnhZ1Hba8VqCZf2pjgdygtnCsGLagaj0Hc6+1BenGqwbKWirW
 SXxkkxGAZaqQXgpar2knE8IDdLKyyC3UH2WRj7ogLB2XOBs/wb3lRA3s5jb1S4XRBZSO
 fjbzU+dXngv8ApNZduBWc+aBluUHcw/f0XNh6J3wZ8MJK1ykO6f4HH8CPnllzi9fWsnn
 vfY0esf/UPCx0K6K0EDfq31VLHoTRm8uxe8xfXi8Rk0cC2S4Tkw7DDOYDs3a3DT4c0e3
 EaBQ==
X-Gm-Message-State: AOJu0YwpE1sEJUszKtsl5PqubtvO/A4NrseV1PEKz0nJ/+WgpSKDqgzT
 cxOLYV9WA/A6S0/YMCoGU/cMMoPcFXUIvOKwG2/Y5IfmWAiFM6WKA1RB2x9hAmliH1hiCPq5boK
 dscHLUUUfQ2pSWfMlBMXcN7ToNn7YPZIZ8XAmSA==
X-Google-Smtp-Source: AGHT+IGzquVQOhZONJiYvtiJZX4SjvFzd1tbgULlg5SlTvALV74HhOGKu01A5AN7B/qPFxfv6y7OhMj44fLXPsWxcTc=
X-Received: by 2002:a50:d70b:0:b0:579:e6ff:c61f with SMTP id
 4fb4d7f45d1cf-579e6ffc790mr3838928a12.25.1716911106809; Tue, 28 May 2024
 08:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-43-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-43-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:44:55 +0100
Message-ID: <CAFEAcA9aNEDMLYt1t9H_2x3Ma3VpBOgs1EBAUi5E6rwEiMre2g@mail.gmail.com>
Subject: Re: [PATCH v2 42/67] target/arm: Convert SUQADD, USQADD to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are faux 2-operand instructions, reading from rd.
> Sort them next to the other three-operand same insns for clarity.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  8 +++++
>  target/arm/tcg/translate-a64.c | 64 ++++------------------------------
>  2 files changed, 14 insertions(+), 58 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

