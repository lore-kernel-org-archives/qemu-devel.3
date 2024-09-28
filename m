Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10781CF6491
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 13:37:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suXdh-0001qq-UU; Sat, 28 Sep 2024 09:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suXdg-0001pu-E3
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 09:37:36 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suXdf-0003pt-0D
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 09:37:36 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a910860e4dcso479005266b.3
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727530653; x=1728135453; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pW30RmH0L4XgjHBSPNM08gntjSXW5CENyWLPiFHiUHg=;
 b=mnoKden6AsR0Wf8tJdpnbOVSuraLKBb1afVeUmwEYxMw1N0YyqsIDudoxvboGtPZgx
 os9KQ/OYonuQdB4Q5fbFgAV6MuxRJ2N/JZUDV0Ot2VInP/pNESS3ZcVVNXjvr60Pz7xa
 BBKltsQvBWNaUUOCBKCPvf4vlwou7dregowEg/krMWzrjcb0vhY96T0v/dGBk0IVfFbd
 1xjQF5qVbrcSNIETRoB9E+FTSuCiJiq2iF7QGjRwapbQxO5u8GMluhbxdcKYDDuu2gNx
 g6JuKgCS4IrrKSDmBuW2Vcz/5Xw7X3RnPt8dPLX01DVuUNeO1akUyOSL9PgFBfnLoChw
 risw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727530653; x=1728135453;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pW30RmH0L4XgjHBSPNM08gntjSXW5CENyWLPiFHiUHg=;
 b=dOHu3ne+/t5Q9BgyaO3CMOMZ/L428b5Ballxnzme2hVc+ro2UW8GKlV7fC2aJYabaw
 M3EVdA+HH4oojr8gq60TpZlRUh9ljMAPeRBgqvK0SIRx92jkMVf8diij90J5VKA8d9+U
 tn8nfZdt2OsZwqCLg+NDi1QQVA9gJQ4JcTErz5jdjRlChyeW6NdqM3+luHHNiZRGSGDK
 pnFrzkuiURF5vODXrYmzAywt9n9/6Ap6GVtRyEderXIhHXDbrH+02uwAN7pKc6OIhj4D
 bYUrAHt8bXZNsVYSfliZx1T7ab3tHXpZcw7aHbcerw0DmOaRxKAevSyROmnf+yJlJH0f
 Tfng==
X-Gm-Message-State: AOJu0YwNSnRk2lW+kYKoyY0luJdmcyAOO4AR252rHezoijMxG4Q29Rlf
 8kUSI/4J3otVP3akqrbY6iBkb+KkgxjEIZDtLiORooM6OdDfjqjTwZjiqqb5efj0JMto8kRaWkq
 1MuqgsN3U6bXog05fjaPtu2I2kvVFbXUDDrnT2w==
X-Google-Smtp-Source: AGHT+IEPaWVsgSEmdedl4I5+4SeJrOqzZ6P5viUTHI9ZAaBNEyyXTTUzxe4Zlr03hi7I79evv+NAVVy7z7juARr+MFQ=
X-Received: by 2002:a17:907:36c5:b0:a8d:592d:f76 with SMTP id
 a640c23a62f3a-a93c4a67db4mr789235166b.48.1727530653332; Sat, 28 Sep 2024
 06:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240925111029.24082-1-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Sep 2024 14:37:22 +0100
Message-ID: <CAFEAcA8tFGRgdVDZZz03xWXVRL2GSsKaAogr8dboCuK55P43hw@mail.gmail.com>
Subject: Re: [PULL 00/44] Functional test conversion, and assert(0) cleanup
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Wed, 25 Sept 2024 at 12:10, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>
>   Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-25
>
> for you to fetch changes up to dc05b2628e3913e668590ba66d9c618382d351ae:
>
>   .gitlab-ci.d: Make separate collapsible log sections for build and test (2024-09-25 09:42:06 +0200)
>
> ----------------------------------------------------------------
> * Convert more Avocado tests to the new functional test framework
> * Clean up assert() statements, use g_assert_not_reached() when possible
> * Improve output of the gitlab CI jobs
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

