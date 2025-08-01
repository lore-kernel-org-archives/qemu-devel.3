Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AEFC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvlV-0006G8-Ly; Fri, 01 Aug 2025 15:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuBi-0006vG-PN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:09:02 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuBh-0002ck-8n
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:09:02 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-71b737ec362so9495577b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071740; x=1754676540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=b8x8YGilbOWAgy8S+8PV7IuIH93DlmHgl6vZFDlG24g=;
 b=xiLMi7dZa8CsXfYD6mfJGXX+1WVVQCPBEXntMyhd7dv3VVKf8+0niE0eCsUGtCA+y5
 hdmcfu0iGQV+1gfspYApyJFNwuRxqb9WUYXuLhIRPlYG2D0VeCnZn5GKxwzqCMlserse
 z1uTkEnqPAUK5nMSv/081Qmr0n4jyj9kprFEHmv/BUBQNAmlgNwsvbjM0IFdKCJjHvvr
 IxMVsNkRQh/gDrbhJGU8NCCtjXQaWd52XCmh2HvSNbeAEiyPUA5pGFGadrBiQPhz24Uk
 +/g/Rb6/cHuSV1wbdeWFUSkHKLBWTU5We+aEnKpz1i6/SoUiyPX4xCQqjKBziRODAdKc
 S9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071740; x=1754676540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=b8x8YGilbOWAgy8S+8PV7IuIH93DlmHgl6vZFDlG24g=;
 b=O3sTjMyEqoLjPY/Hj/WEenWyY8SG6Bm+2i/kZkjKx6V1O5qgmAJPifle/MnWWi3Tt/
 SmkLmDRUZi7tjnSK/9Z962yfRC1Gpv10ouajncG9/NDTb85LP9dRDtDerNWENO2FXs+V
 Ek0iwOnm+VAje9ruHGWQQFA0P1TunBuqtfMygm+AliPfVo8s5YUp8YNzV3edPvD+wu1b
 g8x9wSBTVMU9TywFg3NoL/Cx0orK9GYzdN9LxmZFPDiRD1OlYNBVePreJ2/DKjGVFUt+
 uxNnoCbfFlI0+stKHmBSZ6yK/5VtF9X3ljNbog4ficpJnkpGl0MdZvjZtUKEHiJRH9zW
 T4EQ==
X-Gm-Message-State: AOJu0YzmXcgljPTd9b14KnTQFexP8QlU/VJevyZ+mMZt3gIvSx8Ouzzv
 GHFXBZMHlPyuPSL8kCN7onU00tyfheJm7wIV90si03xXkgtYoHsgeMjdPCMa4PyzFYBVGEMfXUA
 anylLcyigD2DbGyAlAV+tFLeqK7Vx3auX/vhDB/71jT8Mk0cgq4q4
X-Gm-Gg: ASbGncs5OO5cJm5sdkb6S5KfSoNQyrAQ1nJvRQbCuI/1cCCcU30fV9NaswqzkeWca/V
 JjLyfJ0zNB0FNkP1SAo5UIpsYQstj7lrlzJJcYggJ+dMemQ+2LoALXeSomcBxRq7OJ5CrxYLz12
 3oNtwbjFDquJf45ODnUnJY6MgiCi0IYgPO4RKVQtKrFPFZzD8xMKg33KaKIdP61TNz8PJF1+ZDI
 6pBDatV
X-Google-Smtp-Source: AGHT+IEdqjRvmVVsr4dR3WEKwCmVvpGBGlkBABm1J3oDIQFooWVP5JXMXSCn+WL+HmJFPMssWPTPhZearTQDdwlET+A=
X-Received: by 2002:a05:690c:387:b0:71a:154:f2aa with SMTP id
 00721157ae682-71b7ef5774bmr8192127b3.11.1754071739932; Fri, 01 Aug 2025
 11:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-58-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-58-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:08:47 +0100
X-Gm-Features: Ac12FXxnM1kepz50iBU7mDgayJn8BjMDOYnDFdi1Aca2gD_ULz1XjyqLj3YTS1Q
Message-ID: <CAFEAcA_sartr-MVKVRre+8G3+Q=wdwTV9SwFhD_nJ1MkZFCEUg@mail.gmail.com>
Subject: Re: [PATCH 57/89] linux-user: Move init_guest_commpage to
 hppa/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 30 Jul 2025 at 01:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/hppa/target_elf.h |  4 ++++
>  linux-user/loader.h          |  2 --
>  linux-user/elfload.c         | 32 --------------------------------
>  linux-user/hppa/elfload.c    | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 35 insertions(+), 34 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

