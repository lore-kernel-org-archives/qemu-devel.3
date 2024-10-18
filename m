Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53027D2FFFA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 15:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1pJe-0003Gk-OX; Fri, 18 Oct 2024 11:55:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1pJb-0003CQ-Hj
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:54:59 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t1pJa-00021a-6r
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 11:54:59 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5c40aea5c40so4089613a12.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2024 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729266896; x=1729871696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wMZRgjC3Yokbg/ciiCLvi1/pIslAClVwybXh4127blc=;
 b=GDgfx5FDQvmusRPlNam2goDNUygNgOZhBinvymeUhwO6OE2D8B0Eiwl0suI94OWZ5w
 fOq6HlsQCT+Pa7s0nnL6hXda5bOZJtPK0jxDXZqydjzb6ZfDsqSOTuoojbIme0kkAVne
 Evy0xtGuKEu4uuunYmHp/Grm5h6BAMzqox9U+G5dNldW6umzsXarZK7Yz+C3qrq506sZ
 j+zSKx7oCfWPmOwH9ZfVn6PWOh9PCrgFvx/XjU4XY494LrzDeHOrK100Mx529qBc/45P
 mzpUPzG35cl2+J5SdW0hO7bUjjQ+URvdtlXSz7ruwDr9S/7Fz0XmPS3nrubSroZjXxBq
 kkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729266896; x=1729871696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wMZRgjC3Yokbg/ciiCLvi1/pIslAClVwybXh4127blc=;
 b=qL4Ql5OSZG1AjHn2lp4o8kkaU9/RN5U7UYs2VgTA1VOxJqfaBRSs7veYP+epBV6Bp9
 WrUlQ0aLPx1HPQFK+EmXRRZmouYYQKgGAvheaxx5JUSBthAZzENdsZjZVotsz2GWnNZc
 zE4FpzWT+69/DF5UBSL+5mgUeoS5mbKrVPsl8lM7iL68fMPJaMw6tOyXPFHtyUBeuifr
 T2WCbTqKjzyEF3zUo6WBf4ELjkAKhqOOskBJdsMImUbpBz6gdqWA35bu+UsGfxrTZcK6
 f+69fzi7AUqUxwXzP4mjXLVGTFA8XDWH4BHKz0y5nVMHzfY+sNvlZtM4XVwUaM6CD5r7
 LtUg==
X-Gm-Message-State: AOJu0YyPUn6PgAeQ5Zs7Vpakr4Kae67hs9WdKMVFdttD6izA+x8l65Z6
 RxDxWgpyRHNv8U2GNWHzeUaTRMKVLFQSJA/M39PRUd0ZjR2L6BXVvpFU5bZGlmp+MoHZZTV8KYI
 Lh6NngmNBn4r/Gvb7rNvg32PiJxnTEolk5OWFpE9gWsaVCNPF
X-Google-Smtp-Source: AGHT+IGierd9Q7RD59ma8oFM8dPzqZIhzI1b3zzLY9kIUhKO4zFcXWILJ76YDScrsIOQWYNmv+MYjo4zdSG6qY+i1xI=
X-Received: by 2002:a05:6402:26c3:b0:5c9:7f41:eb1b with SMTP id
 4fb4d7f45d1cf-5c9a5a56109mr7742126a12.17.1729266896161; Fri, 18 Oct 2024
 08:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20241015113705.239067-1-peter.maydell@linaro.org>
In-Reply-To: <20241015113705.239067-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2024 16:54:45 +0100
Message-ID: <CAFEAcA-o_J4UgpYW=S0kHS2J_oDPvNre7uFCbEMCe8ACPAjqYg@mail.gmail.com>
Subject: Re: [PATCH] tests/qtest: Raise the ide-test timeout
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 15 Oct 2024 at 12:37, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The ide-test occasionally times out: on the system I run
> vm-build-openbsd on, it usually takes about 18 seconds, but
> occasionally hits the 60s timeout, likely when the host machine is
> under heavy load.  I have also seen this test hit its time limit on
> the s390x CI runner.
>
> Double the timeout for this test so that it won't hit its timeout
> even when the host is running more slowly than usual.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

I'll put this into my target-arm.next queue unless
you'd prefer it to go in some other way.

thanks
-- PMM

