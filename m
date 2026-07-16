Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6885BC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMsC-0006ts-Jm; Thu, 16 Jul 2026 10:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wkLzD-0003Nh-J8
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:18:48 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mike.malyshev@gmail.com>)
 id 1wkLzB-0004Ow-1S
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 09:18:47 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso1161685e9.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 06:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784207922; x=1784812722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AYiOSLZ05BXXFHEk68Bw7Gj8xG73Q2VclyfmnlPY5aw=;
 b=jhA4CK5mooS57UzWx3imv+Ip5wJP031DVdIvws0u7TdRP+Rnzp3OA+6EyJCbcpcV8B
 BE4kvIt1wRcpHOXWZDLybgZhtI03AilCCobuTBYBpHXNJvboNcISEzzgeJLC/dGUvvct
 LZTMpv57J2kjAm2qQBjwTQUTw4MRecn1wgeLHTLW0pO9kSEx+m8WlVOoi66ok/ZY1Ujy
 qxhNKeY20nC5WRfqHgipezuzVvYaB3H+ShPT+ur51zOUDewzSu/oL3db5jFWz39QtTX+
 1fTUZmX4uxHNK4WqVZyAxruO83I0FjaryupyMkvaBPWFfNsAx27wpI3NgdVcOIDFM8H3
 5evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784207922; x=1784812722;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AYiOSLZ05BXXFHEk68Bw7Gj8xG73Q2VclyfmnlPY5aw=;
 b=VSyh4d0djkNsGGbaiVe7H/4walygJmcyBTyGCbVoN3PlEQ5LBqFrGOEVC+sFDscbOW
 ZQWYcCQ4gfYiedapUW1A87h+jud2E0JMUphgLpFT6FsowGDf1bTXuasBgK9lFROl8k/M
 Tf/w+8vxo9J4UIYcPrtxYRNVLamNI4K0Nhurc+2N8PuHyKtja44kazdwCANz2zjgpUeg
 r3qewcUSDYdh2N0z67T4qyWWQ9xzoifeqH9h2qm1IO3gNK5WCl1aPRxrt9CM28ztOP+G
 D+fkslGaS6T85qSE3It8Hn+4JNw8VdKe//c9zLdWxwgY/bS9YtRBriySsOz8eCu/Cug0
 mcTQ==
X-Gm-Message-State: AOJu0Yyc/5P7FUNZz8EVXu+qx1ywg29jGg4iY8+I4AW9MvszIp63l4vV
 NRjCpJuocBzKdxX+F1N4LCEs72yc8oGg7DBsfsIC4OMV/FFx/Z6QSIoUxvCe2NWbwGE=
X-Gm-Gg: AfdE7ckusskD5urht6ct5b2K8eqJFXjZFhMWIZYUCe/5jlB4G0cb6NPKXY7Y0E52GPQ
 O5ZIceRJIm/wyEUZtj3HMB/Wvea/lGA8lh8PJJNxgE6Gtzn2BU46riUDAIYph8jIj1feqhpTxhF
 SmA1qXethTseWkxtrzQ6ZnDm+pVx20bgeY2kv5UtD4kOrQP7FTXs/6MRaa3/BSMuLyeBTAD8zbA
 rCVw4BmFZjfE+YGFwrgitT+8icDvLDkli8WiqedLdCfExoCLlJgcNTJ/py7tzuxn7ito6+CJjb+
 7POyUkju8Fp/wVcP+aV2UkQ5pW/VEH5+3DXKWL4EUIHlMDEidJOizkV+Tgsqeuf+93wzOlcgdBy
 YJmbLXZxJjtOY6rcbpCWKi9N+RlnGe+i+kBhJNcX7cn+3SZA+1hhbTt1lct4gT1/j9hRYnTuKec
 waz6T+uxg=
X-Received: by 2002:a05:600c:34c9:b0:492:3e44:214b with SMTP id
 5b1f17b1804b1-4953905c59emr121581365e9.13.1784207921418; 
 Thu, 16 Jul 2026 06:18:41 -0700 (PDT)
Received: from build-server.. ([62.96.37.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e7f8aesm64769805e9.1.2026.07.16.06.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:18:40 -0700 (PDT)
From: mike.malyshev@gmail.com
To: qemu-devel@nongnu.org
Cc: Mikhail Malyshev <mike.malyshev@gmail.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH] hw/vfio: recover from disabled-BAR mmap SIGBUS as
 Unsupported Request
Date: Thu, 16 Jul 2026 13:18:39 +0000
Message-ID: <20260716131839.1522870-1-mike.malyshev@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=mike.malyshev@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Jul 2026 10:15:34 -0400
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

From: Mikhail Malyshev <mike.malyshev@gmail.com>

A guest that clears PCI_COMMAND.MEM on a passed-through device makes
vfio-pci invalidate the device's BAR mmaps in the kernel: any access
to them then faults with BUS_ADRERR. A vCPU MMIO access that races
the resulting BAR teardown can reach
memory_region_ram_device_{read,write}() against a mmap the kernel has
already invalidated and take SIGBUS, which qemu turns into a fatal
abort of the whole VM.

This is not a contrived race: real multi-vCPU guest drivers clear a
device's PCI_COMMAND.MEM (memory decode) on one vCPU while other
vCPUs are still issuing MMIO to that device's BAR, and this has been
observed with Intel integrated-GPU drivers in a Windows guest under
vfio passthrough, so the racing MMIO during teardown is ordinary
guest behavior.

On real hardware an access to a BAR whose memory decode is disabled
is answered by the PCIe layer with an Unsupported Request: reads
return all-ones, writes are dropped, and the instruction completes.
Emulate that instead of aborting.

Record each ram_device mmap host range as it is (un)mapped, arm a
per-thread sigsetjmp checkpoint around the raw load/store in the
ram_device ops, and have the SIGBUS handler longjmp back to it when a
non-MCE fault address falls in one of those ranges. Mirrors the
SIGBUS-recovery idiom already used by qemu_prealloc_mem(). MCE and
non-vfio SIGBUS are unaffected.

Notes:
- A compiler barrier() brackets the guarded load/store so the
  ram_device_active guard is ordered around the faulting access
  rather than depending on codegen.
- Overflowing the mmap range table warns rather than silently leaving
  a range untracked (which would reintroduce the abort).
- sigsetjmp saves the signal mask (an rt_sigprocmask per trapped
  access); it cannot be dropped without leaving SIGBUS blocked after
  siglongjmp, so it is a deliberate cost on the trapped-MMIO slow path
  only, never the EPT fast path.

Link: https://lore.kernel.org/all/20260621133708.3454718-1-mike.malyshev@gmail.com/
Signed-off-by: Mikhail Malyshev <mike.malyshev@gmail.com>
---

Sent as RFC because:

(a) This is the VMM/SIGBUS half of a two-part PCI_COMMAND.MEM
    teardown-edge race. The KVM -EFAULT half (the kernel-side arrival
    of the same race) is handled separately via KVM_EXIT_MEMORY_FAULT
    and discussed at the Link above; a coordinated qemu memory-fault
    handler for that half will follow.

(b) The mmap range table currently lives in the generic
    system/memory.c ram_device path. It could instead be relocated
    into vfio, since vfio is presently the only user of ram_device
    regions that hits this race in practice.

(c) The per-access sigsetjmp on the trapped-MMIO slow path, and the
    alternative of keeping the ram_device MemoryRegion's enabled state
    synced with PCI_COMMAND.MEM (so the race window is closed instead
    of recovered from), are both open to maintainer direction.

(d) There is no clean single qemu commit that introduced this fault
    (it is the kernel vfio-pci mmap invalidation on PCI_COMMAND.MEM
    clear that makes the mapping fault); commit 4a2e242bbb30
    ("memory: Don't use memcpy for ram_device regions") is only where
    the now-recoverable ram_device dereference lives, so no Fixes:
    tag is asserted.

 hw/vfio/region.c        |   5 ++
 include/system/memory.h |  13 ++++
 system/cpus.c           |   9 +++
 system/memory.c         | 131 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index dbde339180..30f10e5857 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -280,6 +280,7 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
                             region->mmaps[index].offset +
                             region->mmaps[index].size - 1);
     memory_region_del_subregion(region->mem, &region->mmaps[index].mem);
+    memory_region_ram_device_del_range(region->mmaps[index].mmap);
     munmap(region->mmaps[index].mmap, region->mmaps[index].size);
     object_unparent(OBJECT(&region->mmaps[index].mem));
     region->mmaps[index].mmap = NULL;
@@ -428,6 +429,9 @@ int vfio_region_mmap(VFIORegion *region)
                                           memory_region_owner(region->mem),
                                           name, region->mmaps[i].size,
                                           region->mmaps[i].mmap);
+        /* track the mmap host range for disabled-BAR SIGBUS -> UR recovery */
+        memory_region_ram_device_add_range(region->mmaps[i].mmap,
+                                           region->mmaps[i].size);
         g_free(name);
         memory_region_add_subregion(region->mem, region->mmaps[i].offset,
                                     &region->mmaps[i].mem);
@@ -495,6 +499,7 @@ void vfio_region_finalize(VFIORegion *region)
 
     for (i = 0; i < region->nr_mmaps; i++) {
         if (region->mmaps[i].mmap) {
+            memory_region_ram_device_del_range(region->mmaps[i].mmap);
             munmap(region->mmaps[i].mmap, region->mmaps[i].size);
         }
     }
diff --git a/include/system/memory.h b/include/system/memory.h
index 47a0e06fbf..bcf1b4e735 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1278,6 +1278,19 @@ void memory_region_init_ram_device_ptr(MemoryRegion *mr,
                                        uint64_t size,
                                        void *ptr);
 
+/*
+ * vfio disabled-BAR SIGBUS recovery (see system/memory.c). vfio registers each
+ * BAR mmap host range so a racing MMIO into a just-invalidated mmap can be
+ * completed as an Unsupported Request instead of aborting qemu.
+ */
+void memory_region_ram_device_add_range(void *host, size_t size);
+void memory_region_ram_device_del_range(void *host);
+/*
+ * called from the SIGBUS handler; longjmps (no return) when it recovers.
+ * Recovers only for a BUS_ADRERR fault address in a tracked range.
+ */
+bool memory_region_ram_device_on_sigbus(void *addr, int si_code);
+
 /**
  * memory_region_init_alias: Initialize a memory region that aliases all or a
  *                           part of another memory region.
diff --git a/system/cpus.c b/system/cpus.c
index 97e5a5edee..22f77321b1 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -33,6 +33,7 @@
 #include "exec/gdbstub.h"
 #include "accel/accel-cpu-ops.h"
 #include "system/hw_accel.h"
+#include "system/memory.h"
 #include "exec/cpu-common.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
@@ -382,6 +383,14 @@ static void sigbus_reraise(void)
 static void sigbus_handler(int n, siginfo_t *siginfo, void *ctx)
 {
     if (siginfo->si_code != BUS_MCEERR_AO && siginfo->si_code != BUS_MCEERR_AR) {
+        /*
+         * Not an MCE. If this is a racing MMIO into a passed-through vfio BAR
+         * whose PCI_COMMAND.MEM was just cleared (mmap invalidated by the
+         * kernel), complete it as an Unsupported Request instead of aborting.
+         * memory_region_ram_device_on_sigbus() longjmps back into the
+         * ram_device access and does not return when it recovers.
+         */
+        memory_region_ram_device_on_sigbus(siginfo->si_addr, siginfo->si_code);
         sigbus_reraise();
     }
 
diff --git a/system/memory.c b/system/memory.c
index 5fc36708ec..db74606d45 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -14,6 +14,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
 #include "system/memory.h"
@@ -1364,11 +1365,129 @@ const MemoryRegionOps unassigned_mem_ops = {
     .endianness = DEVICE_NATIVE_ENDIAN,
 };
 
+/*
+ * vfio passthrough disabled-BAR SIGBUS recovery.
+ *
+ * When a guest clears PCI_COMMAND.MEM on a passed-through device, vfio-pci in
+ * the kernel invalidates the BAR's mmap: any access faults with BUS_ADRERR. A
+ * vCPU MMIO access that races the teardown reaches the ram_device ops below
+ * against the just-invalidated mmap and takes SIGBUS, which qemu would turn
+ * into an abort. On real hardware an access to a MEM=0 BAR is answered with an
+ * Unsupported Request (reads return all-ones, writes are dropped).
+ *
+ * Recover to those semantics: record each ram_device mmap host range, arm a
+ * sigsetjmp checkpoint around the raw load/store, and let the SIGBUS handler
+ * (system/cpus.c) longjmp back here when the fault address is one of our
+ * ranges. Same idiom as qemu_prealloc_mem() in util/oslib-posix.c.
+ */
+typedef struct RamDeviceRange {
+    uintptr_t start;
+    uintptr_t end;
+} RamDeviceRange;
+#define RAM_DEVICE_MAX_RANGES 64
+static RamDeviceRange ram_device_ranges[RAM_DEVICE_MAX_RANGES];
+/*
+ * Mutated only from the vfio mmap/munmap paths (device (un)realize), which run
+ * under the BQL; read locklessly from the SIGBUS handler on the faulting vCPU
+ * thread. The range set is tied to the device mmap lifecycle, not to the
+ * MEM-toggle path that triggers the fault, so a fault never races an add/del
+ * of its own range. (If a non-BQL ram_device dispatch or vfio unmap path were
+ * ever added, this swap-remove would need to become atomic.)
+ */
+static int ram_device_nranges;
+
+void memory_region_ram_device_add_range(void *host, size_t size)
+{
+    if (!host) {
+        return;
+    }
+    if (ram_device_nranges >= RAM_DEVICE_MAX_RANGES) {
+        /*
+         * Don't drop it silently: an untracked mmap reintroduces the fatal
+         * abort this recovery prevents, so make the failure mode observable.
+         */
+        warn_report("ram_device SIGBUS recovery: range table full (%d); "
+                    "host %p (0x%zx) left untracked, a racing MMIO to it "
+                    "while its BAR is disabled would abort qemu",
+                    RAM_DEVICE_MAX_RANGES, host, size);
+        return;
+    }
+    ram_device_ranges[ram_device_nranges].start = (uintptr_t)host;
+    ram_device_ranges[ram_device_nranges].end = (uintptr_t)host + size;
+    ram_device_nranges++;
+}
+
+void memory_region_ram_device_del_range(void *host)
+{
+    int i;
+    for (i = 0; i < ram_device_nranges; i++) {
+        if (ram_device_ranges[i].start == (uintptr_t)host) {
+            ram_device_ranges[i] = ram_device_ranges[--ram_device_nranges];
+            return;
+        }
+    }
+}
+
+static bool ram_device_addr_known(uintptr_t addr)
+{
+    /* snapshot for the lockless signal-context read */
+    int i, n = ram_device_nranges;
+
+    for (i = 0; i < n; i++) {
+        if (addr >= ram_device_ranges[i].start &&
+            addr < ram_device_ranges[i].end) {
+            return true;
+        }
+    }
+    return false;
+}
+
+/* per-thread checkpoint, armed around the raw mmap access below */
+static __thread sigjmp_buf ram_device_env;
+static __thread volatile sig_atomic_t ram_device_active;
+
+/*
+ * Called from the SIGBUS handler on the faulting thread. If a ram_device
+ * access is in flight on this thread and the fault hit one of our mmap ranges,
+ * jump back to the checkpoint (does not return); otherwise return false.
+ */
+bool memory_region_ram_device_on_sigbus(void *addr, int si_code)
+{
+    if (si_code == BUS_ADRERR && ram_device_active &&
+        ram_device_addr_known((uintptr_t)addr)) {
+        siglongjmp(ram_device_env, 1);
+    }
+    return false;
+}
+
 static uint64_t memory_region_ram_device_read(void *opaque,
                                               hwaddr addr, unsigned size)
 {
     MemoryRegion *mr = opaque;
-    uint64_t data = ldn_he_p(mr->ram_block->host + addr, size);
+    uint64_t data;
+
+    /*
+     * sigsetjmp(env, 1) saves the signal mask (an rt_sigprocmask on glibc) on
+     * every trapped ram_device access. It can't be dropped: siglongjmp out of
+     * the SIGBUS handler must restore the mask or SIGBUS stays blocked on the
+     * thread. This is a deliberate per-access cost, incurred only on the
+     * trapped-MMIO slow path (quirked/sub-page BARs, teardown), never on the
+     * EPT fast path.
+     */
+    if (sigsetjmp(ram_device_env, 1)) {
+        /* mmap faulted (BUS_ADRERR): BAR MEM disabled -> Unsupported Request */
+        ram_device_active = 0;
+        data = (size >= 8) ? ~(uint64_t)0 : (((uint64_t)1 << (size * 8)) - 1);
+        trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data,
+                                            size);
+        return data;
+    }
+    ram_device_active = 1;
+    /* the guard must be set before the faulting load, reset after */
+    barrier();
+    data = ldn_he_p(mr->ram_block->host + addr, size);
+    barrier();
+    ram_device_active = 0;
 
     trace_memory_region_ram_device_read(get_cpu_index(), mr, addr, data, size);
 
@@ -1382,7 +1501,17 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
 
     trace_memory_region_ram_device_write(get_cpu_index(), mr, addr, data, size);
 
+    if (sigsetjmp(ram_device_env, 1)) {
+        /* mmap faulted (BUS_ADRERR): BAR MEM disabled -> drop write (UR) */
+        ram_device_active = 0;
+        return;
+    }
+    ram_device_active = 1;
+    /* the guard must be set before the faulting store, reset after */
+    barrier();
     stn_he_p(mr->ram_block->host + addr, size, data);
+    barrier();
+    ram_device_active = 0;
 }
 
 static const MemoryRegionOps ram_device_mem_ops = {
-- 
2.43.0


