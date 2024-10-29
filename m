Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C0CD2AB20
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 11:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5kJg-0006GH-Tu; Tue, 29 Oct 2024 07:23:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5kJe-0006G9-2o
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 07:23:14 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5kJc-0002CO-Hf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 07:23:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so7281511a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 04:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730200990; x=1730805790; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kd+G31MLEI1OctWkbnt8RLu/iSHpowKrGa+V+QCeBns=;
 b=Bw+4W5StG9KRlGT/JwMl2uLGHOHkADezq9sbAgp4L7D29UjTJVB2Rh+YCGLWkWnUYo
 jpHDLwxEN0GThIrtvyePhp0ncM6Msb0G5/rU/Yso3jAb5Dy4BOg5bx3l31QdcycHjXqC
 s7pbfeW0VI5Utkt5sFVVA9zbPU3ODtHdLWhZQivbdHtaNSYhrXGdyBJRaLUBPRZo7Mr2
 YIFpZ1m4w2SgR4xz8ncLd8UCm9vIaGh2cVLLslutxwBOgzPD2Jq7xJVHYy1Jw4PxD25g
 JbBXTQqB76hHyW9nQNFJd8ddTu4ImIztkghacriMeVdh+fpnTa5k/BGFLZAVQrRn/uEN
 n+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730200990; x=1730805790;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kd+G31MLEI1OctWkbnt8RLu/iSHpowKrGa+V+QCeBns=;
 b=nTfHScpIYlPx8aLHP3NCvTNW5XYfWKq3oFT5coqYQWRD7C0F6WyoBuA2Dj8Y5cBuYJ
 gvQr3Ha3unJIWmp7DDr6MNJehJzDZvROP2irIyZo5ioKYQBqbAHkwTwUdebl8shx+NQG
 gzT/Wo8bojcErQk0Rp8nBreX2BUXQ6f3XuujYfhTndLT+8Y83Tb7dN2mNcvXgJadc/uq
 5lSHxyBDEji1gJ6aw0/9N76hvyeBOqY/KMLW/QHmMmkbe1DKtmXp8qpj4HU2VfaYPbvG
 2vr1Ou3Tv8xNj/5fz9zMZEv1IkYJoR21ekKzH5sgLm1223rkrBKN5m69pTf57GzMioFB
 mPvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/ZDYjx9zxfHWCbIg+7E624Pdo+TFDEgT6YcQ2k9H7hU2FCuNDH/8W3jIbhTAbJr5ufS4FRvq5uHpG@nongnu.org
X-Gm-Message-State: AOJu0YyAAxX+Z56PXv/TD7gPoNTCBDy5t8PX50CjzJF73GhJ2MpvjHrl
 ZPSkudJ9qCRmmAnpgerekrwQP9pBEVg3SauipTTCSwMZazRnj4OyEq9wRmcRUgOXHhg7jthV3H/
 ARaFGO7adTJj1od4v9El2MsPXU55So2KcOU37GYfLL+HuAv2M
X-Google-Smtp-Source: AGHT+IFXsmMef2xubLGTh4Cd9UxHNLq1VGHDfOAH3E5+A15/yz/zO6qs4/XQ1i2mGaiclGXyT0qo2lzI3ieXT6CUzUk=
X-Received: by 2002:a05:6402:42d6:b0:5c8:9e36:ccaf with SMTP id
 4fb4d7f45d1cf-5cbbf944324mr8848740a12.33.1730200989943; Tue, 29 Oct 2024
 04:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Oct 2024 11:22:58 +0000
Message-ID: <CAFEAcA9XK85TBHmty5WJRtwTtX-0--bgNKXitTpxs6t7jpqj0A@mail.gmail.com>
Subject: Re: [PATCH 00/36] next-cube: more tidy-ups and improvements
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: huth@tuxfamily.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 23 Oct 2024 at 09:59, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> This series contains a number of tidy-ups and improvements to the NeXTCube machine
> which include:
>
>   - Bringing the code up-to-date with our latest coding standards/APIs, in particular
>     related to the board configuration and IRQ wiring
>
>   - Remove the remaining overlapping memory regions and consolidating multiple
>     register implementations into a single place
>
>   - Add a new next-scsi device containing the ESP device and its associated
>     CSRs
>
>   - Adding the empty_slot device to fill unimplemented devices and removing
>     the "catch-all" next.scr memory region
>
>   - QOMifying the next-rtc device and wiring it up with gpios as required
>
> The next-cube machine looks in fairly good shape now, the main remaining work is to
> create a separate device for the DMA controller and update the wiring of the IRQs
> (including to the CPU) accordingly.

Would you have time to consider updating hw/m68k/next-kbd.c
to stop using qemu_add_kbd_event_handler()? It's the only
user left in the codebase of that input-legacy.c API.
Generally using qemu_input_handler_register() should simplify
the code because it will no longer need to decode multi-byte
PS2 code sequences back into "what is the single key event
that this corresponds to?". Commit ff7888dcc6c701 is an
example of the conversion (though that input device
is somewhat simpler than a full real keyboard).

thanks
-- PMM

