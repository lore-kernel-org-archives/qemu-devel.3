Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1E7F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 23:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCQzv-0002HB-UP; Mon, 13 Apr 2026 19:47:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQzu-0002Gu-UV
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:47:18 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCQzt-0001eh-Aw
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 19:47:18 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c76b0cda2aeso2041962a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776124035; x=1776728835; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MxALAJRMrmCWLQPF+9QIvUXcd/yCenDPuIZmayH3Eac=;
 b=mG/MN2b5j9nCxmUZ1BwJCQxCNJ1SweySzg02GqzuUd1lUnB9J2Yoat1lGk/eKJxSfO
 0mNI5r2QkSGDcmAQow2zduNPYVakXEr/jnPylD0kXbptg168FjkevCZ+QxGg54Q4IPB1
 of0p8Kz4PmTZy2DF7f1bwrUiQ7d4tkPD7hgxeWawR9OtP/S7LEVlIi7QS86DtaWh9O+W
 zX/++vB+YOPdRpjHUSF4QKXmyS/xG0wwQ+dOV+g/5vpOEBcIUQWHrKOyKEI0Il6+cBzZ
 Nkg/KcKmdRPfbsyLK+lWRcU4Wa8HDBBATH7Jq3SUQXwKb1bIU22mx1q6clZd1XPyXHvv
 F3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776124035; x=1776728835;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MxALAJRMrmCWLQPF+9QIvUXcd/yCenDPuIZmayH3Eac=;
 b=e0AJ62ZkOgmf25nRMxm95Ctheu227SfiV3svUUfXMt4iVHHNtPHqn+o9fr2Q2biFC8
 OsB9jAydA97PsyhDch0ADqf4RrNzMsLfTBQev5cmIFfUd/W0rM+rIMzEtHQBfJ0OKjLI
 etZR/t4lUXYQ0/AbrSv/Fi0dXjAItVpYWT03IU0w1rNKZkhE1mWU/ORF5V92mTc98mG6
 Mg8uY3/JsvjDNs+shQbaaB+ssXeHQIxNnO3KoILPAoBy8WoIoHoYgbGY9qU5kakxqRR2
 pj7attnf12LRXScx0c9T3s7wCRdTeHYoilLm6lHEfcreN8EZ2jaEgtnrx3HQjN/bXUJl
 IIZg==
X-Gm-Message-State: AOJu0YzbRwz5tRqkisCfCz8q04psMtozcYc1z4S5xy+9LqrCNmUwDru8
 HcdZO8x71ev+pqUCnxRsruzLmk/9B3nKEGxsplkdvTKHlU8fjkGXPd/Rk+jiK9IW9ip5GNVH3ss
 lGSZ1
X-Gm-Gg: AeBDieukNgQufEDWbpbG0z0WZA58PgXfNbtJlzx0zEJ0vXrdPNfd1dqFOMX9NUZGxzi
 Pf4cRuWoZIhE/NoCl350TeqxOl8kDZe7goru7HwColnWp5FTT2kBwFQzQ98XGSNV+e4fWH01gfA
 xcbNO9eLwFNyz6f0SY2H0kjbo5Jw1LHH1UK3eNpziJ5XGjl+tewSGn2mJ8x3uC2t9xuY88Cz31O
 KDKWQx738wwPY6LCl/dp3uh3Cy3WIR+PuGBb5yR0KF1Gm+Verc+21jwcgavy0hFukICa06vWLgR
 uwQ+8z10Di2xlWg+VjQzhhDrPPRmlijGLwqoZwxE2yWjXNPNrqGBEpypdnw2kjc/syYTGOfmf61
 vLamgwXm7Clp3DbX48ya5Y6UFbLCqHJBBgmnKnNrlJxOpENRAFbe6NK2caoA0Cu2py1RDMLHYOz
 Jvr7R/vvy+ofbJQdi9gXLO8y3KxS0HtyHvIXZYXFIxgKJHZskxwYO3vYahJdOSUe0hArRQTok0o
 Nql9o1GmdBTTQ==
X-Received: by 2002:a05:6a00:12cc:b0:82c:eafa:8875 with SMTP id
 d2e1a72fcca58-82f0c26b33bmr14779523b3a.2.1776124034940; 
 Mon, 13 Apr 2026 16:47:14 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f0c34f7d0sm13162625b3a.14.2026.04.13.16.47.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 16:47:14 -0700 (PDT)
Message-ID: <0c1cbc35-acc2-4ead-a8cd-419cf952a750@linaro.org>
Date: Tue, 14 Apr 2026 09:47:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/9] target/arm: Introduce mo_endian() helper
To: qemu-devel@nongnu.org
References: <20260410200628.19378-1-philmd@linaro.org>
 <20260410200628.19378-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410200628.19378-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 4/11/26 06:06, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/internals.h      | 3 +++
>   target/arm/helper.c         | 8 ++++++++
>   target/arm/tcg/mve_helper.c | 3 ++-
>   3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index e92a967f575..f21555a69fd 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -28,6 +28,7 @@
>   #include "exec/hwaddr.h"
>   #include "exec/vaddr.h"
>   #include "exec/breakpoint.h"
> +#include "exec/memop.h"
>   #include "accel/tcg/tb-cpu-state.h"
>   #include "hw/core/registerfields.h"
>   #include "tcg/tcg-gvec-desc.h"
> @@ -46,6 +47,8 @@
>   #define BANK_HYP    6
>   #define BANK_MON    7
>   
> +MemOp mo_endian(CPUARMState *env);
> +
>   static inline int arm_env_mmu_index(CPUARMState *env)
>   {
>       return EX_TBFLAG_ANY(env->hflags, MMUIDX);
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7389f2988c4..037d2bcf376 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -38,6 +38,14 @@
>   
>   static void switch_mode(CPUARMState *env, int mode);
>   
> +MemOp mo_endian(CPUARMState *env)
> +{
> +    if (!is_a64(env) && arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env))) {
> +        return MO_BE;
> +    }
> +    return MO_LE;
> +}

For use within tcg, which this is,

   EX_TBFLAG_ANY(env->hflags, BE_DATA)

would be better.


r~

