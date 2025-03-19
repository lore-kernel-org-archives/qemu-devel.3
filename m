Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CF8C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 00:34:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhNw-0004YW-Gv; Tue, 18 Mar 2025 20:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhNU-0004GY-5A
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:33:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhNR-0003sS-Cl
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 20:33:47 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22349bb8605so139868165ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 17:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742344423; x=1742949223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xhVJhJ2VSN1T8HMbhJEADEU8OW7AJ57ZYg76V6x+0B4=;
 b=wcX7ySFEcIwk1+ZXkKR3Tj/B0tcssAR9CBI4sW0PEVMxF3GRAQgQSA3mDHAC113Ee3
 4fgX/jEo6Id7xAdbcu29sUuJQp5XVXNV2poPzSa36KDMKiXOpNe8P8CUrkzVUsuhiQLZ
 I96lNyALLdrO/q8/wOGIg8GV9XxgDXr5PezSfA+nWXHJcBNBPGodAzhUsGD8/9gZpnHu
 kUjaIZkpykfPAr478fEQbuCjOTX1lqi+zyUMWNrX1mwM9K2KSm4KDouKycWXiamDW98b
 rTOZv4MqtKg5Zws9b+s9OSgjqwBePqZEzKQ31WsT6jFVw0dsuaZGX5r+Y/MmLHSiuZn4
 iCMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742344423; x=1742949223;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xhVJhJ2VSN1T8HMbhJEADEU8OW7AJ57ZYg76V6x+0B4=;
 b=Z7weLLuqO5AGad1GFtU0QDeASbNEQ5EsU8e3MFulaW/ycWuZOmsx2XgF+xKiKeE+mR
 Gh2nbCXYhgfDk4jEc+z1GJ3+C3St9UaUVk3zfxKCynjKSIO0bOHK65i3wl5Bxh99lL8M
 h0kx4dh+BYpt+o95l5TJCddmV7Z5J9yIq/Z5t5B9RuLITGit3aSWcetSayMngBsoC+zd
 8B4+zQK8mU8iTXWe7AMZ1V/UivPK24k/MqbCMK2+04N+ii6MUWCkIU1eXIBwgoeVUjs1
 jYLrl1PGrVrNuVVdHQ7sV9a8KuHCWX33IWDuiN3MIk9qO3nJL2u5rZb/k9lIdimL66jb
 g/4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmX5GxLlbiPY9piA7wnQjv3nwJkxhfpjzlHKrdLsWJJg8Uabwo8ey9q7lC705nm2dWf1behVkPIVwh@nongnu.org
X-Gm-Message-State: AOJu0YzYq6aYTcnsxsPWkGjHit3A2XeOAd63QO3aBhVZOLvFghYlURI8
 BIUuV5WKDY5q0CQjdrWzKogdXsvimtVugqJw2E0QvB82lU5L4DWxvsRoYdjHJC0=
X-Gm-Gg: ASbGncsYUprEH4FrZBFx4o97brOqag/+u9F16RPAl/RkZQ2Ym80ILyZuWUDC8mnQNlk
 mPMcg5E7fWB6JIEb0nJail1DDEtDrteYjJtPd5Na2IhxuRFvCJ3oXz4Mh6HDdNQg+6hEabEQhSn
 6WCYjcMPR9H2SOAmKfF9nx+GIf7NGz+44DQfsA/5+lY8n2BEiU0z/Qo0QKCG7jcgWqlucIdQ9ON
 KMFGz6wEdSmPTLQIzYDO3AQqvrbC04OcTD3CBFjqaVgXKi8oaD0wLb25FqRArjqU4ImqoJ4GhHB
 pHZQQGY7s7Qv6+UcFRaSAouk4n9CR6DYwI7PCKujMuuajnyauJuc7lp35Q==
X-Google-Smtp-Source: AGHT+IG52DMeVwE7AOyUGCThjnxZPSzOLzwrkfdJz6fQ+XAXYAQusMhG1UL9xqZqwQOToaMcAS/h7w==
X-Received: by 2002:a05:6a20:2d24:b0:1f5:85f9:4ce6 with SMTP id
 adf61e73a8af0-1fbeb7a156fmr1218964637.11.1742344423484; 
 Tue, 18 Mar 2025 17:33:43 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9e195asm9790669a12.25.2025.03.18.17.33.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 17:33:43 -0700 (PDT)
Message-ID: <d57beca1-4be8-4332-b2d5-9f0368d7c007@linaro.org>
Date: Tue, 18 Mar 2025 17:33:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/42] include/exec: Split out icount.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-38-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250318213209.2579218-38-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/18/25 14:32, Richard Henderson wrote:
> Split icount stuff from system/cpu-timers.h.
> There are 17 files which only require icount.h, 7 that only
> require cpu-timers.h, and 7 that require both.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++
>   include/system/cpu-timers.h      | 58 ---------------------------
>   accel/tcg/cpu-exec.c             |  2 +-
>   accel/tcg/icount-common.c        |  2 +-
>   accel/tcg/monitor.c              |  1 +
>   accel/tcg/tcg-accel-ops-icount.c |  2 +-
>   accel/tcg/tcg-accel-ops-mttcg.c  |  2 +-
>   accel/tcg/tcg-accel-ops-rr.c     |  2 +-
>   accel/tcg/tcg-accel-ops.c        |  2 +-
>   accel/tcg/tcg-all.c              |  2 +-
>   accel/tcg/translate-all.c        |  2 +-
>   hw/core/ptimer.c                 |  2 +-
>   replay/replay.c                  |  2 +-
>   stubs/icount.c                   |  2 +-
>   system/cpu-timers.c              |  1 +
>   system/dma-helpers.c             |  2 +-
>   system/vl.c                      |  1 +
>   target/arm/helper.c              |  1 +
>   target/riscv/cpu_helper.c        |  2 +-
>   target/riscv/csr.c               |  2 +-
>   target/riscv/debug.c             |  1 +
>   target/riscv/machine.c           |  2 +-
>   target/riscv/pmu.c               |  2 +-
>   util/async.c                     |  2 +-
>   util/main-loop.c                 |  1 +
>   util/qemu-timer.c                |  1 +
>   26 files changed, 92 insertions(+), 75 deletions(-)
>   create mode 100644 include/exec/icount.h
> 
> diff --git a/include/exec/icount.h b/include/exec/icount.h
> new file mode 100644
> index 0000000000..4964987ae4
> --- /dev/null
> +++ b/include/exec/icount.h
> @@ -0,0 +1,68 @@
> +/*
> + * icount - Instruction Counter API
> + * CPU timers state API
> + *
> + * Copyright 2020 SUSE LLC
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef EXEC_ICOUNT_H
> +#define EXEC_ICOUNT_H
> +
> +/**
> + * ICountMode: icount enablement state:
> + *
> + * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
> + * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
> + * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
> + */
> +typedef enum {
> +    ICOUNT_DISABLED = 0,
> +    ICOUNT_PRECISE,
> +    ICOUNT_ADAPTATIVE,
> +} ICountMode;
> +
> +#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> +extern ICountMode use_icount;
> +#define icount_enabled() (use_icount)
> +#else
> +#define icount_enabled() ICOUNT_DISABLED
> +#endif
> +
> +/*
> + * Update the icount with the executed instructions. Called by
> + * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
> + */
> +void icount_update(CPUState *cpu);
> +
> +/* get raw icount value */
> +int64_t icount_get_raw(void);
> +
> +/* return the virtual CPU time in ns, based on the instruction counter. */
> +int64_t icount_get(void);
> +/*
> + * convert an instruction counter value to ns, based on the icount shift.
> + * This shift is set as a fixed value with the icount "shift" option
> + * (precise mode), or it is constantly approximated and corrected at
> + * runtime in adaptive mode.
> + */
> +int64_t icount_to_ns(int64_t icount);
> +
> +/**
> + * icount_configure: configure the icount options, including "shift"
> + * @opts: Options to parse
> + * @errp: pointer to a NULL-initialized error object
> + *
> + * Return: true on success, else false setting @errp with error
> + */
> +bool icount_configure(QemuOpts *opts, Error **errp);
> +
> +/* used by tcg vcpu thread to calc icount budget */
> +int64_t icount_round(int64_t count);
> +
> +/* if the CPUs are idle, start accounting real time to virtual clock. */
> +void icount_start_warp_timer(void);
> +void icount_account_warp_timer(void);
> +void icount_notify_exit(void);
> +
> +#endif /* EXEC_ICOUNT_H */
> diff --git a/include/system/cpu-timers.h b/include/system/cpu-timers.h
> index 64ae54f6d6..a1abed0d7a 100644
> --- a/include/system/cpu-timers.h
> +++ b/include/system/cpu-timers.h
> @@ -15,64 +15,6 @@
>   /* init the whole cpu timers API, including icount, ticks, and cpu_throttle */
>   void cpu_timers_init(void);
>   
> -/* icount - Instruction Counter API */
> -
> -/**
> - * ICountMode: icount enablement state:
> - *
> - * @ICOUNT_DISABLED: Disabled - Do not count executed instructions.
> - * @ICOUNT_PRECISE: Enabled - Fixed conversion of insn to ns via "shift" option
> - * @ICOUNT_ADAPTATIVE: Enabled - Runtime adaptive algorithm to compute shift
> - */
> -typedef enum {
> -    ICOUNT_DISABLED = 0,
> -    ICOUNT_PRECISE,
> -    ICOUNT_ADAPTATIVE,
> -} ICountMode;
> -
> -#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> -extern ICountMode use_icount;
> -#define icount_enabled() (use_icount)
> -#else
> -#define icount_enabled() ICOUNT_DISABLED
> -#endif
> -
> -/*
> - * Update the icount with the executed instructions. Called by
> - * cpus-tcg vCPU thread so the main-loop can see time has moved forward.
> - */
> -void icount_update(CPUState *cpu);
> -
> -/* get raw icount value */
> -int64_t icount_get_raw(void);
> -
> -/* return the virtual CPU time in ns, based on the instruction counter. */
> -int64_t icount_get(void);
> -/*
> - * convert an instruction counter value to ns, based on the icount shift.
> - * This shift is set as a fixed value with the icount "shift" option
> - * (precise mode), or it is constantly approximated and corrected at
> - * runtime in adaptive mode.
> - */
> -int64_t icount_to_ns(int64_t icount);
> -
> -/**
> - * icount_configure: configure the icount options, including "shift"
> - * @opts: Options to parse
> - * @errp: pointer to a NULL-initialized error object
> - *
> - * Return: true on success, else false setting @errp with error
> - */
> -bool icount_configure(QemuOpts *opts, Error **errp);
> -
> -/* used by tcg vcpu thread to calc icount budget */
> -int64_t icount_round(int64_t count);
> -
> -/* if the CPUs are idle, start accounting real time to virtual clock. */
> -void icount_start_warp_timer(void);
> -void icount_account_warp_timer(void);
> -void icount_notify_exit(void);
> -
>   /*
>    * CPU Ticks and Clock
>    */
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 372b876604..034c2ded6b 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -35,7 +35,7 @@
>   #include "exec/log.h"
>   #include "qemu/main-loop.h"
>   #include "exec/cpu-all.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "exec/replay-core.h"
>   #include "system/tcg.h"
>   #include "exec/helper-proto-common.h"
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index 402d3e3f4e..d6471174a3 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -35,7 +35,7 @@
>   #include "system/replay.h"
>   #include "system/runstate.h"
>   #include "hw/core/cpu.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/cpu-timers-internal.h"
>   
>   /*
> diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
> index eeb38a4d9c..1c182b6bfb 100644
> --- a/accel/tcg/monitor.c
> +++ b/accel/tcg/monitor.c
> @@ -14,6 +14,7 @@
>   #include "qapi/qapi-commands-machine.h"
>   #include "monitor/monitor.h"
>   #include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/tcg.h"
>   #include "tcg/tcg.h"
>   #include "internal-common.h"
> diff --git a/accel/tcg/tcg-accel-ops-icount.c b/accel/tcg/tcg-accel-ops-icount.c
> index 27cf1044c7..d0f7b410fa 100644
> --- a/accel/tcg/tcg-accel-ops-icount.c
> +++ b/accel/tcg/tcg-accel-ops-icount.c
> @@ -25,7 +25,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "system/replay.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/guest-random.h"
>   #include "hw/core/cpu.h"
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index bdcc385ae9..dfcee30947 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -26,7 +26,7 @@
>   #include "qemu/osdep.h"
>   #include "system/tcg.h"
>   #include "system/replay.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/notify.h"
>   #include "qemu/guest-random.h"
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index f62cf24e1d..6eec5c9eee 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -27,7 +27,7 @@
>   #include "qemu/lockable.h"
>   #include "system/tcg.h"
>   #include "system/replay.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/notify.h"
>   #include "qemu/guest-random.h"
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 5c88056157..ccdb781eef 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -29,7 +29,7 @@
>   #include "system/accel-ops.h"
>   #include "system/tcg.h"
>   #include "system/replay.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "qemu/main-loop.h"
>   #include "qemu/guest-random.h"
>   #include "qemu/timer.h"
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index c1a30b0121..7a5b810b88 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -26,7 +26,7 @@
>   #include "qemu/osdep.h"
>   #include "system/tcg.h"
>   #include "exec/replay-core.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "tcg/startup.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 167535bcb1..bb161ae61a 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -55,7 +55,7 @@
>   #include "qemu/cacheinfo.h"
>   #include "qemu/timer.h"
>   #include "exec/log.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/tcg.h"
>   #include "qapi/error.h"
>   #include "accel/tcg/cpu-ops.h"
> diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
> index 7f63d17ca1..0aeb10fb53 100644
> --- a/hw/core/ptimer.c
> +++ b/hw/core/ptimer.c
> @@ -11,7 +11,7 @@
>   #include "migration/vmstate.h"
>   #include "qemu/host-utils.h"
>   #include "exec/replay-core.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/qtest.h"
>   #include "block/aio.h"
>   #include "hw/clock.h"
> diff --git a/replay/replay.c b/replay/replay.c
> index 3adc387b3d..a3e24c967a 100644
> --- a/replay/replay.c
> +++ b/replay/replay.c
> @@ -11,7 +11,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/replay.h"
>   #include "system/runstate.h"
>   #include "replay-internal.h"
> diff --git a/stubs/icount.c b/stubs/icount.c
> index edbf60cbfa..ceb73b4fc2 100644
> --- a/stubs/icount.c
> +++ b/stubs/icount.c
> @@ -1,6 +1,6 @@
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   
>   /* icount - Instruction Counter API */
>   
> diff --git a/system/cpu-timers.c b/system/cpu-timers.c
> index 23dd82b465..cb35fa62b8 100644
> --- a/system/cpu-timers.c
> +++ b/system/cpu-timers.c
> @@ -36,6 +36,7 @@
>   #include "hw/core/cpu.h"
>   #include "system/cpu-timers.h"
>   #include "system/cpu-timers-internal.h"
> +#include "exec/icount.h"
>   
>   /* clock and ticks */
>   
> diff --git a/system/dma-helpers.c b/system/dma-helpers.c
> index 6bad75876f..0d592f6468 100644
> --- a/system/dma-helpers.c
> +++ b/system/dma-helpers.c
> @@ -13,7 +13,7 @@
>   #include "trace.h"
>   #include "qemu/thread.h"
>   #include "qemu/main-loop.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "qemu/range.h"
>   
>   /* #define DEBUG_IOMMU */
> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03..c17945c493 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -89,6 +89,7 @@
>   #include "audio/audio.h"
>   #include "system/cpus.h"
>   #include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "migration/colo.h"
>   #include "migration/postcopy-ram.h"
>   #include "system/kvm.h"
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 0454b06a6c..becbbbd0d8 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -24,6 +24,7 @@
>   #include "exec/translation-block.h"
>   #include "hw/irq.h"
>   #include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/kvm.h"
>   #include "system/tcg.h"
>   #include "qapi/error.h"
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6c4391d96b..0dd8645994 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -31,7 +31,7 @@
>   #include "accel/tcg/cpu-ops.h"
>   #include "trace.h"
>   #include "semihosting/common-semi.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "cpu_bits.h"
>   #include "debug.h"
>   #include "pmp.h"
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 49566d3c08..be4aebb9b2 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -27,7 +27,7 @@
>   #include "exec/exec-all.h"
>   #include "exec/cputlb.h"
>   #include "exec/tb-flush.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "qemu/guest-random.h"
>   #include "qapi/error.h"
>   #include <stdbool.h>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index fea989afe9..7fc9e121e1 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -32,6 +32,7 @@
>   #include "exec/helper-proto.h"
>   #include "exec/watchpoint.h"
>   #include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   
>   /*
>    * The following M-mode trigger CSRs are implemented:
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 889e2b6570..a1f70cc955 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -21,7 +21,7 @@
>   #include "qemu/error-report.h"
>   #include "system/kvm.h"
>   #include "migration/cpu.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "debug.h"
>   
>   static bool pmp_needed(void *opaque)
> diff --git a/target/riscv/pmu.c b/target/riscv/pmu.c
> index 0408f96e6a..a68809eef3 100644
> --- a/target/riscv/pmu.c
> +++ b/target/riscv/pmu.c
> @@ -22,7 +22,7 @@
>   #include "qemu/timer.h"
>   #include "cpu.h"
>   #include "pmu.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/device_tree.h"
>   
>   #define RISCV_TIMEBASE_FREQ 1000000000 /* 1Ghz */
> diff --git a/util/async.c b/util/async.c
> index 863416dee9..2719c629ae 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -35,7 +35,7 @@
>   #include "block/raw-aio.h"
>   #include "qemu/coroutine_int.h"
>   #include "qemu/coroutine-tls.h"
> -#include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "trace.h"
>   
>   /***********************************************************/
> diff --git a/util/main-loop.c b/util/main-loop.c
> index acad8c2e6c..42bd75c193 100644
> --- a/util/main-loop.c
> +++ b/util/main-loop.c
> @@ -27,6 +27,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/timer.h"
>   #include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/replay.h"
>   #include "qemu/main-loop.h"
>   #include "block/aio.h"
> diff --git a/util/qemu-timer.c b/util/qemu-timer.c
> index 788466fe22..1fb48be281 100644
> --- a/util/qemu-timer.c
> +++ b/util/qemu-timer.c
> @@ -27,6 +27,7 @@
>   #include "qemu/timer.h"
>   #include "qemu/lockable.h"
>   #include "system/cpu-timers.h"
> +#include "exec/icount.h"
>   #include "system/replay.h"
>   #include "system/cpus.h"
>   

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


