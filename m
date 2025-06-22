Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD2BAC7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAV5-0003WV-Ut; Sat, 21 Jun 2025 22:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAV3-0003V7-IE
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:32:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAV1-0005Pr-Tg
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:32:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2363497cc4dso26380975ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559522; x=1751164322; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vhRLZQcK9930OrczbUKBIJ5abOm/9JveApuOQuaUVfo=;
 b=sVdSKiUdeRqs0br5XA4pSDremqxXklNeKcz9WcNxTRpBPx8vHJSGI7GNoyoKhQMsU/
 GawQrTg7G8w1oECuGcFTobKLDHvw9EWLs6wJiO/Pjhn+/URoqqwMtBkpoYGCy5i5HW5M
 YETlYfK50Ne1pYrbWT0vBTJij9fI7KK7NYLqkNzZEn9TEEyV7swCLiG6gCg9VtDaSSDf
 3KTXFGv++OSI420BFJtEaHWvDlVT1CrUkTcTxWyTjuJAyluNP3I/iGBdsi163G+MDwTy
 oVd72gfsbuhWL4nP+c/C+FQVaLy+JU5545wvQ5IWo2uOwI9v64dcR3rkHKuuejjH+SUY
 nZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559522; x=1751164322;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vhRLZQcK9930OrczbUKBIJ5abOm/9JveApuOQuaUVfo=;
 b=FCiLSwMo/l8GFzq4SWiX5TLfgwsA26Rcb3tokcXlSK1u89U5kboxk6lPLC6xYIc27X
 squ77aKCp4OL57KKULXzfaJuyVEBawpbVHmWLS1Oqnim3G8nHkOt4swd22HAuF93/06Q
 OeLalK1f1J2/Ws12Cra8EMt4BRIAKrkX8FqbVWnWc43FIhl/q2nMvMeuHyvsHASPkurF
 zTWcv6M3OcBZjfwsIxFfL9iuWog/9YuCMnTRJH2YMz4OLMiiMUANPQ6PQ5uRi2bK8xsP
 c+xEf5GgV/r2hjvXgYX+oP4xNxl2eNJlf132HGfDGMUvLM5yGfsnG2FaUQL5nl1qaF/m
 MhZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA2NQf0XD9afgIFlUWLEo0uCGlX8ipb7ZYogtmaJdn/GpWrSBvHJE6s3A6Bd93gNn2pij5cn4oe1/P@nongnu.org
X-Gm-Message-State: AOJu0YyNH1a0pnzxXc8LzYQrCYPfLsjaUuu0ubmWd5PzTYK0CbWFkcPv
 mv1jxmVlr4q95dBuCHEOuzi8gAqUs2pu/ljLF+vRuQVeu+yYzBpBeHOfuYIaRlKATdU=
X-Gm-Gg: ASbGncsrHaEf7qkUVfF3y+ulJLcvs97/CSWU7TI5hfDlsq+cS4QgFMIFT7gKk38pg0/
 /p0DRyKFc5a3RRRgPcQqJNUZ37ZDMlGwlTaEdxomluC7b6EHbC9nnPSoZTX5VaxQ0V6FR9FeZXI
 ja7DHFNFmnL8id1RjIhT39Bcv0x1o1qYIn+Clhs7xksdcMJE8vnut8w3WkU/xX6tr1t878UbjG/
 AU3otwWA64EWPyVl1Mz+NpsbeGJGciA90dAdhqgeoU7QBtvv+OFWJLxHKNsfZOkVilN5aHkPZB5
 RnOpre6ukCk4KADDAGaIU+7uKKFiYeMvdr5eKvXZNE0cweRRA5zmn3TQWqBjB+atAqIsr56OPM6
 rFzWIbF7v2qUDvbFbECeMyvKROmi4
X-Google-Smtp-Source: AGHT+IFGwQ3gpSkOLd7qE0fjSk55wZTL6FTya9HtLj22EfR6F9rciIBA3VDtGGzXpV88ZHFyV4SMLA==
X-Received: by 2002:a17:902:f689:b0:231:e331:b7df with SMTP id
 d9443c01a7336-237d9991786mr132102625ad.29.1750559522202; 
 Sat, 21 Jun 2025 19:32:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d83ed5f9sm50822185ad.71.2025.06.21.19.32.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:32:01 -0700 (PDT)
Message-ID: <8c87ac98-0329-4b3e-bd36-3a0ccd992b07@linaro.org>
Date: Sat, 21 Jun 2025 19:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 09/42] accel/split: Add cpu_thread_routine()
 stub
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 70 ++++++++++++++++++++++++++++++++++-
>   1 file changed, 69 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index e5c1d51d426..294ea79420e 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -7,11 +7,79 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/guest-random.h"
> +#include "exec/cpu-common.h"
>   #include "system/accel-ops.h"
> +#include "system/cpus.h"
>   
>   static void *split_cpu_thread_routine(void *arg)
>   {
> -    g_assert_not_reached();
> +    CPUState *cpu = arg;
> +    int r;
> +
> +    /* TODO: check accel allowed */
> +
> +    rcu_register_thread();
> +
> +    bql_lock();
> +    qemu_thread_get_self(cpu->thread);
> +
> +    cpu->thread_id = qemu_get_thread_id();
> +    current_cpu = cpu;
> +
> +    /* TODO: init_vcpu_thread() */
> +    /* TODO: allocate AccelCPUState */
> +
> +    /* signal CPU creation */
> +    cpu_thread_signal_created(cpu);
> +    qemu_guest_random_seed_thread_part2(cpu->random_seed);
> +
> +    /* process any pending work */
> +    cpu->exit_request = 1;
> +
> +    do {
> +        r = 0;
> +
> +        if (cpu_can_run(cpu)) {
> +            r = 0; /* TODO: exec_vcpu_thread() */
> +            switch (r) {
> +            case 0:
> +                break;
> +            case EXCP_INTERRUPT:
> +                break;
> +            case EXCP_YIELD:
> +                break;
> +            case EXCP_DEBUG:
> +                cpu_handle_guest_debug(cpu);
> +                break;
> +            case EXCP_HALTED:
> +                /*
> +                 * Usually cpu->halted is set, but may have already been
> +                 * reset by another thread by the time we arrive here.
> +                 */
> +                break;
> +            case EXCP_ATOMIC:
> +                bql_unlock();
> +                cpu_exec_step_atomic(cpu);
> +                bql_lock();
> +                break;
> +            default:
> +                /* Ignore everything else? */
> +                break;
> +            }
> +        }
> +        qemu_wait_io_event(cpu);
> +    } while (!cpu->unplug || cpu_can_run(cpu));
> +
> +    /* TODO: destroy_vcpu_thread() */
> +
> +    cpu_thread_signal_destroyed(cpu);
> +    bql_unlock();
> +
> +    rcu_unregister_thread();
> +
> +    return NULL;
>   }
>   
>   static void split_ops_init(AccelClass *ac)


