Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D565C83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 16:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXMhh-0006jR-DR; Thu, 03 Jul 2025 12:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMhY-0006dd-D7
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:22:20 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXMhW-0006DM-JT
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 12:22:20 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e81cf6103a6so5802342276.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 09:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751559736; x=1752164536; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aBSvS76xILHIDpjwE/w9YCKWfqGz7fpfO4FGe7DpX1Q=;
 b=MNC7XT3kPY6ZOcQmMr1fVWp1QMfgNpjn4ckkik94/gJSSTcQPPM9AjlUCj3naolqFm
 QHAnAkcWWRBx943ZQs8tn9sGmWppz/N+OI6YIWkcbztQEmcNyDLyiE4oqaBG6YzWNCbD
 LkljL16MMPEhGme1hndFKzm4C12+yu4qGuMCZMmjJ/VGf52wOAPdjQ04mbcDdJ8RZwEX
 A2LsFhT5ab9Cv0GXOk9AiNKXP+yt7cHNJpkOXi2KIZiZxOOLiGp3kQrPB8uanqtNU4Sf
 hZQc4JiMUjW7r4NrvOew77pZzxE4xST1DTYmcX5TE0BwdkE15O5v8/XStM96qAiA4fW6
 wZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751559736; x=1752164536;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aBSvS76xILHIDpjwE/w9YCKWfqGz7fpfO4FGe7DpX1Q=;
 b=sAZZWqzdaq9qKTqtuady6LmtuQovIgjVm1ZJgeBRYGlyfhII7GCxUWGJsC0ObHFlgv
 6CmoU9SKhbx1r2NtOSvtwvT9cUPt6xHnASrZgTkAIBW0iilTjlHPK0wvrJqQ/Nbb/mV4
 eUE7kCknsjA+ddsmIEsOkMVAUdiP3o1qTaRwWPiyeYQDLuztgBJTxXOpCzc6YAzZlNfK
 0IltLeNSljGK/qR5PwHkBSogPcK2SUR+MbUKWZ2sI55+lA4Sc2cBT8Mah7Rch758pKP6
 c8N9f/16NS9KfimYiHxlvKVFiezV6Dhb7DwGmbrgp1HO8G2bPPD5mE+fr31VQjqRrgLZ
 dziQ==
X-Gm-Message-State: AOJu0YybtoDCNjoipv6RJDHHhqgbWzNsh05vBlIhXTzmIZCTyQtEbprR
 nFPRmlATo9hGuEZg9eW/T8HoR/IRY8Gs+BVZjKIUExAGkXs0VJfMOSyqu2MOr3i6cRqlCtMAqlc
 jKpz7oOrLY8FWU5+kBfe+5+L4/c/GAyDD7lcU54h1I808rhAu3j2e
X-Gm-Gg: ASbGncuc0S2yE7WBEZwFIpAQscZ51qjzN2MU8CPwZgJ8NHOtJUrKJLPckMe8oZtmiCc
 uPFPIBKPNN3eRQgoE/09DCvb1lq1ea7snzb0Rc4TwJU5gJDKs01hJ1LdfJ16o5PzMbGWwdgqekE
 eTlTLvgbgxVFItj8U7BjhmGWUSQBjDI+MhxUWkS3DJgNXqZdpVT3sgzEQ=
X-Google-Smtp-Source: AGHT+IHhMZb7Gqqyr/HF/xZ8JCHdNqNtX0bahLmL5RoiX7APKsSX50sHb8TOYVug2As6/4LdpNvbmMVWUVuQ0NhhXpY=
X-Received: by 2002:a05:690c:3704:b0:716:4da5:a01c with SMTP id
 00721157ae682-71658ff8fe7mr72133377b3.11.1751559736458; Thu, 03 Jul 2025
 09:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250618230549.3351152-1-jcksn@duck.com>
 <20250618230549.3351152-9-jcksn@duck.com>
In-Reply-To: <20250618230549.3351152-9-jcksn@duck.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 17:22:03 +0100
X-Gm-Features: Ac12FXz3WO05I_QJoAycSzwc51SEZWMxRD7d7VuDSpFIpTWzkwevRKi6e0N5wpM
Message-ID: <CAFEAcA-xLUCGsV+9PrsskADppG3Xcb-qwkcTyTuzKbotF2+2uw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] MAX78000: TRNG Implementation
To: Jackson Donaldson <jackson88044@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 19 Jun 2025 at 00:06, Jackson Donaldson <jackson88044@gmail.com> wrote:
>
> This commit implements the True Random Number
> Generator for the MAX78000
>
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>

>  static const MemoryRegionOps max78000_gcr_ops = {
> diff --git a/hw/misc/max78000_trng.c b/hw/misc/max78000_trng.c
> new file mode 100644
> index 0000000000..f406681730
> --- /dev/null
> +++ b/hw/misc/max78000_trng.c
> @@ -0,0 +1,127 @@
> +/*
> + * MAX78000 True Random Number Generator
> + *
> + * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "trace.h"
> +#include "hw/irq.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/max78000_trng.h"
> +#include "qemu/guest-random.h"
> +
> +static uint64_t max78000_trng_read(void *opaque, hwaddr addr,
> +                                    unsigned int size)
> +{
> +    uint32_t data;
> +
> +    Max78000TrngState *s = opaque;
> +    switch (addr) {
> +    case CTRL:
> +        return s->ctrl;
> +
> +    case STATUS:
> +        return 1;
> +
> +    case DATA:
> +        qemu_guest_getrandom_nofail(&data, sizeof(data));
> +        return data;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
> +            HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static void max78000_trng_write(void *opaque, hwaddr addr,
> +                    uint64_t val64, unsigned int size)
> +{
> +    Max78000TrngState *s = opaque;
> +    uint32_t val = val64;
> +    switch (addr) {
> +    case CTRL:
> +        /* TODO: implement AES keygen */
> +        s->ctrl = val;
> +        if (val & RND_IE) {
> +            qemu_set_irq(s->irq, 1);
> +        } else{
> +            qemu_set_irq(s->irq, 0);
> +        }
> +        break;
> +
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
> +            HWADDR_PRIx "\n", __func__, addr);
> +        break;
> +    }
> +}

The interrupt generation logic still doesn't look right
here to me -- see my comments on the TRNG patch in v1
of this patchset.

thanks
-- PMM

