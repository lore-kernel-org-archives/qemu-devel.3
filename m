Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA6AC67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBmR-00089M-TU; Tue, 09 Apr 2024 09:44:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBmQ-000895-P6
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:44:54 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruBmO-0001ZL-0Q
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:44:54 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516cdb21b34so7144737e87.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712670289; x=1713275089; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XHJAKofpde+C9H1PFyYx60KQ7swMbrzOdT/Elo3VqPk=;
 b=xp4E873dI8RrDnDiVJODrJjSfdV5c6fqzcE42FA+lb+mh/cgB/TJGi/IRYBH0YPlwH
 74IEPMK5h5adDs3Z+T4d0fxCf51ymE2bWqmdPnXhh5OgyaO2npwpkpQyUzczvoFpdYcR
 3RZBH0FJulphC1Mf0IQCwyvUWMUVjGqaxBc+7T96mtNBPPSpvXE9+4cXdBwsd4UP14cl
 hweX5801p5HMGBQeIq98w63OzEoHevPPNOXkoQWlxt9WGgyEIINpQFoKxAdeVExIQmgR
 vitDAYqCtjRXcv04XJ/uq5L7758z4GlPAY0kHC9e1rdo3ExDirsqWK6gCsn4/+lRc6tV
 MDeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712670289; x=1713275089;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XHJAKofpde+C9H1PFyYx60KQ7swMbrzOdT/Elo3VqPk=;
 b=rXfjUGPdwDlULwceHFHgAYIxN5j6NQQR5GwoFwp7KTLIQNqbg+58qkKOynGhor3+It
 skv9D+DUY8OCGr5AMpEvE3jrHZ3wTn2+7MkIA7iK8MvspFhrLIvi7s0gEZJ7bemeiXLT
 Hz6BCjptzULqRGRloexvL6XyueQpoG2VgPDvMe2ra17UBNic8MWCuBUw1Y7f6TfOocUP
 uJaClexh0eOw4Wq6+YJbt9um2NccobX0qb9IQ3lAHaxm2DBMUyERPWiYwpH8PdrUoxA7
 uCLCgXSopyH1iKF2vCCkuLwOGtVB4Vo659183cVliUFuvBlK3HT3wAm2D74urLrPaQ4D
 jIBw==
X-Gm-Message-State: AOJu0YwNhmlWWDOuw/GP1k7fZ1J7L6V52pLCFRbjuekSK/dBs8EaouZG
 LxbEz6dI7NT7Nr1KtW4tsETHAVDEcs7iN8xLaTCuYLA3QR3SHXA/LXtAAkoIkyEpshZ7j2xuBD7
 xfWYaYMOBCKmaOb8EF3Z5M6kwW+55ir9tUAjtnA==
X-Google-Smtp-Source: AGHT+IG8grxFvGIOZTN/yRK6iFbiikEw+J5VULSe4eMEIrcSbRyxgW8SLm0QmzZ6+iGVg+/2rTQE3cG8n0qXE6iwd5E=
X-Received: by 2002:a19:750b:0:b0:516:d471:18a0 with SMTP id
 y11-20020a19750b000000b00516d47118a0mr7052254lfe.67.1712670288840; Tue, 09
 Apr 2024 06:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240409133801.23503-1-philmd@linaro.org>
 <20240409133801.23503-4-philmd@linaro.org>
In-Reply-To: <20240409133801.23503-4-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 14:44:38 +0100
Message-ID: <CAFEAcA9NrzZyXrpfcs0RdvfGgYFjNkapY+V-5Y0HLNgDHyFfeQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 v2 03/11] hw/net/lan9118: Remove duplicated
 assignment
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Chuhong Yuan <hslester96@gmail.com>, 
 Jason Wang <jasowang@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Tue, 9 Apr 2024 at 14:39, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> s->txp->fifo_used is zeroed in the next 3 lines.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/net/lan9118.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
> index 91d81b410b..d6f0e37eb1 100644
> --- a/hw/net/lan9118.c
> +++ b/hw/net/lan9118.c
> @@ -438,7 +438,6 @@ static void lan9118_reset(DeviceState *d)
>      s->hw_cfg =3D s->mode_16bit ? 0x00050000 : 0x00050004;
>      s->pmt_ctrl &=3D 0x45;
>      s->gpio_cfg =3D 0;
> -    s->txp->fifo_used =3D 0;
>      s->txp->state =3D TX_IDLE;
>      s->txp->cmd_a =3D 0xffffffffu;
>      s->txp->cmd_b =3D 0xffffffffu;

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

