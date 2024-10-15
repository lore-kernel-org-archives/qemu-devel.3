Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D15D1D88F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 16:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0kRC-0003TW-7q; Tue, 15 Oct 2024 12:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0kR7-0003Rp-Ht
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:30:18 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0kR4-00072q-UZ
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:30:16 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5389917ef34so6196569e87.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729009812; x=1729614612; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HVehCFNPqYOnfDLHpkI6OJP54zAUgFuDm1OT6EfjWIU=;
 b=Z+OVd6TG+sAbaTXk3ekMgZKzS9ahpOWvcOrYKJQM8nSNEQK+dtJNQbex8HPb7Q3g0x
 IcR9q7KV0fcQgiaFMeyiE65OiecBx8Qpmis7gxAHUPy+ABVpRiqTH+ugTDTqh8Domr+5
 TSCnwHVFhTfJ/Swlnaql0kDLlTDa6qRz2cbw+wmPrA7kNfxYaeuxYw5ZI0UPmDqlY3QR
 f70m/S32TYpDdrBtbM75oprP3zh8b6LO7ux3D7wRuRJEI4gURVYIEgNLq5x7N924hkZ2
 azQkY0yDsBT4xDgs60FOGWO1EYqQzjN8IVrJ9EqxxWSWDFGVd1E9+8zvGBA1ph604jeb
 nbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729009812; x=1729614612;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HVehCFNPqYOnfDLHpkI6OJP54zAUgFuDm1OT6EfjWIU=;
 b=j/L9JqYDUITzyPzyksDb1lkj7tn/ukUAfVX0Og8EZjWNjlvcYUYtAPSXU6aLvLAdLG
 g2y6OzCwQq82YIYLTvGadi/F9DjA+VnCVBsWbD5+FbDeYuVPYqH+g4w9SOayH89K3ewb
 nU8VJrnGAImBvjEbYue+eBrsuGYqVlzoDjNzt3XnXSZOz7y6mgL64FvKe8zDlW5VHYgw
 lONycQaVPUAUVojcNViUM0X39imGhxQDPsKudUzhBHlJDTyEHYdvIAmqJUPX+lgUhq9O
 nnIiibdrCRWR5udp68fIETRM72FSaKf7wO27204Ygy2TKN7O8mDqgVo7/d/9Zqlvnsgi
 3FtQ==
X-Gm-Message-State: AOJu0YyfxpRnsVRYOZO49pqOUTXps3jIJD8V+ciELR3mtxwWl7uMM3aP
 0NFpbRP+ZzvD2HF1DpJNE2mIItG0MpDXsSTbRwTzVtpv3nLiG2uTqTESpOyMrK/2ntlS5U2NAFB
 x69Lp8E5zTXKMb+NHWJzTQKLeFj2EcFa7jAYeJPEgycYQ8vi7
X-Google-Smtp-Source: AGHT+IFGEs1cMNDE0K1NeDLDGeaHBRDftP/MsH7O+2i+BpoMLiUfsxuFRr8A6ZCb8XS/kJuPgrt9bP6kC2EAooY8sSQ=
X-Received: by 2002:a05:6512:3e01:b0:539:de03:d7a7 with SMTP id
 2adb3069b0e04-539e551882amr5818957e87.22.1729009811335; Tue, 15 Oct 2024
 09:30:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241015141804.294447-1-peter.maydell@linaro.org>
In-Reply-To: <20241015141804.294447-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2024 17:30:00 +0100
Message-ID: <CAFEAcA_KBmkqmmAHGG5bL-FNn1mN6xvZXtsbPuuCZ6ggpBDZww@mail.gmail.com>
Subject: Re: [PULL v2 00/28] target-arm queue
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Tue, 15 Oct 2024 at 15:18, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> v2: added missing qtest_quit() call to the new STM32L4x5 qtest,
> which was causing the test to hang on OpenBSD.
>
> -- PMM
>
> The following changes since commit 35152940b78e478b97051a799cb6275ced03192e:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-14 17:05:25 +0100)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20241015-1
>
> for you to fetch changes up to f160a4f8d0ef322377db3519c0aa088ccd99edf1:
>
>   hw/arm/xilinx_zynq: Add various missing unimplemented devices (2024-10-15 15:16:17 +0100)
>
> ----------------------------------------------------------------
> target-arm queue:
>  * hw/arm/omap1: Remove unused omap_uwire_attach() method
>  * stm32f405: Add RCC device to stm32f405 SoC
>  * arm/gicv3: add missing casts
>  * hw/misc: Create STM32L4x5 SYSCFG clock
>  * hw/arm: Add SPI to Allwinner A10
>  * hw/intc/omap_intc: Remove now-unnecessary abstract base class
>  * hw/char/pl011: Use correct masks for IBRD and FBRD
>  * docs/devel: Convert txt files to rST
>  * Remove MAX111X, MAX7310, DSCM-1XXXX, pcmcia devices (used only
>    by now-removed omap/pxa2xx boards)
>  * vl.c: Remove pxa2xx-specific -portrait and -rotate options
>  * dma: Fix function names in documentation
>  * hw/arm/xilinx_zynq: Add various missing unimplemented devices
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

