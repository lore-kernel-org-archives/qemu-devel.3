Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0FDC5B552
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 08:43:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOuYt-0006Fk-EF; Tue, 10 Jun 2025 04:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOuYs-0006FL-5h
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:42:26 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uOuYp-0003ci-QT
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 04:42:25 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-70e447507a0so41369977b3.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 01:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749544942; x=1750149742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZIuPnCGNokh2r4qO0IZf3QHexp85bC7lYzuRr1HstuA=;
 b=ss40eniq4u3XWzGuhdoBf3upOrpOa2Ezbt7tYLO6K/E/owcIc1k5U+WSwpQWEZ9XUR
 iDTIHwPYQ7BIffRNmfQaFMRKbQUZgcW8kMRCn8M/jHHDw0fI7PDueJcKk/RwvZ+9zLj6
 xV3WzSnd6Ctf+Gnl2cE1gu6aXBn3z1Jf5nurYQs0CrY/DnBowYsrgHOQOOMnuVgJ+7bW
 1UCUPNYi3LzMFCP2kfhvK76sC8Qwbdo4oL1JFsacLz+C2IvE6pMV7X9LOO331lDZQbvw
 cpvjOFeMWGMumAxGMuOmrnb1JKM8ZvelDWLuIjjZCnwBCzi8TUM5mJ2kQg9/oAQinZmD
 seMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749544942; x=1750149742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZIuPnCGNokh2r4qO0IZf3QHexp85bC7lYzuRr1HstuA=;
 b=TRSa+Rtl7PJ50AfCYvZXRaCnwZBEzZVnXlROZ79iYrx1zwhZsPOWOfsD2hYuweHFQs
 uwXr1zOg8Nz3k/Ax+YbRT7Y4po7i4Zp+c8ivgZmMT9PNLDZPdBN7SprKvDQYXPzk4F5f
 q5QEVpbJ3hdfjMyJ6ubV7opPDPdNgSDVaHkg5Bm1D14AXl93KiUw+8RpI8Cf1e14rs2R
 ualHFDACCFEC9uuvn8n64NBm29mTojb2tR1yjr5uEBdT2j9yyjiqDo+FGufLiv2U19oE
 fKvgAUUr6rjuZs9+QlyQL+m2toPL4E4Op1qyATr1W64iHIFRewD7ax+hV3p20DTGZVPn
 deUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXE8uSRUR/rKDhl3mN2zjymeylletZHN/wX0I6LEGLmN/rgls9bdLLGi5vyO8WYvXAWfU8wPnF/s7mI@nongnu.org
X-Gm-Message-State: AOJu0Yxv/m78fF9GbPDUW5cTDOl9tCRLu9LLzWV66+m9AyqL6ZBw7G9R
 aSVfNq4h+gFLV1knfipRJFm7Ok1KUPpEF/3BBgrhhRerYsZSElF1GUfTyQTTE0b0uc1ij+SCpal
 51EQdxHqvF5ZKUcLwMXHT7XxjT6CsFkqu9j0nnXqLcg==
X-Gm-Gg: ASbGncuRlu5r0ozqAMSdiz3zFjBH2JmT2OA8CBMUxoZeX2WG3HAEAuhRIO/BZK5KzVq
 UsnvP78sW9zDryri2Wfgip81tOnmkX8hT/DPc/ve26js4Bbx94/Av6KabHnrFLtTS1OHJJujC+t
 nuiWjYerN1XXoOYQDyDc69oKl4jEEYV6PkUFxai+aubtWe
X-Google-Smtp-Source: AGHT+IE/9qk2aSz7vPh2IFx0Y170M93DwiBg3usjvPQBdpHxAXMmy/spygRbSWbSOnTcxcUl0cYcTyKfA34z4QC+Mfo=
X-Received: by 2002:a05:690c:6a02:b0:70c:a5c2:ceed with SMTP id
 00721157ae682-710f76ffe14mr221894887b3.25.1749544942061; Tue, 10 Jun 2025
 01:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250610012851.1627715-1-linux@roeck-us.net>
In-Reply-To: <20250610012851.1627715-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jun 2025 09:42:10 +0100
X-Gm-Features: AX0GCFsI9n_plIj9Jxbgt6bAPEPMgxofXuZ5eYc1CyFiD0hVGfQM2QzqVQkSWvQ
Message-ID: <CAFEAcA-aznHrcSk9xfmLHkpJTiabjd4oX2KnvC5TXkkLgW6n8A@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/npcm7xx_boards: Add support for specifying SPI
 flash model
To: Guenter Roeck <linux@roeck-us.net>
Cc: Tyrone Ting <kfting@nuvoton.com>, Hao Wu <wuhaotsh@google.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Tue, 10 Jun 2025 at 02:28, Guenter Roeck <linux@roeck-us.net> wrote:
>
> In some situations it is desirable to be able to specify the flash type
> connected to a board. For example, the target operating system may not
> support the default flash type, its support may be broken, or the qemu
> emulation is insufficient and the default flash is not detected.
> On top of that, the ability to test various flash types improves
> testability since a single emulated board can be used to test a variety
> of flash chips with the controller supported by that board.
>
> The aspeed emulation supports an option to specify the flash type. Use
> the same mechanism to configure the flash type for Nuvoton 7xx boards.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> I don't know if there is interest in this, but I figured I should at least
> submit it. Background is that Macronix flash support is broken when running
> upstream Linux v6.16-rc1, thanks to upstream Linux commit 947c86e481a027e
> ("mtd: spi-nor: macronix: Drop the redundant flash info fields"). I needed
> a workaround, and using a different flash model was the easiest solution.

I think the question I would have here is "is this the flash
device the hardware actually has?". If QEMU's using the wrong
flash type, we should fix that. If QEMU's modelling the right
flash type and the kernel doesn't implement it, then that's
a kernel bug and the right fix is to get the kernel to
handle that flash type.

thanks
-- PMM

