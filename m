Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510CEC87FCF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 23:35:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukt57-0000j2-3e; Sat, 09 Aug 2025 19:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ukt55-0000iL-9o
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:34:31 -0400
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ukt53-0004dm-9t
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 19:34:31 -0400
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7e1d89fcc31so337397185a.1
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 16:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754782467; x=1755387267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=595vqFNt+OWlRGOZf+6J+Rayv0WWXuITmOxKlHTsAfM=;
 b=IbYgapEqenFP4aT16vztAjbgmXecLMaNhiuu69ZtQOLed9mV+5/+0F5nH1FHkEmtoj
 UB2Ydnj2LAEnFhR53L5Cnzkm2BQ48fUv5W+xeaECSWhpkvDznX16AnB821ZDNuCEwyEo
 g9Hngyl9dyYkVvGnyTBE+ty4UwGjJ0TzkcC9hng4405Oa99iK3SPPNd4WOQn5VK9he3W
 vF4IIev2dM05iNru/559uS6v7vZyVyTfC3+YNpVyHXjGgRMURJ7uKJM62SPCBI2ZPlSs
 R2797FVnEi3OKWVqd/bnm2od96ucJTMJ9SVjkZ/PNRFaDIriLtgut7RqX9BjpxfxrUz8
 Wusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754782467; x=1755387267;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=595vqFNt+OWlRGOZf+6J+Rayv0WWXuITmOxKlHTsAfM=;
 b=sUlzeBGueADXxt8AMV9WQ8rHEdjyXQOdGsx4dyxoc0FXXx8SkX35w0A64kSEDm1qiO
 Qwyj5NXViUGuOoLHDQR7R37t4JvCj3TDEOSobEtrO09N8IvvAS59XULHfhIZER/RhpP8
 1sqgYNYInzmjIjMuTE2zGxRewzsGSFjJYwC29ZB8q6c4t9P5a7DGoT5Y3D4K+6iomi00
 hgNRUsCesXSK/uWOP0ku81MoWjjts27DxDflyV3ysi4O8kP7pUR/n3t7D2cUNTiMRxNB
 MK5YK7I40SBlbq7mFxvkjQyngrvOjKFTE56mjLGrl57koNsSY9FGPYQfx5HfDtMN7NIF
 HkTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtZBM7rEEKr6WBh7AI5Br8qep4ieBZVGthauJ/GZE6ZjSBRaLdloJnKSANp1Y76VZRJAtVPhayUi84@nongnu.org
X-Gm-Message-State: AOJu0YzV3O06wnzLJgaJh97OCAstiQecQAHEXlXukMwy6Rx1jBxDuxyf
 u11w13DHJtspG1uKwrDtj+PZ5VKF/TX+l/XIcjseFjg+zZsbTdthXxBAbXIEn09je5Q=
X-Gm-Gg: ASbGnct0lpOuZdQOy3X8oxwlzZRPFQSJz8OhyOtAYiegGyTOQKil393RLqMU1p1ga8r
 My1bb+MDhCM7lSbSlSnGmRq9G/LZRiBmjDB+RdGg4UGzi6yeEiEnVppGly9YQVxgSLF3ZCkkMDq
 aBOkVNYH2goR1jbEwaO52jz+7ubQ74GNWT45UpPDJ0cNVdXgdMU55ICeUaC3CLJq1YTErvaeqmZ
 4Fih3Bu5TuWM1ShZqtHV3P0HQGvhCD8j1Zc4JN3bNyKOl71LL7l/Z42Tj8/45IFp+mxHqnk6b7w
 7eOXN0SCZsKmh0S2xvNEt+yDcr8TUALW2w6vMx3vMh5Ej/6EdzVHpq0mp8xs+U4OeNlwcUPrlHE
 Yh48Nw8pCJtX0/7NX83dK3yksNUYUJUZxdf9zEJcCr9lUEIbz/bH8BFuDIdLWC9L1i7/Niwtqjy
 LiKngrcXh/8Qm5Bsvg
X-Google-Smtp-Source: AGHT+IFwuv7rYE8xDS4SLVPsRWwEn8WOCeYo1f/jH0sMtpKrNO9ogenyrO5sYQxM6zZyaO4lEmxffg==
X-Received: by 2002:a05:620a:a808:b0:7e6:55b8:3cdc with SMTP id
 af79cd13be357-7e82c7a1176mr1050267885a.49.1754782467490; 
 Sat, 09 Aug 2025 16:34:27 -0700 (PDT)
Received: from [10.153.194.227] ([172.58.166.125])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e826870838sm401627085a.31.2025.08.09.16.34.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Aug 2025 16:34:27 -0700 (PDT)
Message-ID: <8c97dcba-0ba7-4a2f-9bfb-7b87872c9675@linaro.org>
Date: Sun, 10 Aug 2025 09:34:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] accel: make all calls to qemu_wait_io_event look the
 same
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, peterx@redhat.com
References: <20250808185905.62776-1-pbonzini@redhat.com>
 <20250808185905.62776-9-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250808185905.62776-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x72a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/9/25 04:59, Paolo Bonzini wrote:
> There is no reason for some accelerators to use qemu_wait_io_event_common
> (which is specifically separated for round robin).  They can also check
> on the first pass through the loop as well directly, without setting
> cpu->exit_request for no particular reason.
> 
> There is also no need to use qatomic_set_mb() because the ordering of
> the communication between I/O and vCPU threads is always the same.
> In the I/O thread:
> 
> (a) store other memory locations that will be checked if cpu->exit_request
>      or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
>      for cpu->exit_request)
> 
> (b) cpu_exit(): store-release cpu->exit_request, or
> (b) cpu_interrupt(): store-release cpu->interrupt_request
> 
>>>> at this point, cpu->halt_cond is broadcast and the BQL released
> 
> (c) do the accelerator-specific kick (e.g. write icount_decr for TCG,
>      pthread_kill for KVM, etc.)
> 
> In the vCPU thread instead the opposite order is respected:
> 
> (c) the accelerator's execution loop exits thanks to the kick
> 
> (b) then the inner execution loop checks cpu->interrupt_request
>      and cpu->exit_request.  If needed cpu->interrupt_request is
>      converted into cpu->exit_request when work is needed outside
>      the execution loop.
> 
> (a) then the other memory locations are checked.  Some may need
>      to be read under the BQL, and the vCPU thread may also take
>      for the vCPU thread can sleep on cpu->halt_cond; but in
>      principle this step is correct even without the BQL.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   accel/dummy-cpus.c                |  2 +-
>   accel/hvf/hvf-accel-ops.c         |  2 +-
>   accel/kvm/kvm-accel-ops.c         |  3 ++-
>   accel/kvm/kvm-all.c               |  2 --
>   accel/tcg/cpu-exec.c              |  1 -
>   accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++----
>   accel/tcg/tcg-accel-ops-rr.c      | 38 ++++++++++++++++---------------
>   accel/tcg/tcg-accel-ops.c         |  2 --
>   system/cpus.c                     |  1 +
>   target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
>   target/i386/nvmm/nvmm-all.c       |  2 --
>   target/i386/whpx/whpx-accel-ops.c |  6 ++---
>   target/i386/whpx/whpx-all.c       |  2 --
>   13 files changed, 31 insertions(+), 43 deletions(-)

I think this is doing two separate things: rearranging the qemu_wait_io_event, and ...


> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 57e35960125..db95e06e768 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3155,7 +3155,6 @@ int kvm_cpu_exec(CPUState *cpu)
>       trace_kvm_cpu_exec();
>   
>       if (kvm_arch_process_async_events(cpu)) {
> -        qatomic_set(&cpu->exit_request, 0);
>           return EXCP_HLT;
>       }
>   
> @@ -3345,7 +3344,6 @@ int kvm_cpu_exec(CPUState *cpu)
>           vm_stop(RUN_STATE_INTERNAL_ERROR);
>       }
>   
> -    qatomic_set(&cpu->exit_request, 0);
>       return ret;
>   }
>   
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index b9da2e3770e..f474ccb37f5 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -871,7 +871,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>        * The corresponding store-release is in cpu_exit.
>        */
>       if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
> -        qatomic_set(&cpu->exit_request, 0);
>           if (cpu->exception_index == -1) {
>               cpu->exception_index = EXCP_INTERRUPT;
>           }
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index f4d5372866a..ad3f29107e1 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -82,8 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
>       ret = cpu_exec(cpu);
>       cpu_exec_end(cpu);
>   
> -    qatomic_set_mb(&cpu->exit_request, 0);
> -
>       return ret;
>   }
>   
> diff --git a/system/cpus.c b/system/cpus.c
> index d2cfa2a9c4e..0cc14eae6a0 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -458,6 +458,7 @@ void qemu_wait_io_event(CPUState *cpu)
>   {
>       bool slept = false;
>   
> +    qatomic_set(&cpu->exit_request, false);
>       while (cpu_thread_is_idle(cpu)) {
>           if (!slept) {
>               slept = true;
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index d2d90f38976..09839d45b92 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -817,8 +817,6 @@ nvmm_vcpu_loop(CPUState *cpu)
>       cpu_exec_end(cpu);
>       bql_lock();
>   
> -    qatomic_set(&cpu->exit_request, false);
> -
>       return ret < 0;
>   }
>   
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 9b07716121a..2e248a0a6d5 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2050,8 +2050,6 @@ static int whpx_vcpu_run(CPUState *cpu)
>           whpx_last_vcpu_stopping(cpu);
>       }
>   
> -    qatomic_set(&cpu->exit_request, false);
> -
>       return ret < 0;
>   }
>   

... sinking the clear of exit_request.

It would be nice to actually unify the run loop that you're manipulating here.  But I 
suppose that can be a follow-up.


r~

