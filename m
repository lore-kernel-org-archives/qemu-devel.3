Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DE8CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huy-0005S1-9m; Fri, 03 Oct 2025 11:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huo-0005LS-5A
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4hts-0007jJ-Gn
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=85evjCkzA4rz72jPuSh0adwcSbJfJuVR+xX2fDSDkTU=;
 b=RrdlRR4s6+0dD/+UAMcwOpyRwFRFj4p1kEzleyJx1f7GY+BIuWedxtglWK6JxrEpOghb4I
 cBitUe96uQVO/HKm0+0lkzO+jtoirsxj/l/hAyY9llUnXfdTqD0airDZeV9cNMMQcQIrsb
 xQFLCJ7NbqKHNriCy77zdZV0lSd4ocU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-IM2M7ITdMDSBTKrxa6Oagw-1; Fri, 03 Oct 2025 11:40:42 -0400
X-MC-Unique: IM2M7ITdMDSBTKrxa6Oagw-1
X-Mimecast-MFC-AGG-ID: IM2M7ITdMDSBTKrxa6Oagw_1759506042
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-79a3c16b276so48281586d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506042; x=1760110842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=85evjCkzA4rz72jPuSh0adwcSbJfJuVR+xX2fDSDkTU=;
 b=ms7dfMbtyB5MH/ohJrvbIbP3X6q5OOW4zkMeButfnqjvpMdLxgQQoCKr64iUvXIScH
 z1JDd1MADyhD7jmXbUQ1gSOEQuon6tQwwl+eauzKhHpEob0JV76V256W82QS65SHV03m
 cDzw4eYH+nP/j8Sqbb32VllwKwhZoSomx6DwCd591UpH3NRMfsnOdlXp1ebyZfJAwIyY
 DOb9Xi/z96wAQmJ9NqQ5CUZ0TakpQBwbOxB6JleGDv5ETNJmphwtLDoPU09ZiGseX1+D
 7DG1CQmis/Gc5djNud/fExEnn6SvSd61UAbwtiwgFRmlErF0YqEbCcbg1JgecCBfRTPP
 dqsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjhpP40Ujq0QUTKnGNVRqS7TBDeWkdNNXn8ldCVpQ6LY7u2/EzvPrhvQLH1H58sISzNlwSftrjVDd+@nongnu.org
X-Gm-Message-State: AOJu0Yx14bApZCy5UECcOclT7vtWNFOR88UaBD7Um00Lwa/swf6ZpzUP
 fyKoIzaDo58ZdXl2YI85kMP3TruqVnh38MBlzUA+cxW2aFsg3LvcKoYRloFWOFMtzlwo/AV6v15
 9LbBirk89LECXi3jyJul2ZtYdP0zx4kaL4Ue3MYSmBpN/FIh9Mw7xvDwy
X-Gm-Gg: ASbGncs3HnrGcV4TYF2IspIwAxaWSi2SP58LouYKT9VoCDYjjDg34DWnoM6hPr9r/el
 pkGEWn2pY0cSKgCUX3MZQGbkaRYctvc6gHmLp9vf5+U2Lad02HyQ1Z3xG+XyVzmExSoIZtuoTxq
 OMd+mdyEAxYNqfLQQpjjONJFi9jUmdn9CtCTNTBgmELm9peWl+HEGF2R2+JqP5wssVybn1gEYUR
 mZ/l28wPUUr7xJNPaEOsB+jdbCaVrTiOFF8mH08jkc3Ihc4peOLZ4E9sztDZNRgWLmsnD2/XS4t
 0d1rHDcvhPuew9X7WZRCbSctvPNoqLU3Fm/8WQ==
X-Received: by 2002:a05:6214:6003:b0:879:df50:3a24 with SMTP id
 6a1803df08f44-879df5075a3mr23662336d6.49.1759506041694; 
 Fri, 03 Oct 2025 08:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDBCa1gzNRZkT5IEyAhHzXUfR8b1S1AlTDHDR9LSv2/dEXVpTj4+7hRJIix42IFDUAzqt53A==
X-Received: by 2002:a05:6214:6003:b0:879:df50:3a24 with SMTP id
 6a1803df08f44-879df5075a3mr23660536d6.49.1759506041085; 
 Fri, 03 Oct 2025 08:40:41 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:40 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 35/45] physmem: Destroy all CPU AddressSpaces on unrealize
Date: Fri,  3 Oct 2025 11:39:38 -0400
Message-ID: <20251003153948.1304776-36-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.467,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

When we unrealize a CPU object (which happens on vCPU hot-unplug), we
should destroy all the AddressSpace objects we created via calls to
cpu_address_space_init() when the CPU was realized.

Commit 24bec42f3d6eae added a function to do this for a specific
AddressSpace, but did not add any places where the function was
called.

Since we always want to destroy all the AddressSpaces on unrealize,
regardless of the target architecture, we don't need to try to keep
track of how many are still undestroyed, or make the target
architecture code manually call a destroy function for each AS it
created.  Instead we can adjust the function to always completely
destroy the whole cpu->ases array, and arrange for it to be called
during CPU unrealize as part of the common code.

Without this fix, AddressSanitizer will report a leak like this
from a run where we hot-plugged and then hot-unplugged an x86 KVM
vCPU:

Direct leak of 416 byte(s) in 1 object(s) allocated from:
    #0 0x5b638565053d in calloc (/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/qemu-system-x86_64+0x1ee153d) (BuildId: c1cd6022b195142106e1bffeca23498c2b752bca)
    #1 0x7c28083f77b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5b6386999c7c in cpu_address_space_init /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../system/physmem.c:797:25
    #3 0x5b638727f049 in kvm_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/kvm/kvm-cpu.c:102:5
    #4 0x5b6385745f40 in accel_cpu_common_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../accel/accel-common.c:101:13
    #5 0x5b638568fe3c in cpu_exec_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/cpu-common.c:232:10
    #6 0x5b63874a2cd5 in x86_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/cpu.c:9321:5
    #7 0x5b6387a0469a in device_set_realized /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:494:13
    #8 0x5b6387a27d9e in property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:2375:5
    #9 0x5b6387a2090b in object_property_set /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1450:5
    #10 0x5b6387a35b05 in object_property_set_qobject /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/qom-qobject.c:28:10
    #11 0x5b6387a21739 in object_property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1520:15
    #12 0x5b63879fe510 in qdev_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:276:12

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2517
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-4-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/exec/cpu-common.h          | 10 +++++-----
 include/hw/core/cpu.h              |  1 -
 hw/core/cpu-common.c               |  1 +
 stubs/cpu-destroy-address-spaces.c | 15 ++++++++++++++
 system/physmem.c                   | 32 ++++++++++++++----------------
 stubs/meson.build                  |  1 +
 6 files changed, 37 insertions(+), 23 deletions(-)
 create mode 100644 stubs/cpu-destroy-address-spaces.c

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f373781ae0..b96ac49844 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -123,13 +123,13 @@ size_t qemu_ram_pagesize_largest(void);
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr);
 /**
- * cpu_address_space_destroy:
- * @cpu: CPU for which address space needs to be destroyed
- * @asidx: integer index of this address space
+ * cpu_destroy_address_spaces:
+ * @cpu: CPU for which address spaces need to be destroyed
  *
- * Note that with KVM only one address space is supported.
+ * Destroy all address spaces associated with this CPU; this
+ * is called as part of unrealizing the CPU.
  */
-void cpu_address_space_destroy(CPUState *cpu, int asidx);
+void cpu_destroy_address_spaces(CPUState *cpu);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index c9f40c2539..0fcbc923f3 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -515,7 +515,6 @@ struct CPUState {
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     struct CPUAddressSpace *cpu_ases;
-    int cpu_ases_count;
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 41a339903c..8c306c89e4 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -294,6 +294,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
      * accel_cpu_common_unrealize, which may free fields using call_rcu.
      */
     accel_cpu_common_unrealize(cpu);
+    cpu_destroy_address_spaces(cpu);
 }
 
 static void cpu_common_initfn(Object *obj)
diff --git a/stubs/cpu-destroy-address-spaces.c b/stubs/cpu-destroy-address-spaces.c
new file mode 100644
index 0000000000..dc6813f5bd
--- /dev/null
+++ b/stubs/cpu-destroy-address-spaces.c
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "exec/cpu-common.h"
+
+/*
+ * user-mode CPUs never create address spaces with
+ * cpu_address_space_init(), so the cleanup function doesn't
+ * need to do anything. We need this stub because cpu-common.c
+ * is built-once so it can't #ifndef CONFIG_USER around the
+ * call; the real function is in physmem.c which is system-only.
+ */
+void cpu_destroy_address_spaces(CPUState *cpu)
+{
+}
diff --git a/system/physmem.c b/system/physmem.c
index ae8ecd50ea..dbb2a4e017 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -795,7 +795,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
-        cpu->cpu_ases_count = cpu->num_ases;
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -809,30 +808,29 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 }
 
-void cpu_address_space_destroy(CPUState *cpu, int asidx)
+void cpu_destroy_address_spaces(CPUState *cpu)
 {
     CPUAddressSpace *cpuas;
+    int asidx;
 
     assert(cpu->cpu_ases);
-    assert(asidx >= 0 && asidx < cpu->num_ases);
 
-    cpuas = &cpu->cpu_ases[asidx];
-    if (tcg_enabled()) {
-        memory_listener_unregister(&cpuas->tcg_as_listener);
-    }
+    /* convenience alias just points to some cpu_ases[n] */
+    cpu->as = NULL;
 
-    address_space_destroy(cpuas->as);
-    g_free_rcu(cpuas->as, rcu);
-
-    if (asidx == 0) {
-        /* reset the convenience alias for address space 0 */
-        cpu->as = NULL;
+    for (asidx = 0; asidx < cpu->num_ases; asidx++) {
+        cpuas = &cpu->cpu_ases[asidx];
+        if (!cpuas->as) {
+            /* This index was never initialized; no deinit needed */
+            continue;
+        }
+        if (tcg_enabled()) {
+            memory_listener_unregister(&cpuas->tcg_as_listener);
+        }
+        g_clear_pointer(&cpuas->as, address_space_destroy_free);
     }
 
-    if (--cpu->cpu_ases_count == 0) {
-        g_free(cpu->cpu_ases);
-        cpu->cpu_ases = NULL;
-    }
+    g_clear_pointer(&cpu->cpu_ases, g_free);
 }
 
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e685..5d577467bf 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,6 +55,7 @@ endif
 if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
+  stub_ss.add(files('cpu-destroy-address-spaces.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
   # they are not built at all for --disable-system builds.
-- 
2.50.1


