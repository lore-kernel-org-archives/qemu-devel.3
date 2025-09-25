Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4061CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1bVs-0007zG-HR; Wed, 24 Sep 2025 22:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1bVr-0007xR-6F
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:15:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1bVm-0000JK-Fe
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:15:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46b7580f09eso2341905e9.2
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 19:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758766503; x=1759371303; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GSX2RQj53sDwDWlCSEQC312T3M0CiEdNaFF3hDZWqX0=;
 b=LerkL46PO7Kd46zVUD5W5RePf8oTPrqCt4it4nuu2NrT5c5DoiQMn2isBe9Yk5t+Jz
 d6K7ePcG0ABy1tmRy/ozWzrMD0rIwF+TLs8uLCpf1TGUFWIuDAEZCYxh0Fzvj7Srt3JF
 8Lu1G/wwJXLjBLoGmPY7ZI1xN9R7oMhjYnXG/lxUqgR0wX5Z3L9jzGsXADLy7iqZvOar
 3JblHMS6IGMBYQKNicB4dv2Xxlmzzru+euCzRPZNZta9JeIy0yvbzGcaGfOfk414SpTE
 17Pxl0+PFkz/WXlFX/xVdFRgKP0RpUgWFv9ifa5i3BbAXSOy7lE4rxU5FqDJCTwZSQd9
 8JBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758766503; x=1759371303;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GSX2RQj53sDwDWlCSEQC312T3M0CiEdNaFF3hDZWqX0=;
 b=VyRUbOESB1enF0RnNMPSyqLV3rdZ65ww8lKlrRB8abjLMAwCWwfNNqjy5JBVfyQrIJ
 DaU+57Y+L68f7Afx5+InVin1coducfoRoLELsoDp53013gEAAkDDL7sq9lDgEVwNN7fk
 P3oAYRf9oO1yhj2meEUPtQQ9pWW11pJx8sG+MG632ERaOXNw8gx/Fb0mCUJc1ikyqQZk
 TZMr8cPDjKhKpfmVxM164uzQ8QsO2+oaaKJ4eb+Wf7gqYqlYg1hZy8W7B7TaqtOUiYz5
 Dbcy1JwmKhEAc9fdZubOBDynv/pRVHi5/x8CdQFJVZ/27l/fTckFhM4LfpNwlCVdlGKX
 L/BQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2cg/hkVM/mccSx4NTOL69f0gPAHBxt49nY9sGbp+qwsNXz8vnO8DLtHRXrj0Mk/P3tuJmNNe+0m2W@nongnu.org
X-Gm-Message-State: AOJu0Yw75KH71hYkQdCePTaNxAQWa1ngOMBpNRO8jQf0VZ/8flZs9wGJ
 Fhd/UbtnypEU7dFgIpUN+J75I1ae0McrwbK4mkSiTBZm5SThRU5EU1ctMnMkekV9eiY=
X-Gm-Gg: ASbGncvFb7R/+H4kImCK6eOSqai+PvN6y772Zr40bavB1zV4k+NAPv09VAqhhRJeO3+
 ZlodhnsrcWu3TvzYhmJ0fqfGqbglWCJ3OAXEcs/yd9Z3yNgBER25kHCWg3e4eJFzaTCc4kPI/Fa
 4+5oK7pyyId+dCEkTAgTZI8YM5O4LQdFGn7jK/6618SnYw7cuQJKqgBDmwGDID+ooSlLraQaa+W
 n0MvcbYSMAklXz2aJUr+6LtkxT38VEZVlSVc+k0KLQ5vDRORL+5GKeCDsp4DVxlSFrUhJhyIO0B
 DgaM19dwWbMe428WMqMOKpFMJMGvEiBGOp/DjOmhMJtr1nUDOS80eHRaho5Ks5ru+HrITuGZqkf
 cQ2+hvJP3PsniXhIQ1lwYkqBG+fcyKWV4KPi8xZGfhGyBO8VYLkibG9OHSJ0+bQ8OKw==
X-Google-Smtp-Source: AGHT+IFMhRseuJ0ywTNENFnXR+XEBPaMQGW2fr88TGHdxxwAtwEbR2QwgtJm+xQ90DSuFpqYuwyjgQ==
X-Received: by 2002:a05:600c:1d28:b0:46e:2c22:3590 with SMTP id
 5b1f17b1804b1-46e329f7db7mr14579795e9.22.1758766502833; 
 Wed, 24 Sep 2025 19:15:02 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2ff6sm788698f8f.56.2025.09.24.19.15.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Sep 2025 19:15:02 -0700 (PDT)
Message-ID: <3bfa2dd1-08eb-4037-90b7-db706cce8b98@linaro.org>
Date: Thu, 25 Sep 2025 04:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] accel/tcg: Split out
 tb_flush__exclusive_or_serial
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250923215425.3685950-1-richard.henderson@linaro.org>
 <20250923215425.3685950-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923215425.3685950-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 23/9/25 23:54, Richard Henderson wrote:
> Expose a routine to be called when no cpus are running.
> Simplify the do_tb_flush run_on_cpu callback, because
> that is explicitly called with start_exclusive; there
> is no need for the mmap_lock as well.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h | 15 +++++++++++++++
>   accel/tcg/tb-maint.c    | 39 +++++++++++++++++++++++++--------------
>   2 files changed, 40 insertions(+), 14 deletions(-)
> 
> diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
> index 142c240d94..090ffc8818 100644
> --- a/include/exec/tb-flush.h
> +++ b/include/exec/tb-flush.h
> @@ -8,6 +8,21 @@
>   #ifndef _TB_FLUSH_H_
>   #define _TB_FLUSH_H_
>   
> +/**
> + * tb_flush__exclusive_or_serial()
> + *
> + * Used to flush all the translation blocks in the system.  Mostly this is
> + * used to empty the code generation buffer after it is full.  Sometimes it
> + * is used when it is simpler to flush everything than work out which
> + * individual translations are now invalid.
> + *
> + * Must be called from an exclusive or serial context, e.g. start_exclusive,
> + * vm_stop, or when there is only one vcpu.  Note that start_exclusive cannot
> + * be called from within the cpu run loop, so this cannot be called from
> + * within target code.
> + */
> +void tb_flush__exclusive_or_serial(void);
> +
>   /**
>    * tb_flush() - flush all translation blocks
>    * @cs: CPUState (must be valid, but treated as anonymous pointer)
> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 0048316f99..7be9a1c4de 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -36,6 +36,9 @@
>   #include "internal-common.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "user/page-protection.h"
> +#define runstate_is_running()  true
> +#else
> +#include "system/runstate.h"
>   #endif
>   
>   
> @@ -88,7 +91,10 @@ static IntervalTreeRoot tb_root;
>   
>   static void tb_remove_all(void)
>   {
> -    assert_memory_lock();
> +    /*
> +     * Only called from tb_flush__exclusive_or_serial, where we have already
> +     * asserted that we're in an exclusive state.
> +     */
>       memset(&tb_root, 0, sizeof(tb_root));
>   }
>   
> @@ -756,17 +762,19 @@ static void tb_remove(TranslationBlock *tb)
>   }
>   #endif /* CONFIG_USER_ONLY */
>   
> -/* flush all the translation blocks */
> -static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
> +/*
> + * Flush all the translation blocks.
> + * Must be called from a context in which no cpus are running,
> + * e.g. start_exclusive() or vm_stop().
> + */
> +void tb_flush__exclusive_or_serial(void)
>   {
> -    bool did_flush = false;
> +    CPUState *cpu;
>   
> -    mmap_lock();
> -    /* If it is already been done on request of another CPU, just retry. */
> -    if (tb_ctx.tb_flush_count != tb_flush_count.host_int) {
> -        goto done;
> -    }
> -    did_flush = true;

Since reworking, here I'd add a tracing event to help debugging:

        trace_tb_flush();

> +    assert(tcg_enabled());
> +    /* Note that cpu_in_serial_context checks cpu_in_exclusive_context. */
> +    assert(!runstate_is_running() ||
> +           (current_cpu && cpu_in_serial_context(current_cpu)));
>   
>       CPU_FOREACH(cpu) {
>           tcg_flush_jmp_cache(cpu);
> @@ -778,11 +786,14 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
>       tcg_region_reset_all();
>       /* XXX: flush processor icache at this point if cache flush is expensive */
>       qatomic_inc(&tb_ctx.tb_flush_count);
> +    qemu_plugin_flush_cb();
> +}
>   
> -done:
> -    mmap_unlock();
> -    if (did_flush) {
> -        qemu_plugin_flush_cb();
> +static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
> +{
> +    /* If it is already been done on request of another CPU, just retry. */
> +    if (tb_ctx.tb_flush_count == tb_flush_count.host_int) {
> +        tb_flush__exclusive_or_serial();
>       }
>   }
>   


