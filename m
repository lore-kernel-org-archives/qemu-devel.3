Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 641B1C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 13:48:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLk37-0002ml-DW; Mon, 24 Jun 2024 09:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLk32-0002l9-UC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:47:57 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sLk2z-0004dj-GJ
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 09:47:55 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52cdfb69724so1938109e87.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 06:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719236870; x=1719841670; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0s3LydvkurpzHPSmFqn8SsqqOKpHZfLVy0YgIg6YuhM=;
 b=Qbrb8qFUyHqUZp6Hk1DTy/pEZKvjeZewCofYSWv5rRixkeRGyHCWLB5gZUpjPtvnjM
 F3zKQvPsrHsXkKy9SpRsDJ0mB8+flgHUMr0tAWyChQKw5CXWHKufilyxCA/v8QnVaQXo
 TKY84UN79R0L6tXN9IP0s9TbEBETsHwgOOfRVOlqBi/0wDXJzULONaKSbnDU/olxdgSL
 MOkSbVz9vJJGW5Fk8VAG+5c6XvezeBZPO94tEJkOaeHoyyVOFVQjG4lQTsTjwJAwMeqt
 hJ8TopD/gDlH8Wky47ZQCwm9w5oRir8fbunrCrmMWW4y4BkfEpxw7zRTYjV6lWpklwmh
 wHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719236870; x=1719841670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0s3LydvkurpzHPSmFqn8SsqqOKpHZfLVy0YgIg6YuhM=;
 b=XpF/LzFxrkB7Lu3U8Qu1H2DrhJkM1Qu37hCXjr+AaloF5o8uWsBm+mDL1GnDCY4YAy
 otqXDN5CLsoHRKsaJCsVkLfLGaoOAgCPZ24jztOI9D6DLGxUvn7geHUgXOl5goprRYuS
 uspUJTFw4YVClIKWd0ZRGa4/0lFMD3LQgt5xJJZdzW/yLfDmXWEnzkJsjicMKgXQCdMH
 zICt0NmbvmLyeen5Dvggl6r0RIyb7fdmZAr1DYq/i9aESpFlylaZUJebSS+rX3tw94Yi
 ktw8iydgit16CyqRk47sfWWaHt6JJBJ1lR9zVhAN7w3URhhgLtvXYagFztrWRKKXdZRO
 i2SQ==
X-Gm-Message-State: AOJu0Yz+h2pr8uU3NaH00AxmABvbSHF7P3L0JnkyFOJTDGOwFJ5luJx0
 tgxuSEipQxEEsDTIxJ8dc7SNNJXXHCkAtk9c6/3PP+IkS/TP1YhxZDU/OPARbpOaWnyGOVz0MSs
 o1BvuWMf+MdlNIfux1QsM2ia3lXb3r4kQMMOSiw==
X-Google-Smtp-Source: AGHT+IEak+AlU/sGyNgKu71+/v2DuvHcCZWwEj3MVCEKEJeB0lgx0APIFcwedpxjChNmBHua5VVMWIwXUZl45G8fzec=
X-Received: by 2002:ac2:550d:0:b0:52c:e126:3d50 with SMTP id
 2adb3069b0e04-52ce183bf44mr2481283e87.36.1719236870433; Mon, 24 Jun 2024
 06:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240621165115.336-1-shiju.jose@huawei.com>
In-Reply-To: <20240621165115.336-1-shiju.jose@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jun 2024 14:47:38 +0100
Message-ID: <CAFEAcA9CQ_D168MmD+VbQsegUVsJuiXBP64oH0SgL=bD8EDJOA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] hw/arm: FW first ARM processor error injection.
To: shiju.jose@huawei.com
Cc: qemu-devel@nongnu.org, linux-edac@vger.kernel.org, 
 jonathan.cameron@huawei.com, mchehab+huawei@kernel.org, tanxiaofei@huawei.com, 
 prime.zeng@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
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

On Fri, 21 Jun 2024 at 17:52, shiju.jose--- via <qemu-devel@nongnu.org> wrote:
>
> From: Shiju Jose <shiju.jose@huawei.com>
>



> diff --git a/hw/arm/arm_error_inject.c b/hw/arm/arm_error_inject.c
> new file mode 100644
> index 0000000000..953a9d6705
> --- /dev/null
> +++ b/hw/arm/arm_error_inject.c
> @@ -0,0 +1,49 @@
> +/*
> + * CXL Type 3 (memory expander) device

This doesn't seem to match what the file actually does.

> + *
> + * Copyright(C) 2020 Intel Corporation.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + *
> + * SPDX-License-Identifier: GPL-v2-only

Why are these new files GPL-v2-only? Our general preference
(see the LICENSE) file is for GPL-v2-or-any-later-version.

I also notice that this file is marked as copyright Intel, but
you're submitting from a Huawei email address.  What's the history
of this code?

> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "qapi-commands-arm-error-inject.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/pmem.h"
> +#include "qemu/range.h"
> +#include "qemu/rcu.h"
> +#include "qemu/guest-random.h"
> +#include "sysemu/hostmem.h"
> +#include "sysemu/numa.h"
> +#include "hw/boards.h"
> +#include "hw/acpi/ghes.h"

Looking at the code here I'm pretty sure you don't need
anywhere near all of these include lines.

> +
> +#define DWORD_BYTE 4

This seems to be unused.

thanks
-- PMM

