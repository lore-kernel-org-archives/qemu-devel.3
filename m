Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F31CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 09:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0z3V-0008GU-Dn; Tue, 23 Sep 2025 05:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0z3S-00089Y-Gu
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:11:22 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0z3F-0000i3-UI
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 05:11:21 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46c889b310dso23323285e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 02:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758618662; x=1759223462; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aDmCW/5cNlIWUqKjSuSSDU6RxKK5oezNvlBBOz2U3QE=;
 b=eDzlDl+2hjFkrksIfaEife2ksztkIN7p5Ro3C5YP4D+HM06lsZyMyuVdhnv0IYlIRM
 zdMOba7xoP6STzthCw6uTXQdFJGcKYiU+GK289kCYz9cbkl+GGSACeovyBvm8A22QKh8
 wR4f/7ARuYWvGw3rXM0pqNRjv9g3hR6xZjW3qyegj8au8GAefT0/zVTfMbPyxJlFoN8T
 t8EVE8b5Q8CftAzfMCtD3wnifEo+gKb5xjFKsM481LR+Mr4KG7vk4NfQrT4FCfRor92f
 FkmAfqxuAzJGFkllZ/40gVXUOeDSR1RriQwUK/Bp/SzodtkoepgugHCljqmcLJHPl6UY
 I2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758618662; x=1759223462;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aDmCW/5cNlIWUqKjSuSSDU6RxKK5oezNvlBBOz2U3QE=;
 b=dH5LW2TNgbaLT+3yvuqbZm6JppVyCYFho+KiyTFiKLUacEh71qcudUkZq+cQD4JWoA
 ESNMj790q4AzmzWgCfREBYrliUVrXPZNcadvGb/4SWydaKdUnSZGvis5wLi/7/lXGcEU
 OoUOZ2hFXKkbK+b7V9rm41eRNaq1SnPuuG/Qt5yVZeY68eiss5mmK2QkjSgK8MUhnMvX
 PDVlRbI2DCdXt6Q/ylXIkan4IXQwiQOZ9DwWtdeumrRqsyp413VtqNj+a5CtV6qv7smv
 w4yJdjxtJ4BI18Ny/VHkkKwhyTQ70FZHEjJtDPTj899ypnjRKFGFDhw1BmLIDdwGLQyI
 UtqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr8PJk9KW6gpiO1EmGO5jyFvxbxaqmcKkrh1sA27Z1Nl7t0WiGnYB2pLhvroOrazUdUtHpm1fA1Bq7@nongnu.org
X-Gm-Message-State: AOJu0YzykyvqTay+lV/JUx7ipjIWzbjDkVHRGWDi8MzYnbX0AZkbKqSa
 9xgVpbGIhefinBAydUdEG1MsEq53wxS1wW6edJNWjwsPApPzrIzkv9wHY3cbtEwRP+U=
X-Gm-Gg: ASbGnct4DiTQYwkO3rd20T44T3Le0df73OB987acDL1ShtzG76NGKE0+legSyQlAqAT
 4Q7L43VKKUfFXxOk1t9mdneQzWTh7HqQ3MKF8jWN5ZFwpEc9v8plfQFYp94o7GFyMyhOZzkJSbU
 GPCJkm2yq7n++ZMrvpk92Pj6G6s5iVe9iKUw5dyEP7CitzjH8DF+nbe0907+N3Su6jWQ7EX7YKM
 g3pXXiihEDg6tdp5UCE4q02d3d4t4SZYW5gWUWE9JdROBRGTfBsxs6c5o9mxZWevfKEQtd9bY7x
 REQ5jUCSncNZQ2w6Hy2ZnxTItp4TwiGujwzP3etQpsId05MG2T9ZAq/5XOfgjr7j5ajsU7Jp4it
 BOlJnlLm1OrwERyvyDXXE1l7HuGrvu0d09SyPRAQWTgVZjoA76MG8Q5H9tj5z3otKjA==
X-Google-Smtp-Source: AGHT+IHTiRcNAKYuWEuSQYuErm94f6Sn1DwcEX6WVsdt1ZvocOgxnM4NWiRwwMgqQE61tQVowe1W+A==
X-Received: by 2002:a05:600c:6305:b0:46e:1a60:c995 with SMTP id
 5b1f17b1804b1-46e1e1122e4mr16571595e9.2.1758618662489; 
 Tue, 23 Sep 2025 02:11:02 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d5d437b90sm71537225e9.13.2025.09.23.02.11.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 02:11:01 -0700 (PDT)
Message-ID: <199f10af-7c15-4787-ae2a-8eb2714a1a22@linaro.org>
Date: Tue, 23 Sep 2025 11:11:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] gdbstub: Remove tb_flush uses
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/9/25 04:39, Richard Henderson wrote:
> This hasn't been needed since d828b92b8a6
> ("accel/tcg: Introduce CF_BP_PAGE").
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   gdbstub/system.c | 4 ----
>   gdbstub/user.c   | 3 ---
>   2 files changed, 7 deletions(-)
> 
> diff --git a/gdbstub/system.c b/gdbstub/system.c
> index 5be0d3c58c..df3514dc74 100644
> --- a/gdbstub/system.c
> +++ b/gdbstub/system.c
> @@ -18,7 +18,6 @@
>   #include "gdbstub/syscalls.h"
>   #include "gdbstub/commands.h"
>   #include "exec/hwaddr.h"
> -#include "exec/tb-flush.h"
>   #include "accel/accel-ops.h"
>   #include "accel/accel-cpu-ops.h"
>   #include "system/cpus.h"
> @@ -174,9 +173,6 @@ static void gdb_vm_state_change(void *opaque, bool running, RunState state)
>           } else {
>               trace_gdbstub_hit_break();
>           }
> -        if (tcg_enabled()) {
> -            tb_flush(cpu);
> -        }
>           ret = GDB_SIGNAL_TRAP;
>           break;
>       case RUN_STATE_PAUSED:

To squash:

-- >8 --
diff --git a/gdbstub/system.c b/gdbstub/system.c
index f31d401e0b3..c139476bf26 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -26,3 +26,2 @@
  #include "system/replay.h"
-#include "system/tcg.h"
  #include "hw/core/cpu.h"
---

