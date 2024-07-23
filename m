Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FE8C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9YH-00054a-UK; Tue, 23 Jul 2024 03:03:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YE-0004rW-BW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1sW9YC-0000kV-7P
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721718186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kkenl+qhRsmytEQ9m14nID+/OlKKx7wjEg3Z5sEzvSY=;
 b=dfJifKBgxUWPlARz2FJv5GPrKwr5a9YG8kO/AnQmiSWolI8JWnBv2iTeG7XBkmDzD19MVR
 dPtnB8T6nZOFKPJMSfWUVXdmbjQC+l8iAefnj6bi1SrEt0wTDtrYtQxF2AeWghBmBz4hcj
 UyRpATgFdWKihnQVqHDvHGSB68wBupA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-5Y0n3vOVPau-CMmi8ftvaQ-1; Tue,
 23 Jul 2024 03:03:01 -0400
X-MC-Unique: 5Y0n3vOVPau-CMmi8ftvaQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E34DF1955D4A; Tue, 23 Jul 2024 07:03:00 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.211])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6BE743000197; Tue, 23 Jul 2024 07:02:58 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL v2 02/25] qga: move linux vcpu command impls to commands-linux.c
Date: Tue, 23 Jul 2024 10:02:28 +0300
Message-ID: <20240723070251.25575-3-kkostiuk@redhat.com>
In-Reply-To: <20240723070251.25575-1-kkostiuk@redhat.com>
References: <20240723070251.25575-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The qmp_guest_set_vcpus and qmp_guest_get_vcpus command impls in
commands-posix.c are surrounded by '#ifdef __linux__' so should
instead live in commands-linux.c

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240712132459.3974109-3-berrange@redhat.com>
Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
---
 qga/commands-linux.c | 141 +++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c | 139 ------------------------------------------
 2 files changed, 141 insertions(+), 139 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index 214e408fcd..78580ac39d 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -13,6 +13,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qga-qapi-commands.h"
 #include "commands-common.h"
 #include "cutils.h"
 #include <mntent.h>
@@ -284,3 +285,143 @@ int qmp_guest_fsfreeze_do_thaw(Error **errp)
     return i;
 }
 #endif /* CONFIG_FSFREEZE */
+
+/* Transfer online/offline status between @vcpu and the guest system.
+ *
+ * On input either @errp or *@errp must be NULL.
+ *
+ * In system-to-@vcpu direction, the following @vcpu fields are accessed:
+ * - R: vcpu->logical_id
+ * - W: vcpu->online
+ * - W: vcpu->can_offline
+ *
+ * In @vcpu-to-system direction, the following @vcpu fields are accessed:
+ * - R: vcpu->logical_id
+ * - R: vcpu->online
+ *
+ * Written members remain unmodified on error.
+ */
+static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
+                          char *dirpath, Error **errp)
+{
+    int fd;
+    int res;
+    int dirfd;
+    static const char fn[] = "online";
+
+    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
+    if (dirfd == -1) {
+        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+        return;
+    }
+
+    fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
+    if (fd == -1) {
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
+        } else if (sys2vcpu) {
+            vcpu->online = true;
+            vcpu->can_offline = false;
+        } else if (!vcpu->online) {
+            error_setg(errp, "logical processor #%" PRId64 " can't be "
+                       "offlined", vcpu->logical_id);
+        } /* otherwise pretend successful re-onlining */
+    } else {
+        unsigned char status;
+
+        res = pread(fd, &status, 1, 0);
+        if (res == -1) {
+            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
+        } else if (res == 0) {
+            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
+                       fn);
+        } else if (sys2vcpu) {
+            vcpu->online = (status != '0');
+            vcpu->can_offline = true;
+        } else if (vcpu->online != (status != '0')) {
+            status = '0' + vcpu->online;
+            if (pwrite(fd, &status, 1, 0) == -1) {
+                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
+                                 fn);
+            }
+        } /* otherwise pretend successful re-(on|off)-lining */
+
+        res = close(fd);
+        g_assert(res == 0);
+    }
+
+    res = close(dirfd);
+    g_assert(res == 0);
+}
+
+GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
+{
+    GuestLogicalProcessorList *head, **tail;
+    const char *cpu_dir = "/sys/devices/system/cpu";
+    const gchar *line;
+    g_autoptr(GDir) cpu_gdir = NULL;
+    Error *local_err = NULL;
+
+    head = NULL;
+    tail = &head;
+    cpu_gdir = g_dir_open(cpu_dir, 0, NULL);
+
+    if (cpu_gdir == NULL) {
+        error_setg_errno(errp, errno, "failed to list entries: %s", cpu_dir);
+        return NULL;
+    }
+
+    while (local_err == NULL && (line = g_dir_read_name(cpu_gdir)) != NULL) {
+        GuestLogicalProcessor *vcpu;
+        int64_t id;
+        if (sscanf(line, "cpu%" PRId64, &id)) {
+            g_autofree char *path = g_strdup_printf("/sys/devices/system/cpu/"
+                                                    "cpu%" PRId64 "/", id);
+            vcpu = g_malloc0(sizeof *vcpu);
+            vcpu->logical_id = id;
+            vcpu->has_can_offline = true; /* lolspeak ftw */
+            transfer_vcpu(vcpu, true, path, &local_err);
+            QAPI_LIST_APPEND(tail, vcpu);
+        }
+    }
+
+    if (local_err == NULL) {
+        /* there's no guest with zero VCPUs */
+        g_assert(head != NULL);
+        return head;
+    }
+
+    qapi_free_GuestLogicalProcessorList(head);
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
+{
+    int64_t processed;
+    Error *local_err = NULL;
+
+    processed = 0;
+    while (vcpus != NULL) {
+        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
+                                     vcpus->value->logical_id);
+
+        transfer_vcpu(vcpus->value, false, path, &local_err);
+        g_free(path);
+        if (local_err != NULL) {
+            break;
+        }
+        ++processed;
+        vcpus = vcpus->next;
+    }
+
+    if (local_err != NULL) {
+        if (processed == 0) {
+            error_propagate(errp, local_err);
+        } else {
+            error_free(local_err);
+        }
+    }
+
+    return processed;
+}
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 76af98ba32..a8ef41f175 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -2003,145 +2003,6 @@ void qmp_guest_suspend_hybrid(Error **errp)
     guest_suspend(SUSPEND_MODE_HYBRID, errp);
 }
 
-/* Transfer online/offline status between @vcpu and the guest system.
- *
- * On input either @errp or *@errp must be NULL.
- *
- * In system-to-@vcpu direction, the following @vcpu fields are accessed:
- * - R: vcpu->logical_id
- * - W: vcpu->online
- * - W: vcpu->can_offline
- *
- * In @vcpu-to-system direction, the following @vcpu fields are accessed:
- * - R: vcpu->logical_id
- * - R: vcpu->online
- *
- * Written members remain unmodified on error.
- */
-static void transfer_vcpu(GuestLogicalProcessor *vcpu, bool sys2vcpu,
-                          char *dirpath, Error **errp)
-{
-    int fd;
-    int res;
-    int dirfd;
-    static const char fn[] = "online";
-
-    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
-    if (dirfd == -1) {
-        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
-        return;
-    }
-
-    fd = openat(dirfd, fn, sys2vcpu ? O_RDONLY : O_RDWR);
-    if (fd == -1) {
-        if (errno != ENOENT) {
-            error_setg_errno(errp, errno, "open(\"%s/%s\")", dirpath, fn);
-        } else if (sys2vcpu) {
-            vcpu->online = true;
-            vcpu->can_offline = false;
-        } else if (!vcpu->online) {
-            error_setg(errp, "logical processor #%" PRId64 " can't be "
-                       "offlined", vcpu->logical_id);
-        } /* otherwise pretend successful re-onlining */
-    } else {
-        unsigned char status;
-
-        res = pread(fd, &status, 1, 0);
-        if (res == -1) {
-            error_setg_errno(errp, errno, "pread(\"%s/%s\")", dirpath, fn);
-        } else if (res == 0) {
-            error_setg(errp, "pread(\"%s/%s\"): unexpected EOF", dirpath,
-                       fn);
-        } else if (sys2vcpu) {
-            vcpu->online = (status != '0');
-            vcpu->can_offline = true;
-        } else if (vcpu->online != (status != '0')) {
-            status = '0' + vcpu->online;
-            if (pwrite(fd, &status, 1, 0) == -1) {
-                error_setg_errno(errp, errno, "pwrite(\"%s/%s\")", dirpath,
-                                 fn);
-            }
-        } /* otherwise pretend successful re-(on|off)-lining */
-
-        res = close(fd);
-        g_assert(res == 0);
-    }
-
-    res = close(dirfd);
-    g_assert(res == 0);
-}
-
-GuestLogicalProcessorList *qmp_guest_get_vcpus(Error **errp)
-{
-    GuestLogicalProcessorList *head, **tail;
-    const char *cpu_dir = "/sys/devices/system/cpu";
-    const gchar *line;
-    g_autoptr(GDir) cpu_gdir = NULL;
-    Error *local_err = NULL;
-
-    head = NULL;
-    tail = &head;
-    cpu_gdir = g_dir_open(cpu_dir, 0, NULL);
-
-    if (cpu_gdir == NULL) {
-        error_setg_errno(errp, errno, "failed to list entries: %s", cpu_dir);
-        return NULL;
-    }
-
-    while (local_err == NULL && (line = g_dir_read_name(cpu_gdir)) != NULL) {
-        GuestLogicalProcessor *vcpu;
-        int64_t id;
-        if (sscanf(line, "cpu%" PRId64, &id)) {
-            g_autofree char *path = g_strdup_printf("/sys/devices/system/cpu/"
-                                                    "cpu%" PRId64 "/", id);
-            vcpu = g_malloc0(sizeof *vcpu);
-            vcpu->logical_id = id;
-            vcpu->has_can_offline = true; /* lolspeak ftw */
-            transfer_vcpu(vcpu, true, path, &local_err);
-            QAPI_LIST_APPEND(tail, vcpu);
-        }
-    }
-
-    if (local_err == NULL) {
-        /* there's no guest with zero VCPUs */
-        g_assert(head != NULL);
-        return head;
-    }
-
-    qapi_free_GuestLogicalProcessorList(head);
-    error_propagate(errp, local_err);
-    return NULL;
-}
-
-int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
-{
-    int64_t processed;
-    Error *local_err = NULL;
-
-    processed = 0;
-    while (vcpus != NULL) {
-        char *path = g_strdup_printf("/sys/devices/system/cpu/cpu%" PRId64 "/",
-                                     vcpus->value->logical_id);
-
-        transfer_vcpu(vcpus->value, false, path, &local_err);
-        g_free(path);
-        if (local_err != NULL) {
-            break;
-        }
-        ++processed;
-        vcpus = vcpus->next;
-    }
-
-    if (local_err != NULL) {
-        if (processed == 0) {
-            error_propagate(errp, local_err);
-        } else {
-            error_free(local_err);
-        }
-    }
-
-    return processed;
-}
 #endif /* __linux__ */
 
 #if defined(__linux__) || defined(__FreeBSD__)
-- 
2.45.2


