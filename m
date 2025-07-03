Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27FB2C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:15:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXIqe-0002Nd-3G; Thu, 03 Jul 2025 08:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIqb-0002K5-MG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:15:25 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXIqU-0008Ij-Ji
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:15:25 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e7db5c13088so808695276.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751544916; x=1752149716; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBgsgIeawqL0c81jNvHXOOlPF0rya4pW0p9Ob7Foz/o=;
 b=pQw4eXDpn0KTHi4pOEMi8o/qAx0Den3FqcHUUqQ5Pk9aOarv2JZyWNONWtFmfsyaf+
 0Vj+dcOas9HWvgvxo3WI13DE5DrI0TXxrT5SkYr2E1k7h3qqbo5AhkmEmTTnzTSFPHnr
 bwbbZBgUMoBEfaGzqVfrmJUVWl0shAPhy6w+89bcCBvxC6xO67IsHgzMRd8k/uTxvQtS
 6qsX6WKHHfEIRwM7id2M0lSQn4fkjYqwq4ObYYbAiLWd4dZyZkiv4cFckn2WUugHObYk
 jmr3kXWG8DHlPL1BpaGTXv4kqF1O4I+YEUS/GDeg4gMufEefbAYYiGzpvMbQEFzA584G
 +bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751544916; x=1752149716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBgsgIeawqL0c81jNvHXOOlPF0rya4pW0p9Ob7Foz/o=;
 b=FzzIbZGsmYniPSvCq/6GlCDgAEaglHn/U4YQqaik8F3SGcbcdjvIpelNVKR5ejQQrp
 aVuq+uFDcvRCNq86O+vUaf/qc7geXC9lWg0ai6phOY7cLl8mBRkzpVC+1QneAtT6EgpE
 y+//O7yHl7Z3LXyMeX+nvPQCx6KohPWQJZMF/HYtgStlYqVDhRNsGBJzN7hCvFiW1qw0
 92CWPY7g5vuhuHEHuNxfr3/5cdXLHqjDhj492sKZr09Hp59DNK7YtIOPLp9T0suqCfD6
 bHxOhQJ3Ic496UCrj9rKDccJgYzfJ1X7WK51msMYUzKCpQ8lDqBLGufj+eNfJgkA4Ghw
 9e7A==
X-Gm-Message-State: AOJu0Yw2rlwMoW/3STpGXK9jYh2MuAHhIdLYJtuU9zjfPZB/qIlHt5Qn
 uFa/AeiRgcweRfS5ja6LWmSB2n6NtXC37oO5VPRMvNGmln9gGJjlFuNLQROPyPvEFJDe0Qd9Mnw
 oRzz+emrc/Qg5iPjmHrsKuTFRab0TPICzpPbfoI8u2Q==
X-Gm-Gg: ASbGncs/FciHieNEAl866Pufq5EZTe76iVicMGS8Zi3lsrNvmwEYhAZBSRC28fQiB3q
 YhNRlmugOwzTod/OmB7q/fqe/OmuMihUcHlxOiFpBvW4Flx+/LTHxLwz3SyPdtshm+Gv/YpcbqY
 jKPD3DKKYYy9R0d8uIHAOZtX6k7XQrDCqPzGzRivc8O9np
X-Google-Smtp-Source: AGHT+IFaL9TUUMjrUVZCCINqltUjMb33/wHq04ElBoqRuemk0p26PJkYAkIjpZLfQkMQNRdU2uCgyP+UdiKFNMgj8Gc=
X-Received: by 2002:a05:690c:3807:b0:712:cc11:b02 with SMTP id
 00721157ae682-7165ca32b44mr24996527b3.4.1751544915555; Thu, 03 Jul 2025
 05:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-71-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-71-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:15:04 +0100
X-Gm-Features: Ac12FXzFE_4J3f5FEw9PehjR0I9rp7xVvVcKXyjJ3Gn9iVhU-5dqMZtr_cIWaaY
Message-ID: <CAFEAcA_7dTmTB4xESb4nN3WqGCcBPow7pakq++vwrM3Yep7qcw@mail.gmail.com>
Subject: Re: [PATCH v3 70/97] target/arm: Implement {ADD, SMIN, SMAX, UMIN,
 UMAX}QV for SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 2 Jul 2025 at 13:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

