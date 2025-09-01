Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4830CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4eO-0000lZ-3B; Mon, 01 Sep 2025 09:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4eL-0000ip-KE
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:32:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4eB-0002DA-7g
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756733553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IGXr4g4zjhC2rNL9qLBJ2TlRDetCdnv44VyXTWohCJA=;
 b=Kcz9+MPikvNJGXZstqUEHALEqggAInxm5SAEoiw6Ah7Kc5QeFtg2mMwnv6Qx0GpbT5lgl7
 dqu+sKf6WzhzPlAcUkl5Y4zzkd4yN80OapCSGVi0Yu2qZM6MYccgB9MsBI0psG20LN6T2N
 ozlYvHtyyYzmzstPDAJ4Yqv3LNGL5Pc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-R_K2cZaOOEWoYqXpHMzUHw-1; Mon, 01 Sep 2025 09:32:31 -0400
X-MC-Unique: R_K2cZaOOEWoYqXpHMzUHw-1
X-Mimecast-MFC-AGG-ID: R_K2cZaOOEWoYqXpHMzUHw_1756733551
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-70de0bdb600so75185146d6.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733551; x=1757338351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IGXr4g4zjhC2rNL9qLBJ2TlRDetCdnv44VyXTWohCJA=;
 b=s5fhG2a2PWaUYL9gjsd6AjD6pAzEp2U1jp2llYZuhbF1S/o5hhnJ6EQsEA9jIg0fw0
 enSyWqI7+PiLYo0N0SC4lZ7M/zFhhWUiDpy92B6xObhYOTpk1RuV8DNelgrwFpdYVXBh
 ZBJjqC0DYVDhABVHC1nJta3UahuI5Vjn967GudbZVlmv+mCGUCzm9W01pCg9RnoMt5bJ
 8aT+arbk4xYfdylDVsnhnYYcp+2+r4sjAKekdnoNmzOxHDhF/pzcN4iOFRGlswvPyi8s
 3133elwTCtCxpwaby1nfhgn/w2ydUAXlsqDpPJcDvs04A3xvx5EnLd1CkY2S7pJTQtqm
 CeEw==
X-Gm-Message-State: AOJu0YzJyrXwas+XQmf4OhfBuA4ea7mD3jVeut6YAZAGC5R5zSEUwsja
 8VOuJ6FgPfNy3FAH4ALMCrx4HkPE0drO85lUySClQ3zQ6z50QZtRc3LJKOHAlIoig/Y7BxAcyrF
 gE1/z6ROz9Pv9lcJTDiufT7P1tYzEisGh69Iv+4Aq36vYaR0wPQ41rAT4
X-Gm-Gg: ASbGnctE2XwbRfojqulxTilW94NuTWwvKe2pkJZAqtzxjnmOH9DXcV2fMAUXY/C6/Mp
 vKh92ww9o/iPQEnCR4VrgT980RGpvvbDghQVZHOQGwvnEhDBwtFr+nzbTF3fN9tzBbPkpmGWIy2
 CJ/5CSkMMeonIEqItYekF9nqGFYgDkE0/Y9uTg31PKAC8hXKhLvAk6Apb7Kl4EvSXsvP2VdcBPk
 tmQ0R7Cichaa6jwIMrE8c9jyrbzYktxPTjYPkpfYdmpQujACIwyx+UXgupg+0Dp5Ta/1MOz3ZNT
 BamPaMAMhZ75YhXX3Nmn2hVi5h9yuQ==
X-Received: by 2002:a05:6214:1d2c:b0:70d:fe5d:e2f with SMTP id
 6a1803df08f44-70fac86d46fmr92154026d6.39.1756733550586; 
 Mon, 01 Sep 2025 06:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+aqqvRZwDTentvkGzzEA0PHHr73AVy4IDuJLChbaq8TwYs85LlbJuvs3eq27tr15QlfBAjw==
X-Received: by 2002:a05:6214:1d2c:b0:70d:fe5d:e2f with SMTP id
 6a1803df08f44-70fac86d46fmr92153326d6.39.1756733549908; 
 Mon, 01 Sep 2025 06:32:29 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70fb28b62e6sm39348256d6.65.2025.09.01.06.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:32:29 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:32:26 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 17/18] accel: make all calls to qemu_wait_io_event look
 the same
Message-ID: <20250901153226.782ce963@fedora>
In-Reply-To: <20250829153115.1590048-13-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-13-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, 29 Aug 2025 17:31:14 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> There is no reason for some accelerators to use qemu_wait_io_event_common
> (which is separated from qemu_wait_io_event() specifically for round
> robin).  They can also check for events directly on the first pass through
> the loop, instead of setting cpu->exit_request to true.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/dummy-cpus.c                |  2 +-
>  accel/hvf/hvf-accel-ops.c         |  2 +-
>  accel/kvm/kvm-accel-ops.c         |  3 ++-
>  accel/tcg/tcg-accel-ops-mttcg.c   |  7 ++---
>  accel/tcg/tcg-accel-ops-rr.c      | 43 ++++++++++++++-----------------
>  target/i386/nvmm/nvmm-accel-ops.c |  6 ++---
>  target/i386/whpx/whpx-accel-ops.c |  6 ++---
>  7 files changed, 30 insertions(+), 39 deletions(-)
> 
> diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
> index 03cfc0fa01e..1f74c727c42 100644
> --- a/accel/dummy-cpus.c
> +++ b/accel/dummy-cpus.c
> @@ -43,6 +43,7 @@ static void *dummy_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> +        qemu_wait_io_event(cpu);
>          bql_unlock();
>  #ifndef _WIN32
>          do {
> @@ -57,7 +58,6 @@ static void *dummy_cpu_thread_fn(void *arg)
>          qemu_sem_wait(&cpu->sem);
>  #endif
>          bql_lock();
> -        qemu_wait_io_event(cpu);
>      } while (!cpu->unplug);
>  
>      bql_unlock();
> diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
> index d488d6afbac..4ba3e40831f 100644
> --- a/accel/hvf/hvf-accel-ops.c
> +++ b/accel/hvf/hvf-accel-ops.c
> @@ -192,13 +192,13 @@ static void *hvf_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> +        qemu_wait_io_event(cpu);
>          if (cpu_can_run(cpu)) {
>              r = hvf_vcpu_exec(cpu);
>              if (r == EXCP_DEBUG) {
>                  cpu_handle_guest_debug(cpu);
>              }
>          }
> -        qemu_wait_io_event(cpu);
>      } while (!cpu->unplug || cpu_can_run(cpu));
>  
>      hvf_vcpu_destroy(cpu);
> diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
> index b709187c7d7..80f0141a8a6 100644
> --- a/accel/kvm/kvm-accel-ops.c
> +++ b/accel/kvm/kvm-accel-ops.c
> @@ -47,13 +47,14 @@ static void *kvm_vcpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> +        qemu_wait_io_event(cpu);
> +
>          if (cpu_can_run(cpu)) {
>              r = kvm_cpu_exec(cpu);
>              if (r == EXCP_DEBUG) {
>                  cpu_handle_guest_debug(cpu);
>              }
>          }
> -        qemu_wait_io_event(cpu);
>      } while (!cpu->unplug || cpu_can_run(cpu));
>  
>      kvm_destroy_vcpu(cpu);
> diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> index 1148ebcaae5..04012900a30 100644
> --- a/accel/tcg/tcg-accel-ops-mttcg.c
> +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> @@ -84,10 +84,9 @@ static void *mttcg_cpu_thread_fn(void *arg)
>      cpu_thread_signal_created(cpu);
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
> -    /* process any pending work */
> -    qatomic_set(&cpu->exit_request, true);
> -
>      do {
> +        qemu_wait_io_event(cpu);
> +
>          if (cpu_can_run(cpu)) {
>              int r;
>              bql_unlock();
> @@ -112,8 +111,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
>                  break;
>              }
>          }
> -
> -        qemu_wait_io_event(cpu);
>      } while (!cpu->unplug || cpu_can_run(cpu));
>  
>      tcg_cpu_destroy(cpu);
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index e9d291dc391..28897288db7 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -211,13 +211,30 @@ static void *rr_cpu_thread_fn(void *arg)
>  
>      cpu = first_cpu;
>  
> -    /* process any pending work */
> -    qatomic_set(&cpu->exit_request, true);
> -
>      while (1) {
>          /* Only used for icount_enabled() */
>          int64_t cpu_budget = 0;
>  
> +        if (cpu) {
> +            /*
> +             * This could even reset exit_request for all CPUs, but in practice
> +             * races between CPU exits and changes to "cpu" are so rare that
> +             * there's no advantage in doing so.
> +             */
> +            qatomic_set(&cpu->exit_request, false);
> +        }
> +
> +        if (icount_enabled() && all_cpu_threads_idle()) {
> +            /*
> +             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
> +             * in the main_loop, wake it up in order to start the warp timer.
> +             */
> +            qemu_notify_event();
> +        }
> +
> +        rr_wait_io_event();
> +        rr_deal_with_unplugged_cpus();
> +
>          bql_unlock();
>          replay_mutex_lock();
>          bql_lock();
> @@ -285,26 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
>  
>          /* Does not need a memory barrier because a spurious wakeup is okay.  */
>          qatomic_set(&rr_current_cpu, NULL);
> -
> -        if (cpu) {
> -            /*
> -             * This could even reset exit_request for all CPUs, but in practice
> -             * races between CPU exits and changes to "cpu" are so rare that
> -             * there's no advantage in doing so.
> -             */
> -            qatomic_set(&cpu->exit_request, false);
> -        }
> -
> -        if (icount_enabled() && all_cpu_threads_idle()) {
> -            /*
> -             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
> -             * in the main_loop, wake it up in order to start the warp timer.
> -             */
> -            qemu_notify_event();
> -        }
> -
> -        rr_wait_io_event();
> -        rr_deal_with_unplugged_cpus();
>      }
>  
>      g_assert_not_reached();
> diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
> index 86869f133e9..f51244740d8 100644
> --- a/target/i386/nvmm/nvmm-accel-ops.c
> +++ b/target/i386/nvmm/nvmm-accel-ops.c
> @@ -42,16 +42,14 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> +        qemu_wait_io_event(cpu);
> +
>          if (cpu_can_run(cpu)) {
>              r = nvmm_vcpu_exec(cpu);
>              if (r == EXCP_DEBUG) {
>                  cpu_handle_guest_debug(cpu);
>              }
>          }
> -        while (cpu_thread_is_idle(cpu)) {
> -            qemu_cond_wait_bql(cpu->halt_cond);
> -        }
> -        qemu_wait_io_event_common(cpu);
>      } while (!cpu->unplug || cpu_can_run(cpu));
>  
>      nvmm_destroy_vcpu(cpu);
> diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
> index da58805b1a6..611eeedeef7 100644
> --- a/target/i386/whpx/whpx-accel-ops.c
> +++ b/target/i386/whpx/whpx-accel-ops.c
> @@ -42,16 +42,14 @@ static void *whpx_cpu_thread_fn(void *arg)
>      qemu_guest_random_seed_thread_part2(cpu->random_seed);
>  
>      do {
> +        qemu_wait_io_event(cpu);
> +
>          if (cpu_can_run(cpu)) {
>              r = whpx_vcpu_exec(cpu);
>              if (r == EXCP_DEBUG) {
>                  cpu_handle_guest_debug(cpu);
>              }
>          }
> -        while (cpu_thread_is_idle(cpu)) {
> -            qemu_cond_wait_bql(cpu->halt_cond);
> -        }
> -        qemu_wait_io_event_common(cpu);
>      } while (!cpu->unplug || cpu_can_run(cpu));
>  
>      whpx_destroy_vcpu(cpu);


