Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19319C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 20:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Zs3-0001N8-IP; Tue, 15 Sep 2026 16:35:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zs0-0001KV-Qf
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:12 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6Zry-0005c4-1f
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 16:35:12 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so1072865e9.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 13:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789504509; x=1790109309; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZIoeg91zeWuTpwxotQCiRuVpQN1XOyBCM3H3hj1KbdA=;
 b=KXeDp5JlK7eCLOqvyhWqCuTBSUqE13uassb5Li5a7iHjlbspKO+bBrDkstgASIqTTV
 YHj+qXh7AwtNZF80XLldFQIXD4EOzrvkzbsMucBnNwGn32ztOffPjXEqVH+3lpJzTQQn
 yFALqzmIo/A3lh6mhhKmIZSVrgnnWH2rLgL/qoEXzyZcgxSeirfkdeFV9y6WFwFot4Wu
 mLapJePknVBL3UmrZBzNjxnPw45nG9flPRng+KyVxWbDq9WQDSQq9rODmLI8k/L3YRoE
 WxBxOAp7filCt5GnK6183eXNPv1WdlO51FI1yHdYyHTb2WlsmuA2R2i7mzs9Pw9rWRB2
 Eb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789504509; x=1790109309;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZIoeg91zeWuTpwxotQCiRuVpQN1XOyBCM3H3hj1KbdA=;
 b=NIc2/C2gqLanWQ6nySuZbgMJol8gLWEpO5r7dEcvkbQnoxBwXpVrPEPiEdSbap9TI1
 Pc5HeFHWnYvbg2rKvrlesCTnQDWLCNpR8DgpDVoT2MQVdMUpqKK7lFJXH3ffjqO+N0u3
 NNNXjVaf6yKgK4+mEIpMJXRUKPJePdLH64lFuCUSSLw4uo6O7gzcZ3tTDXyRz3i5D1B/
 345ez0OyMcnPNdqPX+pb5d3zOWMkGcTDiZqLHjIFL6gM126brlovE9XWHLQ8KN5mBer4
 QKeUyvixAtz4X1rXUr49WpMnp2/enqu/HqP55B9WpxHz5ct1jgEFJHHgFI/ijmxhwfFE
 3hXQ==
X-Gm-Message-State: AFuF++k6TWIChZkieFcNUjEeVXsO1aNtoSYDax0WwYJoKCD5hENk5XxF
 3Xj1rdk1pBSLRgvJgyR1LEpI8cyQfiIutTKRROliDB5FHGGY/n0r5/92ozbxyf9bvOqM4UgIe8+
 tqKfC
X-Gm-Gg: AYBFou0kMPfKgt2pV9FWpA+XEwwjjEYFNuIu/9Mh4Wii4R8r/XYmD8WVTzfIfE7f2t0
 m0Ey90jTGtnuoPZH9LJIN3XyDvoxgGmjIgwvGc3R1ECS1KHXCr9zfJaf03dKMXdEZlGB0TJqt/I
 4+LyNJHvt/QTCtUw0tSVR4XWHDNK2c19j/Y6k5W5iZL+vAn7o3Ztu4nNVeDdKA/Aln5M8NqAM7K
 kKJskKjNQSWEWnBJmK3/x5xQ95g9953pkzNVKjo5vEZBXNgdyq1YRP82kcfIKQ/q1H3G4Queuz4
 cNB64W5Y/I5BO+sPIkhYKOllB3MeijpYCiPFpYhk8uF7exfVQVusbUAyeOFeZL1Mz3Muc5sZ0WH
 wNnu3N142QID3mzQnGEQknnBKPDxUb+Klj46i+VwRvZLnmeBXUIg+P/VfKG5DOTznUa7AdfLvj6
 nmZq4RGlfrr01Ih2XagQ4zizd9POyMZThirR4r/imco3IEjkSHpzph4Bib3A+ShZ2sOjB0S4zid
 Qdf+L8=
X-Received: by 2002:adf:e19d:0:b0:486:f958:f221 with SMTP id
 ffacd0b85a97d-4870cedc88dmr350792f8f.5.1789504508663; 
 Tue, 15 Sep 2026 13:35:08 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f0fe:c7ed:403d:e487])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf37e69sm1504073f8f.29.2026.09.15.13.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 13:35:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 06/10] oslib: report each thread's program counter
Date: Tue, 15 Sep 2026 22:34:50 +0200
Message-ID: <20260915203455.580999-7-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260915203455.580999-1-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Denis V. Lunev <den@openvz.org>

A kernel stack describes a thread asleep in a syscall and says nothing
about one spinning in userspace, which is the other way a thread stops
making progress.

Ask each thread where it is by signalling it and reading the program
counter out of the signal frame. That is a register read and a store,
which a handler may do, unlike unwinding: backtrace() is not async
signal safe and takes the loader lock the first time it runs.

Ask all of them at once, once every passive read is taken. The signal
interrupts whatever a thread was blocked in, so probing earlier would
make the kernel stack and the wait channel describe the interruption
instead of the hang, and probing one at a time would spend the timeout
again for every thread that never answers. Insert the answers from the
back, so the offsets recorded during the reads still point where they
did.

A thread that never answers within the deadline can still run the
handler later, once whatever held it lets go, and by then the slots it
would write to are gone. Count handlers between entry and exit,
withdraw the slots when the deadline expires and wait for the last
handler out before returning to the caller that frees them. A handler
that arrives after the withdrawal finds nothing to write to.

Where the counter sits in the signal frame is a host property, so it is
answered from host/include like the other per-host questions, with a
generic fallback that reports no counter and leaves the host otherwise
untouched. The Linux hosts covered are the ones whose signal frames
linux-user already describes in host-signal.h.

Name the address through dladdr() where there is a symbol for it. There
often is not, because dladdr() sees exported symbols only and a thread
parked inside a library sits in its internals, so fall back to the
object and the offset within it. An offset resolves against the library
afterwards; the raw address does not survive the process.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Daniel P. Berrangé <berrange@redhat.com>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 host/include/aarch64/host/signal-pc.h     |  20 +++
 host/include/generic/host/signal-pc.h     |  11 ++
 host/include/loongarch64/host/signal-pc.h |  20 +++
 host/include/ppc64/host/signal-pc.h       |  22 +++
 host/include/riscv64/host/signal-pc.h     |  20 +++
 host/include/s390x/host/signal-pc.h       |  20 +++
 host/include/x86_64/host/signal-pc.h      |  20 +++
 include/qemu/osdep.h                      |   7 +-
 meson.build                               |   2 +
 util/oslib-posix.c                        | 181 +++++++++++++++++++++-
 10 files changed, 318 insertions(+), 5 deletions(-)
 create mode 100644 host/include/aarch64/host/signal-pc.h
 create mode 100644 host/include/generic/host/signal-pc.h
 create mode 100644 host/include/loongarch64/host/signal-pc.h
 create mode 100644 host/include/ppc64/host/signal-pc.h
 create mode 100644 host/include/riscv64/host/signal-pc.h
 create mode 100644 host/include/s390x/host/signal-pc.h
 create mode 100644 host/include/x86_64/host/signal-pc.h

diff --git a/host/include/aarch64/host/signal-pc.h b/host/include/aarch64/host/signal-pc.h
new file mode 100644
index 0000000000..fe60ed1c96
--- /dev/null
+++ b/host/include/aarch64/host/signal-pc.h
@@ -0,0 +1,20 @@
+/*
+ * Program counter of an interrupted aarch64 thread, from its signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef AARCH64_HOST_SIGNAL_PC_H
+#define AARCH64_HOST_SIGNAL_PC_H
+
+#ifdef CONFIG_LINUX
+#define HAVE_HOST_SIGNAL_PC 1
+
+static inline uintptr_t host_signal_pc(const ucontext_t *uc)
+{
+    return uc->uc_mcontext.pc;
+}
+#else
+#define HAVE_HOST_SIGNAL_PC 0
+#endif
+
+#endif
diff --git a/host/include/generic/host/signal-pc.h b/host/include/generic/host/signal-pc.h
new file mode 100644
index 0000000000..8ce3822069
--- /dev/null
+++ b/host/include/generic/host/signal-pc.h
@@ -0,0 +1,11 @@
+/*
+ * No host specific way to read the program counter from a signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HOST_SIGNAL_PC_H
+#define HOST_SIGNAL_PC_H
+
+#define HAVE_HOST_SIGNAL_PC 0
+
+#endif
diff --git a/host/include/loongarch64/host/signal-pc.h b/host/include/loongarch64/host/signal-pc.h
new file mode 100644
index 0000000000..ccb2ac1c56
--- /dev/null
+++ b/host/include/loongarch64/host/signal-pc.h
@@ -0,0 +1,20 @@
+/*
+ * Program counter of an interrupted loongarch64 thread, from its signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef LOONGARCH64_HOST_SIGNAL_PC_H
+#define LOONGARCH64_HOST_SIGNAL_PC_H
+
+#ifdef CONFIG_LINUX
+#define HAVE_HOST_SIGNAL_PC 1
+
+static inline uintptr_t host_signal_pc(const ucontext_t *uc)
+{
+    return uc->uc_mcontext.__pc;
+}
+#else
+#define HAVE_HOST_SIGNAL_PC 0
+#endif
+
+#endif
diff --git a/host/include/ppc64/host/signal-pc.h b/host/include/ppc64/host/signal-pc.h
new file mode 100644
index 0000000000..1473570a39
--- /dev/null
+++ b/host/include/ppc64/host/signal-pc.h
@@ -0,0 +1,22 @@
+/*
+ * Program counter of an interrupted ppc64 thread, from its signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PPC64_HOST_SIGNAL_PC_H
+#define PPC64_HOST_SIGNAL_PC_H
+
+#ifdef CONFIG_LINUX
+#include <asm/ptrace.h>
+
+#define HAVE_HOST_SIGNAL_PC 1
+
+static inline uintptr_t host_signal_pc(const ucontext_t *uc)
+{
+    return uc->uc_mcontext.gp_regs[PT_NIP];
+}
+#else
+#define HAVE_HOST_SIGNAL_PC 0
+#endif
+
+#endif
diff --git a/host/include/riscv64/host/signal-pc.h b/host/include/riscv64/host/signal-pc.h
new file mode 100644
index 0000000000..362b446040
--- /dev/null
+++ b/host/include/riscv64/host/signal-pc.h
@@ -0,0 +1,20 @@
+/*
+ * Program counter of an interrupted riscv64 thread, from its signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef RISCV64_HOST_SIGNAL_PC_H
+#define RISCV64_HOST_SIGNAL_PC_H
+
+#ifdef CONFIG_LINUX
+#define HAVE_HOST_SIGNAL_PC 1
+
+static inline uintptr_t host_signal_pc(const ucontext_t *uc)
+{
+    return uc->uc_mcontext.__gregs[REG_PC];
+}
+#else
+#define HAVE_HOST_SIGNAL_PC 0
+#endif
+
+#endif
diff --git a/host/include/s390x/host/signal-pc.h b/host/include/s390x/host/signal-pc.h
new file mode 100644
index 0000000000..6ad809c911
--- /dev/null
+++ b/host/include/s390x/host/signal-pc.h
@@ -0,0 +1,20 @@
+/*
+ * Program counter of an interrupted s390x thread, from its signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef S390X_HOST_SIGNAL_PC_H
+#define S390X_HOST_SIGNAL_PC_H
+
+#ifdef CONFIG_LINUX
+#define HAVE_HOST_SIGNAL_PC 1
+
+static inline uintptr_t host_signal_pc(const ucontext_t *uc)
+{
+    return uc->uc_mcontext.psw.addr;
+}
+#else
+#define HAVE_HOST_SIGNAL_PC 0
+#endif
+
+#endif
diff --git a/host/include/x86_64/host/signal-pc.h b/host/include/x86_64/host/signal-pc.h
new file mode 100644
index 0000000000..c94ad2e976
--- /dev/null
+++ b/host/include/x86_64/host/signal-pc.h
@@ -0,0 +1,20 @@
+/*
+ * Program counter of an interrupted x86_64 thread, from its signal frame.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef X86_64_HOST_SIGNAL_PC_H
+#define X86_64_HOST_SIGNAL_PC_H
+
+#ifdef CONFIG_LINUX
+#define HAVE_HOST_SIGNAL_PC 1
+
+static inline uintptr_t host_signal_pc(const ucontext_t *uc)
+{
+    return uc->uc_mcontext.gregs[REG_RIP];
+}
+#else
+#define HAVE_HOST_SIGNAL_PC 0
+#endif
+
+#endif
diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 0bd08e0f7f..00eeb5dcc9 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -680,9 +680,10 @@ bool qemu_debugger_attached(void);
  * qemu_thread_states:
  *
  * Returns a newly allocated, newline terminated description of every thread
- * in this process apart from the caller: its id, name, scheduler state and
- * kernel stack, or NULL on a host that cannot report any of that. Where the
- * kernel stack is privileged the description falls back to a wait channel.
+ * in this process apart from the caller: its id, name, scheduler state, the
+ * program counter it stopped at and its kernel stack, or NULL on a host that
+ * cannot report any of that. A privileged kernel stack falls back to a wait
+ * channel, and a host with no way to read a program counter omits it.
  */
 char *qemu_thread_states(void);
 
diff --git a/meson.build b/meson.build
index cfac634cf1..25e8842918 100644
--- a/meson.build
+++ b/meson.build
@@ -2646,6 +2646,8 @@ config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
 config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
 config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
 config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
+config_host_data.set('CONFIG_DLADDR', cc.has_function('dladdr',
+                     prefix: osdep_prefix + '#include <dlfcn.h>'))
 config_host_data.set('HAVE_SYSTEM_FUNCTION', cc.has_function('system', prefix: '#include <stdlib.h>'))
 if rbd.found()
   config_host_data.set('HAVE_RBD_NAMESPACE_EXISTS',
diff --git a/util/oslib-posix.c b/util/oslib-posix.c
index 6a683b849e..ddc2b48df2 100644
--- a/util/oslib-posix.c
+++ b/util/oslib-posix.c
@@ -58,8 +58,13 @@
 #include <lwp.h>
 #endif
 
+#ifdef CONFIG_DLADDR
+#include <dlfcn.h>
+#endif
+
 #include "qemu/memalign.h"
 #include "qemu/mmap-alloc.h"
+#include "host/signal-pc.h"
 
 #define MAX_MEM_PREALLOC_THREAD_COUNT 32
 
@@ -168,8 +173,164 @@ static bool thread_stacks_readable(void)
     return readable;
 }
 
-static void append_thread_state(GString *out, const char *tid)
+/* Where a thread was, and where its line belongs in the report */
+typedef struct {
+    int tid;
+    size_t at;
+    void *pc;
+    int done;
+} ThreadPc;
+
+#if HAVE_HOST_SIGNAL_PC
+
+/* How long to wait for the answers, however many threads were asked */
+#define THREAD_PC_WAIT_MS 100
+
+/*
+ * Published to the handler, which runs in whichever thread was interrupted
+ * and so may only touch this with atomics: every qemu synchronisation
+ * primitive is built on a mutex, and none of them may be taken here.
+ * pc_handlers counts handlers between entry and exit, so the slots can be
+ * withdrawn and the last handler waited out before the caller frees them.
+ */
+static ThreadPc *pc_slots;
+static int pc_nslots;
+static int pc_handlers;
+
+static void thread_pc_handler(int sig, siginfo_t *si, void *ctx)
+{
+    ThreadPc *slots;
+    int me, i, n;
+
+    qatomic_inc(&pc_handlers);
+    smp_mb__after_rmw();
+    slots = qatomic_load_acquire(&pc_slots);
+    if (slots) {
+        n = qatomic_read(&pc_nslots);
+        me = qemu_get_thread_id();
+        for (i = 0; i < n; i++) {
+            if (qatomic_read(&slots[i].tid) == me) {
+                slots[i].pc = (void *)host_signal_pc(ctx);
+                qatomic_store_release(&slots[i].done, 1);
+                break;
+            }
+        }
+    }
+    qatomic_dec(&pc_handlers);
+}
+
+static bool thread_pc_armed(void)
+{
+    static int armed = -1;
+    struct sigaction sa;
+
+    if (armed >= 0) {
+        return armed;
+    }
+    memset(&sa, 0, sizeof(sa));
+    sa.sa_sigaction = thread_pc_handler;
+    sa.sa_flags = SA_SIGINFO | SA_RESTART;
+    sigemptyset(&sa.sa_mask);
+    armed = sigaction(QEMU_SIG_INTROSPECT, &sa, NULL) == 0;
+    return armed;
+}
+
+/*
+ * Ask every thread at once. Asking one at a time would spend the timeout
+ * again for each thread that never answers, and the threads that never
+ * answer are the ones a hung qemu has most of.
+ */
+static void thread_pc_collect(GArray *slots)
 {
+    int64_t deadline;
+    guint i;
+    int left;
+
+    if (!slots->len || !thread_pc_armed()) {
+        return;
+    }
+    qatomic_set(&pc_nslots, slots->len);
+    qatomic_store_release(&pc_slots, &g_array_index(slots, ThreadPc, 0));
+
+    for (i = 0; i < slots->len; i++) {
+        ThreadPc *slot = &g_array_index(slots, ThreadPc, i);
+
+        if (qemu_kill_thread(slot->tid, QEMU_SIG_INTROSPECT) < 0) {
+            qatomic_store_release(&slot->done, -1);
+        }
+    }
+
+    deadline = g_get_monotonic_time() + THREAD_PC_WAIT_MS * 1000;
+    do {
+        left = 0;
+        for (i = 0; i < slots->len; i++) {
+            if (!qatomic_load_acquire(&g_array_index(slots, ThreadPc,
+                                                     i).done)) {
+                left++;
+            }
+        }
+        if (!left) {
+            break;
+        }
+        g_usleep(1000);
+    } while (g_get_monotonic_time() < deadline);
+
+    qatomic_set(&pc_slots, NULL);
+    /* Pairs with the barrier in thread_pc_handler() */
+    smp_mb();
+    while (qatomic_read(&pc_handlers)) {
+        g_usleep(1000);
+    }
+}
+
+static void insert_thread_pc(GString *out, const ThreadPc *slot)
+{
+    g_autofree char *line = NULL;
+    void *pc = slot->pc;
+#ifdef CONFIG_DLADDR
+    Dl_info info = { };
+#endif
+
+    if (qatomic_read(&slot->done) != 1 || !pc) {
+        return;
+    }
+#ifdef CONFIG_DLADDR
+    if (dladdr(pc, &info) && info.dli_sname) {
+        line = g_strdup_printf("      pc %p %s+0x%tx\n", pc, info.dli_sname,
+                               (char *)pc - (char *)info.dli_saddr);
+    } else if (info.dli_fname && info.dli_fbase) {
+        /*
+         * dladdr() only knows exported symbols, so an address inside a
+         * library's own internals has none. The object and the offset
+         * within it still resolve later, the raw address does not.
+         */
+        g_autofree char *obj = g_path_get_basename(info.dli_fname);
+
+        line = g_strdup_printf("      pc %p %s+0x%tx\n", pc, obj,
+                               (char *)pc - (char *)info.dli_fbase);
+    }
+#endif
+    if (!line) {
+        line = g_strdup_printf("      pc %p\n", pc);
+    }
+    g_string_insert(out, slot->at, line);
+}
+
+#else
+
+static void thread_pc_collect(GArray *slots)
+{
+}
+
+static void insert_thread_pc(GString *out, const ThreadPc *slot)
+{
+}
+
+#endif /* HAVE_HOST_SIGNAL_PC */
+
+static void append_thread_state(GString *out, GArray *slots, const char *tid)
+{
+    ThreadPc slot = { };
     g_autofree char *comm = read_task_file(tid, "comm");
     g_autofree char *stat = NULL;
     g_autofree char *stack = NULL;
@@ -194,6 +355,10 @@ static void append_thread_state(GString *out, const char *tid)
     }
     g_string_append_printf(out, "  %-7s %-16s %c\n", tid, comm, state);
 
+    slot.tid = atoi(tid);
+    slot.at = out->len;
+    g_array_append_val(slots, slot);
+
     /* A running thread has no settled kernel stack to unwind */
     if (state != 'R' && thread_stacks_readable()) {
         stack = read_task_file(tid, "stack");
@@ -220,8 +385,10 @@ static void append_thread_state(GString *out, const char *tid)
 char *qemu_thread_states(void)
 {
     g_autoptr(GDir) dir = g_dir_open("/proc/self/task", 0, NULL);
+    g_autoptr(GArray) slots = g_array_new(FALSE, TRUE, sizeof(ThreadPc));
     const char *tid;
     GString *out;
+    guint i;
 
     if (!dir) {
         return NULL;
@@ -232,13 +399,23 @@ char *qemu_thread_states(void)
     out = g_string_new(NULL);
     while ((tid = g_dir_read_name(dir))) {
         if (atoi(tid) != qemu_get_thread_id()) {
-            append_thread_state(out, tid);
+            append_thread_state(out, slots, tid);
         }
     }
     if (!out->len) {
         g_string_free(out, TRUE);
         return NULL;
     }
+
+    /*
+     * Only now, with every passive read taken, disturb the threads. Insert
+     * from the back so the offsets recorded above stay where they were.
+     */
+    thread_pc_collect(slots);
+    for (i = slots->len; i > 0; i--) {
+        insert_thread_pc(out, &g_array_index(slots, ThreadPc, i - 1));
+    }
+
     return g_string_free(out, FALSE);
 }
 
-- 
2.53.0


