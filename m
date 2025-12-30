Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727BBEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagyG-0006zV-AM; Tue, 30 Dec 2025 16:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxx-0006e4-6B
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:20 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxt-0002JL-IP
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:16 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso105743645e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:09:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128952; x=1767733752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hhU49fbiZ3nl0kGa0lXhvD0zoh9REzkPC+zIE/tKGjE=;
 b=Ml/+eWy0hS2ozcZ2O2NzTRuH1avi0180Y0wJYmgLyY3aySIU5rcu14TR5BEYw/gzrB
 w+WQYqxTIGL6eNXXM+BPgiWwT3WjWjCY0F0uk4n82+N5nX95hcK7DwAx8Aqk+QHLJPfr
 OS3OjwoYYCiP6krE+X7VmTKXevMVDgfifu2TTav3vl1mva1mkwWUtnCS3v/LlUCcvzG/
 LcvkQvO0a9bbK6EjMGaokYzTCsJEe0+NxFvrLbybei1RERe6so4aUpgvLWWBIZhSN720
 rFSCUuB8C470seB+rxD1gjrLccEw/HM2hXfXpfKzvZuGEMu/x7Oq7B3XsPHSz3g/aGn2
 amXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128952; x=1767733752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hhU49fbiZ3nl0kGa0lXhvD0zoh9REzkPC+zIE/tKGjE=;
 b=Pnwl4T332xv+tcXaRckXk4ydvnNNpYlgoKnITo7s1c9wsdjegRQLK1r23sqxclMvNP
 s5RWJPyGnk0bQVxMNusNT4qKqfpfj7YmWDC37uiGOH6I9ePAEEzTFwYHvBuQgZCkX2Zb
 cIGsM+nnxoq2p4sMpVTomIeFx8I7c3PFIu6OZGgS9rnnUbag1S8wPZSQjC3WEz/b8h89
 cBg8IYkzHYzuU4ewh+YPvjKZwJ6n59WBOY7Nc2oaJ5V5i8ccbSRrOrOle6cYekrpNpdF
 xTumEc6NXbujYx6raortqNswLoNS4shEMfl/K9XNyjY9GCsL2ScUT7wDPsxB0fWyQUIj
 dZwg==
X-Gm-Message-State: AOJu0YzuR7U5Ge6urgdlYVhPfxfDxb6drNDJsKU4XwgrRX16ijBLuvun
 KlSfxu+Iu1TsMSGi83i5qaLUonp/6KcW5mpJ7JZdeGXQ/3dDyyEbk0n3GjiFzw/JDgpgmnRDSjP
 h6l5HQAA=
X-Gm-Gg: AY/fxX5hS4y8Zt1QN/RniMh16miYJu9qaaHUnyAEW6msOhQqOkjeURk1LD7CIb7HkTh
 NdnZpvNHO2FhqcB6LVqk9wIYOHeoeEu0MVOspiMC8+rkFOK6Vp/l9TXQgmAkY2jrrDyMUQxCSW3
 3PBFhiIdcCIaQZqALVlGOjUOIGQq1chWH7yhgTr4B4eALfNR0W4OfTYwOBejPyiv0ih2G7NtNCn
 6v7znZn7PvJaekhgTVN0UpWEhSCHoxC+AIx5nPradsv0ZwYusMIRWUQFJ1sJbjwetyjKuwCSicV
 dApXF2v49XoCtUbp38AP9CoNRPKLeQRwp5onysmaPfiGhj08PKJ55hoC9XigFibYMgoIVqkhN8m
 OylY+qZnX0163115aj9IGCq+5GEc2HsmimXteRcDJrVmBhtcRV578HzZEEKDYoamU7hcG/Cs5SA
 Ous7cM6a884xgav9w7nlmo5PplWed4WDtn8ZxQRdfzu/2GYQ+lRCc1a8qsBO/XccmekZxu5d4=
X-Google-Smtp-Source: AGHT+IFoQM7XP7iZvEjbc82sUaJR+Ko/eFYBTqHS8kHMN9KEK2wd2NvfNZetxg2e/M7p4JYYhrOd/w==
X-Received: by 2002:a05:600c:608d:b0:477:93f7:bbc5 with SMTP id
 5b1f17b1804b1-47d195667d6mr398383395e9.10.1767128951398; 
 Tue, 30 Dec 2025 13:09:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be2723d19sm717916385e9.2.2025.12.30.13.09.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:09:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/34] monitor/hmp: Merge hmp-cmds-target.c within hmp-cmds.c
Date: Tue, 30 Dec 2025 22:07:33 +0100
Message-ID: <20251230210757.13803-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

hmp-cmds-target.c is no more target specific, move its code
in hmp-cmds.c, which is built once for all system binaries.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251229231546.50604-8-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 383 --------------------------------------
 monitor/hmp-cmds.c        | 354 +++++++++++++++++++++++++++++++++++
 monitor/meson.build       |   2 +-
 3 files changed, 355 insertions(+), 384 deletions(-)
 delete mode 100644 monitor/hmp-cmds-target.c

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
deleted file mode 100644
index b4360f1f807..00000000000
--- a/monitor/hmp-cmds-target.c
+++ /dev/null
@@ -1,383 +0,0 @@
-/*
- * Miscellaneous target-dependent HMP commands
- *
- * Copyright (c) 2003-2004 Fabrice Bellard
- *
- * Permission is hereby granted, free of charge, to any person obtaining a copy
- * of this software and associated documentation files (the "Software"), to deal
- * in the Software without restriction, including without limitation the rights
- * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
- * copies of the Software, and to permit persons to whom the Software is
- * furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
- * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
- * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
- * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
- * THE SOFTWARE.
- */
-
-#include "qemu/osdep.h"
-#include "disas/disas.h"
-#include "system/address-spaces.h"
-#include "system/memory.h"
-#include "monitor/hmp-target.h"
-#include "monitor/monitor-internal.h"
-#include "qapi/error.h"
-#include "qobject/qdict.h"
-#include "system/hw_accel.h"
-#include "exec/target_page.h"
-
-/* Set the current CPU defined by the user. Callers must hold BQL. */
-int monitor_set_cpu(Monitor *mon, int cpu_index)
-{
-    CPUState *cpu;
-
-    cpu = qemu_get_cpu(cpu_index);
-    if (cpu == NULL) {
-        return -1;
-    }
-    g_free(mon->mon_cpu_path);
-    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
-    return 0;
-}
-
-/* Callers must hold BQL. */
-static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
-{
-    CPUState *cpu = NULL;
-
-    if (mon->mon_cpu_path) {
-        cpu = (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
-                                                    TYPE_CPU, NULL);
-        if (!cpu) {
-            g_free(mon->mon_cpu_path);
-            mon->mon_cpu_path = NULL;
-        }
-    }
-    if (!mon->mon_cpu_path) {
-        if (!first_cpu) {
-            return NULL;
-        }
-        monitor_set_cpu(mon, first_cpu->cpu_index);
-        cpu = first_cpu;
-    }
-    assert(cpu != NULL);
-    if (synchronize) {
-        cpu_synchronize_state(cpu);
-    }
-    return cpu;
-}
-
-CPUState *mon_get_cpu(Monitor *mon)
-{
-    return mon_get_cpu_sync(mon, true);
-}
-
-CPUArchState *mon_get_cpu_env(Monitor *mon)
-{
-    CPUState *cs = mon_get_cpu(mon);
-
-    return cs ? cpu_env(cs) : NULL;
-}
-
-int monitor_get_cpu_index(Monitor *mon)
-{
-    CPUState *cs = mon_get_cpu_sync(mon, false);
-
-    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
-}
-
-void hmp_info_registers(Monitor *mon, const QDict *qdict)
-{
-    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
-    int vcpu = qdict_get_try_int(qdict, "vcpu", -1);
-    CPUState *cs;
-
-    if (all_cpus) {
-        CPU_FOREACH(cs) {
-            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
-        }
-    } else {
-        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
-
-        if (!cs) {
-            if (vcpu >= 0) {
-                monitor_printf(mon, "CPU#%d not available\n", vcpu);
-            } else {
-                monitor_printf(mon, "No CPU available\n");
-            }
-            return;
-        }
-
-        monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
-        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
-    }
-}
-
-static void memory_dump(Monitor *mon, int count, int format, int wsize,
-                        uint64_t addr, bool is_physical)
-{
-    int l, line_size, i, max_digits, len;
-    uint8_t buf[16];
-    uint64_t v;
-    CPUState *cs = mon_get_cpu(mon);
-    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
-    const bool big_endian = target_big_endian();
-
-    if (!cs && (format == 'i' || !is_physical)) {
-        monitor_printf(mon, "Can not dump without CPU\n");
-        return;
-    }
-
-    if (format == 'i') {
-        monitor_disas(mon, cs, addr, count, is_physical);
-        return;
-    }
-
-    len = wsize * count;
-    if (wsize == 1) {
-        line_size = 8;
-    } else {
-        line_size = 16;
-    }
-    max_digits = 0;
-
-    switch (format) {
-    case 'o':
-        max_digits = DIV_ROUND_UP(wsize * 8, 3);
-        break;
-    default:
-    case 'x':
-        max_digits = (wsize * 8) / 4;
-        break;
-    case 'u':
-    case 'd':
-        max_digits = DIV_ROUND_UP(wsize * 8 * 10, 33);
-        break;
-    case 'c':
-        wsize = 1;
-        break;
-    }
-
-    while (len > 0) {
-        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
-        l = len;
-        if (l > line_size) {
-            l = line_size;
-        }
-        if (is_physical) {
-            AddressSpace *as = cs ? cs->as : &address_space_memory;
-            MemTxResult r = address_space_read(as, addr,
-                                               MEMTXATTRS_UNSPECIFIED, buf, l);
-            if (r != MEMTX_OK) {
-                monitor_printf(mon, " Cannot access memory\n");
-                break;
-            }
-        } else {
-            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
-                monitor_printf(mon, " Cannot access memory\n");
-                break;
-            }
-        }
-        i = 0;
-        while (i < l) {
-            switch (wsize) {
-            default:
-            case 1:
-                v = ldub_p(buf + i);
-                break;
-            case 2:
-                v = (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
-                break;
-            case 4:
-                v = (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf + i);
-                break;
-            case 8:
-                v = (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
-                break;
-            }
-            monitor_printf(mon, " ");
-            switch (format) {
-            case 'o':
-                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
-                break;
-            case 'x':
-                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
-                break;
-            case 'u':
-                monitor_printf(mon, "%*" PRIu64, max_digits, v);
-                break;
-            case 'd':
-                monitor_printf(mon, "%*" PRId64, max_digits, v);
-                break;
-            case 'c':
-                monitor_printc(mon, v);
-                break;
-            }
-            i += wsize;
-        }
-        monitor_printf(mon, "\n");
-        addr += l;
-        len -= l;
-    }
-}
-
-void hmp_memory_dump(Monitor *mon, const QDict *qdict)
-{
-    int count = qdict_get_int(qdict, "count");
-    int format = qdict_get_int(qdict, "format");
-    int size = qdict_get_int(qdict, "size");
-    vaddr addr = qdict_get_int(qdict, "addr");
-
-    memory_dump(mon, count, format, size, addr, false);
-}
-
-void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
-{
-    int count = qdict_get_int(qdict, "count");
-    int format = qdict_get_int(qdict, "format");
-    int size = qdict_get_int(qdict, "size");
-    hwaddr addr = qdict_get_int(qdict, "addr");
-
-    memory_dump(mon, count, format, size, addr, true);
-}
-
-void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
-{
-    Int128 gpa_region_size;
-    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
-                                                 addr, size);
-
-    if (!mrs.mr) {
-        error_setg(errp,
-                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
-        return NULL;
-    }
-
-    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
-        error_setg(errp,
-                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
-        memory_region_unref(mrs.mr);
-        return NULL;
-    }
-
-    gpa_region_size = int128_make64(size);
-    if (int128_lt(mrs.size, gpa_region_size)) {
-        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
-                   " exceeded.", addr);
-        memory_region_unref(mrs.mr);
-        return NULL;
-    }
-
-    *p_mr = mrs.mr;
-    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
-}
-
-void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
-{
-    hwaddr addr = qdict_get_int(qdict, "addr");
-    Error *local_err = NULL;
-    MemoryRegion *mr = NULL;
-    void *ptr;
-
-    ptr = gpa2hva(&mr, addr, 1, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return;
-    }
-
-    monitor_printf(mon, "Host virtual address for 0x%" HWADDR_PRIx
-                   " (%s) is %p\n",
-                   addr, mr->name, ptr);
-
-    memory_region_unref(mr);
-}
-
-void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
-{
-    vaddr addr = qdict_get_int(qdict, "addr");
-    CPUState *cs = mon_get_cpu(mon);
-    hwaddr gpa;
-
-    if (!cs) {
-        monitor_printf(mon, "No cpu\n");
-        return;
-    }
-
-    gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
-    if (gpa == -1) {
-        monitor_printf(mon, "Unmapped\n");
-    } else {
-        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
-                       gpa + (addr & ~TARGET_PAGE_MASK));
-    }
-}
-
-#ifdef CONFIG_LINUX
-static uint64_t vtop(void *ptr, Error **errp)
-{
-    uint64_t pinfo;
-    uint64_t ret = -1;
-    uintptr_t addr = (uintptr_t) ptr;
-    uintptr_t pagesize = qemu_real_host_page_size();
-    off_t offset = addr / pagesize * sizeof(pinfo);
-    int fd;
-
-    fd = open("/proc/self/pagemap", O_RDONLY);
-    if (fd == -1) {
-        error_setg_errno(errp, errno, "Cannot open /proc/self/pagemap");
-        return -1;
-    }
-
-    /* Force copy-on-write if necessary.  */
-    qatomic_add((uint8_t *)ptr, 0);
-
-    if (pread(fd, &pinfo, sizeof(pinfo), offset) != sizeof(pinfo)) {
-        error_setg_errno(errp, errno, "Cannot read pagemap");
-        goto out;
-    }
-    if ((pinfo & (1ull << 63)) == 0) {
-        error_setg(errp, "Page not present");
-        goto out;
-    }
-    ret = (pinfo & 0x007fffffffffffffull) * pagesize;
-    ret |= addr & (pagesize - 1);
-
-out:
-    close(fd);
-    return ret;
-}
-
-void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
-{
-    hwaddr addr = qdict_get_int(qdict, "addr");
-    Error *local_err = NULL;
-    MemoryRegion *mr = NULL;
-    void *ptr;
-    uint64_t physaddr;
-
-    ptr = gpa2hva(&mr, addr, 1, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return;
-    }
-
-    physaddr = vtop(ptr, &local_err);
-    if (local_err) {
-        error_report_err(local_err);
-    } else {
-        monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
-                       " (%s) is 0x%" PRIx64 "\n",
-                       addr, mr->name, (uint64_t) physaddr);
-    }
-
-    memory_region_unref(mr);
-}
-#endif
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 33a88ce205a..f7ff6ec90ec 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -17,9 +17,11 @@
 #include "system/address-spaces.h"
 #include "system/ioport.h"
 #include "exec/gdbstub.h"
+#include "exec/target_page.h"
 #include "gdbstub/enums.h"
 #include "monitor/hmp.h"
 #include "qemu/help_option.h"
+#include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
@@ -28,7 +30,10 @@
 #include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
+#include "system/hw_accel.h"
+#include "system/memory.h"
 #include "system/system.h"
+#include "disas/disas.h"
 
 bool hmp_handle_error(Monitor *mon, Error *err)
 {
@@ -435,3 +440,352 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
     monitor_printf(mon, "DTB dumped to '%s'\n", filename);
 }
 #endif
+
+/* Set the current CPU defined by the user. Callers must hold BQL. */
+int monitor_set_cpu(Monitor *mon, int cpu_index)
+{
+    CPUState *cpu;
+
+    cpu = qemu_get_cpu(cpu_index);
+    if (cpu == NULL) {
+        return -1;
+    }
+    g_free(mon->mon_cpu_path);
+    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    return 0;
+}
+
+/* Callers must hold BQL. */
+static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
+{
+    CPUState *cpu = NULL;
+
+    if (mon->mon_cpu_path) {
+        cpu = (CPUState *) object_resolve_path_type(mon->mon_cpu_path,
+                                                    TYPE_CPU, NULL);
+        if (!cpu) {
+            g_free(mon->mon_cpu_path);
+            mon->mon_cpu_path = NULL;
+        }
+    }
+    if (!mon->mon_cpu_path) {
+        if (!first_cpu) {
+            return NULL;
+        }
+        monitor_set_cpu(mon, first_cpu->cpu_index);
+        cpu = first_cpu;
+    }
+    assert(cpu != NULL);
+    if (synchronize) {
+        cpu_synchronize_state(cpu);
+    }
+    return cpu;
+}
+
+CPUState *mon_get_cpu(Monitor *mon)
+{
+    return mon_get_cpu_sync(mon, true);
+}
+
+CPUArchState *mon_get_cpu_env(Monitor *mon)
+{
+    CPUState *cs = mon_get_cpu(mon);
+
+    return cs ? cpu_env(cs) : NULL;
+}
+
+int monitor_get_cpu_index(Monitor *mon)
+{
+    CPUState *cs = mon_get_cpu_sync(mon, false);
+
+    return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
+}
+
+void hmp_info_registers(Monitor *mon, const QDict *qdict)
+{
+    bool all_cpus = qdict_get_try_bool(qdict, "cpustate_all", false);
+    int vcpu = qdict_get_try_int(qdict, "vcpu", -1);
+    CPUState *cs;
+
+    if (all_cpus) {
+        CPU_FOREACH(cs) {
+            monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
+            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
+        }
+    } else {
+        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
+
+        if (!cs) {
+            if (vcpu >= 0) {
+                monitor_printf(mon, "CPU#%d not available\n", vcpu);
+            } else {
+                monitor_printf(mon, "No CPU available\n");
+            }
+            return;
+        }
+
+        monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
+        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
+    }
+}
+
+static void memory_dump(Monitor *mon, int count, int format, int wsize,
+                        uint64_t addr, bool is_physical)
+{
+    int l, line_size, i, max_digits, len;
+    uint8_t buf[16];
+    uint64_t v;
+    CPUState *cs = mon_get_cpu(mon);
+    const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
+    const bool big_endian = target_big_endian();
+
+    if (!cs && (format == 'i' || !is_physical)) {
+        monitor_printf(mon, "Can not dump without CPU\n");
+        return;
+    }
+
+    if (format == 'i') {
+        monitor_disas(mon, cs, addr, count, is_physical);
+        return;
+    }
+
+    len = wsize * count;
+    if (wsize == 1) {
+        line_size = 8;
+    } else {
+        line_size = 16;
+    }
+    max_digits = 0;
+
+    switch (format) {
+    case 'o':
+        max_digits = DIV_ROUND_UP(wsize * 8, 3);
+        break;
+    default:
+    case 'x':
+        max_digits = (wsize * 8) / 4;
+        break;
+    case 'u':
+    case 'd':
+        max_digits = DIV_ROUND_UP(wsize * 8 * 10, 33);
+        break;
+    case 'c':
+        wsize = 1;
+        break;
+    }
+
+    while (len > 0) {
+        monitor_printf(mon, "%0*" PRIx64 ":", addr_width, addr);
+        l = len;
+        if (l > line_size) {
+            l = line_size;
+        }
+        if (is_physical) {
+            AddressSpace *as = cs ? cs->as : &address_space_memory;
+            MemTxResult r = address_space_read(as, addr,
+                                               MEMTXATTRS_UNSPECIFIED, buf, l);
+            if (r != MEMTX_OK) {
+                monitor_printf(mon, " Cannot access memory\n");
+                break;
+            }
+        } else {
+            if (cpu_memory_rw_debug(cs, addr, buf, l, 0) < 0) {
+                monitor_printf(mon, " Cannot access memory\n");
+                break;
+            }
+        }
+        i = 0;
+        while (i < l) {
+            switch (wsize) {
+            default:
+            case 1:
+                v = ldub_p(buf + i);
+                break;
+            case 2:
+                v = (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
+                break;
+            case 4:
+                v = (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf + i);
+                break;
+            case 8:
+                v = (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
+                break;
+            }
+            monitor_printf(mon, " ");
+            switch (format) {
+            case 'o':
+                monitor_printf(mon, "0%*" PRIo64, max_digits, v);
+                break;
+            case 'x':
+                monitor_printf(mon, "0x%0*" PRIx64, max_digits, v);
+                break;
+            case 'u':
+                monitor_printf(mon, "%*" PRIu64, max_digits, v);
+                break;
+            case 'd':
+                monitor_printf(mon, "%*" PRId64, max_digits, v);
+                break;
+            case 'c':
+                monitor_printc(mon, v);
+                break;
+            }
+            i += wsize;
+        }
+        monitor_printf(mon, "\n");
+        addr += l;
+        len -= l;
+    }
+}
+
+void hmp_memory_dump(Monitor *mon, const QDict *qdict)
+{
+    int count = qdict_get_int(qdict, "count");
+    int format = qdict_get_int(qdict, "format");
+    int size = qdict_get_int(qdict, "size");
+    vaddr addr = qdict_get_int(qdict, "addr");
+
+    memory_dump(mon, count, format, size, addr, false);
+}
+
+void hmp_physical_memory_dump(Monitor *mon, const QDict *qdict)
+{
+    int count = qdict_get_int(qdict, "count");
+    int format = qdict_get_int(qdict, "format");
+    int size = qdict_get_int(qdict, "size");
+    hwaddr addr = qdict_get_int(qdict, "addr");
+
+    memory_dump(mon, count, format, size, addr, true);
+}
+
+void *gpa2hva(MemoryRegion **p_mr, hwaddr addr, uint64_t size, Error **errp)
+{
+    Int128 gpa_region_size;
+    MemoryRegionSection mrs = memory_region_find(get_system_memory(),
+                                                 addr, size);
+
+    if (!mrs.mr) {
+        error_setg(errp,
+                   "No memory is mapped at address 0x%" HWADDR_PRIx, addr);
+        return NULL;
+    }
+
+    if (!memory_region_is_ram(mrs.mr) && !memory_region_is_romd(mrs.mr)) {
+        error_setg(errp,
+                   "Memory at address 0x%" HWADDR_PRIx " is not RAM", addr);
+        memory_region_unref(mrs.mr);
+        return NULL;
+    }
+
+    gpa_region_size = int128_make64(size);
+    if (int128_lt(mrs.size, gpa_region_size)) {
+        error_setg(errp, "Size of memory region at 0x%" HWADDR_PRIx
+                   " exceeded.", addr);
+        memory_region_unref(mrs.mr);
+        return NULL;
+    }
+
+    *p_mr = mrs.mr;
+    return qemu_map_ram_ptr(mrs.mr->ram_block, mrs.offset_within_region);
+}
+
+void hmp_gpa2hva(Monitor *mon, const QDict *qdict)
+{
+    hwaddr addr = qdict_get_int(qdict, "addr");
+    Error *local_err = NULL;
+    MemoryRegion *mr = NULL;
+    void *ptr;
+
+    ptr = gpa2hva(&mr, addr, 1, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
+    monitor_printf(mon, "Host virtual address for 0x%" HWADDR_PRIx
+                   " (%s) is %p\n",
+                   addr, mr->name, ptr);
+
+    memory_region_unref(mr);
+}
+
+void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
+{
+    vaddr addr = qdict_get_int(qdict, "addr");
+    CPUState *cs = mon_get_cpu(mon);
+    hwaddr gpa;
+
+    if (!cs) {
+        monitor_printf(mon, "No cpu\n");
+        return;
+    }
+
+    gpa  = cpu_get_phys_page_debug(cs, addr & TARGET_PAGE_MASK);
+    if (gpa == -1) {
+        monitor_printf(mon, "Unmapped\n");
+    } else {
+        monitor_printf(mon, "gpa: 0x%" HWADDR_PRIx "\n",
+                       gpa + (addr & ~TARGET_PAGE_MASK));
+    }
+}
+
+#ifdef CONFIG_LINUX
+static uint64_t vtop(void *ptr, Error **errp)
+{
+    uint64_t pinfo;
+    uint64_t ret = -1;
+    uintptr_t addr = (uintptr_t) ptr;
+    uintptr_t pagesize = qemu_real_host_page_size();
+    off_t offset = addr / pagesize * sizeof(pinfo);
+    int fd;
+
+    fd = open("/proc/self/pagemap", O_RDONLY);
+    if (fd == -1) {
+        error_setg_errno(errp, errno, "Cannot open /proc/self/pagemap");
+        return -1;
+    }
+
+    /* Force copy-on-write if necessary.  */
+    qatomic_add((uint8_t *)ptr, 0);
+
+    if (pread(fd, &pinfo, sizeof(pinfo), offset) != sizeof(pinfo)) {
+        error_setg_errno(errp, errno, "Cannot read pagemap");
+        goto out;
+    }
+    if ((pinfo & (1ull << 63)) == 0) {
+        error_setg(errp, "Page not present");
+        goto out;
+    }
+    ret = (pinfo & 0x007fffffffffffffull) * pagesize;
+    ret |= addr & (pagesize - 1);
+
+out:
+    close(fd);
+    return ret;
+}
+
+void hmp_gpa2hpa(Monitor *mon, const QDict *qdict)
+{
+    hwaddr addr = qdict_get_int(qdict, "addr");
+    Error *local_err = NULL;
+    MemoryRegion *mr = NULL;
+    void *ptr;
+    uint64_t physaddr;
+
+    ptr = gpa2hva(&mr, addr, 1, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return;
+    }
+
+    physaddr = vtop(ptr, &local_err);
+    if (local_err) {
+        error_report_err(local_err);
+    } else {
+        monitor_printf(mon, "Host physical address for 0x%" HWADDR_PRIx
+                       " (%s) is 0x%" PRIx64 "\n",
+                       addr, mr->name, (uint64_t) physaddr);
+    }
+
+    memory_region_unref(mr);
+}
+#endif
diff --git a/monitor/meson.build b/monitor/meson.build
index a71523a1ce8..2647100e04c 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -9,4 +9,4 @@ system_ss.add(files(
 system_ss.add([spice_headers, files('qmp-cmds.c')])
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-		if_true: [files( 'hmp-cmds-target.c', 'hmp-target.c'), spice])
+                if_true: [files('hmp-target.c'), spice])
-- 
2.52.0


