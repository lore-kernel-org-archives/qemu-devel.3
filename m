Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04285C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 13:30:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhpot-0003EA-LQ; Fri, 01 Aug 2025 09:29:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uhpUm-0003nD-Br
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:08:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uhpUi-0003Zi-G8
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 09:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754053697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v5TE/fM/QX+7N+mq/zr3hWOBj+ZnzWuAUQQKflajtqI=;
 b=fxu8AzjNJPKF0ZCAPNRjqlVbmWPzmB9JmrS+J8ejLCgApnZRefYrabZwZh0wSGTP7fbvs2
 Vs18rDGfH+fW0Un+1TdymReylwUOO88Qg4yzpYPUtiAgCPT75+PKfRxX/qUF+jVn5on2CC
 XLorXqKDbPeyntKIEqyb64ujXksrlYk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-LzKuZoFwM7CpBg-f7-KsXg-1; Fri, 01 Aug 2025 09:08:16 -0400
X-MC-Unique: LzKuZoFwM7CpBg-f7-KsXg-1
X-Mimecast-MFC-AGG-ID: LzKuZoFwM7CpBg-f7-KsXg_1754053695
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45359bfe631so9499145e9.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 06:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754053695; x=1754658495;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v5TE/fM/QX+7N+mq/zr3hWOBj+ZnzWuAUQQKflajtqI=;
 b=ZDsvSyu5NjhxVQiKc0wZpJOgr02fZmMSJrVyu/APXOIYwdFYJco1GfBhB6Ysvd6qJ+
 6GlpzSGnYVQCNkP/clJ8JOhp51sQFKY4B9+ivu5FEc67dd5iPc/ByWfV2P/YjrLr1Uih
 csJE0ffI/MDTCRhSyyFHtoFhF3lKSjNclZzJpYW8rpcDeiHp1vpzz8T+uqHdgOPVmhEK
 spLNBOxouFnNTRLAgwSn2bgotYuMxpOyEojgvm8X3O4P8Q8SP98Ky5bcIf4K3qfTW3Ls
 UeRujEtAiuj/8hToqfVB5cW+YlAf37W0zQ4ORzsWiKCnnwYVDAYFJov8fjqyFDaY1VxR
 /HVA==
X-Gm-Message-State: AOJu0Yym/fXmHqXCErIbZXzs4XIokBzct3XgDAVbn3WlXJLSWgDXJirR
 6w4nKj/UXvQ9aN1x7+TmQl3scSfuBwJaf4LP0InEpSBMh8l82/k8wN9c3sWhs0lO82Mx8c0qWB/
 LIIdyrl613dnkT4x0YyymniCHsApcVyrKIqmb/GuHX9lRqHY6W6dyzOzy
X-Gm-Gg: ASbGncv/d2rqCzHaeOYDw0NYMoXOI1P6JeJAF2CqJIC766yWC2p1WWiA5QxZ4RseiEh
 2kqXA3+zmrJD4aYBEvERQtnp4r9awfCcrFjVDzIK16nrpbevoTXU4T3cxddLynOE7xI763OpXGp
 imHdiwFlLqPmnYIU8pqcyjyYbE75D/gGltkpMRKXwLb62+F9qeOcRGQ8J6sDTFOPuCz0UIhWMHo
 2PAFpaA0IV1wlN1gu79VHqmBIHBIaSuiyXDMmjgAVTrfbEEeGylOcZW0GFlJkid/WN56cDWt8V0
 0Ody2G+BAjg9Y5/BNk0MH+0R9uFQA3oeIFlX2Uz6lYrHLg==
X-Received: by 2002:a05:600c:c4a3:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45892b94d5emr99859105e9.6.1754053694561; 
 Fri, 01 Aug 2025 06:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8sAkdjVG5AKkSbHvHgjfV5/FX8QD5zeHg5PiML0eIFX//aI8KxDHnqA0WUafWcpNX4/3oTQ==
X-Received: by 2002:a05:600c:c4a3:b0:450:6b55:cf91 with SMTP id
 5b1f17b1804b1-45892b94d5emr99858465e9.6.1754053693987; 
 Fri, 01 Aug 2025 06:08:13 -0700 (PDT)
Received: from [192.168.10.81] ([176.206.122.191])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-458981d0b06sm108768545e9.5.2025.08.01.06.08.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Aug 2025 06:08:13 -0700 (PDT)
Message-ID: <5c73f6ef-7a6b-42ed-ab79-9060471f1891@redhat.com>
Date: Fri, 1 Aug 2025 15:08:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] kvm: i386: irqchip: take BQL only if there is an
 interrupt
To: Igor Mammedov <imammedo@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, mtosatti@redhat.com,
 kraxel@redhat.com, peter.maydell@linaro.org
References: <20250730123934.1787379-1-imammedo@redhat.com>
 <20250730123934.1787379-7-imammedo@redhat.com> <aIvDC4nv1mUNLeMI@x1.local>
 <20250801104215.2ceaa19a@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250801104215.2ceaa19a@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On 8/1/25 10:42, Igor Mammedov wrote:
> looking at the code, it seems we are always hold BQL when setting
> exit_request.

While the BQL is taken, it is for other reasons (e.g. because of 
cpu->halt_cond).

In this case it's set and read from within the same thread so it's okay.

> it matches with similar pattern:
> 
>          /* Read cpu->exit_request before KVM_RUN reads run->immediate_exit.
>           * Matching barrier in kvm_eat_signals.
>           */
>          smp_rmb();
>                                                                                   
>          run_ret = kvm_vcpu_ioctl(cpu, KVM_RUN, 0);
> 
> to be on the safe side, this is preserving barrier that BQL has provided before
> I can drop it if it's not really needed.

That comment is wrong...  The actual pairing here is with cpu_exit(), 
though the logic of cpu_exit() is messed up and only fully works for 
TCG, and immediate_exit does not matter at all.  I'll clean it up and 
write a comment.

A correct ordering would be:

(a) store other flags that will be checked if cpu->exit_request is 1

(b) cpu_exit(): store-release cpu->exit_request

(c) cpu_interrupt(): store-release cpu->interrupt_request

- broadcast cpu->halt_cond if needed; right now it's done always in 
qemu_cpu_kick()

 >>> now you can release the BQL

(d) do the accelerator-specific kick (e.g. write icount_decr for TCG, 
pthread_kill for KVM, etc.)


The other side then does the checks in the opposite direction:

(d) the accelerator's execution loop exits thanks to the kick

(c) then check cpu->interrupt_request - any work that's needed here may 
take the BQL or not, and may set cpu->exit_request

(b) then check cpu->exit_request to see if it should do slow path work

(a) then (under the BQL) it possibly goes to sleep, waiting on 
cpu->halt_cond.

cpu->exit_request and cpu->interrupt_request are not a 
load-acquire/store-release pair right now, but it should be.  Probably 
everything is protected one way or the other by the BQL, but it's not clear.

I'll handle cpu->exit_request and leave cpu->interrupt_request to you. 
For the sake of this series, please do the following:

- contrarily to what I said in my earlier review, do introduce a 
cpu_test_interrupt() now and make it use a load-acquire.  There aren't 
many occurrences:

accel/tcg/cpu-exec.c:    if 
(unlikely(qatomic_read(&cpu->interrupt_request))) {
target/alpha/cpu.c:    return cs->interrupt_request & (CPU_INTERRUPT_HARD
target/arm/cpu.c:        && cs->interrupt_request &
target/arm/hvf/hvf.c:    if (cpu->interrupt_request & 
(CPU_INTERRUPT_HARD | CPU_INTERRUPT_FIQ)) {
target/avr/cpu.c:    return (cs->interrupt_request & (CPU_INTERRUPT_HARD 
| CPU_INTERRUPT_RESET))
target/hppa/cpu.c:    return cs->interrupt_request & (CPU_INTERRUPT_HARD 
| CPU_INTERRUPT_NMI);
target/i386/kvm/kvm.c:    if (cpu->interrupt_request & 
(CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
target/i386/kvm/kvm.c:    if (cpu->interrupt_request & 
(CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
target/i386/nvmm/nvmm-all.c:    if (cpu->interrupt_request & 
(CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
target/i386/whpx/whpx-all.c:        cpu->interrupt_request & 
(CPU_INTERRUPT_NMI | CPU_INTERRUPT_SMI)) {
target/i386/whpx/whpx-all.c:    if (cpu->interrupt_request & 
(CPU_INTERRUPT_INIT | CPU_INTERRUPT_TPR)) {
target/microblaze/cpu.c:    return cs->interrupt_request & 
(CPU_INTERRUPT_HARD | CPU_INTERRUPT_NMI);
target/openrisc/cpu.c:    return cs->interrupt_request & 
(CPU_INTERRUPT_HARD |
target/rx/cpu.c:    return cs->interrupt_request &

- in tcg_handle_interrupt and generic_handle_interrupt, change like this

     /* Pairs with load_acquire in cpu_test_interrupt().  */
     qatomic_store_release(&cpu->interrupt_request,
         cpu->interrupt_request | mask);

I'll take care of properly adding the store-release/load-acquire
for exit_request and removing the unnecessary memory barriers in kvm-all.c.

Paolo


>>
>> Thanks,
>>
>>> +    }
>>>   
>>> +    if (release_bql) {
>>>           bql_unlock();
>>>       }
>>>   }
>>> -- 
>>> 2.47.1
>>>    
>>
> 
> 
> 


