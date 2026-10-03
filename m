Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03FDCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:27:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbJ-000897-V9; Wed, 07 Oct 2026 05:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <509753f0ac2fb55607a55df7ec761ffaab15b312@kylie.crudebyte.com>)
 id 1xELJk-0002Lf-Su
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:40:16 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <509753f0ac2fb55607a55df7ec761ffaab15b312@kylie.crudebyte.com>)
 id 1xELJX-0004C2-M9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=T5ANrWR5XgQlb4kxxSYmPS4w/awiAnPKvA+hJXMhxXE=; b=OZJnF
 LPRK4Qa4C1kN0y4B/2zJyNIKMugTSulcn1qFuplb6nh8EHKanD6SdvSAIsJUcE2cloaikpM5XxHMt
 4AIuodgsma3rVpleTDe9e8PH6RX18Rq3xcy0xx3o2ax6SF8QQQ+A67C3m+H5yioePHyGvW3m3Vdu3
 XrIP7+/32X7OcG5PDY2ksvGRuue1WNUpQjKBLroC99sc8kKG7wOT54Y8FQKAEE/vsghs5Py6ZQs7K
 a0rXXk5MbBodFfOJwGPcgEGqG3hMc0JoffL2weNj/b9u0yOCuPjlkXG45m+45Nxldn9xgJY5BQv66
 hr7Dzfa4pyoXe70QIFOXf1tW8RFThZARAm4Ng4/hfGU2d1qcemMl4rJAHncEg+rqwIWGPIzTp0zwj
 2j5aS8Qp2viW8tbhLz99wuE7TLbtEanhd1SxxCKc1KG1VHWxOHxKmUzuS/seYamBZqKExEEyRBSI2
 9FAmYeKi3erZw+TMyA/WepDuO8OIKlceWps6E8WxI4JgZDid6gRmw/T4fW6mYT+VISLwS6p79Pjab
 aMzsfbmXb+Wzw3G1nf8ctcLT3uQ/lrrwYB3TnoZNQNUbymMQsmVNjtnOqmiYByBPyBLVa3ljnSoXV
 +dBRnQjuv4F2byADEsvuFKCDnCek4sPTWgN9PlKfpKzg2uap4RoeZGQ4ANjL4c=;
Message-ID: <509753f0ac2fb55607a55df7ec761ffaab15b312.1791291812.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791291812.git.qemu_oss@crudebyte.com>
References: <cover.1791291812.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 3 Oct 2026 19:50:21 +0200
Subject: [PATCH 4/9] tests/9p-client: add Tstat / Rstat test client functions
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=509753f0ac2fb55607a55df7ec761ffaab15b312@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_48_96=1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add v9fs_tstat() and v9fs_rstat() functions to the 9p test client.

Since this is a request type that exists both in legacy 9p2000.u
and modern 9p2000.L protocol version, error responses types might
differ (Rerror vs. Rlerror). Therefore v9fs_tstat() is using an
error type tolerant helper function v9fs_req_check_err() for
processing expected errors with this request type.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 79 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 45 +++++++++++++++
 2 files changed, 124 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 005ae53a3f..4a3fc1511b 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -306,6 +306,33 @@ void v9fs_rlerror(P9Req *req, uint32_t *err)
     v9fs_req_free(req);
 }
 
+/*
+ * Asserts for caller that the request's response returned with the passed,
+ * expected error code (in a protocol version agnostic manner).
+ */
+static void v9fs_req_check_err(P9Req *req, uint32_t expect_err)
+{
+    P9Hdr hdr;
+    uint32_t err;
+
+    /* peek the response header */
+    v9fs_memread(req, &hdr, sizeof(hdr));
+    /* reset offset after peek, so v9fs_rlerror() etc. read correctly */
+    req->r_off = 0;
+
+    if (hdr.id == P9_RLERROR) {
+        v9fs_rlerror(req, &err);
+    } else if (hdr.id == P9_RERROR) {
+        v9fs_rerror(req, &err);
+    } else {
+        g_printerr("Received response %d (%s) instead of an error response\n",
+                   hdr.id, rmessage_name(hdr.id));
+        v9fs_req_free(req);
+        g_assert_not_reached();
+    }
+    g_assert_cmpint(err, ==, expect_err);
+}
+
 /* size[4] Tversion tag[2] msize[4] version[s] */
 TVersionRes v9fs_tversion(TVersionOpt opt)
 {
@@ -1286,3 +1313,55 @@ void v9fs_rxattrwalk(P9Req *req, uint64_t *size)
     }
     v9fs_req_free(req);
 }
+
+/* size[4] Tstat tag[2] fid[4] */
+TStatRes v9fs_tstat(TStatOpt opt)
+{
+    P9Req *req;
+
+    g_assert(opt.client);
+    /* expecting either Rstat or an error response, but obviously not both */
+    g_assert(!opt.expectErr || !opt.rstat.stat);
+
+    req = v9fs_req_init(opt.client, 4, P9_TSTAT, opt.tag);
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_req_send(req);
+
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_req_check_err(req, opt.expectErr);
+        } else {
+            v9fs_rstat(req, opt.rstat.stat);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TStatRes) { .req = req };
+}
+
+/* size[4] Rstat tag[2] stat[n] */
+void v9fs_rstat(P9Req *req, v9fs_stat *stat)
+{
+    v9fs_req_recv(req, P9_RSTAT);
+
+    v9fs_memskip(req, 2); /* protocol quirk: size appears twice */
+    v9fs_uint16_read(req, &stat->size);
+    v9fs_uint16_read(req, &stat->type);
+    v9fs_uint32_read(req, &stat->dev);
+    v9fs_memread(req, &stat->qid, 13);
+    v9fs_uint32_read(req, &stat->mode);
+    v9fs_uint32_read(req, &stat->atime);
+    v9fs_uint32_read(req, &stat->mtime);
+    v9fs_uint64_read(req, &stat->length);
+    v9fs_string_read(req, NULL, &stat->name);
+    v9fs_string_read(req, NULL, &stat->uid);
+    v9fs_string_read(req, NULL, &stat->gid);
+    v9fs_string_read(req, NULL, &stat->muid);
+    v9fs_string_read(req, NULL, &stat->extension);
+    v9fs_uint32_read(req, &stat->n_uid);
+    v9fs_uint32_read(req, &stat->n_gid);
+    v9fs_uint32_read(req, &stat->n_muid);
+
+    v9fs_req_free(req);
+}
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index 5a00a0870c..f604cc0ee5 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -63,6 +63,25 @@ typedef struct v9fs_attr {
     uint64_t data_version;
 } v9fs_attr;
 
+typedef struct v9fs_stat {
+    uint16_t size;
+    uint16_t type;
+    uint32_t dev;
+    v9fs_qid qid;
+    uint32_t mode;
+    uint32_t atime;
+    uint32_t mtime;
+    uint64_t length;
+    char *name;
+    char *uid;
+    char *gid;
+    char *muid;
+    char *extension;
+    uint32_t n_uid;
+    uint32_t n_gid;
+    uint32_t n_muid;
+} v9fs_stat;
+
 #define P9_GETATTR_BASIC    0x000007ffULL /* Mask for fields up to BLOCKS */
 #define P9_GETATTR_ALL      0x00003fffULL /* Mask for ALL fields */
 
@@ -579,6 +598,30 @@ typedef struct TXattrWalkRes {
     uint64_t size;
 } TXattrWalkRes;
 
+/* options for 'Tstat' 9p request */
+typedef struct TStatOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID to get the Rstat for (required) */
+    uint32_t fid;
+    /* data being received from 9p server as 'Rstat' response (optional) */
+    struct {
+        v9fs_stat *stat;
+    } rstat;
+    /* only send Tstat request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an error response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TStatOpt;
+
+/* result of 'Tstat' 9p request */
+typedef struct TStatRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+} TStatRes;
+
 void v9fs_set_allocator(QGuestAllocator *t_alloc);
 void v9fs_memwrite(P9Req *req, const void *addr, size_t len);
 void v9fs_memskip(P9Req *req, size_t len);
@@ -639,5 +682,7 @@ TXattrCreateRes v9fs_txattrcreate(TXattrCreateOpt opt);
 void v9fs_rxattrcreate(P9Req *req);
 TXattrWalkRes v9fs_txattrwalk(TXattrWalkOpt opt);
 void v9fs_rxattrwalk(P9Req *req, uint64_t *size);
+TStatRes v9fs_tstat(TStatOpt opt);
+void v9fs_rstat(P9Req *req, v9fs_stat *stat);
 
 #endif
-- 
2.47.3


