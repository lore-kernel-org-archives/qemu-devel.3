Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCCBC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 07:22:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN4vM-0002ze-Om; Thu, 05 Jun 2025 03:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN4vJ-0002zJ-Im
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 03:22:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uN4vH-0002Ty-MV
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 03:22:01 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a36748920cso667492f8f.2
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 00:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749108117; x=1749712917; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eszciaitP2kB1wQYPJUOg1SRbq5XGBMAmIFs1ludgkA=;
 b=hlMxv35u2gWf/GL1xEOkESLvAhTmg0uMV45gCwq/bPd+CLHqWLcBVxHHKi/51mGYfe
 +lba866j99oK91XZ72baHNaSi+NS9MYbA/EcOcsNhg9Whkp0d9+n6dDz3/+dwLcYSz7a
 dd6wrxYglLhJ7S1RTthD8pUxFUkMKICE1MaTEDY1dIlLRe7Vk39W+odHgvY/1Qc8UO50
 oM5aljAw11IwQa46SnxlHdR7XTlZRMkssPMeWXGoGmyvoKY+nro9xb1xRpaDwIPZ7YoO
 5/XsoqEwmB9iNbrMR+aOc31dfjmgMGbfqB/Nd0j2OUdOkYz/DlAXvlNLDRFZCgw1o6BP
 LYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749108117; x=1749712917;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eszciaitP2kB1wQYPJUOg1SRbq5XGBMAmIFs1ludgkA=;
 b=MiCZwx1Xob38tuZbkeqQ9hY3+cDd+lS2Q8/nO9CnWUGvhNhDkriIeSPDuOquFwZgyW
 euzn8iHv+mlTnOA9eQphO8xrZee5NyzEOjVLGoed0jz/kbMDSpI231D+PfXBtfPaDhCG
 qSKHJdz9Ph4Pe0fCkewJLigXT2RTY2ud5HI2ABwdSkK/InHJzNeobvDVYBdrLZ9SOiPm
 OBh0LZlw7uSHdGZu3OOSqMzKqEENeaVrQedu8i33z85Al4lpwMGzGGCif9HNEXgBNtSc
 5awlCY5mlINcdVzdLsos2TIlytVK0TCZTJoBKh/uC4MQULSgzEWlpa11VKVE9ZTzxJl8
 Rn4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZ2DMWHnh8rBBqlL75ueuVsTVsbpueob3KiTQ9uDeqdMJKdTySiQSs5x7sEIGxYyp8ROGqLCor5z+v@nongnu.org
X-Gm-Message-State: AOJu0YxOXhlyB1xlIQTbd7zm+CkLzrJOz4m+/WeaUOygNYezANoYVsNO
 7TJDMorAEXXOywtSeIqpIrE19/jXjTEohi+cAnw7tQvuTQMyhvgnz9PbY314+Ze++N0=
X-Gm-Gg: ASbGncvTvVyN7xuvWW/8GNxVfjt1sop7NC2cXDNELXA35BQldPcPDFgjFU3+eBe0DmH
 WwJL069tNKakEbdQNJL4ODhMod6oCg1gaiUPcIKewuQdyKhtLcwesgk1gFrZu02IKCIhrEMsTlG
 U2Y6R70VziDsuhOWyjzFhSxLnSelDDSfU6HLV+Elg9H1e8IWuiZQVbFDU3p431HUzvU0Msp6f+3
 wUzHOjusXj2Q26RPUKLzy2Hq9g+gylGVvA/Fm7b5mJf13QzHKCp9jjfai+OFsVwRppmN8B1Zf4K
 oV2VHT9NSQXuSun2ztOgm4dw8vf3ZIUOelTwUZTDtnvEz3fJ4KvIFSHFPjY286pOUfcpQnbY75c
 FBmJbVe1fW4c/FPEVcwU=
X-Google-Smtp-Source: AGHT+IEjOL6smuYYX/DA1Fzx74mxQwdM687BoooY6oqtJyW85/jq0UTol/UeHovN19xIRHNpfYvqyQ==
X-Received: by 2002:a05:6000:25c4:b0:3a4:fc3f:ed28 with SMTP id
 ffacd0b85a97d-3a51d95dfc4mr4608934f8f.29.1749108117271; 
 Thu, 05 Jun 2025 00:21:57 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f990cffasm14408375e9.19.2025.06.05.00.21.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 00:21:56 -0700 (PDT)
Message-ID: <369151f7-cde7-4065-ac0a-5364214e8d2c@linaro.org>
Date: Thu, 5 Jun 2025 09:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/tcg: Make round-robin kick period configurable
To: Ethan Chen <ethan84@andestech.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com
References: <20250605061852.2081342-1-ethan84@andestech.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250605061852.2081342-1-ethan84@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Hi Ethan,

On 5/6/25 08:18, Ethan Chen via wrote:
> This change introduces a configurable round-robin kick period, giving users the
> flexibility to balance SMP simulation accuracy and performance according to
> their specific needs.
> 
> The round-robin kick period is the time one vCPU can run before scheduler
> switches to another vCPU when using a single thread TCG. The default value of
> 0.1 seconds may allow one vCPU to run for too long before the scheduler
> switches to another. This behavior may not be suitable for workloads with
> strict timing requirements.
> 
> Reducing the period can improve the fidelity of SMP simulation by allowing
> more frequent vCPU switching, though it may negatively impact overall
> simulation performance.
> 
> Signed-off-by: Ethan Chen <ethan84@andestech.com>
> ---
>   accel/tcg/tcg-accel-ops-rr.c |  2 +-
>   accel/tcg/tcg-accel-ops-rr.h |  2 +-
>   accel/tcg/tcg-all.c          | 35 +++++++++++++++++++++++++++++++++++
>   qemu-options.hx              |  9 ++++++++-
>   4 files changed, 45 insertions(+), 3 deletions(-)


> diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
> index 2a76a29612..324bb772cb 100644
> --- a/accel/tcg/tcg-accel-ops-rr.h
> +++ b/accel/tcg/tcg-accel-ops-rr.h
> @@ -10,7 +10,7 @@
>   #ifndef TCG_ACCEL_OPS_RR_H
>   #define TCG_ACCEL_OPS_RR_H
>   
> -#define TCG_KICK_PERIOD (NANOSECONDS_PER_SECOND / 10)
> +extern uint64_t rr_kick_period;

No need for another extern, pass it as argument:

-- >8 --
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index f62cf24e1d4..551864b5509 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -62,9 +62,9 @@ void rr_kick_vcpu_thread(CPUState *unused)
  static QEMUTimer *rr_kick_vcpu_timer;
  static CPUState *rr_current_cpu;

-static inline int64_t rr_next_kick_time(void)
+static inline int64_t rr_next_kick_time(uint64_t kick_delay_ns)
  {
-    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + TCG_KICK_PERIOD;
+    return qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + kick_delay_ns;
  }

  /* Kick the currently round-robin scheduled vCPU to next */
@@ -83,15 +83,20 @@ static void rr_kick_next_cpu(void)

  static void rr_kick_thread(void *opaque)
  {
-    timer_mod(rr_kick_vcpu_timer, rr_next_kick_time());
+    CPUState *cpu = opaque;
+
+    // here use rr_next_kick_time(cpu->accel->rr_kick_delay_ns):
+    timer_mod(rr_kick_vcpu_timer, rr_next_kick_time(TCG_KICK_PERIOD));
      rr_kick_next_cpu();
  }

  static void rr_start_kick_timer(void)
  {
-    if (!rr_kick_vcpu_timer && CPU_NEXT(first_cpu)) {
+    CPUState *next_cpu = CPU_NEXT(first_cpu);
+
+    if (!rr_kick_vcpu_timer && next_cpu) {
          rr_kick_vcpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
-                                           rr_kick_thread, NULL);
+                                           rr_kick_thread, next_cpu);
      }
      if (rr_kick_vcpu_timer && !timer_pending(rr_kick_vcpu_timer)) {
          timer_mod(rr_kick_vcpu_timer, rr_next_kick_time());
---

> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 6e5dc333d5..69390020aa 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -36,6 +36,7 @@
>   #include "qapi/qapi-builtin-visit.h"
>   #include "qemu/units.h"
>   #include "qemu/target-info.h"
> +#include "qemu/timer.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/boards.h"
>   #endif
> @@ -50,6 +51,7 @@ struct TCGState {
>       bool one_insn_per_tb;
>       int splitwx_enabled;
>       unsigned long tb_size;
> +    uint64_t rr_kick_period;

'rr_kick_delay_ns' seems more accurate.

>   };
>   typedef struct TCGState TCGState;
>   
> @@ -76,9 +78,11 @@ static void tcg_accel_instance_init(Object *obj)
>   #else
>       s->splitwx_enabled = 0;
>   #endif
> +    s->rr_kick_period = NANOSECONDS_PER_SECOND / 10;
>   }
>   
>   bool one_insn_per_tb;
> +uint64_t rr_kick_period;

(Drop)

>   
>   static int tcg_init_machine(MachineState *ms)
>   {
> @@ -125,6 +129,7 @@ static int tcg_init_machine(MachineState *ms)
>   #endif
>   
>       tcg_allowed = true;
> +    rr_kick_period = s->rr_kick_period;

(Drop)

>   
>       page_init();
>       tb_htable_init();
> @@ -234,6 +239,30 @@ static int tcg_gdbstub_supported_sstep_flags(void)
>       }
>   }

Patch LGTM otherwise.

Regards,

Phil.

