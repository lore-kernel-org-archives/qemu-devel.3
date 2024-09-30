Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6022CCE8374
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 16:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svJYg-0001kr-7e; Mon, 30 Sep 2024 12:47:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svJYe-0001kN-Ss
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 12:47:36 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svJYd-000791-0F
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 12:47:36 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9bf9d8bso3310601a12.1
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727714853; x=1728319653; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BRHZ8tXK+So2K4ER9/3su8ZchMoCflm2dMQ0P2QDrYk=;
 b=BUYaGtwl7pImzYfx6uh7Iu0TGfxqzBJRA/pqtTx9ULy1Ghf68gDivcXNa3tuEJyM6b
 m3Oy2uciX8ZUQIE35Es7CjMu7z0gZNbi6Gou5KZKTxQQwVCDEBaz7Y3Ix154JxDv3KGA
 roXw6ntDQ+GcWM+XJBQzqIsNn/S4rgA09tlE117CGgdkZx5F7JPUyQm07QmPXpAav4Mc
 +HZL22dOqVY8wUJX/m4zvS0MHUkzNZYE2fxJ/dD+5dBk0h3n8uBju7oL+p+suusRxI3e
 lUWYWbsLOePwj7jlqZqg7umM+/3PKVb8NmN9rWWvqA/fIpGM5EPlAnJaN7Xb6VCC0tjt
 cwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727714853; x=1728319653;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BRHZ8tXK+So2K4ER9/3su8ZchMoCflm2dMQ0P2QDrYk=;
 b=otHSwbgo4djaKhBqEZ5cdjcRizmD6QonPQ1cafXstdgNOhUNlna+3vz8Mq/A+Pl6Re
 wu3g1mmnmmlvIBiLat4xOVP64iwDT//KUueJooyt13JbP9fHVem7O+yGiOuEQWovgpdK
 BHM3gi8ad4/7t8T36YH/O4Dw/rc5pclYSIk4hPc4nhLyktcElWruN2XyClwQPooC2k+G
 0J8pG+i3GOdJlijx02CsnrXTnzZIJEFYox5JvoSsLGzVYxHcB43EPS2/6XRJqcYRLMsv
 6G8g1suz6nFO82XHBTCHanq1XgZK4dOnDDA6YAFsM/LdjGY4uRbGDPKNePL8E5Fg7FW6
 k5lA==
X-Gm-Message-State: AOJu0Yw1/5/YsjC1cU++QETuGArjFga7bnh0wnI/LcORJoZsquwq2QZz
 vIC+UpKGUvarirAEmgNX0ubkknvJvBAZXyJ8MCbg/sxASOmm5WdMaUJ5/SPnDjZOMkFpSbQ+8uH
 w9MJPd5oLtvGbWVR+c1pqtKRJ+vIxTC1DbZR9Jw==
X-Google-Smtp-Source: AGHT+IFDfJ1Vj57zUyr8tesDER+152wQ96Tph7WYtvx/I0USBN5m7Wg+zWTXHHvhDkpIyjKMDBeIJ0gtRfRrSNxargI=
X-Received: by 2002:a05:6402:51c9:b0:5c8:84a8:5170 with SMTP id
 4fb4d7f45d1cf-5c884a852e8mr12766690a12.34.1727714852738; Mon, 30 Sep 2024
 09:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20240925111029.24082-1-thuth@redhat.com>
 <20240925111029.24082-3-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-3-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 17:47:21 +0100
Message-ID: <CAFEAcA-rkkxVRsWJqHOeA2cqSg5hnVqvH4-iZRSadxKmfey9nw@mail.gmail.com>
Subject: Re: [PULL 02/44] tests/functional: Convert the vexpressa9 Avocado test
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 25 Sept 2024 at 12:10, Thomas Huth <thuth@redhat.com> wrote:
>
> Use the new launch_kernel function to convert this test in a simple way.
>
> Message-ID: <20240919185749.71222-3-thuth@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS                           |  1 +
>  tests/avocado/boot_linux_console.py   |  9 ---------
>  tests/functional/meson.build          |  1 +
>  tests/functional/test_arm_vexpress.py | 26 ++++++++++++++++++++++++++
>  4 files changed, 28 insertions(+), 9 deletions(-)
>  create mode 100755 tests/functional/test_arm_vexpress.py

Hi. This sequence of patches changed us from
getting our CI images for the advent calendar tests
from URLs like
 https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/day16.tar.xz
to ones like
 https://www.qemu-advent-calendar.org/2018/download/day16.tar.xz

This new site has just stopped working: download
attempts return a 503. This breaks our CI:
https://gitlab.com/qemu-project/qemu/-/jobs/7955655569

Should we switch back?

thanks
-- PMM

