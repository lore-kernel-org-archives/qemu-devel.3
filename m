Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FBECA0FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4dy-0000R7-K1; Mon, 01 Sep 2025 09:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4dp-0000HR-M0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:32:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ut4dn-0002As-Dv
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756733527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4mbE4lzyj+ycGtdguQJb73hLphXy96gKVibwWLC15k=;
 b=ix/smrh6Om8nHVsEYKfQoqK3yaJamGY4xDbhxwXS6ZvY9GxR0C60IXr8Zw/dhXKqirIE++
 mhl+5RUI2WPtmJPfi/sTpE1oKzRsoTljDEgBXMg6EKThUvETiXJyewdsFNRYkSmSY3RzUm
 p79JPwyxPyHqA1OaLUDGRoWRliJo+nQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-obYZdpOIO_G9jR4RHkJU9w-1; Mon, 01 Sep 2025 09:32:06 -0400
X-MC-Unique: obYZdpOIO_G9jR4RHkJU9w-1
X-Mimecast-MFC-AGG-ID: obYZdpOIO_G9jR4RHkJU9w_1756733526
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4b3200a05dfso33464461cf.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:32:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733526; x=1757338326;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q4mbE4lzyj+ycGtdguQJb73hLphXy96gKVibwWLC15k=;
 b=TFkO3JVO/+hya9bXBHvmNaRJLjRkX4Utvs8gxFQGg6yx5jKoOFA2F6D3UkGpBrfBuc
 hbyEJjTFWSNei9rD+0PNpW/N0ZJopC32nF8fGL8Rv/370+jP3WKjJRqsHH1Mpqni5Xyo
 aMxbVw0Srd1PcHwvBXuV5/UoSjTVu839Mg4xzYmi/M+hCdWgVKMq9FjMHr97a5mnWZXr
 /Y6L/3OWZl1BhK/Fw4f/TYmJfgnbJg/N7VVrrm7627Hl3xN+wWO+OWAscm8wkRyjt6vy
 BIKkizwZrBIC5UcpR6AP2ENuR6+9dXDlx0TjokX6c4QamCHtz8jyj08G21AzG4VE+uJJ
 NWvg==
X-Gm-Message-State: AOJu0Yyjx935NaPEsYc46urE6O6VFur3fdfsLivtuAj6BkbvDeHETIsi
 y9xJjX+tt2M6/DPInHUhB+zueqsyIHcy41wNM+05dXwjhlU57+BYBIFArQVcIUmX9EGL221pyeK
 nyn7foM5ZDnLI3HyyU8HvdUmsh728eppVrbX3CdgOTzjIgq1F633S7XeJXQ9PpVP+
X-Gm-Gg: ASbGncuftK2asX1tL9SKbFZHNGOqYKxr/hE5cpcO8JAiUcmxAFyp8QWKyLJlwBTxgGz
 zZwokjZFK4bUIPKM9Z85YoC6ZzUDce8r34q9H5d5DofjcgwqioYVts7gu/CAC0ieJv9Lql6/Ren
 AGLD1szRUGaTcDBeDOGve2CSCq/hMQXIHC/Jd/g86oUwGJaXzbu+1S2UN1QCRMUH8Q8p8xLd2om
 N8HvO33kS5fKls+J7lqARZGg9qfp6NAvZdSgxjkckCkr+YqcAWoHnrpLueF0UAT4EBPZRFObJPK
 p8u8GFV9sjxOAIl5vbRvqbiW4OniAQ==
X-Received: by 2002:a05:622a:592:b0:4b0:7db9:92d7 with SMTP id
 d75a77b69052e-4b31b85d8f7mr101921261cf.2.1756733525300; 
 Mon, 01 Sep 2025 06:32:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfMI6t/gLNfVpwMT8gIFQ2FxCZR92T5gyp/JHEEPtklYY/tboqFtDFwcPLruQbYaS1Hm1ykg==
X-Received: by 2002:a05:622a:592:b0:4b0:7db9:92d7 with SMTP id
 d75a77b69052e-4b31b85d8f7mr101920591cf.2.1756733524687; 
 Mon, 01 Sep 2025 06:32:04 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-801ef39cbd4sm243482185a.34.2025.09.01.06.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 06:32:04 -0700 (PDT)
Date: Mon, 1 Sep 2025 15:32:02 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, richard.henderson@linaro.org
Subject: Re: [PATCH 16/18] cpus: clear exit_request in qemu_wait_io_event
Message-ID: <20250901153202.28f869df@fedora>
In-Reply-To: <20250829153115.1590048-12-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
 <20250829153115.1590048-12-pbonzini@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 29 Aug 2025 17:31:13 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Make the code common to all accelerators: after seeing cpu->exit_request
> set to true, accelerator code needs to reach qemu_wait_io_event_common().
> 
> So for the common cases where they use qemu_wait_io_event(), go ahead and
> clear it in there.  Note that the cheap qatomic_set() is enough because
> at this point the thread has taken the BQL; qatomic_set_mb() is not needed.
> In particular, this is the ordering of the communication between
> I/O and vCPU threads is always the same.
> 
> In the I/O thread:
> 
> (a) store other memory locations that will be checked if cpu->exit_request
>     or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
>     for cpu->exit_request)
> 
> (b) cpu_exit(): store-release cpu->exit_request, or
> (b) cpu_interrupt(): store-release cpu->interrupt_request
> 
> >>> at this point, cpu->halt_cond is broadcast and the BQL released  
> 
> (c) do the accelerator-specific kick (e.g. write icount_decr for TCG,
>     pthread_kill for KVM, etc.)
> 
> In the vCPU thread instead the opposite order is respected:
> 
> (c) the accelerator's execution loop exits thanks to the kick
> 
> (b) then the inner execution loop checks cpu->interrupt_request
>     and cpu->exit_request.  If needed cpu->interrupt_request is
>     converted into cpu->exit_request when work is needed outside
>     the execution loop.
> 
> (a) then the other memory locations are checked.  Some may need to
>     be read under the BQL, but the vCPU thread may also take other
>     locks (e.g. for queued work items) or none at all.
> 
> qatomic_set_mb() would only be needed if the halt sleep was done
> outside the BQL (though in that case, cpu->exit_request probably
> would be replaced by a QemuEvent or something like that).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  accel/kvm/kvm-all.c          | 2 --
>  accel/tcg/cpu-exec.c         | 1 -
>  accel/tcg/tcg-accel-ops-rr.c | 9 +++++++--
>  accel/tcg/tcg-accel-ops.c    | 2 --
>  accel/tcg/user-exec.c        | 1 +
>  system/cpus.c                | 1 +
>  target/i386/nvmm/nvmm-all.c  | 2 --
>  target/i386/whpx/whpx-all.c  | 2 --
>  8 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index e4167d94b4f..d13156bee87 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3155,7 +3155,6 @@ int kvm_cpu_exec(CPUState *cpu)
>      trace_kvm_cpu_exec();
>  
>      if (kvm_arch_process_async_events(cpu)) {
> -        qatomic_set(&cpu->exit_request, 0);
>          return EXCP_HLT;
>      }
>  
> @@ -3345,7 +3344,6 @@ int kvm_cpu_exec(CPUState *cpu)
>          vm_stop(RUN_STATE_INTERNAL_ERROR);
>      }
>  
> -    qatomic_set(&cpu->exit_request, 0);
>      return ret;
>  }
>  
> diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
> index 3ae545e888f..ad94f96b252 100644
> --- a/accel/tcg/cpu-exec.c
> +++ b/accel/tcg/cpu-exec.c
> @@ -872,7 +872,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
>       * The corresponding store-release is in cpu_exit.
>       */
>      if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
> -        qatomic_set(&cpu->exit_request, 0);
>          if (cpu->exception_index == -1) {
>              cpu->exception_index = EXCP_INTERRUPT;
>          }
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index 610292d3bac..e9d291dc391 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -286,8 +286,13 @@ static void *rr_cpu_thread_fn(void *arg)
>          /* Does not need a memory barrier because a spurious wakeup is okay.  */
>          qatomic_set(&rr_current_cpu, NULL);
>  
> -        if (cpu && qatomic_read(&cpu->exit_request)) {
> -            qatomic_set_mb(&cpu->exit_request, 0);
> +        if (cpu) {
> +            /*
> +             * This could even reset exit_request for all CPUs, but in practice
> +             * races between CPU exits and changes to "cpu" are so rare that
> +             * there's no advantage in doing so.
> +             */
> +            qatomic_set(&cpu->exit_request, false);
>          }
>  
>          if (icount_enabled() && all_cpu_threads_idle()) {
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 1f662a9c745..3bd98005042 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -82,8 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
>      ret = cpu_exec(cpu);
>      cpu_exec_end(cpu);
>  
> -    qatomic_set_mb(&cpu->exit_request, 0);
> -
>      return ret;
>  }
>  
> diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
> index 81906d2e033..8f4f049b924 100644
> --- a/accel/tcg/user-exec.c
> +++ b/accel/tcg/user-exec.c
> @@ -54,6 +54,7 @@ void qemu_cpu_kick(CPUState *cpu)
>  
>  void qemu_wait_io_event(CPUState *cpu)
>  {
> +    qatomic_set(&cpu->exit_request, false);
>      process_queued_cpu_work(cpu);
>  }
>  
> diff --git a/system/cpus.c b/system/cpus.c
> index bb13942cbb7..f989d9938b6 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -463,6 +463,7 @@ void qemu_wait_io_event(CPUState *cpu)
>  {
>      bool slept = false;
>  
> +    qatomic_set(&cpu->exit_request, false);
>      while (cpu_thread_is_idle(cpu)) {
>          if (!slept) {
>              slept = true;
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 7e36c42fbb4..ed424251673 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -817,8 +817,6 @@ nvmm_vcpu_loop(CPUState *cpu)
>      cpu_exec_end(cpu);
>      bql_lock();
>  
> -    qatomic_set(&cpu->exit_request, false);
> -
>      return ret < 0;
>  }
>  
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 00fb7e23100..2a85168ed51 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2050,8 +2050,6 @@ static int whpx_vcpu_run(CPUState *cpu)
>          whpx_last_vcpu_stopping(cpu);
>      }
>  
> -    qatomic_set(&cpu->exit_request, false);
> -
>      return ret < 0;
>  }
>  


