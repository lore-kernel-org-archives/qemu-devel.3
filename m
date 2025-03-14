Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88CFC35FF1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 11:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt3NZ-0006NY-W9; Fri, 14 Mar 2025 07:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tt3NW-0006N1-R8
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 07:39:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tt3NU-0006pP-9P
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 07:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741952339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9AuZ8NqIERB9jCxuHV86kkNs2RasXIZiNvawOr2h2I=;
 b=V/uH0rVLttqs8mbkA+q3xQryKFfZKAO4Cp0jmWwZVgxJ0K7uPm+dnMpABYcbrcNVyN9vow
 ffgUUZDoDgP9+jvDuXGHKZ0YED70FU+k79vefRUnvbzyhS1SL/hu+GCI92WukoqZ1c92yC
 7LN8JvusctpFX+0UuF/CdKNxNhM3qAw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-BNOtgokdNbyq34Rq_3RRPg-1; Fri,
 14 Mar 2025 07:38:55 -0400
X-MC-Unique: BNOtgokdNbyq34Rq_3RRPg-1
X-Mimecast-MFC-AGG-ID: BNOtgokdNbyq34Rq_3RRPg_1741952335
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B4C219560B0; Fri, 14 Mar 2025 11:38:55 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.44.32.191])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CC181954B32; Fri, 14 Mar 2025 11:38:52 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>
Subject: [PATCH 1/2] qga-win: implement a 'guest-get-load' command
Date: Fri, 14 Mar 2025 13:38:46 +0200
Message-ID: <20250314113847.109460-2-kkostiuk@redhat.com>
In-Reply-To: <20250314113847.109460-1-kkostiuk@redhat.com>
References: <20250314113847.109460-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Windows has no native equivalent API, but it would be possible to
simulate it as illustrated here (BSD-3-Clause):

  https://github.com/giampaolo/psutil/pull/1485

Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c   | 140 +++++++++++++++++++++++++++++++++++++++++
 qga/guest-agent-core.h |  10 +++
 qga/main.c             |  39 ++++++++++++
 qga/meson.build        |   2 +-
 qga/qapi-schema.json   |   4 +-
 5 files changed, 192 insertions(+), 3 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 749fdf8895..9ded44c2f7 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -27,6 +27,7 @@
 #include <lm.h>
 #include <wtsapi32.h>
 #include <wininet.h>
+#include <pdh.h>
 
 #include "guest-agent-core.h"
 #include "vss-win32.h"
@@ -119,6 +120,28 @@ static OpenFlags guest_file_open_modes[] = {
     {"a+b", FILE_GENERIC_APPEND | GENERIC_READ, OPEN_ALWAYS  }
 };
 
+/*
+ * We use an exponentially weighted moving average, just like Unix systems do
+ * https://en.wikipedia.org/wiki/Load_(computing)#Unix-style_load_calculation
+ *
+ * These constants serve as the damping factor and are calculated with
+ * 1 / exp(sampling interval in seconds / window size in seconds)
+ *
+ * This formula comes from linux's include/linux/sched/loadavg.h
+ * https://github.com/torvalds/linux/blob/345671ea0f9258f410eb057b9ced9cefbbe5dc78/include/linux/sched/loadavg.h#L20-L23
+ */
+#define LOADAVG_FACTOR_1F  0.9200444146293232478931553241
+#define LOADAVG_FACTOR_5F  0.9834714538216174894737477501
+#define LOADAVG_FACTOR_15F 0.9944598480048967508795473394
+/*
+ * The time interval in seconds between taking load counts, same as Linux
+ */
+#define LOADAVG_SAMPLING_INTERVAL 5
+
+double load_avg_1m;
+double load_avg_5m;
+double load_avg_15m;
+
 #define debug_error(msg) do { \
     char *suffix = g_win32_error_message(GetLastError()); \
     g_debug("%s: %s", (msg), suffix); \
@@ -2448,3 +2471,120 @@ char *qga_get_host_name(Error **errp)
 
     return g_utf16_to_utf8(tmp, size, NULL, NULL, NULL);
 }
+
+
+static VOID CALLBACK load_avg_callback(PVOID hCounter, BOOLEAN timedOut)
+{
+    PDH_FMT_COUNTERVALUE displayValue;
+    double currentLoad;
+    PDH_STATUS err;
+
+    err = PdhGetFormattedCounterValue(
+        (PDH_HCOUNTER)hCounter, PDH_FMT_DOUBLE, 0, &displayValue);
+    /* Skip updating the load if we can't get the value successfully */
+    if (err != ERROR_SUCCESS) {
+        slog("PdhGetFormattedCounterValue failed to get load value with 0x%lx",
+             err);
+        return;
+    }
+    currentLoad = displayValue.doubleValue;
+
+    load_avg_1m = load_avg_1m * LOADAVG_FACTOR_1F + currentLoad * \
+        (1.0 - LOADAVG_FACTOR_1F);
+    load_avg_5m = load_avg_5m * LOADAVG_FACTOR_5F + currentLoad * \
+        (1.0 - LOADAVG_FACTOR_5F);
+    load_avg_15m = load_avg_15m * LOADAVG_FACTOR_15F + currentLoad * \
+        (1.0 - LOADAVG_FACTOR_15F);
+}
+
+static BOOL init_load_avg_counter(Error **errp)
+{
+    CONST WCHAR *szCounterPath = L"\\System\\Processor Queue Length";
+    PDH_STATUS status;
+    BOOL ret;
+    HQUERY hQuery;
+    HCOUNTER hCounter;
+    HANDLE event;
+    HANDLE waitHandle;
+
+    status = PdhOpenQueryW(NULL, 0, &hQuery);
+    if (status != ERROR_SUCCESS) {
+        /*
+         * If the function fails, the return value is a system error code or
+         * a PDH error code. error_setg_win32 cant translate PDH error code
+         * properly, so just report it as is.
+         */
+        error_setg_win32(errp, (DWORD)status,
+                         "PdhOpenQueryW failed with 0x%lx", status);
+        return FALSE;
+    }
+
+    status = PdhAddEnglishCounterW(hQuery, szCounterPath, 0, &hCounter);
+    if (status != ERROR_SUCCESS) {
+        error_setg_win32(errp, (DWORD)status,
+            "PdhAddEnglishCounterW failed with 0x%lx. Performance counters may be disabled.",
+            status);
+        PdhCloseQuery(hQuery);
+        return FALSE;
+    }
+
+    event = CreateEventW(NULL, FALSE, FALSE, L"LoadUpdateEvent");
+    if (event == NULL) {
+        error_setg_win32(errp, GetLastError(), "Create LoadUpdateEvent failed");
+        PdhCloseQuery(hQuery);
+        return FALSE;
+    }
+
+    status = PdhCollectQueryDataEx(hQuery, LOADAVG_SAMPLING_INTERVAL, event);
+    if (status != ERROR_SUCCESS) {
+        error_setg_win32(errp, (DWORD)status,
+                         "PdhCollectQueryDataEx failed with 0x%lx", status);
+        CloseHandle(event);
+        PdhCloseQuery(hQuery);
+        return FALSE;
+    }
+
+    ret = RegisterWaitForSingleObject(
+        &waitHandle,
+        event,
+        (WAITORTIMERCALLBACK)load_avg_callback,
+        (PVOID)hCounter,
+        INFINITE,
+        WT_EXECUTEDEFAULT);
+
+    if (ret == 0) {
+        error_setg_win32(errp, GetLastError(),
+                         "RegisterWaitForSingleObject failed");
+        CloseHandle(event);
+        PdhCloseQuery(hQuery);
+        return FALSE;
+    }
+
+    ga_set_load_avg_wait_handle(ga_state, waitHandle);
+    ga_set_load_avg_event(ga_state, event);
+    ga_set_load_avg_pdh_query(ga_state, hQuery);
+
+    return TRUE;
+}
+
+GuestLoadAverage *qmp_guest_get_load(Error **errp)
+{
+    if (ga_get_load_avg_pdh_query(ga_state) == NULL) {
+        /* set initial values */
+        load_avg_1m = 0;
+        load_avg_5m = 0;
+        load_avg_15m = 0;
+
+        if (init_load_avg_counter(errp) == false) {
+            return NULL;
+        }
+    }
+
+    GuestLoadAverage *ret = NULL;
+
+    ret = g_new0(GuestLoadAverage, 1);
+    ret->load1m = load_avg_1m;
+    ret->load5m = load_avg_5m;
+    ret->load15m = load_avg_15m;
+    return ret;
+}
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index a536d07d0d..d9f3922adf 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -13,6 +13,10 @@
 #ifndef GUEST_AGENT_CORE_H
 #define GUEST_AGENT_CORE_H
 
+#ifdef _WIN32
+#include <pdh.h>
+#endif
+
 #include "qapi/qmp-registry.h"
 #include "qga-qapi-types.h"
 
@@ -41,6 +45,12 @@ void ga_set_response_delimited(GAState *s);
 bool ga_is_frozen(GAState *s);
 void ga_set_frozen(GAState *s);
 void ga_unset_frozen(GAState *s);
+#ifdef _WIN32
+void ga_set_load_avg_event(GAState *s, HANDLE event);
+void ga_set_load_avg_wait_handle(GAState *s, HANDLE wait_handle);
+void ga_set_load_avg_pdh_query(GAState *s, HQUERY query);
+HQUERY ga_get_load_avg_pdh_query(GAState *s);
+#endif
 const char *ga_fsfreeze_hook(GAState *s);
 int64_t ga_get_fd_handle(GAState *s, Error **errp);
 int ga_parse_whence(GuestFileWhence *whence, Error **errp);
diff --git a/qga/main.c b/qga/main.c
index 72c39b042f..6c02f3ec38 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -33,6 +33,7 @@
 #include "qemu-version.h"
 #ifdef _WIN32
 #include <dbt.h>
+#include <pdh.h>
 #include "qga/service-win32.h"
 #include "qga/vss-win32.h"
 #endif
@@ -105,6 +106,9 @@ struct GAState {
     GAService service;
     HANDLE wakeup_event;
     HANDLE event_log;
+    HANDLE load_avg_wait_handle;
+    HANDLE load_avg_event;
+    HQUERY load_avg_pdh_query;
 #endif
     bool delimit_response;
     bool frozen;
@@ -582,6 +586,25 @@ const char *ga_fsfreeze_hook(GAState *s)
 }
 #endif
 
+#ifdef _WIN32
+void ga_set_load_avg_wait_handle(GAState *s, HANDLE wait_handle)
+{
+    s->load_avg_wait_handle = wait_handle;
+}
+void ga_set_load_avg_event(GAState *s, HANDLE event)
+{
+    s->load_avg_event = event;
+}
+void ga_set_load_avg_pdh_query(GAState *s, HQUERY query)
+{
+    s->load_avg_pdh_query = query;
+}
+HQUERY ga_get_load_avg_pdh_query(GAState *s)
+{
+    return s->load_avg_pdh_query;
+}
+#endif
+
 static void become_daemon(const char *pidfile)
 {
 #ifndef _WIN32
@@ -1402,6 +1425,10 @@ static GAState *initialize_agent(GAConfig *config, int socket_activation)
     g_debug("Guest agent version %s started", QEMU_FULL_VERSION);
 
 #ifdef _WIN32
+    s->load_avg_wait_handle = INVALID_HANDLE_VALUE;
+    s->load_avg_event = INVALID_HANDLE_VALUE;
+    s->load_avg_pdh_query = NULL;
+
     s->event_log = RegisterEventSource(NULL, "qemu-ga");
     if (!s->event_log) {
         g_autofree gchar *errmsg = g_win32_error_message(GetLastError());
@@ -1506,6 +1533,18 @@ static void cleanup_agent(GAState *s)
 #ifdef _WIN32
     CloseHandle(s->wakeup_event);
     CloseHandle(s->event_log);
+
+    if (s->load_avg_wait_handle != INVALID_HANDLE_VALUE) {
+        UnregisterWait(s->load_avg_wait_handle);
+    }
+
+    if (s->load_avg_event != INVALID_HANDLE_VALUE) {
+        CloseHandle(s->load_avg_event);
+    }
+
+    if (s->load_avg_pdh_query) {
+        PdhCloseQuery(s->load_avg_pdh_query);
+    }
 #endif
     if (s->command_state) {
         ga_command_state_cleanup_all(s->command_state);
diff --git a/qga/meson.build b/qga/meson.build
index 587ec4e5e8..89a4a8f713 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -95,7 +95,7 @@ gen_tlb = []
 qga_libs = []
 if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
-               '-lsetupapi', '-lcfgmgr32', '-luserenv']
+               '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
   if have_qga_vss
     qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-lstdc++', '-Wl,--enable-stdcall-fixup']
     subdir('vss-win32')
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 995594aaf4..cdab3872ea 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1863,7 +1863,7 @@
       'load5m': 'number',
       'load15m': 'number'
   },
-  'if': 'CONFIG_GETLOADAVG'
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
 }
 
 ##
@@ -1877,7 +1877,7 @@
 ##
 { 'command': 'guest-get-load',
   'returns': 'GuestLoadAverage',
-  'if': 'CONFIG_GETLOADAVG'
+  'if': { 'any': ['CONFIG_WIN32', 'CONFIG_GETLOADAVG'] }
 }
 
 ##
-- 
2.48.1


