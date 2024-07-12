Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA93C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 13:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSGHk-0004gw-SD; Fri, 12 Jul 2024 09:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHG-0002ZD-Op
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sSGHE-0003q3-0L
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 09:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720790731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4pLNMZgzEcZH+ABN0fSwaZBCtEDFrs9igcxkhnnQzco=;
 b=JEGJrELHK/dxhHQj1iynbxtZqP8G//ecI0jcThiuDSn7NhNA98DkHC/q1ueBJvqomVFm57
 3ATHyXS5+A++N6ZF9KtskLOKPYhLzRD3zuM5IsO33JfTg6jD8eDQVOZweCU77LTnpsKMms
 eQhi2J83a2FcNp8TxQUmPk66RcwdgyA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-223-hm4I8hclNr656ERGDDGGDw-1; Fri,
 12 Jul 2024 09:25:27 -0400
X-MC-Unique: hm4I8hclNr656ERGDDGGDw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE3461955F69; Fri, 12 Jul 2024 13:25:26 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.56])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72AB1955F40; Fri, 12 Jul 2024 13:25:23 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [PATCH v3 06/22] qga: move linux memory block command impls to
 commands-linux.c
Date: Fri, 12 Jul 2024 14:24:43 +0100
Message-ID: <20240712132459.3974109-7-berrange@redhat.com>
In-Reply-To: <20240712132459.3974109-1-berrange@redhat.com>
References: <20240712132459.3974109-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The qmp_guest_{set,get}_{memory_blocks,block_info} command impls in
commands-posix.c are surrounded by '#ifdef __linux__' so should
instead live in commands-linux.c

This also removes a "#ifdef CONFIG_LINUX" that was nested inside
a "#ifdef __linux__".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qga/commands-linux.c | 308 ++++++++++++++++++++++++++++++++++++++++++
 qga/commands-posix.c | 311 +------------------------------------------
 2 files changed, 309 insertions(+), 310 deletions(-)

diff --git a/qga/commands-linux.c b/qga/commands-linux.c
index c0e8bd4062..73b13fbaf6 100644
--- a/qga/commands-linux.c
+++ b/qga/commands-linux.c
@@ -1595,6 +1595,314 @@ int64_t qmp_guest_set_vcpus(GuestLogicalProcessorList *vcpus, Error **errp)
     return processed;
 }
 
+
+static void ga_read_sysfs_file(int dirfd, const char *pathname, char *buf,
+                               int size, Error **errp)
+{
+    int fd;
+    int res;
+
+    errno = 0;
+    fd = openat(dirfd, pathname, O_RDONLY);
+    if (fd == -1) {
+        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname);
+        return;
+    }
+
+    res = pread(fd, buf, size, 0);
+    if (res == -1) {
+        error_setg_errno(errp, errno, "pread sysfs file \"%s\"", pathname);
+    } else if (res == 0) {
+        error_setg(errp, "pread sysfs file \"%s\": unexpected EOF", pathname);
+    }
+    close(fd);
+}
+
+static void ga_write_sysfs_file(int dirfd, const char *pathname,
+                                const char *buf, int size, Error **errp)
+{
+    int fd;
+
+    errno = 0;
+    fd = openat(dirfd, pathname, O_WRONLY);
+    if (fd == -1) {
+        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname);
+        return;
+    }
+
+    if (pwrite(fd, buf, size, 0) == -1) {
+        error_setg_errno(errp, errno, "pwrite sysfs file \"%s\"", pathname);
+    }
+
+    close(fd);
+}
+
+/* Transfer online/offline status between @mem_blk and the guest system.
+ *
+ * On input either @errp or *@errp must be NULL.
+ *
+ * In system-to-@mem_blk direction, the following @mem_blk fields are accessed:
+ * - R: mem_blk->phys_index
+ * - W: mem_blk->online
+ * - W: mem_blk->can_offline
+ *
+ * In @mem_blk-to-system direction, the following @mem_blk fields are accessed:
+ * - R: mem_blk->phys_index
+ * - R: mem_blk->online
+ *-  R: mem_blk->can_offline
+ * Written members remain unmodified on error.
+ */
+static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
+                                  GuestMemoryBlockResponse *result,
+                                  Error **errp)
+{
+    char *dirpath;
+    int dirfd;
+    char *status;
+    Error *local_err = NULL;
+
+    if (!sys2memblk) {
+        DIR *dp;
+
+        if (!result) {
+            error_setg(errp, "Internal error, 'result' should not be NULL");
+            return;
+        }
+        errno = 0;
+        dp = opendir("/sys/devices/system/memory/");
+         /* if there is no 'memory' directory in sysfs,
+         * we think this VM does not support online/offline memory block,
+         * any other solution?
+         */
+        if (!dp) {
+            if (errno == ENOENT) {
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
+            }
+            goto out1;
+        }
+        closedir(dp);
+    }
+
+    dirpath = g_strdup_printf("/sys/devices/system/memory/memory%" PRId64 "/",
+                              mem_blk->phys_index);
+    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
+    if (dirfd == -1) {
+        if (sys2memblk) {
+            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+        } else {
+            if (errno == ENOENT) {
+                result->response = GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;
+            } else {
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
+            }
+        }
+        g_free(dirpath);
+        goto out1;
+    }
+    g_free(dirpath);
+
+    status = g_malloc0(10);
+    ga_read_sysfs_file(dirfd, "state", status, 10, &local_err);
+    if (local_err) {
+        /* treat with sysfs file that not exist in old kernel */
+        if (errno == ENOENT) {
+            error_free(local_err);
+            if (sys2memblk) {
+                mem_blk->online = true;
+                mem_blk->can_offline = false;
+            } else if (!mem_blk->online) {
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
+            }
+        } else {
+            if (sys2memblk) {
+                error_propagate(errp, local_err);
+            } else {
+                error_free(local_err);
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
+            }
+        }
+        goto out2;
+    }
+
+    if (sys2memblk) {
+        char removable = '0';
+
+        mem_blk->online = (strncmp(status, "online", 6) == 0);
+
+        ga_read_sysfs_file(dirfd, "removable", &removable, 1, &local_err);
+        if (local_err) {
+            /* if no 'removable' file, it doesn't support offline mem blk */
+            if (errno == ENOENT) {
+                error_free(local_err);
+                mem_blk->can_offline = false;
+            } else {
+                error_propagate(errp, local_err);
+            }
+        } else {
+            mem_blk->can_offline = (removable != '0');
+        }
+    } else {
+        if (mem_blk->online != (strncmp(status, "online", 6) == 0)) {
+            const char *new_state = mem_blk->online ? "online" : "offline";
+
+            ga_write_sysfs_file(dirfd, "state", new_state, strlen(new_state),
+                                &local_err);
+            if (local_err) {
+                error_free(local_err);
+                result->response =
+                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
+                goto out2;
+            }
+
+            result->response = GUEST_MEMORY_BLOCK_RESPONSE_TYPE_SUCCESS;
+            result->has_error_code = false;
+        } /* otherwise pretend successful re-(on|off)-lining */
+    }
+    g_free(status);
+    close(dirfd);
+    return;
+
+out2:
+    g_free(status);
+    close(dirfd);
+out1:
+    if (!sys2memblk) {
+        result->has_error_code = true;
+        result->error_code = errno;
+    }
+}
+
+GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
+{
+    GuestMemoryBlockList *head, **tail;
+    Error *local_err = NULL;
+    struct dirent *de;
+    DIR *dp;
+
+    head = NULL;
+    tail = &head;
+
+    dp = opendir("/sys/devices/system/memory/");
+    if (!dp) {
+        /* it's ok if this happens to be a system that doesn't expose
+         * memory blocks via sysfs, but otherwise we should report
+         * an error
+         */
+        if (errno != ENOENT) {
+            error_setg_errno(errp, errno, "Can't open directory"
+                             "\"/sys/devices/system/memory/\"");
+        }
+        return NULL;
+    }
+
+    /* Note: the phys_index of memory block may be discontinuous,
+     * this is because a memblk is the unit of the Sparse Memory design, which
+     * allows discontinuous memory ranges (ex. NUMA), so here we should
+     * traverse the memory block directory.
+     */
+    while ((de = readdir(dp)) != NULL) {
+        GuestMemoryBlock *mem_blk;
+
+        if ((strncmp(de->d_name, "memory", 6) != 0) ||
+            !(de->d_type & DT_DIR)) {
+            continue;
+        }
+
+        mem_blk = g_malloc0(sizeof *mem_blk);
+        /* The d_name is "memoryXXX",  phys_index is block id, same as XXX */
+        mem_blk->phys_index = strtoul(&de->d_name[6], NULL, 10);
+        mem_blk->has_can_offline = true; /* lolspeak ftw */
+        transfer_memory_block(mem_blk, true, NULL, &local_err);
+        if (local_err) {
+            break;
+        }
+
+        QAPI_LIST_APPEND(tail, mem_blk);
+    }
+
+    closedir(dp);
+    if (local_err == NULL) {
+        /* there's no guest with zero memory blocks */
+        if (head == NULL) {
+            error_setg(errp, "guest reported zero memory blocks!");
+        }
+        return head;
+    }
+
+    qapi_free_GuestMemoryBlockList(head);
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+GuestMemoryBlockResponseList *
+qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
+{
+    GuestMemoryBlockResponseList *head, **tail;
+    Error *local_err = NULL;
+
+    head = NULL;
+    tail = &head;
+
+    while (mem_blks != NULL) {
+        GuestMemoryBlockResponse *result;
+        GuestMemoryBlock *current_mem_blk = mem_blks->value;
+
+        result = g_malloc0(sizeof(*result));
+        result->phys_index = current_mem_blk->phys_index;
+        transfer_memory_block(current_mem_blk, false, result, &local_err);
+        if (local_err) { /* should never happen */
+            goto err;
+        }
+
+        QAPI_LIST_APPEND(tail, result);
+        mem_blks = mem_blks->next;
+    }
+
+    return head;
+err:
+    qapi_free_GuestMemoryBlockResponseList(head);
+    error_propagate(errp, local_err);
+    return NULL;
+}
+
+GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
+{
+    Error *local_err = NULL;
+    char *dirpath;
+    int dirfd;
+    char *buf;
+    GuestMemoryBlockInfo *info;
+
+    dirpath = g_strdup_printf("/sys/devices/system/memory/");
+    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
+    if (dirfd == -1) {
+        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
+        g_free(dirpath);
+        return NULL;
+    }
+    g_free(dirpath);
+
+    buf = g_malloc0(20);
+    ga_read_sysfs_file(dirfd, "block_size_bytes", buf, 20, &local_err);
+    close(dirfd);
+    if (local_err) {
+        g_free(buf);
+        error_propagate(errp, local_err);
+        return NULL;
+    }
+
+    info = g_new0(GuestMemoryBlockInfo, 1);
+    info->size = strtol(buf, NULL, 16); /* the unit is bytes */
+
+    g_free(buf);
+
+    return info;
+}
+
 #define MAX_NAME_LEN 128
 static GuestDiskStatsInfoList *guest_get_diskstats(Error **errp)
 {
diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 5da60e65ab..2a3bef7445 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -887,316 +887,7 @@ void qmp_guest_set_user_password(const char *username,
 }
 #endif /* __linux__ || __FreeBSD__ */
 
-#ifdef __linux__
-static void ga_read_sysfs_file(int dirfd, const char *pathname, char *buf,
-                               int size, Error **errp)
-{
-    int fd;
-    int res;
-
-    errno = 0;
-    fd = openat(dirfd, pathname, O_RDONLY);
-    if (fd == -1) {
-        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname);
-        return;
-    }
-
-    res = pread(fd, buf, size, 0);
-    if (res == -1) {
-        error_setg_errno(errp, errno, "pread sysfs file \"%s\"", pathname);
-    } else if (res == 0) {
-        error_setg(errp, "pread sysfs file \"%s\": unexpected EOF", pathname);
-    }
-    close(fd);
-}
-
-static void ga_write_sysfs_file(int dirfd, const char *pathname,
-                                const char *buf, int size, Error **errp)
-{
-    int fd;
-
-    errno = 0;
-    fd = openat(dirfd, pathname, O_WRONLY);
-    if (fd == -1) {
-        error_setg_errno(errp, errno, "open sysfs file \"%s\"", pathname);
-        return;
-    }
-
-    if (pwrite(fd, buf, size, 0) == -1) {
-        error_setg_errno(errp, errno, "pwrite sysfs file \"%s\"", pathname);
-    }
-
-    close(fd);
-}
-
-/* Transfer online/offline status between @mem_blk and the guest system.
- *
- * On input either @errp or *@errp must be NULL.
- *
- * In system-to-@mem_blk direction, the following @mem_blk fields are accessed:
- * - R: mem_blk->phys_index
- * - W: mem_blk->online
- * - W: mem_blk->can_offline
- *
- * In @mem_blk-to-system direction, the following @mem_blk fields are accessed:
- * - R: mem_blk->phys_index
- * - R: mem_blk->online
- *-  R: mem_blk->can_offline
- * Written members remain unmodified on error.
- */
-static void transfer_memory_block(GuestMemoryBlock *mem_blk, bool sys2memblk,
-                                  GuestMemoryBlockResponse *result,
-                                  Error **errp)
-{
-    char *dirpath;
-    int dirfd;
-    char *status;
-    Error *local_err = NULL;
-
-    if (!sys2memblk) {
-        DIR *dp;
-
-        if (!result) {
-            error_setg(errp, "Internal error, 'result' should not be NULL");
-            return;
-        }
-        errno = 0;
-        dp = opendir("/sys/devices/system/memory/");
-         /* if there is no 'memory' directory in sysfs,
-         * we think this VM does not support online/offline memory block,
-         * any other solution?
-         */
-        if (!dp) {
-            if (errno == ENOENT) {
-                result->response =
-                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
-            }
-            goto out1;
-        }
-        closedir(dp);
-    }
-
-    dirpath = g_strdup_printf("/sys/devices/system/memory/memory%" PRId64 "/",
-                              mem_blk->phys_index);
-    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
-    if (dirfd == -1) {
-        if (sys2memblk) {
-            error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
-        } else {
-            if (errno == ENOENT) {
-                result->response = GUEST_MEMORY_BLOCK_RESPONSE_TYPE_NOT_FOUND;
-            } else {
-                result->response =
-                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
-            }
-        }
-        g_free(dirpath);
-        goto out1;
-    }
-    g_free(dirpath);
-
-    status = g_malloc0(10);
-    ga_read_sysfs_file(dirfd, "state", status, 10, &local_err);
-    if (local_err) {
-        /* treat with sysfs file that not exist in old kernel */
-        if (errno == ENOENT) {
-            error_free(local_err);
-            if (sys2memblk) {
-                mem_blk->online = true;
-                mem_blk->can_offline = false;
-            } else if (!mem_blk->online) {
-                result->response =
-                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_NOT_SUPPORTED;
-            }
-        } else {
-            if (sys2memblk) {
-                error_propagate(errp, local_err);
-            } else {
-                error_free(local_err);
-                result->response =
-                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
-            }
-        }
-        goto out2;
-    }
-
-    if (sys2memblk) {
-        char removable = '0';
-
-        mem_blk->online = (strncmp(status, "online", 6) == 0);
-
-        ga_read_sysfs_file(dirfd, "removable", &removable, 1, &local_err);
-        if (local_err) {
-            /* if no 'removable' file, it doesn't support offline mem blk */
-            if (errno == ENOENT) {
-                error_free(local_err);
-                mem_blk->can_offline = false;
-            } else {
-                error_propagate(errp, local_err);
-            }
-        } else {
-            mem_blk->can_offline = (removable != '0');
-        }
-    } else {
-        if (mem_blk->online != (strncmp(status, "online", 6) == 0)) {
-            const char *new_state = mem_blk->online ? "online" : "offline";
-
-            ga_write_sysfs_file(dirfd, "state", new_state, strlen(new_state),
-                                &local_err);
-            if (local_err) {
-                error_free(local_err);
-                result->response =
-                    GUEST_MEMORY_BLOCK_RESPONSE_TYPE_OPERATION_FAILED;
-                goto out2;
-            }
-
-            result->response = GUEST_MEMORY_BLOCK_RESPONSE_TYPE_SUCCESS;
-            result->has_error_code = false;
-        } /* otherwise pretend successful re-(on|off)-lining */
-    }
-    g_free(status);
-    close(dirfd);
-    return;
-
-out2:
-    g_free(status);
-    close(dirfd);
-out1:
-    if (!sys2memblk) {
-        result->has_error_code = true;
-        result->error_code = errno;
-    }
-}
-
-GuestMemoryBlockList *qmp_guest_get_memory_blocks(Error **errp)
-{
-    GuestMemoryBlockList *head, **tail;
-    Error *local_err = NULL;
-    struct dirent *de;
-    DIR *dp;
-
-    head = NULL;
-    tail = &head;
-
-    dp = opendir("/sys/devices/system/memory/");
-    if (!dp) {
-        /* it's ok if this happens to be a system that doesn't expose
-         * memory blocks via sysfs, but otherwise we should report
-         * an error
-         */
-        if (errno != ENOENT) {
-            error_setg_errno(errp, errno, "Can't open directory"
-                             "\"/sys/devices/system/memory/\"");
-        }
-        return NULL;
-    }
-
-    /* Note: the phys_index of memory block may be discontinuous,
-     * this is because a memblk is the unit of the Sparse Memory design, which
-     * allows discontinuous memory ranges (ex. NUMA), so here we should
-     * traverse the memory block directory.
-     */
-    while ((de = readdir(dp)) != NULL) {
-        GuestMemoryBlock *mem_blk;
-
-        if ((strncmp(de->d_name, "memory", 6) != 0) ||
-            !(de->d_type & DT_DIR)) {
-            continue;
-        }
-
-        mem_blk = g_malloc0(sizeof *mem_blk);
-        /* The d_name is "memoryXXX",  phys_index is block id, same as XXX */
-        mem_blk->phys_index = strtoul(&de->d_name[6], NULL, 10);
-        mem_blk->has_can_offline = true; /* lolspeak ftw */
-        transfer_memory_block(mem_blk, true, NULL, &local_err);
-        if (local_err) {
-            break;
-        }
-
-        QAPI_LIST_APPEND(tail, mem_blk);
-    }
-
-    closedir(dp);
-    if (local_err == NULL) {
-        /* there's no guest with zero memory blocks */
-        if (head == NULL) {
-            error_setg(errp, "guest reported zero memory blocks!");
-        }
-        return head;
-    }
-
-    qapi_free_GuestMemoryBlockList(head);
-    error_propagate(errp, local_err);
-    return NULL;
-}
-
-GuestMemoryBlockResponseList *
-qmp_guest_set_memory_blocks(GuestMemoryBlockList *mem_blks, Error **errp)
-{
-    GuestMemoryBlockResponseList *head, **tail;
-    Error *local_err = NULL;
-
-    head = NULL;
-    tail = &head;
-
-    while (mem_blks != NULL) {
-        GuestMemoryBlockResponse *result;
-        GuestMemoryBlock *current_mem_blk = mem_blks->value;
-
-        result = g_malloc0(sizeof(*result));
-        result->phys_index = current_mem_blk->phys_index;
-        transfer_memory_block(current_mem_blk, false, result, &local_err);
-        if (local_err) { /* should never happen */
-            goto err;
-        }
-
-        QAPI_LIST_APPEND(tail, result);
-        mem_blks = mem_blks->next;
-    }
-
-    return head;
-err:
-    qapi_free_GuestMemoryBlockResponseList(head);
-    error_propagate(errp, local_err);
-    return NULL;
-}
-
-GuestMemoryBlockInfo *qmp_guest_get_memory_block_info(Error **errp)
-{
-    Error *local_err = NULL;
-    char *dirpath;
-    int dirfd;
-    char *buf;
-    GuestMemoryBlockInfo *info;
-
-    dirpath = g_strdup_printf("/sys/devices/system/memory/");
-    dirfd = open(dirpath, O_RDONLY | O_DIRECTORY);
-    if (dirfd == -1) {
-        error_setg_errno(errp, errno, "open(\"%s\")", dirpath);
-        g_free(dirpath);
-        return NULL;
-    }
-    g_free(dirpath);
-
-    buf = g_malloc0(20);
-    ga_read_sysfs_file(dirfd, "block_size_bytes", buf, 20, &local_err);
-    close(dirfd);
-    if (local_err) {
-        g_free(buf);
-        error_propagate(errp, local_err);
-        return NULL;
-    }
-
-    info = g_new0(GuestMemoryBlockInfo, 1);
-    info->size = strtol(buf, NULL, 16); /* the unit is bytes */
-
-    g_free(buf);
-
-    return info;
-}
-
-
-#else /* defined(__linux__) */
+#ifndef __linux__
 
 void qmp_guest_suspend_disk(Error **errp)
 {
-- 
2.45.1


