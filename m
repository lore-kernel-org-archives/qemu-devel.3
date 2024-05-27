Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F42C25B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 11:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBYaB-00055U-MV; Mon, 27 May 2024 07:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZo-0004sD-Pz
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sBYZl-0001Om-Qg
 for qemu-devel@nongnu.org; Mon, 27 May 2024 07:31:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716809497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hRro5uvvSf+BoekEFg3pHrFSW00kEySLafCn7wMsXUA=;
 b=JIvqom3zYLXqWSDXTMgZYSVsq1y62ImwOhtC6kAvfqObWpgPcLiv2I+qCNte5HgX1qPHw/
 aNbj9aRCF2kuwbUZ40yjIwo6Rap9SX72+IqAildV/bfnibnAYk+rVRNQdn1Ky540gPuU+y
 jvHkDqmbj4SaqAMvMkcgbliNpiWzXjA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-r8zRDUSpMHa8cmiWl8vEnw-1; Mon,
 27 May 2024 07:31:34 -0400
X-MC-Unique: r8zRDUSpMHa8cmiWl8vEnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 622B43C025BE;
 Mon, 27 May 2024 11:31:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 280521C00A8E;
 Mon, 27 May 2024 11:31:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 03F7421E5E61; Mon, 27 May 2024 13:31:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 8/9] qga: Shorten several error messages
Date: Mon, 27 May 2024 13:31:30 +0200
Message-ID: <20240527113131.2054486-9-armbru@redhat.com>
In-Reply-To: <20240527113131.2054486-1-armbru@redhat.com>
References: <20240527113131.2054486-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some, but not all error messages are of the form

    Guest agent command failed, error was '<actual error message>'

For instance, command guest-exec can fail with an error message like

    Guest agent command failed, error was 'Failed to execute child process “/bin/invalid-cmd42” (No such file or directory)'

Shorten this to just just the actual error message.  The guest-exec
example becomes

    Failed to execute child process “/bin/invalid-cmd42” (No such file or directory)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240514105829.729342-3-armbru@redhat.com>
[Superfluous #include "qapi/qmp/qerror.h" deleted]
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-win32.c | 24 ++++++++----------------
 qga/commands.c       |  6 ++----
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index ed31077457..0d1b836e87 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -278,8 +278,7 @@ static void acquire_privilege(const char *name, Error **errp)
         TOKEN_ADJUST_PRIVILEGES | TOKEN_QUERY, &token))
     {
         if (!LookupPrivilegeValue(NULL, name, &priv.Privileges[0].Luid)) {
-            error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                       "no luid for requested privilege");
+            error_setg(errp, "no luid for requested privilege");
             goto out;
         }
 
@@ -287,14 +286,12 @@ static void acquire_privilege(const char *name, Error **errp)
         priv.Privileges[0].Attributes = SE_PRIVILEGE_ENABLED;
 
         if (!AdjustTokenPrivileges(token, FALSE, &priv, 0, NULL, 0)) {
-            error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                       "unable to acquire requested privilege");
+            error_setg(errp, "unable to acquire requested privilege");
             goto out;
         }
 
     } else {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                   "failed to open privilege token");
+        error_setg(errp, "failed to open privilege token");
     }
 
 out:
@@ -308,8 +305,7 @@ static void execute_async(DWORD WINAPI (*func)(LPVOID), LPVOID opaque,
 {
     HANDLE thread = CreateThread(NULL, 0, func, opaque, 0, NULL);
     if (!thread) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                   "failed to dispatch asynchronous command");
+        error_setg(errp, "failed to dispatch asynchronous command");
     }
 }
 
@@ -1418,22 +1414,19 @@ static void check_suspend_mode(GuestSuspendMode mode, Error **errp)
 
     ZeroMemory(&sys_pwr_caps, sizeof(sys_pwr_caps));
     if (!GetPwrCapabilities(&sys_pwr_caps)) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                   "failed to determine guest suspend capabilities");
+        error_setg(errp, "failed to determine guest suspend capabilities");
         return;
     }
 
     switch (mode) {
     case GUEST_SUSPEND_MODE_DISK:
         if (!sys_pwr_caps.SystemS4) {
-            error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                       "suspend-to-disk not supported by OS");
+            error_setg(errp, "suspend-to-disk not supported by OS");
         }
         break;
     case GUEST_SUSPEND_MODE_RAM:
         if (!sys_pwr_caps.SystemS3) {
-            error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                       "suspend-to-ram not supported by OS");
+            error_setg(errp, "suspend-to-ram not supported by OS");
         }
         break;
     default:
@@ -2175,8 +2168,7 @@ static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
     HMODULE module = GetModuleHandle("ntdll");
     PVOID fun = GetProcAddress(module, "RtlGetVersion");
     if (fun == NULL) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED,
-            "Failed to get address of RtlGetVersion");
+        error_setg(errp, "Failed to get address of RtlGetVersion");
         return;
     }
 
diff --git a/qga/commands.c b/qga/commands.c
index 88c1c99fe5..5a5fad31f8 100644
--- a/qga/commands.c
+++ b/qga/commands.c
@@ -15,7 +15,6 @@
 #include "guest-agent-core.h"
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "qemu/base64.h"
 #include "qemu/cutils.h"
 #include "commands-common.h"
@@ -475,7 +474,7 @@ GuestExec *qmp_guest_exec(const char *path,
             guest_exec_task_setup, &has_merge, &pid, input_data ? &in_fd : NULL,
             has_output ? &out_fd : NULL, has_output ? &err_fd : NULL, &gerr);
     if (!ret) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED, gerr->message);
+        error_setg(errp, "%s", gerr->message);
         g_error_free(gerr);
         goto done;
     }
@@ -586,8 +585,7 @@ GuestTimezone *qmp_guest_get_timezone(Error **errp)
     info = g_new0(GuestTimezone, 1);
     tz = g_time_zone_new_local();
     if (tz == NULL) {
-        error_setg(errp, QERR_QGA_COMMAND_FAILED,
-                   "Couldn't retrieve local timezone");
+        error_setg(errp, "Couldn't retrieve local timezone");
         goto error;
     }
 
-- 
2.45.0


