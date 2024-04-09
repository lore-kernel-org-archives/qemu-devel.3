Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A33C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 12:03:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruABd-0000n9-Om; Tue, 09 Apr 2024 08:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruABa-0000mg-Pe
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 08:02:47 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruABT-00079t-0f
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 08:02:45 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-516d3a470d5so5031051e87.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 05:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712664155; x=1713268955; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q4v19AqMuuwz8hrRjJlPrz06wTZzIIAtu/bcPRW6Vbw=;
 b=VuLLR/XvqAZwv+cR6Q741lmCNBMzGHM/L16j1nDQh2oqfBxFWnRaKypx157jPItXxQ
 WhFTFIYeppx58VqGJ5d9DJaB5E2+8X+dRAWFxV4ETDnEjSTkL+LBHJjo6x7MBVEDhTUs
 GTiUJ4NLoMOuQZR0fVF8OZ2mW2sxfb+Qtf77Hz4CDzFQkpQh4MREKISRrxRKIhavlSU+
 0s8h8r3p+KvSz1unE6vc1HX0ny16ePnzM924dOMuvBjOrSHXKHAUXsS24ouze/nWr35P
 UYNyAQN3nmdLlABhR5mRc8O0hJSLOtWtuTBBSyb6XbY87FvvyKMCrtzr7TRnZZwBE50g
 wByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712664155; x=1713268955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q4v19AqMuuwz8hrRjJlPrz06wTZzIIAtu/bcPRW6Vbw=;
 b=maNpNBh2JeXDs7sgpb6hO1bDTOa19OnIQx6+WmT0GH6EhtJAT6aytQlmZ2cKsWjx/b
 wQuNBwGn29xd0uWGh43eKEQcTOCCXUx2koyeXZUBUXtv8uFkrx6KDoRwOo9sChEkC9Ko
 p15gTDB89TCY9A29+sj8aktXC/P5UnXXZ2S7SjcozI0HRtXGnTF/oaXyy8W+IfwlCj3t
 xhRF+2m04OUiWINxUKPQ2BRMkcbeQnHiaGmHBI6pZoXAtIwrZ5xuJLfnhGBPRoLGaySj
 b9TDRlffmOUS4UYt4pjR/YP1OEP9aWx3C7Sp4tFj7dyp1fJs5DQR0bg6Kah377JQj0r3
 ToHQ==
X-Gm-Message-State: AOJu0YwJjOwgC0bIrcJwk1jH5eRqgUktJurqKzszzs5xxcXKNeYuueFl
 wGGl5Z0IB1HMK1z5RAosWXy+qU7DLgD/wHfw7IXyZF28AVRo1g9DyEU8dGPenS6EOQGOTp3KFHh
 Ut5h/lLRGq9XG4Vs0XP9tSn88KJPNeWLqbgNR1h1NXOa1CHto
X-Google-Smtp-Source: AGHT+IHmiK0kCtRh345JKqw/zshkoAbucP3oNLf7+WtdFBWe2q01FRtrl5vopR53DZYOfAdBbCUJKbwFuXpcgcKMx6Q=
X-Received: by 2002:a19:9119:0:b0:514:a821:a020 with SMTP id
 t25-20020a199119000000b00514a821a020mr8493342lfd.26.1712664154940; Tue, 09
 Apr 2024 05:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240409115301.21829-1-abelova@astralinux.ru>
In-Reply-To: <20240409115301.21829-1-abelova@astralinux.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 13:02:24 +0100
Message-ID: <CAFEAcA_W4qr6EPhOu-s_+d_V+MfADzddKNwd_gUzBTbajQ+xvg@mail.gmail.com>
Subject: Re: [PATCH] hw/dma: prevent overflow in soc_dma_set_request
To: Anastasia Belova <abelova@astralinux.ru>
Cc: qemu-devel@nongnu.org, Andrzej Zaborowski <balrogg@gmail.com>,
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, 9 Apr 2024 at 12:54, Anastasia Belova <abelova@astralinux.ru> wrote:
>
> ch->num can reach values up to 31. Add casting to
> a larger type before performing left shift to
> prevent integer overflow.

If ch->num can only reach up to 31, then 1 << ch->num
is fine, because QEMU can assume that integers are 32 bits,
and we compile with -fwrapv so there isn't a problem with
shifting into the sign bit.

And I agree that we shouldn't ever have a ch->num greater
than 31, because the worst case here is when we call
soc_dma_init() with an argument of 32, which sets up
soc_dma_ch_s structs with values of num from 0 to 31.

So this doesn't seem to me to be fixing an active bug.
Am I missing something?

thanks
-- PMM

