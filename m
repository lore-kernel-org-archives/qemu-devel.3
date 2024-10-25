Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF0CD0C61A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 14:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4LE7-0004PB-Dn; Fri, 25 Oct 2024 10:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4LE6-0004Oe-4N
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:23:42 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t4LE4-0000wW-87
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 10:23:41 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c903f5bd0eso3983683a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 07:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729866218; x=1730471018; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLMYlHcdvCVqme3C29S30Xolv4HvZ+Z8lZg76ycL2/E=;
 b=hKcvEo4TAJ2IyVNHAe7TxsN856oB1PnSW5LQ61BV4tL2B1ZLoScWbUtecSxAyTTpvb
 xHX2bE3/zs6/EpDkeYE31NzcoN94hfWQosM2J+7Sj8WRyH1cT3+pjrHlpOR5A9pyqNjL
 isF4RfYaGcfhJQlAQBKid5vSDQXtQg0UFvrvJrzzLwMQu3yHsnEvrtdU43ct1X3LRSCZ
 Pdln5cOizbIqW843GvKb0/na3SuyPCIiHvIFEoBW6MUQ5DBDOiyFzTtuiMHJJVSxNXR1
 bbv+4RSHDBrcnUmDOY7PS0gLe/sVN1P7fZ7UEujCgwOyO5QvM1jQJWbUE19+VbO+781f
 i6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729866218; x=1730471018;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLMYlHcdvCVqme3C29S30Xolv4HvZ+Z8lZg76ycL2/E=;
 b=CsjEgLXcDvFLBpQQ65SVLVChM1NSlRsITSB5iLS1EpVgRbOCgysoKfLJLZH3AybvBs
 F3j8WEUnpgmisRVVBHhQGtepYnqxwVNz5JzWzeEHpX5uJGcLyMI8zcy6PqHd3pMlnSBy
 +aIg22n14wipAHqrWZyjDWs4d60XlQwft3AolQUN05iC47zQDR7uJehevJpyxwBZLUYR
 rLePfqoUdQcQHiVSirTWVsIVWAIjWM2DuJvsZatcE5k/0qE6B53uBzoY3whLv9p4j7mH
 1yFrIx9i4vWuXhkTs8dyjOcrJQPVQfCwA8ZDehbponcewNKKvBqChnnQY1HMAytedsCN
 4gfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB7ze/1iMFPiT6KfKlGZWuEchjriGHr4WWzV6IN73DMnSaktFM3achPiaWldkoWySMxUQ9XMVxGqKs@nongnu.org
X-Gm-Message-State: AOJu0Yw1mxSQj6MMW0gOWi7dPMzqWPLr5OKSiC1hMqUNd34Gl2dHih6U
 0PiBP8Njt0asm8KcqotE6ejZlqA0b8IX+zHN+MwYTmiXkZSRl9i3lUHps8heOPeAjYtjwyL11py
 LX99O5p020jI0GywPVeFUA5Pa2EGz3bKy3YdqSSq7yRjmrUQw
X-Google-Smtp-Source: AGHT+IHJ/TOXpB93JBT7a0CBfROs1uGaXaY6tiywm+o+4MtMc9Ye0Jw+V35BtYA+QMdjODp+NYb0RPDnUwS/3bIWH/U=
X-Received: by 2002:a05:6402:3586:b0:5cb:6869:24b4 with SMTP id
 4fb4d7f45d1cf-5cb8aa4368emr7146380a12.0.1729866218146; Fri, 25 Oct 2024
 07:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20241024063507.1585765-1-clg@redhat.com>
In-Reply-To: <20241024063507.1585765-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2024 15:23:26 +0100
Message-ID: <CAFEAcA-Ee7Dw98a1AmniR4H0VoDDyLowYx=7ZZVC3iGvcNvoOg@mail.gmail.com>
Subject: Re: [PULL 00/17] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, 24 Oct 2024 at 07:38, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 6f625ce2f21d6a1243065d236298277c56f972=
d5:
>
>   Merge tag 'pull-request-2024-10-21' of https://gitlab.com/thuth/qemu in=
to staging (2024-10-21 17:12:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20241024
>
> for you to fetch changes up to 1df52a9ac0897687cff7c38705007b2b58065042:
>
>   test/qtest/aspeed_smc-test: Fix coding style (2024-10-24 07:57:47 +0200=
)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Fixed GPIO interrupt status when in index mode
> * Added GPIO support for the AST2700 SoC and specific test cases
> * Fixed crypto controller (HACE) Accumulative hash function
> * Converted Aspeed machine avocado tests to the new functional
>   framework. SDK tests still to be addressed.
> * Fixed issue in the SSI controller when doing writes in user mode
> * Added support for the WRSR2 register of Winbond flash devices
> * Added SFDP table for the Windbond w25q80bl flash device
> * Changed flash device models for the ast1030-a1 EVB
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

