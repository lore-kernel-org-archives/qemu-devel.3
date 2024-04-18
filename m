Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3339C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 19:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxXSg-0001FB-Dc; Thu, 18 Apr 2024 15:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXS9-0007Jk-Q3
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:29:51 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxXS7-0007tE-A9
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 15:29:49 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2dac77cdf43so16849991fa.2
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713468585; x=1714073385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WrEd7aDEDjdvNR6Rc9rGdmrqk6I0VD0LzXzxlDM7bsE=;
 b=pe7lk2d6LU8/yOpdhEtsekg/HiueDwnPZiLozjL9blghbOxKDAobTuKIOX5QVL3utx
 yJry/+7W7EhnnthdbALEbeo3wro8/+hKq8Nmo8iFBOaCZ92WPxcdrGkapLDoRagdJH9K
 FBc9aMna2FkyvobAdkBQ9uaa53PShgE3kw2zyuMGkJehr0Tdf6si9LL0NUzflqnK3czg
 4625gaUvse2CYySTyRqM4DkN9qwn5D19AHCVRkQiLrCUKkO00UpovV6dGW3cLGisp5NM
 GBUwS4z43/iLRw9pvWsgIv+ef9MpN9+NAiKDPuw6Eeqex/xgb8AsIXXR/pxRXCzTQj2t
 Wz6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713468585; x=1714073385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrEd7aDEDjdvNR6Rc9rGdmrqk6I0VD0LzXzxlDM7bsE=;
 b=nqj3yBx9+ODPZ+e9qBEj3W7hj3bS4p/w47wD1n+F3xPNI55Asg4dAWP1AiWSZcPd3p
 f/SPzxKVpDMKwdjWJJbAPFHc2Ev538NX/ISj0R1yhpyqC8jcMOr3O6nJSR1/zejX42IG
 McS3o52Z4t3ULcGRu0K7+5H0MEVp1Ok8W6OGqzF55HxLYMGblubLCyG6yf+aqPQTh372
 MvuJlyVF25UtbFAytQAjqVuYezEOEc+Sr1OiKzJ8A9Q68/oijLkO6P+VAkL/yoULlbrk
 eQeodFy6MGHXNOCgr0YEMJgCjhmzdCeBdQeaMCPQX+0H03+Oc9m5JeGOaICFziaUluw/
 6YqQ==
X-Gm-Message-State: AOJu0Yw0JNhDJS0enMKJRTF1+YpMHwcZwpASXOcwh1EUqyFbXepE9dPP
 Ld7KbevGwyYJJfTZuMyky5OrPeGHEnwTeXcDaTpXCaVgEN7xelwicugr42he+Qp+dcAa2hX+vHp
 W
X-Google-Smtp-Source: AGHT+IGPiOT1eC6eUS6iwYRXcHUMAYmSQxpoP9gCPQopDsCgUk5q4iJLyvSqdEZh8CYyR1arTYRm6Q==
X-Received: by 2002:a2e:240c:0:b0:2d8:a82c:9e1e with SMTP id
 k12-20020a2e240c000000b002d8a82c9e1emr1974267ljk.15.1713468584887; 
 Thu, 18 Apr 2024 12:29:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.213])
 by smtp.gmail.com with ESMTPSA id
 bc24-20020a056402205800b0057059784823sm1226083edb.29.2024.04.18.12.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 12:29:44 -0700 (PDT)
Message-ID: <09dd8fe2-29ec-4099-9746-70fe8665b3dd@linaro.org>
Date: Thu, 18 Apr 2024 21:29:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/24] exec: Declare CPUBreakpoint/CPUWatchpoint type in
 'breakpoint.h' header
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418192525.97451-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 18/4/24 21:25, Philippe Mathieu-Daudé wrote:
> The CPUBreakpoint and CPUWatchpoint structures are declared
> in "hw/core/cpu.h", which contains declarations related to
> CPUState and CPUClass. Some source files only require the
> BP/WP definitions and don't need to pull in all CPU* API.
> In order to simplify, create a new "exec/breakpoint.h" header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/breakpoint.h | 23 +++++++++++++++++++++++
>   include/hw/core/cpu.h     | 16 +---------------
>   target/arm/internals.h    |  1 +
>   target/ppc/internal.h     |  1 +
>   target/riscv/debug.h      |  2 ++
>   5 files changed, 28 insertions(+), 15 deletions(-)
>   create mode 100644 include/exec/breakpoint.h
> 
> diff --git a/include/exec/breakpoint.h b/include/exec/breakpoint.h
> new file mode 100644
> index 0000000000..45038263e3
> --- /dev/null
> +++ b/include/exec/breakpoint.h
> @@ -0,0 +1,23 @@

Oops, forgot:

+/*
+ * QEMU breakpoint & watchpoint definitions
+ *
+ * Copyright (c) 2012 SUSE LINUX Products GmbH
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */

> +#ifndef EXEC_BREAKPOINT_H
> +#define EXEC_BREAKPOINT_H
> +
> +#include "qemu/queue.h"
> +#include "exec/vaddr.h"
> +#include "exec/memattrs.h" //MemTxAttrs

Also forgot to remove that comment.

> +
> +typedef struct CPUBreakpoint {
> +    vaddr pc;
> +    int flags; /* BP_* */
> +    QTAILQ_ENTRY(CPUBreakpoint) entry;
> +} CPUBreakpoint;
> +
> +typedef struct CPUWatchpoint {
> +    vaddr vaddr;
> +    vaddr len;
> +    vaddr hitaddr;
> +    MemTxAttrs hitattrs;
> +    int flags; /* BP_* */
> +    QTAILQ_ENTRY(CPUWatchpoint) entry;
> +} CPUWatchpoint;
> +
> +#endif


