Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F091B108E1F3
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:39:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Bif-0007K6-7h; Thu, 19 Mar 2026 07:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3Bib-0007Js-RO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:39:14 -0400
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongmianquan@bytedance.com>)
 id 1w3Bia-0004cR-2d
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 07:39:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1773920346; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=TveFI/sDZqiQ3mrpO0u1dXilS/98mgQUpWeqgtqotqQ=;
 b=ENXfe4z0cQx7yKjeFM2ayRbgBztO75YaAJzRVZiUfHZq52JeXuunVfrkoCG6cYC4GAwGIH
 nufwaOwV3z51LCFshFqkYqmHNeuHTd6SJcgOWui0aRICew23+HhMkC+fl6o996zuF5nxhZ
 y8fwRIX7kAmjJ32EWMWX/oFlVfsk8u0L3ZU/afUvVgMee94FNbmCejxl6HZuT/EHbsWVY4
 XPRk5SyTMMzer2dlRiiFW8MDtFdyX8n4PRgq6equUXL3iYtxJLtPcN6rlcYkrwBItg5xg2
 qc0qSXXC/zQ4IJp+wO6wi6hVSJ4403VzKdoNxoex9TMApjanJoc9KTaMW3bngw==
Cc: <peterx@redhat.com>, <farosas@suse.de>, <mark.kanda@oracle.com>, 
 <bchaney@akamai.com>, "hongmianquan" <hongmianquan@bytedance.com>
From: "hongmianquan" <hongmianquan@bytedance.com>
Subject: [RFC v2 2/2] cpr: use hashtable for cpr fds
Mime-Version: 1.0
In-Reply-To: <20260319113830.53867-1-hongmianquan@bytedance.com>
To: <qemu-devel@nongnu.org>
References: <20260319113830.53867-1-hongmianquan@bytedance.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
Date: Thu, 19 Mar 2026 19:38:30 +0800
Message-Id: <20260319113830.53867-3-hongmianquan@bytedance.com>
X-Lms-Return-Path: <lba+269bbe058+29f6a8+nongnu.org+hongmianquan@bytedance.com>
X-Original-From: hongmianquan <hongmianquan@bytedance.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Received-SPF: pass client-ip=209.127.230.112;
 envelope-from=hongmianquan@bytedance.com; helo=va-1-112.ptr.blmpb.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Use a hashtable to store cpr fds to reduce the time
consumption of `cpr_find_fd` in scenarios with a large
number of fds, which relies on the migration support for
GHashTable implemented earlier. The time complexity for
`cpr_find_fd` is reduced from O(N) to O(1).
To demonstrate the performance improvement, we tested the total time
consumed by `cpr_find_fd` (called N times for N fds) under our real-world
business scenarios with different numbers of file descriptors. The results
are measured in nanoseconds:

| Number of FDs | Total time with QLIST (ns) | Total time with GHashTable (ns) |
|---------------|----------------------------|---------------------------------|
| 540           | 936,753                    | 393,358                         |
| 2,870         | 24,102,342                 | 2,212,113                       |
| 7,530         | 152,715,916                | 5,474,310                       |

As shown in the data, the lookup time grows exponentially with the QLIST
as the number of fds increases. With the GHashTable, the time consumption
remains linear (O(1) per lookup), significantly reducing the downtime during
the CPR process.

Signed-off-by: hongmianquan <hongmianquan@bytedance.com>
---
 include/migration/cpr.h |   4 +-
 migration/cpr.c         | 129 ++++++++++++++++++++++++++++------------
 system/vl.c             |   2 +
 3 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 5850fd1788..858b251bb5 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -18,16 +18,16 @@
 #define QEMU_CPR_FILE_VERSION   0x00000001
 #define CPR_STATE "CprState"
 
-typedef QLIST_HEAD(CprFdList, CprFd) CprFdList;
 typedef QLIST_HEAD(CprVFIODeviceList, CprVFIODevice) CprVFIODeviceList;
 
 typedef struct CprState {
-    CprFdList fds;
+    GHashTable *fds;
     CprVFIODeviceList vfio_devices;
 } CprState;
 
 extern CprState cpr_state;
 
+void cpr_state_init(void);
 void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
diff --git a/migration/cpr.c b/migration/cpr.c
index a0b37007f5..cfdddb5043 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -27,59 +27,101 @@ CprState cpr_state;
 
 /****************************************************************************/
 
-typedef struct CprFd {
+typedef struct CprFdKey {
     char *name;
     unsigned int namelen;
     int id;
+} CprFdKey;
+
+typedef struct CprFdVal {
     int fd;
-    QLIST_ENTRY(CprFd) next;
-} CprFd;
+} CprFdVal;
+
+#define VMSTATE_FDS_KEY                                                 \
+{                                                                       \
+    .name = "cpr-fd-key",                                               \
+    .version_id = 1,                                                    \
+    .minimum_version_id = 1,                                            \
+    .fields = (const VMStateField[]) {                                  \
+        VMSTATE_UINT32(namelen, CprFdKey),                              \
+        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFdKey, 0, NULL, namelen), \
+        VMSTATE_INT32(id, CprFdKey),                                    \
+        VMSTATE_END_OF_LIST()                                           \
+    }                                                                   \
+}
 
-static const VMStateDescription vmstate_cpr_fd = {
-    .name = "cpr fd",
-    .version_id = 1,
-    .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
-        VMSTATE_UINT32(namelen, CprFd),
-        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprFd, 0, NULL, namelen),
-        VMSTATE_INT32(id, CprFd),
-        VMSTATE_FD(fd, CprFd),
-        VMSTATE_END_OF_LIST()
-    }
+#define VMSTATE_FDS_VAL                 \
+{                                       \
+    .name = "cpr-fd-value",             \
+    .version_id = 1,                    \
+    .minimum_version_id = 1,            \
+    .fields = (const VMStateField[]) {  \
+        VMSTATE_FD(fd, CprFdVal),       \
+        VMSTATE_END_OF_LIST()           \
+    }                                   \
+}
+
+static const VMStateDescription vmstate_fds_hashtable[2] = {
+    VMSTATE_FDS_VAL,   /* value */
+    VMSTATE_FDS_KEY   /* key */
 };
 
+static guint cpr_fd_key_hash(gconstpointer v)
+{
+    const CprFdKey *key = v;
+    return g_str_hash(key->name) ^ key->id;
+}
+
+static gboolean cpr_fd_key_equal(gconstpointer a, gconstpointer b)
+{
+    const CprFdKey *key_a = a;
+    const CprFdKey *key_b = b;
+    return !strcmp(key_a->name, key_b->name) && key_a->id == key_b->id;
+}
+
+static void cpr_destroy_fd_key(gpointer data)
+{
+    CprFdKey *k = (CprFdKey *) data;
+    g_free(k->name);
+    g_free(k);
+}
+
+void cpr_state_init(void)
+{
+    CprState *s = &cpr_state;
+
+    s->fds = g_hash_table_new_full(cpr_fd_key_hash, cpr_fd_key_equal,
+                                   cpr_destroy_fd_key, g_free);
+}
+
 void cpr_save_fd(const char *name, int id, int fd)
 {
-    CprFd *elem = g_new0(CprFd, 1);
+    CprFdKey *key = g_new0(CprFdKey, 1);
+    CprFdVal *val = g_new0(CprFdVal, 1);
 
     trace_cpr_save_fd(name, id, fd);
-    elem->name = g_strdup(name);
-    elem->namelen = strlen(name) + 1;
-    elem->id = id;
-    elem->fd = fd;
-    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
+    key->name = g_strdup(name);
+    key->namelen = strlen(name) + 1;
+    key->id = id;
+    val->fd = fd;
+    g_hash_table_insert(cpr_state.fds, key, val);
 }
 
-static CprFd *find_fd(CprFdList *head, const char *name, int id)
+static CprFdVal *find_fd(CprFdKey *key)
 {
-    CprFd *elem;
-
-    QLIST_FOREACH(elem, head, next) {
-        if (!strcmp(elem->name, name) && elem->id == id) {
-            return elem;
-        }
-    }
-    return NULL;
+    return g_hash_table_lookup(cpr_state.fds, key);
 }
 
 void cpr_delete_fd(const char *name, int id)
 {
-    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    CprFdKey key = {
+        .name = (char *)name,
+        .id = id,
+    };
+    CprFdVal *elem = find_fd(&key);
 
     if (elem) {
-        QLIST_REMOVE(elem, next);
-        g_free(elem->name);
-        g_free(elem);
+        g_hash_table_remove(cpr_state.fds, &key);
     }
 
     trace_cpr_delete_fd(name, id);
@@ -87,7 +129,11 @@ void cpr_delete_fd(const char *name, int id)
 
 int cpr_find_fd(const char *name, int id)
 {
-    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    CprFdKey key = {
+        .name = (char *)name,
+        .id = id,
+    };
+    CprFdVal *elem = find_fd(&key);
     int fd = elem ? elem->fd : -1;
 
     trace_cpr_find_fd(name, id, fd);
@@ -96,7 +142,11 @@ int cpr_find_fd(const char *name, int id)
 
 void cpr_resave_fd(const char *name, int id, int fd)
 {
-    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    CprFdKey key = {
+        .name = (char *)name,
+        .id = id,
+    };
+    CprFdVal *elem = find_fd(&key);
     int old_fd = elem ? elem->fd : -1;
 
     if (old_fd < 0) {
@@ -125,9 +175,11 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 
 bool cpr_walk_fd(cpr_walk_fd_cb cb)
 {
-    CprFd *elem;
+    GHashTableIter iter;
+    CprFdVal *elem;
 
-    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+    g_hash_table_iter_init(&iter, cpr_state.fds);
+    while (g_hash_table_iter_next(&iter, NULL, (gpointer *)&elem)) {
         g_assert(elem->fd >= 0);
         if (!cb(elem->fd)) {
             return false;
@@ -142,7 +194,8 @@ static const VMStateDescription vmstate_cpr_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (VMStateField[]) {
-        VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
+        VMSTATE_GHASH_V(fds, CprState, 1, vmstate_fds_hashtable,
+                        CprFdKey, CprFdVal),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
diff --git a/system/vl.c b/system/vl.c
index 3e341142a0..da42de87db 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2894,6 +2894,8 @@ void qemu_init(int argc, char **argv)
 
     qemu_init_subsystems();
 
+    cpr_state_init();
+
     /* first pass of option parsing */
     optind = 1;
     while (optind < argc) {
-- 
2.32.1 (Apple Git-133)

