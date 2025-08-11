Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A113CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 16:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulVII-0006ni-Es; Mon, 11 Aug 2025 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulVIG-0006lT-77
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:22:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulVI7-0001wh-Th
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 12:22:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754929346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d3rRwfWApgfsi89IX9vg0MYDevy2sO+VDOyLUbAlH1M=;
 b=hSz4cS99oQCI4OWxekjZai9RLT5QAODNyynuS6rZ/Zh57ATemyWHIpaEvgNaalc1XpSvl8
 WMayS1DWzgOdqIMr0tq7ZLF4Q334e9R/xFbSqTOXawuXMDhsw1dsAhenwowYN6IEr7Rpbh
 K92NeT5hauoQia6kWs279Ji4z70EKw8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-Pgh9WXiuO8W_NDDF9N6k8g-1; Mon, 11 Aug 2025 12:22:25 -0400
X-MC-Unique: Pgh9WXiuO8W_NDDF9N6k8g-1
X-Mimecast-MFC-AGG-ID: Pgh9WXiuO8W_NDDF9N6k8g_1754929345
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7e69d69691fso455497885a.3
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 09:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754929345; x=1755534145;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3rRwfWApgfsi89IX9vg0MYDevy2sO+VDOyLUbAlH1M=;
 b=osf+g6jx6kUrSjNPcTTLb7RA+K99k6zChzrQfJN0IwogDEPaO+vz1RiwDP/5DagyEE
 RCwf/zZ1wHfbYynP9Qcee9p73ojKVse5c8iRqKpkgszbcQEqnaDaVeNcwEK3JX07XcXv
 NptgYChhF9kEI7eB1AaR4W40Z5QWu19Y2nYJJbow1Hmh2bR4T8IF7LgDvrWObhV40/Pg
 cGeKQenC/TRDovPv+OyMj+PaoOznyokxLou2nunvku+0NLg/HPDmUwhcyOHjGdeCbW1L
 qdsiefCE51fT4OcbIT9bI7NtafUtlbGu7JBo5bdUUJk68Nzapp/FS9CYg0UeYvoJc60g
 iwjw==
X-Gm-Message-State: AOJu0YwGyWZBJJtWVjZqRRjIX537MXlL6MVSU5rGEmE0xXh5qGC/8Ame
 ePkbrMYRjPq6qmvU1ZEywVeK+JKVS3hcwXRE3DIgVILg/Da6hDGIgRJsw5ZzDactbuekZq40u5R
 K1MWB1tfeoGB6CvpmQM8fuZzdTyU0RHFpdBo5si9uQZFSaHAobqbobWdE
X-Gm-Gg: ASbGnctcsGGJMGUR3vl4SPDGFcqtxcq1wefs1765r21CaVGG9t0GqXSlOi/IwSeeAXo
 BNixzHxmYekpB8A0x683zB7zr79hBE24mwGd6d1370CY61O9MdJhL/vuE8Gv2XPEvalxeHLUxlC
 42rWo0REvGooL+9UvYjs9GRQBRXpYdv7cjiUOsh0TktA/VMeEIJX+X8RKbeFc1xRtvL+FJAGBNt
 O6I4hyfED1UKe8NnhGC65q25D29z8b6RnE0AemLubZKyqPjcf8vKn52IepRaFzO3gM78RQFFEb9
 InJ3GIrC3hFAcCAFKXvRf8uwxB8iwJ6Z
X-Received: by 2002:a05:620a:7209:b0:7e3:397f:4752 with SMTP id
 af79cd13be357-7e82c639236mr1786386985a.5.1754929344519; 
 Mon, 11 Aug 2025 09:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF767jFM8zZYRtQnVHpWz+/9BDj3SrPUMOVMzvMdNEzYq82woDj39EMqAu7tg8GVeHM3sARYQ==
X-Received: by 2002:a05:620a:7209:b0:7e3:397f:4752 with SMTP id
 af79cd13be357-7e82c639236mr1786362385a.5.1754929341603; 
 Mon, 11 Aug 2025 09:22:21 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e84a217627sm243713285a.32.2025.08.11.09.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 09:22:20 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:22:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com
Subject: Re: [PATCH v3 08/10] kvm: i386: irqchip: take BQL only if there is
 an interrupt
Message-ID: <aJoYr0mow9ungtq-@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-9-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250808120137.2208800-9-imammedo@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 08, 2025 at 02:01:35PM +0200, Igor Mammedov wrote:
> when kernel-irqchip=split is used, QEMU still hits BQL
> contention issue when reading ACPI PM/HPET timers
> (despite of timer[s] access being lock-less).
> 
> So Windows with more than 255 cpus is still not able to
> boot (since it requires iommu -> split irqchip).
> 
> Problematic path is in kvm_arch_pre_run() where BQL is taken
> unconditionally when split irqchip is in use.
> 
> There are a few parts that BQL protects there:
>   1. interrupt check and injecting
> 
>     however we do not take BQL when checking for pending
>     interrupt (even within the same function), so the patch
>     takes the same approach for cpu->interrupt_request checks
>     and takes BQL only if there is a job to do.
> 
>   2. request_interrupt_window access
>       CPUState::kvm_run::request_interrupt_window doesn't need BQL
>       as it's accessed by its own vCPU thread.
> 
>   3. cr8/cpu_get_apic_tpr access
>       the same (as #2) applies to CPUState::kvm_run::cr8,
>       and APIC registers are also cached/synced (get/put) within
>       the vCPU thread it belongs to.
> 
> Taking BQL only when is necessary, eleminates BQL bottleneck on
> IO/MMIO only exit path, improoving latency by 80% on HPET micro
> benchmark.
> 
> This lets Windows to boot succesfully (in case hv-time isn't used)
> when more than 255 vCPUs are in use.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v3:
>   * drop net needed pair of () in cpu->interrupt_request & CPU_INTERRUPT_HARD
>     check
>   * Paolo Bonzini <pbonzini@redhat.com>
>      * don't take BQL when setting exit_request, use qatomic_set() instead
>      * after above simplification take/release BQL unconditionally
>      * drop smp_mb() after run->cr8/run->request_interrupt_window update
> ---
>  target/i386/kvm/kvm.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a7b5c8f81b..306430a052 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5478,9 +5478,6 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>          }
>      }
>  
> -    if (!kvm_pic_in_kernel()) {
> -        bql_lock();
> -    }
>  
>      /* Force the VCPU out of its inner loop to process any INIT requests
>       * or (for userspace APIC, but it is cheap to combine the checks here)
> @@ -5489,10 +5486,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>      if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_INIT) &&
>              !(env->hflags & HF_SMM_MASK)) {
> -            cpu->exit_request = 1;
> +            qatomic_set(&cpu->exit_request, 1);
>          }
>          if (cpu_test_interrupt(cpu, CPU_INTERRUPT_TPR)) {
> -            cpu->exit_request = 1;
> +            qatomic_set(&cpu->exit_request, 1);

I still see plenty of cases where exit_request will be updated without
qatomic_set().. There's even one in kvm.c (kvm_arch_process_async_events)
which is the same file.

Maybe it would make more sense to move these two changes separately, e.g. a
single patch changing tree-wide exit_request setters to use qatomic_set()?

But not that it's a huge deal..

Reviewed-by: Peter Xu <peterx@redhat.com>

>          }
>      }
>  
> @@ -5503,6 +5500,8 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>              (env->eflags & IF_MASK)) {
>              int irq;
>  
> +            bql_lock();
> +
>              cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
>              irq = cpu_get_pic_interrupt(env);
>              if (irq >= 0) {
> @@ -5517,6 +5516,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>                              strerror(-ret));
>                  }
>              }
> +            bql_unlock();
>          }
>  
>          /* If we have an interrupt but the guest is not ready to receive an
> @@ -5531,8 +5531,6 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>  
>          DPRINTF("setting tpr\n");
>          run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
> -
> -        bql_unlock();
>      }
>  }
>  
> -- 
> 2.47.1
> 

-- 
Peter Xu


