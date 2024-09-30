Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB80CE8359
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 15:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svI9B-000633-U3; Mon, 30 Sep 2024 11:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svI99-0005zP-Lt
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:17:11 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svI96-000592-Ew
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 11:17:10 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c881aa669fso4692947a12.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727709426; x=1728314226; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=u8jF7f97obPQbQPRwah5xs/l/E1L4LlJnkZkiyAlH64=;
 b=NYUp0l60I1B20jsg9yNZZXJ9vlq6C4zPjyxm/kCXzwjexxfSRmlt2bbhtaVhCSCwEk
 iT8AFaP5tZLvGEDShAWlTLRdo7D0GAriaVxZyA0yfPDqSiwaIIMrxlPgBE5LXOAw0UMA
 K5TDlBn9keWvJB595xkhJSLEQ+JJ7dVJjKrAOfi211cLbIpZL305tz2fpOTnyschZSB3
 nOg5t+cJKo3jg2sZilbWpJgwXb3vkA1BTgklN1bInHYgTRnL70Od+/zP4SQJfWQ/f4XZ
 Ruee+tXXtOIzC9rrHC1k7v7dpNdohv1W5HFv6HJXQiogRI5u3a9p3vLchZtWZGk+/PsK
 TAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727709426; x=1728314226;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u8jF7f97obPQbQPRwah5xs/l/E1L4LlJnkZkiyAlH64=;
 b=pqZ4LdKL6O/Capc9dRLIppMP1VwOmFkuXRx2mqE/e1BxnFF4U+euce9SFTFE4YJsOT
 kfATFQkj3FA03ykYFu2JR20+7YtrRdD3iUnEJ+enpFPbJk4g13EDJdZVg8PMS0AU3Mz6
 mgTrSS9Gzl2cDVsFNwRuGbltAKnsnwb777EOLnQlcP8mq0PqUgh+KK7u+F1IH5qoKOLu
 CYnLovfB9I6KdvUzDZM2LoEJVKVs1MyKHGh7XrWBWrEozr2F3C7Ee2TWtYNGqa9ds0SA
 rVM/WPbI0X0uG9GHXjIeWx+ruZ4Fkk3FegP5cFVyL295p1WC5JTRgqrwRX5o0fxhCkk6
 COpw==
X-Gm-Message-State: AOJu0YyexuNpk3In2hG/EdCW478DBJay8w1fN++LDhvXwWLBxTVJIsRY
 xO80A8b0T6AXJ2X7961is6oIcTwMd1Xvw1Xo5wgzeUxshMemaTYdfxRRsttdvKruFBxZdz/wymM
 ridJ7PzlRgNZSXcZ6OZISu4kg0Q/HOnwBw9r/tQ==
X-Google-Smtp-Source: AGHT+IFkgeSFAkioxGj0RD+6KLgaY1E9MXTCCPYDhdJc+g6tObyUCVHRIbfLXqqxsuUCdcbYZVob9s21d11wVgsZC74=
X-Received: by 2002:a05:6402:d07:b0:5c2:4dcc:b90a with SMTP id
 4fb4d7f45d1cf-5c88260791cmr11853419a12.34.1727709426303; Mon, 30 Sep 2024
 08:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240923035632.81304-1-sebastian.huber@embedded-brains.de>
 <20240923035632.81304-2-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240923035632.81304-2-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Sep 2024 16:16:54 +0100
Message-ID: <CAFEAcA8Wf-PzAC-YGdma3YVETyuatLJHmvjrrb_kG2NjDSGs+Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/arm/boot: Use hooks if PSCI is disabled
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 23 Sept 2024 at 04:57, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> In arm_load_kernel(), use the secondary boot hooks provided by the
> platform if PSCI is disabled also while booting a non-Linux kernel.
> While booting Linux with PSCI disabled, provide default hooks if needed.
>
> In do_cpu_reset(), use the secondary CPU reset hook provided by the
> platform for resetting a non-Linux kernel.
>
> This change allows a more accurate simulation of the platform reset
> behaviour.

So, the difficulty with this is that it's effectively
introducing an extra way of booting. At the moment we
have two boot approaches for Arm guests:

(1) Booting Linux -- the boot.c code simulates what the BIOS,
boot rom etc, does, both to set up the 1st CPU for the kernel
boot entry, and to set up the secondaries in whatever way
the bootrom does that the kernel expects to release them from.

(2) Booting bare-metal -- boot.c assumes the guest code is going
to do whatever the BIOS/bootrom does, so you get what you get
for real-hardware CPU reset. (Either the secondaries start
in power-off state and the primary will release them via some
kind of power controller device, or else all the CPUs start at
once at the reset vector and the bootrom is going to sort the
secondaries out and put them in a pen.)

What you want is a third thing:

(3) Booting not-a-kernel but not 100% bare-metal: emulate what
the bootrom does for primary and secondary CPUs but don't
boot the guest binary as if it was a Linux kernel.

The problem with adding that is that we don't have any
way to distinguish whether the user wanted that or our
existing type (2), because both are "user gave us a binary
that isn't a Linux kernel". (It also has a bit of a
"continuously expanding job" problem because the bootrom
could do arbitrarily complicated things, like boot directly
from SD cards, which we have historically not wanted to
emulate within QEMU itself.)

There are other platforms where the real hardware's bootrom
has a particular "this is what a bare-metal-under-the-bootrom
startup looks like" definition, notably the raspberry pi
boards. There too we don't currently implement that, and
instead effectively tell users "pick one of the two boot
paradigms we do support"...

thanks
-- PMM

