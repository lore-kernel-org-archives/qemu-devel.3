Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC14BC0218D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 21:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcAI8-00012R-Uq; Sun, 26 Jan 2025 16:35:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAI6-00010n-Pt
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:35:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcAI2-0002W9-6A
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 16:35:37 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2164b662090so72059015ad.1
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 13:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737927332; x=1738532132; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u0m5yL8s0TWSEEfxviVLYoEbDIw5bajMGnLn0okjgqc=;
 b=eWGo4O06s57EsC/RjsGJaycppLYHV2TmwTFCKmFife8/gQZfbaiDPDknI9GAtgvhJB
 wKz045Lw7RhNUk3qZNesmjKmMhwiBBa/0Ny4F6F+Ff7+OrPjAC43y2Ol1HzT4l5WyDvo
 wf3tovO/wj1tdyjl0G+gxQRi1TSsLhpcPjc0rBFlwv38iICRMYJ6k/UNyy3Wwgy1Pg0a
 JzuNn32WTmbxscC61XiRExMYqq7XD91Ukqwwj+Yv6AS4FHsY05yzb6mZzqag5U7CXsos
 T7hO9d4UWkLqZPLFDHJWJZjAUT4eT7g1ovHdqT0gxfzsuxyeKv1fOMZyBmUe+XKn0mKw
 XpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737927332; x=1738532132;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u0m5yL8s0TWSEEfxviVLYoEbDIw5bajMGnLn0okjgqc=;
 b=asxNKPsqSBPmiJnuHwsnjNcH5zv+bqKjMLWneRnVWmXa/rUUzMuQBxa/wwF8ZLXRCn
 olsEjE8GdLulM6CcvL/Wum7rO/4N+crtO0rmkhomlkgwe9RJb5fVSXyxKTHeL6jjxaCo
 FZq1uDdHvGyFUdfvNgiDYxZgBRem6tnL3kdTOucSTicnqeeeAVyENTS44aW+kQb5Tar7
 PqC5de8kRdbdRZsLGlnWC/uodJcQgJqgl2S+1mTWHmxBp0wK7ICaWJ0A0b5uY0ZL/xKF
 2CKWOn71v1EsHMnH9ASV0egE/b1DrmieBMjhwIoda+v93T1OTj1v/0JpXIcUOT2IQB2N
 9vmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnjQgGbaDugfBhuBM+1rqAdh9/poxYKCUdJ3jPw6SCLU95HkurB8w7ffgPlwsKXEZptf3KvogL4h05@nongnu.org
X-Gm-Message-State: AOJu0Yw51/ohlNtlkPGzrfdO6xz7XkxnpQ49GS7ro2Kfv4Dgob/chMLK
 B9J72lKI5lin+Zs1nFDagNMN9GHieQBBDOx+TZHGcps2H3ewEuZNXbQ3sqQ4UNU=
X-Gm-Gg: ASbGnctOGg9TnmzaEdYtZrJ2+KHNtd2P1zzVmofPqPX2JN2G6RTAG+KO8XQ3j/KwQmH
 lyVNCie/2MVELZaMvFdycak7B9lVOdS4FHXms0N6HYfD6/02jdRW082W/SBTTdi0+5UHpNzeweM
 IAkndEq5RgWhWwTUObPuaaA53UxOwuCFWKouMS0M491ygkGysXPlpjk2HCl6J2beOWrg3PwTBbc
 rtXO2eymj3tEZtWzT3sdKrTn7UVl9+FCwAwYGbBcdvMbVn2XoZuEofeNS5XLl10UyYMrRE9ceCb
 rUZTCwou7XAQ5ari9OLW+cQFO8ap7tyxMDBPhT0R6hH9mk8=
X-Google-Smtp-Source: AGHT+IF/uxXXMxK7HfifMI4lK/bjNl3NXv2LfDusZSj5Oq6BRtJb3xCpVAH5ppeGMpTK7NLB5Z4iRQ==
X-Received: by 2002:a17:903:191:b0:216:3466:7414 with SMTP id
 d9443c01a7336-21c355f6a9cmr669165345ad.44.1737927327477; 
 Sun, 26 Jan 2025 13:35:27 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3d9c552sm50455215ad.18.2025.01.26.13.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 13:35:27 -0800 (PST)
Message-ID: <4de30644-618d-4914-a1c6-008992c7edff@linaro.org>
Date: Sun, 26 Jan 2025 13:35:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] cpus: Register VMState per user / system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, David Hildenbrand <david@redhat.com>,
 qemu-s390x@nongnu.org, xen-devel@lists.xenproject.org
References: <20250123234415.59850-1-philmd@linaro.org>
 <20250123234415.59850-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250123234415.59850-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 1/23/25 15:44, Philippe Mathieu-Daudé wrote:
> Simplify cpu-target.c by extracting mixed vmstate code
> into the cpu_vmstate_register() / cpu_vmstate_unregister()
> helpers, implemented in cpu-user.c and cpu-system.c.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> XXX: tlb_flush() temporary declared manually.
> 
> Only 2 more CONFIG_USER_ONLY to go.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -22,10 +22,21 @@
>   #include "qapi/error.h"
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
> +#include "exec/tb-flush.h"
>   #include "exec/tswap.h"
>   #include "hw/qdev-core.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/core/sysemu-cpu-ops.h"
> +#include "migration/vmstate.h"
> +#include "system/tcg.h"
> +
> +/*
> + * XXX this series plan is to be applied on top on my exec/cputlb rework series,
> + * then tlb_flush() won't be declared target-specific in exec-all.h.
> + * Meanwhile, declare locally.
> + * XXX
> + */
> +void tlb_flush(CPUState *cs);

Ack.


r~

