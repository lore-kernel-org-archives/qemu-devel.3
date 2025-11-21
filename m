Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B016FCFA76C
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMNzx-0004wL-02; Fri, 21 Nov 2025 05:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzT-0004gn-7V
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:44 -0500
Received: from p-east3-cluster3-host7-snip4-8.eps.apple.com ([57.103.86.71]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzF-0007te-P7
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:03:40 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 8618118000A3; Fri, 21 Nov 2025 10:02:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=ib4mNqe0dQAGQ3Xwgh234JlvMvgAmSzb+oH8FW78gws=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=buB7e0hSAr1ojcMwMM6QeLEG69wDSW06QBQJ1xEkhUnQwEVKaqWF9dOulRm3wORXIiHBcGNV2tseONrt0pvxVa+x/POy5cnxZ0GgrOxMwPPEIvk8fpUrcdr0WXgQXYD/AYNGYDp59yxrZmtxTi1e3x18fSBQY/v31Lc+q2bVInAsm9XXlknO5x4qQZCwGrvbSSJD37wMB4xZn660mJVoJS2ksaUNXF/CPL0gYJoPMaTxwVbFJxJAel4BRTeG4e59ODc9E9LzXpGioBg6OMbpmPUwGJJq1/U79c2BNWJmVWfBnSrc1Q0E7oC6IcfMvAz1aY5GfJ5MOW15znhQttkAfA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 1358818000B1; Fri, 21 Nov 2025 10:02:54 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v11 07/28] whpx: reshuffle common code
Date: Fri, 21 Nov 2025 11:02:19 +0100
Message-ID: <20251121100240.89117-8-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX66onAmNv3pWo
 x7fcTMSj+DFai8J/p/bTHnI6uQ/dBXNv7APR0I2lrlOlMQmAIuJflxwHJrigRsEuV5Wb+Bm8Ta7
 QlufsaYp8nyKLNnLN6Oym4l4TymMtN3Nhp4dnLIAOOuYsGwqwrSNOP2bQUH7u9rG5lrAnUrSgvv
 VmNb2l1Id9e1Ps9/czLpyenS0X8Ems9I8Dz5R7pWvFhfzeNKPHdeS6F5Ts3m9A6BmBgU+CkVyNa
 xjOwaIS8Za8y89Vkf8M5Nde6K9PszCFd6dDGoKIaHp38ImX9ulBfkkOZE1KnPv5TL3Ca4ZgvTym
 TtlPce/LEDV7TLjOgSR
X-Proofpoint-ORIG-GUID: JzGZpbUlFfPb9seSUiTNvs42f0z9q6UH
X-Authority-Info: v=2.4 cv=fMg0HJae c=1 sm=1 tr=0 ts=692038d3 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
 a=XtnWhMvHLvoGx0dyWtYA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: JzGZpbUlFfPb9seSUiTNvs42f0z9q6UH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 clxscore=1030 phishscore=0
 adultscore=0 spamscore=0
 malwarescore=0 suspectscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2511210076
X-JNJ: AAAAAAABUkknclyKDXJU+Ox61zVpz1sqmM0gmN8rpEkJwDax0n+goff9ZWISombnQ8p5qMFNN5SSMlENj91J+Lxjm9TrnPSpLb0vHwb80koVs279jx+ZcjVUGtI0LW3EI2AjMuun0r4mM6tF4f8OdqPHgiCNePri4fGWelBtr+tId1ivb+u56nIrP9lRfLbdnVkctW+H4UNoC1SawpoEEF6hIYYqf8lqPSilVplrxZHVwyu4DgqD1GQrsvofBqOLBXMRZV+Lymb1nuQhX6IjaX1r/hH9RPT0V2k9fKCfcHcDOhW2990zMl7IaiHf+9TmJtH1xbuzF7nTW9tV9qR6EOnM0t723CKOtGNdUmM2eqBHKXH3Fgzu48b0yeJaWUOs5bbpVcQfxdqQc1zBXPpJcj/FleBLqjghmxRY7ruN6p75m8e5Kim3VZ1M74WuTQW0jR5WYCCQnhIkceDPFKdXYpYTB/t7BYCzzskg6GKYi3dnCPPJHFzU6SNfAojBGfQxXeYCFQNfqps3S8wrJvl5NHA98/G4tYEi+DlZ516X33evtYakg4zsmULPb9GVY7SboLcUhZy3+p1d18sac3Ti04nAZ2R5UEq/6Vh5xSxOShW6kkh3Y2fwNcGGf8871hnm7+ok290YlTgvLpmb2+E69wgrPpPe2v0wwwQhr0N2BofcH6EvF7ZmDnyUFhNYKhfVq+OnfwAZlAXtXnG1Co4nqG7mTjmAYUhkA1n3Ucc=
Received-SPF: pass client-ip=57.103.86.71;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Some code can be shared between x86_64 and arm64 WHPX. Do so as much as reasonable.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS                  |   2 +
 accel/whpx/meson.build       |   1 +
 accel/whpx/whpx-common.c     | 562 +++++++++++++++++++++++++++++++++++
 include/system/whpx-all.h    |  20 ++
 include/system/whpx-common.h |  21 ++
 target/i386/whpx/whpx-all.c  | 551 +---------------------------------
 6 files changed, 616 insertions(+), 541 deletions(-)
 create mode 100644 accel/whpx/whpx-common.c
 create mode 100644 include/system/whpx-all.h
 create mode 100644 include/system/whpx-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fdd1401f0..8a9df6b283 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -555,6 +555,8 @@ F: target/i386/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
+F: include/system/whpx-common.h
+F: include/system/whpx-internal.h
 
 MSHV
 M: Magnus Kulke <magnus.kulke@linux.microsoft.com>
diff --git a/accel/whpx/meson.build b/accel/whpx/meson.build
index 7b3d6f1c1c..fad28dddcb 100644
--- a/accel/whpx/meson.build
+++ b/accel/whpx/meson.build
@@ -1,6 +1,7 @@
 whpx_ss = ss.source_set()
 whpx_ss.add(files(
   'whpx-accel-ops.c',
+  'whpx-common.c'
 ))
 
 specific_ss.add_all(when: 'CONFIG_WHPX', if_true: whpx_ss)
diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
new file mode 100644
index 0000000000..66c9238586
--- /dev/null
+++ b/accel/whpx/whpx-common.c
@@ -0,0 +1,562 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * QEMU Windows Hypervisor Platform accelerator (WHPX)
+ *
+ * Copyright Microsoft Corp. 2017
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "system/address-spaces.h"
+#include "system/ioport.h"
+#include "gdbstub/helpers.h"
+#include "qemu/accel.h"
+#include "accel/accel-ops.h"
+#include "system/whpx.h"
+#include "system/cpus.h"
+#include "system/runstate.h"
+#include "qemu/main-loop.h"
+#include "hw/boards.h"
+#include "hw/intc/ioapic.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "qapi/qapi-types-common.h"
+#include "qapi/qapi-visit-common.h"
+#include "migration/blocker.h"
+#include "accel/accel-cpu-target.h"
+#include <winerror.h>
+
+#include "system/whpx-internal.h"
+#include "system/whpx-accel-ops.h"
+#include "system/whpx-common.h"
+#include "system/whpx-all.h"
+
+#include <winhvplatform.h>
+#include <winhvplatformdefs.h>
+
+bool whpx_allowed;
+static bool whp_dispatch_initialized;
+static HMODULE hWinHvPlatform;
+static HMODULE hWinHvEmulation;
+
+struct whpx_state whpx_global;
+struct WHPDispatch whp_dispatch;
+
+/* Tries to find a breakpoint at the specified address. */
+struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address)
+{
+    struct whpx_state *whpx = &whpx_global;
+    int i;
+
+    if (whpx->breakpoints.breakpoints) {
+        for (i = 0; i < whpx->breakpoints.breakpoints->used; i++) {
+            if (address == whpx->breakpoints.breakpoints->data[i].address) {
+                return &whpx->breakpoints.breakpoints->data[i];
+            }
+        }
+    }
+
+    return NULL;
+}
+
+/*
+ * This function is called when the a VCPU is about to start and no other
+ * VCPUs have been started so far. Since the VCPU start order could be
+ * arbitrary, it doesn't have to be VCPU#0.
+ *
+ * It is used to commit the breakpoints into memory, and configure WHPX
+ * to intercept debug exceptions.
+ *
+ * Note that whpx_set_exception_exit_bitmap() cannot be called if one or
+ * more VCPUs are already running, so this is the best place to do it.
+ */
+int whpx_first_vcpu_starting(CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+
+    g_assert(bql_locked());
+
+    if (!QTAILQ_EMPTY(&cpu->breakpoints) ||
+            (whpx->breakpoints.breakpoints &&
+             whpx->breakpoints.breakpoints->used)) {
+        CPUBreakpoint *bp;
+        int i = 0;
+        bool update_pending = false;
+
+        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
+            if (i >= whpx->breakpoints.original_address_count ||
+                bp->pc != whpx->breakpoints.original_addresses[i]) {
+                update_pending = true;
+            }
+
+            i++;
+        }
+
+        if (i != whpx->breakpoints.original_address_count) {
+            update_pending = true;
+        }
+
+        if (update_pending) {
+            /*
+             * The CPU breakpoints have changed since the last call to
+             * whpx_translate_cpu_breakpoints(). WHPX breakpoints must
+             * now be recomputed.
+             */
+            whpx_translate_cpu_breakpoints(&whpx->breakpoints, cpu, i);
+        }
+        /* Actually insert the breakpoints into the memory. */
+        whpx_apply_breakpoints(whpx->breakpoints.breakpoints, cpu, true);
+    }
+    HRESULT hr;
+    uint64_t exception_mask;
+    if (whpx->step_pending ||
+        (whpx->breakpoints.breakpoints &&
+         whpx->breakpoints.breakpoints->used)) {
+        /*
+         * We are either attempting to single-step one or more CPUs, or
+         * have one or more breakpoints enabled. Both require intercepting
+         * the WHvX64ExceptionTypeBreakpointTrap exception.
+         */
+        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+    } else {
+        /* Let the guest handle all exceptions. */
+        exception_mask = 0;
+    }
+    hr = whpx_set_exception_exit_bitmap(exception_mask);
+    if (!SUCCEEDED(hr)) {
+        error_report("WHPX: Failed to update exception exit mask,"
+                     "hr=%08lx.", hr);
+        return 1;
+    }
+    return 0;
+}
+
+/*
+ * This function is called when the last VCPU has finished running.
+ * It is used to remove any previously set breakpoints from memory.
+ */
+int whpx_last_vcpu_stopping(CPUState *cpu)
+{
+    whpx_apply_breakpoints(whpx_global.breakpoints.breakpoints, cpu, false);
+    return 0;
+}
+
+static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
+{
+    if (!cpu->vcpu_dirty) {
+        whpx_get_registers(cpu);
+        cpu->vcpu_dirty = true;
+    }
+}
+
+static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
+                                               run_on_cpu_data arg)
+{
+    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
+    cpu->vcpu_dirty = false;
+}
+
+static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
+                                              run_on_cpu_data arg)
+{
+    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
+    cpu->vcpu_dirty = false;
+}
+
+static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
+                                               run_on_cpu_data arg)
+{
+    cpu->vcpu_dirty = true;
+}
+
+/*
+ * CPU support.
+ */
+
+void whpx_cpu_synchronize_state(CPUState *cpu)
+{
+    if (!cpu->vcpu_dirty) {
+        run_on_cpu(cpu, do_whpx_cpu_synchronize_state, RUN_ON_CPU_NULL);
+    }
+}
+
+void whpx_cpu_synchronize_post_reset(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_whpx_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
+}
+
+void whpx_cpu_synchronize_post_init(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_whpx_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
+}
+
+void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
+{
+    run_on_cpu(cpu, do_whpx_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
+}
+
+static void whpx_pre_resume_vm(AccelState *as, bool step_pending)
+{
+    whpx_global.step_pending = step_pending;
+}
+
+/*
+ * Vcpu support.
+ */
+
+int whpx_vcpu_exec(CPUState *cpu)
+{
+    int ret;
+    int fatal;
+
+    for (;;) {
+        if (cpu->exception_index >= EXCP_INTERRUPT) {
+            ret = cpu->exception_index;
+            cpu->exception_index = -1;
+            break;
+        }
+
+        fatal = whpx_vcpu_run(cpu);
+
+        if (fatal) {
+            error_report("WHPX: Failed to exec a virtual processor");
+            abort();
+        }
+    }
+
+    return ret;
+}
+
+void whpx_destroy_vcpu(CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+
+    whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+    AccelCPUState *vcpu = cpu->accel;
+    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+    g_free(cpu->accel);
+}
+
+
+void whpx_vcpu_kick(CPUState *cpu)
+{
+    struct whpx_state *whpx = &whpx_global;
+    whp_dispatch.WHvCancelRunVirtualProcessor(
+        whpx->partition, cpu->cpu_index, 0);
+}
+
+/*
+ * Memory support.
+ */
+
+static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
+                                void *host_va, int add, int rom,
+                                const char *name)
+{
+    struct whpx_state *whpx = &whpx_global;
+    HRESULT hr;
+
+    /*
+    if (add) {
+        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
+               (void*)start_pa, (void*)size, host_va,
+               (rom ? "ROM" : "RAM"), name);
+    } else {
+        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
+               (void*)start_pa, (void*)size, host_va, name);
+    }
+    */
+
+    if (add) {
+        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
+                                         host_va,
+                                         start_pa,
+                                         size,
+                                         (WHvMapGpaRangeFlagRead |
+                                          WHvMapGpaRangeFlagExecute |
+                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
+    } else {
+        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
+                                           start_pa,
+                                           size);
+    }
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
+                     " Host:%p, hr=%08lx",
+                     (add ? "MAP" : "UNMAP"), name,
+                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
+    }
+}
+
+static void whpx_process_section(MemoryRegionSection *section, int add)
+{
+    MemoryRegion *mr = section->mr;
+    hwaddr start_pa = section->offset_within_address_space;
+    ram_addr_t size = int128_get64(section->size);
+    unsigned int delta;
+    uint64_t host_va;
+
+    if (!memory_region_is_ram(mr)) {
+        return;
+    }
+
+    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
+    delta &= ~qemu_real_host_page_mask();
+    if (delta > size) {
+        return;
+    }
+    start_pa += delta;
+    size -= delta;
+    size &= qemu_real_host_page_mask();
+    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
+        return;
+    }
+
+    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
+            + section->offset_within_region + delta;
+
+    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
+                        memory_region_is_rom(mr), mr->name);
+}
+
+static void whpx_region_add(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    memory_region_ref(section->mr);
+    whpx_process_section(section, 1);
+}
+
+static void whpx_region_del(MemoryListener *listener,
+                           MemoryRegionSection *section)
+{
+    whpx_process_section(section, 0);
+    memory_region_unref(section->mr);
+}
+
+static void whpx_transaction_begin(MemoryListener *listener)
+{
+}
+
+static void whpx_transaction_commit(MemoryListener *listener)
+{
+}
+
+static void whpx_log_sync(MemoryListener *listener,
+                         MemoryRegionSection *section)
+{
+    MemoryRegion *mr = section->mr;
+
+    if (!memory_region_is_ram(mr)) {
+        return;
+    }
+
+    memory_region_set_dirty(mr, 0, int128_get64(section->size));
+}
+
+static MemoryListener whpx_memory_listener = {
+    .name = "whpx",
+    .begin = whpx_transaction_begin,
+    .commit = whpx_transaction_commit,
+    .region_add = whpx_region_add,
+    .region_del = whpx_region_del,
+    .log_sync = whpx_log_sync,
+    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
+};
+
+void whpx_memory_init(void)
+{
+    memory_listener_register(&whpx_memory_listener, &address_space_memory);
+}
+
+/*
+ * Load the functions from the given library, using the given handle. If a
+ * handle is provided, it is used, otherwise the library is opened. The
+ * handle will be updated on return with the opened one.
+ */
+static bool load_whp_dispatch_fns(HMODULE *handle,
+    WHPFunctionList function_list)
+{
+    HMODULE hLib = *handle;
+
+    #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
+    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
+    #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature) \
+        whp_dispatch.function_name = \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+
+    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
+        whp_dispatch.function_name = \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+        if (!whp_dispatch.function_name) { \
+            error_report("Could not load function %s", #function_name); \
+            goto error; \
+        } \
+
+    #define WHP_LOAD_LIB(lib_name, handle_lib) \
+    if (!handle_lib) { \
+        handle_lib = LoadLibrary(lib_name); \
+        if (!handle_lib) { \
+            error_report("Could not load library %s.", lib_name); \
+            goto error; \
+        } \
+    } \
+
+    switch (function_list) {
+    case WINHV_PLATFORM_FNS_DEFAULT:
+        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
+        LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
+        break;
+    case WINHV_EMULATION_FNS_DEFAULT:
+        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
+        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+        break;
+    case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
+        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
+        LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
+        break;
+    }
+
+    *handle = hLib;
+    return true;
+
+error:
+    if (hLib) {
+        FreeLibrary(hLib);
+    }
+
+    return false;
+}
+
+static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
+                                   const char *name, void *opaque,
+                                   Error **errp)
+{
+    struct whpx_state *whpx = &whpx_global;
+    OnOffSplit mode;
+
+    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
+        return;
+    }
+
+    switch (mode) {
+    case ON_OFF_SPLIT_ON:
+        whpx->kernel_irqchip_allowed = true;
+        whpx->kernel_irqchip_required = true;
+        break;
+
+    case ON_OFF_SPLIT_OFF:
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        break;
+
+    case ON_OFF_SPLIT_SPLIT:
+        error_setg(errp, "WHPX: split irqchip currently not supported");
+        error_append_hint(errp,
+            "Try without kernel-irqchip or with kernel-irqchip=on|off");
+        break;
+
+    default:
+        /*
+         * The value was checked in visit_type_OnOffSplit() above. If
+         * we get here, then something is wrong in QEMU.
+         */
+        abort();
+    }
+}
+
+static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
+
+    acc->cpu_instance_init = whpx_cpu_instance_init;
+}
+
+static const TypeInfo whpx_cpu_accel_type = {
+    .name = ACCEL_CPU_NAME("whpx"),
+
+    .parent = TYPE_ACCEL_CPU,
+    .class_init = whpx_cpu_accel_class_init,
+    .abstract = true,
+};
+
+/*
+ * Partition support
+ */
+
+bool whpx_apic_in_platform(void)
+{
+    return whpx_global.apic_in_platform;
+}
+
+static void whpx_accel_class_init(ObjectClass *oc, const void *data)
+{
+    AccelClass *ac = ACCEL_CLASS(oc);
+    ac->name = "WHPX";
+    ac->init_machine = whpx_accel_init;
+    ac->pre_resume_vm = whpx_pre_resume_vm;
+    ac->allowed = &whpx_allowed;
+
+    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
+        NULL, whpx_set_kernel_irqchip,
+        NULL, NULL);
+    object_class_property_set_description(oc, "kernel-irqchip",
+        "Configure WHPX in-kernel irqchip");
+}
+
+static void whpx_accel_instance_init(Object *obj)
+{
+    struct whpx_state *whpx = &whpx_global;
+
+    memset(whpx, 0, sizeof(struct whpx_state));
+    /* Turn on kernel-irqchip, by default */
+    whpx->kernel_irqchip_allowed = true;
+}
+
+static const TypeInfo whpx_accel_type = {
+    .name = ACCEL_CLASS_NAME("whpx"),
+    .parent = TYPE_ACCEL,
+    .instance_init = whpx_accel_instance_init,
+    .class_init = whpx_accel_class_init,
+};
+
+static void whpx_type_init(void)
+{
+    type_register_static(&whpx_accel_type);
+    type_register_static(&whpx_cpu_accel_type);
+}
+
+bool init_whp_dispatch(void)
+{
+    if (whp_dispatch_initialized) {
+        return true;
+    }
+
+    if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
+        goto error;
+    }
+
+    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
+        goto error;
+    }
+
+    assert(load_whp_dispatch_fns(&hWinHvPlatform,
+        WINHV_PLATFORM_FNS_SUPPLEMENTAL));
+    whp_dispatch_initialized = true;
+
+    return true;
+error:
+    if (hWinHvPlatform) {
+        FreeLibrary(hWinHvPlatform);
+    }
+    if (hWinHvEmulation) {
+        FreeLibrary(hWinHvEmulation);
+    }
+    return false;
+}
+
+type_init(whpx_type_init);
diff --git a/include/system/whpx-all.h b/include/system/whpx-all.h
new file mode 100644
index 0000000000..f13cdf7f66
--- /dev/null
+++ b/include/system/whpx-all.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef SYSTEM_WHPX_ALL_H
+#define SYSTEM_WHPX_ALL_H
+
+/* Called by whpx-common */
+int whpx_vcpu_run(CPUState *cpu);
+void whpx_get_registers(CPUState *cpu);
+void whpx_set_registers(CPUState *cpu, int level);
+int whpx_accel_init(AccelState *as, MachineState *ms);
+void whpx_cpu_instance_init(CPUState *cs);
+HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions);
+void whpx_apply_breakpoints(
+struct whpx_breakpoint_collection *breakpoints,
+    CPUState *cpu,
+    bool resuming);
+void whpx_translate_cpu_breakpoints(
+    struct whpx_breakpoints *breakpoints,
+    CPUState *cpu,
+    int cpu_breakpoint_count);
+#endif
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
new file mode 100644
index 0000000000..e549c7539c
--- /dev/null
+++ b/include/system/whpx-common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef SYSTEM_WHPX_COMMON_H
+#define SYSTEM_WHPX_COMMON_H
+
+struct AccelCPUState {
+    WHV_EMULATOR_HANDLE emulator;
+    bool window_registered;
+    bool interruptable;
+    bool ready_for_pic_interrupt;
+    uint64_t tpr;
+    uint64_t apic_base;
+    bool interruption_pending;
+    /* Must be the last field as it may have a tail */
+    WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
+};
+
+int whpx_first_vcpu_starting(CPUState *cpu);
+int whpx_last_vcpu_stopping(CPUState *cpu);
+void whpx_memory_init(void);
+struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+#endif
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index c0bd429d19..c63bb28b20 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -33,6 +33,8 @@
 
 #include "system/whpx-internal.h"
 #include "system/whpx-accel-ops.h"
+#include "system/whpx-all.h"
+#include "system/whpx-common.h"
 
 #include <winhvplatform.h>
 #include <winhvemulation.h>
@@ -232,28 +234,9 @@ typedef enum WhpxStepMode {
     WHPX_STEP_EXCLUSIVE,
 } WhpxStepMode;
 
-struct AccelCPUState {
-    WHV_EMULATOR_HANDLE emulator;
-    bool window_registered;
-    bool interruptable;
-    bool ready_for_pic_interrupt;
-    uint64_t tpr;
-    uint64_t apic_base;
-    bool interruption_pending;
-
-    /* Must be the last field as it may have a tail */
-    WHV_RUN_VP_EXIT_CONTEXT exit_ctx;
-};
-
-bool whpx_allowed;
-static bool whp_dispatch_initialized;
-static HMODULE hWinHvPlatform, hWinHvEmulation;
 static uint32_t max_vcpu_index;
 static WHV_PROCESSOR_XSAVE_FEATURES whpx_xsave_cap;
 
-struct whpx_state whpx_global;
-struct WHPDispatch whp_dispatch;
-
 static bool whpx_has_xsave(void)
 {
     return whpx_xsave_cap.XsaveSupport;
@@ -379,7 +362,7 @@ static uint64_t whpx_cr8_to_apic_tpr(uint64_t cr8)
     return cr8 << 4;
 }
 
-static void whpx_set_registers(CPUState *cpu, int level)
+void whpx_set_registers(CPUState *cpu, int level)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -594,7 +577,7 @@ static void whpx_get_xcrs(CPUState *cpu)
     cpu_env(cpu)->xcr0 = xcr0.Reg64;
 }
 
-static void whpx_get_registers(CPUState *cpu)
+void whpx_get_registers(CPUState *cpu)
 {
     struct whpx_state *whpx = &whpx_global;
     AccelCPUState *vcpu = cpu->accel;
@@ -934,7 +917,7 @@ static int whpx_handle_portio(CPUState *cpu,
  * The 'exceptions' argument accepts a bitmask, e.g:
  * (1 << WHvX64ExceptionTypeDebugTrapOrFault) | (...)
  */
-static HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
+HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 {
     struct whpx_state *whpx = &whpx_global;
     WHV_PARTITION_PROPERTY prop = { 0, };
@@ -1084,23 +1067,6 @@ static HRESULT whpx_vcpu_configure_single_stepping(CPUState *cpu,
     return S_OK;
 }
 
-/* Tries to find a breakpoint at the specified address. */
-static struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address)
-{
-    struct whpx_state *whpx = &whpx_global;
-    int i;
-
-    if (whpx->breakpoints.breakpoints) {
-        for (i = 0; i < whpx->breakpoints.breakpoints->used; i++) {
-            if (address == whpx->breakpoints.breakpoints->data[i].address) {
-                return &whpx->breakpoints.breakpoints->data[i];
-            }
-        }
-    }
-
-    return NULL;
-}
-
 /*
  * Linux uses int3 (0xCC) during startup (see int3_selftest()) and for
  * debugging user-mode applications. Since the WHPX API does not offer
@@ -1136,7 +1102,7 @@ static const uint8_t whpx_breakpoint_instruction = 0xF1;
  * memory, but doesn't actually do it. The memory accessing is done in
  * whpx_apply_breakpoints().
  */
-static void whpx_translate_cpu_breakpoints(
+void whpx_translate_cpu_breakpoints(
     struct whpx_breakpoints *breakpoints,
     CPUState *cpu,
     int cpu_breakpoint_count)
@@ -1230,7 +1196,7 @@ static void whpx_translate_cpu_breakpoints(
  * Passing resuming=true  will try to set all previously unset breakpoints.
  * Passing resuming=false will remove all inserted ones.
  */
-static void whpx_apply_breakpoints(
+void whpx_apply_breakpoints(
     struct whpx_breakpoint_collection *breakpoints,
     CPUState *cpu,
     bool resuming)
@@ -1306,93 +1272,6 @@ static void whpx_apply_breakpoints(
     }
 }
 
-/*
- * This function is called when the a VCPU is about to start and no other
- * VCPUs have been started so far. Since the VCPU start order could be
- * arbitrary, it doesn't have to be VCPU#0.
- *
- * It is used to commit the breakpoints into memory, and configure WHPX
- * to intercept debug exceptions.
- *
- * Note that whpx_set_exception_exit_bitmap() cannot be called if one or
- * more VCPUs are already running, so this is the best place to do it.
- */
-static int whpx_first_vcpu_starting(CPUState *cpu)
-{
-    struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-
-    g_assert(bql_locked());
-
-    if (!QTAILQ_EMPTY(&cpu->breakpoints) ||
-            (whpx->breakpoints.breakpoints &&
-             whpx->breakpoints.breakpoints->used)) {
-        CPUBreakpoint *bp;
-        int i = 0;
-        bool update_pending = false;
-
-        QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
-            if (i >= whpx->breakpoints.original_address_count ||
-                bp->pc != whpx->breakpoints.original_addresses[i]) {
-                update_pending = true;
-            }
-
-            i++;
-        }
-
-        if (i != whpx->breakpoints.original_address_count) {
-            update_pending = true;
-        }
-
-        if (update_pending) {
-            /*
-             * The CPU breakpoints have changed since the last call to
-             * whpx_translate_cpu_breakpoints(). WHPX breakpoints must
-             * now be recomputed.
-             */
-            whpx_translate_cpu_breakpoints(&whpx->breakpoints, cpu, i);
-        }
-
-        /* Actually insert the breakpoints into the memory. */
-        whpx_apply_breakpoints(whpx->breakpoints.breakpoints, cpu, true);
-    }
-
-    uint64_t exception_mask;
-    if (whpx->step_pending ||
-        (whpx->breakpoints.breakpoints &&
-         whpx->breakpoints.breakpoints->used)) {
-        /*
-         * We are either attempting to single-step one or more CPUs, or
-         * have one or more breakpoints enabled. Both require intercepting
-         * the WHvX64ExceptionTypeBreakpointTrap exception.
-         */
-
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
-    } else {
-        /* Let the guest handle all exceptions. */
-        exception_mask = 0;
-    }
-
-    hr = whpx_set_exception_exit_bitmap(exception_mask);
-    if (!SUCCEEDED(hr)) {
-        error_report("WHPX: Failed to update exception exit mask,"
-                     "hr=%08lx.", hr);
-        return 1;
-    }
-
-    return 0;
-}
-
-/*
- * This function is called when the last VCPU has finished running.
- * It is used to remove any previously set breakpoints from memory.
- */
-static int whpx_last_vcpu_stopping(CPUState *cpu)
-{
-    whpx_apply_breakpoints(whpx_global.breakpoints.breakpoints, cpu, false);
-    return 0;
-}
-
 /* Returns the address of the next instruction that is about to be executed. */
 static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
 {
@@ -1634,7 +1513,7 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
     }
 }
 
-static int whpx_vcpu_run(CPUState *cpu)
+int whpx_vcpu_run(CPUState *cpu)
 {
     HRESULT hr;
     struct whpx_state *whpx = &whpx_global;
@@ -2057,65 +1936,6 @@ static int whpx_vcpu_run(CPUState *cpu)
     return ret < 0;
 }
 
-static void do_whpx_cpu_synchronize_state(CPUState *cpu, run_on_cpu_data arg)
-{
-    if (!cpu->vcpu_dirty) {
-        whpx_get_registers(cpu);
-        cpu->vcpu_dirty = true;
-    }
-}
-
-static void do_whpx_cpu_synchronize_post_reset(CPUState *cpu,
-                                               run_on_cpu_data arg)
-{
-    whpx_set_registers(cpu, WHPX_SET_RESET_STATE);
-    cpu->vcpu_dirty = false;
-}
-
-static void do_whpx_cpu_synchronize_post_init(CPUState *cpu,
-                                              run_on_cpu_data arg)
-{
-    whpx_set_registers(cpu, WHPX_SET_FULL_STATE);
-    cpu->vcpu_dirty = false;
-}
-
-static void do_whpx_cpu_synchronize_pre_loadvm(CPUState *cpu,
-                                               run_on_cpu_data arg)
-{
-    cpu->vcpu_dirty = true;
-}
-
-/*
- * CPU support.
- */
-
-void whpx_cpu_synchronize_state(CPUState *cpu)
-{
-    if (!cpu->vcpu_dirty) {
-        run_on_cpu(cpu, do_whpx_cpu_synchronize_state, RUN_ON_CPU_NULL);
-    }
-}
-
-void whpx_cpu_synchronize_post_reset(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_whpx_cpu_synchronize_post_reset, RUN_ON_CPU_NULL);
-}
-
-void whpx_cpu_synchronize_post_init(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_whpx_cpu_synchronize_post_init, RUN_ON_CPU_NULL);
-}
-
-void whpx_cpu_synchronize_pre_loadvm(CPUState *cpu)
-{
-    run_on_cpu(cpu, do_whpx_cpu_synchronize_pre_loadvm, RUN_ON_CPU_NULL);
-}
-
-static void whpx_pre_resume_vm(AccelState *as, bool step_pending)
-{
-    whpx_global.step_pending = step_pending;
-}
-
 /*
  * Vcpu support.
  */
@@ -2244,295 +2064,18 @@ error:
     return ret;
 }
 
-int whpx_vcpu_exec(CPUState *cpu)
-{
-    int ret;
-    int fatal;
-
-    for (;;) {
-        if (cpu->exception_index >= EXCP_INTERRUPT) {
-            ret = cpu->exception_index;
-            cpu->exception_index = -1;
-            break;
-        }
-
-        fatal = whpx_vcpu_run(cpu);
-
-        if (fatal) {
-            error_report("WHPX: Failed to exec a virtual processor");
-            abort();
-        }
-    }
-
-    return ret;
-}
-
-void whpx_destroy_vcpu(CPUState *cpu)
-{
-    struct whpx_state *whpx = &whpx_global;
-    AccelCPUState *vcpu = cpu->accel;
-
-    whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
-    whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
-    g_free(cpu->accel);
-}
-
-void whpx_vcpu_kick(CPUState *cpu)
-{
-    struct whpx_state *whpx = &whpx_global;
-    whp_dispatch.WHvCancelRunVirtualProcessor(
-        whpx->partition, cpu->cpu_index, 0);
-}
-
-/*
- * Memory support.
- */
-
-static void whpx_update_mapping(hwaddr start_pa, ram_addr_t size,
-                                void *host_va, int add, int rom,
-                                const char *name)
-{
-    struct whpx_state *whpx = &whpx_global;
-    HRESULT hr;
-
-    /*
-    if (add) {
-        printf("WHPX: ADD PA:%p Size:%p, Host:%p, %s, '%s'\n",
-               (void*)start_pa, (void*)size, host_va,
-               (rom ? "ROM" : "RAM"), name);
-    } else {
-        printf("WHPX: DEL PA:%p Size:%p, Host:%p,      '%s'\n",
-               (void*)start_pa, (void*)size, host_va, name);
-    }
-    */
-
-    if (add) {
-        hr = whp_dispatch.WHvMapGpaRange(whpx->partition,
-                                         host_va,
-                                         start_pa,
-                                         size,
-                                         (WHvMapGpaRangeFlagRead |
-                                          WHvMapGpaRangeFlagExecute |
-                                          (rom ? 0 : WHvMapGpaRangeFlagWrite)));
-    } else {
-        hr = whp_dispatch.WHvUnmapGpaRange(whpx->partition,
-                                           start_pa,
-                                           size);
-    }
-
-    if (FAILED(hr)) {
-        error_report("WHPX: Failed to %s GPA range '%s' PA:%p, Size:%p bytes,"
-                     " Host:%p, hr=%08lx",
-                     (add ? "MAP" : "UNMAP"), name,
-                     (void *)(uintptr_t)start_pa, (void *)size, host_va, hr);
-    }
-}
-
-static void whpx_process_section(MemoryRegionSection *section, int add)
-{
-    MemoryRegion *mr = section->mr;
-    hwaddr start_pa = section->offset_within_address_space;
-    ram_addr_t size = int128_get64(section->size);
-    unsigned int delta;
-    uint64_t host_va;
-
-    if (!memory_region_is_ram(mr)) {
-        return;
-    }
-
-    delta = qemu_real_host_page_size() - (start_pa & ~qemu_real_host_page_mask());
-    delta &= ~qemu_real_host_page_mask();
-    if (delta > size) {
-        return;
-    }
-    start_pa += delta;
-    size -= delta;
-    size &= qemu_real_host_page_mask();
-    if (!size || (start_pa & ~qemu_real_host_page_mask())) {
-        return;
-    }
-
-    host_va = (uintptr_t)memory_region_get_ram_ptr(mr)
-            + section->offset_within_region + delta;
-
-    whpx_update_mapping(start_pa, size, (void *)(uintptr_t)host_va, add,
-                        memory_region_is_rom(mr), mr->name);
-}
-
-static void whpx_region_add(MemoryListener *listener,
-                           MemoryRegionSection *section)
-{
-    memory_region_ref(section->mr);
-    whpx_process_section(section, 1);
-}
-
-static void whpx_region_del(MemoryListener *listener,
-                           MemoryRegionSection *section)
-{
-    whpx_process_section(section, 0);
-    memory_region_unref(section->mr);
-}
-
-static void whpx_transaction_begin(MemoryListener *listener)
-{
-}
-
-static void whpx_transaction_commit(MemoryListener *listener)
-{
-}
-
-static void whpx_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
-{
-    MemoryRegion *mr = section->mr;
-
-    if (!memory_region_is_ram(mr)) {
-        return;
-    }
-
-    memory_region_set_dirty(mr, 0, int128_get64(section->size));
-}
-
-static MemoryListener whpx_memory_listener = {
-    .name = "whpx",
-    .begin = whpx_transaction_begin,
-    .commit = whpx_transaction_commit,
-    .region_add = whpx_region_add,
-    .region_del = whpx_region_del,
-    .log_sync = whpx_log_sync,
-    .priority = MEMORY_LISTENER_PRIORITY_ACCEL,
-};
-
-static void whpx_memory_init(void)
-{
-    memory_listener_register(&whpx_memory_listener, &address_space_memory);
-}
-
-/*
- * Load the functions from the given library, using the given handle. If a
- * handle is provided, it is used, otherwise the library is opened. The
- * handle will be updated on return with the opened one.
- */
-static bool load_whp_dispatch_fns(HMODULE *handle,
-    WHPFunctionList function_list)
-{
-    HMODULE hLib = *handle;
-
-    #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
-    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
-    #define WHP_LOAD_FIELD_OPTIONAL(return_type, function_name, signature) \
-        whp_dispatch.function_name = \
-            (function_name ## _t)GetProcAddress(hLib, #function_name); \
-
-    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
-        whp_dispatch.function_name = \
-            (function_name ## _t)GetProcAddress(hLib, #function_name); \
-        if (!whp_dispatch.function_name) { \
-            error_report("Could not load function %s", #function_name); \
-            goto error; \
-        } \
-
-    #define WHP_LOAD_LIB(lib_name, handle_lib) \
-    if (!handle_lib) { \
-        handle_lib = LoadLibrary(lib_name); \
-        if (!handle_lib) { \
-            error_report("Could not load library %s.", lib_name); \
-            goto error; \
-        } \
-    } \
-
-    switch (function_list) {
-    case WINHV_PLATFORM_FNS_DEFAULT:
-        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
-        LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
-        break;
-
-    case WINHV_EMULATION_FNS_DEFAULT:
-        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
-        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
-        break;
-
-    case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
-        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
-        LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_LOAD_FIELD_OPTIONAL)
-        break;
-    }
-
-    *handle = hLib;
-    return true;
-
-error:
-    if (hLib) {
-        FreeLibrary(hLib);
-    }
-
-    return false;
-}
-
-static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
-                                   const char *name, void *opaque,
-                                   Error **errp)
-{
-    struct whpx_state *whpx = &whpx_global;
-    OnOffSplit mode;
-
-    if (!visit_type_OnOffSplit(v, name, &mode, errp)) {
-        return;
-    }
-
-    switch (mode) {
-    case ON_OFF_SPLIT_ON:
-        whpx->kernel_irqchip_allowed = true;
-        whpx->kernel_irqchip_required = true;
-        break;
-
-    case ON_OFF_SPLIT_OFF:
-        whpx->kernel_irqchip_allowed = false;
-        whpx->kernel_irqchip_required = false;
-        break;
-
-    case ON_OFF_SPLIT_SPLIT:
-        error_setg(errp, "WHPX: split irqchip currently not supported");
-        error_append_hint(errp,
-            "Try without kernel-irqchip or with kernel-irqchip=on|off");
-        break;
-
-    default:
-        /*
-         * The value was checked in visit_type_OnOffSplit() above. If
-         * we get here, then something is wrong in QEMU.
-         */
-        abort();
-    }
-}
-
-static void whpx_cpu_instance_init(CPUState *cs)
+void whpx_cpu_instance_init(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
 
     host_cpu_instance_init(cpu);
 }
 
-static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelCPUClass *acc = ACCEL_CPU_CLASS(oc);
-
-    acc->cpu_instance_init = whpx_cpu_instance_init;
-}
-
-static const TypeInfo whpx_cpu_accel_type = {
-    .name = ACCEL_CPU_NAME("whpx"),
-
-    .parent = TYPE_ACCEL_CPU,
-    .class_init = whpx_cpu_accel_class_init,
-    .abstract = true,
-};
-
 /*
  * Partition support
  */
 
-static int whpx_accel_init(AccelState *as, MachineState *ms)
+int whpx_accel_init(AccelState *as, MachineState *ms)
 {
     struct whpx_state *whpx;
     int ret;
@@ -2715,77 +2258,3 @@ error:
 
     return ret;
 }
-
-bool whpx_apic_in_platform(void) {
-    return whpx_global.apic_in_platform;
-}
-
-static void whpx_accel_class_init(ObjectClass *oc, const void *data)
-{
-    AccelClass *ac = ACCEL_CLASS(oc);
-    ac->name = "WHPX";
-    ac->init_machine = whpx_accel_init;
-    ac->pre_resume_vm = whpx_pre_resume_vm;
-    ac->allowed = &whpx_allowed;
-
-    object_class_property_add(oc, "kernel-irqchip", "on|off|split",
-        NULL, whpx_set_kernel_irqchip,
-        NULL, NULL);
-    object_class_property_set_description(oc, "kernel-irqchip",
-        "Configure WHPX in-kernel irqchip");
-}
-
-static void whpx_accel_instance_init(Object *obj)
-{
-    struct whpx_state *whpx = &whpx_global;
-
-    memset(whpx, 0, sizeof(struct whpx_state));
-    /* Turn on kernel-irqchip, by default */
-    whpx->kernel_irqchip_allowed = true;
-}
-
-static const TypeInfo whpx_accel_type = {
-    .name = ACCEL_CLASS_NAME("whpx"),
-    .parent = TYPE_ACCEL,
-    .instance_init = whpx_accel_instance_init,
-    .class_init = whpx_accel_class_init,
-};
-
-static void whpx_type_init(void)
-{
-    type_register_static(&whpx_accel_type);
-    type_register_static(&whpx_cpu_accel_type);
-}
-
-bool init_whp_dispatch(void)
-{
-    if (whp_dispatch_initialized) {
-        return true;
-    }
-
-    if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
-        goto error;
-    }
-
-    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
-        goto error;
-    }
-
-    assert(load_whp_dispatch_fns(&hWinHvPlatform,
-        WINHV_PLATFORM_FNS_SUPPLEMENTAL));
-    whp_dispatch_initialized = true;
-
-    return true;
-error:
-    if (hWinHvPlatform) {
-        FreeLibrary(hWinHvPlatform);
-    }
-
-    if (hWinHvEmulation) {
-        FreeLibrary(hWinHvEmulation);
-    }
-
-    return false;
-}
-
-type_init(whpx_type_init);
-- 
2.50.1 (Apple Git-155)


