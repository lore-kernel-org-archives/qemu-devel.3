Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE343C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6d9-0001s7-Vy; Fri, 26 Jun 2026 09:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6d7-0001rO-09
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:30:01 -0400
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wd6d3-00050D-6b
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 09:29:59 -0400
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-80b9993928dso9313647b3.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 06:29:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782480596; cv=none;
 d=google.com; s=arc-20260327;
 b=QSiix6rdp458k4lvZawm13eKsLbanYqusvgrwSgRsKEEe/lRRDM9ONvOjev2mcdX2v
 vokp43XaYnqWalsgKTCXeikgDGE++rh9aijX7ERaWu9ktx63Gz57F+/CAtZurZKvpimE
 I5h4wObP/WwM0vV4IFjiyOETmt+mf3QQGYQvkugaP/nLeBRZz4XjX4YsIqxz2Hfyf7q2
 SxporkgebFF0uakdNr9x74kPg6OMiNFkSkaVBRgDEx0mTOxHKNQJymAu033Dumwu2JM7
 C2g23UX1m1Y+FNGoAFdlyfDhVWnMl9zIRI/XqHEKfUTdiClSszj22KWtHtp9GrM8eyh0
 myTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AB6XgcnQzk3zBCK4Lj2CcXGmBM3Joo2qdjyStFw68E4=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=mTVB+n901L1/7ZUzqp0rVkBwYf5EI4eaXbYy3g/VPJ5Ho/ZC/NABVH65J7TAxvwyal
 jqD1TU5jc4jzrYbNrN6drFGHHp8s2vQEH4GTyJLM11JpoGBtta32lPiW2BOqA9IYvMy4
 GprF/b0FrZMUqIXTwXompdfqD/IbXWbJt38sAik5EK3v5fc7jcsnvm4KobCYVozvrStl
 Q51AKO8uW3BW2x77RQhqzta2hdse9YFNMivRiTM++4XzY3XaABChbtu06cqtCLZ81nQ3
 ApOlcrN1sX/5cp4pklq69u9IneKZH6QT78HufxOtRUTzssebHHQuo8Mpn2Qd/an5oEuq
 YnjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782480596; x=1783085396; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AB6XgcnQzk3zBCK4Lj2CcXGmBM3Joo2qdjyStFw68E4=;
 b=O2GEe/O+djoVuSMEd255ipZKtWmfB6v47ZY+2MvioFk1bzC+RCZOs8z38NLpDu+Kcx
 m7HLMX+y++10i9SUSVEF6HVbrtwxkAFOIMHSkuxxE8cfGTZW4neh2t96L9CNY6qONNzw
 Rp/2BVtr/Fj3r3hn9DMb1BImVx7PvpiT6DiRx2Fdt0MolbwHK1h9SYYNWeGQuztC0XHA
 E4eLXYRWiGBy2+lp46qW+0/Cw6BSFhKXMVfHyel8VncKAZY8xvuiUzPEhOMjlDfGdhIS
 i5GSZuDEW/cmZEgNctcoqTMdySG4WSNPHQpFYVrWAdgx6HmfrB27iIKkgwFPDgyklDHy
 Omog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782480596; x=1783085396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AB6XgcnQzk3zBCK4Lj2CcXGmBM3Joo2qdjyStFw68E4=;
 b=MNTwfutwTn+vM/lw1VVUtbNURn9aSZk/ADLh596GJNaXsbWyyZGqZpT1WkDaG9gQH2
 wlb4AirmPum4sYq0NhIwLZ60Z6Mlf+9fR+Z4qg9l+Nn8wBEbFILLHE8DwaHi6fG8r9la
 f5q9EJ+xG1EeCXjOpzXMUmDUvsJEnTzTmv9rnys4AMAD8ifZNddIFAjVOpzLgRyi06H/
 OafEvKNv2dbEaXjIhogCMM9ico0baGFdbo6nVtZBPFqVF0mQNBeYkeTIYq4gcbjgH/J9
 UAM+GuEKDLip/lq37kFtEhH7GOHVZmqZ2ur/q/WBKdrddMIqzqBfsjV/UN84ZOwJNj3p
 CSog==
X-Gm-Message-State: AOJu0YwAy3bzZWHEncDS7wD+twwclth4yp+P8AHqq9b8cmH8EQ48cOY2
 Rair2dZBHuVSP6ryvgrEkZ4gQhOj5ysDPvv5/w899qjJTa7KgoFCm1MrfBT9tivVhPAsHPH2ESr
 7Wvtm1zXMmt3UtMOG7Z1nGAuDtiofPhDXN6Bxmvxzcg==
X-Gm-Gg: AfdE7cliGMEMBg+GtlBjf2CezMD/5J7yxgKbutcn/UNtlc+uCHWDtVXrD50mc00F5Wo
 ehj9lKVHQ9kxSaJp6XuEuNfRoj7uQ4OLw0fN5IMQANJyzSRgxBmi0ZzxQwgYB1QJNumZLUkJBme
 tz/y7QapO/ui02tu39h0EF9Ew0b4eEInykp7YZ50Yx7eiS1NT0gt928DL72jKYrZuUStDLtyf1o
 hU2QSdwdqCRjcKH1lss8NcSA9NRQ3HAk8BI1p7ZPIz35s7cfsvg0ZFVU13yvfjSOksFeCwvxyzR
 bqy6gsadIp56pPi87lRzE4uNr+PWjpg/kBTZ5sjjP0IyfkrqRm6JVr+F
X-Received: by 2002:a05:690c:e213:20b0:80a:9f1a:d492 with SMTP id
 00721157ae682-80a9f1ad692mr43590917b3.53.1782480595976; Fri, 26 Jun 2026
 06:29:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260625223200.763198-1-richard.henderson@linaro.org>
 <20260625223200.763198-16-richard.henderson@linaro.org>
In-Reply-To: <20260625223200.763198-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2026 14:29:43 +0100
X-Gm-Features: AVVi8CeSci9uSgJtQHbN3Ifs93zAqLRag92uIWWUFrhVED8qeOrfpXu-tgT7ggY
Message-ID: <CAFEAcA_COyr11t8GRHud-y+u6gXnk_sbK9ZD9=fdp96yppdvWg@mail.gmail.com>
Subject: Re: [PATCH 15/15] target/arm: Enable FEAT_SME_MOP4 for -cpu max
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1134.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 25 Jun 2026 at 23:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

