Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF909C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:46:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfnH-0005cP-4Q; Fri, 04 Jul 2025 08:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXfnD-0005br-Ie
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:45:28 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXfnB-0000uk-FX
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:45:27 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-451d3f72391so8793755e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751633123; x=1752237923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FnMGD+/LhWsHWpmeGmqGcY2jHrC8WXhb8Q1aplMffak=;
 b=ca3qqQJohAdq1is3GioMXhhqhSKywGE8w6XL/RCzQTn6/ZUosUTkkcpamY9cCrFSUZ
 aw8W9FYMRUsCMJYbpD6RM+BhyOEbxopU2r8nPrVAduJ9kwOYunTqjwu919u7naCtESdw
 9CsU05IIPBJXRXXsb5ZRvUdHSd2KrNJgBJ1ZrwuFZ/odLjFmTUCMxB+7xFkyBcOtdTdc
 YtStbpAxE2GC84ZfvRUXnZC6QWPM/7xKnffhS+5tx7qL4NYmLg8Rwc7sMYmhG2V3hSjN
 28+JV0sLCWludaF83D8IjPMqrbH94zpI6mZzfjw4NGL4VyMtUE5zqK4X0Se/WhWcPSfy
 Ma9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751633123; x=1752237923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FnMGD+/LhWsHWpmeGmqGcY2jHrC8WXhb8Q1aplMffak=;
 b=qZ9TOhgRlSIBZKHPHE5D1JSsBckU5KhGAp5vyAhfMtj/sEHojQKXaFajHUSCgkzqfO
 acOT7zZJtouXxJFh9pVQeCE/kfLYB2EPH6Em1easdZ7UcS2CkYvzYrLmt3BX5ZrtrJRw
 Bb7WBRPquYYDOzbdADdWjn04+bRcVz8UyXALrX+Q/mNNEEpu16oyMH6mGWhuQTsFC1He
 xy8AywedWApsdP64svKn7W4OqTasEYvHGVLGOFCVUXlhFb48hX/CBxYbEsozNGiRpWph
 7i7LXiMWRIGCxVx32TpqDRkPBuwdDe4EIsS9XUGXvs+ZrApOMnm6uVJiVZeYh4fySyc4
 cdIg==
X-Gm-Message-State: AOJu0Yzr4EIjvoCxXihRXMuOQnGedciUBL5ICGbJ8gfzPgfTE824WoUl
 kiIOBG+e6RPbWFqKG8FL0l/jyrQW0te7vM0mFODYcG/W2K/FpMkCYTjKcNeS9F80baU=
X-Gm-Gg: ASbGnct/7e0lI9zd+yN5wvB105IMaeuItrFw2RW771z+sChdtP9g4nIOrIoTA+8gG+p
 mlsBO+eY7xo9XazGnkvzG6UZoHRQvFFjRTXF7NqSkRXdgGkdRqm0gRgvBZmyWnZxnQM7eucgW45
 Z97CdslHhQl+OEFnfU/W9/i4GqSEU/oHpZNtnf6kpoBmYzQnMxpQ2svxaM0neszIGiWjMXlDOiY
 FODQrZKh/oMAJuZqa7Lxy6QryQ4iJgLB+/ls4uvMtQ1pvGQ4rWEZthLKm1C+ICaZYu2RggYQsk/
 Fldm8T24jwVVr/HNis9q+ZOnvFj0yuBGINu9LVH2xtJjRx4TunuKFB83hs9M7pA3wBAR1Eob+eg
 sIaN0qHSubNW51vy/zHmHAHMtH3sAXuanQB4=
X-Google-Smtp-Source: AGHT+IGMMv7mBsKL67bFXEgjQnXKSpyLzqPHL1OpeaSlvBAY08/kdR4wErGSuHkDTnflmrPFyi0fRQ==
X-Received: by 2002:a05:600c:4ed1:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-454b30d90e9mr22590915e9.20.1751633122819; 
 Fri, 04 Jul 2025 05:45:22 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9bced0esm54634965e9.22.2025.07.04.05.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Jul 2025 05:45:22 -0700 (PDT)
Message-ID: <07c26674-f705-487b-93f1-d98884c279f5@linaro.org>
Date: Fri, 4 Jul 2025 14:45:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 27/65] accel/hvf: Implement get_vcpu_stats()
To: Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250702185332.43650-1-philmd@linaro.org>
 <20250702185332.43650-28-philmd@linaro.org>
 <AAAC3128-4BA8-4085-920A-9512786CA343@ynddal.dk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <AAAC3128-4BA8-4085-920A-9512786CA343@ynddal.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 4/7/25 14:05, Mads Ynddal wrote:
> 
>> On 2 Jul 2025, at 20.52, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>> accel/hvf/hvf-accel-ops.c | 19 +++++++++++++++++++
>> 1 file changed, 19 insertions(+)
>>
>> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
>> index e7f40888c26..c07ebf8a652 100644
>> --- a/accel/hvf/hvf-accel-ops.c
>> +++ b/accel/hvf/hvf-accel-ops.c
>> @@ -358,6 +358,12 @@ static inline int hvf_gdbstub_sstep_flags(AccelState *as)
>>      return SSTEP_ENABLE | SSTEP_NOIRQ;
>> }
>>
>> +static void do_hvf_get_vcpu_exec_time(CPUState *cpu, run_on_cpu_data arg)
>> +{
>> +    int r = hv_vcpu_get_exec_time(cpu->accel->fd, arg.host_ptr);
>> +    assert_hvf_ok(r);
>> +}
>> +
>> static void hvf_accel_class_init(ObjectClass *oc, const void *data)
>> {
>>      AccelClass *ac = ACCEL_CLASS(oc);
>> @@ -583,6 +589,16 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
>>      }
>> }
>>
>> +static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
>> +{
>> +    uint64_t time_us; /* units of mach_absolute_time() */
>> +
>> +    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_us));
>> +
>> +    g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
>> +                                time_us / 1000000, (time_us % 1000000) / 1000);
>> +}
>> +
>> static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
>> {
>>      AccelOpsClass *ops = ACCEL_OPS_CLASS(oc);
>> @@ -601,7 +617,10 @@ static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
>>      ops->remove_breakpoint = hvf_remove_breakpoint;
>>      ops->remove_all_breakpoints = hvf_remove_all_breakpoints;
>>      ops->update_guest_debug = hvf_update_guest_debug;
>> +
>> +    ops->get_vcpu_stats = hvf_get_vcpu_stats;
>> };
>> +
>> static const TypeInfo hvf_accel_ops_type = {
>>      .name = ACCEL_OPS_NAME("hvf"),
>>
>> -- 
>> 2.49.0
>>
> 
> This doesn't return the right time for me (M3 Pro). If you tested on Intel, it might have a different time scale for mach units?
> 
> This is what I needed to change to make it work. Tested with 'yes > /dev/null' in the guest and 'info accel' in monitor.
> 
> 
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index cf623a1ea4..5b3bcd553d 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -59,6 +59,7 @@
>   #include "system/hvf.h"
>   #include "system/hvf_int.h"
>   #include "hw/core/cpu.h"
> +#include <mach/mach_time.h>
> 
>   HVFState *hvf_state;
> 
> @@ -340,12 +341,16 @@ static void hvf_remove_all_breakpoints(CPUState *cpu)
> 
>   static void hvf_get_vcpu_stats(CPUState *cpu, GString *buf)
>   {
> -    uint64_t time_us; /* units of mach_absolute_time() */
> +    uint64_t time_mach; /* units of mach_absolute_time() */
> 
> -    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_us));
> +    run_on_cpu(cpu, do_hvf_get_vcpu_exec_time, RUN_ON_CPU_HOST_PTR(&time_mach));
> +
> +    mach_timebase_info_data_t timebase;
> +    mach_timebase_info(&timebase);
> +    uint64_t time_ns = time_mach * timebase.numer / timebase.denom;

Great, thank you! That works for me :)

> 
>       g_string_append_printf(buf, "HVF cumulative execution time: %llu.%.3llus\n",
> -                                time_us / 1000000, (time_us % 1000000) / 1000);
> +                                time_ns / 1000000000, (time_ns % 1000000000) / 1000000);
>   }
> 
>   static void hvf_accel_ops_class_init(ObjectClass *oc, const void *data)
> 
> 


