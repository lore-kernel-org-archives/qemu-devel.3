Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04772CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHM4R-0005xa-8M; Thu, 15 Oct 2026 10:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHM4O-0005x0-8m
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:04:32 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHM4M-00026z-8Q
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 10:04:31 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-8b0ca1ebc8bso16395507b3.2
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 07:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792073068; cv=none;
 d=google.com; s=arc-20260327;
 b=jCT5Yp1CscnX7jCkKPS7dRr+U/WkapdUf+QCIl5IcwC4jT41gl2D5kLzCJEBnBKNqA
 7P6gMkuiNuAqfMzxERvj0KWFbcz1CE9m9cnfI5UxdDL+GhM4jSj9InvNHK6ZSkGrRt5Y
 rKnK3UaAoqcTy9iMfmofU3EagZJ6TItQay4aBV2M66M3Ku/H9fELk3u4vS+i12q0ijuE
 vowID2sqIgpeo7K8DX6/hqwulvaRF6bOYGnLrOSutjZDml9kBJ/ctMl7HDSGzQjZXOaZ
 zLug3A8542NGkglGKHdh0GYcKV43ptbyEANDnQ4iFGxHd+7kWNjxlV5y+hdAGuFmwfrh
 la5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=rAj/PL1/Kubvxu9E3DHe1paOOh3OoN48UxF0kJlMOXk=;
 fh=6rorc93e3c4Q+Ph26UXUjUp4sWvGL/TNMnTIcoCSgvY=;
 b=RSaPsURIgUmb29tbdlBE7McYStO5ZqZD8nf7SLRKPb7jCKKap19VcVX3z9dCWErR0H
 bth5qzfWmaARftF5Zx/Df4IYFiYVTAJODWkyKYYUoQo5aIg/rlI0r2Y2/6tiNinHNgL5
 8A3vMErmA+NZ4fX/MffE3F3b4EdcJPrtvOGOQogd0HWp1E/K/n6PeZ5WV+XOPcWw1BHN
 7UldNr207pgDbsxU4J2XgDWRJc3FJE5X9uJ5ci1KdW1n3Do2f11ZnV55gfdEdMFNdbtW
 l+KjDvvbqKm2PlHh2ombOgmIn/vIgW1rSeewkRlQeRJhyRFllC2NuXtuSZj6VyvK6AXA
 1oGg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792073068; x=1792677868; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rAj/PL1/Kubvxu9E3DHe1paOOh3OoN48UxF0kJlMOXk=;
 b=BKuHK6wi8sYo8q0VxeEBTryUsbZUpyIGFZgK7tzFO+h+dk0rqAz/9ScHGG4wZCUrKy
 htkuok7vBM87eb2txj61KF08/b80VfggaY6Er1AxyPx/JV4fWrBZQG6mXXyF+J5OM/l/
 RFYRZQdnVr2rAizw4meDYb3qXQ6A7K2/o4Sap3z0cXR1abRaxOG6okYhI1sovi1wOHnr
 hx9/7IkQC+aJamxvH3DQcrwGDASw5XZ+gm/bOL4EuGEhdAS4BGb5vsv5gAtpDIjd0FoD
 4Dz9/UAWeSbmInYoYf4D6uya2mBSZizAdtmnYJ7GGgVjaw7m+8e2GbsrFM2Osip9RCl0
 PD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792073068; x=1792677868;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=rAj/PL1/Kubvxu9E3DHe1paOOh3OoN48UxF0kJlMOXk=;
 b=I+quoQehyTHu/Or9g0/t1p2O1dOUSQYrDLt6bRX1NEokh552RdKmSDCsVGIxRMbaNL
 /U4NILaiA3fqBgCjD3EV0GGe4lY1fFoncOf8Ie2+Q3um7c6A/l4/jOzVqcho+fgq9Wtc
 DywcIJQkzeCCTlB44iClywNK9rzZXneizH1Ja64vE/2PjGh0jqSdIo7fJObCFEsp+LsA
 s38Cfc8IGUjAQP7iqE1OYj9m22HTkSuFVTcxOE7cAMFpMM0bNWG43h0LjDx2SxDaiudP
 mlkpTHBso9GTTDrIm6fDj+483fa/tF6s1NfQdSlq80V1kfmMm+6AoqpWA+s57ZjIlPhC
 Tqig==
X-Gm-Message-State: AFq9FYLljknUMykoNDAsGuroEJVu1aNli2SJ4k1jOliAp7Dl6G735bSE
 Mofh1Fa+dzrMbguKVZM6YIOn/KwfZ0a5Yx2DP4Sf/A5UrfvM6/9ml/WnX0SvMpPfJcRMnFvrBCZ
 sDdDq+Cd+pV81QlSU7ytMPXr57NoLbAnWGF9D498m3nxI8AsYR2sFHU8=
X-Gm-Gg: AYBFou2htXnN2XmNgW1M8MrCjLus8JrOqOJn/ShHNNnlqTZrxU5LLxdq3lfezOxMlF1
 Zy0gDdDpP3xtObMCyvBV3kDVIkToMXNnJ8/qVJjnjm6Mr+s75+U8pEss230gXqKFnmIzQUWaiCi
 Myl8HLtNQNaWeLKjxjEjet2jisGp0nQlFd0zrlFES7cdNjdLuQrkKjb4/wTvDlVaEYti1Hb2UGm
 KOFfjuE9lA97kvYS6xLr90HaoZAf6/dhXdJX0OlddrHMbixav2jOGM3BH4j3/atuCUGDN60KS3k
 KkOZvRe1u3Rx1nNEj8hVGKZo8IOsZ6pXoLKsmfgnyPqjvs9DibpyYbTzh9nsWCZc/8ZGvEtaRo1
 20GBIbXP5jtq2B7vwZL/ioDBgqpCGhUewrIr553ysgS4ku6F1wg==
X-Received: by 2002:a05:690c:fce:b0:8b0:d9ff:4f7c with SMTP id
 00721157ae682-8b0d9ff56ddmr5428357b3.17.1792073067767; Thu, 15 Oct 2026
 07:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20261014045605.399684-1-bin.meng@processmission.com>
In-Reply-To: <20261014045605.399684-1-bin.meng@processmission.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Oct 2026 15:04:15 +0100
X-Gm-Features: AclHuK87O_mSPs02NGthXWxbNV6NhgEJtcWU8NJD3S4nj8p5bqwnKQDDUqcU9yU
Message-ID: <CAFEAcA8XwpDmqvUaFDj+QROEAcyTr2K17cz5O1F-g7YSFSq_2A@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] hw/arm: Enable U-Boot boot on MCIMX6UL-EVK
To: Bin Meng <bin.meng@processmission.com>
Cc: QEMU <qemu-devel@nongnu.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 14 Oct 2026 at 05:56, Bin Meng <bin.meng@processmission.com> wrote:
>
>
> The mcimx6ul-evk machine can boot Linux directly, but it cannot run the
> U-Boot proper produced by Buildroot far enough to load a kernel from its
> SD card. Early U-Boot boot test accesses currently abort or observe
> placeholder values, and the i.MX uSDHC model exposes several issues.
>
> This series lets an unmodified Buildroot 2026.05 U-Boot 2024.07 image
> run on mcimx6ul-evk, load zImage and imx6ul-14x14-evk.dtb from USDHC2,
> start Linux, mount the SD card root file system, and reach the Buildroot
> login prompt. It also documents and tests the existing direct Linux boot
> path.
>
> Patches 1 through 4 provide the minimum early-firmware-visible state.
> Patches 5 through 8 address i.MX uSDHC behavior needed by U-Boot. The
> last two patches document both boot paths and add functional tests for
> U-Boot and direct Linux boot.
>
> This series is based on:
> <20261014012323.322790-1-bin.meng@processmission.com>
> as the sdhci changes have conflicts.

I've reviewed patch 1. If imx and sdcard people review the other
patches, I'm happy to take it via target-arm.next (ping me at
that point), but I don't currently have the bandwidth to review
large Arm SoC/board model patchseries myself.

thanks
-- PMM

