Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1588DCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOf-0004Ee-80; Sat, 30 Aug 2025 11:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us15A-0001xi-Fh
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us158-0000aj-8c
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RU656r1zopCHhkasbtOtRNl8eqkrSuEKMSPB6VC/E24=;
 b=SzZdXMs+tcRsxeQf5iEs19ruV/ckIxwpC4EvQji0GhucjpdiYgE+Jsszpx/tB9flwGpxAM
 78yRjZ9NWtCXRGMEhtPAoi60AyMMQ/vY19ID2dC+pAfRes1i6EF2NMQDC0NYXnszQWn3DG
 tB4qJwWGnny2Bw1xdwuWqBx+nOc5oRc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-27-4iMoxjDVP1q6kodJljr_Zg-1; Fri, 29 Aug 2025 11:31:59 -0400
X-MC-Unique: 4iMoxjDVP1q6kodJljr_Zg-1
X-Mimecast-MFC-AGG-ID: 4iMoxjDVP1q6kodJljr_Zg_1756481518
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ccd58af2bbso1162390f8f.0
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481517; x=1757086317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RU656r1zopCHhkasbtOtRNl8eqkrSuEKMSPB6VC/E24=;
 b=uiNXrTbspZmsYE1On6rdNfSdY6P6iWHCDK2s+pRagbU78Z+QMyxQp1HnSiWv29eAzx
 XTe7YWUgopbFot11F3yV++qJ1YxYBySemqoHiJ89d0LzvzmWT3+eP8hCLv7Wdl9l1Y+5
 c4JubLfvaiZpX695c6PxFeI7gmq0Ys5RqDTaQCtVR4ge4fmq/WcOD1yvyR/dryJAT0Bz
 QejtHKQsdjKXua1o2I5f8MjQWh82PR1gx1XVgvsTAyzr/ymskn7C29qxfMhFBgcdK3AJ
 RWDGVXjrV6zl0wIvESekqjViInoxRVfL/ETeSnXmZcZFonafE8vwI1du0r8ij4uIduct
 tPoQ==
X-Gm-Message-State: AOJu0YxoYSPmVFahveJskzvKLVrVTa/KeYjuZXmjcjqSXtypG6KZ/m51
 8Hn2nV/q3EdG6MLj5mR6tPmC7PUrDD7SN/zqtaHmYebOZ8cwZWfTpc3xMsTWuk9oyZSJZPgS+nD
 JebVSUNsU6x5jZ7lEvSElbU6zYbRgKZr5UzZXQusyIMmwlEC05bLSY2OvJgox9c/0FSZjcBnFnF
 zyOvbCegqA7AoxdgikEG9UCuLBn4EMaY65uyNxqUS/
X-Gm-Gg: ASbGncuQH91d5kVlRRHybRZ9yMxwi48Onv6upGNpjHgUbC6EKHRjlGU1C86+bE8OTXs
 QxmK8Dpa3mv9/FpUsNIvOTW5Ndo0ZTY8SEtICiZzhNBGG45gooCHu1tEBY1iMdT2speuuCgqI2f
 9WEtHO+xGhzbU8Vbak0L0lxKEGxXKVp21CgJNlPHwbRNiNTOeBIWvFo4YKgxJtdnt16/XPNyIL5
 F6btehzCoU+FfC2XpyTid/m51PKxaoB3CkrGRfLJNV2Ur6ImhHlTGrj1lSOelXYkq9fYKbtW7dz
 oSx/M/mIIh9kbNCXtCrPtyiUefFDC59YAbf6pClfxAWzUlYhfjxNlo8+wvL2SABlvsXZCwgscsu
 6AX88j40SkfJv8fQ+ZT7/QaPffF9wykR4XF8tsSfL9l0=
X-Received: by 2002:a05:6000:2f86:b0:3c2:95c8:b71a with SMTP id
 ffacd0b85a97d-3cbb15ca0a0mr11998798f8f.5.1756481516948; 
 Fri, 29 Aug 2025 08:31:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFj24O12qFLqJew2DlCZx1qddZf6WrHJ+phrvUbezL+awgZqH+ttarVp/je5O8qWqu1xFwJCA==
X-Received: by 2002:a05:6000:2f86:b0:3c2:95c8:b71a with SMTP id
 ffacd0b85a97d-3cbb15ca0a0mr11998759f8f.5.1756481516470; 
 Fri, 29 Aug 2025 08:31:56 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9431sm3756297f8f.44.2025.08.29.08.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 16/18] cpus: clear exit_request in qemu_wait_io_event
Date: Fri, 29 Aug 2025 17:31:13 +0200
Message-ID: <20250829153115.1590048-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Make the code common to all accelerators: after seeing cpu->exit_request
set to true, accelerator code needs to reach qemu_wait_io_event_common().

So for the common cases where they use qemu_wait_io_event(), go ahead and
clear it in there.  Note that the cheap qatomic_set() is enough because
at this point the thread has taken the BQL; qatomic_set_mb() is not needed.
In particular, this is the ordering of the communication between
I/O and vCPU threads is always the same.

In the I/O thread:

(a) store other memory locations that will be checked if cpu->exit_request
    or cpu->interrupt_request is 1 (for example cpu->stop or cpu->work_list
    for cpu->exit_request)

(b) cpu_exit(): store-release cpu->exit_request, or
(b) cpu_interrupt(): store-release cpu->interrupt_request

>>> at this point, cpu->halt_cond is broadcast and the BQL released

(c) do the accelerator-specific kick (e.g. write icount_decr for TCG,
    pthread_kill for KVM, etc.)

In the vCPU thread instead the opposite order is respected:

(c) the accelerator's execution loop exits thanks to the kick

(b) then the inner execution loop checks cpu->interrupt_request
    and cpu->exit_request.  If needed cpu->interrupt_request is
    converted into cpu->exit_request when work is needed outside
    the execution loop.

(a) then the other memory locations are checked.  Some may need to
    be read under the BQL, but the vCPU thread may also take other
    locks (e.g. for queued work items) or none at all.

qatomic_set_mb() would only be needed if the halt sleep was done
outside the BQL (though in that case, cpu->exit_request probably
would be replaced by a QemuEvent or something like that).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c          | 2 --
 accel/tcg/cpu-exec.c         | 1 -
 accel/tcg/tcg-accel-ops-rr.c | 9 +++++++--
 accel/tcg/tcg-accel-ops.c    | 2 --
 accel/tcg/user-exec.c        | 1 +
 system/cpus.c                | 1 +
 target/i386/nvmm/nvmm-all.c  | 2 --
 target/i386/whpx/whpx-all.c  | 2 --
 8 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index e4167d94b4f..d13156bee87 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -3155,7 +3155,6 @@ int kvm_cpu_exec(CPUState *cpu)
     trace_kvm_cpu_exec();
 
     if (kvm_arch_process_async_events(cpu)) {
-        qatomic_set(&cpu->exit_request, 0);
         return EXCP_HLT;
     }
 
@@ -3345,7 +3344,6 @@ int kvm_cpu_exec(CPUState *cpu)
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
-    qatomic_set(&cpu->exit_request, 0);
     return ret;
 }
 
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3ae545e888f..ad94f96b252 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -872,7 +872,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      * The corresponding store-release is in cpu_exit.
      */
     if (unlikely(qatomic_load_acquire(&cpu->exit_request)) || icount_exit_request(cpu)) {
-        qatomic_set(&cpu->exit_request, 0);
         if (cpu->exception_index == -1) {
             cpu->exception_index = EXCP_INTERRUPT;
         }
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 610292d3bac..e9d291dc391 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -286,8 +286,13 @@ static void *rr_cpu_thread_fn(void *arg)
         /* Does not need a memory barrier because a spurious wakeup is okay.  */
         qatomic_set(&rr_current_cpu, NULL);
 
-        if (cpu && qatomic_read(&cpu->exit_request)) {
-            qatomic_set_mb(&cpu->exit_request, 0);
+        if (cpu) {
+            /*
+             * This could even reset exit_request for all CPUs, but in practice
+             * races between CPU exits and changes to "cpu" are so rare that
+             * there's no advantage in doing so.
+             */
+            qatomic_set(&cpu->exit_request, false);
         }
 
         if (icount_enabled() && all_cpu_threads_idle()) {
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1f662a9c745..3bd98005042 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -82,8 +82,6 @@ int tcg_cpu_exec(CPUState *cpu)
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
 
-    qatomic_set_mb(&cpu->exit_request, 0);
-
     return ret;
 }
 
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 81906d2e033..8f4f049b924 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -54,6 +54,7 @@ void qemu_cpu_kick(CPUState *cpu)
 
 void qemu_wait_io_event(CPUState *cpu)
 {
+    qatomic_set(&cpu->exit_request, false);
     process_queued_cpu_work(cpu);
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index bb13942cbb7..f989d9938b6 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -463,6 +463,7 @@ void qemu_wait_io_event(CPUState *cpu)
 {
     bool slept = false;
 
+    qatomic_set(&cpu->exit_request, false);
     while (cpu_thread_is_idle(cpu)) {
         if (!slept) {
             slept = true;
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 7e36c42fbb4..ed424251673 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -817,8 +817,6 @@ nvmm_vcpu_loop(CPUState *cpu)
     cpu_exec_end(cpu);
     bql_lock();
 
-    qatomic_set(&cpu->exit_request, false);
-
     return ret < 0;
 }
 
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 00fb7e23100..2a85168ed51 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2050,8 +2050,6 @@ static int whpx_vcpu_run(CPUState *cpu)
         whpx_last_vcpu_stopping(cpu);
     }
 
-    qatomic_set(&cpu->exit_request, false);
-
     return ret < 0;
 }
 
-- 
2.51.0


