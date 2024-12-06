Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B10EE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaO6-0003WM-II; Fri, 06 Dec 2024 10:37:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaO4-0003N9-GF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:37:00 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaO2-0001m1-Cy
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:37:00 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d0f6fa6f8bso3123276a12.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733499414; x=1734104214; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yQ4A3/g/2pS6c784I2euUtTqJcCLeS/MepE1AhkfSyI=;
 b=PXabn57Rh4NSNdYagskd2qdmCCvZUllThFIc6y0blq1kLG4aS3blKnPFmYgWJSwB8t
 BVR6CGCcqF96EP47RChZElq2u/cF0ydSFCWv9GfOZ3SbO9s3wuBFFgMN1PWjy3L0eYzf
 Wjwcc1uo6lJKIfd/ZayJiPk17bf7Z5cV69ckfMulr1t1SUVuCQ2FQ2+sRJI6yV7bwDHz
 BLw8jlcUIInXy1DFL/MHNofbhjjpux75OGrZoF4ZFWvxcr0JA4G4FNwxKQJbPPw0iT8/
 2e1gmiawfWtmqPHnewQcZ66B6MRZKc+QG5USJX/DShNS8RQ1zD7XCmefllDzXvwmRrBM
 bMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499414; x=1734104214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yQ4A3/g/2pS6c784I2euUtTqJcCLeS/MepE1AhkfSyI=;
 b=NKzZFK+yviABIvnw7EvDk4sIv9Wn56n3md2HvYgfZXtoVXN+Tn5zkHUCzbN5UXqdYU
 TTc1GNreBd/5g1tmlbdcZbmX6jNEnsvL1XauAaZ/Tud7uBEo8GT4regF7uxjsbJ/WRLS
 WPWLJcdLcsZjNURtNUmgHU/aEvKSDjsX+JLsO7sSECI2zBwrp6iBEXUiKMNp/5KYkgky
 6FsdjGvK5IwdCDu66guGxqoga8dFV89uW65BteOVQziqU3z8Rk9RDlDcgpGG3uklNdyA
 JFoSTy2cnLEGU8tv1PAydlr0nPUQTKZGIMYyu4lfkUyyzJqJWQqySSBAle/lCPq+ALGx
 oqTQ==
X-Gm-Message-State: AOJu0YwVe7lzXieBxYuHnCav6pJVhAgRcyTc00y0RutdcVleYnOItEVw
 OjHj8HnXX3WktwIQbzSW4qHVmFbLgtn2luFj8VPwKlYeP71xBSFKRMptP8pudNzSEWGzr1XTYNx
 4TsYLY3U1GfFU9sj43UJJXRdvnG0owKnpJaKKGQ==
X-Gm-Gg: ASbGnct0ZZgW355itrZtENX8DXxW94QtZVuvmfCNKsBaFgXnq1Wf0mDQzN7LSXSPEM2
 B6uw5yrOH85Nsqu3YUxE1pF6r1kCxdP/s
X-Google-Smtp-Source: AGHT+IEKbzxPoBA92CKmBIFd6LXCg1OPIPhpCRqZHYTY6y9hZbuSgGaA/8Z3hJpO1D9/EO/FRVDsSQEPgqarpI3jgQc=
X-Received: by 2002:a05:6402:2742:b0:5d2:723c:810f with SMTP id
 4fb4d7f45d1cf-5d3be783193mr4379864a12.30.1733499414416; Fri, 06 Dec 2024
 07:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-45-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:36:43 +0000
Message-ID: <CAFEAcA8Kk_AKZHF_ew41HY0=Hyvo4jjzfxgzaYw0_vVLDZvdLw@mail.gmail.com>
Subject: Re: [PATCH 44/67] target/arm: Introduce gen_gvec_{s,u}{add,ada}lp
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 1 Dec 2024 at 15:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Pairwise addition with and without accumulation.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h             |   2 -
>  target/arm/tcg/translate.h      |   9 ++
>  target/arm/tcg/gengvec.c        | 230 ++++++++++++++++++++++++++++++++
>  target/arm/tcg/neon_helper.c    |  22 ---
>  target/arm/tcg/translate-neon.c | 150 +--------------------
>  5 files changed, 243 insertions(+), 170 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

