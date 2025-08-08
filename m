Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D63EC87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 21:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukUuQ-0006SN-9T; Fri, 08 Aug 2025 17:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUuD-0006Pz-4D
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:45:46 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukUuB-0003Q3-2o
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 17:45:40 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b78127c5d1so1597400f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 14:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754689535; x=1755294335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8egk7ygOP/LSHiXHwjEv2hRD4LcoOX34X1BpDzf5J6k=;
 b=Q0wSsA+dG/UzILPCTIN7cQk/G2DBY26XtCAcb8/JBpv8m5NhSDYOUJHTgt4GfkK60h
 j2bvYGh2AczbYXb4DUilEUwETb+ENLY8x3UYLHUWM6YoWMlw3lBz99CoPYs8Xlz5uzfY
 oJ/iL3L1g5LbLSWds3/PCntC/Nv8cpNudJPOSCfsjTjUcd+eCygieWYrYFaZwzIyG4j/
 2eD3zWsqHJ8qHwNvnsOzhkAzt4T01bGxD+A+zzoMRJ45Xm2ry98LaLqNQqEbC+ZRJctP
 QwIxww0xHtvOs17dz/zuNNXMvbrYANJIiez87PA01TVUX2CY4nraZOYNmvl7g6cTRcP+
 0zVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754689535; x=1755294335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8egk7ygOP/LSHiXHwjEv2hRD4LcoOX34X1BpDzf5J6k=;
 b=bSClA6bARm5n10deP/SfM8is9eUts4xhRV+UPFMZbm5Xb7v0/ktVrzQFaF8FzmBujl
 Bph/6tqPnZOCPMcc0nJuaaQ85/p1VWKyeeMerrSmUnq//jId4Zo0QyYlEsw9rE+j8/6w
 L/iuLQFPZO9MkNazfouYehOBsiNxETtVpepluThk2eASpHaksDFvce/DI2d5l9JYvxTy
 jbw2ORb9uceT6ptUdOnBbpisAohXHGZy4m4egNd6PC9EUgKFTMjVcUALdsfNXbJlEGpD
 +WJKMRdvLu8dm6hP5t9n1/dyNVlMDfXK//7cfmcjpjfTQkBJ7b6Wz1d3tBRYYXZBdqYS
 CuaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeZk0of9HYgbEHCQwBpLt5gEVAmGqPZiStOtGWsBPOl+Ocy+WQRL7SArE3vKTiWj6d8hxNsJVzyNWw@nongnu.org
X-Gm-Message-State: AOJu0YykrYpkPCh2OkDeaFtR5bi9PafqPg4VtRJt0c63gvmbiIkcQ2Cp
 2XUmi0+Wde+yrfvDaAL4Y7mSGd3n/d9Y2xO73O6psjl9Qke5OoAk7LGXlDJVB+en3TA=
X-Gm-Gg: ASbGncuNIDrofBKH66QGgaQactgSQsqEr1T8EmC7qjQHNXylclQBsTdOobNuY3DYejQ
 Jg+NhK+ZlPPA+oIc3cR7DX75rIqtEG2F31KDjQOWAyvlPLowbFpUg9hOFpX6xAhQ8eeCezAr1EV
 jq3uGORrkVNLVzCZU1WvtYjtBPANRtyo74UyphpzvxECkWTwwRmyLtVKz4vW0WWbT7WATojSsQn
 a/jHyhweYLDIZt35yAlutfMMwyll+7SYF4sUEG7qFNN1Ww27VQAPV06/ecQaGSfWhrE7IKto+e1
 5uohUMU6eI7c2osKa1iLZ2/KKMVnaV+pYuz75I3X5Y+AXbVXelAs4rJbR92eo0l2bA2GPbJYxgl
 WCtljo7Hk4eUyd/IU3skyP6CiAVNV5bBeYrt3J5c3nP5vKWRi/vrr6AbWS/Q6eKs4pg==
X-Google-Smtp-Source: AGHT+IH/0q/IyTLgcsPfN/xLNR5AtT1UhJQpq+3PpkVQfdRNzdZaRpQQ22B2AJVO44kt++7YRgEImA==
X-Received: by 2002:a05:6000:2013:b0:3a4:dfc2:bb60 with SMTP id
 ffacd0b85a97d-3b900b34192mr3838094f8f.26.1754689535094; 
 Fri, 08 Aug 2025 14:45:35 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459e5e99e04sm148330905e9.11.2025.08.08.14.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Aug 2025 14:45:34 -0700 (PDT)
Message-ID: <ef71cc03-53a3-4a9f-8052-eabf528227e4@linaro.org>
Date: Fri, 8 Aug 2025 23:45:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/9] contrib/plugins/uftrace: implement tracing
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, rowan Hart <rowanbhart@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20250808204156.659715-1-pierrick.bouvier@linaro.org>
 <20250808204156.659715-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250808204156.659715-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 8/8/25 22:41, Pierrick Bouvier wrote:
> We implement tracing, following uftrace format.
> Trace is flushed every 32 MB, so file operations don't impact
> performance at runtime.
> 
> A different trace is generated per cpu, and we ensure they have a unique
> name, based on vcpu_index, while keeping room for privilege level coming
> in next commit.
> 
> Uftrace format is not officially documented, but it can be found here:
> https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   contrib/plugins/uftrace.c | 150 +++++++++++++++++++++++++++++++++++++-
>   1 file changed, 149 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/plugins/uftrace.c b/contrib/plugins/uftrace.c
> index bb775916270..830967c215b 100644
> --- a/contrib/plugins/uftrace.c
> +++ b/contrib/plugins/uftrace.c
> @@ -12,6 +12,13 @@
>   #include <qemu-plugin.h>
>   #include <glib.h>
>   #include <stdio.h>
> +#include <sys/stat.h>
> +#include <sys/time.h>
> +#include <time.h>
> +#include <unistd.h>
> +
> +#define MiB     (INT64_C(1) << 20)
> +#define NANOSECONDS_PER_SECOND 1000000000LL

#define TRACE_FLUSH_SIZE (32 * MiB)

#define TRACE_ID_SCALE 100

(and use)

> @@ -44,9 +59,41 @@ typedef struct {
>       struct qemu_plugin_register *reg_fp;
>   } Aarch64Cpu;
>   
> +typedef struct {
> +    uint64_t timestamp;
> +    uint64_t data;
> +} UftraceEntry;
> +
> +typedef enum {
> +    UFTRACE_ENTRY,
> +    UFTRACE_EXIT,
> +    UFTRACE_LOST,
> +    UFTRACE_EVENT

        UFTRACE_EVENT,

(in case more types appear)

> +} UftraceRecordType;


> +static void trace_add_entry(Trace *t, uint64_t timestamp, uint64_t pc,
> +                            size_t depth, UftraceRecordType type)
> +{
> +    /* https://github.com/namhyung/uftrace/blob/v0.18/libmcount/record.c#L909 */
> +    const uint64_t record_magic = 0x5;
> +    uint64_t data = type | record_magic << 3;

        uint64_t data = type | (record_magic << 3);

> +    data += depth << 6;
> +    data += pc << 16;
> +    UftraceEntry e = {.timestamp = timestamp, .data = data};
> +    g_array_append_val(t->t, e);
> +    if (t->t->len * sizeof(UftraceEntry) > 32 * MiB) {
> +        trace_flush(t, true);
> +    }
> +}


>   static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
> @@ -297,6 +432,16 @@ static void vcpu_init(qemu_plugin_id_t id, unsigned int vcpu_index)
>       cpu->ops.init(cpu);
>       cpu->buf = g_byte_array_new();
>   
> +    g_assert(vcpu_index < UINT32_MAX / 100);
> +    /* trace_id is: cpu_number * 100 */
> +    uint32_t trace_id = (vcpu_index + 1) * 100;
> +
> +    g_autoptr(GString) trace_name = g_string_new(NULL);
> +    g_string_append_printf(trace_name, "cpu%u", vcpu_index);

   g_autofree char *trace_name = g_strdup_printf("cpu%u", vcpu_index);

and pass (const?) char * to trace_new().

> +    cpu->trace = trace_new(trace_id, trace_name);
> +    /* create/truncate trace file */
> +    trace_flush(cpu->trace, false);
> +
>       cpu->cs = callstack_new();
>   }

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


