Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EFEC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 16:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg53n-0008LI-LR; Thu, 06 Feb 2025 11:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0ad7cb925edff3f14bd47fdb7ef3c0b6186960d4@kylie.crudebyte.com>)
 id 1tg53b-0008Ji-NM
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:48:52 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <0ad7cb925edff3f14bd47fdb7ef3c0b6186960d4@kylie.crudebyte.com>)
 id 1tg53Z-0006DY-Vo
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 11:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=D9wDRyQBxJlr5I2gWNfNbciP1wRvnJLh7g260qArd8s=; b=S5RQ0
 K3KqMFuQ8mrfIzynOPNmUYiJ++3QHACX3N6NICWwAao2dfS0TcOh6xOhvthx73Nw8UanCsQUtrgMO
 p0WQZu8ymCXPNUWjZKTtrKY3fSGnvDDl3h3ooGpM7oAjtM5aIASGbHNudvz8iLqWPNqBhy9xINhZ5
 kS7Fgwi2yAgfSIYffx2rFmalyJaZ/vjmNFuLkbM8cA0ibuCOFendBfsp4B0NhKgAVcBWsMEr1JRvf
 uwNLTnqeHLf0dw2ni/0SHjCKkv1UiGgDw2BpvVkjnu3VwKy8kzAmww+XlUCu9Jac/66y/T2mIM+8R
 vjiexZOglbDO1vl+7Anv0te683ktK298uGqgRFm8xBeqHjh4XdxqRoTbRS5880S03i0JQqvcxmyq0
 8vVITW9K6IGIV0MFvscrRYHqJejIgFwshTQMaUi9fWuwm1lg8Xsh+/E+FqdK4eYHtd+YmjsA0AjUM
 AkwXJlExM7XHzIEA2ZqDBRPXI8DiUywFHlkgEvsKRLk1Kj7Qx7wnqaJHlsQ7YNMxYCBfnyk7kHoDc
 Raa5m6/KrXk5f5zUeuIr1TUrO8xJd/DaamwReW1I6+mKRDIkW6BOuafhLIrAerx6RXP781fIN41uj
 LqG+21/iZUUKCT4wEMwgNI7rS9YQULbKJUDGrtBsWO+etgxrm0BaQTozTIwDzM=;
Message-Id: <0ad7cb925edff3f14bd47fdb7ef3c0b6186960d4.1738860115.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1738860115.git.qemu_oss@crudebyte.com>
References: <cover.1738860115.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 06 Feb 2025 17:41:56 +0100
Subject: [PULL 1/7] 9pfs: improve v9fs_walk() tracing
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>,
    Stefan Hajnoczi <stefanha@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=0ad7cb925edff3f14bd47fdb7ef3c0b6186960d4@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

'Twalk' is the most important request type in the 9p protocol to look out
for when debugging 9p communication. That's because it is the only part
of the 9p protocol which actually deals with human-readable path names,
whereas all other 9p request types work on numeric file IDs (FIDs) only.

Improve tracing of 'Twalk' requests, e.g. let's say client wanted to walk
to "/home/bob/src", then improve trace output from:

  v9fs_walk tag 0 id 110 fid 0 newfid 1 nwnames 3

to:

  v9fs_walk tag=0 id=110 fid=0 newfid=1 nwnames=3 wnames={home, bob, src}

To achieve this, add a new helper function trace_v9fs_walk_wnames() which
converts the received V9fsString array of individual path elements into a
comma-separated string presentation for being passed to the tracing system.
As this conversion is somewhat expensive, this conversion function is only
called if tracing of event 'v9fs_walk' is currently enabled.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <E1tJamT-007Cqk-9E@kylie.crudebyte.com>
---
 hw/9pfs/9p.c         | 36 +++++++++++++++++++++++++++++++-----
 hw/9pfs/trace-events |  2 +-
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 578517739a..6f24c1abb3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1774,6 +1774,21 @@ static bool same_stat_id(const struct stat *a, const struct stat *b)
     return a->st_dev == b->st_dev && a->st_ino == b->st_ino;
 }
 
+/*
+ * Returns a (newly allocated) comma-separated string presentation of the
+ * passed array for logging (tracing) purpose for trace event "v9fs_walk".
+ *
+ * It is caller's responsibility to free the returned string.
+ */
+static char *trace_v9fs_walk_wnames(V9fsString *wnames, size_t nwnames)
+{
+    g_autofree char **arr = g_malloc0_n(nwnames + 1, sizeof(char *));
+    for (size_t i = 0; i < nwnames; ++i) {
+        arr[i] = wnames[i].data;
+    }
+    return g_strjoinv(", ", arr);
+}
+
 static void coroutine_fn v9fs_walk(void *opaque)
 {
     int name_idx, nwalked;
@@ -1787,6 +1802,7 @@ static void coroutine_fn v9fs_walk(void *opaque)
     size_t offset = 7;
     int32_t fid, newfid;
     P9ARRAY_REF(V9fsString) wnames = NULL;
+    g_autofree char *trace_wnames = NULL;
     V9fsFidState *fidp;
     V9fsFidState *newfidp = NULL;
     V9fsPDU *pdu = opaque;
@@ -1800,11 +1816,9 @@ static void coroutine_fn v9fs_walk(void *opaque)
     }
     offset += err;
 
-    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames);
-
     if (nwnames > P9_MAXWELEM) {
         err = -EINVAL;
-        goto out_nofid;
+        goto out_nofid_nownames;
     }
     if (nwnames) {
         P9ARRAY_NEW(V9fsString, wnames, nwnames);
@@ -1814,15 +1828,23 @@ static void coroutine_fn v9fs_walk(void *opaque)
         for (i = 0; i < nwnames; i++) {
             err = pdu_unmarshal(pdu, offset, "s", &wnames[i]);
             if (err < 0) {
-                goto out_nofid;
+                goto out_nofid_nownames;
             }
             if (name_is_illegal(wnames[i].data)) {
                 err = -ENOENT;
-                goto out_nofid;
+                goto out_nofid_nownames;
             }
             offset += err;
         }
+        if (trace_event_get_state_backends(TRACE_V9FS_WALK)) {
+            trace_wnames = trace_v9fs_walk_wnames(wnames, nwnames);
+            trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames,
+                            trace_wnames);
+        }
+    } else {
+        trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "");
     }
+
     fidp = get_fid(pdu, fid);
     if (fidp == NULL) {
         err = -ENOENT;
@@ -1957,7 +1979,11 @@ out:
     }
     v9fs_path_free(&dpath);
     v9fs_path_free(&path);
+    goto out_pdu_complete;
+out_nofid_nownames:
+    trace_v9fs_walk(pdu->tag, pdu->id, fid, newfid, nwnames, "<?>");
 out_nofid:
+out_pdu_complete:
     pdu_complete(pdu, err);
 }
 
diff --git a/hw/9pfs/trace-events b/hw/9pfs/trace-events
index a12e55c165..ed9f4e7209 100644
--- a/hw/9pfs/trace-events
+++ b/hw/9pfs/trace-events
@@ -11,7 +11,7 @@ v9fs_stat(uint16_t tag, uint8_t id, int32_t fid) "tag %d id %d fid %d"
 v9fs_stat_return(uint16_t tag, uint8_t id, int32_t mode, int32_t atime, int32_t mtime, int64_t length) "tag %d id %d stat={mode %d atime %d mtime %d length %"PRId64"}"
 v9fs_getattr(uint16_t tag, uint8_t id, int32_t fid, uint64_t request_mask) "tag %d id %d fid %d request_mask %"PRIu64
 v9fs_getattr_return(uint16_t tag, uint8_t id, uint64_t result_mask, uint32_t mode, uint32_t uid, uint32_t gid) "tag %d id %d getattr={result_mask %"PRId64" mode %u uid %u gid %u}"
-v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames) "tag %d id %d fid %d newfid %d nwnames %d"
+v9fs_walk(uint16_t tag, uint8_t id, int32_t fid, int32_t newfid, uint16_t nwnames, const char* wnames) "tag=%d id=%d fid=%d newfid=%d nwnames=%d wnames={%s}"
 v9fs_walk_return(uint16_t tag, uint8_t id, uint16_t nwnames, void* qids) "tag %d id %d nwnames %d qids %p"
 v9fs_open(uint16_t tag, uint8_t id, int32_t fid, int32_t mode) "tag %d id %d fid %d mode %d"
 v9fs_open_return(uint16_t tag, uint8_t id, uint8_t type, uint32_t version, uint64_t path, int iounit) "tag %u id %u qid={type %u version %u path %"PRIu64"} iounit %d"
-- 
2.30.2


