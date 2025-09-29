Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C90CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3F5r-0004i4-0s; Mon, 29 Sep 2025 10:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5i-0004fE-4S
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:43:02 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v3F5S-0001lF-GJ
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:43:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e501a9034so9247165e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759156956; x=1759761756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRfXK8DLlmyxNn6fM1i82Qtqd0zzhs3o+KVizRy7jKM=;
 b=l3Ynnj90grEDwj+qrg2jxRr+zZhv7ISYN59O+qXRs133KtdV6B1gt2f2pXRl7kZsrm
 3EVzmMde9BbIlqDwHHrTfYu3VE8vWGTFouqwKuaHHVmPV6aFodQjfLB1Fk9hEPVQmd83
 8RS7tBnbGPTWbywutFuhip8uh2ncB1/PxRD3Jfm4WpRtL43cpXdCx/Pu062NEKke9rCe
 7i6vbWT/aMJyRKxYf3vTUWi4xkr65xHJEY15kfTwlXTU9cYq7mcflNbJV9kznS0wdDcB
 Gj1PAWd32iDtCHgFRFK4a4E08mLTp6HAhTplqxcS0LNeNGhPYd4TICgZAUGXTn1PrDWD
 mFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759156956; x=1759761756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRfXK8DLlmyxNn6fM1i82Qtqd0zzhs3o+KVizRy7jKM=;
 b=c6EfsXyq8hL+gIIMAGSmAsOJguCIgsE0Fzd6R21v6tHB9/gJbDEOcwtjtDdBM6a3gv
 MlvoJUe/iPIMOmOF9KPEn+jFyblf4/4TbM1TqmG2fvfwxUrPjNy7SRuf6DPcevu3VtV5
 oLxoJh2tbHd3BbFUWaT9mQfLtbh+3AojmkDRqAQ3+VZWSFR9WCWt8AZLYSk1mMljRRDu
 M5wu6XqZg31bZ3xp6Ihla2fabDXZ1eIZPTp7UuNRuClo+io/EnY/kxBmyWnQ1JL4eoNm
 MvrkrTImpVlvXtIod4b8JGnfBmCvcmC0QxUcmcEzefUnItyT7NHy5KCZPnpWrtgfYvU+
 wzMg==
X-Gm-Message-State: AOJu0Ywy9Ivy/GrEJEzrUFSxAuTNOUB5wXQBcsgFitEMtCLh4AEA+ukG
 GwcYgUsNS5LSgz/D0RWfqzVrrBb2Kvndmr1Wb5hXpfcMSFkatigjartVFOPuZ3DgXs6yDxIh/CB
 q9ufw
X-Gm-Gg: ASbGncvKN62OORSmPklbfNJ//a7xGGclg9GLPfX2JpfpCO6vsx8+cWVou/0qHGuCBQx
 DPvUn/9sTZEIRn1rkDozCdHemqk/jsjMFBWueahIN8S1qPYqlLTnHaEj/rN315DbiCFL3Z/j8Eo
 eHMD4J1po2K5MpXu2BdVlI5TjHVF3/oeSpe8xtjKXVNIFiPUE2wKio9AhsUxH3o/XreRbvbeBM+
 uZjyQAJYqlrlzgR7AuQXGR+fZ4GUkk46vhVswyaJ3AtrC11oq+5Trjm+q5W5NYySKH2DAwcbfWd
 L3gBNCnem4gfVBK9lLFek8ak8tVolg9KJue/eqfBYEPt2p9jCvqQ37MAS3KHcSCEDyONhW6pP/c
 NxfsIIyp/V2mj/TQz5kJCazOAl2JS
X-Google-Smtp-Source: AGHT+IGQEOcWVN7Mm8X8I1Xn7W5TML85UQLqnxCufY4UybG9TLkjl77E+4al6mJMJWV66tBejuLBIw==
X-Received: by 2002:a05:6000:2282:b0:3ee:1586:6c85 with SMTP id
 ffacd0b85a97d-40e50d6de49mr14594812f8f.57.1759156955553; 
 Mon, 29 Sep 2025 07:42:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f64849sm15893885e9.11.2025.09.29.07.42.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 07:42:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH 3/3] physmem: Destroy all CPU AddressSpaces on unrealize
Date: Mon, 29 Sep 2025 15:42:28 +0100
Message-ID: <20250929144228.1994037-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929144228.1994037-1-peter.maydell@linaro.org>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
---
 include/exec/cpu-common.h          | 10 ++++-----
 include/hw/core/cpu.h              |  1 -
 hw/core/cpu-common.c               |  1 +
 stubs/cpu-destroy-address-spaces.c | 15 +++++++++++++
 system/physmem.c                   | 34 ++++++++++++++----------------
 stubs/meson.build                  |  1 +
 6 files changed, 38 insertions(+), 24 deletions(-)
 create mode 100644 stubs/cpu-destroy-address-spaces.c

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f373781ae07..b96ac49844a 100644
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
index c9f40c25392..0fcbc923f38 100644
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
index 41a339903ca..8c306c89e45 100644
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
index 00000000000..dc6813f5bd1
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
index ae8ecd50ea1..dbb2a4e0175 100644
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
+    /* convenience alias just points to some cpu_ases[n] */
+    cpu->as = NULL;
+
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
 
-    address_space_destroy(cpuas->as);
-    g_free_rcu(cpuas->as, rcu);
-
-    if (asidx == 0) {
-        /* reset the convenience alias for address space 0 */
-        cpu->as = NULL;
-    }
-
-    if (--cpu->cpu_ases_count == 0) {
-        g_free(cpu->cpu_ases);
-        cpu->cpu_ases = NULL;
-    }
+    g_clear_pointer(&cpu->cpu_ases, g_free);
 }
 
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
diff --git a/stubs/meson.build b/stubs/meson.build
index cef046e6854..5d577467bfd 100644
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
2.43.0


