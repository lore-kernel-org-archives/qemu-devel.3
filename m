Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0CEC47DD9
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 11:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reD3c-00081N-J5; Sun, 25 Feb 2024 06:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reD3a-000806-G5
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 06:52:34 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1reD3Y-00023o-QX
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 06:52:34 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-56533e30887so2243401a12.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 03:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708861950; x=1709466750; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gOfc+o6YVJY9n0PKQbdoguE6/mGYQ1ZnE0tbMGd1dXY=;
 b=PVP26I2uUocDwSzvQdal+VnMfN24H6XhI5YH/2WzifsB8OtD2JKukUQ4yvCMGW/Kdx
 JaIQzuTOzIve/NUA0fDAYJfJeUK+blVA6gqTGY7e9YBFOgFJg+4L2E29JPhpMR58+8bW
 Xo7YcYvNIVUbeSPZg2tt/n06l2/l4o6BlcJUa8shw8036lF8xyWij+vrTKduc+KOwLaW
 hkb5RvWHt/ptHPRjVgl95BIjzuYIwk9VdKKAmkWZFhGRpKYYltNvpKs4WNtBym641EWq
 LirpvRjuqkA9VwC+JN+j62NFhJ2CFZzZi236BVsMRksJYZSQk5k36ORSBdCypsgNr/fd
 twHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708861950; x=1709466750;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gOfc+o6YVJY9n0PKQbdoguE6/mGYQ1ZnE0tbMGd1dXY=;
 b=JStkuONw8Lk93wntepLQdqfUUMP8sJRj9hGeVmfWxdsoEPjpyQDeW2wL/NdsC87C1z
 GKzO++GPDcqLSW+LCrd8Zlnqk4+6sXncMMJrcT4WfXbAOTWck4C8lo95srP8EpIaZzS0
 q1ZdAPcBihZ0Bbl36hfWucup4pC02s10w7aqrO27ZQtdddk9r5yqClXXW9pkMd/pjVTo
 VrajMD+GKulYzmepDal5Z9XeL2P590RNUe/HM/++EeBxRUgaR/hsCh8vPqFIeRsGszJ/
 DbhBuKNCbCaHcR/ODDSFaoUtimph2Py4T1ZeReUXHvIbbPEoPIGPgRr/uKF/CKltX2YJ
 Q0zA==
X-Gm-Message-State: AOJu0YyOwEZqLrX8poCc0xVo4Sj5L47xGlvC0LFdhVr8YtsFsORoSK1b
 irxtMPx/23VOeXT1CTen7xH9jRHX6rswYQYAnBXjLYuKLdB1tNPjnct4WqzJwxxEnS4mPi35qBp
 thcrg5BONpciN0ZMzF6KkvB03LqKO84ynKbu7FgbXV3k/hiZY
X-Google-Smtp-Source: AGHT+IFAov0GF5uV1/+IQstWVcD9l0u9iw9M1xqVYfe5N1yINsx1Gwu+1JJgT5WdMVjDQSqIgFmwgeu1gcOxW+TML4E=
X-Received: by 2002:aa7:d959:0:b0:564:b882:bc5a with SMTP id
 l25-20020aa7d959000000b00564b882bc5amr3149553eds.37.1708861950477; Sun, 25
 Feb 2024 03:52:30 -0800 (PST)
MIME-Version: 1.0
References: <20240223191003.6268-1-thuth@redhat.com>
In-Reply-To: <20240223191003.6268-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Feb 2024 11:52:19 +0000
Message-ID: <CAFEAcA-vBDBPrs9+sHzYoUG3nfhYzEOCVR83UoA00mqkdWfZAw@mail.gmail.com>
Subject: Re: [PULL 00/11] Test and misc patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Fri, 23 Feb 2024 at 19:10, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 3d54cbf269d63ff1d500b35b2bcf4565ff8ad485:
>
>   Merge tag 'hw-misc-20240222' of https://github.com/philmd/qemu into staging (2024-02-22 15:44:29 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-02-23
>
> for you to fetch changes up to 028ade14da9eb31a8c5dde48dd5b140e49888908:
>
>   target/i386: do not filter processor tracing features except on KVM (2024-02-23 08:13:52 +0100)
>
> ----------------------------------------------------------------
> * m68k: Fix exception frame format for 68010
> * Add cdrom test for LoongArch virt machine
> * Fix qtests when using --without-default-devices
> * Enable -Wvla
> * Windows 32-bit removal
> * Silence warnings in the test-x86-cpuid-compat qtest
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

