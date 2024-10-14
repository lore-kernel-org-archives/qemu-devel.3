Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ADB9D1624E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 12:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JnN-000851-PC; Mon, 14 Oct 2024 08:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0JnL-00084o-SK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:03:28 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0JnK-00077q-5t
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 08:03:27 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9362c26d8so7015335a12.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 05:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728907403; x=1729512203; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+g6Lad4LYEei3i27YX0og7YE77gkveC5dQk12cAF4yg=;
 b=EXk5Vcvfch7auGAddQxistnWIioGM/I0f0UtIwF93JzWV3T435SwAHEgFjkGsBnjJt
 tUqkDhuEWvGqF73HJ72ArZW/DD+683ZDxJfd+b+2pZN/s6YS3qjwwLyp03UEefHjs6+z
 0HyrdlQ53Ez6iBFIfizUAc4Sbn/sqRwIbZDZXV17J3iHIzdNWLoKUsd9yAXscjDCjVli
 /k4yZVmE2prr7pkw4PZpxpjzKDZz33gmD1O1V8mKro55C541ADksMKfgjf0U18/4S1q2
 XCK8VazPiBsVATUo+PbVVqz6ydRshb2IFqZh1K2IvJsRpG5aAc9nugsE4B2jgUXUmY8U
 0hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728907403; x=1729512203;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+g6Lad4LYEei3i27YX0og7YE77gkveC5dQk12cAF4yg=;
 b=JQfqYsXE0Npk2o4Qfcz9rQKhWEjxns1ah5+xAOrGCgOKFK3VzebRAUbq7z1JBxGoIM
 Ctkz/lEXzDN4P5pDFWM41QGX4YnJYoSztmGOwtvlhcVmZX6OoDPhorXq2GuVL5FSJHxB
 4G3MHHaQizC8H1NzyKqnia77QkibyuxMBlmA2u/TSFknhoNXmG6yu4Fa8/LPIy31taM4
 SSTfwmffgmuONU4VylbUaB2KFSEw6cWayQtDQ9yxdr1m+2hYQppANCaqAXxN/gqQTbRj
 JpTZYsJ5QomWEwMvIl/slKZy9ykOLDuD2AY8ODGQT22fBlNNxSmsF3NOHNUPaHWEsAVr
 EQvg==
X-Gm-Message-State: AOJu0YzrsbtsCnKPTbVbZgSiA6TjP0NQunz0Fr7jj1mSGRu16Cr5Irai
 CKGX4QWnw8U78ml3z+v33XONElOsBtcMNwiKoTIxAkdnrlfdp4v58bqMQWEgLFwdhqGlOxTN4ZU
 HlfpmxAlHPjUrruphqbv8cbCsADZfBHtGYPdWIw==
X-Google-Smtp-Source: AGHT+IFsx3YYvLcMnkFuF59MwGHPMBhYrOUlxhLfIa5kp3itMsZ/Uz6Pj60SH3wUTehPbhbI48VpWpKmMsiEZz11rlM=
X-Received: by 2002:a05:6402:2547:b0:5c8:78dd:8027 with SMTP id
 4fb4d7f45d1cf-5c94754c607mr9723590a12.12.1728907402184; Mon, 14 Oct 2024
 05:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 13:03:11 +0100
Message-ID: <CAFEAcA8oxdMV3AubieqxuZPiBEhnvAXkFij5yawrWoTLjnGPWw@mail.gmail.com>
Subject: Re: [PULL 00/27] tcg + linux patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sun, 13 Oct 2024 at 23:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 7e3b6d8063f245d27eecce5aabe624b5785f2a77:
>
>   Merge tag 'crypto-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2024-10-10 18:05:43 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20241013
>
> for you to fetch changes up to e530581ee06573fcf48c7f7a6c3f8ec6e5809243:
>
>   target/arm: Fix alignment fault priority in get_phys_addr_lpae (2024-10-13 11:27:06 -0700)
>
> ----------------------------------------------------------------
> linux-user/i386: Emulate orig_ax
> linux-user/vm86: Fix compilation with Clang
> tcg: remove singlestep_enabled from DisasContextBase
> accel/tcg: Add TCGCPUOps.tlb_fill_align
> target/hppa: Handle alignment faults in hppa_get_physical_address
> target/arm: Fix alignment fault priority in get_phys_addr_lpae
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

