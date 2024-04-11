Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1EECD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 10:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rurx9-0006TH-I1; Thu, 11 Apr 2024 06:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rurx6-0006HQ-EL
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:46:44 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rurx4-00053D-Ug
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 06:46:44 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56e56ee8d5cso6507098a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712832401; x=1713437201; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vbkLjk7fSqzJjIzpx+/g4deWwnUPCXq7b84Avz4t4Dk=;
 b=NqVZYDjZXCPlGN7eQrgh/B8zFVDzFXkjHiwOXO8GHPjrnSXGboyRLILqoJ8ig8eoXn
 l9zGwyQqNDcc+jlrAhnecjPYxS+FvrjO8fYufD7vkXFO3Ps67nJD8SouBnoX0pr7XOk3
 jhB/8Q396M7NmEDvNFfbFdftSTA3Pm4EPL88MvaUtXtn8piqw2tBQsht+WS8dbeVqzUp
 ZoxZzbqf5vCYLpUDy/S+bV1so1TGkocfMekTbvsnqXtrMzEOc++IojP+Xzgw+BDedAYl
 0QpdRzbgLWI8x3wLl71rQkKj7hUGdIsnxSfd+9eSx3sVRbe8c6b6UUUEL38XUF+EGJxz
 +F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712832401; x=1713437201;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vbkLjk7fSqzJjIzpx+/g4deWwnUPCXq7b84Avz4t4Dk=;
 b=diYhxFht0RL3rTroqih0cuVlsSqpIxtInH1hzfIPlNBuv7I+ZYBMf45FiCFgBsxOtJ
 netgRq8UGfm8gBPPq5i/homXFvnnlvd9DSpWh9lJ+VL+KhDuklQYzoB6MB/qwcD49p52
 V+puJn4RlzO0v8Wer0qg/VqMrwEboFk496vDdMTtY00wnIsUJmQ69XTfMm7UDqB7vkdw
 +IUaUzgmZ7FEj+E1Xj4+EA54y+o3l2JgyHDlJzl7FL7qhRNR4W46ktWs8BNjevdRbckt
 qE/7e2ACjKmREvuVlc35QRtXohDPVfIbfjZhnY0rtbyZqyxAaxlOMOXD79LjSm3wpt46
 tHLQ==
X-Gm-Message-State: AOJu0YzGSmstSXPbj/Zk8r8IYevXa+HB73oQnsIzxZGzGNdWOuP5GnBU
 v+Jd+uEzviEdbTa+EIvn3Q1k0s+JZ0epi5PEC+v5EceigWxeW6NpArDtISzYp27N8prYy5mCMsr
 oRuQ9ux8TCJ90CN7Ho6+qeSZXxd8COmIZj3dKzA==
X-Google-Smtp-Source: AGHT+IF8HhxjCUu34evUGWEZ0hJ0lxCW5q+iEzpHoDV9B+DfmTJn2WtoNcY4GuM+XqDMtrXkBV6r2m+914k/EEQvTH0=
X-Received: by 2002:a50:a6d2:0:b0:56d:fdb3:bcc5 with SMTP id
 f18-20020a50a6d2000000b0056dfdb3bcc5mr3907275edc.12.1712832401239; Thu, 11
 Apr 2024 03:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240411104340.6617-1-philmd@linaro.org>
 <20240411104340.6617-6-philmd@linaro.org>
In-Reply-To: <20240411104340.6617-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2024 11:46:29 +0100
Message-ID: <CAFEAcA-oDLAE1F9MThZBRabDeD1B6XdTSX_Qw_8PRGiK2Bjy9A@mail.gmail.com>
Subject: Re: [PATCH 5/9] hw/misc/imx: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 11 Apr 2024 at 11:44, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/misc/imx25_ccm.c  | 2 +-
>  hw/misc/imx31_ccm.c  | 2 +-
>  hw/misc/imx6_ccm.c   | 4 ++--
>  hw/misc/imx6_src.c   | 2 +-
>  hw/misc/imx6ul_ccm.c | 4 ++--
>  hw/misc/imx7_src.c   | 2 +-
>  hw/net/imx_fec.c     | 2 +-
>  hw/ssi/imx_spi.c     | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

