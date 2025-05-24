Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA18C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 24 May 2025 17:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIsXP-00019o-JI; Sat, 24 May 2025 13:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsXN-00019Y-GC
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:19:57 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uIsXL-00073B-Rr
 for qemu-devel@nongnu.org; Sat, 24 May 2025 13:19:57 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-442ed8a275fso11223315e9.2
 for <qemu-devel@nongnu.org>; Sat, 24 May 2025 10:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748107193; x=1748711993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Re9NadHWXR4Hm9X0VxiM63cQfbrk11H+klgvbWGQjmk=;
 b=zmrY9A48DPn/0t0EomIA/QPz6TVM35PWQBQzVq+vmoepHaeQO3CQbxNaYaDq5pHovC
 Wg66vtmvi9sCvpL8qi9F52dgyJbriZgx0k+zQ0+VEU/si61nfdnoOpbUIrvP8xSZhgrx
 crS1jThJgkMJ6q5rKsRidHvIAttxyAaq57fJ3PxnaBQVes3RxHk5+avhWt52er63rw1E
 Guo1Isz+gMTFysQNC9cUk3LW4o7JmBlmY7iaj+pahl/WzAzlIC38L/ZW7qJnvSpTLgSW
 Noq2d7Qb/gBw2AE+fNmpUfH9gl+2CejG87/sAkcDfa0Vpd1QwJ0+Ao72MrbqGtF2aZpE
 MpDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748107193; x=1748711993;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Re9NadHWXR4Hm9X0VxiM63cQfbrk11H+klgvbWGQjmk=;
 b=pPH7kyq/0eHJ8nlTVeQUGZxxl/6jvlHWMoDcwA6HkepGZkMowubfa3YewTrXR+h/sM
 JQbBLbvloWB6uqy2QXYBhOTxNh6TwDlLAwkNoYwMzMdlhmBv5C8s+Y9ShF8W4g6G/pOs
 UmJr618WtYzHvzg2u3cUd5ddTkNq6/8BFJVcYzqqTjWGITVMZVzLi446XXzrz8uRBcP5
 XL0h9bxpGMJKc3wYanIVJJ+5HnmYTFDYsxbZsh0/CQCV/iVA+n4PAzCsfEtbSTVTOnwi
 ggLoK3awM4EOsLg9tYcqFF+/RhAKdU1/y1giS0u1SEVnqNyBdDtCMxMpjimrDWBwROsr
 1C0g==
X-Gm-Message-State: AOJu0YyH/T8zx+sf4Mfd+KQDWeCAq3Nflkz3ymbD/5uxoGgWx5yaekgQ
 ZNfG44R4CPZfr2jxdD8FcmXXdWTowFj80Cuf2KDXoQpj/KGk0VnylxDfNRWEqMI6I0FdZxe0zsr
 nhpma6W2Ucg==
X-Gm-Gg: ASbGncsUffdq5yNIX/+14d4BzsJ5gYy6BU4/pmgaTUn8qlAJh9M05Escf72psdw2c2h
 05VrGeDOhSW3gO6klhxVR2y5OeUmMFSHuhYiKJVzzhsVnpjxqFYDX/KlgWqsTjKQ4xDIE60GNDv
 ELHRe5IHSgZWM3ZxYzJvGViEHFsLHCwTfB7tFcTzbcOeLoP7XE2zbeyxQFf/8IcHUWHK11RQvS8
 SXbaG8MhuNAduwHKpk9/0jViRH/EB61TdX7Qj97v1Siq+R0mXY/YgRA/zE1Zz71Ll3Z0DRH6cfy
 YaFg8IpOCgLEKFiQ8C+2kRYSxiffQV+9eCCJ+rmF6VfeAzI+0lg4MupSX7UnU7Me0g==
X-Google-Smtp-Source: AGHT+IEx/kHdF+9FVr64iUwpwtMMapuDowM/DQkGsu8mY+OeQskuUjltpU2fkf2rSb8I5K2fzPIlUg==
X-Received: by 2002:a05:600c:1c97:b0:43d:2230:300f with SMTP id
 5b1f17b1804b1-44c8f071dc3mr31650145e9.0.1748107193157; 
 Sat, 24 May 2025 10:19:53 -0700 (PDT)
Received: from [172.16.25.47] ([195.53.115.74])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f18251adsm189623785e9.2.2025.05.24.10.19.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 May 2025 10:19:52 -0700 (PDT)
Message-ID: <be2f91dc-c156-4f1b-95b0-2e7be3a860d4@linaro.org>
Date: Sat, 24 May 2025 18:19:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/25] target/m68k: call plugin trap callbacks
To: qemu-devel@nongnu.org
References: <cover.1747666625.git.neither@nut.email>
 <d559b98b46bf7c9a410a0ff4ff7ca4a5cc403281.1747666625.git.neither@nut.email>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <d559b98b46bf7c9a410a0ff4ff7ca4a5cc403281.1747666625.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/19/25 16:19, Julian Ganz wrote:
> We recently introduced API for registering callbacks for trap related
> events as well as the corresponding hook functions. Due to differences
> between architectures, the latter need to be called from target specific
> code.
> 
> This change places hooks for Motorola 68000 targets.
> 
> Signed-off-by: Julian Ganz <neither@nut.email>
> ---
>   target/m68k/op_helper.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/target/m68k/op_helper.c b/target/m68k/op_helper.c
> index f29ae12af8..ca15af5765 100644
> --- a/target/m68k/op_helper.c
> +++ b/target/m68k/op_helper.c
> @@ -22,6 +22,7 @@
>   #include "exec/helper-proto.h"
>   #include "accel/tcg/cpu-ldst.h"
>   #include "semihosting/semihost.h"
> +#include "qemu/plugin.h"
>   
>   #if !defined(CONFIG_USER_ONLY)
>   
> @@ -183,6 +184,21 @@ static const char *m68k_exception_name(int index)
>       return "Unassigned";
>   }
>   
> +static void do_plugin_vcpu_interrupt_cb(CPUState *cs, uint64_t from)
> +{
> +    switch (cs->exception_index) {
> +    case EXCP_SPURIOUS ... EXCP_INT_LEVEL_7:
> +        qemu_plugin_vcpu_interrupt_cb(cs, from);
> +        break;
> +    case EXCP_SEMIHOSTING:
> +        qemu_plugin_vcpu_hostcall_cb(cs, from);
> +        break;
> +    default:
> +        qemu_plugin_vcpu_exception_cb(cs, from);
> +        break;
> +    }
> +}
> +
>   static void cf_interrupt_all(CPUM68KState *env, int is_hw)
>   {
>       CPUState *cs = env_cpu(env);
> @@ -200,9 +216,11 @@ static void cf_interrupt_all(CPUM68KState *env, int is_hw)
>           case EXCP_RTE:
>               /* Return from an exception.  */
>               cf_rte(env);
> +            qemu_plugin_vcpu_exception_cb(cs, retaddr);
>               return;

EXCP_RTE is not an architectural exception, it's qemu implementation detail.  Think 
"subroutine return, and also pop cpu state".  I don't think you should expose this. 
Certainly you're not instrumenting "return from exception" for other targets.

> @@ -277,12 +297,14 @@ static void m68k_interrupt_all(CPUM68KState *env, int is_hw)
>       uint32_t sp;
>       uint32_t vector;
>       uint16_t sr, oldsr;
> +    uint64_t last_pc = env->pc;
>   
>       if (!is_hw) {
>           switch (cs->exception_index) {
>           case EXCP_RTE:
>               /* Return from an exception.  */
>               m68k_rte(env);
> +            qemu_plugin_vcpu_exception_cb(cs, last_pc);
>               return;
>           }
>       }

Likewise.


r~

