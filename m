Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F351C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 17:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSfMM-0004Ag-C8; Fri, 20 Jun 2025 13:17:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKn-0001dX-Ml
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:27 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfKl-0004Uv-H2
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:15:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45363645a8eso10194355e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750439721; x=1751044521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThJ9gD63sooyYfC0TwQMdGR/95qoYxG7tdS8NDTZY4I=;
 b=XFlb+S8rKhVj4IVRswDYEbMJny4gGdUxXLnmiQKJfIgeBR0y7wMeDPZOsco4lUsB/k
 dbvxzAYfdmIoyWxn6nNmOLF0CdMDXkYzSB4rSkE6mFshe+nSoFCzo3GxdYpynhAfzHFj
 MoQwWOPICWOdO7pgrP3Fts91ikMY9eLYvzDwxCpmcH3Dhpk89Xu7zQ/aa5rADaNKkXha
 zgWE6RJlRW0MyDMY/Hk+4h/ZCaliZdedltbIFaNL4vOL04ErByToxqFxxSXxcOs4V9SU
 hGFg0fjI+pWZf8E0WWKlDQquvrgV0h7trJHytIWhAdcDNc4HMLT0G2Ay4g/gYSz08CU4
 bLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750439721; x=1751044521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThJ9gD63sooyYfC0TwQMdGR/95qoYxG7tdS8NDTZY4I=;
 b=ht3LkacLkxi67akFmdt/6h+BCaWbzFXQ+0pZxVXebF1QTsaZ6pHR1z1CJElNeSBg2K
 yyFNN9/9A2HQcZ9+cNOZJUMP5T0UjuKp1IR7UFL3GvyRQIW1Wj/1vEc8+s0P/pHFl9Xw
 ld7qQeGNmHQ8NjxI6pV0NWWxB3DEdhmz66pfMwoIxkRYJPQM94ajhOl/f+lPvB/uMEUB
 4QptkVgTMlw39rB/GYntP6+l7wPvyIVU80fTD99xMxZZeSAzzCk+N53da16Dl8gwwiJg
 XtWieOq6lzEzXG7l/fd55nppEL/reI18ttFZWfnhZqFBz088V+R/snODYtJqecbG4Way
 xTHQ==
X-Gm-Message-State: AOJu0YxUI+X2+ND3k5REq9Bm4O6XvZnRWbGmW7ItohNqSXLZOCm1cE8q
 Rjgzia4vm6rMWigbmzQ+AtwwS1NbRe7sUIBSQDB30sdYtFJ5LwvNNtZznWArRwOUz98qFJrd+DL
 FNMWdnws=
X-Gm-Gg: ASbGncuTgDwsZvCAifq8RvVgqQlDXmmpH/OwNR5XLufzK+wItW3VhDJKJ3HbYExZGvZ
 KNvVO1OGeqdXtvZwkcKcd0wmYzxTqSS0krfVC6UNL49dpHM7pQofC3jyYOzEJRgM8p45cpeTWYa
 ZnzrME9/FRMFDKBOwpls+S9q/v2dVpzEbppTOxh53ywWjSJn23dL2qa9dqvJ3j0IIiMnLqkn8EY
 03/ToccJg9rrY1noQHxM1+/ftqgJJ/LO6LcOrFaNz9Kn3xxc/zpYMuDmScoNFFdtX9RHExY3yZA
 IxMJOVT4MdgUY8CNLgGh+FIwvup5Vxa0nXL0UDWrm8kcQFh7LKBfr0WGRWBzyYe1+QGVGNHWHiR
 OCM4OvLY+cs60/DJluO3LNZE5UgNLT+KMy/cni83+PNuPbMM=
X-Google-Smtp-Source: AGHT+IFNKlqCigwGJvLSwWFrhrPWLoAxc2tCmpjR5rTMdPHor3IOg3s/sY5xUT41gmn0DMCfYREWbA==
X-Received: by 2002:a05:600c:4f0c:b0:450:b9c0:c7d2 with SMTP id
 5b1f17b1804b1-453654cbfeamr30480215e9.11.1750439721420; 
 Fri, 20 Jun 2025 10:15:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536470415csm30991895e9.31.2025.06.20.10.15.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:15:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH v2 20/48] cpus: Rename 'vcpu_dirty' field as negated
 'hwaccel_synchronized'
Date: Fri, 20 Jun 2025 19:13:13 +0200
Message-ID: <20250620171342.92678-21-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620171342.92678-1-philmd@linaro.org>
References: <20250620171342.92678-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Try to better describe which side is dirty (QEMU process or
hardware accelerator) by renaming as @hwaccel_synchronized.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h |  4 ++--
 accel/kvm/kvm-all.c   | 20 ++++++++++----------
 target/mips/kvm.c     |  4 ++--
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 69ea425c458..d5f82609943 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -441,7 +441,7 @@ struct qemu_work_item;
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
- * @vcpu_dirty: Hardware accelerator is not synchronized with QEMU state
+ * @hwaccel_synchronized: Hardware accelerator is synchronized with QEMU state
  * @kvm_fd: vCPU file descriptor for KVM.
  * @work_mutex: Lock to prevent multiple access to @work_list.
  * @work_list: List of pending asynchronous work.
@@ -538,7 +538,6 @@ struct CPUState {
     uint32_t kvm_fetch_index;
     uint64_t dirty_pages;
     int kvm_vcpu_stats_fd;
-    bool vcpu_dirty;
 
     /* Use by accel-block: CPU is executing an ioctl() */
     QemuLockCnt in_ioctl_lock;
@@ -555,6 +554,7 @@ struct CPUState {
     int32_t exception_index;
 
     AccelCPUState *accel;
+    bool hwaccel_synchronized;
 
     /* Used to keep track of an outstanding cpu throttle thread for migration
      * autoconverge
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 37faf615cbc..dca6d4b99ef 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -478,8 +478,8 @@ static int kvm_create_vcpu(CPUState *cpu)
 
     cpu->kvm_fd = kvm_fd;
     cpu->kvm_state = s;
-    if (!s->guest_state_protected) {
-        cpu->vcpu_dirty = true;
+    if (s->guest_state_protected) {
+        cpu->hwaccel_synchronized = true;
     }
     cpu->dirty_pages = 0;
     cpu->throttle_us_per_full = 0;
@@ -2880,7 +2880,7 @@ void kvm_flush_coalesced_mmio_buffer(void)
 
 static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
 {
-    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
+    if (cpu->hwaccel_synchronized && !kvm_state->guest_state_protected) {
         Error *err = NULL;
         int ret = kvm_arch_get_registers(cpu, &err);
         if (ret) {
@@ -2894,13 +2894,13 @@ static void do_kvm_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
             vm_stop(RUN_STATE_INTERNAL_ERROR);
         }
 
-        cpu->vcpu_dirty = true;
+        cpu->hwaccel_synchronized = false;
     }
 }
 
 void kvm_cpu_synchronize_state(CPUState *cpu)
 {
-    if (!cpu->vcpu_dirty && !kvm_state->guest_state_protected) {
+    if (cpu->hwaccel_synchronized && !kvm_state->guest_state_protected) {
         run_on_cpu(cpu, do_kvm_cpu_synchronize_state, RUN_ON_CPU_NULL);
     }
 }
@@ -2920,7 +2920,7 @@ static void do_kvm_cpu_synchronize_post_reset(CPUState *cpu, run_on_cpu_data arg
         vm_stop(RUN_STATE_INTERNAL_ERROR);
     }
 
-    cpu->vcpu_dirty = false;
+    cpu->hwaccel_synchronized = true;
 }
 
 void kvm_cpu_synchronize_post_reset(CPUState *cpu)
@@ -2946,7 +2946,7 @@ static void do_kvm_cpu_synchronize_post_init(CPUState *cpu, run_on_cpu_data arg)
         exit(1);
     }
 
-    cpu->vcpu_dirty = false;
+    cpu->hwaccel_synchronized = true;
 }
 
 void kvm_cpu_synchronize_post_init(CPUState *cpu)
@@ -2962,7 +2962,7 @@ void kvm_cpu_synchronize_post_init(CPUState *cpu)
 
 static void do_kvm_cpu_synchronize_pre_loadvm(CPUState *cpu, run_on_cpu_data arg)
 {
-    cpu->vcpu_dirty = true;
+    cpu->hwaccel_synchronized = false;
 }
 
 void kvm_cpu_synchronize_pre_loadvm(CPUState *cpu)
@@ -3131,7 +3131,7 @@ int kvm_cpu_exec(CPUState *cpu)
     do {
         MemTxAttrs attrs;
 
-        if (cpu->vcpu_dirty) {
+        if (!cpu->hwaccel_synchronized) {
             Error *err = NULL;
             ret = kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE, &err);
             if (ret) {
@@ -3145,7 +3145,7 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             }
 
-            cpu->vcpu_dirty = false;
+            cpu->hwaccel_synchronized = true;
         }
 
         kvm_arch_pre_run(cpu, run);
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index ec53acb51a1..44fca0d649f 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -565,7 +565,7 @@ static void kvm_mips_update_state(void *opaque, bool running, RunState state)
      * already saved and can be restored when it is synced back to KVM.
      */
     if (!running) {
-        if (!cs->vcpu_dirty) {
+        if (cs->hwaccel_synchronized) {
             ret = kvm_mips_save_count(cs);
             if (ret < 0) {
                 warn_report("Failed saving count");
@@ -581,7 +581,7 @@ static void kvm_mips_update_state(void *opaque, bool running, RunState state)
             return;
         }
 
-        if (!cs->vcpu_dirty) {
+        if (cs->hwaccel_synchronized) {
             ret = kvm_mips_restore_count(cs);
             if (ret < 0) {
                 warn_report("Failed restoring count");
-- 
2.49.0


