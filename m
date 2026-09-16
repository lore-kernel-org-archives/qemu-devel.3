Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C80C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pcu-00018f-07; Wed, 16 Sep 2026 09:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6pcr-00017u-Sa
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:24:38 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x6pcp-0003T4-SA
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:24:37 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso10481255e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1789565072; x=1790169872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AmT2DTipzV88wzGzPmVEFbqXiHfgiQPbVpiLoDeBPpw=;
 b=UOA8RPwaPdegJdv94AOL/oCVhSRt8GGzsV6tTnt/g5JIQQFs+Rvrmcmk8648neNLKA
 VJwoFTQbdj0rEpGvBu4oetbQ6E1Vsy/JcewXUvTyhhzgNNNRy9dNAPC8w9lOexL2I4BR
 JtD9jJKytIov7BJpNtW93g6z1GcVzDY5Ol7G8HSTbOSm/13Afe/OobgTi8L+YwlAVbMN
 LlKA4p2z/EoZ4jzcXCdS703dqF1UnEOwzXyvMBmLXLdi6TfNBDsXTB0vC8c5SoTx8oxa
 jm1Q+UpZf76FniRqO059KUkalt21tmgpPMZIiyQLcvedha6LkyPn7nE3hvN6kr+aBEZd
 3ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789565072; x=1790169872;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AmT2DTipzV88wzGzPmVEFbqXiHfgiQPbVpiLoDeBPpw=;
 b=V+74tAlhp9PASdkb+hy3HRLdoGZejPear3gBCR/EREbjKWoy3ILYMaBYKxMpNHswgv
 0WRSxM7E7mHiQ8I3rF8hpnXX/m6oe7csBV4Flrzmq1FzRGRNccPH7BCTBWkAdarLMFHE
 7nwkR9snAJUHC03cqjshVDJk+4rFvvGloKmAKLMy5hWhklan45eGyZxKxJrZWiv258nO
 Hocgj6pgRKBE+rr/BzKRSGHYGdWPuxxCWZfaq1j0X78xNkyz9HG1pChuTr7+Lm+AKvly
 kc3YXxw6YJjODai/7qWF20XLoP3aOFaMx4kwez43yCcMN1uC1qb2QagSkkjWhDbTobDj
 X1aQ==
X-Gm-Message-State: AFuF++nEjwSh/AtQadHjI0KsL9ISKdHNlAg6wajvoFKTQ+QOSEdp0++S
 nsa/eDhdKR00VfEiqmQhHsIa3fV3sfXIvWJ1wrN0h0cynhOtKHQviIuVKhkkiLZiDonbXTaQlh7
 eyFIH
X-Gm-Gg: AYBFou28M0rbCdcP7HmUQtZs0MT9ir4c3WnezqUeBH/S6Axz9T/mFLbotESb786FDzC
 KRH3cOzL+yLrtXGygNJN14OVZHrtKQdBLhObGWVSoQugtnvQd6zy0KHnZoPIG33eE3lKUNrn29Y
 T4qap3t7Ph6FeL1UFfmBil3zS8P/Yb7DbbnBqjyMlPXVx2ffqQgvPbmasXm12wlhxBJ4JO888PR
 sxltrifzWmChbGLcSgRAulMFYdmzLa/IoEygBUVGwFtymdaIyM0pkop9yh6vVfmg7maEik2Kscl
 dzMVZkV04TjdXzblZFMv1bxqGKuLsK+g/0BT/9lVbkXezLbZbcpsjNpljJu4jT9I0r1tywde9ot
 Tr3xK4Uo5EYhGy/PF60bIXzBltVyMzWXLsD2EV4i1V0F3Py7oOLdglW4hfyn7wVFYvKbk+IIKGp
 p0g/1HIqUt69IwOFzofUnZHigNtqWPY5x1tydPHU+viiY9ul/KpRZlhJ6CBVlA/i5psrDC
X-Received: by 2002:a05:600c:3e15:b0:49c:f617:7cf with SMTP id
 5b1f17b1804b1-49eac41066amr59412845e9.0.1789565072239; 
 Wed, 16 Sep 2026 06:24:32 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f56f:c51e:c53f:b1ce])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf4161fsm6579272f8f.34.2026.09.16.06.24.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:24:31 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH 1/1] migration/cpr: lock the cpr state
Date: Wed, 16 Sep 2026 15:24:28 +0200
Message-ID: <20260916132428.1628553-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=den@openvz.org; helo=mail-wm2-x10.google.com
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

From: Denis V. Lunev <den@openvz.org>

The cpr state is a process wide registry of the resources that have to
survive an exec. Entries are added and dropped from realize and teardown
paths all over the tree, and a caller has no way to tell which thread the
next caller will run in.

The state carries no serialization of its own. It is safe today only
because its callers happen to hold the BQL, and that is a property of
where those callers live rather than anything the interface promises or
checks. A caller that is correct within its own subsystem can therefore
break this one from a distance: two that overlap corrupt the registry,
and the next lookup walks an entry that has already been freed.

Give the state a lock of its own instead of relying on that. Entries
move when a device is realized, when a resource is handed over, and when
a migration starts, so none of this is on a hot path and an uncontended
mutex costs nothing.

Take the lock in every accessor and across the save and load walks.
Holding it over the walk callbacks is safe because none of them comes
back through this interface. State that is not reached through these
accessors, such as the VFIO device list that hw/vfio manipulates
directly, stays outside it.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Mark Kanda <mark.kanda@oracle.com>
Cc: Ben Chaney <bchaney@akamai.com>
Cc: Steve Sistare <steven.sistare@oracle.com>
---
 migration/cpr.c | 59 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index bca43e9bf3..503057e262 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -9,6 +9,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "qemu/lockable.h"
 #include "hw/vfio/vfio-cpr.h"
 #include "migration/cpr.h"
 #include "migration/misc.h"
@@ -26,6 +27,14 @@
 CprState cpr_state;
 static GHashTable *cpr_fds_hash;
 
+/* Callers are spread across the tree and need not share a thread. */
+static QemuMutex cpr_fds_lock;
+
+static void __attribute__((constructor)) cpr_fds_lock_init(void)
+{
+    qemu_mutex_init(&cpr_fds_lock);
+}
+
 /****************************************************************************/
 
 typedef struct CprFd {
@@ -94,6 +103,8 @@ static int cpr_fd_pre_save(void *opaque)
     GHashTableIter iter;
     CprFd *elem;
 
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
     QLIST_INIT(&state->fds);
 
     g_hash_table_iter_init(&iter, get_cpr_fds_hash());
@@ -109,6 +120,8 @@ static int cpr_fd_post_load(void *opaque, int version_id)
     CprState *state = (CprState *)opaque;
     CprFd *elem;
 
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
     while ((elem = QLIST_FIRST(&state->fds))) {
         QLIST_REMOVE(elem, next);
 
@@ -127,7 +140,7 @@ static int cpr_fd_post_load(void *opaque, int version_id)
     return 0;
 }
 
-void cpr_save_fd(const char *name, int id, int fd)
+static void do_cpr_save_fd(const char *name, int id, int fd)
 {
     CprFd *elem = g_new0(CprFd, 1);
 
@@ -139,6 +152,13 @@ void cpr_save_fd(const char *name, int id, int fd)
     cpr_fd_hash_insert(elem);
 }
 
+void cpr_save_fd(const char *name, int id, int fd)
+{
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
+    do_cpr_save_fd(name, id, fd);
+}
+
 static CprFd *find_fd(const char *name, int id)
 {
     CprFd key = {
@@ -149,6 +169,15 @@ static CprFd *find_fd(const char *name, int id)
     return g_hash_table_lookup(get_cpr_fds_hash(), &key);
 }
 
+static int do_cpr_find_fd(const char *name, int id)
+{
+    CprFd *elem = find_fd(name, id);
+    int fd = elem ? elem->fd : -1;
+
+    trace_cpr_find_fd(name, id, fd);
+    return fd;
+}
+
 void cpr_delete_fd(const char *name, int id)
 {
     CprFd key = {
@@ -156,6 +185,8 @@ void cpr_delete_fd(const char *name, int id)
         .id = id,
     };
 
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
     g_hash_table_remove(get_cpr_fds_hash(), &key);
 
     trace_cpr_delete_fd(name, id);
@@ -163,20 +194,23 @@ void cpr_delete_fd(const char *name, int id)
 
 int cpr_find_fd(const char *name, int id)
 {
-    CprFd *elem = find_fd(name, id);
-    int fd = elem ? elem->fd : -1;
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
 
-    trace_cpr_find_fd(name, id, fd);
-    return fd;
+    return do_cpr_find_fd(name, id);
 }
 
 void cpr_resave_fd(const char *name, int id, int fd)
 {
-    CprFd *elem = find_fd(name, id);
-    int old_fd = elem ? elem->fd : -1;
+    CprFd *elem;
+    int old_fd;
+
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
+    elem = find_fd(name, id);
+    old_fd = elem ? elem->fd : -1;
 
     if (old_fd < 0) {
-        cpr_save_fd(name, id, fd);
+        do_cpr_save_fd(name, id, fd);
     } else if (old_fd != fd) {
         error_report("internal error: cpr fd '%s' id %d value %d "
                      "already saved with a different value %d",
@@ -188,12 +222,15 @@ void cpr_resave_fd(const char *name, int id, int fd)
 int cpr_open_fd(const char *path, int flags, const char *name, int id,
                 Error **errp)
 {
-    int fd = cpr_find_fd(name, id);
+    int fd;
 
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
+    fd = do_cpr_find_fd(name, id);
     if (fd < 0) {
         fd = qemu_open(path, flags, errp);
         if (fd >= 0) {
-            cpr_save_fd(name, id, fd);
+            do_cpr_save_fd(name, id, fd);
         }
     }
     return fd;
@@ -204,6 +241,8 @@ bool cpr_walk_fd(cpr_walk_fd_cb cb)
     GHashTableIter iter;
     CprFd *elem;
 
+    QEMU_LOCK_GUARD(&cpr_fds_lock);
+
     g_hash_table_iter_init(&iter, get_cpr_fds_hash());
     while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
         g_assert(elem->fd >= 0);
-- 
2.53.0


