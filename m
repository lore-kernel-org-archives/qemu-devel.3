Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE83E9B26B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 14:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vutBH-0000S3-Jt; Tue, 24 Feb 2026 09:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutBA-0000R3-Ma
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:14:24 -0500
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vutB8-0005RY-1c
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 09:14:24 -0500
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-79495b1aaa7so49889077b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 06:14:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771942460; cv=none;
 d=google.com; s=arc-20240605;
 b=ZUGbXlp1Z+Z67CW1KLR8PrO+4qljQIWOzUR1V9xpXtH+xGIQkgLsfxSdVWPPhDbDTb
 1/bA9zfV8MZ88Hlikdt+TtdYE1pXjkIOdc8z3bqM6de8QQNokE2JSVoSFRHVd6m3XWeR
 w6DF/HeYGLtpmKc45AyZ/Xkob+rlNFpN9LJKJeWRpejRM/n3AAaH4kBZIGYW/EvLL888
 lKg1F86MmPWsAvNeS6h220P4NSk0zPxV3DOj7U7OW3uFMxB5GLtL9xnHQFcJBlFQfLzc
 FL76qTtjzqmzLUvBhXXUx7CAVCEA74yU/gRzD2+izV2YdT9+4u2U6MBhqMmb8x91NDEC
 035w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EXqdJS02i/JZarNlrJH/q5NZaHQwzIKmUgSq7tphkOs=;
 fh=i5SkGeoft/qBgEDQ744B1k5cDX9i4RU/+cCDlJSQtYg=;
 b=D8yd64wvyT8+/gD2B4mFbNaAcUAqgAaFYKeDVRpsKJfsxtBf6WbEIsFKMCbsUd/ndq
 e7SX0Rx/n64gQKg9JMoPY/uk4cqWFpSO4kX3w1lXsSQcvmtMjR+TB6avVy3rZSr/b4dQ
 j0TRQXoHAKLkNg8dQ6ZgRKrY3e7yeX0sHX2f+FMoZ5QB5f1MIyioRR6RoMqfCPbt9NCU
 zKTy5d+43/5DNNowQf76jp7t2b1IlcaTsuh+SPSAvW0ClsT0qp1yXeQEDJowNqvADUeK
 MvMCkewNEu11JPAQSRPAR3oKClYMdh0M6meayb67xfTwCj1CxkzjCCb3/x00E7MjjQM2
 KSvg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771942460; x=1772547260; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EXqdJS02i/JZarNlrJH/q5NZaHQwzIKmUgSq7tphkOs=;
 b=BO0v2zmMudduqRK7V6d2GtGs7tf7/4pmZ50op4mSiDFxdTlPIEqXPVZIuuUxCHJCYS
 18jWWEra+DpattoSw56Ovg/j1SsZNuZKdg74AIYLPDYadE4Ap4JFPClU1hPRmCHd4UGQ
 /5B6JsSkJdCiFYeSWJrN4oO1mnCXCr4iIekry1etZ9lzTqiim5JJRivRex4qUKyOceZO
 wPOSxmJgLaRY7wgsp+3R1morvJFY2kHkXM42A9JggCaq9UYt0GubQekRRHm6bbfQ/ybY
 Bsf6Rs48Qzq8W4ObCB9TQWNdsBnVkAZDrAlZoKhS5ozAVV8PW3t50FNCk3q2guyt4E3j
 67UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771942460; x=1772547260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EXqdJS02i/JZarNlrJH/q5NZaHQwzIKmUgSq7tphkOs=;
 b=Km68zEjNuyFh3E/Nr/FmtoiWfDvJF7hwkWRhsWjlPyDwilYEa6o4MXuXib8teB0sNo
 sFCRVcdrJyCfB9rH1/T9zTeDw4XJGDvo1Jbm2NexvkHkcCGD3TCn0eFGDJCPglD8tg0W
 1jAXBRAC67GRWHSbkkTIGjdwEGjJq4zP8k61qSF/Xjl974TJOJt0+7Wq+nUwML/M0JF3
 wwkF6KrLQhhnQsb8e/zTLwjoLBGagE5o3VxoYuRFbIdE5JLcT6C7DlPJlIX68iQ2EY+g
 5sB6bVXDxRSdECQ2WiXDYqhlVpqFoAwZP9tGEuk4IbLz1F9OyrYiiJDqACl8uGcPKkL2
 hYGA==
X-Gm-Message-State: AOJu0YxLRHUFbBWwJwoyPZ129daSRwVJhblUOm7ePmn/AdYNxkJMmB4E
 2prq0VcrM4IjgdpqPnyYejRU6QE1dEl7lF0fHM42JDd6NXQl83UrV8d1ztBOjg2JJtDfXFyHurT
 lQtGTtRliNxRwAJof/XWrtCIP9oYl9MDeweqzH2cjXw==
X-Gm-Gg: ATEYQzzgwUqWUyOgTAY/0l6HQFm/4PTlw4FbNZNPTy5QwqIUQfWgUKpRgSVxpYmnO5c
 GoVHzCI0Pb6it6kD4Aq4z3BXixe1hxT5/q8u61NMWR310fz3I7vmW8mkrN5PLdkbbNDyDPwWwkX
 Gsu1OI+LuNuuIII3YRgiji++QXKURd9AOZth8/GYVJjmHVapIOFBvyfCwe+VnBzgDSL0pEzDnPx
 FQkUxbq4YlNx2nWTkN4Mr09twtQkKKDRyrwiKijod+uNNXkI+uWcvKi7B9Q6bppPgQY8kX6kk48
 dmcX+1Oi1kFb8LLxYYejwey4KTY0aQKzvx3GtlnfSdskfomsHUmTt1jAKtpOYXIoa3c=
X-Received: by 2002:a53:ab4a:0:b0:644:6ad4:fdfd with SMTP id
 956f58d0204a3-64c78f6f89amr6995168d50.71.1771942459321; Tue, 24 Feb 2026
 06:14:19 -0800 (PST)
MIME-Version: 1.0
References: <20260223142031.1397832-1-stefanha@redhat.com>
In-Reply-To: <20260223142031.1397832-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 14:14:07 +0000
X-Gm-Features: AaiRm50bh1oBk0ck2is6DnC5puVTkXv15wRl72b5reLGfJhpGZ5R3O3IOYd471c
Message-ID: <CAFEAcA-XAd7e6XzobbdfFbjsS1rGNUy7dpLwAmBOtYqK_XJH3A@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Mon, 23 Feb 2026 at 14:20, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 07f97d5da04a9f97e273de85c76f5017d8135a6e:
>
>   Merge tag 'pull-target-arm-20260219' of https://gitlab.com/pm215/qemu into staging (2026-02-19 10:36:06 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 961fcc0f22768e7c3432fc645b93dc7cd4932fae:
>
>   fdmon-io_uring: check CQ ring directly in gsource_check (2026-02-23 08:50:04 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> Jens Axboe's fixes for fdmon-io_uring.
>
> ----------------------------------------------------------------
>



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

