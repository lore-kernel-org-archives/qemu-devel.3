Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A283C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 15:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX00z-0002LJ-AP; Thu, 25 Jul 2024 11:04:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sX00t-0002Hg-2w
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 11:04:18 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sX00p-0005E2-Q2
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 11:04:14 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-368380828d6so736179f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721919849; x=1722524649; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M0ZBiu0UIBrAy27KVOIo2FtpnOh3w3wmUWh6fyp3ZWs=;
 b=lCdqeQJmZWXlqr6ZdqnwYgoKTKF1XGbKhdbpEHMwizBIY3J1mwBX4C1rKiLflU2V+q
 lg1y9ycVJGoAzd3VKfxctUnU4PoqNgXEY6dxQGmMBFk6N8tguJjoMnT8HoIbDpSef7Xn
 j2dvOKYYveKvQ/Q8+ZCPwrjnDFejc9mGOWbcY4l1CeboyeLmaK6hUpgPL6F6UmQHYpu5
 QZkpgUuqn8s/kNSAY4QxY1lGS8HNqXisEPuYg9s/X9pRvA+wNcjtmADX67h5MEUJG4vs
 niNqgcbQqDlILPy/IVgAvJFpq836hY2+lC8kQmkA/JhgfF7bHYlw0r/qjrhTPgP52dmx
 NmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721919849; x=1722524649;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0ZBiu0UIBrAy27KVOIo2FtpnOh3w3wmUWh6fyp3ZWs=;
 b=u6GweHfwI9PUdM8HR4VhPDOJfG/EiFNHJYEEZN9gALdKN6KY4Mk2XFFQux20VG33Y1
 Ce8+PcV7FQhs/ynBpmi+0m3vpOGDh2x5014nWjB9ACciwVpVCa0nBFqFoGhLk3Gt83n1
 GnXPGBYO43eLV+Ggz474BxIAyHNVof5fTzuvd9DduWZ4PpTWNV4tGaHeNMmCv+NErtr0
 VCKzcLLPdFYLkAyC0HmMwR/gxfru3u0nlfrLHXIOBGR4NcyCNpAAvPmH89cGLlULV/1f
 waPIWIFZN8oDMsZVRpFYiHWIK4FaS2X/3TKBBbvEyFOJApxhv8I0wbVA6cvKzlb8vYDy
 Q6/g==
X-Gm-Message-State: AOJu0YwhSn0hiOLHj/eY/HWyGNcAytrJVFHUAZzRppmmHG1a/sdn4BNc
 YLmf07GUCEIO8Nd0X8DF3unJKlyN6u6yRMTz14wd7mCsnx8BESRoEwJpCNV8+eVo5fZCDoQwk2T
 QvDJVzWtIuGr3r83gqTzbUjy2+tSgWHLdgnWSMw==
X-Google-Smtp-Source: AGHT+IF5d289w4enLEpITWJWGjtN5chSOGG3/KJZo7vRW/ExRUECmR7RGHRkDk8wmxpFaXAK00HhD6ahC22MhGa9BiE=
X-Received: by 2002:adf:ef0c:0:b0:368:65ad:529 with SMTP id
 ffacd0b85a97d-36b3640d05fmr1628812f8f.17.1721919849255; Thu, 25 Jul 2024
 08:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240725145904.421456-1-npiggin@gmail.com>
In-Reply-To: <20240725145904.421456-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2024 16:03:55 +0100
Message-ID: <CAFEAcA-0NYucDhyLEPok+3DfxGHrYKpXHfvK+LjrfU+2CQwPnA@mail.gmail.com>
Subject: Re: [PATCH] tests/tcg: Skip failing ppc64 multi-threaded tests in CI
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

On Thu, 25 Jul 2024 at 16:00, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> In Gitlab CI, some ppc64 multi-threaded tcg tests crash when run in the
> clang-user job with an assertion failure in glibc that seems to
> indicate corruption:
>
>   signals: allocatestack.c:223: allocate_stack:
>     Assertion `powerof2 (pagesize_m1 + 1)' failed.
>
> Disable these tests on CI for now.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> gcc compiled host does work in CI, though I don't know if there is a
> simple way to test for that in the makefile. clang compiled crash does
> not reproduce on my local system / compiler, so progress in debugging
> this has been slow.
>
> Thanks,
> Nick
> ---
>  tests/tcg/ppc64/Makefile.target | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/tests/tcg/ppc64/Makefile.target b/tests/tcg/ppc64/Makefile.target
> index 8c3e4e4038..d57f9338b4 100644
> --- a/tests/tcg/ppc64/Makefile.target
> +++ b/tests/tcg/ppc64/Makefile.target
> @@ -11,6 +11,21 @@ config-cc.mak: Makefile
>
>  -include config-cc.mak
>
> +ifneq ($(GITLAB_CI),)
> +# When multi-thread tests are run under the clang-user in CI, it causes crashes
> +# in glibc, so disable for now.
> +# signals: allocatestack.c:223: allocate_stack: Assertion `powerof2 (pagesize_m1 + 1)' failed.
> +run-signals: signals
> +       $(call skip-test, $<, "Broken on Gitlab CI for clang-user")
> +run-plugin-signals-with-%:
> +       $(call skip-test, $<, "Broken on Gitlab CI for clang-user")
> +
> +run-threadcount: threadcount
> +       $(call skip-test, $<, "Broken on Gitlab CI for clang-user")
> +run-plugin-threadcount-with-%:
> +       $(call skip-test, $<, "Broken on Gitlab CI for clang-user")
> +endif

Please don't disable tests on gitlab-CI only. If they don't work
in the CI then they might also not work on the user's local
machine. And if they're disabled in CI then they're quite likely
to bitrot and then a local user will find they're broken for
some reason unrelated to whatever they were doing that made them
want to run the tests.

Also, if we need to disable a test for some reason we should
file an issue in gitlab with the details, and include the gitlab
issue URL in a comment next to where we're disabling the test.

thanks
-- PMM

