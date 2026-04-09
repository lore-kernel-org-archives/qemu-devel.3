Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DB2F31E22
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 15:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wArDO-0007rV-Jy; Thu, 09 Apr 2026 11:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wArDM-0007r6-Tr
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:22:40 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wArDL-0004H7-89
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 11:22:40 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79ab5fd969aso11202077b3.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 08:22:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775748158; cv=none;
 d=google.com; s=arc-20240605;
 b=IOLAIRI8IUaAXLZE10F5YYkadKQVQ+Sv+u/UUKWr0qRUP+7Rqg/REyeUPshVtyDAQU
 KWIeJqI7zjgf4eFcTMQijmt04GrLAUiSE80hKWO0fRR9OPVRWJGE6EkCqidbKmZqlRc6
 QE4KNK42RrNrDF3Qp4sXgYTs93Kx+Y7EhiwOu/NVVcA222w7SKbytNtsDoA6jhSb83/N
 Jtv8QZQzfxqhR6f/xCz+CpuEQMcwcgvUW+WqGsB6Egr9zykyioEcYU77aS2VH/gfbekp
 c0CAL3QrYCw5X+M8SBDkwkWqAoljIqup4ObsGOqXxRRt6QCniHQyURlASMPO3z6M+Y9k
 3YQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qJshqtyhL5Fi0CwkZiwe4Cm+ggGRBuchLGOYTsL/uSI=;
 fh=VUZ7eJox894qpEuQTEFSefKlY4l3x+uBmRGBSaSsOHU=;
 b=fWPKpTVCqolx9jBGow8353dFunRcMTGlSHxQiZpb4ogMkK5wauUZ3AvI+6iVqCB6IY
 asJHTzkGmzFUL8EXRtMogdjVNZWm85h6uO0hPZIf40c6CD/IPDy9jUpeUzdRoZ0ojBO3
 QKxPWqBrcbVEZxV4ssGbHjF+tm4EOtYgE6BqC8wwP9hM4pceK9gvn07MQNkb0VPFG/Ed
 860DKsJJlSa3cUT7JEfs4KpLg+1sA0DwAzQiCLR+x5SJJyjOR/IzZZBcXRbwqSuCINqH
 kX2gSHqRCn8N6UXJeuM3bSPx449WAnVodp+AV2yTCQvCHajoB3C6TRoGiEb/dwlyvvic
 gaqQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775748158; x=1776352958; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qJshqtyhL5Fi0CwkZiwe4Cm+ggGRBuchLGOYTsL/uSI=;
 b=aTJvyEOe0W7jZdrlynU08dg0s4Mkb5fdOiFAisN1xaf5Gopplas1AnuRI4jkpiRJWI
 HavelZxMvzR2h42b3uUeG0rKu4lxYwCBkNR88myF+SKpqsqkSXOdp4lKc4Y0J6dzUhmm
 yRrCWOW8HjTAl0ERjXz6z3nLzzFf51UFZYmr79gDD/ctSbU3wYq5ioNHYLeYVnd4wPIN
 DcIvIfufgCuULnLbeNsIkfAaRQH0MuuSCbKc2qY39g25D2JxkoX26xmOFldeRRNGel3M
 XehWJuKAQwjNQoTSj4X+aNZQxRVC8F5UF1+mcZtSGpUOcvVqMU/FjkaUbd2wuwW5QMAM
 mRsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775748158; x=1776352958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJshqtyhL5Fi0CwkZiwe4Cm+ggGRBuchLGOYTsL/uSI=;
 b=k0hdDs4+j0bw/XsY9+/nZOLrqRNLFiT+CN5qEo3dw5/78/9zfoxc7pd8wY1qlGWhxp
 /OkbLPb3Sln9FQu6qDIx1lDtwg8Zh11RJ1kUK/g7YVJ+NcE3Y78HkfydllebVfLysmgI
 dDePAEXVV026xraJlJHhmJJa3y08gTtIhGYL4VmseR0Esiw/UOsN8G5zXq7YVp7aYIW6
 r+CycIkE6pHZIH1Gpljie5ZrEcYYYHZX6bvtvA8VeJwXrRK3lZHU1xDKLioq/dn0b6k8
 7wqYuTnMSF7aTtHKf3kJR3S/q5jzl5vi9HtBIwvmidIs0Fhtv0Ie5iU3vmMBdp00LUA/
 tAXg==
X-Gm-Message-State: AOJu0YzOT1MtrUlRth+cTsBsQIFogEE6d/uA9OifDjrvQCPhBOcqpFrR
 lz1TtiCis1BE7E6W/+Lfxv1U+6qLItyLS3Czwv4T8mmrOTqqRm0eobMOjipmcASVpRTxl1766Pf
 4zGEvul7H5MuhAVbuPGP5ui9RS6XzgCoWLSTtcSvqKA==
X-Gm-Gg: AeBDieskrurIIeD6GEAcDKvo0rFu3okRwXNxESDSlCV8yqKps4P75jn5381lyXc9oCE
 Rc4s0giQYBqgXIbu6YzzmhlidR+I/KqCZCPNRX07TxidrtwXzBbhIZWi8vZBA3jAwaqFeH6Gyc5
 2aS8cUMk3Wf7g9OxArmfkeNdJ8KfhKQCMw1Ev96eVwX6eYlmiNJN8JZJzWnSefx0KpkKIMe4KMG
 30EGBs2ItoMXrrKgqeozB97gEWRN8r6qxXcVjPTaVaer8m3c4+gQctF42xe1a70+efQGoJtNEfi
 xro5+OVJFEYM+cANr36FD7GOEU597N70cjCNGxP8yshkfS6TgOI07HJWuoJsJScQk2w=
X-Received: by 2002:a05:690c:c510:b0:79e:8299:751f with SMTP id
 00721157ae682-7adf0ebc8a4mr39196277b3.7.1775748157501; Thu, 09 Apr 2026
 08:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260306121511.1781020-1-kchiu@axiado.com>
 <20260306121511.1781020-3-kchiu@axiado.com>
In-Reply-To: <20260306121511.1781020-3-kchiu@axiado.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Apr 2026 16:22:25 +0100
X-Gm-Features: AQROBzDdHTaHQiWZ0pWpILfYRaDE19q966rUxB7TojkF0iYBpz0acYi92JrrSLs
Message-ID: <CAFEAcA-yDSiumFrj4R88B0ZrB_jjK1JEJBQok7wUi=yN+vTNGA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hw/arm: Add Axiado EVK board
To: Kuan-Jui Chiu <kchiu@axiado.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 6 Mar 2026 at 12:16, Kuan-Jui Chiu <kchiu@axiado.com> wrote:
>
> This patch adds a new model for Axiado SCM3003 EVK with Axiado SoC AX3000
>
> Signed-off-by: Kuan-Jui Chiu <kchiu@axiado.com>
> ---
>  hw/arm/axiado-boards.c         | 78 ++++++++++++++++++++++++++++++++++
>  hw/arm/axiado-evk.c            | 38 +++++++++++++++++
>  hw/arm/meson.build             |  4 +-
>  include/hw/arm/axiado-boards.h | 41 ++++++++++++++++++
>  4 files changed, 160 insertions(+), 1 deletion(-)
>  create mode 100644 hw/arm/axiado-boards.c
>  create mode 100644 hw/arm/axiado-evk.c
>  create mode 100644 include/hw/arm/axiado-boards.h
>

> +static const TypeInfo axiado_machine_types[] = {
> +    {
> +        .name          = TYPE_AXIADO_MACHINE,
> +        .parent        = TYPE_MACHINE,
> +        .instance_size = sizeof(AxiadoMachineState),
> +        .class_size    = sizeof(AxiadoMachineClass),
> +        .class_init    = axiado_machine_class_init,
> +        .interfaces    = aarch64_machine_interfaces,
> +        .abstract      = true,
> +    }
> +};

Are we really going to have lots of Axiado machines such
that we need all this machinery with an abstract base class?
The simple thing is to define one machine that directly
instantiates the SoC, etc.

> +DEFINE_TYPES(axiado_evk_types)
> diff --git a/hw/arm/meson.build b/hw/arm/meson.build
> index c3c96c0a70..993a95d33a 100644
> --- a/hw/arm/meson.build
> +++ b/hw/arm/meson.build
> @@ -106,7 +106,9 @@ arm_common_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
>  arm_common_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
>  arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
>  arm_common_ss.add(when: ['CONFIG_AXIADO_SOC', 'TARGET_AARCH64'], if_true: files(
> -  'axiado-soc.c'))
> +  'axiado-soc.c',
> +  'axiado-boards.c',
> +  'axiado-evk.c'))

Don't hook everything under a single KConfig symbol like this.
You should generally speaking have separate Kconfig symbols for:
 - each separate devices that is part of the SoC
 - the SoC itself
 - the board

and the Kconfig stanza for the board says it needs the SoC,
the SoC says it needs all the devices, and so on. The way
we do the various imx6 boards is an example of this.

thanks
-- PMM

