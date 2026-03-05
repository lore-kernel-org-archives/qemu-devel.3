Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A481F30937
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 10:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy6NO-000312-EV; Thu, 05 Mar 2026 05:56:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy6N7-0002t8-M2
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:56:03 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vy6N6-0006JU-7U
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 05:56:01 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-79860421382so76129937b3.0
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 02:55:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772708159; cv=none;
 d=google.com; s=arc-20240605;
 b=F6GG3aSmYlUe+86+ogxnGMXpKax1h2HiYfM9/Y1y5b7IoqGb3ap/gVsFv2lRVzMJR1
 i1e0CfZmuyq2m37jWHC+zPmOqrny4FAoebQLWWkMFw7cjIN4+OL1vzP2BBFiWnTUpg2A
 ELmwuKR6Q7uZwM1BOm1rVvgkoB9ZXdpwCwW+QgULJyVlUjEnagOeBzBJRV7h5TLMEzTy
 NScdLym1A50I9ifzorkbqtap+Fl3OCwU14tl2/Clk6JtMG+8n6nSjpX9iOXx8L6pIweB
 6j9OR1EXQOXNNqn7veJgQ6Maa/GGEgw5N/Go/DEDDmG2N4mxcfAOxP0onQqyT13uDucr
 6OIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ACrG2WK2Y9KnAR5R2CA69uCrJCAKoLIMjNqhEB6lVRM=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=haqh8hhU3tiDqRV5MbsqVPzMcWUR104aKFvnVbJgaNga0Q/hAlIZSlJbZnfOWxGSQ6
 cVAGJRVsWKLzZbF8VpwMEzdGk42YHOwzyTwVK/CFFjKneYuAoRwGzP1I9cKKxo3XGiho
 fNGzdd4XK6PauE3J7TNisWTgNquTRPBS+59D/D/oJc6XXFpGrgYJ2ccOFDpa5yfpWXyi
 P2QFY4EVzv5BmeseQP8sO68QPwqxvliOdcpsl1qJuwEtRGrv/1/y3zqbF83yh/cw5DN1
 t/4oah58iFtyNZnUuLIF57eqRojz68z8LIKov7LkRat7NBgXKuY2mgBbYul5y4eD+Yav
 E+ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772708159; x=1773312959; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ACrG2WK2Y9KnAR5R2CA69uCrJCAKoLIMjNqhEB6lVRM=;
 b=KV6pnuU08lZ0WMj6jLPXtrA8T+FGqOF6tKS/JJOKJV5fbS6YJqUvFoyXyeMpP/qoH2
 JEIodYoSAZnBBrcg/vTmByUq3q/fSgLDv/Gs+jRIJPBmciz1ZlCRJI5b9KjA3fqTmKAd
 TTs4qVOiRZ9SOH0pcMLOKdsHi/73xqjMnc22Xq71oBKdUqtnbXiIHFr6/yaPAJLRxHZD
 yJMMkjZJ4Ge5pQHnE6/c55DRhKOQgqbetrWJljA0XacjdZAQysf+GNkJcedX4ipEILVi
 IqKKHUaGMKhMzx19Vm0aUzoFanLgEyI9+uY0XL16uvCrmN+WI3sPSjHkZzTgGUrUf7dN
 aCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772708159; x=1773312959;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACrG2WK2Y9KnAR5R2CA69uCrJCAKoLIMjNqhEB6lVRM=;
 b=rTbFsg/h7DS1WWn8cTzSL6LYiLpfhQKNMB7il1LeU/xUb+t5LvfjYGievADmkwxpGc
 HcJpOFQoawwxyDJixrSZGTBB3LqzsXzhvjP88gkQDdgEIA5seewUrnzrvGl0GC6S+luV
 Ydcnj4c70EZZuHFrDV2sPAcHNb4CGTxV/Jy7feZblv3iJEh+lJKsvZ2iAlOr+16lPAuL
 YuLsdGjt/QjWNgN4aM511Wr0O+817TcY5g6PDPZnUyLNodrbHOzerCQRtLaMzREY0Dam
 qwjS6rY9Kcm4yGcC9dVzpv8dhGrd74RzRnKhN254QEn190LuXE4Pqu/AXoXc0NyRZEGB
 eImw==
X-Gm-Message-State: AOJu0YxQ1/puJtNM3p/OaMod8M+E3hadk/ASHMZC/PjBABsBjoqOpZzM
 z4xLctYw87Flm/MTwnqtY79JubFUUYguAbC+5gdUwyxcPxxy1bfrxlHVoyTjDbEL9Ny90J1nDeX
 V4PaPVFOPseKFK+WCCl8baGfbr5uZFA7+lnF7EfdlxA==
X-Gm-Gg: ATEYQzyCtNCeJ/MCBAL+1IRw3qutvX8PHXZsIRbS862epeDoyRk1eb4pwZNUWmfmFV1
 Cl9WJdX4h1tMfllB2vZFAxnWVY3na3OY3DwAVf5fcxmc53e/4NC+iXq1OkoXs7/0pkTf7dTrm5g
 WzrwyNmG+duvSm5gik5MmBlUyQ4cmvKwBG9hYslbqazIKXNWi6ciAcalhR9HGBLawyuaJBkUSck
 AapDUrjyAGk6sZ2i78BEREGABCpbQdhPXbRPs3Tg1f6C/WUK6VwHhM8ymtX8fgiUOBhhTJNgesw
 eEYZDh2CJCWQbTBumSX5W+Ld/OCpDki8gcKJoRf7t11zVWVedPMdg2Y0oyNut+TKdZY=
X-Received: by 2002:a05:690e:bcb:b0:649:ef06:15f3 with SMTP id
 956f58d0204a3-64cf9b27344mr3887713d50.10.1772708158865; Thu, 05 Mar 2026
 02:55:58 -0800 (PST)
MIME-Version: 1.0
References: <20260305103400.1574217-1-kchiu@axiado.com>
In-Reply-To: <20260305103400.1574217-1-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Mar 2026 10:55:46 +0000
X-Gm-Features: AaiRm51t0fHOQS57nr9dSyHrTBjhUCH-EHt5vJMn-_wCL-lf38ozjDZCnj9DErA
Message-ID: <CAFEAcA9hcr7sDHvv-o_YRkaBJLTt99Uh=DgLtTHw_=jA6A4j5w@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Add new model for Cadence GPIO controller
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Thu, 5 Mar 2026 at 10:39, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch seriers add a new model for Cadence GPIO controller which
> supports 32 pins and interrupts for level-triggered/edge-triggered type on
> input pins.
>
> Also define new trace functions for analysis purpose and new configuration to
> enable this model.
>
> Kuan-Jui Chiu (1):
>   hw/gpio: Add Cadence GPIO model
>
>  hw/gpio/Kconfig                |   3 +
>  hw/gpio/cadence_gpio.c         | 312 +++++++++++++++++++++++++++++++++
>  hw/gpio/meson.build            |   1 +
>  hw/gpio/trace-events           |   5 +
>  include/hw/gpio/cadence_gpio.h |  66 +++++++
>  5 files changed, 387 insertions(+)

Hi; this patch adds a new TYPE_SYSBUS (memory-mapped) device,
but it doesn't add that new device to any board models, so
this is dead code, as it stands.

What's the intended user? Generally we recommend adding
new devices to QEMU along with the machine/SoC/whatever
that uses them.

thanks
-- PMM

