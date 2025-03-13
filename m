Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FB1C28B28
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 10:08:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsfTT-0005QZ-NR; Thu, 13 Mar 2025 06:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfTR-0005Po-1L
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:07:33 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsfTO-0000YT-89
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 06:07:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3912baafc58so624389f8f.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 03:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741860448; x=1742465248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ZXWUp0JBXMEpvX8Pe+4wr79wUHge5v+NeLQeVidOFA=;
 b=r/5jlj3YkbfbrwgjTMPTx93lyf7GDbjft6wVQsZ2Avn/8//pP6P8MaanS/iaK8Ggq6
 KKkbe/m0qschdDWU/Z9LO3Du025VLDkfaIpdcluZV7uiQvB/XdxTnPWzsYFawq8e2X2H
 x2bKgsL3HX/uODJ9eju5Cbg+k+tAwMdwODdwAdJIrS8DphRooYEN/5K+gleGo8yG2pdZ
 5BqU39HMW72ZZrimj7z33FKKlIyXFLOp88Wn/jiN5fGVRdtyBV5s+cn+TM5SA8vFCLOO
 qemtp9h8kU2jb36XSmuP3r2/s5jly3mgUcDZ0DPhSLQmFinbDS7xcaHKhbdE6PU0xiYa
 F8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741860448; x=1742465248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZXWUp0JBXMEpvX8Pe+4wr79wUHge5v+NeLQeVidOFA=;
 b=SGh3GghhSHL9VpKeIqsPwP1AqmT5OmsaI0FLpXv2izv89aDqHE6xWbtn/1qBPq0whA
 UOJwxYG+MlwLL2WDbVGJjFBZ1VnaJ8FjSK00vRgATR2JCrOZOXAnN264/aWn3W2Wcq35
 opMQNbN7S/xIwKsCEaaIGal0eNGEGOfi01f9wEiiFf6/5OQ3ErRB1XKpY2WZM7pmvywe
 VU6q39oVCiGn3C4GQHBH5ZYSv0/ZSxC41SxZBDdw8UiZcRic3ra7oV1YyfsQPZqCivmI
 U38/UkqYPOk6fX+P+ADv0Y5NHrq3r40K8kmlvXI10u2M298W6qoN0h135MO8o9NevQKL
 E2+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4UMwciLhhjRcn66T23kgTLv64h99Pii0UfeRzPk4OOdf798v/Rz9JHFQUcI1sNRd/GK6D4XebHlAV@nongnu.org
X-Gm-Message-State: AOJu0YznAAjI14JRxqH/D17wiJ24Su4l1rsckQ5FPffdZzoy5S81reX2
 FA5taAEloXH1agSjRLZJDYDJUdhgP8j58qaWCG+KcBrxdiG29kBBIDg3xIe1ju8=
X-Gm-Gg: ASbGncs1f6oa2L4iY0mAiUAd6/O5sqkWEbm2oiSlS42jfNysXJVY0188dNLoZcidyM0
 JytBvGMY9ZwpObB0SCkGYKgyBp2LcInC2Ek95R+/drQgOU7ydtjnH5kY6x55LNscuwaLPlC7eZq
 +N5cKtI2oYokML8X8GzfEaCLd3ms8F5ASG+uoy1ZwcXoMgy+s1rKbXF0XxJ+5VinM7rD+teAvZA
 x3Z4eKi5PW43WDU7FdD8rp9hNtef2aUuKKjDU8O1YUIt1E3hGz/XnmB6EUDqkxknd/kwOux2FqK
 lS3Jjbn+QWY+wqioCfhJS2clsNQ7xCyZXAd1U192JEZ+G6K5RjHqBN2ELo8b+tTEN79JSDcJfoO
 Jgv8s6pD5f9GX9Ks=
X-Google-Smtp-Source: AGHT+IHtIDemP5Zxx4ZY5j38ONWysh4wY0IIxKYF2xpc1jp7IXr0Tnyzv371I1R1i3yPqCn3zsxFrw==
X-Received: by 2002:a05:6000:1acc:b0:391:4977:5060 with SMTP id
 ffacd0b85a97d-39149775323mr13591716f8f.53.1741860448448; 
 Thu, 13 Mar 2025 03:07:28 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ebe4bsm1600669f8f.98.2025.03.13.03.07.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 03:07:27 -0700 (PDT)
Message-ID: <36f7e651-4df6-457d-a7ef-df7a7c4b2570@linaro.org>
Date: Thu, 13 Mar 2025 11:07:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/37] common-user: Split out watchpoint-stub.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 13/3/25 04:45, Richard Henderson wrote:
> Uninline the user-only stubs from hw/core/cpu.h.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/hw/core/cpu.h         | 23 -----------------------
>   common-user/watchpoint-stub.c | 28 ++++++++++++++++++++++++++++
>   common-user/meson.build       |  1 +
>   3 files changed, 29 insertions(+), 23 deletions(-)
>   create mode 100644 common-user/watchpoint-stub.c
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 5d11d26556..2fdb115b19 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -1109,35 +1109,12 @@ static inline bool cpu_breakpoint_test(CPUState *cpu, vaddr pc, int mask)
>       return false;
>   }
>   
> -#if defined(CONFIG_USER_ONLY)
> -static inline int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> -                                        int flags, CPUWatchpoint **watchpoint)
> -{
> -    return -ENOSYS;
> -}
> -
> -static inline int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
> -                                        vaddr len, int flags)
> -{
> -    return -ENOSYS;
> -}
> -
> -static inline void cpu_watchpoint_remove_by_ref(CPUState *cpu,
> -                                                CPUWatchpoint *wp)
> -{
> -}
> -
> -static inline void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> -{
> -}
> -#else
>   int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
>                             int flags, CPUWatchpoint **watchpoint);
>   int cpu_watchpoint_remove(CPUState *cpu, vaddr addr,
>                             vaddr len, int flags);
>   void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *watchpoint);
>   void cpu_watchpoint_remove_all(CPUState *cpu, int mask);
> -#endif
>   
>   /**
>    * cpu_get_address_space:
> diff --git a/common-user/watchpoint-stub.c b/common-user/watchpoint-stub.c
> new file mode 100644
> index 0000000000..2489fca4f3
> --- /dev/null
> +++ b/common-user/watchpoint-stub.c
> @@ -0,0 +1,28 @@
> +/*
> + * CPU watchpoint stubs
> + *
> + * Copyright (c) 2003 Fabrice Bellard
> + * SPDX-License-Identifier: LGPL-2.1-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/core/cpu.h"
> +
> +int cpu_watchpoint_insert(CPUState *cpu, vaddr addr, vaddr len,
> +                          int flags, CPUWatchpoint **watchpoint)
> +{
> +    return -ENOSYS;
> +}
> +
> +int cpu_watchpoint_remove(CPUState *cpu, vaddr addr, vaddr len, int flags)
> +{
> +    return -ENOSYS;
> +}
> +
> +void cpu_watchpoint_remove_by_ref(CPUState *cpu, CPUWatchpoint *wp)
> +{

Again, can this be elide? Otherwise better use g_assert_not_reached().

> +}
> +
> +void cpu_watchpoint_remove_all(CPUState *cpu, int mask)
> +{
> +}

