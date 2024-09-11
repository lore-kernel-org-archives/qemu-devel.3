Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5246CEE499C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 18:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soS4X-0006NR-SW; Wed, 11 Sep 2024 14:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soS4W-0006Ms-FE
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:28:08 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soS4U-0001LW-Rm
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 14:28:08 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5c26815e174so109885a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 11:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726079285; x=1726684085; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TRc5yra3lJIAuAXx6V9Oj+mGANIpv4xZR30cYj1JhY=;
 b=ZIhW2XZpiSNT/f0IBvnGjhqFg1vo3/g6kVnjk3pyNfsx4QwpuVwmHZSsPYTOgLlaKx
 b5MmEe00qYrUXAan0F9bilhsVigT3tqidPzeynRLxGV6i2v39Sf/ttoPEoG0VJ05szoY
 52tMpSHUC0PUOAVn3dLe+Pv71bsEkxhLVN8PzXKtCpZF3nm17wJFI/Of04wYdDcBGa1r
 /Qj9CDr3J0iQ4oS25w+qDVfTIcG2oV8UN+HiVoQ1nUWiP0wOxzNShGy4KaQk8mCAOXxK
 677Dv9RshocaY5usStZtWvdAd/Twa6P6H8ThGua35IrIeNqjODIFsDj3BIqdbRAaqkH0
 hNmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726079285; x=1726684085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4TRc5yra3lJIAuAXx6V9Oj+mGANIpv4xZR30cYj1JhY=;
 b=Q7tLGPnlNoXgDoFYziq5vMAjQw12tiPw1rKdEMDq0rZsjEiyomTYCE8v9GkbUkNRnG
 N87Qo6e80c3tXt7xxWH0kPGmgDO+OHbHtOaq8WkOH9K6WPv+hdotQeyTXwn4oai9Z92W
 vNweiBvRTUnsVkBlhPJy6iVyXzCEwu1XjRuueurOWa/OjL/i8CAQ1ZfQ1FK1bfudFNWx
 OijRdaZLBoUTUcuRnjioq+0JLIrA2g652ne7wHWRTjKFl1IRyA4+m5XFXn6oq0se3e72
 W5gMxMaooI/TFJldVcMxvsl3UZUeQ8J7B9GStC7eDwlWXyqOTOeADEe+hpDBUE0WKfps
 /pTg==
X-Gm-Message-State: AOJu0YwQ9WuVEl0/K2zIhXtc+c2psn6V+R5iTB+Fh4cQzuGJwdyJKWdv
 wQR496iOGnHwbgcqYfaqCjt3IVWPcqRYNhI/rMVNF/uts8b3cwpaZFHeIU8JaZoLcLN+8JAhasy
 U/yaVaB80EIlDLmHiyHC28sBCr+gyw/pqJyklMQ==
X-Google-Smtp-Source: AGHT+IEGpT1rik/UBlVnKNB2oZd9frrS7NXPOGgzjmQ+dIy6hzxRcN5QQXDRkk+ZoxXp9z89ToHhtR7RVa/UroVDZlY=
X-Received: by 2002:a05:6402:3596:b0:5c2:5c77:3342 with SMTP id
 4fb4d7f45d1cf-5c413e05eddmr239905a12.1.1726079284356; Wed, 11 Sep 2024
 11:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20240911064645.357592-1-alex.bennee@linaro.org>
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Sep 2024 19:27:52 +0100
Message-ID: <CAFEAcA-6LmedAW0DJxAXNFh=zpEUuG+E39vAf9OSxfPksf_btw@mail.gmail.com>
Subject: Re: [PULL 00/10] testing and gdbstub updates
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Wed, 11 Sept 2024 at 07:47, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
> The following changes since commit a66f28df650166ae8b50c992eea45e7b247f41=
43:
>
>   Merge tag 'migration-20240909-pull-request' of https://gitlab.com/peter=
x/qemu into staging (2024-09-10 11:19:22 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-testing-gdbstub-oct-10092=
4-1
>
> for you to fetch changes up to 06dd94e84336d2c5a86c99049dc9abb4a1d6b2e5:
>
>   tests/tcg/aarch64: Extend MTE gdbstub tests to system mode (2024-09-10 =
23:34:03 +0100)
>
> ----------------------------------------------------------------
> testing and gdbstub updates:
>
>   - remove docker-armel-cross
>   - update i686 and mipsel images to bookworm
>   - use docker-all-test-cross for mips64le tests
>   - fix duplicated line in docs
>   - update gitlab-runner ansible script
>   - support MTE in gdbstub for system mode
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

