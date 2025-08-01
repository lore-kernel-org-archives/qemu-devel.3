Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F5BC87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 08:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhlLT-0008F8-QX; Fri, 01 Aug 2025 04:42:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhlLQ-0008EH-7b
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:42:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uhlLL-0002RU-OV
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 04:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754037740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbZ0JhJh3iRLGnjV+ffoprl1C84JKgWN9089VM9FjUU=;
 b=XXkWph0NW2uZZujzsXW23i6SBp0GIRyTtMXZE/BO0o0bIWNPig88W37sre9K2waLcQ0YkX
 94adNr4kxf5ZIT1d3MwbeNhFtKhYSn0+RlxyDGqA8m5HyuSTAjQYv2wLr22ec5vY3gKx/j
 3S9jbWki26LlTQZQqAkXV94XCje3yWw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-3Dka0fY9Olu93TRydjuz1g-1; Fri, 01 Aug 2025 04:42:19 -0400
X-MC-Unique: 3Dka0fY9Olu93TRydjuz1g-1
X-Mimecast-MFC-AGG-ID: 3Dka0fY9Olu93TRydjuz1g_1754037737
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456175dba68so4197615e9.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 01:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754037737; x=1754642537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbZ0JhJh3iRLGnjV+ffoprl1C84JKgWN9089VM9FjUU=;
 b=t1jeqiKT8fU6zgEuc/Gk4TrGqazudDmMb2oMDAgYlcDDXBExIFZ94TDJAVUHPLMuDb
 PGg775mn6Gv5mn2KDxlqT0Na19YeTTYnq+6QQzqvgKOBP4yV1fvseV2dopC3fY9VJaLJ
 2YlBhAA1RqpC5oETdDwiESx+SkF6IaMR2XyvjYHfv15kdHR/1+oUKpaXeM2MRSi9ypTp
 54VmQJoKQZ/GPCi+UfRTMScimPZytsEs/qdjT4n7+CQiBwCwgOy1wkRGU8zUgjOAO509
 WdU5BEPbeM4gwR++U6XGUJ60a+0coIJbKz8dT/rDVXTt4x3laTmQb1ta6GCJgFj7hQaq
 gByA==
X-Gm-Message-State: AOJu0YwStIv5rZ8IApVe9S9Xbg0suvlGFZYEPrOIa0S9kNjJO28YaiYk
 fvGDa0X9fOfk32qgvaQMDlOEiB+8OhG7zBwt4lQQvALJTw3IJCGQtSVRigXW731jOYLQltjBZvX
 nZk55/rt9CE6QRgq38dP0XO/aAPMa5xB70Uf2qr3MY8ez182qE/l9rKvq
X-Gm-Gg: ASbGnct7NsJvFneCFW9Cq0gVSBr8lrF2Pe8mMZIgrfnHSn+lqoV6HieL1AxDOdyiu6q
 RxNLvYCtM/S8vTBtGaHttg6g13bMK94FyffbtGGqF8jlz7+EFt6f4s4GYPVF9aoWAeQSeWhUVFq
 s+SuY6vOdnusgk4KY5IFd7+zt2owCWO1AkpZObJ26Mg/LyA0mVG3tkol16EbJXU6bSna9wH+ZgM
 v8EYYrolVHtLHp2kd7nFatoyFbdpIhUQuzVlnndkYsy1+gwAkYZmsKeFwWKIvut+ffZLriNsY5m
 5CZTY4EiKj1ESwzLANtMAIdJqBkdMA==
X-Received: by 2002:a05:600c:5195:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-45892b9da2dmr109288865e9.10.1754037737107; 
 Fri, 01 Aug 2025 01:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7foJ1t+8cYjTJzjBntXBWmzq5bQEJEgy5VC1uroiwew+0NNFdr7wU/x5679eA79nDi+KhjQ==
X-Received: by 2002:a05:600c:5195:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-45892b9da2dmr109288545e9.10.1754037736679; 
 Fri, 01 Aug 2025 01:42:16 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953cfeaesm102737575e9.16.2025.08.01.01.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 01:42:16 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:42:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, kraxel@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH v2 6/6] kvm: i386: irqchip: take BQL only if there is an
 interrupt
Message-ID: <20250801104215.2ceaa19a@fedora>
In-Reply-To: <aIvDC4nv1mUNLeMI@x1.local>
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-7-imammedo@redhat.com>
 <aIvDC4nv1mUNLeMI@x1.local>
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

On Thu, 31 Jul 2025 15:24:59 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 30, 2025 at 02:39:34PM +0200, Igor Mammedov wrote:
> > when kernel-irqchip=split is used, QEMU still hits BQL
> > contention issue when reading ACPI PM/HPET timers
> > (despite of timer[s] access being lock-less).
> > 
> > So Windows with more than 255 cpus is still not able to
> > boot (since it requires iommu -> split irqchip).
> > 
> > Problematic path is in kvm_arch_pre_run() where BQL is taken
> > unconditionally when split irqchip is in use.
> > 
> > There are a few parts tha BQL protects there:
> >   1. interrupt check and injecting
> > 
> >     however we do not take BQL when checking for pending
> >     interrupt (even within the same function), so the patch
> >     takes the same approach for cpu->interrupt_request checks
> >     and takes BQL only if there is a job to do.
> > 
> >   2. request_interrupt_window access
> >       CPUState::kvm_run::request_interrupt_window doesn't need BQL
> >       as it's accessed on side QEMU only by its own vCPU thread.
> >       The only thing that BQL provides there is implict barrier.
> >       Which can be done by using cheaper explicit barrier there.
> > 
> >   3. cr8/cpu_get_apic_tpr access
> >       the same (as #2) applies to CPUState::kvm_run::cr8 write,
> >       and APIC registers are also cached/synced (get/put) within
> >       the vCPU thread it belongs to.
> > 
> > Taking BQL only when is necessary, eleminates BQL bottleneck on
> > IO/MMIO only exit path, improoving latency by 80% on HPET micro
> > benchmark.
> > 
> > This lets Windows to boot succesfully (in case hv-time isn't used)
> > when more than 255 vCPUs are in use.  
> 
> Not familiar with this path, but the change looks reasonable, a few pure
> questions inline.

perhaps Paolo can give an expert opinion.

> 
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  target/i386/kvm/kvm.c | 58 +++++++++++++++++++++++++++----------------
> >  1 file changed, 37 insertions(+), 21 deletions(-)
> > 
> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> > index 369626f8c8..32024d50f5 100644
> > --- a/target/i386/kvm/kvm.c
> > +++ b/target/i386/kvm/kvm.c
> > @@ -5450,6 +5450,7 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >  {
> >      X86CPU *x86_cpu = X86_CPU(cpu);
> >      CPUX86State *env = &x86_cpu->env;
> > +    bool release_bql = 0;
> >      int ret;
> >  
> >      /* Inject NMI */
> > @@ -5478,15 +5479,16 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >          }
> >      }
> >  
> > -    if (!kvm_pic_in_kernel()) {
> > -        bql_lock();
> > -    }
> >  
> >      /* Force the VCPU out of its inner loop to process any INIT requests
> >       * or (for userspace APIC, but it is cheap to combine the checks here)
> >       * pending TPR access reports.
> >       */
> >      if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
> > +        if (!kvm_pic_in_kernel()) {
> > +            bql_lock();
> > +            release_bql = true;
> > +        }  
> 
> Does updating exit_request need bql at all?  I saw the pattern is this:
> 
>         kvm_arch_pre_run(cpu, run);
>         if (qatomic_read(&cpu->exit_request)) {
>             trace_kvm_interrupt_exit_request();
>             /*
>              * KVM requires us to reenter the kernel after IO exits to complete
>              * instruction emulation. This self-signal will ensure that we
>              * leave ASAP again.
>              */
>             kvm_cpu_kick_self();
>         }
> 
> So setting exit_request=1 here will likely be read very soon later, in this
> case it seems the lock isn't needed.

Given I'm not familiar with the code, I'm changing locking logic only in
places I have to and preserving current current behavior elsewhere.

looking at the code, it seems we are always hold BQL when setting
exit_request.

> 
> >          if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
> >              !(env->hflags & HF_SMM_MASK)) {
> >              cpu->exit_request = 1;
> > @@ -5497,24 +5499,31 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >      }
> >  
> >      if (!kvm_pic_in_kernel()) {
> > -        /* Try to inject an interrupt if the guest can accept it */
> > -        if (run->ready_for_interrupt_injection &&
> > -            (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> > -            (env->eflags & IF_MASK)) {
> > -            int irq;
> > -
> > -            cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> > -            irq = cpu_get_pic_interrupt(env);
> > -            if (irq >= 0) {
> > -                struct kvm_interrupt intr;
> > -
> > -                intr.irq = irq;
> > -                DPRINTF("injected interrupt %d\n", irq);
> > -                ret = kvm_vcpu_ioctl(cpu, KVM_INTERRUPT, &intr);
> > -                if (ret < 0) {
> > -                    fprintf(stderr,
> > -                            "KVM: injection failed, interrupt lost (%s)\n",
> > -                            strerror(-ret));
> > +        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {
> > +            if (!release_bql) {
> > +                bql_lock();
> > +                release_bql = true;
> > +            }
> > +
> > +            /* Try to inject an interrupt if the guest can accept it */
> > +            if (run->ready_for_interrupt_injection &&
> > +                (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> > +                (env->eflags & IF_MASK)) {
> > +                int irq;
> > +
> > +                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;
> > +                irq = cpu_get_pic_interrupt(env);
> > +                if (irq >= 0) {
> > +                    struct kvm_interrupt intr;
> > +
> > +                    intr.irq = irq;
> > +                    DPRINTF("injected interrupt %d\n", irq);
> > +                    ret = kvm_vcpu_ioctl(cpu, KVM_INTERRUPT, &intr);
> > +                    if (ret < 0) {
> > +                        fprintf(stderr,
> > +                                "KVM: injection failed, interrupt lost (%s)\n",
> > +                                strerror(-ret));
> > +                    }
> >                  }
> >              }
> >          }
> > @@ -5531,7 +5540,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
> >  
> >          DPRINTF("setting tpr\n");
> >          run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
> > +        /*
> > +         * make sure that request_interrupt_window/cr8 are set
> > +         * before KVM_RUN might read them
> > +         */
> > +        smp_mb();  
> 
> Is this mb() needed if KVM_RUN will always happen in the same thread anyway?


it matches with similar pattern:

        /* Read cpu->exit_request before KVM_RUN reads run->immediate_exit.      
         * Matching barrier in kvm_eat_signals.                                  
         */                                                                                                     
        smp_rmb();                                                               
                                                                                 
        run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0); 

to be on the safe side, this is preserving barrier that BQL has provided before
I can drop it if it's not really needed.

> 
> Thanks,
> 
> > +    }
> >  
> > +    if (release_bql) {
> >          bql_unlock();
> >      }
> >  }
> > -- 
> > 2.47.1
> >   
> 


