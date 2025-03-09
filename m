Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8630CC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 18:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trKpa-0005E1-Vc; Sun, 09 Mar 2025 13:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpS-0005CT-3U
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:47 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trKpQ-0004qh-8I
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 13:52:45 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bd5644de8so36427775e9.3
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741542762; x=1742147562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8FG/sgyXr9996vZOdOWbBM0OkWgobia8pq1aZDtIQB4=;
 b=cxzIes2qF03NTDaX3jdun1j0zs+Jzr43OKGBk4V+D7wm9rajRDFevtwDCG/wXDxI6f
 3h58GGtPEWtXNPWmE9FLuvn8m/S8p7wveSTeuKuTXj/5/kyqUV3i0lpADg7CT+zXgGsr
 4fRtyJd85RT011LW/DdhshlaTp0vVVpyvVxn0n+iK7fl6r4Fc8CVqEEw/YaopooGl2dU
 m08EBvIkTujkT8vjHhOXNylDqRMgHBA6W4F2KCc6Gebh9YUcnA01GHvRflMhnpDXhGOY
 P08EbEdZBhlBdhTkTcMMGUNJgBSl33y53me+S4jEf7LiNdmkMsJW5ahRE8psOkU/fxxZ
 xd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741542762; x=1742147562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FG/sgyXr9996vZOdOWbBM0OkWgobia8pq1aZDtIQB4=;
 b=moGG+hqLV4Dl9JRjwGrPRUg/ojoGSX3/Jm+l19rbSB+nSSjXYPxZ5QqsvA8lSiqRzO
 8fcPPe2hsuq2LrCd9DvI9z8p6gJS8uU2NThrXTR2BBIbNpi2xIlJCh7E8hPSBCZKrlf8
 1N1suwMTF8gF6WkrLZff07tDCgiMyIzzwl3KoT0o3bNn1n0IT3KiKqIISo22M7ianT9e
 sGbVV5ha5DU2oT8EAaUSaivHoRtC28FMQ2MJpzrre+0t7U9CAHz27cWd8d+3XBnOlVaw
 bzVPAsxx20udQkKYdQ6SwCIIgmCze0mB8SjIobhqaoXH/d99xSwHmEe9AkT6H7NDL3bU
 5n1w==
X-Gm-Message-State: AOJu0YwZNBp9j9e+Bdftst0GgSYLmDQKAUA3v520RhDyQL9T3sFgu2Rv
 8Fg64VqudUbeJUR1/ZyZw/tUtyBlpW1yA96rSuboxX5iy/0fvk3DDwxdilbpADKmqvVje9K6Jp6
 neIg=
X-Gm-Gg: ASbGnctSS5gS30c/tc6jUzmBAcqDtN8Xf/13pro3ED9lXVLnN6PDIFIE8GvjoSVYOG4
 fuT3yQXpo+F9jWC/QRhQtuan+yOT0PiSBy+nJOHYqdKdOvnXJu44f3/oXW7tdu+BDe5n8rQ/suH
 EO+1UTEAf3ZyHdG1aHtZ/y9yqzG/LUVL8M6XgXfw39iBBAuQW73/KOX+w8EpsdAG8dXgXj2KC3f
 Yv32lko9qnkBkPJqf8VMF0C/FmeJqBiOckyEOKuBL9XE1lDgbqb3H4xILnWZA2VZ9y+AgduRZX7
 1D0ziRR2ZeGiiPlrmSrA7iy2qhKTILoWcnn+PSzo7hCmB08VHqIn5wC1aQvSw0gP65SAUmirK0D
 3CmCM9u6dfScHfPUKc0A=
X-Google-Smtp-Source: AGHT+IHRj8sKj47XZF8Gb6wyUqCSukF/uwDYueuewD1xX78sJ7gUZX1QQRYNkX5OuwysquzWf6CZdw==
X-Received: by 2002:a05:600c:1d1c:b0:43c:efed:732d with SMTP id
 5b1f17b1804b1-43cefed7916mr20900435e9.16.1741542762313; 
 Sun, 09 Mar 2025 10:52:42 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd42c6203sm150211345e9.24.2025.03.09.10.52.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Mar 2025 10:52:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/38] cpus: Prefer cached CpuClass over CPU_GET_CLASS() macro
Date: Sun,  9 Mar 2025 18:51:36 +0100
Message-ID: <20250309175207.43828-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250309175207.43828-1-philmd@linaro.org>
References: <20250309175207.43828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-5-philmd@linaro.org>
---
 include/hw/core/cpu.h | 10 +++----
 cpu-common.c          | 10 +++----
 hw/core/cpu-common.c  | 13 +++------
 hw/core/cpu-system.c  | 61 ++++++++++++++++---------------------------
 4 files changed, 33 insertions(+), 61 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index bc0c9468344..c6df426c947 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -826,10 +826,8 @@ const char *parse_cpu_option(const char *cpu_option);
  */
 static inline bool cpu_has_work(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    g_assert(cc->has_work);
-    return cc->has_work(cpu);
+    g_assert(cpu->cc->has_work);
+    return cpu->cc->has_work(cpu);
 }
 
 /**
@@ -968,9 +966,7 @@ void cpu_interrupt(CPUState *cpu, int mask);
  */
 static inline void cpu_set_pc(CPUState *cpu, vaddr addr)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    cc->set_pc(cpu, addr);
+    cpu->cc->set_pc(cpu, addr);
 }
 
 /**
diff --git a/cpu-common.c b/cpu-common.c
index f5dcc2d136b..ef5757d23bf 100644
--- a/cpu-common.c
+++ b/cpu-common.c
@@ -388,11 +388,10 @@ void process_queued_cpu_work(CPUState *cpu)
 int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
                           CPUBreakpoint **breakpoint)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUBreakpoint *bp;
 
-    if (cc->gdb_adjust_breakpoint) {
-        pc = cc->gdb_adjust_breakpoint(cpu, pc);
+    if (cpu->cc->gdb_adjust_breakpoint) {
+        pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
     bp = g_malloc(sizeof(*bp));
@@ -418,11 +417,10 @@ int cpu_breakpoint_insert(CPUState *cpu, vaddr pc, int flags,
 /* Remove a specific breakpoint.  */
 int cpu_breakpoint_remove(CPUState *cpu, vaddr pc, int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     CPUBreakpoint *bp;
 
-    if (cc->gdb_adjust_breakpoint) {
-        pc = cc->gdb_adjust_breakpoint(cpu, pc);
+    if (cpu->cc->gdb_adjust_breakpoint) {
+        pc = cpu->cc->gdb_adjust_breakpoint(cpu, pc);
     }
 
     QTAILQ_FOREACH(bp, &cpu->breakpoints, entry) {
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 5671d8d4f54..ba0f02e49da 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -40,9 +40,7 @@ CPUState *cpu_by_arch_id(int64_t id)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        CPUClass *cc = CPU_GET_CLASS(cpu);
-
-        if (cc->get_arch_id(cpu) == id) {
+        if (cpu->cc->get_arch_id(cpu) == id) {
             return cpu;
         }
     }
@@ -101,11 +99,9 @@ static int cpu_common_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg)
 
 void cpu_dump_state(CPUState *cpu, FILE *f, int flags)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->dump_state) {
+    if (cpu->cc->dump_state) {
         cpu_synchronize_state(cpu);
-        cc->dump_state(cpu, f, flags);
+        cpu->cc->dump_state(cpu, f, flags);
     }
 }
 
@@ -119,11 +115,10 @@ void cpu_reset(CPUState *cpu)
 static void cpu_common_reset_hold(Object *obj, ResetType type)
 {
     CPUState *cpu = CPU(obj);
-    CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (qemu_loglevel_mask(CPU_LOG_RESET)) {
         qemu_log("CPU Reset (CPU %d)\n", cpu->cpu_index);
-        log_cpu_state(cpu, cc->reset_dump_flags);
+        log_cpu_state(cpu, cpu->cc->reset_dump_flags);
     }
 
     cpu->interrupt_request = 0;
diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
index 6c89d76e498..e29664d39bb 100644
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -33,10 +33,8 @@
 
 bool cpu_paging_enabled(const CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->get_paging_enabled) {
-        return cc->sysemu_ops->get_paging_enabled(cpu);
+    if (cpu->cc->sysemu_ops->get_paging_enabled) {
+        return cpu->cc->sysemu_ops->get_paging_enabled(cpu);
     }
 
     return false;
@@ -45,10 +43,8 @@ bool cpu_paging_enabled(const CPUState *cpu)
 bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                             Error **errp)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->get_memory_mapping) {
-        return cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
+    if (cpu->cc->sysemu_ops->get_memory_mapping) {
+        return cpu->cc->sysemu_ops->get_memory_mapping(cpu, list, errp);
     }
 
     error_setg(errp, "Obtaining memory mappings is unsupported on this CPU.");
@@ -58,15 +54,15 @@ bool cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
 hwaddr cpu_get_phys_page_attrs_debug(CPUState *cpu, vaddr addr,
                                      MemTxAttrs *attrs)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     hwaddr paddr;
 
-    if (cc->sysemu_ops->get_phys_page_attrs_debug) {
-        paddr = cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr, attrs);
+    if (cpu->cc->sysemu_ops->get_phys_page_attrs_debug) {
+        paddr = cpu->cc->sysemu_ops->get_phys_page_attrs_debug(cpu, addr,
+                                                               attrs);
     } else {
         /* Fallback for CPUs which don't implement the _attrs_ hook */
         *attrs = MEMTXATTRS_UNSPECIFIED;
-        paddr = cc->sysemu_ops->get_phys_page_debug(cpu, addr);
+        paddr = cpu->cc->sysemu_ops->get_phys_page_debug(cpu, addr);
     }
     /* Indicate that this is a debug access. */
     attrs->debug = 1;
@@ -94,64 +90,53 @@ int cpu_asidx_from_attrs(CPUState *cpu, MemTxAttrs attrs)
 int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf32_qemunote) {
+    if (!cpu->cc->sysemu_ops->write_elf32_qemunote) {
         return 0;
     }
-    return (*cc->sysemu_ops->write_elf32_qemunote)(f, cpu, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf32_qemunote)(f, cpu, opaque);
 }
 
 int cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cpu,
                          int cpuid, void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf32_note) {
+    if (!cpu->cc->sysemu_ops->write_elf32_note) {
         return -1;
     }
-    return (*cc->sysemu_ops->write_elf32_note)(f, cpu, cpuid, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf32_note)(f, cpu, cpuid, opaque);
 }
 
 int cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                              void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf64_qemunote) {
+    if (!cpu->cc->sysemu_ops->write_elf64_qemunote) {
         return 0;
     }
-    return (*cc->sysemu_ops->write_elf64_qemunote)(f, cpu, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf64_qemunote)(f, cpu, opaque);
 }
 
 int cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                          int cpuid, void *opaque)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (!cc->sysemu_ops->write_elf64_note) {
+    if (!cpu->cc->sysemu_ops->write_elf64_note) {
         return -1;
     }
-    return (*cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
+    return (*cpu->cc->sysemu_ops->write_elf64_note)(f, cpu, cpuid, opaque);
 }
 
 bool cpu_virtio_is_big_endian(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->virtio_is_big_endian) {
-        return cc->sysemu_ops->virtio_is_big_endian(cpu);
+    if (cpu->cc->sysemu_ops->virtio_is_big_endian) {
+        return cpu->cc->sysemu_ops->virtio_is_big_endian(cpu);
     }
     return target_words_bigendian();
 }
 
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
     GuestPanicInformation *res = NULL;
 
-    if (cc->sysemu_ops->get_crash_info) {
-        res = cc->sysemu_ops->get_crash_info(cpu);
+    if (cpu->cc->sysemu_ops->get_crash_info) {
+        res = cpu->cc->sysemu_ops->get_crash_info(cpu);
     }
     return res;
 }
@@ -300,10 +285,8 @@ void cpu_vmstate_register(CPUState *cpu)
 
 void cpu_vmstate_unregister(CPUState *cpu)
 {
-    CPUClass *cc = CPU_GET_CLASS(cpu);
-
-    if (cc->sysemu_ops->legacy_vmsd != NULL) {
-        vmstate_unregister(NULL, cc->sysemu_ops->legacy_vmsd, cpu);
+    if (cpu->cc->sysemu_ops->legacy_vmsd != NULL) {
+        vmstate_unregister(NULL, cpu->cc->sysemu_ops->legacy_vmsd, cpu);
     }
     if (qdev_get_vmsd(DEVICE(cpu)) == NULL) {
         vmstate_unregister(NULL, &vmstate_cpu_common, cpu);
-- 
2.47.1


