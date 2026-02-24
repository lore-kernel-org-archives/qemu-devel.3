Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81DF1F4BB65
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwUG-0002lo-Sy; Tue, 24 Feb 2026 12:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwUE-0002iB-3V
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:18 -0500
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vuwUC-0005DG-HT
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:46:17 -0500
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64c9a398bc7so1578240d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:46:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771955175; cv=none;
 d=google.com; s=arc-20240605;
 b=NE1+32fYwA77eLlZx9K0XMKPY/BDHsfBm1nlP9kPCRyzK+Go/67SUU62cLRcSEpIsg
 +7LG/cXjSWDsDML4x03DgGpmkuojxrsDAqEm4rATW1/IdvxMb9MKBUCupOqOhnxfAIC9
 pd4ca/ZIOXNy4pFPCgqY8GpzdiQetgRdBuK36rA9TXrYKdni5Z16QeFJyCm2mgbtgqP1
 GDxVQy11ls8dYk2TEBK7Yt5/gORuzlkc8+SjWKysyQOShPp5R7RLP/3sLGBS6B0khPz5
 vyGviGJcj+kWq5PJv19tYlL2sRoEEUkdqRqgz/qnkfz8QBLwWwRwr+D0ZFkN3/RIgqay
 DZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CQE21tXGJCAHd9dP6vrG4T8bnEpBZFaF++JScfs5Kzg=;
 fh=R84pXDYvJznuJb5dunrikqaEeI9MgwuEGgEYHxBIZ1A=;
 b=MfxySZ4dVsNDoIgl0rl3jB9LwSAeH4rVtsETcHAszS+nMSyevePw0VE+0YLobIYN8V
 6+ApHqnvp5EwwIMkkW2TxYJme9r5XdbVlVfakTcv9+Lf/YcyeHBK9OcGnDprOH9TkPgP
 AFDstgrecav9SLqANWIuGj/rhkoLOA3lx2Fh+CE6f/zrRbr+3lW7sF/Z5yAJCOaiOAg/
 JNEuoHiHovH/6o26NxKaqpicpUQCZf07of5GNhTcWH/fPgkz6lJ8JtXMR737BwLaeDDm
 rr/QTW6PgMvzAdMQ3+27bOrWC0lgQYVREIR8e8ZqdLomtB/fJs4OmnYznXDLsjC1UPvq
 mO/g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771955175; x=1772559975; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQE21tXGJCAHd9dP6vrG4T8bnEpBZFaF++JScfs5Kzg=;
 b=DqecAe+lshaaFxUv+/Xzm0ANv4MVmihxoLfFrHUBs++VA/SRXAcnJXeiJIuFYoEEI8
 KAbp3DDX5gxZcoS4r7SxgDhZFu1bNz8VuePD6jYHELnOSQmIfKx0Ynv6MfP+VIVrWPck
 xxWFjZ9sPXIuMh9jHAcv3p8rTIKObcYkqI2JlmM1Lwg4yuqP4pCVegzOoM5a33/zA6zL
 U77BRCMoWyvBFWKqnJ31fs9ZLxx5DRe+y02By41RjHapz+8j4ivZg2wsTnGNmsrz30J5
 XgHKe/BLyI0sDyeuz1gjTZb6NqL7rG9HrMWEh5ctbWXPDs1vDMgLOiSMZA7vMY3jkFD0
 W7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771955175; x=1772559975;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CQE21tXGJCAHd9dP6vrG4T8bnEpBZFaF++JScfs5Kzg=;
 b=Tu4Iy7QsLpczv7hXIfY4D+OTqYjrxloWl/9IkCzYYsAWIdymvDPffLLfRc+qk4AJF1
 UUY8miJR8I/r/jVcC3yt0bjee7BPxsCFESzdhbHbgBB2tNYz9x07uxId5/EgfOeTZtZT
 /KSN+jXVWZ6E52rnR2g9gKaYSXVEd97891tqWXkJocJoPJX01rrUOlM+yvm8I/PnOOFS
 VvPnDgTGSl17yGX0UjIT2yCExdjYLcQ3CPzGOEWM9Szh1R6+T36pqrtmb3+hoBaEMrk/
 QznkeaW6AaKEDxaeLoVVHH4duktGCmRyLeUnOnhsQrwqrE+jog36L6UZVlcKhlV8tCN/
 XP1g==
X-Gm-Message-State: AOJu0Yw6dlPhhHeDFiFKIeUQ8fBJKZBbgsA50zo1uQfUEAboExaj4io+
 ibHrbRrxQW6wjlahknYIQgXDPEk2n5LUoywWzXcDEzsf9HvLejAxHA2FrIyix4SLeKMU1aq8KpK
 QAeo3gYUB12MID6fkIXzrv7hdQJEyDPXLR3+fz7yvcg==
X-Gm-Gg: ATEYQzxBM2Yh+dj4pTv3vnef5rAH4DhgOFyRNsLLvoEaVZmCpeiEOhr5uN1xh1alK5I
 x66gOnrtEU4u8ceFq8tK2zUiXkPJ+MW1TReCvbcCuBHPEyDk51QxdN4Bl0bZl9++7stx3nCgTXi
 YhYmekOF7uhDUNegtJ+0jFcLC3fXQungBQyQTVwFDK56Sh6IAm7CnKLe+d9UJHkqj4xoZZqy1tC
 EZgbT6/X7rg/h1uXyPskPDY51RtKRH6hL+Yj1PCCP4gUDEghd6Jyl6PuFqO9wMAWC0+sxROEb/C
 VZS0JSXu2sy+1nS/aNJ3LzAEVMQVhR64pidA3YfsJDW2S59yay32ZHAdResXqI5mFa0=
X-Received: by 2002:a05:690e:168d:b0:64a:e3dd:58d0 with SMTP id
 956f58d0204a3-64c786d10a1mr11130440d50.15.1771955175253; Tue, 24 Feb 2026
 09:46:15 -0800 (PST)
MIME-Version: 1.0
References: <20260219171810.602667-1-alex.bennee@linaro.org>
 <20260219171810.602667-14-alex.bennee@linaro.org>
In-Reply-To: <20260219171810.602667-14-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Feb 2026 17:46:04 +0000
X-Gm-Features: AaiRm50ItoAXOhS6svP9VdlVvft6M2sYrK1WnPTGpygYq2YRl9NltM5lvx0dZC0
Message-ID: <CAFEAcA-tdAfuAAsDuKBZOfAtNtsvdf44Z=vf9XvC_0tba9i43A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 13/14] target/alpha: move cpu reset into a proper
 reset function
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 qemu-arm@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Aurelien Jarno <aurelien@aurel32.net>, Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Yanan Wang <wangyanan55@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Thu, 19 Feb 2026 at 17:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Now the alpha clipper machine will execute a proper reset we can use
> the reset mechanisms to reset the CPU.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/alpha/cpu.h |  2 ++
>  target/alpha/cpu.c | 10 ++++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)



> -static void alpha_cpu_initfn(Object *obj)
> +static void alpha_cpu_reset_exit(Object *obj, ResetType type)

This should be the 'hold' phase, not the 'exit' one.
(The general rule is that "most" stuff happens in 'hold';
'exit' and 'enter' are for special cases.)

thanks
-- PMM

