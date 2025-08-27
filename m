Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5D4CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 13:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urG0E-0006rC-22; Wed, 27 Aug 2025 09:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1urG06-0006o7-Vt
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 09:15:43 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nikolai.barybin@virtuozzo.com>)
 id 1urG00-0004VO-5R
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 09:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
 :From; bh=lk7n7x8SSuQ7Mg1QTyQtwAw2cATkRG+xZM4NWFPXABU=; b=xGirMvm5EnMRtXjdrti
 zMB9xc8/W7ELlP2JMGtGPETNDFHCv8LOoDBced/fVY7Zk5IXHqP1SL++UuAh4Veg4SS6d49ngFtPa
 yyyVM4LB4eBX1G3KMEcMFHQB4OgUW/0blyoIul7hQZa1idJSrpXWLeLsa9YTU1wMJDgn6ZutCJPiH
 xG33GE58mSn43qxe/M/zQ2Coi9unf0uoyn580pAdceOWPLZ+lCZ9yYgVU/Ih540QAU9N4eKCnF6rW
 LAnR95bn+0qDDpJO6abFD+XBQSRWGlPD8dPrJLuNI5mA70dZF74lQ0UcJmL6lMwk1EzVCnUxhCM13
 HeUO2xlxwIyd5Ag==;
Received: from [130.117.225.5] (helo=vz9-barybin-2.ch-qa.vzint.dev)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <nikolai.barybin@virtuozzo.com>) id 1urFVH-005c4N-1B;
 Wed, 27 Aug 2025 15:15:27 +0200
From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Date: Wed, 27 Aug 2025 16:15:27 +0300
Subject: [PATCH] dump: enhance win_dump_available to report properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-enhance-win-dump-avalaible-v2-v1-1-a6f359e9ff8e@virtuozzo.com>
X-B4-Tracking: v=1; b=H4sIAO4Er2gC/x3MTQ5AMBBA4avIrE1Sg/i5iliUDiahpI2SiLtrL
 L+3eA94dsIe2uQBx0G87DYiSxMYF21nRjHRQIpKVVOFbGMeGS+xaM7tQB30qmVYGQNhkVM5qHy
 qm8JAfByOJ7n/f9e/7wdyj2HbbwAAAA==
X-Change-ID: 20250827-enhance-win-dump-avalaible-v2-4325b03f894d
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Denis V. Lunev" <den@virtuozzo.com>, 
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756300527; l=10338;
 i=nikolai.barybin@virtuozzo.com; s=20250827; h=from:subject:message-id;
 bh=etIlLWnACVBU0kIy7j4+T2TgVu4GbvK4rmEPIil1wm8=;
 b=9pxHPE/lAV+K8ekjCIyAvPx5R7czvs/ZH1uuirPFMtYP+QNAwNHtO+axV93Z1S/u71msn9HZO
 7p/c8GXbUDsAApEDTVlXKt7PWt837+uoefUM03tegF9DNq5iyoPwKLC
X-Developer-Key: i=nikolai.barybin@virtuozzo.com; a=ed25519;
 pk=SZWzGBZYZNiojQv29dhpTVx22c0UJvq7kEIa6s8+ywQ=
Received-SPF: pass client-ip=130.117.225.111;
 envelope-from=nikolai.barybin@virtuozzo.com; helo=relay.virtuozzo.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
During first series discussion Den mentions that that code will not work
on 32bit guest with more than 4Gb RAM on i386.

This issue required even more code duplication between dump_init() and
win_dump_available() which we'd like to avoid as mentioned by Daniel.

Hence I present 2nd version of this fix:
 - split dump_init() into dump_preinit() and dump_init_complete()
 - pass pre-inited dump structure with calculated guest note size to
   win_dump_available()
 - call header check and guest note size check inside
   win_dump_available()
---
 dump/dump.c     | 129 ++++++++++++++++++++++++++++++++------------------------
 dump/win_dump.c |  23 ++++++++--
 dump/win_dump.h |   2 +-
 3 files changed, 95 insertions(+), 59 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 15bbcc0c6192822cf920fcb7d60eb7d2cfad0952..19341fa42feef4d1c50dbb3a892ded59a3468d20 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1777,10 +1777,7 @@ static void vmcoreinfo_update_phys_base(DumpState *s)
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
@@ -1788,16 +1785,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
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
@@ -1814,41 +1801,10 @@ static void dump_init(DumpState *s, int fd, bool has_format,
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
@@ -1906,6 +1862,56 @@ static void dump_init(DumpState *s, int fd, bool has_format,
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
@@ -1916,8 +1922,6 @@ static void dump_init(DumpState *s, int fd, bool has_format,
         qemu_get_guest_simple_memory_mapping(&s->list, &s->guest_phys_blocks);
     }
 
-    s->nr_cpus = nr_cpus;
-
     get_max_mapnr(s);
 
     uint64_t tmp;
@@ -2147,11 +2151,6 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
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
@@ -2190,9 +2189,19 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
 
     s = &dump_state_global;
     dump_state_prepare(s);
+    dump_preinit(s, errp);
+    if (*errp) {
+        qatomic_set(&s->status, DUMP_STATUS_FAILED);
+        return;
+    }
+
+    if (has_format && format == DUMP_GUEST_MEMORY_FORMAT_WIN_DMP
+        && !win_dump_available(s, errp)) {
+        return;
+    }
 
-    dump_init(s, fd, has_format, format, paging, has_begin,
-              begin, length, kdump_raw, errp);
+    dump_init_complete(s, fd, has_format, format, paging, has_begin,
+                       begin, length, kdump_raw, errp);
     if (*errp) {
         qatomic_set(&s->status, DUMP_STATUS_FAILED);
         return;
@@ -2215,6 +2224,14 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
                                   g_new0(DumpGuestMemoryCapability, 1);
     DumpGuestMemoryFormatList **tail = &cap->formats;
 
+    DumpState *s = &dump_state_global;
+    dump_state_prepare(s);
+    dump_preinit(s, errp);
+    if (*errp) {
+        qatomic_set(&s->status, DUMP_STATUS_FAILED);
+        return cap;
+    }
+
     /* elf is always available */
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_ELF);
 
@@ -2234,9 +2251,11 @@ DumpGuestMemoryCapability *qmp_query_dump_guest_memory_capability(Error **errp)
     QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_SNAPPY);
 #endif
 
-    if (win_dump_available(NULL)) {
+    if (win_dump_available(s, NULL)) {
         QAPI_LIST_APPEND(tail, DUMP_GUEST_MEMORY_FORMAT_WIN_DMP);
     }
 
+    dump_cleanup(s);
+    qatomic_set(&s->status, DUMP_STATUS_NONE);
     return cap;
 }
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 3162e8bd48771af8b0e1b1571e40d9a0d888409c..d42427feb22e9cec282129fef4d207342c28205e 100644
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
diff --git a/dump/win_dump.h b/dump/win_dump.h
index 9d6cfa47c566503b50db11e773c01381540443e9..62e19c252738e36ac304f92ae834d3be2e4aafa4 100644
--- a/dump/win_dump.h
+++ b/dump/win_dump.h
@@ -14,7 +14,7 @@
 #include "system/dump.h"
 
 /* Check Windows dump availability for the current target */
-bool win_dump_available(Error **errp);
+bool win_dump_available(DumpState *s, Error **errp);
 
 void create_win_dump(DumpState *s, Error **errp);
 

---
base-commit: e771ba98de25c9f43959f79fc7099cf7fbba44cc
change-id: 20250827-enhance-win-dump-avalaible-v2-4325b03f894d

Best regards,
-- 
Nikolai Barybin <nikolai.barybin@virtuozzo.com>


