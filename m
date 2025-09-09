Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0704FCAC58D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 12:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxw3-0006Hz-M0; Tue, 09 Sep 2025 08:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lifei.shirley@bytedance.com>)
 id 1uvs4K-0005U4-Mn
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 02:43:09 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lifei.shirley@bytedance.com>)
 id 1uvs4F-00062U-Od
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 02:43:08 -0400
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-7704f3c46ceso4218961b3a.2
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 23:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1757400175; x=1758004975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/GvIWSk/3gbYKeUtKA9FXFsOEEQ7hBCXqeb+YlYiqlM=;
 b=cllcsxLYXe7Z3Uxl8eJNXVU6fcBYSuBnL5WhnBsMY/DgjXjILjejf+jy6CkUQvatgq
 g3UAzk1VaQkXAhwyANwUAnktAJwWDRoDyKcMCCNtn/MS3YWme0X5B86we6uv/uPCzBiX
 8Oz98xNCUyKDzTyLn9B9dtg9o0ne2eD+/PX+yVrxwRcLxB2mBrzgPZMdVHkWpwnGTVNv
 DmKbi37BQZnHSvl3n6Lg2kM6vhEOriCRfCfRNNb3GoaL8ftUshAYKuPhFWT4/xHm8L92
 rDRQnba99Y2ZPb7VPOWm0pirk8aY6Nvi/Vi8Vnt+lvmbLKUg7wyTDn6pKHSDzNVDx2Qh
 uPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757400175; x=1758004975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/GvIWSk/3gbYKeUtKA9FXFsOEEQ7hBCXqeb+YlYiqlM=;
 b=uTpWgUTGJv4xMq7/fmwSHNcYW77tRcUS0Iar+6D234GnVHtpL2iSFhjkCkjyxghF4i
 32TuYI3XDZikNoN6jdzVEnyWWY4c8jaZocXYB+3lI/NNI4LOna7bL+uW9WiT8ChUbn9I
 TvaKPliVO4/6f+ewXoA5+cmidBdr+jcPmH1HyUix+w7jAwv5Z6e+zgJrmpWSY67SqruM
 17mw6S4Rc0DtAc3cbD17ohmHuHxpfnBs7/V9IyQQiK1Bx3B6jgUUxHCUPS5r8zdG73Sd
 BF65yfgR1RQNCOvFszwz2qHs0EKKeA1ImVP141OC7+qOo8O5Tlz2nVPZ0DKrrsaPS8Wm
 0qHg==
X-Gm-Message-State: AOJu0Yz0Y7tePvLdfCsW4nTorJkaEjzCiS9h2T9kevPRl2dZaGJds1gx
 h0u/HukqSDJgyjggQfXsrLscCR8rfovfgv5ChvW7GeGKEXIaxWrTAwJtGaYhUh6jLRE=
X-Gm-Gg: ASbGnctO1Zxqlp3qtD40Q17/cW8nOMIpvcR7wu2CnsEab6MqL+GHf7Jqd4FXgqQy+i1
 zPoP14z9mmiJUaJ8RRRF54jOWzMoD1tndJuceuOVaXRHLXRC5sChAbLXl1FrPOFpw6xQRWoOPwU
 HwUheRChQTB4csxM+ogsUyxeZZRiaKznSYl3aKymGkxlGWdThKNJRm21GP/RLTQT5q7B3t63kib
 a2QEUIOjHyON6ArgqTCP57jqPGcEH9yZ5JKOAaPPfUKYDGXDYk+QFo882qyoowth3nc3rDVmlMk
 6g3z/VH5Eh8FTmGxCRnS4YkzL314WtGwtdyv6qJsYOoNBmIthtj9Tz0SSYvzBZuHskAhu+ieSsA
 EIsCSm5S1/jlaheWWLMnDcxLw1WPa72kUl6Y/if+n3G+Lhmt/rSbFRyp0QWnW+prnTzQew8o=
X-Google-Smtp-Source: AGHT+IGYt5vOyFOt20vZvKtxMhw48jTWh2xHSOtkVEUQByr0A4T6BQmilfHwXnXK5Ks1EXc1KJBYgA==
X-Received: by 2002:a05:6a20:9183:b0:246:9192:2789 with SMTP id
 adf61e73a8af0-2534441fa83mr15956172637.49.1757400175306; 
 Mon, 08 Sep 2025 23:42:55 -0700 (PDT)
Received: from [10.4.104.249] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-774662905bcsm990963b3a.51.2025.09.08.23.42.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 23:42:54 -0700 (PDT)
Message-ID: <f6706599-0b8e-44bb-9f53-4e6a4db24b6d@bytedance.com>
Date: Tue, 9 Sep 2025 14:42:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: x86: Restrict writeback of SMI VCPU state
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org
References: <20250909063327.14263-1-lifei.shirley@bytedance.com>
Content-Language: en-US
From: Fei Li <lifei.shirley@bytedance.com>
In-Reply-To: <20250909063327.14263-1-lifei.shirley@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=lifei.shirley@bytedance.com; helo=mail-pf1-x442.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 08:58:43 -0400
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

Hi all,
The previous context is from one KVM topic: 
https://lore-kernel.gnuweeb.org/lkml/f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com/T/#m80f426b55e272f9b257e2d7f6ff4902b7eb60178

Please help to review this patch, thanks for your time.

Have a nice day, thanks
Fei


