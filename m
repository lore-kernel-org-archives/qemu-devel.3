Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03944CAC5B8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v29qe-0002f7-Qw; Fri, 26 Sep 2025 10:55:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lifei.shirley@bytedance.com>)
 id 1v29qX-0002da-MK
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:54:55 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lifei.shirley@bytedance.com>)
 id 1v29qN-0006Xl-2L
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:54:53 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b556284db11so2208460a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 07:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1758898450; x=1759503250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fQ3d5ngg1DfO7r8b2XH43YDUg6JuZOy/Y/EgRNcVGic=;
 b=Fnc8hxYORnlPoepOPJXNxTb5LpqkZN88E+1HbLkojFdPnP2phuAbnbU9LXb9koGvr0
 HxWOErMdYwoVDD1kWH4X0IWdC5J2hIh9xLmRc9p/26NRrLR2y0peG1B/WUTRyf7JdNyq
 8zt7Nd22EMHcyjfIwFGc4TdsqfJOlO/L2LK5gXiRCmTQHtGk75zWPAE0P7BD6lz94FgF
 6QawAMKgLi637xdW/r4hrlfPOyL0+DBLalR3FcpBFutTIEQ5xLzNj+5pteD3/HIteXOE
 JbF7uPAg2jtB9ie5qLdcmQwKJk1PxcDfw4YZTGiUSDvsNGNYCtZZFXEtp8HDQE23d9UT
 ZpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758898450; x=1759503250;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fQ3d5ngg1DfO7r8b2XH43YDUg6JuZOy/Y/EgRNcVGic=;
 b=GSodDbWH08ud2BoCP681/KZoENmuUXmODrqmO+j/eHlS4XC6WuJ0iDnSx22dirZjHW
 FJAOUiVyyfLmmUEyTpdfg0ryjIg8FzUCMNoSb1gQIdeczPaFCTMOCOsjAaFNB7Cc7UbO
 ytULlORddFUlf6/YPn4oi2bFQZJo40T/pI7IP4PAF+P7fkdzrIol+QDIPyQs2L+9VC94
 WdDWa1gshb9JKnYOXIQq1XJOcKtsQz+DgtnZK2UtpKjC6cjCi1GVAVydTqfYS+117T4A
 JCZHNxLGFtGMIDdOha0NCqaOUbRBlZe8wf3edJfxpnyB8wrshBXSwaaxAJirG4WdkfgB
 dO2A==
X-Gm-Message-State: AOJu0YwzUkpA7xa1vup99RS5bRvydXyX+b61S8kryx71ShXOulbCq0xY
 s1i5TrJRuR1PctfRAZOByonW354JcbH7tWhbkBY/hdjGqpG9dHCTGffSpPId2yIWrgQ=
X-Gm-Gg: ASbGncuTcLcC4zUNu+N0etnkM1DAWh9owqgmGjNMrf01Osj0wGTmGIEqUbiQxmmk1Gv
 vrFm6P34Tpjfh4rc5KY3wqXCweJW0SoUgrZ7aZKUai0kC0Ee54m3EiwfyuglNKktrCPes8MWpJP
 +rsEoMrC5Ul+kkrTF3CI6CmFGgBWpJELhV0VpB0b5rbHPz3ITN2ueinOBihjgCMcdiKTA4G3sOa
 pE1RfJb0SUR6pGKyGDm37F9m8NV0kLyDLSl5IPdvU5Bfdy79IWPcdm2k9CCGiXRoS1F87IX7DWM
 riBAZapFiQ2oRMVM742ezeLi4On2kv+dYc4DSInGjeZy9/UPFEOnuDHJGUmJzDML6WcIEutVOqA
 M1CgK59pJ1YvSX06VqVFbfEgy6mM8qpDOl5qvh78xqtgQ+AkOI4S7rHhY0w==
X-Google-Smtp-Source: AGHT+IEM5gfpTFeny4JGgiwPmQJtjR802N61GuO0pjn187ffL/azsDT3fsFt/ZGKNuDaQhw0bWZGdw==
X-Received: by 2002:a17:903:1a2b:b0:24c:ea17:e322 with SMTP id
 d9443c01a7336-27ed49df28dmr87377845ad.3.1758898450221; 
 Fri, 26 Sep 2025 07:54:10 -0700 (PDT)
Received: from [10.254.228.139] ([139.177.225.234])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed69bc295sm56361985ad.123.2025.09.26.07.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 07:54:09 -0700 (PDT)
Message-ID: <5db494c6-c8dd-4073-bea0-5a62fce170e9@bytedance.com>
Date: Fri, 26 Sep 2025 22:54:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Fei Li <lifei.shirley@bytedance.com>
Subject: Re: [PATCH] KVM: x86: Restrict writeback of SMI VCPU state
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 kvm@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel@nongnu.org
References: <20250909063327.14263-1-lifei.shirley@bytedance.com>
Content-Language: en-US
In-Reply-To: <20250909063327.14263-1-lifei.shirley@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=lifei.shirley@bytedance.com; helo=mail-pg1-x530.google.com
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


Dear maintainers,

Could you please help to review the patch [PATCH] KVM: x86: Restrict 
writeback of SMI VCPU state? This fixes a race condition causing VM hang 
when frequently running `info registers -a` via HMP during VM startup. 
The issue occurs because unrestricted SMI state writeback conflicts with 
vCPU initialization sequences.

It would be very appreciated for us to know if this patch properly
resolve the race condition, and if validated, we would like to apply it 
to our production environment. Let me know if further details are needed. :)

Best regards, and thanks again!
Fei

On 9/9/25 2:33 PM, Fei Li wrote:
> Recently, we meet a SMI race bug triggered by one monitor tool in our
> production environment. This monitor executes 'info registers -a' hmp
> at a fixed frequency, even during VM startup process, which makes
> some AP stay in KVM_MP_STATE_UNINITIALIZED forever, thus VM hangs.
> 
> The complete calling processes for the SMI race are as follows:
> 
> //thread1                      //thread2               //thread3
> `info registers -a` hmp [1]    AP(vcpu1) thread [2]    BSP(vcpu0) send INIT/SIPI [3]
> 
>                                 [2]
>                                 KVM: KVM_RUN and then
>                                      schedule() in kvm_vcpu_block() loop
> 
> [1]
> for each cpu: cpu_synchronize_state
> if !qemu_thread_is_self()
> 1. insert to cpu->work_list, and handle asynchronously
> 2. then kick the AP(vcpu1) by sending SIG_IPI/SIGUSR1 signal
> 
>                                 [2]
>                                 KVM: checks signal_pending, breaks loop and returns -EINTR
>                                 Qemu: break kvm_cpu_exec loop, run
>                                       1. qemu_wait_io_event()
>                                       => process_queued_cpu_work => cpu->work_list.func()
>                                          e.i. do_kvm_cpu_synchronize_state() callback
>                                          => kvm_arch_get_registers
>                                             => kvm_get_mp_state /* KVM: get_mpstate also calls
>                                                kvm_apic_accept_events() to handle INIT and SIPI */
>                                       => cpu->vcpu_dirty = true;
>                                       // end of qemu_wait_io_event
> 
>                                                         [3]
>                                                         SeaBIOS: BSP enters non-root mode and runs reset_vector() in SeaBIOS.
>                                                                  send INIT and then SIPI by writing APIC_ICR during smp_scan
>                                                         KVM: BSP(vcpu0) exits, then => handle_apic_write
>                                                              => kvm_lapic_reg_write => kvm_apic_send_ipi to all APs
>                                                              => for each AP: __apic_accept_irq, e.g. for AP(vcpu1)
>                                                              ==> case APIC_DM_INIT: apic->pending_events = (1UL << KVM_APIC_INIT)
>                                                                  (not kick the AP yet)
>                                                              ==> case APIC_DM_STARTUP: set_bit(KVM_APIC_SIPI, &apic->pending_events)
>                                                                  (not kick the AP yet)
> 
>                                 [2]
>                                 Qemu continue:
>                                      2. kvm_cpu_exec()
>                                      => if (cpu->vcpu_dirty):
>                                         => kvm_arch_put_registers
>                                            => kvm_put_vcpu_events
>                                 KVM: kvm_vcpu_ioctl_x86_set_vcpu_events
>                                      => clear_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
>                                         e.i. pending_events changes from 11b to 10b
>                                        // end of kvm_vcpu_ioctl_x86_set_vcpu_events
>                                 Qemu: => after put_registers, cpu->vcpu_dirty = false;
>                                       => kvm_vcpu_ioctl(cpu, KVM_RUN, 0)
>                                 KVM: KVM_RUN
>                                      => schedule() in kvm_vcpu_block() until Qemu's next SIG_IPI/SIGUSR1 signal
>                                      /* But AP(vcpu1)'s mp_state will never change from KVM_MP_STATE_UNINITIALIZED
>                                        to KVM_MP_STATE_INIT_RECEIVED, even then to KVM_MP_STATE_RUNNABLE without
>                                        handling INIT inside kvm_apic_accept_events(), considering BSP will never
>                                        send INIT/SIPI again during smp_scan. Then AP(vcpu1) will never enter
>                                        non-root mode */
> 
>                                                         [3]
>                                                         SeaBIOS: waits CountCPUs == expected_cpus_count and loops forever
>                                                                  e.i. the AP(vcpu1) stays: EIP=0000fff0 && CS =f000 ffff0000
>                                                                  and BSP(vcpu0) appears 100% utilized as it is in a while loop.
> 
> To fix this, avoid clobbering SMI when not putting "reset" state, just
> like NMI abd SIPI does.
> 
> Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
> ---
>   target/i386/kvm/kvm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 369626f8c8..598661799a 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -5056,7 +5056,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
>   
>       events.sipi_vector = env->sipi_vector;
>   
> -    if (has_msr_smbase) {
> +    if (has_msr_smbase && level >= KVM_PUT_RESET_STATE) {
>           events.flags |= KVM_VCPUEVENT_VALID_SMM;
>           events.smi.smm = !!(env->hflags & HF_SMM_MASK);
>           events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);


