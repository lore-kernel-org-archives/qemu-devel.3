Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3683DCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:15:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvYsT-0001tZ-Qq; Mon, 08 Sep 2025 06:13:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsN-0001pX-2m
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvYsC-0000xB-NT
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757326394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NNOluOBJNIDynOX/SeCHp/9Wa5GX8lq9yKO/uaKZQRg=;
 b=UhgZg9XB2q018+kkAjIiyIvwxQWAySvxNthXp/sSFgE4T+aO1YT0mGJQz4tihqCxckmxI0
 d6K/jTqAHjyVhTVElf8UDKUY81K4hq1RaFv7B2/GLbEn6O8MxD4DzgLGbEGYZBeDzsPUM1
 cLSajXrdGoC55J2e+m7fGfGSbWdO1P8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-vCGzS2HuOlixOJ-UQV3QXw-1; Mon, 08 Sep 2025 06:13:13 -0400
X-MC-Unique: vCGzS2HuOlixOJ-UQV3QXw-1
X-Mimecast-MFC-AGG-ID: vCGzS2HuOlixOJ-UQV3QXw_1757326392
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3e68a54dac2so384457f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757326391; x=1757931191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NNOluOBJNIDynOX/SeCHp/9Wa5GX8lq9yKO/uaKZQRg=;
 b=SU1iWqiByYdSSWhekbikKNBcmHAxluFp7oUvUBMvO5ZqVjjakkPVcsNIbfg3a+U844
 yzVty8AfzjLud7F/CPiEAlBNObnTF9MAPxbq+i09upOzzaQYRJN2m9sw+dIrXz+CO2J6
 66tQVhZQAz7PZqo8OESN2r21PplBA6z9v0QGsM8CZTOqrbR7VBpbonHAp47Sorrk+m2X
 gFqyEbXnA5R4E2eXh7aJ3G6UAc+tyi/4OKvZvrR5Vgli/z6rN7//1NfjddJJIlRVmwSj
 gfhMTBjGXaCfA0anaSOtyKsFxRWlmI8kkBWfkLQ5nzOu7uT4hMz6nm4Xp4hVZaj+jfxe
 I3sg==
X-Gm-Message-State: AOJu0YzP8mtUBuTUPhdWyHTKF6BMnat4S+vLgDxV6SuYinXNMfCqRnha
 wA9LEVy/f93BFcjhsrrufMJC7uFQ9xali+239wuuZqb+j/x9tdfxtw1ZwRv7GiJ2da6L7iLKwGe
 v9k7nwWMInzV7QqVv+6A8zaMJ6FgmEQPDeDq5xvvNgb/upx1eJ6ZPwtuOfaKf6UM2xtJHhc9QuX
 MMjcT/WOoX28oG2Y+ZZMd7q1S6ssWbX7jU9RiasIDU
X-Gm-Gg: ASbGncvY/CgO8V0tuoosOtf1Vue0S4D8s4YRQvYlYn2KGWWg0IJGQry7R5KZYyiS8vn
 6iOcdER7Q2V2q7u5M8z/K31dj+TGyydyk3G1X5HjuQEWTrnzeFM65n3f22dRQBqEkjXdthyAF6Z
 /Hg5qZ4A3DRg5lOdC+pI4KJv0xKLFLaQXMdhYoS78f/sc7NIaGezvnXFdVe/JR+TxQPVTaT58Di
 7WqkUrckfXMBk1+6YVrTPREq1Xax+dsTTOxa449gZRFsyZ3nL1Hv6NlOKdM2H74x9W3WkI28Ub1
 t1D6fsE0ng7rKbkXTvZPc3aXnrVyMZCG1HGJ8hv9Zy07PxDE9kdIhCbiulF13oIiOj8X+U54ob7
 KhceRFhxwtaUaS7RStb2xA2UmOjakcDnOA8MCxSU9kOI=
X-Received: by 2002:a05:6000:1a87:b0:3e2:e851:7f93 with SMTP id
 ffacd0b85a97d-3e300ae3446mr10075262f8f.7.1757326390674; 
 Mon, 08 Sep 2025 03:13:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2pJGIYWJwE6StkLzHGPEjPIaEYufrfU5jk2BSgO6+GpS2gJl2d1sVD2m5rotGThxWdauADg==
X-Received: by 2002:a05:6000:1a87:b0:3e2:e851:7f93 with SMTP id
 ffacd0b85a97d-3e300ae3446mr10075220f8f.7.1757326390104; 
 Mon, 08 Sep 2025 03:13:10 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf34493b8csm40181801f8f.59.2025.09.08.03.13.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:13:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 11/19] accel/tcg: create a thread-kick function for TCG
Date: Mon,  8 Sep 2025 12:12:33 +0200
Message-ID: <20250908101241.2110068-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908101241.2110068-1-pbonzini@redhat.com>
References: <20250908101241.2110068-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Round-robin TCG is calling into cpu_exit() directly.  In preparation
for making cpu_exit() usable from all accelerators, define a generic
thread-kick function for TCG which is used directly in the multi-threaded
case, and through CPU_FOREACH in the round-robin case.

Use it also for user-mode emulation, and take the occasion to move
the implementation to accel/tcg/user-exec.c.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/tcg-icount.rst       | 2 +-
 accel/tcg/tcg-accel-ops-mttcg.h | 3 ---
 accel/tcg/tcg-accel-ops.h       | 1 +
 accel/tcg/cpu-exec.c            | 6 ++++++
 accel/tcg/tcg-accel-ops-mttcg.c | 5 -----
 accel/tcg/tcg-accel-ops-rr.c    | 2 +-
 accel/tcg/tcg-accel-ops.c       | 2 +-
 accel/tcg/user-exec.c           | 6 ++++++
 bsd-user/main.c                 | 5 -----
 linux-user/main.c               | 5 -----
 10 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/docs/devel/tcg-icount.rst b/docs/devel/tcg-icount.rst
index 7df883446a7..a1dcd79e0fd 100644
--- a/docs/devel/tcg-icount.rst
+++ b/docs/devel/tcg-icount.rst
@@ -37,7 +37,7 @@ translator starts by allocating a budget of instructions to be
 executed. The budget of instructions is limited by how long it will be
 until the next timer will expire. We store this budget as part of a
 vCPU icount_decr field which shared with the machinery for handling
-cpu_exit(). The whole field is checked at the start of every
+qemu_cpu_kick(). The whole field is checked at the start of every
 translated block and will cause a return to the outer loop to deal
 with whatever caused the exit.
 
diff --git a/accel/tcg/tcg-accel-ops-mttcg.h b/accel/tcg/tcg-accel-ops-mttcg.h
index 8ffa7a9a9fe..5c145cc8595 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.h
+++ b/accel/tcg/tcg-accel-ops-mttcg.h
@@ -10,9 +10,6 @@
 #ifndef TCG_ACCEL_OPS_MTTCG_H
 #define TCG_ACCEL_OPS_MTTCG_H
 
-/* kick MTTCG vCPU thread */
-void mttcg_kick_vcpu_thread(CPUState *cpu);
-
 /* start an mttcg vCPU thread */
 void mttcg_start_vcpu_thread(CPUState *cpu);
 
diff --git a/accel/tcg/tcg-accel-ops.h b/accel/tcg/tcg-accel-ops.h
index 6feeb3f3e9b..aecce605d7b 100644
--- a/accel/tcg/tcg-accel-ops.h
+++ b/accel/tcg/tcg-accel-ops.h
@@ -18,5 +18,6 @@ void tcg_cpu_destroy(CPUState *cpu);
 int tcg_cpu_exec(CPUState *cpu);
 void tcg_handle_interrupt(CPUState *cpu, int mask);
 void tcg_cpu_init_cflags(CPUState *cpu, bool parallel);
+void tcg_kick_vcpu_thread(CPUState *cpu);
 
 #endif /* TCG_ACCEL_OPS_H */
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f838535d111..9241bcadb5f 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -40,6 +40,7 @@
 #include "exec/replay-core.h"
 #include "system/tcg.h"
 #include "exec/helper-proto-common.h"
+#include "tcg-accel-ops.h"
 #include "tb-jmp-cache.h"
 #include "tb-hash.h"
 #include "tb-context.h"
@@ -748,6 +749,11 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
     return false;
 }
 
+void tcg_kick_vcpu_thread(CPUState *cpu)
+{
+    cpu_exit(cpu);
+}
+
 static inline bool icount_exit_request(CPUState *cpu)
 {
     if (!icount_enabled()) {
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index b12b7a36b5d..1148ebcaae5 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -123,11 +123,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
     return NULL;
 }
 
-void mttcg_kick_vcpu_thread(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 void mttcg_start_vcpu_thread(CPUState *cpu)
 {
     char thread_name[VCPU_THREAD_NAME_SIZE];
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index d13e0d8b44d..a1d75fd3419 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -43,7 +43,7 @@ void rr_kick_vcpu_thread(CPUState *unused)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        cpu_exit(cpu);
+        tcg_kick_vcpu_thread(cpu);
     };
 }
 
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 9c37266c1e0..1f662a9c745 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -206,7 +206,7 @@ static void tcg_accel_ops_init(AccelClass *ac)
 
     if (qemu_tcg_mttcg_enabled()) {
         ops->create_vcpu_thread = mttcg_start_vcpu_thread;
-        ops->kick_vcpu_thread = mttcg_kick_vcpu_thread;
+        ops->kick_vcpu_thread = tcg_kick_vcpu_thread;
         ops->handle_interrupt = tcg_handle_interrupt;
     } else {
         ops->create_vcpu_thread = rr_start_vcpu_thread;
diff --git a/accel/tcg/user-exec.c b/accel/tcg/user-exec.c
index 66c25fba7dd..3c072fd868f 100644
--- a/accel/tcg/user-exec.c
+++ b/accel/tcg/user-exec.c
@@ -38,6 +38,7 @@
 #include "qemu/int128.h"
 #include "trace.h"
 #include "tcg/tcg-ldst.h"
+#include "tcg-accel-ops.h"
 #include "backend-ldst.h"
 #include "internal-common.h"
 #include "tb-internal.h"
@@ -46,6 +47,11 @@ __thread uintptr_t helper_retaddr;
 
 //#define DEBUG_SIGNAL
 
+void qemu_cpu_kick(CPUState *cpu)
+{
+    tcg_kick_vcpu_thread(cpu);
+}
+
 /*
  * Adjust the pc to pass to cpu_restore_state; return the memop type.
  */
diff --git a/bsd-user/main.c b/bsd-user/main.c
index 9ba69642f50..73aae8c3274 100644
--- a/bsd-user/main.c
+++ b/bsd-user/main.c
@@ -214,11 +214,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
     return thread_cpu == cpu;
 }
 
-void qemu_cpu_kick(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 /* Assumes contents are already zeroed.  */
 static void init_task_state(TaskState *ts)
 {
diff --git a/linux-user/main.c b/linux-user/main.c
index 7b0ccb6fd60..4ddfc9a619c 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -189,11 +189,6 @@ bool qemu_cpu_is_self(CPUState *cpu)
     return thread_cpu == cpu;
 }
 
-void qemu_cpu_kick(CPUState *cpu)
-{
-    cpu_exit(cpu);
-}
-
 void task_settid(TaskState *ts)
 {
     if (ts->ts_tid == 0) {
-- 
2.51.0


