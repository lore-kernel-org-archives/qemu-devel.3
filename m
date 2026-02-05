Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977FFEC1E99
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnx5s-0001xc-Hu; Thu, 05 Feb 2026 06:00:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnx5q-0001x1-EM
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:00:14 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vnx5n-0000Sy-Hi
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:00:14 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-795232991adso1603737b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770289210; cv=none;
 d=google.com; s=arc-20240605;
 b=GznDWvXi+SKzlnvIV4BSerG7u6ZLndCXCyUk548AYbm+g/TrXonn01ckT82WiwbX7i
 AH62inKauUn7ikNM7crqnobRZn3M985pDlCJ7OeYlCHZ+qthzjjEhjHWLYvTPYp2LHxZ
 bunnWeFolgxldyRWrTiz8TKSb5Z3sw8b97NEa/zwH1fezhioAnVgJuRFbVAtYsWb8yVL
 RVduVHbNTslw28epWEifx2v2dGBhByTA3H3fmFuM4sjAnNc2J6FNy9U4Ul4yEgu1L1Du
 jn7BPZ8NNEi6Ejl1qHZYYk0V0++EHMCsHJuc8+3Ju9AvuOKvko1ojGoNFBWFgFi1A+m7
 aVSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UTXQ+hL5pOtgRw7c+pwlRgQW/90K168Dme8+mjUgRzY=;
 fh=QjOJZvpe0caDFfsEs9xnM9LsntH7+V9ksuhIBgPTSj8=;
 b=hGqgZiJNJf6EP9jmM5lUoCCLGz5v+kKYGoQ2Tw47XW/X/Xm/tMs6k3AlslRQTTZ3Mj
 AfAGt5BCJ04bYIINrBDwjBOjS8jJW1NloFSfR0+opZA+HiRaVZadeKJOuwqfx9QV/hwJ
 dnvDuLaQ2whNqOkqjRp4O2W0zG36mQujCV1QR5US0hM05QBwa1hG7acmc3aYFT5Jbmf8
 xgmCN+2TlWsU1/PgbxOzSMJhAQ9NU1NyvgFgzeLLV0XjR2qMSz+Ehnz1sPprtuSi6ZYg
 /VFCELLESWoGsEiB0GUjZF1moyC64UPGlc3uuTKWvaqIKErS6BeaKUu7jjK2G7qQWFSg
 vqUw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770289210; x=1770894010; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UTXQ+hL5pOtgRw7c+pwlRgQW/90K168Dme8+mjUgRzY=;
 b=jpqSPlhL/ktDK8cu1giKLnIZlSrA1ZiuO5e3U3BiUeQsZYqmILWMNMpuEpUzAKThT7
 0TFSKIu6C2K12hReVxifsKK7NgASjC3nuQtMXZDj5A0Lvv2ZLpHO3yEvDLVk4/dPQAla
 jlxe6mdOdQFSlK2JtlCmBsDpJf2YszriI0IZ6fv3foWIb0ffrNasBs9hwfexVW5yKTCa
 oiwpOm/TR+1omL85vs0YeyT18QelFm4Fya8sOiQopaKpBqba1DJNRQXX/1w9/s4QfntD
 tPhov9jF4dVYjTcnpbJmXTHoZC5aSx9eHyS8D93OYzLBthVqbUizIXyBHx8U3frp7fRr
 TcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770289210; x=1770894010;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UTXQ+hL5pOtgRw7c+pwlRgQW/90K168Dme8+mjUgRzY=;
 b=r3wb4Ak0hClg215lEIKWVcpBXIYP+XpRMPU+ANwlRs00KWOyZwcDDuZKA7gcAGx05u
 qXkEiKo6eekQVJm0fBOyPYiakF7xXMk3cl43vXlU+V1M2F27aUAUtXg6CIshbb7hLNIs
 MurgMwTEqQ/UQejMIGyUEzskts1eyjESYo0FnsQ4TUWhn8FVAsnH3HTui55jNQj37Gs9
 BP46E2U/BsP+SfKqNAO6bo6oQHwh4QcTgYEOFIosRlnqdFE4cAVAoUY7TZ/2RGr3LLDD
 53orU3V8JrvNNRIOLzyH5F0FjLgHxzvft4PC+XiTEFKn3cEdnMKp9pO2/3Hx0dbYC/m/
 D+7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVKp+qLJsCNApIysGmS3Be+qlI4Ee3D9cZQTuTOMbEJSjYCRN84rRYvI7YNZOkn/PLnAW5ygejXH32@nongnu.org
X-Gm-Message-State: AOJu0YxwXgvnVxq8X70YaYUHIs9UH3UiMhtjO6eensyL/GzPO7DDSCOZ
 RgCJrfdlNDWdYLam3WDmpzwi8ek6lqvvpDEryeOnqu6kIyxKju6WOTGuFlExKPS+c9PUxPOUwXb
 fM9QupHi9BW0NJcM1OTZhpf5ZHiQiNYeZ6mIwbJb5jw==
X-Gm-Gg: AZuq6aK3IzgvMrJbsQzyQ/Q7X57eH1NFg2Va7SxLXyVnrmGlppwcuhWVexGNVqv5Ur7
 5Hyi4Y/LSF7WfhnrjXHb+Bc4EQfzYHIxRacrH5HPWnR7XSbNdzbnepQ9+sOjy5LX8YThfkwnE0G
 QSDnpu1qUJ6JAVCYLPeKlfw8OkWfgPJMhTbF9fTU7a3CCLRZFQ4D8E17PBv5tVWd5O7n+9xXAIn
 N5OcmyiJRudlJZfHrUn99fu7rFXJ2qHl3h4zePDj7LsbaZiFDjurDwiDLxQARGMEKNgKMiU3vg+
 umaX
X-Received: by 2002:a05:690c:f:b0:794:d29b:4a3f with SMTP id
 00721157ae682-794fe695ea5mr62683867b3.29.1770289209502; Thu, 05 Feb 2026
 03:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20260204103136.1795455-1-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Feb 2026 10:59:58 +0000
X-Gm-Features: AZwV_QjPAmVaqBP6vcgUxH9C4U5YcF0jFaGbAt6Ck5GLsu2fEdCNwV9ZVP2aggg
Message-ID: <CAFEAcA8bbux4ZurMeKF4=qPijBs_BLDN8CNpMT1PB9G_hmeKjg@mail.gmail.com>
Subject: Re: [PULL 00/45] aspeed queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 4 Feb 2026 at 10:31, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> The following changes since commit 28a6ca268c2cd3718b5bf24c2d97e3d1e95fc6=
04:
>
>   Merge tag 'single-binary-20260203' of https://github.com/philmd/qemu in=
to staging (2026-02-04 01:57:26 +1000)
>
> are available in the Git repository at:
>
>   https://github.com/legoater/qemu/ tags/pull-aspeed-20260204
>
> for you to fetch changes up to e56e45d5bdc808ed52f943d1a785e4d885b6f18f:
>
>   tests/functional/aarch64: Add I2C test for AST1700 IO expanders (2026-0=
2-04 10:10:57 +0100)
>
> ----------------------------------------------------------------
> aspeed queue:
>
> * Added support for the new AST1700 IO expander, including several
>   device models (LTPI, PWM, I2C, GPIO, etc.).
> * Updated the AST2700 SoC with LTPI support, EHCI IRQ fixes, and other
>   improvements.
> * Updated test images and test cases for various Aspeed platforms.
> * Fixed issues in the Aspeed I2C and ADC models.
> * Added support for pca9535 GPIO expander.
> * Updated documentation for Aspeed boards.
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

