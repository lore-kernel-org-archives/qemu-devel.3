Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E6EC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:36:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvYK-0007qJ-7t; Fri, 01 Aug 2025 15:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtso-0000Fs-2K
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:49:37 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtsm-0007LC-Lj
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:49:29 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71b5279714cso15933907b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070567; x=1754675367; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pCh/GAhEPHvLkaZ7jNZ4V8T2R/wYguq05uTsCvUZRMk=;
 b=PbXBtwoCLGBTJIiRUtg4RuT0sDuypUNXzX0w30JlKfp5zXFsQik/DaPTls3j35Ov9x
 qZjB9y3OL6hnRC7N3eyRtB8qi2LovxUNKuJ1MXzVnyJ367TXZ6FpD+21PB9KIawQrMWo
 ulflK5drBbczAEaPL9+ub0P+Ql1h2ndpip9UlIvJV5E5woPZ9jy/50WBRCJi6jF+qXuY
 d5+/wE34MRekIhNdlDlbADDn7q7kmN22+w8RIQco9H0U28MmNH+PJIQo4bZltuCiYZH9
 ucs5TlfUGLHmqATDwmGad53T72uMzPK0kvQDsGJVJeI9qmM8mouX1vxVvPyAa4EAEbj3
 HKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070567; x=1754675367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pCh/GAhEPHvLkaZ7jNZ4V8T2R/wYguq05uTsCvUZRMk=;
 b=aY4EyoM4ObhwL+6UTEGpFYWeTxD9en9Ld5FnFgFatNJaXeV65oAreOQp7WsCKfQ3Tw
 d+s54x6O8DhT1LSDhro7/6Rkn3WW5Hh/Xwpy4K0Pa2YPnHHnVxRqsWtpF44uf6OikTq3
 In7YP1rCJQ9uDWm0sR4+ZU15Xyhq4UGEEPvgJgMl+n3fpkiTSzcghdKjfZXVn/Pl2vsx
 UcTTLHzpIkZOI5hBVfTBvXsSOghFisXUZfJePec58754qEzTlqqsJXbb2DBWUI8Mz4po
 oMqBM4qNnVHy9Oc0kMYPOk3WovAGSNgXwyaTJNtiT8l1Vo39AtuF1Zwup4to6A1K6XAC
 RY5g==
X-Gm-Message-State: AOJu0YwkiXYoFpc49ny3RSnpYQLaeHZomJ2JZ8n4CDwyc72uBIPJ4ePO
 3SX35rblVgu3qdlW2/8aRsHVCbp8gzU4bwjxcGaGXO6NDARZsUVXwcmgLZX/NR0ScXVXb/O9X50
 3pVL/hO96Ik/ZOKpMlE26DTfedB4vsy+2HWhJhX2glg==
X-Gm-Gg: ASbGnctmo6gT2yjUgAfMJPwSYd6pEKCrqOQp1XNndvbAqq5JnD8383M+H3wfu3UNC5S
 v8yTi0vVsGUyHBhJx/DGsmnoYvsvtIoKn+1LSB0a3V8Ds7OEsEQJN8HpvfEt2DFBITKf5sriM2l
 3RFjaqCYy3JjyrYoC4lEhMbUNYxPaNEsirZej7aic2lVRfO6+GufNKhS9aUkrQTud7frYcBAYyn
 1k/Wh+f
X-Google-Smtp-Source: AGHT+IGQ7lAAdTXUa+lt63jeHsVBXi1h6zj01fmPg89bYnNLblPxWbQMJt63toMuuxf0lqf5QvvfdAeJm2yyB7z2xOE=
X-Received: by 2002:a05:690c:fc1:b0:71b:6ab5:1db3 with SMTP id
 00721157ae682-71b7ecea04dmr8569337b3.6.1754070567181; Fri, 01 Aug 2025
 10:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-51-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-51-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:49:16 +0100
X-Gm-Features: Ac12FXwx0wlvSDNeffy8-MjqjAcRH2xO8XdspWAH2BABJ6rwwYxJGIklMmO0yUY
Message-ID: <CAFEAcA_i8k2AvKnpm6fHV1EsvzaHf-EQgkr=ePB=LsWLWiKVJA@mail.gmail.com>
Subject: Re: [PATCH 50/89] target/sh4: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 30 Jul 2025 at 01:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Subject line should say "linux-user/sh4". Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

