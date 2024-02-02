Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE6AC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 15:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVvXF-00043f-7f; Fri, 02 Feb 2024 10:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvXC-00042Q-TY
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:54 -0500
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rVvXB-0000Ix-67
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 10:32:54 -0500
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d066b532f0so33817331fa.1
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 07:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706887971; x=1707492771; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K4cGSV6JcNnAfF+ETkPxS1EGEHfUGAqXOX6faYwsgNw=;
 b=N2WjGeuerQn8Wk+rSGamnbSzqWcY3mhb93Qh1aeU97qzGJBXNKDX/vEzVtq7br1Odq
 TPJ3S/VMPWVgMmFdzYKP/D3sAeamCEjfPMd6ina8KuWuOkiJ/wuNJLmQRithiBPywX3A
 qa/zTBgz8xi8wv0AMUcc0XbgBQbGzFaZQjyrG4qcPnqe7sCQQXuginiWOijiSTLsi43G
 u3SPpF83fuLbr0Yf6VOZ4c4dgx6i1tye4f2oYo5yjVazEeDqiBhBNRsf7/L3y+HTezG0
 QRyRzQw5fO0LSm1q0xRXLnjILXl80b6RiiAE3jzYhQxAiLjwkGDo7QMUKvJKJs2NlWVb
 /Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706887971; x=1707492771;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4cGSV6JcNnAfF+ETkPxS1EGEHfUGAqXOX6faYwsgNw=;
 b=suvm00w6bkAEe7N/+S9xHUwwA6Rcqf0PYbEEP2BUz6aaNDdAiJgqYZlpoL+VX3urtf
 fr+MJDYe7FxB8pX5b/l99WZAJZoc5g2EsxS5r+oAs2A1Vfg2NCvRqT5+YaRq2mzqV0hD
 +s7vHBVc8BFDGAeyGcGSDXdM4aR3a0l3vjhFO+YZL0ORWa6a/XEHAcyM1VIEN5rQoGTi
 9E3cd9UoW7qe5OZ9fFuBQty9n3/n6UC2VAKWHSvYw3/aNqSdtAfbj/H8kCCMpHZ1cvQl
 ArpUS8hxdj6JmS5uO7cVGNOHARoWVUxuW/e4smOvPsHm8VUdVCCtuo5vZaAFhVq0u7+h
 WQbw==
X-Gm-Message-State: AOJu0YxfcrN1gySBOf2WI0weUah2pgUwTd5SA/+ep7HcsvE0cec8HDlV
 9H0ItaB1vpmTTXJ1VONZb4Ucka5NGj0f5PcSEdOpiq3fmDHYoKMBxA3GgYN5BcwRCEc8ihcb5cy
 kQjslIc7ymM4tcPZnyE7bAWSqnA77OJwlSSWAXw==
X-Google-Smtp-Source: AGHT+IG+OF4aDgKgbX9g7anPNNuAQVVSAwr4ew/QkC5HNvH+lLtfx+ivJTDDXfhYw58E8sZoAWAF6Hyg8C4tkowhiNY=
X-Received: by 2002:a05:651c:1551:b0:2cf:48cf:dbe2 with SMTP id
 y17-20020a05651c155100b002cf48cfdbe2mr8583404ljp.0.1706887971142; Fri, 02 Feb
 2024 07:32:51 -0800 (PST)
MIME-Version: 1.0
References: <20240201164412.785520-1-dwmw2@infradead.org>
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Feb 2024 15:32:39 +0000
Message-ID: <CAFEAcA9-e=hzN62vkq-P575yMvjqmm1sNwNMswUDnqj1gCRmOA@mail.gmail.com>
Subject: Re: [PULL 00/47] nic-config.for-upstream queue
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22f.google.com
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

On Thu, 1 Feb 2024 at 16:48, David Woodhouse <dwmw2@infradead.org> wrote:
>
> The following changes since commit 14639717bf379480e937716fcaf1e72b47fd4c5f:
>
>   Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-01-31 19:53:45 +0000)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/users/dwmw2/qemu.git tags/pull-nic-config.for-upstream-20240201
>
> for you to fetch changes up to 5382a24c9b0be4391ea91b020bb72ad15c05cc88:
>
>   net: make nb_nics and nd_table[] static in net/net.c (2024-02-01 16:21:52 +0000)
>
> ----------------------------------------------------------------
> Rework matching of network devices to -nic options

This fails "make check' because some of the qom-test and
test-hmp checks fail when the QEMU binary segfaults.

https://gitlab.com/qemu-project/qemu/-/jobs/6084552256
https://gitlab.com/qemu-project/qemu/-/jobs/6084044180

Reproduces on an x86-64 host if you do a build and 'make check'
for all target archs.

Generally this kind of segfault is because some machine type
segfaults on startup. For instance:

$ ./build/all/qemu-system-hppa -M C3700
Segmentation fault (core dumped)

(It's possible that's the only machine type that has a
problem; I haven't tried to exhaustively check.)

-- PMM

