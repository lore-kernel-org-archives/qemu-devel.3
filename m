Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B22ACA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvxw5-0006BG-Si; Tue, 09 Sep 2025 08:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lifei.shirley@bytedance.com>)
 id 1uvrvX-0003ne-KN
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 02:34:03 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lifei.shirley@bytedance.com>)
 id 1uvrvQ-0004uR-PT
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 02:34:03 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77460a64848so653340b3a.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 23:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1757399622; x=1758004422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KlYPumXZ2GNPPhioX83eHuWYdzwsk2NeU2T6+Hb+h+o=;
 b=hN+5z20g8QInG14gp2lJ5e+f6QUebCgNUyw65Ydse9snreS2NPC89JJfaoMrPtciqA
 Ciz7TaJ2ALdMMM2XNW6G0BPRJuXA9twJPaHA8beBL9uU2fYtbaZhnYU5BpeyTorbPCkd
 bX5uzWj0QGvPkxCg1cZA9OIwY5E9F+dpiQDGFq/wv3t1fd1j6vXee46WtG0Gp4Bq586K
 9zPBr3NzjlGAUgPR/BWK/3wubvIaMM863IDtD5SIQEAPFupK7rR7kM5EjdjYhfw6WOGX
 /LvofTHWddlRkRcMyxIZCfb9/xZqp/E/kZnEtVHgC5vxd0DpQF1oh18G2qaMZlyGySKk
 rBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757399622; x=1758004422;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KlYPumXZ2GNPPhioX83eHuWYdzwsk2NeU2T6+Hb+h+o=;
 b=D7ZoqjXjJoQRjgYpEgt3YFJmYkeLW1TZuXS41/JINLzXPVnmANdXP0MV9kOsgY8R8W
 mCwZxNxuMOhd02+WA67RiLLq9meG0VT0kBiYyCN8oTKI4XNuT3X6DSlseRYioNHxqQFO
 NjlsIyk/nBDB9f1IHV6voh1MMYzr/f9ArVL5ha/Eht622P1PTjHsaAeUMajLXfZvmSAp
 m4EI9FUZ1J5AhbUl5wgVjjsseri6wvSEZ6bzAhfEpEQtdHm3/cYTpWauV53yCMTpcSHS
 xDZXxdYFSpjXhvyuKVDU5oKrH2ZyMZZf04Xt300egukUH2d3oQL39T3wlIxgkiERLzzB
 0Ezg==
X-Gm-Message-State: AOJu0YzqbLrHV+JTyTxIsffgD72aWRstibQpYBVhF/kr8k14mRkBNIIV
 YZHgHAP9x7w6jbRwxILRU2djbTC3gSoPYN6zBduKYyxbAiI7tn7yJTkhVbAr2olrV9Q=
X-Gm-Gg: ASbGncugzJ3/29o/Gls5l1leC0VIViLokAt2N/DQKOHu3K/JvXqqzzlwcXsWr8vzoiK
 7v/CoKDMCWefUEJ5Lj8jVzHMA9rrZaLhfXVkXdGG9kNZMoyVF/uTTj2EedYJ/zTvQrbcYlyIvbZ
 4ZSSpA+AZqvNxDmXntT8YowYoLAuVNlvUyJGkCxOl7pBqVziWzqYc9tA/wmHJrG29B2/w+83zv4
 Ha8LUvWrvJ7iPylbS6g3WwrtRO52wi8Y6NNrZqsrjbwk7fwoNTxzBI5RNYgVGzfQcfyiBU1g/jZ
 8CXZWM0iW+c8giZ7aCDbFs78uGH178aAfMi0+UlGDamFpS4sJi2OsPpGx5dBjuBoL0YykaOW3++
 xZHKhAkKoEBbGs+nV6Jyc0zzJitIe4km7QT03UqR8h2ZPR6Ngcqm77mRX4BjXvg==
X-Google-Smtp-Source: AGHT+IG5VjYQNMdw/MpShOmZhgIpumMJ2z8imKGQ/mFwUjSsWb6PA2uPoGsX+egsKKVRJhRC4n1lfQ==
X-Received: by 2002:a05:6a20:9392:b0:24e:2cee:9592 with SMTP id
 adf61e73a8af0-2534547a6c6mr15549901637.46.1757399621653; 
 Mon, 08 Sep 2025 23:33:41 -0700 (PDT)
Received: from localhost.localdomain ([61.213.176.12])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b5235c0c3e2sm4213501a12.20.2025.09.08.23.33.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Sep 2025 23:33:41 -0700 (PDT)
From: Fei Li <lifei.shirley@bytedance.com>
To: pbonzini@redhat.com, mtosatti@redhat.com, seanjc@google.com,
 kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org,
	Fei Li <lifei.shirley@bytedance.com>
Subject: [PATCH] KVM: x86: Restrict writeback of SMI VCPU state
Date: Tue,  9 Sep 2025 14:33:27 +0800
Message-Id: <20250909063327.14263-1-lifei.shirley@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=lifei.shirley@bytedance.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Sep 2025 08:58:42 -0400
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

Recently, we meet a SMI race bug triggered by one monitor tool in our
production environment. This monitor executes 'info registers -a' hmp
at a fixed frequency, even during VM startup process, which makes
some AP stay in KVM_MP_STATE_UNINITIALIZED forever, thus VM hangs.

The complete calling processes for the SMI race are as follows:

//thread1                      //thread2               //thread3
`info registers -a` hmp [1]    AP(vcpu1) thread [2]    BSP(vcpu0) send INIT/SIPI [3]

                               [2]
                               KVM: KVM_RUN and then
                                    schedule() in kvm_vcpu_block() loop

[1]
for each cpu: cpu_synchronize_state
if !qemu_thread_is_self()
1. insert to cpu->work_list, and handle asynchronously
2. then kick the AP(vcpu1) by sending SIG_IPI/SIGUSR1 signal

                               [2]
                               KVM: checks signal_pending, breaks loop and returns -EINTR
                               Qemu: break kvm_cpu_exec loop, run
                                     1. qemu_wait_io_event()
                                     => process_queued_cpu_work => cpu->work_list.func()
                                        e.i. do_kvm_cpu_synchronize_state() callback
                                        => kvm_arch_get_registers
                                           => kvm_get_mp_state /* KVM: get_mpstate also calls
                                              kvm_apic_accept_events() to handle INIT and SIPI */
                                     => cpu->vcpu_dirty = true;
                                     // end of qemu_wait_io_event

                                                       [3]
                                                       SeaBIOS: BSP enters non-root mode and runs reset_vector() in SeaBIOS.
                                                                send INIT and then SIPI by writing APIC_ICR during smp_scan
                                                       KVM: BSP(vcpu0) exits, then => handle_apic_write
                                                            => kvm_lapic_reg_write => kvm_apic_send_ipi to all APs
                                                            => for each AP: __apic_accept_irq, e.g. for AP(vcpu1)
                                                            ==> case APIC_DM_INIT: apic->pending_events = (1UL << KVM_APIC_INIT)
                                                                (not kick the AP yet)
                                                            ==> case APIC_DM_STARTUP: set_bit(KVM_APIC_SIPI, &apic->pending_events)
                                                                (not kick the AP yet)

                               [2]
                               Qemu continue:
                                    2. kvm_cpu_exec()
                                    => if (cpu->vcpu_dirty):
                                       => kvm_arch_put_registers
                                          => kvm_put_vcpu_events
                               KVM: kvm_vcpu_ioctl_x86_set_vcpu_events
                                    => clear_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
                                       e.i. pending_events changes from 11b to 10b
                                      // end of kvm_vcpu_ioctl_x86_set_vcpu_events
                               Qemu: => after put_registers, cpu->vcpu_dirty = false;
                                     => kvm_vcpu_ioctl(cpu, KVM_RUN, 0)
                               KVM: KVM_RUN
                                    => schedule() in kvm_vcpu_block() until Qemu's next SIG_IPI/SIGUSR1 signal
                                    /* But AP(vcpu1)'s mp_state will never change from KVM_MP_STATE_UNINITIALIZED
                                      to KVM_MP_STATE_INIT_RECEIVED, even then to KVM_MP_STATE_RUNNABLE without
                                      handling INIT inside kvm_apic_accept_events(), considering BSP will never
                                      send INIT/SIPI again during smp_scan. Then AP(vcpu1) will never enter
                                      non-root mode */

                                                       [3]
                                                       SeaBIOS: waits CountCPUs == expected_cpus_count and loops forever
                                                                e.i. the AP(vcpu1) stays: EIP=0000fff0 && CS =f000 ffff0000
                                                                and BSP(vcpu0) appears 100% utilized as it is in a while loop.

To fix this, avoid clobbering SMI when not putting "reset" state, just
like NMI abd SIPI does.

Signed-off-by: Fei Li <lifei.shirley@bytedance.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..598661799a 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5056,7 +5056,7 @@ static int kvm_put_vcpu_events(X86CPU *cpu, int level)
 
     events.sipi_vector = env->sipi_vector;
 
-    if (has_msr_smbase) {
+    if (has_msr_smbase && level >= KVM_PUT_RESET_STATE) {
         events.flags |= KVM_VCPUEVENT_VALID_SMM;
         events.smi.smm = !!(env->hflags & HF_SMM_MASK);
         events.smi.smm_inside_nmi = !!(env->hflags2 & HF2_SMM_INSIDE_NMI_MASK);
-- 
2.39.2 (Apple Git-143)


