Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69675CF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 15:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t00Ux-0003H8-Kf; Sun, 13 Oct 2024 11:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t00Ux-0003Gr-0Z
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:27:11 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t00Uv-0008Uo-9g
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:27:10 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a993302fa02so569420266b.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728833227; x=1729438027; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NELsnigqApL4bZKLhcArUF0yEBLqWEqtATsZcQNROw=;
 b=nK9H7jO1xammyIYKU3/V/DC90WgG0aWqxodSSjFUXKMceV45/4XOzsOPHL058ZmMuS
 Pbo/HP29sleLZj7lr8PMpcS3w+geXt683HbucQRt9TRV38+G5gNTOwbjqjFadFIUcklo
 DoCC5pYqUGb/FNyM9JhSzPJRsJpTTgZNRjbkfaZDAaLcM6H0MyalE2YPiyX/MQZoTuO/
 wsKxZ3vRP4+q91Uosen452UlrQ/M8cxJoxZtMjN8LbmSeY0U7k2D5T/5nc5PkilWt+Eo
 QXrKvhu4rKSySC5pZ5GSb/e0VCVlkvR0TIx8ndwcvOB4KEnwLgFIQWRKxtWBriyE+vcS
 67aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728833227; x=1729438027;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8NELsnigqApL4bZKLhcArUF0yEBLqWEqtATsZcQNROw=;
 b=dIkaTgE9UHxIneJ3dVNPKT1iadBBaYDgaFbPIcmU1ezNMVsZqyPJz0z/KD6EyYhPov
 PAL9LsnYkeHYS7mkxYJNuHqpO7quFJDqnKiscvX+JHxJtTl9kWNiDx4lRsXO7Bvjq67X
 AVELEl7fPhkRduGZRb0mDqs8iaI/XoIIn+EeLfU4T/9pljmWdJ44fjZ6I5NktMg6Ajtl
 6sUjfJjgCYpzBLZ89BS914evwogeVfn+z2pOY1Veg7Rl7k/uBJzW1SRCH5WKZ80pI+VA
 mc/63Y1zZxFj6ICQB1u1A6SBNKk7NYtbb+hRFq0tqe2MqyNiPGNAr2Bs+5v7FOypzH8k
 LOtg==
X-Gm-Message-State: AOJu0YyM6LvhVt1Cul5vFVNd7+3JRbKvyY/NWOv7Guet6+NggqGcUvpi
 SkDrd9O47xDy49xmyZPIt85aYN0sbPii6wNoFkQwQnX4T8vhWapGeD5I0c2hp1U=
X-Google-Smtp-Source: AGHT+IEbI20SYu4fQJyCcY9fre+UQlFqEIXA18XoSfUS2wbpbuK+VNhrOQ9z7Yevtb9GpRIojlS84Q==
X-Received: by 2002:a17:907:84d:b0:a99:e939:d69e with SMTP id
 a640c23a62f3a-a99e939d95bmr502423566b.51.1728833227147; 
 Sun, 13 Oct 2024 08:27:07 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99ef8c4d50sm202868166b.11.2024.10.13.08.27.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 08:27:06 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B6E115F8BA;
 Sun, 13 Oct 2024 16:27:05 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Guenter Roeck <linux@roeck-us.net>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Magnus Damm <magnus.damm@gmail.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 00/17] Convert the Avocado tuxrun tests into new
 functional tests
In-Reply-To: <20241011131937.377223-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 11 Oct 2024 15:19:17 +0200")
References: <20241011131937.377223-1-thuth@redhat.com>
User-Agent: mu4e 1.12.6; emacs 29.4
Date: Sun, 13 Oct 2024 16:27:05 +0100
Message-ID: <87bjzoaura.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> This patch series converts the tests/avocado/tuxrun_baselines.py
> to the new functional test framework. While converting the sh4 test,
> I noticed that the Avocado test was completely broken, so I included
> a fix (revert) for that problem in this series, too.

How can I run them from meson? I don't see them in list (but make
check-functional works). Shouldn't I be able to do:

  ./pyvenv/bin/meson test qemu:func-thorough

?
>
> Thomas Huth (17):
>   tests/functional: Add a base class for the TuxRun tests
>   tests/functional: Convert the Avocado ppc64 tuxrun tests
>   tests/functional: Convert the Avocado aarch64 tuxrun tests
>   tests/functional: Convert the Avocado sparc64 tuxrun test
>   tests/functional: Convert the Avocado s390x tuxrun test
>   tests/functional: Convert the Avocado arm tuxrun tests
>   tests/functional: Convert the Avocado riscv32 tuxrun tests
>   tests/functional: Convert the Avocado riscv64 tuxrun tests
>   tests/functional: Convert the Avocado i386 tuxrun test
>   tests/functional: Convert the Avocado x86_64 tuxrun test
>   tests/functional: Convert the Avocado mips tuxrun test
>   tests/functional: Convert the Avocado mipsel tuxrun test
>   tests/functional: Convert the Avocado mips64 tuxrun test
>   tests/functional: Convert the Avocado mips64el tuxrun test
>   tests/functional: Convert the Avocado ppc32 tuxrun test
>   Revert "hw/sh4/r2d: Realize IDE controller before accessing it"
>   tests/functional: Convert the Avocado sh4 tuxrun test
>
>  MAINTAINERS                              |   4 +-
>  hw/sh4/r2d.c                             |   2 +-
>  tests/avocado/tuxrun_baselines.py        | 620 -----------------------
>  tests/functional/meson.build             |  28 +
>  tests/functional/qemu_test/tuxruntest.py | 158 ++++++
>  tests/functional/test_aarch64_tuxrun.py  |  50 ++
>  tests/functional/test_arm_tuxrun.py      |  70 +++
>  tests/functional/test_i386_tuxrun.py     |  35 ++
>  tests/functional/test_mips64_tuxrun.py   |  35 ++
>  tests/functional/test_mips64el_tuxrun.py |  35 ++
>  tests/functional/test_mips_tuxrun.py     |  36 ++
>  tests/functional/test_mipsel_tuxrun.py   |  36 ++
>  tests/functional/test_ppc64_tuxrun.py    | 110 ++++
>  tests/functional/test_ppc_tuxrun.py      |  35 ++
>  tests/functional/test_riscv32_tuxrun.py  |  38 ++
>  tests/functional/test_riscv64_tuxrun.py  |  38 ++
>  tests/functional/test_s390x_tuxrun.py    |  34 ++
>  tests/functional/test_sh4_tuxrun.py      |  57 +++
>  tests/functional/test_sparc64_tuxrun.py  |  34 ++
>  tests/functional/test_x86_64_tuxrun.py   |  36 ++
>  20 files changed, 869 insertions(+), 622 deletions(-)
>  delete mode 100644 tests/avocado/tuxrun_baselines.py
>  create mode 100644 tests/functional/qemu_test/tuxruntest.py
>  create mode 100755 tests/functional/test_aarch64_tuxrun.py
>  create mode 100755 tests/functional/test_arm_tuxrun.py
>  create mode 100755 tests/functional/test_i386_tuxrun.py
>  create mode 100755 tests/functional/test_mips64_tuxrun.py
>  create mode 100755 tests/functional/test_mips64el_tuxrun.py
>  create mode 100755 tests/functional/test_mips_tuxrun.py
>  create mode 100755 tests/functional/test_mipsel_tuxrun.py
>  create mode 100755 tests/functional/test_ppc64_tuxrun.py
>  create mode 100755 tests/functional/test_ppc_tuxrun.py
>  create mode 100755 tests/functional/test_riscv32_tuxrun.py
>  create mode 100755 tests/functional/test_riscv64_tuxrun.py
>  create mode 100755 tests/functional/test_s390x_tuxrun.py
>  create mode 100755 tests/functional/test_sh4_tuxrun.py
>  create mode 100755 tests/functional/test_sparc64_tuxrun.py
>  create mode 100755 tests/functional/test_x86_64_tuxrun.py

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

