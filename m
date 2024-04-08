Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254FDCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtmKw-00005X-Gv; Mon, 08 Apr 2024 06:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtmKv-00005N-Oo
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:34:49 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtmKt-0004eu-VI
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:34:49 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so300615a12.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712572486; x=1713177286; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K5T6j3BaX4BEctJVxLbqu1H5TQjdw3HgYPlXWiWeEHI=;
 b=zGVs18SQaYrKotojUzQeg2m5XgUHI0ZZhcXvyW++g2ceowywvP9K+ICXihQVX7vL0n
 byHp15BlZLdYfLDSzh7pK2m7fhZ9xWj6jS2tm06IVHnaf9rTQDrgumtzs2gLYPJkv1/R
 hMoKrdAp7E2cYE/d+O6D1kysi5kcAqGFdyMg7oJC9ZJ7Jo9tnKxM6NNxAUmzL7aiqE3C
 RuE1O0l3WVXG7Qfc+cF5S/jHc4FpSsVMQvA5SI2aHbVCIwG0KZBzS2/izKR7VmF4Xrns
 9KSqTEZULi6S1YNORezX8hrwh0/P17mmNZ2iHuwjXVDIAF8ReVjmtL+58gpY3txpL8ns
 1klA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712572486; x=1713177286;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K5T6j3BaX4BEctJVxLbqu1H5TQjdw3HgYPlXWiWeEHI=;
 b=hW4z8wgNygbL6ulA3x7B27C+UUDTE55JbmdtyH/04jai+/TlTzCGJueuRfgSUzUrTo
 4H/+rTJNsqqB8fgVfo30aH1hDYpEydQT+/4BCaG9+f4iEzMh4VNGB3WZEECeHIp7EqnS
 h+Qhe1JV3DqfxJhXDx4hqbs3cr/67uWdlIa5GPq5gasXGUiVwO4N3w6iGbl6KOxfI0PJ
 TpnnBxlY9ZmKaZ65LpfY2jjmLUX1txs8DrbHtZCXvvEwvu4Syx2WOhZyDrbbnTCa7Qa5
 k3e5VhdtgJwEiCIUM+5pr4OOkzbtos8z4N6ll6L9BjG8K6pOU3n4BRpJHMA6zJZ9TSME
 bQlQ==
X-Gm-Message-State: AOJu0YwZ5p8xP/X2nXWAMD7uFWXv8sr6kv8bq81GTxs3NKaqOiwqrnpT
 1Iju921F8rNBu6f0UN0JlVjbsDWzQjz+6+VLkZk4UgUcOaWfJK46YySwOUKjqDtghlo5/e4a5dt
 nqKfAYIvWUbhFKjPSC96MAHeXCf7smq2SxULV0Q==
X-Google-Smtp-Source: AGHT+IFmXEO0J6DNCSmZL3fkU3kjUsY1K1stirlSFNjkFibYNsoP71vVX0H2tqvJa9noM+n1S6M5WsBdcct3pnrQm24=
X-Received: by 2002:a17:906:bce7:b0:a51:94b0:1ae0 with SMTP id
 op7-20020a170906bce700b00a5194b01ae0mr5994665ejb.11.1712572485992; Mon, 08
 Apr 2024 03:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240408095217.57239-1-philmd@linaro.org>
 <20240408095217.57239-3-philmd@linaro.org>
In-Reply-To: <20240408095217.57239-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2024 11:34:35 +0100
Message-ID: <CAFEAcA-GO0nVyjVy3WR8LrZ3qMJvpjOzncVGGDuU3hzziKm8uQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0? 2/2] hw/misc/applesmc: Fix memory leak in reset()
 handler
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Zheyu Ma <zheyuma97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Mon, 8 Apr 2024 at 10:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> AppleSMCData is allocated with g_new0() in applesmc_add_key():
> release it with g_free().
>
> Leaked since commit 1ddda5cd36 ("AppleSMC device emulation").
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2272
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/misc/applesmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/misc/applesmc.c b/hw/misc/applesmc.c
> index 8e65816da6..14e3ef667d 100644
> --- a/hw/misc/applesmc.c
> +++ b/hw/misc/applesmc.c
> @@ -274,6 +274,7 @@ static void qdev_applesmc_isa_reset(DeviceState *dev)
>      /* Remove existing entries */
>      QLIST_FOREACH_SAFE(d, &s->data_def, node, next) {
>          QLIST_REMOVE(d, node);
> +        g_free(d);
>      }
>      s->status =3D 0x00;
>      s->status_1e =3D 0x00;
> --

Cc stable?

This is the right minimal fix for the leak, so
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

but overall this is a bit odd. We don't change either the
keys or their values at runtime, they seem to be a fixed
set defined by the device properties, so why are we tearing
them down and readding them every reset? It would be
simpler to create the data structure once at device realize.

thanks
-- PMM

