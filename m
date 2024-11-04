Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329E7D132B5
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 12:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wFC-0003bM-Ma; Mon, 04 Nov 2024 07:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7wF9-0003b0-Qm
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:31:40 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7wF7-0000oi-VA
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:31:39 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso7504182a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730723496; x=1731328296; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gDemWJWE8lg7jAKAObq5dpAy00HN09LBRil5goOtTIc=;
 b=EL8r+lBoZ8qE/vNY0m9MN3yTwq7G1iSwbqmCvN7ewnWL9b9ei6WWb1PgbogV58ff4W
 PJ1GHzHd8K0GyS7zhkMncJYANLckxx7W/Rp2IP3fyIN+2eM0nc10xK6VwLz1CAzh3W6V
 nfwWoqSJB2zu/26PX6BGRXh3Oyw46O3YrP2EpRJk2UEU0Sw7QasL+6wUykw+IuGA005G
 kGejrTQRIm28iG8bWYEhE+BguzNp2QLpJ3u215yP8zJRAiNlgL55hqtkb50vVc/HUT2/
 7uri/bY6tXFJmw4EX8DBqIVmzjVaP9keY539szEdeUNWqTBejBAA9D1dhrojtY7avpsk
 wiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730723496; x=1731328296;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gDemWJWE8lg7jAKAObq5dpAy00HN09LBRil5goOtTIc=;
 b=I7VaZb1FqrKRQuBWD9Q9M/YAvVXFTKKtRobrnFgb2P2Woh0u2ADg4j0s7CQvf5qIjg
 t3VwOObQ1y0TLVpHrzJYpLHKd2QCp0dFq6DnnBXxj1tWWBbPu6nfN73MGoNcHstbVRlk
 CDx8VtjU7OX1MC2yyn2Mezc/luQPbL8yu0spC48nrW4zu07xOOZqjk9q1knktQEdCBPx
 uBjxxiMAxMBwbPPHWhXrLQPjjZHOuuT1EYv4NN8ZkWWf7S9w+zDrot2OJeE3HeDT3UKg
 BO1G17m8S5ZoAx/F76JVaW++w6Ot/US/n2AnuiZkhRKK2Bxmy1zCo7fEZNRZWcyxaQhW
 DD2w==
X-Gm-Message-State: AOJu0YzlKxa+IwIh92KIWymfu7YjGQ8/i8GMFjjxXq0TcK5/3eeSNHcp
 NGFb0bOqT7Su80TrfSk+TTjICD56+ffhLkAcZ5PUGnU2oBUwvYzs1nuDhVoQWcCbr1M46xdatoH
 53STdTgv6bTEf3oaTdrcaRwo0DqzHM36bzs4EbSmAhBHsNWrW
X-Google-Smtp-Source: AGHT+IF5fuJp9CuKHWM69r6WjCJcWrddxTVkZ7ozT/Q19bvkq5NK6HrfidsHPmFMGHVrAoOTAsbVJIrvqDZaXlHcyvs=
X-Received: by 2002:a05:6402:34d1:b0:5c9:6ae4:332e with SMTP id
 4fb4d7f45d1cf-5cea967a284mr12832136a12.8.1730723496076; Mon, 04 Nov 2024
 04:31:36 -0800 (PST)
MIME-Version: 1.0
References: <20241031174832.6574-1-thuth@redhat.com>
In-Reply-To: <20241031174832.6574-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 12:31:24 +0000
Message-ID: <CAFEAcA90nvvYoK52Yv4kdgRwJ+WyFRP9sW_U0gKdD4reaUGCFg@mail.gmail.com>
Subject: Re: [PULL 00/14] Misc patches (functional tests, next-cube machine,
 ...)
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 31 Oct 2024 at 17:48, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 58d49b5895f2e0b5cfe4b2901bf24f3320b74f=
29:
>
>   Merge tag 'net-pull-request' of https://github.com/jasowang/qemu into s=
taging (2024-10-29 14:00:43 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-31
>
> for you to fetch changes up to d73ad1b1c0e62976d4790606ee29725a0d8a8906:
>
>   tests/functional: Convert the riscv_opensbi avocado test into a standal=
one test (2024-10-31 07:57:47 +0100)
>
> ----------------------------------------------------------------
> * Remove the redundant macOS-15 CI job
> * Various fixes, improvements and additions for the functional test suite
> * Restore the sh4eb target
> * Fix the OpenBSD VM test
> * Re-enable the pci-bridge device on s390x
> * Minor clean-ups / fixes for the next-cube machine
>
> ----------------------------------------------------------------
> Daniel P. Berrang=C3=A9 (2):
>       tests/functional: make tuxrun disk images writable
>       tests/functional: make cached asset files read-only
>
> Mark Cave-Ayland (2):
>       next-cube: fix up compilation when DEBUG_NEXT is enabled
>       next-cube: remove cpu parameter from next_scsi_init()
>
> Thomas Huth (10):
>       .gitlab-ci.d/cirrus: Remove the macos-15 job
>       Revert "Remove the unused sh4eb target"
>       tests/functional: Add a test for sh4eb
>       tests/vm/openbsd: Remove the "Time appears wrong" workaround
>       tests/functional: Fix the s390x and ppc64 tuxrun tests
>       hw/s390x: Re-enable the pci-bridge device on s390x
>       tests/functional: Convert the tcg_plugins test
>       tests/functional: Convert BananaPi tests to the functional framewor=
k
>       tests/functional: Convert the OrangePi tests to the functional fram=
ework
>       tests/functional: Convert the riscv_opensbi avocado test into a sta=
ndalone test

Hi; the opensbi test seems to consistently time out on the s390 CI job:

https://gitlab.com/qemu-project/qemu/-/jobs/8260596592
https://gitlab.com/qemu-project/qemu/-/jobs/8260043983

789/972 qemu:func-quick+func-riscv32 / func-riscv32-riscv_opensbi
TIMEOUT 60.04s killed by signal 15 SIGTERM
791/972 qemu:func-quick+func-riscv64 / func-riscv64-riscv_opensbi
TIMEOUT 60.04s killed by signal 15 SIGTERM

thanks
-- PMM

