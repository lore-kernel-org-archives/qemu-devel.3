Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F01FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfAj-0003Hc-DY; Thu, 30 May 2024 08:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfAh-0003G6-4u
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:46:19 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfAf-0001rx-JP
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:46:18 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-52b7d180542so936549e87.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717073175; x=1717677975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PDnspt9Y6J93/QB9bJRIalN6qBOhNzuzk73SyZONcJQ=;
 b=aGT3vsAOekKIKOucud4bhjc4HpNSMzr3rnSJwwMIHhK9qO3p8KUL6+RYh2wavCQcuH
 kVZzdabN17XNs+r0K3nN9BAyekbqv58882wQTO4Jv9XfcRsQrmut6BYV8BtOmvqVaGnA
 B+TOoTJ06qLRK/y0rEPuvKN8rEo8c+jEtx4F4hZwgiYgiTJd4CPQXiHJ/lGBAuejljkx
 a1Xi+rRNlPO5RmqvhzFMU7QYtQQCWa7xtxpHxQrqcNq9xR/eLOu9IWntQYcou3a7J+cO
 k2LPxE4f34FbPqrRLPEUVJ+9nw+o2dt8uZ4uqtFUafF2fJ6dpj20ztPwQNvvBr96Dpch
 BbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717073175; x=1717677975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PDnspt9Y6J93/QB9bJRIalN6qBOhNzuzk73SyZONcJQ=;
 b=cJMGt7ev7iF0e9ysbhQlPqW0lGRIxekfKNAu9GBS6cjMCxwJ3ipFSqteO6UUxAjUOJ
 G2+1BazHGgnf668rfndczkTJnOwB//vPo9B5nB+5KOrByJlaq7q2BI2AeAX38xKox5Wt
 1FEKTvvvOiCXU2W8WGdR6h0gNj4En0VnQ4JEB2kmHPv0tyrbK7R6bknD4ZaxYzfWhjz5
 apjPkFhlDwemyKbFT8Ko5GIsqpjXSS2LTydslNgEAza0d0so2zBtliabkdYdPa2cntbv
 522lwHYW4Kj/9b/1ad9AVoQGQGe3HesYb8bbn36BQ+F9zBOW87FXPf3hJQ6Qz8OxGpQT
 U7fQ==
X-Gm-Message-State: AOJu0YwHBZc6eBMS586j5rrDqkoLoG7CYwd/8kB5t6vtMDWydIXcjPVH
 mES9siMbGzRkLInV+fxast99CcbNYepz09YgDHBvI/wGX3wqjLbPLBNxWK4zK17xgozLW/+4UoY
 b98jdV1tzIg6PZ7f+NhZ1Lq56h3b9cI4+htalOtWTleUqrDyj
X-Google-Smtp-Source: AGHT+IGRgZbte4F8UMqqq73iVg104XTqJH7PBKl276ZZnet+wScaeIsRDynuN34FP1YYEGH47XSPosjz1KHXQSi07SA=
X-Received: by 2002:a19:e004:0:b0:51d:9ea3:5649 with SMTP id
 2adb3069b0e04-52b7d418f54mr1402790e87.10.1717073174942; Thu, 30 May 2024
 05:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-4-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 13:46:04 +0100
Message-ID: <CAFEAcA_cPWwSnVqXkeympb1Us2c58A49mth_gDeZ4dVjU5fu8g@mail.gmail.com>
Subject: Re: [PATCH RISU v2 03/13] Introduce host_context_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 26 May 2024 at 20:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Most hosts pass ucontext_t as the third parameter of signal handlers.
>
> In one existing usage, loongarch64 is using the kernel's
> struct ucontext instead of libc's ucontext_t.  This is probably a
> simple mistake that could be fixed, but the structure member names
> differ, so the change would not be completely mechanical.
>
> However, due to a sequence of historical mistakes, sparc64 linux
> does not pass any kind of ucontext_t to the signal handler, but
> uses struct sigcontext instead.
>
> Prepare for that by adding a new indirection typedef.
> This allows us to clean up existing usage with void*.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

