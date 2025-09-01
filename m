Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE07CA0FFF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 17:05:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut7x5-0001jS-4M; Mon, 01 Sep 2025 13:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7x3-0001jE-Uc
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:04:17 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut7x2-0006yy-Eg
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 13:04:17 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d603a269cso36933957b3.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 10:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756746255; x=1757351055; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s8i6D5jkAUDyThSuzViGDH9PwKhirlJq1D1dtTZbZSI=;
 b=A4+ENdiewqrLUV8bHjmkJkY27dkw8VIlGOuLKTF9ZB1RyP3waSjvyW74w56P2DHCz+
 a62gSu+zGDj+O1d+nkjR5PHAONZjsglOziHyQzQ/7sWphuLRY/41/IMpnojCJD6fkQ2R
 UCH4RX1xCYyWm0dVZGNhkPyYmtuWRh/LubWLPiI2C42H/M6uxcYQfEtfcjvbazBW+B2c
 6lE127DDLuU7q9dd9Ox+gKHmoB7wqI0YgDA5/NWmg/XayAdw4GlKqfBTLgvl0l/ENGHx
 Pf9E8mmxj/T9aHl4JWuQGWeKJPTPDuqG1jfapK2qTOsVlEnJWLV/bfy4zpYBq3lh2Wdo
 2E0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756746255; x=1757351055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s8i6D5jkAUDyThSuzViGDH9PwKhirlJq1D1dtTZbZSI=;
 b=ZPRUM6t3xkb4V+cP14OMm+AGx7ttHdujv1lrjT+OvmYobM4YSQ46KEcAc9RCEvKlxl
 nvXAVxCcdEgPguTPhrFmHCFbNQc5TBRM/pzNxSBKlYLybOAbJOp8ZgYupPZ1pmxHH4jG
 H3Se1e1omvfEqZ+rCfasxccHwYIGMb8VvKOG7o4qTVtj7j8yWjVFQjzzY5KIYV6nLBCi
 UsbOdETNFtWYDBybmCFRYvqDP3JJPhHimw9QPsMW2wOP88PLXgcyRJiHARgSsKPTxXdz
 tZY1IzcukkGtMPw1tOnaeP1As+BhtmXRQYnqUwKRaJZFwUKxoLf9a7DnSPEaB7eE+0Ew
 Ip9w==
X-Gm-Message-State: AOJu0YxN5cXSFDGJlV60wTRxkpC6VmpA6oQ6/UXvvMXvfAOMfrMLoRY9
 c2NYuQPYhpC2IB3etl8ktXCZT/PiDa24y52VvFelovXRGvtZ4K9P5qo7NK3J0qgvcIjDXTv1uZ7
 GrvCVa9iS9CvoNCqgawfjSUgleBYUAfXrzYYdCSpEFA==
X-Gm-Gg: ASbGncspT++UtMGCor+6A5WWpL4VIwxrtoHSLIFwxhOaAZcwFQyw7Ascw9UtZWD/Fl3
 lVzPS4igoxS6XrX44FEMk2acFu9ezzKQIvUSZ0ry8Qcc8BF0FeJdiCb7WNHuKQgWTSTZinRAo9K
 jdbx4APAt2aDEZO9P02ze95TVplFFX+FV/lxxY7nl2lbmYcQb9vahlhDb2457hPHK7QlaXdm2Np
 PU/xhiK
X-Google-Smtp-Source: AGHT+IHnqnDvMl20p1XdCy/6NlPhO8udKqWBZ37/pVmHfoBv8D4Av3q7gGUUgjzxo2rIeIGZZFGkCaa/cVhKbzxlmNA=
X-Received: by 2002:a05:690c:9985:b0:71f:b624:322e with SMTP id
 00721157ae682-722764af341mr104788327b3.26.1756746232816; Mon, 01 Sep 2025
 10:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250822092410.25833-1-cjchen@igel.co.jp>
 <20250822092410.25833-9-cjchen@igel.co.jp>
In-Reply-To: <20250822092410.25833-9-cjchen@igel.co.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 18:03:41 +0100
X-Gm-Features: Ac12FXx5i4R9R1zWKUOD0YRdUrFqyEPkAA1Wf4Ok6RoZdovbeM5ESEnmpbbH1sU
Message-ID: <CAFEAcA9FAnnQrAf1eUPr1=FQ+=Wbu13gyfj3T3z+k6BhxHj6uQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 8/9] hw/misc: add test device for memory access
To: CJ Chen <cjchen@igel.co.jp>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Tomoyuki Hirose <hrstmyk811m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 22 Aug 2025 at 10:25, CJ Chen <cjchen@igel.co.jp> wrote:
>
> From: Tomoyuki Hirose <hrstmyk811m@gmail.com>
>
> This commit adds a test device for checking memory access. The test
> device generates memory regions that covers all the legal parameter
> patterns. With this device, we can check the handling of
> reading/writing the MemoryRegion is correct.
>
> Co-developed-by: CJ Chen <cjchen@igel.co.jp>
> Signed-off-by: CJ Chen <cjchen@igel.co.jp>
> Tested-by: CJ Chen <cjchen@igel.co.jp>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> v2:
>    - Fix the typo of ops size of big-l-valid.
>    - Replaced the huge macro blocks with dynamic loops that fill in
>      the `MemoryRegionOps` arrays at runtime.
>    - Remove test cases valid.unaligned = false,impl.unaligned = true.


> diff --git a/include/hw/misc/memaccess-testdev.h b/include/hw/misc/memaccess-testdev.h
> new file mode 100644
> index 0000000000..c1b17297a2
> --- /dev/null
> +++ b/include/hw/misc/memaccess-testdev.h
> @@ -0,0 +1,104 @@
> +/*
> + * QEMU memory access test device header
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Author: Tomoyuki HIROSE <hrstmyk811m@gmail.com>
> + */
> +
> +#ifndef HW_MISC_MEMACCESS_TESTDEV_H
> +#define HW_MISC_MEMACCESS_TESTDEV_H
> +
> +#include "system/memory.h"
> +#include "hw/qdev-core.h"
> +
> +#define TYPE_MEM_ACCESS_TEST_DEV "memaccess-testdev"

Could we have a comment in this header file that documents
what interface the test device presents to tests, please?
Both this patch and the test-case patch are hard to
review, because I don't know what the test device is
trying to do or what the test code is able to assume
about the test device.

thanks
-- PMM

