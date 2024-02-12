Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EA8C4829E
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 18:31:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZb5l-0003eC-Lx; Mon, 12 Feb 2024 13:31:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZb5g-0003dJ-0j
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:31:41 -0500
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZb5Z-0002rz-Kq
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 13:31:35 -0500
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2cf1fd1cc5bso44279181fa.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 10:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707762690; x=1708367490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PtMWUyuGF48T55SkyKDLKq7rMhjpk01/Vrt2XC+FTU=;
 b=NBj/sfR/m4FfXzGzkdwvaPMJLHUWACvjEDjhb8hw75497z4uPPzSXWlBX85zfHw7OR
 KzbOgGC1sveyNKvlU+FQy3oxeZguys2ovIejvSn25f9/sGSVA62XifhWJAqBEhVAny/a
 JJVx0H7pn/1xVUvy4vkb8khobaYC9IPinN/gPDm663uEYjVp2uF0vcq0AeByaDJaHxTL
 NPaRXchVu6yrR9y1JrMSJGUyYeBhZy6w+C/uoGWTTiwwSAqJ2w6gaGL3mF0md3GJMZI5
 U8bC150ZnkRtncO3btGDZwVxw6mRv7wB9w3FkHTV9L+EoIWmHXm+/72zK+PKNMhncNHM
 4GSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707762690; x=1708367490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PtMWUyuGF48T55SkyKDLKq7rMhjpk01/Vrt2XC+FTU=;
 b=E5ZV2yUE+J34av0rGTwjiJ/wBhXz4s0hIshQyQ1iO5pfBRe1/cDmAIk9Ji16pbKLMT
 YQqSBrasrp6xoanYfyEwN0pW2Ub29ToHx3p0q3zR6Q2eTZWQPmqG4tsSZScgfrI/wLHi
 uO/aeNwWTkBStqQ42tqprGpHkJLsweGEM3JN4LcpEg0tQ1TWVriuMGbjwrI2CpqQ+grH
 AgJkDNyYrAO9m1Dy9vPpQQAwYNzFK/2teZKMFBEl8g+rwtaVJJ2PLm9pG9h9ak1I3mGd
 X7N0U7S1+hlJoMRKN6+QGfJEL3vhywaG8bHA33kGRINu+4kIbKcdeXU1H3dGtB1lu+48
 ZQhA==
X-Gm-Message-State: AOJu0YwOTwZkelXvyz90PKqa9v3mXQp09T8kAHjtetNh51h1K62RMq1W
 P3nxUawJy2sacMCwmz1ZQSGmls1piwi70VDHeKmSEi1IVCBYDFlz/YdCbEQirrKaAM/e4C8dYTb
 V3dhaTD4/X4/sgsx0rs7ECUnal81GvfDCO96JRw==
X-Google-Smtp-Source: AGHT+IE3nJ9c6r4RrX4HhHOI1Rm+I07CKk/d2vjzZFQStJqIpOTMeWDklKfmYBQ/qvan1aMn66O/OozajJdyL832h90=
X-Received: by 2002:a05:651c:b21:b0:2d0:ff21:2a13 with SMTP id
 b33-20020a05651c0b2100b002d0ff212a13mr2071357ljr.32.1707762690377; Mon, 12
 Feb 2024 10:31:30 -0800 (PST)
MIME-Version: 1.0
References: <20240209194734.3424785-1-alex.bennee@linaro.org>
In-Reply-To: <20240209194734.3424785-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Feb 2024 18:31:19 +0000
Message-ID: <CAFEAcA9rSjhZoruxTvaeLas2a7AFju3ZAAOLqzfHhxhqBuQmcA@mail.gmail.com>
Subject: Re: [PULL 00/10] testing, doc and gdbstub updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22b.google.com
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

On Fri, 9 Feb 2024 at 19:49, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa029=
6c:
>
>   Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx=
/qemu into staging (2024-02-09 11:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-updates-090224=
-1
>
> for you to fetch changes up to 86b75667e04b49a0b75f061f589b3fbec3fb78f1:
>
>   tests/tcg: Add the syscall catchpoint gdbstub test (2024-02-09 17:52:40=
 +0000)
>
> ----------------------------------------------------------------
> testing, doc and gdbstub updates:
>
>   - add sqlite3 to openSUSE image
>   - mark CRIS as deprecated
>   - re-enable the TCG plugin tests
>   - use select for semihosting
>   - implement syscall catching in gdbstub
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

