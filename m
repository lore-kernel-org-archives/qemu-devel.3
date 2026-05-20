Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F774CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZW-0002pp-BT; Wed, 20 May 2026 17:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZO-0002Ka-PJ
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZM-0007fU-PK
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWydiIYQqrKb1lrC/Ixqufpo2JBJY982VhMLteFOhE4=;
 b=dv+Q1DO+ACNei4JTfsAyyhWrQlE7p1dkLX3vALaTEMud/aFPkq8eoutTu4P7VJH5/9bjhb
 020bcEt8nFuB9nr3IbbFHHCtcvft7FUqvwX5pvzx6Z3QcJYBoyfYtYMwj74HXu232JoXok
 vSmysPvML4QPhTfxPBRFso12OkBlKy8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-ywsRgMYVNFKBkkpao4tPYA-1; Wed, 20 May 2026 17:35:10 -0400
X-MC-Unique: ywsRgMYVNFKBkkpao4tPYA-1
X-Mimecast-MFC-AGG-ID: ywsRgMYVNFKBkkpao4tPYA_1779312910
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ca122dade4so66413616d6.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312910; x=1779917710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qWydiIYQqrKb1lrC/Ixqufpo2JBJY982VhMLteFOhE4=;
 b=aN1kMkajV1XtsLyQuPxC56v5EZ2MKitZ+9ySwHd7U0PD7V28DEahPOIAAslsviOjZv
 JvPR5nWc60LFfI/qTo22tZzTwWTystXBiKKY0SRjSJgcQ9RdeYt1IsnRLxZpHxU+z8cu
 WfBXwmLSAEMEhSDrRTwgIyu9dE7eiJQPtblkLi9knEorinKyWiOOqvWLh4fNEkLKl8dK
 1FWUUvd2OPEt5WY3th7SpkS8eSIVdCvNvUc7S4Fuxc7k2U8b27bYdbh7pbm6QdZWpYkZ
 P7vyRJ+cwoOi7ENp7DEgslOWo26bf6GX/y1TxKoSFB36DdyRPVPAoEdpUgZiGs1k8i+D
 P8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312910; x=1779917710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qWydiIYQqrKb1lrC/Ixqufpo2JBJY982VhMLteFOhE4=;
 b=njDAb7wC0jzK7hqwz7b+7IKvb9c7zM/GplqLa7jJsNjwLpfSgIN4guRyQyClRGNccR
 wIodQvx0eM4Vrp3P9zy+3RtUDn1DmSYCylmxRNUEj9V95euJnf40SMPf6vVvoIQrNSL0
 Qz3zHYVXCYZUGihLdOBjMzEOb7V+ojTahitWvkU/k2zhlimsmWXAiWvSfewXeQpTRx39
 1ZaPs2G3m3kpGan/xkPYDWt+QuVnUvx5Q9LZodS8AWb6u0yO2YDkvvypAG0Eaw7JWXO6
 2Qgg9+ZfSgyhfsE1WQH0LcGVO+lJkxxNpL41YutELOScbd7FjOwG/eU7pMUI+KrFIXj+
 yNDg==
X-Gm-Message-State: AOJu0YxcgV/ELkCBZ6myR5yzkUnzacfsOEHBeltTuVsc97mHi/DV+++x
 ySzNB7taxoKRU9EqtE4w8mT5PPfYeGRtHpvLX9/Yjj5u2KamS+HFROpOB3mLmMybfKIAyTK6qJP
 ZulGF7881688GaWo9v5YVkrDyrF/lswPoELQqpFBv2JMFuHf+yaH8sCuTVxvIqiAetWgJ3C4kfB
 y00a+8OfezEuNObKA8J2RXi+aPRIDOM+edHkxqBw==
X-Gm-Gg: Acq92OG+ijshfzWe+tG9/HLMoLPrxxdj5QX2puMh4VDALzbWy7mjU6v6xmrLJpuNxac
 Gqaede3Ic6p+8Zf30OT8XVK+HWch1CkQOL822bPqZ7Qv4paRL29jy8hE1t30HobtbrGkKot5FvN
 X4mP0dbYJUIJjqvMFgdXaiXf2kU1jCv6s03nmZuxaPx8wmY26RCbknAD/m6b1hWeUrW4+r5B+Wi
 X1gpSUNmB0kJby7zoAOyrumpMulrl2C3j+bPtNbwTyLFkJiWGYdxkpSxDrECJuScBP3V6JT02Tt
 EBTrcYyCdhEtkUuneJCglL5r2QnnwFiBZtDvAYAbwe0nLjfmEO1nOvmSDMb/l4v3Wq1SnjWggCX
 XyC9pWYCxPvdkmgxxX+FBoanj0DNl+suEKh3VrrEt2OUs
X-Received: by 2002:a05:6214:1305:b0:8cc:2a92:48ec with SMTP id
 6a1803df08f44-8cc6e37ec21mr3895996d6.34.1779312909629; 
 Wed, 20 May 2026 14:35:09 -0700 (PDT)
X-Received: by 2002:a05:6214:1305:b0:8cc:2a92:48ec with SMTP id
 6a1803df08f44-8cc6e37ec21mr3895126d6.34.1779312908832; 
 Wed, 20 May 2026 14:35:08 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.35.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:35:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 hongmianquan <hongmianquan@bytedance.com>
Subject: [PULL 28/29] migration/cpr: use hashtable for cpr fds
Date: Wed, 20 May 2026 17:33:56 -0400
Message-ID: <20260520213357.40646-29-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: hongmianquan <hongmianquan@bytedance.com>

Use a GHashTable to store cpr fds to reduce the time
consumption of `cpr_find_fd` in scenarios with a large
number of fds. The time complexity for `cpr_find_fd` is
reduced from O(N) to O(1).
Keep cpr fds lookups in a GHashTable during normal runtime
while preserving the existing QLIST migration ABI. Build a
temporary QLIST from the hash table in pre_save and rebuild
the hash table from the loaded QLIST in post_load.

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
Link: https://lore.kernel.org/r/20260519134315.27997-1-hongmianquan@bytedance.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr.c | 116 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 98 insertions(+), 18 deletions(-)

diff --git a/migration/cpr.c b/migration/cpr.c
index 05266dfcfd..bca43e9bf3 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -24,6 +24,7 @@
 /* cpr state container for all information to be saved. */
 
 CprState cpr_state;
+static GHashTable *cpr_fds_hash;
 
 /****************************************************************************/
 
@@ -48,6 +49,84 @@ static const VMStateDescription vmstate_cpr_fd = {
     }
 };
 
+static guint cpr_fd_hash(gconstpointer v)
+{
+    const CprFd *elem = v;
+
+    return g_str_hash(elem->name) ^ elem->id;
+}
+
+static gboolean cpr_fd_equal(gconstpointer a, gconstpointer b)
+{
+    const CprFd *elem_a = a;
+    const CprFd *elem_b = b;
+
+    return !strcmp(elem_a->name, elem_b->name) && elem_a->id == elem_b->id;
+}
+
+static void cpr_fd_destroy(gpointer data)
+{
+    CprFd *elem = data;
+
+    g_free(elem->name);
+    g_free(elem);
+}
+
+static GHashTable *get_cpr_fds_hash(void)
+{
+    if (!cpr_fds_hash) {
+        cpr_fds_hash = g_hash_table_new_full(cpr_fd_hash, cpr_fd_equal,
+                                             cpr_fd_destroy, NULL);
+    }
+
+    return cpr_fds_hash;
+}
+
+static void cpr_fd_hash_insert(CprFd *elem)
+{
+    /* Use the same CprFd as key and value. */
+    g_hash_table_insert(get_cpr_fds_hash(), elem, elem);
+}
+
+static int cpr_fd_pre_save(void *opaque)
+{
+    CprState *state = (CprState *)opaque;
+    GHashTableIter iter;
+    CprFd *elem;
+
+    QLIST_INIT(&state->fds);
+
+    g_hash_table_iter_init(&iter, get_cpr_fds_hash());
+    while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
+        QLIST_INSERT_HEAD(&state->fds, elem, next);
+    }
+
+    return 0;
+}
+
+static int cpr_fd_post_load(void *opaque, int version_id)
+{
+    CprState *state = (CprState *)opaque;
+    CprFd *elem;
+
+    while ((elem = QLIST_FIRST(&state->fds))) {
+        QLIST_REMOVE(elem, next);
+
+        /*
+         * Preserve legacy QLIST lookup semantics if duplicate keys exist in
+         * the incoming stream: the first matching entry wins.
+         */
+        if (g_hash_table_contains(get_cpr_fds_hash(), elem)) {
+            cpr_fd_destroy(elem);
+            continue;
+        }
+
+        cpr_fd_hash_insert(elem);
+    }
+
+    return 0;
+}
+
 void cpr_save_fd(const char *name, int id, int fd)
 {
     CprFd *elem = g_new0(CprFd, 1);
@@ -57,37 +136,34 @@ void cpr_save_fd(const char *name, int id, int fd)
     elem->namelen = strlen(name) + 1;
     elem->id = id;
     elem->fd = fd;
-    QLIST_INSERT_HEAD(&cpr_state.fds, elem, next);
+    cpr_fd_hash_insert(elem);
 }
 
-static CprFd *find_fd(CprFdList *head, const char *name, int id)
+static CprFd *find_fd(const char *name, int id)
 {
-    CprFd *elem;
+    CprFd key = {
+        .name = (char *)name,
+        .id = id,
+    };
 
-    QLIST_FOREACH(elem, head, next) {
-        if (!strcmp(elem->name, name) && elem->id == id) {
-            return elem;
-        }
-    }
-    return NULL;
+    return g_hash_table_lookup(get_cpr_fds_hash(), &key);
 }
 
 void cpr_delete_fd(const char *name, int id)
 {
-    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    CprFd key = {
+        .name = (char *)name,
+        .id = id,
+    };
 
-    if (elem) {
-        QLIST_REMOVE(elem, next);
-        g_free(elem->name);
-        g_free(elem);
-    }
+    g_hash_table_remove(get_cpr_fds_hash(), &key);
 
     trace_cpr_delete_fd(name, id);
 }
 
 int cpr_find_fd(const char *name, int id)
 {
-    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    CprFd *elem = find_fd(name, id);
     int fd = elem ? elem->fd : -1;
 
     trace_cpr_find_fd(name, id, fd);
@@ -96,7 +172,7 @@ int cpr_find_fd(const char *name, int id)
 
 void cpr_resave_fd(const char *name, int id, int fd)
 {
-    CprFd *elem = find_fd(&cpr_state.fds, name, id);
+    CprFd *elem = find_fd(name, id);
     int old_fd = elem ? elem->fd : -1;
 
     if (old_fd < 0) {
@@ -125,9 +201,11 @@ int cpr_open_fd(const char *path, int flags, const char *name, int id,
 
 bool cpr_walk_fd(cpr_walk_fd_cb cb)
 {
+    GHashTableIter iter;
     CprFd *elem;
 
-    QLIST_FOREACH(elem, &cpr_state.fds, next) {
+    g_hash_table_iter_init(&iter, get_cpr_fds_hash());
+    while (g_hash_table_iter_next(&iter, (gpointer *)&elem, NULL)) {
         g_assert(elem->fd >= 0);
         if (!cb(elem->fd)) {
             return false;
@@ -141,6 +219,8 @@ static const VMStateDescription vmstate_cpr_state = {
     .name = CPR_STATE,
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_save = cpr_fd_pre_save,
+    .post_load = cpr_fd_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_QLIST_V(fds, CprState, 1, vmstate_cpr_fd, CprFd, next),
         VMSTATE_END_OF_LIST()
-- 
2.53.0


