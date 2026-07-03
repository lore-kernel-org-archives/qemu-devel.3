Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07F6C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:14:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfULW-0007nX-Ce; Thu, 02 Jul 2026 23:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfULQ-0007j4-Fi
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:13:37 -0400
Received: from mail-pj2-x01.google.com ([2607:f8b0:4864:39::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wfULL-0006lF-8e
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 23:13:36 -0400
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-380feaa05dcso68938a91.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 20:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783048409; x=1783653209; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cgSr5+oqq4DYN35HzzRfYz4VuItlkkqh0xYLmxFJSKw=;
 b=R9A3Hg9W6wfs1L0UHp+hBXQroRpAftj6809actzw4Q4vdCq///J/QtvJyAaR+uJ+Ia
 7d5Ur/DHQSaRwo4Eb4fqik6wJf8ftrKvt2qFbaBNBiDywzPA/EZyVX5+L/A+Hq1TUXAm
 Ts+D0iiqxXJExZ+eCB7Pujkz5nz/CWIWBORbIMl2wZrczXx8Ffc8xB8x9vy/YJIZJ5cR
 5dhJ03e3zbTwCtYJLa3pHKJObzD2Z50X5b9MqTYRLX82Y5cEhRSSFXO0dEcezIqv3Vq6
 dR+CaLttHXUqvvB/0wkDK5VBLOH96q+Ecy64engNFY8ZbYDfqMMmjB/1FpxFw68yA4JV
 t4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783048409; x=1783653209;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cgSr5+oqq4DYN35HzzRfYz4VuItlkkqh0xYLmxFJSKw=;
 b=lNVmiOgNUZGCCP74osazEsaUTTNvIAo4IKwFHgC8MpwaE1Jv6EPM7w6MHj2WdsWlsc
 WuwvMFUCaZ/Q+Fs/zMxaXpoOzBs6afi/9J72AAfHt1nnh/zdobsJPIPTnaqTJ66Iq7e6
 4TIFKm989qSkHVI+L3KYlxf9wO8iXhYwtPqgoAD6PXbEqriJvXmsyQgqcm17cqRVmxrP
 Mlo2aCf+mY0q4mDBdbJqa7iQWYv+DoKToND9cZYPxPi9eeqFu7Ed+Jgc6ElWwOJYrxxV
 F6NQ8EsM/VO1iG7Q8KxM5TLR6OeuLEPAewAwlS8rH+3AbTae7La8TCKjk+un71u5UjOd
 yK8g==
X-Gm-Message-State: AOJu0YzBIOtIKkFZeGlCIdXLou3Da1Po7UMI82BQ1nIe4Hl6NPvxlBp+
 DMrHSFWWE5kAmk5ozO9ccct9Hr8u8xpgHjHbxkt8kJG2T/YAZs/LmUCj
X-Gm-Gg: AfdE7clsLEzwh0gOhimHmrnyxq2keFLSWJxI7LYk1NLCl/J8ni4E8Xa8UZbL4BkYaMK
 lM0xwntIpySFoPMxz+AHqzEOWUSpCgEWICmcPcy4aLxReBItE2UWfq+gQK8ParLmKKsC1t1UIBT
 rRlz517BvhuZlIaSM+hAsferhDQ3zeSA0+tYNtP45IZ49LyAyJv2RiXyxwYbrU0liAyNcJY/NGf
 ZJX4npDcaZXzTjfXcz/2fGYkgKFf65uE/FGRFioJHNiQYoaana3ch1lLWuoHm/uh4TJLZlXGPqv
 Y58380eNVIQVywctdm/id9lrSWXlKOGnpT1XOUx3Me0ZYNmu6gE9XZ4Sx2sJ5PdQvp1iABnxZdi
 NYkq/N6HZa8NrD4AA7DbNpgiui8kRcyB7qU3RIJ418F7kV2sm+YRg//h9ULtLG86xHopInoYV3m
 IWxf2yXJuFygrfbKI7LlWSRWW4OWyLoCArc+Rm/CBG3fKAnZri
X-Received: by 2002:a17:90a:d44f:b0:37f:133a:3e07 with SMTP id
 98e67ed59e1d1-380aa0fc88cmr9337110a91.2.1783048408732; 
 Thu, 02 Jul 2026 20:13:28 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f0bb7fe46sm17449757eec.14.2026.07.02.20.13.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:13:28 -0700 (PDT)
Date: Fri, 3 Jul 2026 11:13:25 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 03/33] accel/tcg: Restrict tlb_protect/unprotect_code()
 to TCG
Message-ID: <akcopoo7DCSdFo9y@ChaodeMacBook-Pro.local>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-4-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630220100.1289-4-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:39::1;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-pj2-x01.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 01, 2026 at 12:00:30AM +0800, Philippe Mathieu-Daudé wrote:
> Both tlb_protect() and tlb_unprotect_code() are only used
> within accel/tcg/. Avoid exposing them to the whole code base,
> declare them in a new "system-page-protection.h" local header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  accel/tcg/system-page-protection.h | 17 +++++++++++++++++
>  include/exec/cputlb.h              |  8 ++------
>  accel/tcg/cputlb.c                 |  3 ++-
>  accel/tcg/tb-maint.c               |  1 +
>  4 files changed, 22 insertions(+), 7 deletions(-)
>  create mode 100644 accel/tcg/system-page-protection.h
> 
> diff --git a/accel/tcg/system-page-protection.h b/accel/tcg/system-page-protection.h
> new file mode 100644
> index 00000000000..52896c6d24a
> --- /dev/null
> +++ b/accel/tcg/system-page-protection.h
> @@ -0,0 +1,17 @@
> +/*
> + * QEMU page protection (system emulation)
> + *
> + *  Copyright (c) 2003 Fabrice Bellard
> + *
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +#ifndef SYSTEM_PAGE_PROTECTION_H
> +#define SYSTEM_PAGE_PROTECTION_H
> +
> +#include "system/ram_addr.h"
> +
> +void tlb_protect_code(ram_addr_t ram_addr);
> +void tlb_unprotect_code(ram_addr_t ram_addr);
> +
> +#endif
> +
> diff --git a/include/exec/cputlb.h b/include/exec/cputlb.h
> index 3a9603a6965..f7f7020382d 100644
> --- a/include/exec/cputlb.h
> +++ b/include/exec/cputlb.h
> @@ -24,14 +24,10 @@
>  #include "exec/hwaddr.h"
>  #include "exec/memattrs.h"
>  #include "exec/vaddr.h"
> -#include "system/ram_addr.h"
> -
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -void tlb_protect_code(ram_addr_t ram_addr);
> -void tlb_unprotect_code(ram_addr_t ram_addr);
> -#endif
>  
>  #ifndef CONFIG_USER_ONLY
> +#include "system/ram_addr.h"
> +
>  void tlb_reset_dirty(CPUState *cpu, uintptr_t start, uintptr_t length);
>  void tlb_reset_dirty_range_all(ram_addr_t start, ram_addr_t length);
>  #endif
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6e66f3c6e93..7f7c208ba12 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -1,5 +1,5 @@
>  /*
> - *  Common CPU TLB handling
> + *  Common CPU TLB handling (system emulation)
>   *
>   *  Copyright (c) 2003 Fabrice Bellard
>   *
> @@ -47,6 +47,7 @@
>  #include "tb-hash.h"
>  #include "tlb-bounds.h"
>  #include "internal-common.h"
> +#include "system-page-protection.h"
>  #ifdef CONFIG_PLUGIN
>  #include "qemu/plugin-memory.h"
>  #endif
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index c33dbf65e7f..4313864d2c5 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -38,6 +38,7 @@
>  #include "user/page-protection.h"
>  #define runstate_is_running()  true
>  #else
> +#include "system-page-protection.h"
>  #include "system/runstate.h"
>  #endif
>  #include "trace.h"
> -- 
> 2.53.0
> 

