Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501FFC87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 15:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulqUv-0006fB-JJ; Tue, 12 Aug 2025 11:01:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulqUk-0006eV-4U
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:00:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1ulqUc-0006r9-Nq
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 11:00:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755010845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+hdYQTj6K8rLJvmUmvHO5gkHnZfbIMkP/mN/S4QTXBU=;
 b=DLKr7jwkDaqyUtEqHOyI/erdqIGCbcqc985erZHqtgpVCOwJiDhauutM411EWdvCXCvjgl
 ZTab+JzpJwPI89SbSdhSs/t7r3EOAgSV7CQfMhiXYJEMDxEkF0lw07EeuJfSsFo9olSzEV
 LHx5cgAYjxnfPTahoZMpAydsGVThlto=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-3yoQJWUpMuiuSJCA7oOP3Q-1; Tue, 12 Aug 2025 11:00:41 -0400
X-MC-Unique: 3yoQJWUpMuiuSJCA7oOP3Q-1
X-Mimecast-MFC-AGG-ID: 3yoQJWUpMuiuSJCA7oOP3Q_1755010841
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7e36e20d700so1124713385a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 08:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755010841; x=1755615641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+hdYQTj6K8rLJvmUmvHO5gkHnZfbIMkP/mN/S4QTXBU=;
 b=OrVYZ1hGKo++smo0kl29jfxzxTuiXulHIWKr9b7qlM+qM0r8jyYaZ4R2odUgotP3n5
 hDw/f1aKQM/Ow3IZeUsARaSEcLNlwg6O3CrcDaO8J9cXLhpj/e7+Xn0VQVTZsf12EsBC
 snbaPr/IXZ3zJyRpFUJ5bmDtOA8omlbcEH7Y5pNeFsVqBv1NdchX9lgF+K6NOqa0Mdy9
 05alBY8RcHAEnfjrQ+LAAa08JHN4C5OrkTlHA08/UXBaXTxt0sERF6ggvDX9etJF/QSM
 KAwuhgqjZlxPxywA6EEPneQbJrwu4bd1h24xiXd78idTzzG23YeGnvGPX7BG/xo5LWjd
 7Jhw==
X-Gm-Message-State: AOJu0YxWjgbD4l7pfZUjf9LX+hGJB6N3TmKbcFzCNylrgmbW3M7ns9Lw
 HCps2Poes/vsHuHUmc58K5CpiCPUtMqG9Nk4H0Hb5eNhyPYUJyzI+eoxETWiCUu8/+zXjXj7uXw
 aoaQjCWRqfB3Ja0LHe5i+v14srPQkwBwTh9kluT+b1P0ITzQhN7Dvs4Z8
X-Gm-Gg: ASbGncvbkUXyWh41il2j/GC+NUDnQl1CkPSV1/QryfOvoO/nTZI/y6YAojvYIeo8I23
 KqGlEImkkWHT2o2WG8warZreayw8OEQpgrZgoo5YFHgJRJdCHLSJwsXbJshzwxPKSxSLjXQsC5s
 VlRWBHCf/nmnQfP97pE3E3efQMwaklms2rO6uJ6W8eAnXRVDjbPFI4Bqy+4YXsX2xQ20xP6rGNf
 B+juOTGX/6dOk5/LfXL7bdEZDMzZTbYB06G+k6jM2ML65uKkFvwgCNKnicpHxy/ORk8rdGgjTQA
 W+6xv5/6dAEtvJtF7nQAUG/UeH89wA==
X-Received: by 2002:a05:620a:28c1:b0:7e6:9dee:2130 with SMTP id
 af79cd13be357-7e858dafa51mr443279085a.9.1755010840397; 
 Tue, 12 Aug 2025 08:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9SBym0T4JwMHL8OAxP2DMs3NYND/5708TW3vRGJaNpxhq/I9ngHHiDYXCRG/u3R46scFekQ==
X-Received: by 2002:a05:620a:28c1:b0:7e6:9dee:2130 with SMTP id
 af79cd13be357-7e858dafa51mr443266685a.9.1755010839421; 
 Tue, 12 Aug 2025 08:00:39 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e67f72b045sm1767690485a.60.2025.08.12.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 08:00:38 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:00:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com,
 david@redhat.com, philmd@linaro.org, mtosatti@redhat.com, David Hildenbrand
 <david@redhat.com>, Stafford Horne <shorne@gmail.com>,
 richard.henderson@linaro.org, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 06/10] introduce cpu_test_interrupt() that will
 replace open coded checks
Message-ID: <20250812170035.609ce5c1@fedora>
In-Reply-To: <aJoa35wuexHfoCEE@x1.local>
References: <20250808120137.2208800-1-imammedo@redhat.com>
 <20250808120137.2208800-7-imammedo@redhat.com>
 <aJoa35wuexHfoCEE@x1.local>
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

On Mon, 11 Aug 2025 12:31:27 -0400
Peter Xu <peterx@redhat.com> wrote:

> On Fri, Aug 08, 2025 at 02:01:33PM +0200, Igor Mammedov wrote:
> > the helper forms load-acquire/store-release pair with
> > tcg_handle_interrupt/generic_handle_interrupt and can be used
> > for checking interrupts outside of BQL
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >  include/hw/core/cpu.h     | 12 ++++++++++++
> >  accel/tcg/tcg-accel-ops.c |  3 ++-
> >  system/cpus.c             |  3 ++-
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index 5eaf41a566..d0460c01cf 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -942,6 +942,18 @@ CPUState *cpu_by_arch_id(int64_t id);
> >  
> >  void cpu_interrupt(CPUState *cpu, int mask);
> >  
> > +/**
> > + * cpu_test_interrupt:
> > + * @cpu: The CPU to check interrupt(s) on.
> > + * @mask: The interrupts to check.
> > + *
> > + * Checks if any of interrupts in @mask are pending on @cpu.
> > + */
> > +static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
> > +{
> > +    return qatomic_load_acquire(&cpu->interrupt_request) & mask;
> > +}
> > +
> >  /**
> >   * cpu_set_pc:
> >   * @cpu: The CPU to set the program counter for.
> > diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> > index 3b0d7d298e..02c7600bb7 100644
> > --- a/accel/tcg/tcg-accel-ops.c
> > +++ b/accel/tcg/tcg-accel-ops.c
> > @@ -97,7 +97,8 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
> >  /* mask must never be zero, except for A20 change call */
> >  void tcg_handle_interrupt(CPUState *cpu, int mask)
> >  {
> > -    cpu->interrupt_request |= mask;
> > +    qatomic_store_release(&cpu->interrupt_request,
> > +        cpu->interrupt_request | mask);
> >  
> >      /*
> >       * If called from iothread context, wake the target cpu in
> > diff --git a/system/cpus.c b/system/cpus.c
> > index 256723558d..8e543488c3 100644
> > --- a/system/cpus.c
> > +++ b/system/cpus.c
> > @@ -256,7 +256,8 @@ int64_t cpus_get_elapsed_ticks(void)
> >  
> >  void generic_handle_interrupt(CPUState *cpu, int mask)
> >  {
> > -    cpu->interrupt_request |= mask;
> > +    qatomic_store_release(&cpu->interrupt_request,
> > +        cpu->interrupt_request | mask);
> >  
> >      if (!qemu_cpu_is_self(cpu)) {
> >          qemu_cpu_kick(cpu);
> > -- 
> > 2.47.1
> >   
> 
> Besides the two writters mentioned above, I still see some more:
> 
> *** accel/tcg/user-exec.c:
> cpu_interrupt[52]              cpu->interrupt_request |= mask;

I don't know if external interrupts can happen in user mode,
for same thread(self) exceptions we don't really need it.

> *** hw/intc/s390_flic.c:
> qemu_s390_flic_notify[193]     cs->interrupt_request |= CPU_INTERRUPT_HARD;

later on the function, for cpus it deemed not to ignore,
explicitly calls cpu_interrupt() which will do store_release.
I'd tentatively would say we don't need explicit store_release here

Anyways CCing David, perhaps he would recall why it's setting interrupt for all
but ignores to actually rise it for some.

> *** hw/openrisc/cputimer.c:
> openrisc_timer_cb[108]         cs->interrupt_request |= CPU_INTERRUPT_TIMER;

this one seems to be similar to generic_handle_interrupt(),
interrupt request from external thread, so I'd add store_release here.

Arguably, it should be calling cpu_interrupt() instead of opencoding it.
(the questionable part is that it set interrupt conditionally but
kicks vccpu always - is this really necessary?)


> *** target/arm/helper.c:
> arm_cpu_do_interrupt[9150]     cs->interrupt_request |= CPU_INTERRUPT_EXITTB;
on kvm it can be reached via main thread or vcpu(self) thread.
so tentatively we need it here.

(ps: kvm_arch_on_sigbus_vcpu()->arm_cpu_do_interrupt() is called under BQL
while kvm_on_sigbus() is called without one from signal handler,
which theoretically might trample on the thread running the 1st vcpu)

> *** target/i386/tcg/system/svm_helper.c:
> helper_vmrun[406]              cs->interrupt_request |= CPU_INTERRUPT_VIRQ;
this one seems to be self targeted (i.e. same thread),
perhaps TCG experts can comment on it.

CCing TCG folks as series touches a few TCG bits anyway


> Do they better as well be converted to use store_release too?

alternatively, for consistency sake we can add a helper to set interrupt
with store_release included and do a blanket tree wide change like with
cpu_test_interrupt().
 
> The other nitpick is this patch introduces the reader helper but without
> using it.
> 
> It can be squashed into the other patch where the reader helper will be
> applied tree-wide.  IMHO that would be better explaining the helper on its
> own.

I can merge it with 7/10 that adds 1st user for the helper in kvm/i386 code.
That has less chances for the store/acquire change to be drowned in
tree wide patch (9/10)

> 
> Thanks,
> 


