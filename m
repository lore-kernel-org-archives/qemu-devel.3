Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C887CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNJl-0002Wk-U3; Sat, 30 Aug 2025 11:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryit-0001JT-C8
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryim-0008Sz-H7
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kZyEgH9DKztXeTe2Vje8AkYxR7PVqbAXH0RSFUOrC7o=;
 b=M532JqtsoWjc20Rv0Tcla25871TR/4oQ8NMY9XaBgr44SFaEUn3w4Dr2ZFWsCBhW0vARin
 QMRJPj7vtmftFW1DD0xlKHBG8GSQzWWm0Vx5jyzDT9DukZF/7RIwjJrcWziGz7Hcyfmspf
 2fNlAEHV4+L7bCx/NU4kHAbQoZjzcRo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-ZpFmLFY3OCyPbNd8u7yUKw-1; Fri, 29 Aug 2025 09:00:44 -0400
X-MC-Unique: ZpFmLFY3OCyPbNd8u7yUKw-1
X-Mimecast-MFC-AGG-ID: ZpFmLFY3OCyPbNd8u7yUKw_1756472443
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3c456849a25so736717f8f.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472443; x=1757077243;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZyEgH9DKztXeTe2Vje8AkYxR7PVqbAXH0RSFUOrC7o=;
 b=GUO8AVkg5Cjm0CUK7kxSCRInf+hZMy9ciCvFG7P//AMntpHjRa60ChxOtlQ2++1fzF
 3h26JgKcnawbJZSi7RgcoQidINEMat/oJRlpSkqtATpgMjj+3vuRhCKe/3prK+OhTTta
 CTPrRyHBj8uVBxhgnny4gr4x5UwfuMYjMsAJNsn7LAyCM9WPylcKNpSKfMulwm52BVWh
 wOUTZLJ8ynAgYEVRWT9JyHWkrrkojaq5jkd9EgjpHzU/4RWLKls6VYhqa6qiQXV1uesL
 4R1fHxCsSigb99EDALA3RhTKOK8ygxdxNYllPsFvQVyatOj1ZZ1m7m/wSgmuIyKvdpVy
 AK2A==
X-Gm-Message-State: AOJu0Yy6mU5Qh1Ceol5yL+bsGO7fwN/qdnt4frULjEAqgeFfW+hk4p72
 hWpCk57YQPyH4FhRU5GrADeok/zPcDlwgPWHO5gf9eI8+sAZXElqpmIi5Q8RmhflziAg3J5skav
 Oej5yWkKdVq5LgUROJFk6WlHAEKzBWax1ynU6Dr30xfJJVynSfno769JVK8sK4QOp9V/Kgw7rT8
 AEPqvA+p7dCyWRsAQ4keLTSSmZ+N56n+rlg3hTegNv
X-Gm-Gg: ASbGnct0z7veiV+UDtKkkORQJa2Z+D3v8FaooAJSiY3SNfUfkfJxfIRozwOmyWU+KDv
 kVTGYaDbqRCFSIby97dmf3JS/JNCDlkX3szNp9jIRsLdLJ7xjR6t9CWNHZIPhgEpd0HgjfY74TQ
 OPX5myjbZsvvHeTxruIMhfQ+C8bi5J00DQArpYQQmVim0uFpx9sIWYyZZ8wz3vfC/mnDNfQn4IR
 HzxOcqYE+trgd3YnGHoQ5fF1YNrgMjUQh9E775gFZMHiaVA85AwjTlq3qshoGnobU2CsP5D7iQL
 rIeSPzMMBzwQE08o7uSExxrYh1wP63c9jseFvLmrQmcMAcwl/JBS+ohU+xxFyR6ia2ldr+jU8KB
 dQug/YE4+giM0Li/I53ACDgcVJkm+N7Dg2e1PhwAZKcg=
X-Received: by 2002:a05:6000:1787:b0:3b7:94ad:ef50 with SMTP id
 ffacd0b85a97d-3cbb15ca78amr11348875f8f.2.1756472442612; 
 Fri, 29 Aug 2025 06:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA+IXhHNAq5Mvz62ij47oXOz5UcksSZg/GlMImUrn9SRZ9TNQJBj6tGCymnJHmyWipA7b+QA==
X-Received: by 2002:a05:6000:1787:b0:3b7:94ad:ef50 with SMTP id
 ffacd0b85a97d-3cbb15ca78amr11348831f8f.2.1756472442052; 
 Fri, 29 Aug 2025 06:00:42 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add7f2sm3549508f8f.32.2025.08.29.06.00.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:00:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/28] user-exec: ensure interrupt_request is not used
Date: Fri, 29 Aug 2025 14:59:27 +0200
Message-ID: <20250829125935.1526984-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

cpu_interrupt() is not called anymore except by ARM but even there
it is dead code; disentangling the various cpregs accessors from user-mode
emulation is a work in progress.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h | 1 +
 accel/tcg/cpu-exec.c  | 6 ++++--
 accel/tcg/user-exec.c | 4 +---
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 5eaf41a566f..f73b4357c7b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -423,6 +423,7 @@ struct qemu_work_item;
  * @created: Indicates whether the CPU thread has been successfully created.
  * @halt_cond: condition variable sleeping threads can wait on.
  * @interrupt_request: Indicates a pending interrupt request.
+ *   Only used by system emulation.
  * @halted: Nonzero if the CPU is in suspended state.
  * @stop: Indicates a pending stop request.
  * @stopped: Indicates the CPU has been artificially stopped.
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 713bdb20564..b44dd1e8205 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -778,6 +778,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
      */
     qatomic_set_mb(&cpu->neg.icount_decr.u16.high, 0);
 
+#ifdef CONFIG_USER_ONLY
+    g_assert(!qatomic_read(&cpu->interrupt_request));
+#else
     if (unlikely(qatomic_read(&cpu->interrupt_request))) {
         int interrupt_request;
         bql_lock();
@@ -792,7 +795,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
             bql_unlock();
             return true;
         }
-#if !defined(CONFIG_USER_ONLY)
         if (replay_mode == REPLAY_MODE_PLAY && !replay_has_interrupt()) {
             /* Do nothing */
         } else if (interrupt_request & CPU_INTERRUPT_HALT) {
@@ -840,7 +842,6 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
              * reload the 'interrupt_request' value */
             interrupt_request = cpu->interrupt_request;
         }
-#endif /* !CONFIG_USER_ONLY */
         if (interrupt_request & CPU_INTERRUPT_EXITTB) {
             cpu->interrupt_request &= ~CPU_INTERRUPT_EXITTB;
             /* ensure that no TB jump will be modified as
@@ -851,6 +852,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         /* If we exit via cpu_loop_exit/longjmp it is reset in cpu_exec */
         bql_unlock();
     }
+#endif /* !CONFIG_USER_ONLY */
 
     /* Finally, check if we need to exit to the main loop.  */
     if (unlikely(qatomic_read(&cpu->exit_request)) || icount_exit_request(cpu)) {
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index f25d80e2dc2..748bfab04a7 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -48,9 +48,7 @@ __thread uintptr_t helper_retaddr;
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-    cpu->interrupt_request |= mask;
-    qatomic_set(&cpu->neg.icount_decr.u16.high, -1);
+    g_assert_not_reached();
 }
 
 /*
-- 
2.51.0


