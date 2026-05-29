Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4864DCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 08:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSsvK-0001Zc-Rv; Fri, 29 May 2026 04:50:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSsvD-0001Yd-IS
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:50:28 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSsvA-0003CV-Fp
 for qemu-devel@nongnu.org; Fri, 29 May 2026 04:50:27 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-7dc2b658544so16241827b3.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 01:50:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780044622; cv=none;
 d=google.com; s=arc-20240605;
 b=Tfaqpi0ca+Z9esPiUwAXfwteJmM5hEV8qolcFPQACTjYibErV9YcaYGP16bgkOtiAq
 zvr/9O/na82PuukiuwvECh40rU24iSoub+X8nt165batavIhMwaexsCY/osnP4jz3v4K
 M3boh5BjdeddlytVoUxnPGIR/s4SdaU+Wexp9KO1kxjRVYzaa92AoXEfZe3rs+5yB/ZQ
 H138NBAS1f69YS/UmlEdkIiB+xwZJ70ZWTTHqrXDM7d9FVobPqjqqF4oyUMQdxDqO2My
 C2gFFJMbS49jKan5f0kf5uvB5hQ1gcVeeERa+dnLp/5bS5ggPul+1YWo2PQ92+Tnkx0I
 BtGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DrVOr67pBSyoz+W7dxZk6XghmFcY56Frp1nv3yrTup8=;
 fh=waM909xNckwKm7pPQFH3nLBAWEC+k9YWzSA1XeTt6rM=;
 b=def864xgc+YvyBxEQJyYOZCdg3JK7tc7fOZajcDV56TgyrH6q54ZwAhZYmera2wQjX
 73fSmJgXsWq4qhJgEvsEPd+dqcfEOKukF5URLQoSlmYlxgYwnrOowyB9zmLpKu1wfCiA
 RHBxhp6jjFMuSNlkf9l20HaFfbytpsJSJCuYGQNvPNUMm7OUcIzj3BQ8S7QSaKuowRfz
 LDcubRf8VGaMLzM+djWElgtJUIoU2pQX/npsc+d6Q0EDxrzCc4T+gnHCm8Q5RVM6i59b
 rV8NDtrAmI8I8TGkgVvOyY08VpOyLJ81kZA9z/5srDdIzZnfW8z9qnZZRNqcSv1O8GjM
 VPjA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780044622; x=1780649422; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrVOr67pBSyoz+W7dxZk6XghmFcY56Frp1nv3yrTup8=;
 b=gFzyYNjnZl4/N/x1sGe54Ueky2tZl27RFyRGGrmJg/RkDxdFWFEDT7BcljHTNvwebM
 Njaf81zqI2tD71+oimJ0HRA1pLQjZHEPYvWcOfqYanA0zQtJyyHOkyURCbIzmW2nuO/k
 0AlROKImQ/jzvrIeghKYo6m5DJCMOuJzWCssjUaXFjc6IyUZ/IfnPvCJ7fn1mwUV3v27
 UPFmCFmA5jIfdWWyPbF+kFGPpl06XTMxfTS70Ti/thU8a/DriaR4Ks79ySWhdycivDUQ
 bxx5PleAbDgAmcvwNmbittQUYR7uCJBssrm8LNRDIKGHeP6+ZeNTcJOQ87qon5Y1dbAc
 BOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780044622; x=1780649422;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DrVOr67pBSyoz+W7dxZk6XghmFcY56Frp1nv3yrTup8=;
 b=Z9Vk8r/vlD8nwvJYrRJQyzaDUS2I+fIsEb8tPsRgoh6wr0bTyKssi8SGC5FwiEL9Yn
 PgVpJ2u5RortrLu3G70jKuptzjU1nWWh6VTSoAeS/s5LC2S2yeWK8RGdRFfIgNQKd+HR
 S5/hWZZzaF53KdA8tzyTxtAEst+75/dQvg4jkSOzcfrrKBa6tpuCmZeaWlHkspPLR7Y1
 OO18gcULvE5EtTPLeBYO8GUwuIvMoST9/9PsX/wn3xlSdXQEYyQZPZ18G+a3m0+gSenF
 9PmKdfFLf8R1qZjtcbHJ9UErLBvudIZArYFs6RX1QSttoeWfbds2hjVuR7ghugCJXVR5
 McVA==
X-Gm-Message-State: AOJu0Yx02BcwfeNNz9YL7U+kdlUsfCQtsBA6Y65CFePVqDpaev8zf6kC
 AKrCcv0fNapo8sVbqxP45ZEcs0JplqLRaElaz0gSid0IVKhMi/WjvEAcy2qJzmp+Q8Mod0kf7GA
 NbyMuiIDMoPBxoxqY6HeHkJx2wefKVor9kH5UhXIjkw==
X-Gm-Gg: Acq92OEB/WqvKPgf5yPQ9H2XEQgMjzE9JPlW2RKn7L1kCdd6+p9NTGuqPdXNOs7xDOA
 ax0QhdBV39Dkjtp0sr+lHWCh/wAFCwm3Z56S78Dq0ey/FiojuRbnaeVZd0ShTK3gdG7ob9ZQJdp
 Y3iV4dfW9yoQ23rOmRXTFKRNad316A4nptB42uBvkmkUK4HithSpS127BDL4crNtQ6dcATsav2/
 pRZuUluXFRItshjZhJTuR1PdVuC3LsonTKfYbgcf2Lcb74tB+06I2bxl84b4Meg4d7ygDRuv5eM
 zM3gQYjEOStb9a0lr/aFWTVXiHgZK7sGMXvGL4fOsvFtxY8O+rJwlV7/xqU4UtTXUBLDupYItHV
 fWQ==
X-Received: by 2002:a05:690c:62c1:b0:7b8:3b51:c9b2 with SMTP id
 00721157ae682-7de48f927ecmr15334657b3.23.1780044622455; Fri, 29 May 2026
 01:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1779986496.git.matyas.bobek@gmail.com>
 <51fe163b259b9ff315377b952d38665a18351b0d.1779986496.git.matyas.bobek@gmail.com>
In-Reply-To: <51fe163b259b9ff315377b952d38665a18351b0d.1779986496.git.matyas.bobek@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2026 09:50:09 +0100
X-Gm-Features: AVHnY4IhWjWRG4X4tVHkplq8_jXuu7_G_MkTucshARgDb-mSR8JD7TvUkrwM51A
Message-ID: <CAFEAcA8RM1i3-ixhkOPVRPsyEEYepXL+QjWAY_V32EpPEOux0A@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] hw/net/can/flexcan: NXP FlexCAN core emulation
To: =?UTF-8?B?TWF0ecOhxaEgQm9iZWs=?= <matyas.bobek@gmail.com>
Cc: qemu-devel@nongnu.org, Matyas Bobek <bobekmat@fel.cvut.cz>, 
 Pavel Pisa <pisa@fel.cvut.cz>, Bernhard Beschow <shentey@gmail.com>,
 qemu-arm@nongnu.org, Marc Kleine-Budde <mkl@pengutronix.de>,
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 Nikita Ostrenkov <n.ostrenkov@gmail.com>, Andrey Volkov <andrey@volkov.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Thu, 28 May 2026 at 18:17, Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.co=
m> wrote:
>
> Added the FlexCAN2 emulator implementation core, with
> CAN_FLEXCAN Kconfig flag and MAINTAINERS entry.
>
> FlexCAN2 version can be found in i.MX6 SoCs and others.
>
> More information about the implementation can be found in [1].
>
> Some macro and struct defintions were borrowed from the Linux kernel.
> The original authors agreed with relicensing them to GPL-2.0-or-later on
> the qemu-devel mailing list.
>
> [1] http://dspace.cvut.cz/bitstream/handle/10467/122654/F3-BP-2025-Bobek-=
Matyas-BP_Bobek_FlexCAN_final_4.pdf
>
> Signed-off-by: Maty=C3=A1=C5=A1 Bobek <matyas.bobek@gmail.com>
> Signed-off-by: Pavel Pisa <pisa@fel.cvut.cz>
> Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Pavel Pisa <pisa@fel.cvut.cz>



> +/**
> + * The following macros were originally written for the Linux kernel by:
> + *   Andrey Volkov <andrey@volkov.fr>
> + *   Sascha Hauer <s.hauer@pengutronix.de>
> + *   Marc Kleine-Budde <mkl@pengutronix.de>
> + *   David Jander <david@protonic.nl>
> + */

For clarity, we should add a line to this comment:
"and they have agreed to license them under GPL-2.0-or-later".

thanks
-- PMM

