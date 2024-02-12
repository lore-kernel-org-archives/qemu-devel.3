Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF13C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 21:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZdfz-0004gf-0X; Mon, 12 Feb 2024 16:17:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZdfq-0004e3-Dx
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 16:17:11 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZdfn-0007p8-Ff
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 16:17:09 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-55f50cf2021so4794519a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 13:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707772625; x=1708377425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ENiWN4qbQDHJoyKwNrLNrrZfw+FzETWpRfr4DmPLvcM=;
 b=zNEmT/2c2JHidHClpFYMGBlbuH/jxFcb4SvmEkK6MmJIAR2Oq6Z3JZqQnuk7ErVEoB
 Hi9qZlHDcYPg+I7PuB+kAwoZPDwtyHaqL2iNdTGz9oylm9A/DVWnrojiLNzU7HieWj86
 /aGSYSlw15y5RRXPe/iFg/OO3gtH3cv/mvhiqOIzRY72UTS0EdzPaOoW09UZWby06QwB
 21fdA2gZeglmJKb9mwAzyuzsIXND2BIVGu4bdeQjrILvzzvWHFCx4114RPLTZypsO3Mf
 qFM1Af10SBEalpdpWjuz0yniJVzDP9wdX8HLPzPWAHcMOUFraVXoPFJvPrb0/Df9CQoY
 u08w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707772625; x=1708377425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ENiWN4qbQDHJoyKwNrLNrrZfw+FzETWpRfr4DmPLvcM=;
 b=q7/kydkAA7cVh4ErJQmp8/e2jVUFBWOOrEaUK9k890IqlSjNCS08P+rIcJxVzRFthl
 wlRaxtKQxZEjLNO8Kwcv+ctj1NvcqxUPomTUqGn1yk9MORU6Y3kHfxk9U1dbAdAxFU/z
 pHFvGtK9Mz+wKpNYor1WdD1joqO4XqcETznlgXR4FUXDvqTyrK0XuO5LWgo/1RQUnaeh
 FvzzdE36ryWvIovfd6Acoec/PWYOTY0xedQQCguubcQ/yXGYfG0zRbRLkGvJHFdDHJ3Z
 GAqNDx3oH8BfH49vIiZeVV+Yo9bSAOWsqqu/hWs6soVnzRAqMAY/2Z38Hixifsw9Xkur
 bIcA==
X-Gm-Message-State: AOJu0YyPm4tGEdI9lKyAHXFLh3K5IOhO6jg7Tgx7eWxh5rcxhiESEB00
 HVHYuVkVI23wSuQPLHktFNP+3dbAGyS9jU61jJvog62rtcCfJY4V6KG6np20n2BzgpkbDHCLggm
 Pdre5Yx48OV8MRS2ezdvKFrgOV1azDCGZT+DoEg==
X-Google-Smtp-Source: AGHT+IETaCIMDMdxdX/fySetf1UeNxn1qTQmg7ckGHeOTx/CY12lpaM21wFHGfe1MTHF2WN9slWn7FDBSBcAQVWOezA=
X-Received: by 2002:a05:6402:78b:b0:561:54f6:4467 with SMTP id
 d11-20020a056402078b00b0056154f64467mr5258756edy.22.1707772624856; Mon, 12
 Feb 2024 13:17:04 -0800 (PST)
MIME-Version: 1.0
References: <20240211122909.5807-1-deller@kernel.org>
In-Reply-To: <20240211122909.5807-1-deller@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 21:16:53 +0000
Message-ID: <CAFEAcA-4ck9Ro-9x13veOqL-165i7q8w17HP7KDN_5uNj2RVEg@mail.gmail.com>
Subject: Re: [PULL 00/12] Hppa64 patches
To: deller@kernel.org
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Sven Schnelle <svens@stackframe.org>, Jason Wang <jasowang@redhat.com>,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Sun, 11 Feb 2024 at 12:30, <deller@kernel.org> wrote:
>
> From: Helge Deller <deller@gmx.de>
>
> The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:
>
>   Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/hdeller/qemu-hppa.git tags/hppa64-pull-request
>
> for you to fetch changes up to f9d2270c85872bd71a01e15b2ebda2569f17f811:
>
>   hw/hppa/machine: Load 64-bit firmware on 64-bit machines (2024-02-11 13:25:15 +0100)
>
> ----------------------------------------------------------------
> target/hppa: Enhancements and fixes
>
> A new SeaBIOS-hppa firmware which is built as 32- and 64-bit firmware.
> Necessary to fully support 64-bit operating systems (HP-UX, Linux, NetBSD,...).
>
> ----------------------------------------------------------------

This fails "make check", eg:
https://gitlab.com/qemu-project/qemu/-/jobs/6154451100

because when the qom-test etc tests run qemu-system-hppa, it
barfs with "qemu-system-hppa: no firmware provided".

That kind of firmware check needs to not fire when
using the qtest accel.

thanks
-- PMM

