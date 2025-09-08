Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF43CAC583
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:17:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsn-00022y-9j; Mon, 08 Sep 2025 06:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsY-0001uK-NR
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsR-00011K-A1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326410;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qlij/+xB1jeZ/DQJ1zSRVc1BKfDXu58VvWt1lqi6rrQ=;
 b=ALBNyI62rwLM/NN00/OGqlS9aJtL8c1fFz5IrVPKSuwtR/QniFkcxZezbQ6ftXS+rYpSrF
 NhHufvxuw0ykBybykV9Hu3I9SDS/eLfU3vlRB/Ayo8k6CMuXrUJ4NBXeC5pwThuAJS4+1X
 k/LPUVId4D/GAxgpE0AEmMyNKoSo4Mw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-7iAf9qK6NHK5UAJ47bGXtg-1; Mon, 08 Sep 2025 06:13:29 -0400
X-MC-Unique: 7iAf9qK6NHK5UAJ47bGXtg-1
X-Mimecast-MFC-AGG-ID: 7iAf9qK6NHK5UAJ47bGXtg_1757326408
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de13167aaso12610415e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326407; x=1757931207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qlij/+xB1jeZ/DQJ1zSRVc1BKfDXu58VvWt1lqi6rrQ=;
 b=PxF+HFkkoQp5eZUq8AOTDcbuj2RE4hDwoCE4vXtx3QlVAiVOgIvtTKMiQCzQVU1AMd
 Rx3c4dy2gr+rDZWOruhcG8p7ZWa7rfsXirm9Tt3SyJ0bXuU/YcpwL8TZkO0gMCjw+tNy
 7D3Y6VEzt213dqIix2RfcPnTRFDq1nSQ6qf8thUpVWi73PnkStjU77Ba8/UJdxwyWK0x
 JI2GoTuOwEuzWolntddPKeDO38stdP+m8be6RSSL/M611yDzBJu0kIOhsAVp8XunpBMS
 ewXlvTLWe4YUtD/MNBax8VgWUl+UCEqZ6ckxmqAkf+kl3Xz3sXvVJcVtpThIClciHbnR
 5JFg==
X-Gm-Message-State: AOJu0Yy0RZeLtDdI4/4AIuOaeUmlYkirye6mXGXfxTouY5QzdrdyziOE
 8GOTE2efX+MlC6rhcYgZDOlE2h7t1o9jeV071SXdsyz8SKwHkdAsfS1zkeJJrTvcI25vfIGotFo
 JWDy++6rtzraAdUMHa603fyO/WEkbfSkMWQw45reiQ1XGxsyd6PTRssYO3rxIcv5E72UAnndYxR
 ZBQIuT/r0lGNtA3aEbToX9NTlaodvmOX5Ox74eiBtf
X-Gm-Gg: ASbGncs0KIoo1xqGrHFLzUJQrPYGdnbwjDfpPvqiWNK+iOrGix76yEiS7vPv845fikw
 MWrbQImDDxuwQE100y4Ti0VHD4zkgPI7d6O+SUgCDQqhTtI0iB1L80gL8VxJIcD2ue3coZnTER4
 eg0vIB0WczW4nr+MkVYGWY8j+kKN+q0XVakjdE/EqbX0DHO/UBHxurtd4+2GaJaDDB1rfnYuZOb
 XkozVSUpSrBxBs0o4M4E1ee5s4AcfFy3gxH0LL7emh/UBJWMmQeD4DgFSN9W8wx7XLxSCDgcIuI
 9Y1MJtDJyJlo/KVgmtWspOLC6b+HmKOqpiAWzyrMHP2uPErgY0JQynsgeXeb8q3sg10fYJv09JC
 CLOkQKtbDh6R79tCkDVuIZ3abcwd60ZUgRcGyQRylfNY=
X-Received: by 2002:a05:600c:1991:b0:45b:5f3d:aa3d with SMTP id
 5b1f17b1804b1-45dddeee57cmr52195915e9.21.1757326406996; 
 Mon, 08 Sep 2025 03:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELSyrvkCLH15zja2lRmA1Dfj1AslSMpN7NT6W5hl3EvNHL9VIGpIwXDWSS+D0DPW6lYdCnvg==
X-Received: by 2002:a05:600c:1991:b0:45b:5f3d:aa3d with SMTP id
 5b1f17b1804b1-45dddeee57cmr52195575e9.21.1757326406522; 
 Mon, 08 Sep 2025 03:13:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd5098292sm155467125e9.1.2025.09.08.03.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 17/19] cpus: clear exit_request in qemu_process_cpu_events
Date: Mon,  8 Sep 2025 12:12:39 +0200
Message-ID: <20250908101241.2110068-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
set to true, accelerator code needs to reach qemu_process_cpu_events_common().

So for the common cases where they use qemu_process_cpu_events(), go ahead and
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

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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
index 813b313859a..7dbdba7b514 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -293,8 +293,13 @@ static void *rr_cpu_thread_fn(void *arg)
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
index 65f5da6c506..916f18754f6 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -54,6 +54,7 @@ void qemu_cpu_kick(CPUState *cpu)
 
 void qemu_process_cpu_events(CPUState *cpu)
 {
+    qatomic_set(&cpu->exit_request, false);
     process_queued_cpu_work(cpu);
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index fd804e07327..aa7bfcf56e5 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -463,6 +463,7 @@ void qemu_process_cpu_events(CPUState *cpu)
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


