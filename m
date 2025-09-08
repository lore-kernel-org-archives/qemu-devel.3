Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5A47CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:17:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsY-0001u4-7n; Mon, 08 Sep 2025 06:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsS-0001tG-U1
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsL-0000zm-Ks
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXQMi8BZDSg1KOQd6AcbPnJhdPXj2cGy9rxZHEZfEC4=;
 b=S4uQD0p/NMocJiypctrN8ikN2/l0LhnrBx1BoOzHeAVSkSVBnkbCiRvqTMnNmLYhLKGgmV
 /BcHGizqqYPrxYhgYzP0JK2RBiU17gXzEUrJYSnR5uXB6Lh5lGpXtWZ1n4cGhRL5B2svnP
 B1kZWTRvPqc80hkuN1u+Eqyp8i2bnXQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-Sg2bjxReNJKfRL5WoBGUsQ-1; Mon, 08 Sep 2025 06:13:22 -0400
X-MC-Unique: Sg2bjxReNJKfRL5WoBGUsQ-1
X-Mimecast-MFC-AGG-ID: Sg2bjxReNJKfRL5WoBGUsQ_1757326402
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45dda7c0e5eso23736565e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326401; x=1757931201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXQMi8BZDSg1KOQd6AcbPnJhdPXj2cGy9rxZHEZfEC4=;
 b=RvAaZ/AZR6El39uurZrU4uRehB67WOxsm7UtTqfUOZTUEVbpvA247DAajyu86zZP+W
 JPVHzsljkHTe/iec0D6M6KHJ3JBSacHaVggvby7zsoE6J2pEP21FjmfitXXfzDGNeDOg
 xv5s/Mb+3g6qc5QGCZ7ol7txaUAuKH9jE3M8LIUY/+WwvNCSiesvinrkkjLAsxcyee9n
 JE7XsiatCyW9XvicC/jPu9KiwKj0TTSCa8RWtnHNg7SjHSZ8FZ3yX2YOafnXjbyDD9s0
 xeV5DpdEEFvhXZCyBcYR4oOR9JcKkOKp84G32YrryZuiu7GWa3wnnXs8GZ3Iie1oIsYM
 zbMg==
X-Gm-Message-State: AOJu0YxYYmYOHBE7yY4G23LUQzFbOBknb1JMXLJKUAo/w23MD1CPwt7U
 XlTZzmq5YmNGZp3CwIAAkeqYkIUl2WcxlI23e3xZDa50EAIBzydShY4c51BsJ09nkZm2Q/snxZb
 P4IXwJyXTKIjWX+53sZZ202umfFhkpkSLGnDpF+utLMS6I+ebQul7UOv0BL84Vx8phfQRLqbvj2
 Plk/wU02U/Mj7WYBU45HwE4mrFrLggZaMaH4HZ33Nz
X-Gm-Gg: ASbGncss7flAGZgU13e5XZKLkeLIEWHchdHsWAums29q6kNzobA+KBw9+ONTfenvLz0
 74wrNA0w8cLCImRqX1818uzc5UHO53tR3nnEHXgFjkpEkx2qbklvzGafUIb523/8H3eWWeLsaje
 dITbHXzE7p9I1LqwCtWRJ+fWITH8xFRbsT9vzMWsDXik1VYQblioMlr2pP/Sz+dji/Jw3eWEXTt
 dPKddyL0WbQYv+wJfYFv9XzgUCfw8ZkvIQPqPdUwyoE0oWBvQ1wRo44YDP/bg5ojMoe2vsS2eRM
 CwUq3KA/qFQinA+0f2pHlUnTfp6fsj6zOZO3CXjkG1/GitTkThEZqunbEgSULZgq2nGz34B7ofx
 GCP++hhNUdFCGxnQ8mC2iD0scOT7g5TTIWUQHInWEr3Q=
X-Received: by 2002:a05:600c:45d4:b0:45b:9a76:ebea with SMTP id
 5b1f17b1804b1-45dddeeee4cmr60636655e9.20.1757326401129; 
 Mon, 08 Sep 2025 03:13:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDzo6psxOTaiHgTtNyoK037UNzS5vsqOyIa8Y5wxCtBxpqtdUODM6CmRXfGe2jtX0D7XxY0g==
X-Received: by 2002:a05:600c:45d4:b0:45b:9a76:ebea with SMTP id
 5b1f17b1804b1-45dddeeee4cmr60636265e9.20.1757326400585; 
 Mon, 08 Sep 2025 03:13:20 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45ddb779eb6sm120988385e9.8.2025.09.08.03.13.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/19] treewide: rename
 qemu_wait_io_event/qemu_wait_io_event_common
Date: Mon,  8 Sep 2025 12:12:37 +0200
Message-ID: <20250908101241.2110068-16-pbonzini@redhat.com>
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

Do so before extending it to the user-mode emulators, where there is no
such thing as an "I/O thread".

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h             | 2 +-
 include/system/cpus.h             | 4 ++--
 accel/dummy-cpus.c                | 2 +-
 accel/hvf/hvf-accel-ops.c         | 2 +-
 accel/kvm/kvm-accel-ops.c         | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.c   | 2 +-
 accel/tcg/tcg-accel-ops-rr.c      | 4 ++--
 cpu-common.c                      | 2 +-
 system/cpus.c                     | 6 +++---
 target/i386/nvmm/nvmm-accel-ops.c | 2 +-
 target/i386/whpx/whpx-accel-ops.c | 2 +-
 11 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 338757e5254..6075be0b59f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -422,7 +422,7 @@ struct qemu_work_item;
  * valid under cpu_list_lock.
  * @created: Indicates whether the CPU thread has been successfully created.
  * @halt_cond: condition variable sleeping threads can wait on.
- * @exit_request: Another thread requests the CPU to call qemu_wait_io_event().
+ * @exit_request: Another thread requests the CPU to call qemu_process_cpu_events().
  *   Should be read only by CPU thread with load-acquire, to synchronize with
  *   other threads' store-release operation.
  *
diff --git a/include/system/cpus.h b/include/system/cpus.h
index 69be6a77a75..4aebec48705 100644
--- a/include/system/cpus.h
+++ b/include/system/cpus.h
@@ -17,8 +17,8 @@ bool cpu_work_list_empty(CPUState *cpu);
 bool cpu_thread_is_idle(CPUState *cpu);
 bool all_cpu_threads_idle(void);
 bool cpu_can_run(CPUState *cpu);
-void qemu_wait_io_event_common(CPUState *cpu);
-void qemu_wait_io_event(CPUState *cpu);
+void qemu_process_cpu_events_common(CPUState *cpu);
+void qemu_process_cpu_events(CPUState *cpu);
 void cpu_thread_signal_created(CPUState *cpu);
 void cpu_thread_signal_destroyed(CPUState *cpu);
 void cpu_handle_guest_debug(CPUState *cpu);
diff --git a/accel/dummy-cpus.c b/accel/dummy-cpus.c
index 03cfc0fa01e..225a47c31fd 100644
--- a/accel/dummy-cpus.c
+++ b/accel/dummy-cpus.c
@@ -57,7 +57,7 @@ static void *dummy_cpu_thread_fn(void *arg)
         qemu_sem_wait(&cpu->sem);
 #endif
         bql_lock();
-        qemu_wait_io_event(cpu);
+        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug);
 
     bql_unlock();
diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index d488d6afbac..7a27bdadb4f 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -198,7 +198,7 @@ static void *hvf_cpu_thread_fn(void *arg)
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_wait_io_event(cpu);
+        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     hvf_vcpu_destroy(cpu);
diff --git a/accel/kvm/kvm-accel-ops.c b/accel/kvm/kvm-accel-ops.c
index b709187c7d7..65a7f76a69a 100644
--- a/accel/kvm/kvm-accel-ops.c
+++ b/accel/kvm/kvm-accel-ops.c
@@ -53,7 +53,7 @@ static void *kvm_vcpu_thread_fn(void *arg)
                 cpu_handle_guest_debug(cpu);
             }
         }
-        qemu_wait_io_event(cpu);
+        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     kvm_destroy_vcpu(cpu);
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 1148ebcaae5..342917c5f6e 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -113,7 +113,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
             }
         }
 
-        qemu_wait_io_event(cpu);
+        qemu_process_cpu_events(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     tcg_cpu_destroy(cpu);
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index a1d75fd3419..813b313859a 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -117,7 +117,7 @@ static void rr_wait_io_event(void)
     rr_start_kick_timer();
 
     CPU_FOREACH(cpu) {
-        qemu_wait_io_event_common(cpu);
+        qemu_process_cpu_events_common(cpu);
     }
 }
 
@@ -203,7 +203,7 @@ static void *rr_cpu_thread_fn(void *arg)
         /* process any pending work */
         CPU_FOREACH(cpu) {
             current_cpu = cpu;
-            qemu_wait_io_event_common(cpu);
+            qemu_process_cpu_events_common(cpu);
         }
     }
 
diff --git a/cpu-common.c b/cpu-common.c
index 152661df8e9..0eb5c7b8f24 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -137,7 +137,7 @@ static void queue_work_on_cpu(CPUState *cpu, struct qemu_work_item *wi)
     wi->done = false;
     qemu_mutex_unlock(&cpu->work_mutex);
 
-    /* exit the inner loop and reach qemu_wait_io_event_common().  */
+    /* exit the inner loop and reach qemu_process_cpu_events_common().  */
     cpu_exit(cpu);
 }
 
diff --git a/system/cpus.c b/system/cpus.c
index bb13942cbb7..fd804e07327 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -450,7 +450,7 @@ static void qemu_cpu_stop(CPUState *cpu, bool exit)
     qemu_cond_broadcast(&qemu_pause_cond);
 }
 
-void qemu_wait_io_event_common(CPUState *cpu)
+void qemu_process_cpu_events_common(CPUState *cpu)
 {
     qatomic_set_mb(&cpu->thread_kicked, false);
     if (cpu->stop) {
@@ -459,7 +459,7 @@ void qemu_wait_io_event_common(CPUState *cpu)
     process_queued_cpu_work(cpu);
 }
 
-void qemu_wait_io_event(CPUState *cpu)
+void qemu_process_cpu_events(CPUState *cpu)
 {
     bool slept = false;
 
@@ -474,7 +474,7 @@ void qemu_wait_io_event(CPUState *cpu)
         qemu_plugin_vcpu_resume_cb(cpu);
     }
 
-    qemu_wait_io_event_common(cpu);
+    qemu_process_cpu_events_common(cpu);
 }
 
 void cpus_kick_thread(CPUState *cpu)
diff --git a/target/i386/nvmm/nvmm-accel-ops.c b/target/i386/nvmm/nvmm-accel-ops.c
index 86869f133e9..d066364b989 100644
--- a/target/i386/nvmm/nvmm-accel-ops.c
+++ b/target/i386/nvmm/nvmm-accel-ops.c
@@ -51,7 +51,7 @@ static void *qemu_nvmm_cpu_thread_fn(void *arg)
         while (cpu_thread_is_idle(cpu)) {
             qemu_cond_wait_bql(cpu->halt_cond);
         }
-        qemu_wait_io_event_common(cpu);
+        qemu_process_cpu_events_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     nvmm_destroy_vcpu(cpu);
diff --git a/target/i386/whpx/whpx-accel-ops.c b/target/i386/whpx/whpx-accel-ops.c
index da58805b1a6..2ca4ee02636 100644
--- a/target/i386/whpx/whpx-accel-ops.c
+++ b/target/i386/whpx/whpx-accel-ops.c
@@ -51,7 +51,7 @@ static void *whpx_cpu_thread_fn(void *arg)
         while (cpu_thread_is_idle(cpu)) {
             qemu_cond_wait_bql(cpu->halt_cond);
         }
-        qemu_wait_io_event_common(cpu);
+        qemu_process_cpu_events_common(cpu);
     } while (!cpu->unplug || cpu_can_run(cpu));
 
     whpx_destroy_vcpu(cpu);
-- 
2.51.0


