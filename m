Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A91D4417D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 11:21:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU1Cm-00073X-GY; Fri, 12 Dec 2025 06:21:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vU1Cl-00073F-In
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:20:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vU1Cj-0000RG-B2
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 06:20:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765538456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=9XXFCT41HuGEMIU8EbPdyRQwtPcBMW60W6+dYBYa930=;
 b=RMdfCm09ZOiCui2yjA2lshcDOhQGimOnoI6aQoblZSiLgmNnQ25XtFmu8T04U8XHH/vEDS
 ZzsLC6HNoM8JufoxMHLy3glLs7fg225glN7UJKFRdGLl7ZJjcXNoNwmnu8Fm7/8qZV5nEm
 DGmVPyoSLFClAAAkogUwa7sEBqA9tXU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-RNzm_ywHPPG4QL4JHw0teQ-1; Fri, 12 Dec 2025 06:20:54 -0500
X-MC-Unique: RNzm_ywHPPG4QL4JHw0teQ-1
X-Mimecast-MFC-AGG-ID: RNzm_ywHPPG4QL4JHw0teQ_1765538453
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42e1e1ca008so553237f8f.0
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765538453; x=1766143253; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=9XXFCT41HuGEMIU8EbPdyRQwtPcBMW60W6+dYBYa930=;
 b=DBXURh+By2OvUeet7dH+QWYAJEhPHqpZAykEoiuNZa0dipRP+aUl5HNeNCqVg/tJHS
 E+8MKgVv4JXxacfoc+mcQpto0UoUdCCnzPaBPNBIy4si+c6VflVi+tP6cj7HwYhsjnBR
 uhoCSSA+BpOz/o/18F5oesPmxJBQe7Z2SKKbrr4LZVUZo4kozQD5hoKkRsLYLt3QxvH0
 TCZfz3zRTnrLezf/NArvTOl18Gvf32vCISMzXY+icuL0Wz6qAzQTLzvMuRoQrFDPSgZz
 5eUw/NHkU97PHdqHnRNecpj5S0q5+bpXbA1N6y5VgEGm2LNm+W6OcXW2HjPa+jgH/Y9g
 ODVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765538453; x=1766143253;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9XXFCT41HuGEMIU8EbPdyRQwtPcBMW60W6+dYBYa930=;
 b=Vz0v6XaPCM36gsrkoTMlTWe2/xqtYyZ+KngsE20ARu408E3ndFJhQsisGkkx6THae9
 7kIkW3Yj360QqAdqfZ17uLxW4B7pPYk7jcabYX7aNK06plGXBbTNs7NZMfiCH3LQeOmJ
 3OnQuYR/dWusyUzlvMoV1yp6HzmmsPYKB1Haha2vHhHZfqRqDHX8BWoAiPpd4oBOJbS1
 kbj2sfoSls+EE1XfRIsX1iGmXn5eaGMiqpxLkpnu8mDmQxcYDRuLi67N2qrZfkgRp7+3
 22Jo4St6XnDPNlW8doAjQn6v6wbxTOyTrxIfHYJ/7FS/k809OdkkeH22w1N5OkHXuVIM
 b8Hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe5ywAPvXbataTrbleT4oD6lWsK3pj6EYm8ntuNytUHDQMbKwwDqsF+M6FdpkMF+Dh+xQKaPJxoKUo@nongnu.org
X-Gm-Message-State: AOJu0Yy+lkQrtK+7mTAYkdU3rFXyBnLQ8xRKw8NzHMPYhGWMJNETg794
 vymMVoA7HLmwgJMnJvOGyBjY4bybf2uKk8wGDEc7pfAcxt0auBURWysM6wN7NRob57K1+NmydH5
 Kv+gaXD8jrH3EM7isQHtCwdnRziyX0NPkhklKPTWVM2XkprrS/DDZQSD+
X-Gm-Gg: AY/fxX6j9DOg2fqGGairTSH0wojNCHCEyOUC5QXYsqKtBsnz86RCj5Sq/TShZSl5lA0
 P6rhrlbgbx6rBdbY+Dn+i2cIyCKljxKgG/gtuqRXnpsNwEjcqKnVzZ8XZniwtI+TBSvhWt7BZBD
 mJ6E8szzcJI8GDLBVpAAbd+ftFioerElyg2VnltkqZGtSq4AQNNQ/A2ZBB0Knxj8GxS38M8leaL
 nprOp4QIqzYHeNwccmAxpHWTnQG2KbHLqyODdc7Hjplr86sbN75rPx07j9EgySFuXXGOr7npKut
 sdIqQ67MLk0pfi4HuVpXfOah+enYP+Y0gv3ne6Uk/gMXqh8sPPMNuWrHpU8roXMGl5w2ZcI1SqE
 k51KyrRErfDsh+Doi8p2/FSvrLv8LrnEKNkoWhAUAO2JUOzQqsnl5hsv7eM4DQVtin8IgDZsmB8
 +/N1cn8C88LCPzgH8=
X-Received: by 2002:a05:6000:24c4:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42fb3ecd768mr2081301f8f.21.1765538453294; 
 Fri, 12 Dec 2025 03:20:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHBKm7J3ndBN0qlkTPyJd9kEKPnFBS0oLW9QIAdt96co21W1xq99DGLEx87ERUEpSazdISDuA==
X-Received: by 2002:a05:6000:24c4:b0:411:3c14:3ad9 with SMTP id
 ffacd0b85a97d-42fb3ecd768mr2081263f8f.21.1765538452765; 
 Fri, 12 Dec 2025 03:20:52 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-42fa8a70440sm11737572f8f.16.2025.12.12.03.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 03:20:52 -0800 (PST)
Message-ID: <6721fd36-4c71-4206-9ddd-d30adb93e31c@redhat.com>
Date: Fri, 12 Dec 2025 12:20:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] qemu: TSAN Clean up
To: Marc Morcos <marcmorcos@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
References: <20251211231155.1171717-1-marcmorcos@google.com>
 <20251211231155.1171717-2-marcmorcos@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251211231155.1171717-2-marcmorcos@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 12/12/25 00:11, Marc Morcos wrote:
> - Fix 3 thread races detected by tsan
> - Change apicbase to 64 bit variable to reflect what it holds

While APICBASE is indeed 36-bits wide, this changes the migration format 
and also makes the patch much larger due to having to use the __nocheck 
variant.  So it should at least be separate.

The three races are:

- apicbase - this is complex and I cannot fully understand it.  It would 
be useful to state what the race is.
> @@ -34,9 +34,10 @@ static inline uint32_t kvm_apic_get_reg(struct kvm_lapic_state *kapic,
>   static void kvm_put_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
>   {
>       int i;
> +    uint64_t apicbase = qatomic_read__nocheck(&s->apicbase);
>   
>       memset(kapic, 0, sizeof(*kapic));
> -    if (kvm_has_x2apic_api() && s->apicbase & MSR_IA32_APICBASE_EXTD) {
> +    if (kvm_has_x2apic_api() && apicbase & MSR_IA32_APICBASE_EXTD) {

This runs in the vCPU thread (see kvm_apic_post_load, kvm_apic_reset).


>   void kvm_get_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
>   {
>       int i, v;
> +    uint64_t apicbase = qatomic_read__nocheck(&s->apicbase);

Likewise, via kvm_arch_get_registers.

> -    if (kvm_has_x2apic_api() && s->apicbase & MSR_IA32_APICBASE_EXTD) {
> +    if (kvm_has_x2apic_api() && apicbase & MSR_IA32_APICBASE_EXTD) {
>           assert(kvm_apic_get_reg(kapic, 0x2) == s->initial_apic_id);
>       } else {
>           s->id = kvm_apic_get_reg(kapic, 0x2) >> 24;
> @@ -97,7 +99,7 @@ void kvm_get_apic_state(APICCommonState *s, struct kvm_lapic_state *kapic)
>   
>   static int kvm_apic_set_base(APICCommonState *s, uint64_t val)
>   {
> -    s->apicbase = val;
> +    qatomic_set__nocheck(&s->apicbase, val);

Likewise, via cpu_set_apic_base (called by kvm_arch_post_run or 
helper_wrmsr).

>       return 0;
>   }
>   
> @@ -140,12 +142,14 @@ static void kvm_apic_put(CPUState *cs, run_on_cpu_data data)
>       APICCommonState *s = data.host_ptr;
>       struct kvm_lapic_state kapic;
>       int ret;
> +    uint64_t apicbase;
>   
>       if (is_tdx_vm()) {
>           return;
>       }
>   
> -    kvm_put_apicbase(s->cpu, s->apicbase);
> +    apicbase = qatomic_read__nocheck(&s->apicbase);
> +    kvm_put_apicbase(s->cpu, apicbase);

Also on the vCPU thread.

>       kvm_put_apic_state(s, &kapic);
>   
>       ret = kvm_vcpu_ioctl(CPU(s->cpu), KVM_SET_LAPIC, &kapic);
> diff --git a/hw/intc/apic_common.c b/hw/intc/apic_common.c
> index ec9e978b0b..9e42189d8a 100644
> --- a/hw/intc/apic_common.c
> +++ b/hw/intc/apic_common.c
> @@ -19,6 +19,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/atomic.h"
>   #include "qemu/error-report.h"
>   #include "qemu/module.h"
>   #include "qapi/error.h"
> @@ -52,8 +53,9 @@ int cpu_set_apic_base(APICCommonState *s, uint64_t val)
>   uint64_t cpu_get_apic_base(APICCommonState *s)
>   {
>       if (s) {
> -        trace_cpu_get_apic_base((uint64_t)s->apicbase);
> -        return s->apicbase;
> +        uint64_t apicbase = qatomic_read__nocheck(&s->apicbase);
> +        trace_cpu_get_apic_base(apicbase);
> +        return apicbase;

Also on the vCPU thread, via e.g. helper_rdmsr
> @@ -223,9 +225,9 @@ void apic_designate_bsp(APICCommonState *s, bool bsp)
>       }
>   
>       if (bsp) {
> -        s->apicbase |= MSR_IA32_APICBASE_BSP;
> +        qatomic_fetch_or(&s->apicbase, MSR_IA32_APICBASE_BSP);
>       } else {
> -        s->apicbase &= ~MSR_IA32_APICBASE_BSP;
> +        qatomic_fetch_and(&s->apicbase, ~MSR_IA32_APICBASE_BSP);
>       }
>   }
> @@ -233,10 +235,11 @@ static void apic_reset_common(DeviceState *dev)
>   {
>       APICCommonState *s = APIC_COMMON(dev);
>       APICCommonClass *info = APIC_COMMON_GET_CLASS(s);
> -    uint32_t bsp;
> +    uint64_t bsp;
>   
> -    bsp = s->apicbase & MSR_IA32_APICBASE_BSP;
> -    s->apicbase = APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE;
> +    bsp = qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_BSP;
> +    qatomic_set__nocheck(&s->apicbase,
> +                    APIC_DEFAULT_ADDRESS | bsp | MSR_IA32_APICBASE_ENABLE);

These two run on reset.  Is this the source of the issue?  What other 
threads are running concurrently on reset?


> @@ -405,7 +408,8 @@ static void apic_common_get_id(Object *obj, Visitor *v, const char *name,
>       APICCommonState *s = APIC_COMMON(obj);
>       uint32_t value;
>   
> -    value = s->apicbase & MSR_IA32_APICBASE_EXTD ? s->initial_apic_id : s->id;
> +    value = qatomic_read__nocheck(&s->apicbase) & MSR_IA32_APICBASE_EXTD ?
> +            s->initial_apic_id : s->id;
>       visit_type_uint32(v, name, &value, errp);
>   }

Or maybe this one?

> diff --git a/monitor/monitor.c b/monitor/monitor.c
> index c5a5d30877..f3bc4f0202 100644
> --- a/monitor/monitor.c
> +++ b/monitor/monitor.c
> @@ -338,15 +338,21 @@ static void monitor_qapi_event_emit(QAPIEvent event, QDict *qdict)
>   {
>       Monitor *mon;
>       MonitorQMP *qmp_mon;
> +    bool send;
>   
>       trace_monitor_protocol_event_emit(event, qdict);
>       QTAILQ_FOREACH(mon, &mon_list, entry) {
> +        qemu_mutex_lock(&mon->mon_lock);
>           if (!monitor_is_qmp(mon)) {
> +            qemu_mutex_unlock(&mon->mon_lock);

This reads mon->is_qmp.  It is initialized in monitor_data_init right 
after mon->mon_lock, therefore there can be no other concurrent read. 
Synchronization with other threads is handled by aio_bh_schedule_oneshot().

>               continue;
>           }
>   
>           qmp_mon = container_of(mon, MonitorQMP, common);
> -        if (qmp_mon->commands != &qmp_cap_negotiation_commands) {
> +        send = qmp_mon->commands != &qmp_cap_negotiation_commands;
> +        qemu_mutex_unlock(&mon->mon_lock);

This one is correct; however a better way to write it is

         if (!monitor_is_qmp(mon)) {
             continue;
         }
         WITH_QEMU_LOCK_GUARD(&mon->mon_lock) {
             qmp_mon = container_of(mon, MonitorQMP, common);
             if (qmp_mon->commands == &qmp_cap_negotiation_commands) {
                 continue;
             }
         }
         qmp_send_response(qmp_mon, qdict);


> +        if (send) {
>               qmp_send_response(qmp_mon, qdict);
>           }
>       }
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index cb99a12d94..73c2fb8cbf 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -462,9 +462,11 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>   
>       switch (event) {
>       case CHR_EVENT_OPENED:
> +        qemu_mutex_lock(&mon->common.mon_lock);
>           mon->commands = &qmp_cap_negotiation_commands;
>           monitor_qmp_caps_reset(mon);
>           data = qmp_greeting(mon);
> +        qemu_mutex_unlock(&mon->common.mon_lock);

Please make the critical section smaller and use WITH_QEMU_LOCK_GUARD().

>           qmp_send_response(mon, data);
>           qobject_unref(data);
>           break;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 60c7981138..76bdef2c78 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5474,7 +5474,10 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>       X86CPU *x86_cpu = X86_CPU(cpu);
>       CPUX86State *env = &x86_cpu->env;
>       int ret;
> +    bool nmi_pending = false;
> +    bool smi_pending = false;
>   
> +    bql_lock();

This hunk (unused variables and missing unlock) is definitely wrong, how 
was this even tested?

>       /* Inject NMI */
>       if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
>           if (cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
> diff --git a/util/thread-pool.c b/util/thread-pool.c
> index d2ead6b728..af49d4dfd9 100644
> --- a/util/thread-pool.c
> +++ b/util/thread-pool.c
> @@ -18,6 +18,7 @@
>   #include "qemu/defer-call.h"
>   #include "qemu/queue.h"
>   #include "qemu/thread.h"
> +#include "qemu/atomic.h"
>   #include "qemu/coroutine.h"
>   #include "trace.h"
>   #include "block/thread-pool.h"
> @@ -39,9 +40,9 @@ struct ThreadPoolElementAio {
>       ThreadPoolFunc *func;
>       void *arg;
>   
> -    /* Moving state out of THREAD_QUEUED is protected by lock.  After
> -     * that, only the worker thread can write to it.  Reads and writes
> -     * of state and ret are ordered with memory barriers.
> +    /*
> +     * All access to state must be atomic,
> +     * Use acquire/release ordering if relevant
>        */

This part is certainly correct, but the comment became worse.

	/*
	 * Accessed with atomics.  Moving state out of THREAD_QUEUED is
	 * protected by pool->lock and only the worker thread can move
	 * the state from THREAD_ACTIVE to THREAD_DONE.
          *
          * When state is THREAD_DONE, ret must have been written already.
          * Use acquire/release ordering when reading/writing ret as well.
	 */
         enum ThreadState state;

	/* Accessed with atomics.  */
         int ret;

> @@ -105,15 +106,14 @@ static void *worker_thread(void *opaque)
>   
>           req = QTAILQ_FIRST(&pool->request_list);
>           QTAILQ_REMOVE(&pool->request_list, req, reqs);
> -        req->state = THREAD_ACTIVE;
> +        qatomic_set(&req->state, THREAD_ACTIVE);
>           qemu_mutex_unlock(&pool->lock);
>   
>           ret = req->func(req->arg);
>   
>           req->ret = ret;
> -        /* Write ret before state.  */
> -        smp_wmb();
> -        req->state = THREAD_DONE;
> +        /* _release to write ret before state.  */
> +        qatomic_store_release(&req->state, THREAD_DONE);
>   
>           qemu_bh_schedule(pool->completion_bh);
>           qemu_mutex_lock(&pool->lock);
> @@ -180,7 +180,8 @@ static void thread_pool_completion_bh(void *opaque)
>   
>   restart:
>       QLIST_FOREACH_SAFE(elem, &pool->head, all, next) {
> -        if (elem->state != THREAD_DONE) {
> +        /* _acquire to read state before ret.  */
> +        if (qatomic_load_acquire(&elem->state) != THREAD_DONE) {
>               continue;
>           }
>   
> @@ -189,9 +190,6 @@ restart:
>           QLIST_REMOVE(elem, all);
>   
>           if (elem->common.cb) {
> -            /* Read state before ret.  */
> -            smp_rmb();
> -
>               /* Schedule ourselves in case elem->common.cb() calls aio_poll() to
>                * wait for another request that completed at the same time.
>                */
> @@ -223,11 +221,11 @@ static void thread_pool_cancel(BlockAIOCB *acb)
>       trace_thread_pool_cancel_aio(elem, elem->common.opaque);
>   
>       QEMU_LOCK_GUARD(&pool->lock);
> -    if (elem->state == THREAD_QUEUED) {
> +    if (qatomic_read(&elem->state) == THREAD_QUEUED) {
>           QTAILQ_REMOVE(&pool->request_list, elem, reqs);
>           qemu_bh_schedule(pool->completion_bh);
>   
> -        elem->state = THREAD_DONE;
> +        qatomic_set(&elem->state, THREAD_DONE);

This one is not necessary, because it's protected by the lock and no
other thread will look at it.  If you want to use atomics here for
consistency, you should first use qatomic_set for ->ret and then
qatomic_store_release for ->state.

Thanks for the patch; I suggest that you split it across multiple 
commits and focus on thread-pool.c and the monitor to begin with.

Paolo

>           elem->ret = -ECANCELED;
>       }
>   


