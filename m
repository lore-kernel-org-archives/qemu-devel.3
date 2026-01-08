Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8EBD1D480
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 16:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdsd7-0006n1-LL; Thu, 08 Jan 2026 11:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscu-0006T0-8d
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:46 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdscs-0002sv-3T
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 11:12:44 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so22774095e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 08:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767888759; x=1768493559; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOrPqLMsU/l7RtrsFWkuX3T1EdJ4tUaPw7x9fYs45IU=;
 b=ijHiqrtCs9KeilWkKA3Ot3/qDwkrAT8vYEi2nenZ9nLUqJ2CuP8BL54n6tsnjeENRU
 Pdp3Y3XCMXFiznal1pMns4L/xA4altqJX6OO0Y0epxWg+9bW1DtKVLgqUEjGWGVsoqdX
 ObPvZbOhFvSP7kGlrf6qKYFATa4nNvdD23sslYSKliSR/qAWpkh8kyDKhtE7ym7MonTD
 c9KbFEW4NyvhntDy0uCTBCI/onJqvXRDIexXl6qKWJEItZ5xGTOjXK7KH2xv+KfYA2ff
 81RxNQ5TUmAG3k9IgIWwLXSoarcDqod3uMIG11Soar6LIaKgVi63m4vNOyVUCR2P3+/A
 eV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767888759; x=1768493559;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XOrPqLMsU/l7RtrsFWkuX3T1EdJ4tUaPw7x9fYs45IU=;
 b=C3uWOfOXDbDsVqbKjlUl8i7mDrh0/P3qexQqs/pDfwvj3td2/By7hru9z9LZSTwlbc
 7fQYRRiKW/HA4ExJBWcLN+zaUEzse47SXwGsYMoEfV+WjGIBrWrhsykPcy8DYAce2RAo
 qysfjp4s0iHMsAc1ltFIpwb1Pnmafo9G6Nv8gISg6FR1dIJ7MAihH8ViMERxkNBdDvPZ
 +KnUyMWh6iYWeR67kdMMbzvylSgEIhizx2KW8UDI0/hpGq05KPxmwG26soGfogxpazWt
 cUvKk5Thb8AC9Szt5lI0yQ0ljiLPe+juuxUGQ4BWfjoNqHjCR8IwoQCbuYg+L5jCI1Kw
 Ooaw==
X-Gm-Message-State: AOJu0YylAGUewMTTgI4vJ+xrC3O/B0bGndVmimXP/bRBs+27cdDB6tMf
 LV1McYmh7u4M2IAdYnn2q95tRpSkAA6B9KPruJAoA00iNpj+xXAY/Z9oIJli0lBH4vDjhxEqHzP
 tsGcnwA4=
X-Gm-Gg: AY/fxX7m7MSlNUwRzS8ULTnjIcBShKqalAhxHtz3ygAOD5aG1h5OGhlsSPM7SXmBwna
 cjXZtuKIWyCYiyiNJDC4Jq9domfCsdq1xbYtHQ+XewmQzBA8VcuNqMB63mU6RrXuS+KkWu0HzKJ
 +YmVI8kXhIvpiR3xhHTHIV28wOLFTvGGFNHaam3tPmOeFhV3FZeK43CearBSC4raEGOQPVAVA25
 yxWmsnN/vZtlWwZu+do3p1hP/QV13T1Q4IDN79jd5UR06xVe0No4fFXQer51z9CgDi14GfL17iM
 PaqAiHm+OxsF5G0r/ksJuYK4WT5U7tCl6pDU8770QwYpXbH+ygSVE5a1ZKKEXBtb5Xx6PzwPyKy
 IDC/b9fTJfgqRIQSUF0N/OJAzeyzvKk3I5+Ca66VVp/nSm6J80DS+g08n+GshpWggpzS6R2n9yr
 a1TagDO/AnL4MB7ivxVL0Pr7PqoFqoaBaq1GNwfqhNEyyN3rCyKgshOQD77vDg
X-Google-Smtp-Source: AGHT+IEj/sT9tjabVSTpPAeWmKH5BZv3w4k8j6+6vRRZsAhVZsYAQXlUi1ONIfgLtEiV4HDxF2r83w==
X-Received: by 2002:a05:600c:3b1f:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d84b52b9cmr73468845e9.34.1767888758951; 
 Thu, 08 Jan 2026 08:12:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8636c610sm40592025e9.0.2026.01.08.08.12.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 Jan 2026 08:12:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/4] dump: enhance win_dump_available to report properly
Date: Thu,  8 Jan 2026 17:12:17 +0100
Message-ID: <20260108161220.15146-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108161220.15146-1-philmd@linaro.org>
References: <20260108161220.15146-1-philmd@linaro.org>
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

From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>

QMP query-dump-guest-memory-capability reports win dump as available for
any x86 VM, which is false.

This patch implements proper query of vmcoreinfo and calculation of
guest note size. Based on that we can surely report whether win dump
available or not.

To perform this I suggest to split dump_init() into dump_preinit() and
dump_init_complete() to avoid exausting copypaste in
win_dump_available().

For further reference one may review this libvirt discussion:
https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB/#HJ3JRLWLGN3IKIC22OQ3PMZ4J3EFG5XB
[PATCH 0/4] Allow xml-configured coredump format on VM crash

Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250911123656.413160-3-nikolai.barybin@virtuozzo.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 dump/win_dump.h |   2 +-
 dump/dump.c     | 129 +++++++++++++++++++++++++++---------------------
 dump/win_dump.c |  23 +++++++--
 3 files changed, 95 insertions(+), 59 deletions(-)

diff --git a/dump/win_dump.h b/dump/win_dump.h
index 9d6cfa47c56..62e19c25273 100644
--- a/dump/win_dump.h
+++ b/dump/win_dump.h
@@ -14,7 +14,7 @@
 #include "system/dump.h"
 
 /* Check Windows dump availability for the current target */
-bool win_dump_available(Error **errp);
+bool win_dump_available(DumpState *s, Error **errp);
 
 void create_win_dump(DumpState *s, Error **errp);
 
diff --git a/dump/dump.c b/dump/dump.c
index 016a7d7b970..89ce9bcd77e 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1781,10 +1781,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
     g_strfreev(lines);
 }
 
-static void dump_init(DumpState *s, int fd, bool has_format,
-                      DumpGuestMemoryFormat format, bool paging, bool has_filter,
-                      int64_t begin, int64_t length, bool kdump_raw,
-                      Error **errp)
+static void dump_preinit(DumpState *s, Error **errp)
 {
     ERRP_GUARD();
     VMCoreInfoState *vmci = vmcoreinfo_find();
@@ -1792,16 +1789,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     int nr_cpus;
     int ret;
 
-    s->has_format = has_format;
-    s->format = format;
-    s->written_size = 0;
-    s->kdump_raw = kdump_raw;
-
-    /* kdump-compressed is conflict with paging and filter */
-    if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
-        assert(!paging && !has_filter);
-    }
-
     if (runstate_is_running()) {
         vm_stop(RUN_STATE_SAVE_VM);
         s->resume = true;
@@ -1818,41 +1805,10 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         nr_cpus++;
     }
 
-    s->fd = fd;
-    if (has_filter && !length) {
-        error_setg(errp, "parameter 'length' expects a non-zero size");
-        goto cleanup;
-    }
-    s->filter_area_begin = begin;
-    s->filter_area_length = length;
-
-    /* First index is 0, it's the special null name */
-    s->string_table_buf = g_array_new(FALSE, TRUE, 1);
-    /*
-     * Allocate the null name, due to the clearing option set to true
-     * it will be 0.
-     */
-    g_array_set_size(s->string_table_buf, 1);
-
     memory_mapping_list_init(&s->list);
-
     guest_phys_blocks_init(&s->guest_phys_blocks);
     guest_phys_blocks_append(&s->guest_phys_blocks);
-    s->total_size = dump_calculate_size(s);
-#ifdef DEBUG_DUMP_GUEST_MEMORY
-    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
-#endif
 
-    /* it does not make sense to dump non-existent memory */
-    if (!s->total_size) {
-        error_setg(errp, "dump: no guest memory to dump");
-        goto cleanup;
-    }
-
-    /* get dump info: endian, class and architecture.
-     * If the target architecture is not supported, cpu_get_dump_info() will
-     * return -1.
-     */
     ret = cpu_get_dump_info(&s->dump_info, &s->guest_phys_blocks);
     if (ret < 0) {
         error_setg(errp,
@@ -1910,6 +1866,56 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         }
     }
 
+    s->nr_cpus = nr_cpus;
+    return;
+cleanup:
+    dump_cleanup(s);
+}
+
+static void dump_init_complete(DumpState *s, int fd, bool has_format,
+                               DumpGuestMemoryFormat format, bool paging,
+                               bool has_filter, int64_t begin, int64_t length,
+                               bool kdump_raw, Error **errp)
+{
+    ERRP_GUARD();
+
+    s->has_format = has_format;
+    s->format = format;
+    s->written_size = 0;
+    s->kdump_raw = kdump_raw;
+
+    /* kdump-compressed is conflict with paging and filter */
+    if (has_format && format != DUMP_GUEST_MEMORY_FORMAT_ELF) {
+        assert(!paging && !has_filter);
+    }
+
+    s->fd = fd;
+    if (has_filter && !length) {
+        error_setg(errp, "parameter 'length' expects a non-zero size");
+        goto cleanup;
+    }
+    s->filter_area_begin = begin;
+    s->filter_area_length = length;
+
+    /* First index is 0, it's the special null name */
+    s->string_table_buf = g_array_new(FALSE, TRUE, 1);
+    /*
+     * Allocate the null name, due to the clearing option set to true
+     * it will be 0.
+     */
+    g_array_set_size(s->string_table_buf, 1);
+
+    s->total_size = dump_calculate_size(s);
+#ifdef DEBUG_DUMP_GUEST_MEMORY
+    fprintf(stderr, "DUMP: total memory to dump: %lu\n", s->total_size);
+#endif
+
+    /* it does not make sense to dump non-existent memory */
+    if (!s->total_size) {
+        error_setg(errp, "dump: no guest memory to dump");
+        goto cleanup;
+    }
+
     /* get memory mapping */
     if (paging) {
         qemu_get_guest_memory_mapping(&s->list, &s->guest_phys_blocks, errp);
@@ -1920,8 +1926,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         qemu_get_guest_simple_memory_mapping(&s->list, &s->guest_phys_blocks);
     }
 
-    s->nr_cpus = nr_cpus;
-
     get_max_mapnr(s);
 
     uint64_t tmp;
@@ -2151,11 +2155,6 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
     }
 #endif
 
-    if (has_format && format == DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
-        && !win_dump_available(errp)) {
-        return;
-    }
-
     if (strstart(protocol, "fd:", &p)) {
         fd = monitor_get_fd(monitor_cur(), p, errp);
         if (fd == -1) {
@@ -2194,9 +2193,19 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
 
     s = &dump_state_global;
     dump_state_prepare(s);
+    dump_preinit(s, errp);
+    if (*errp) {
+        qatomic_set(&s->status, DUMP_STATUS_FAILED);
+        return;
+    }
 
-    dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, kdump_raw, errp);
+    if (has_format && format == DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
+        && !win_dump_available(s, errp)) {
+        return;
+    }
+
+    dump_init_complete(s, fd, has_format, format, paging, has_begin,
+                       begin, length, kdump_raw, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
@@ -2219,6 +2228,13 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
                                   g_new0(DumpGuestMemoryCapability, 1);
     DumpGuestMemoryFormatList **tail = &cap->formats;
 
+    DumpState *s = g_new0(DumpState, 1);
+    dump_state_prepare(s);
+    dump_preinit(s, errp);
+    if (*errp) {
+        goto cleanup;
+    }
+
     /* elf is always available */
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_ELF);
 
@@ -2238,9 +2254,12 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
 #endif
 
-    if (win_dump_available(NULL)) {
+    if (win_dump_available(s, NULL)) {
         QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_WIN_DMP);
     }
 
+ cleanup:
+    dump_cleanup(s);
+    g_free(s);
     return cap;
 }
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 3162e8bd487..d42427feb22 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -20,8 +20,25 @@
 
 #if defined(TARGET_X86_64)
 
-bool win_dump_available(Error **errp)
+static bool check_header(WinDumpHeader *h, bool *x64, Error **errp);
+
+bool win_dump_available(DumpState *s, Error **errp)
 {
+    WinDumpHeader *h = (void *)(s->guest_note + VMCOREINFO_ELF_NOTE_HDR_SIZE);
+    Error *local_err = NULL;
+    bool x64 = true;
+
+    if (s->guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE32 &&
+            s->guest_note_size != VMCOREINFO_WIN_DUMP_NOTE_SIZE64) {
+        error_setg(errp, "win-dump: invalid vmcoreinfo note size");
+        return false;
+    }
+
+    if (!check_header(h, &x64, &local_err)) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
     return true;
 }
 
@@ -480,7 +497,7 @@ out_cr3:
 
 #else /* !TARGET_X86_64 */
 
-bool win_dump_available(Error **errp)
+bool win_dump_available(DumpState *s, Error **errp)
 {
     error_setg(errp, "Windows dump is only available for x86-64");
 
@@ -489,7 +506,7 @@ bool win_dump_available(Error **errp)
 
 void create_win_dump(DumpState *s, Error **errp)
 {
-    win_dump_available(errp);
+    win_dump_available(s, errp);
 }
 
 #endif
-- 
2.52.0


