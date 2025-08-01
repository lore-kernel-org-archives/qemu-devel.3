Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C9DC87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 10:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhmzf-0007qJ-PM; Fri, 01 Aug 2025 06:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uhmyJ-0006eC-77
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 06:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uhmyB-0006TO-F9
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 06:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754043990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=l1q1MYNf0iMgjLs4qO41wUCJBSHp5ysXOdsQ2yDLqko=;
 b=P72Upi48ImB04p5+KZYKyu+93PsnAAPEvqwWz6DWZSaNDOszG2fJ28+yCeTUqPPuhJCvOg
 EgSDVpTpnoNwRHnQJJq2muEg/Po4GQGtQh4KVpSpQYyCV8vCXmVCYtfr+icsvmkFKjddF0
 IhC5n6zYz18LAWnp1yhUNKiaDP7BiFE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-qoEMWOjzPa-ule8i3ZMxIA-1; Fri, 01 Aug 2025 06:26:29 -0400
X-MC-Unique: qoEMWOjzPa-ule8i3ZMxIA-1
X-Mimecast-MFC-AGG-ID: qoEMWOjzPa-ule8i3ZMxIA_1754043989
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so716948f8f.2
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 03:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754043988; x=1754648788;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l1q1MYNf0iMgjLs4qO41wUCJBSHp5ysXOdsQ2yDLqko=;
 b=cqtmNfnCaO1SB+Fkar7tZ3pP2aOawDHpflPG0mCrpujLZ9qYoF4X6U//1xUBhTuVCJ
 HtdxbeEnnyWH8IO0mHxv0Oo/V6HQenCH53/wwNWRy6hkOw5oGUnftQ0lyTyaKQKLwMjn
 5/3eg4+NtNB4RDxAH8b8/JgsHZ+a5kePbhVhiZ0gTAKn5WgB8sJTy+DnJZb6/uFvcee2
 rdV+AHKBsVQAzsH7ZW21xP6jQJzTtv9wsZRAmdrrSK98z2/vAOtjKb/2LW4xV4oIvZpq
 NenvUUOvOL6mH0+NfQNN7gBVySsK6Bm1c2YXfdGKrmRZyfP2ZG4P43IrLhaM4xl8x4Fw
 KXtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUowiiHCJd0SSSL3TsmocUx5bbLvf96VT65RlO9etO2SoOnrOEDfrE5lWmzQurgGRYEidcYP+NRGARa@nongnu.org
X-Gm-Message-State: AOJu0YzAWBYVuUqGdFBfaQ4VU7lmW+OjqVRuxT0HGxISlKaundztHWAD
 FD63X8t3cnzE7YmE2azN0t8lOap8hZCqAoP2dUygfQEUKKr+JTYDFBiIBBlhpZYg5J8StIVuoxO
 pXwVKQQG+pSTjV6kiVrvulw8feUmbreW535siOPJPbZ6WFaS6BUpT0MJK
X-Gm-Gg: ASbGncvUbjj536PFGfIi+OqMup16VwuwSgnV+6FCAZt6qpLWFSP5uJzl0zDwm4lsEns
 /+jqFP9mBnY8i5otxA48ToL7doVd6DoLoCC+DvcUVJy9Uiv5nMdSVUUUl8bcux/GXrYSZgD4mBU
 5Q1EhiRrk8Vs/hnVO7J+TdpQyqpqVcJqpbZtwHOecQrsa2Xs0UChXNZr/rkt6CRyPywioMqmgxh
 2LKq9+GeZavJz0NbHXIOh4lJ94fJTEN2ZM2VBNyVv4X1jEhkHJNWXHnFia+PXXvGyGwQ8qCXPBk
 CeBdcRaZAkOwwz76r19JpFHrKZC7bYh3fl+c/IeXoYVcnA==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:644f:9ca7 with SMTP id
 ffacd0b85a97d-3b794fd7c3cmr8202971f8f.25.1754043988525; 
 Fri, 01 Aug 2025 03:26:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvd6lCXn+4qds0Gw+4p/7QI/y/eNFrTD6/N6M/IMbJOMnJ0ZFaIJ25+udp+WuofX3EJpuZqw==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:644f:9ca7 with SMTP id
 ffacd0b85a97d-3b794fd7c3cmr8202948f8f.25.1754043988075; 
 Fri, 01 Aug 2025 03:26:28 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.122.191])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3b9160sm5455002f8f.21.2025.08.01.03.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 03:26:27 -0700 (PDT)
Message-ID: <8edc80d5-49a0-4e4d-82c4-e4a18eb78304@redhat.com>
Date: Fri, 1 Aug 2025 12:26:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] kvm: i386: irqchip: take BQL only if there is an
 interrupt
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, mst@redhat.com, mtosatti@redhat.com,
 kraxel@redhat.com, peter.maydell@linaro.org
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-7-imammedo@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250730123934.1787379-7-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

The patch is not wrong but complicates things more than it should.

Also, as we do more of these tricks it may be worth adding wrapper APIs 
for interrupt_request access, but that needs to be done tree-wide so you 
can do it separately.

On 7/30/25 14:39, Igor Mammedov wrote:
>      if (cpu->interrupt_request & (CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
> +        if (!kvm_pic_in_kernel()) {
> +            bql_lock();
> +            release_bql = true;
> +        }

This bql_lock() is not needed, all the writes in the "if" are local to 
the current CPU.

When the outer bql_lock() was added, cpu_interrupt() was not thread-safe 
at all, and taking the lock was needed in order to read 
cpu->interrupt_request.  But now it is ok to read outside the lock, 
which you can use to simplify this patch a lot.

>          if ((cpu->interrupt_request & CPU_INTERRUPT_INIT) &&
>              !(env->hflags & HF_SMM_MASK)) {
>              cpu->exit_request = 1;

A patch that changes all these accesses to 
qatomic_set(&cpu->exit_request, 1), tree-wide, would be nice.

> +        if (cpu->interrupt_request & CPU_INTERRUPT_HARD) {

This should be qatomic_read(&cpu->interrupt_request).  Not a blocker for 
now, but this is where I would suggest adding a wrapper like 
cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD).

> +            if (!release_bql) {
> +                bql_lock();
> +                release_bql = true;
> +            }

With the above simplification, this can be done unconditionally.

> +            /* Try to inject an interrupt if the guest can accept it */
> +            if (run->ready_for_interrupt_injection &&
> +                (cpu->interrupt_request & CPU_INTERRUPT_HARD) &&
> +                (env->eflags & IF_MASK)) {
> +                int irq;
> +
> +                cpu->interrupt_request &= ~CPU_INTERRUPT_HARD;

Reads and writes to cpu->interrupt_request still take the BQL, which is 
consistent with include/hw/core/cpu.h, so yeah here the bql_lock() is 
needed.

Like above, writing it's a data race with readers outside the BQL, so 
qatomic_read()/qatomic_set() would be needed to respect the C standard. 
Even better could be to add a function cpu_reset_interrupt_locked() that 
does

    assert(bql_locked());
    qatomic_set(&cpu->interrupt_request, cpu->interrupt_request & ~mask);

But neither of these wrappers (which should be applied tree-wide) are an 
absolute necessity for this series.

> @@ -5531,7 +5540,14 @@ void kvm_arch_pre_run(CPUState *cpu, struct kvm_run *run)
>   
>           DPRINTF("setting tpr\n");
>           run->cr8 = cpu_get_apic_tpr(x86_cpu->apic_state);
> +        /*
> +         * make sure that request_interrupt_window/cr8 are set
> +         * before KVM_RUN might read them
> +         */
> +        smp_mb();

This is not needed, ->cr8 is only read for the same CPU (in 
kvm_arch_vcpu_ioctl_run).

> +    }
>   
> +    if (release_bql) {
>           bql_unlock();
>       }

And since release_bql is not needed anymore, the bql_unlock() can be 
left where it was.

Paolo

>   }


