Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922DCC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 17:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts3PP-00018R-6Y; Tue, 11 Mar 2025 13:28:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3PK-00017z-NL
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:46 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1ts3P8-0004xg-H8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 13:28:46 -0400
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-R7s61xpWMJ6utYL89YD-QA-1; Tue,
 11 Mar 2025 13:28:31 -0400
X-MC-Unique: R7s61xpWMJ6utYL89YD-QA-1
X-Mimecast-MFC-AGG-ID: R7s61xpWMJ6utYL89YD-QA_1741714110
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E64F19560A3; Tue, 11 Mar 2025 17:28:30 +0000 (UTC)
Received: from bahia.redhat.com (unknown [10.44.32.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 236031955BCB; Tue, 11 Mar 2025 17:28:26 +0000 (UTC)
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Greg Kurz <groug@kaod.org>
Subject: [PATCH v2 5/6] tests/9p: add 'Tsetattr' request to test client
Date: Tue, 11 Mar 2025 18:28:08 +0100
Message-ID: <20250311172809.250913-6-groug@kaod.org>
In-Reply-To: <20250311172809.250913-1-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: softfail client-ip=207.211.30.44; envelope-from=groug@kaod.org;
 helo=us-smtp-delivery-44.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add and implement functions to 9pfs test client for sending a 9p2000.L
'Tsetattr' request and receiving its 'Rsetattr' response counterpart.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
 tests/qtest/virtio-9p-test.c          |  1 +
 3 files changed, 84 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 98b77db51d77..6ab4501c6e1a 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -557,6 +557,55 @@ void v9fs_rgetattr(P9Req *req, v9fs_attr *attr)
     v9fs_req_free(req);
 }
 
+/*
+ * size[4] Tsetattr tag[2] fid[4] valid[4] mode[4] uid[4] gid[4] size[8]
+ *                  atime_sec[8] atime_nsec[8] mtime_sec[8] mtime_nsec[8]
+ */
+TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt)
+{
+    P9Req *req;
+    uint32_t err;
+
+    g_assert(opt.client);
+
+    req = v9fs_req_init(
+        opt.client, 4/*fid*/ + 4/*valid*/ + 4/*mode*/ + 4/*uid*/ + 4/*gid*/ +
+        8/*size*/ + 8/*atime_sec*/ + 8/*atime_nsec*/ + 8/*mtime_sec*/ +
+        8/*mtime_nsec*/, P9_TSETATTR, opt.tag
+    );
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_uint32_write(req, (uint32_t) opt.attr.valid);
+    v9fs_uint32_write(req, opt.attr.mode);
+    v9fs_uint32_write(req, opt.attr.uid);
+    v9fs_uint32_write(req, opt.attr.gid);
+    v9fs_uint64_write(req, opt.attr.size);
+    v9fs_uint64_write(req, opt.attr.atime_sec);
+    v9fs_uint64_write(req, opt.attr.atime_nsec);
+    v9fs_uint64_write(req, opt.attr.mtime_sec);
+    v9fs_uint64_write(req, opt.attr.mtime_nsec);
+    v9fs_req_send(req);
+
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_rlerror(req, &err);
+            g_assert_cmpint(err, ==, opt.expectErr);
+        } else {
+            v9fs_rsetattr(req);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TSetAttrRes) { .req = req };
+}
+
+/* size[4] Rsetattr tag[2] */
+void v9fs_rsetattr(P9Req *req)
+{
+    v9fs_req_recv(req, P9_RSETATTR);
+    v9fs_req_free(req);
+}
+
 /* size[4] Treaddir tag[2] fid[4] offset[8] count[4] */
 TReadDirRes v9fs_treaddir(TReadDirOpt opt)
 {
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index 78228eb97d9e..e3221a310412 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -65,6 +65,16 @@ typedef struct v9fs_attr {
 #define P9_GETATTR_BASIC    0x000007ffULL /* Mask for fields up to BLOCKS */
 #define P9_GETATTR_ALL      0x00003fffULL /* Mask for ALL fields */
 
+#define P9_SETATTR_MODE         0x00000001UL
+#define P9_SETATTR_UID          0x00000002UL
+#define P9_SETATTR_GID          0x00000004UL
+#define P9_SETATTR_SIZE         0x00000008UL
+#define P9_SETATTR_ATIME        0x00000010UL
+#define P9_SETATTR_MTIME        0x00000020UL
+#define P9_SETATTR_CTIME        0x00000040UL
+#define P9_SETATTR_ATIME_SET    0x00000080UL
+#define P9_SETATTR_MTIME_SET    0x00000100UL
+
 struct V9fsDirent {
     v9fs_qid qid;
     uint64_t offset;
@@ -182,6 +192,28 @@ typedef struct TGetAttrRes {
     P9Req *req;
 } TGetAttrRes;
 
+/* options for 'Tsetattr' 9p request */
+typedef struct TSetAttrOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID of file/dir whose attributes shall be modified (required) */
+    uint32_t fid;
+    /* new attribute values to be set by 9p server */
+    v9fs_attr attr;
+    /* only send Tsetattr request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an Rlerror response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TSetAttrOpt;
+
+/* result of 'Tsetattr' 9p request */
+typedef struct TSetAttrRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+} TSetAttrRes;
+
 /* options for 'Treaddir' 9p request */
 typedef struct TReadDirOpt {
     /* 9P client being used (mandatory) */
@@ -470,6 +502,8 @@ TWalkRes v9fs_twalk(TWalkOpt opt);
 void v9fs_rwalk(P9Req *req, uint16_t *nwqid, v9fs_qid **wqid);
 TGetAttrRes v9fs_tgetattr(TGetAttrOpt);
 void v9fs_rgetattr(P9Req *req, v9fs_attr *attr);
+TSetAttrRes v9fs_tsetattr(TSetAttrOpt opt);
+void v9fs_rsetattr(P9Req *req);
 TReadDirRes v9fs_treaddir(TReadDirOpt);
 void v9fs_rreaddir(P9Req *req, uint32_t *count, uint32_t *nentries,
                    struct V9fsDirent **entries);
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index ab3a12c816d4..f515a9bb157b 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -20,6 +20,7 @@
 #define tversion(...) v9fs_tversion((TVersionOpt) __VA_ARGS__)
 #define tattach(...) v9fs_tattach((TAttachOpt) __VA_ARGS__)
 #define tgetattr(...) v9fs_tgetattr((TGetAttrOpt) __VA_ARGS__)
+#define tsetattr(...) v9fs_tsetattr((TSetAttrOpt) __VA_ARGS__)
 #define treaddir(...) v9fs_treaddir((TReadDirOpt) __VA_ARGS__)
 #define tlopen(...) v9fs_tlopen((TLOpenOpt) __VA_ARGS__)
 #define twrite(...) v9fs_twrite((TWriteOpt) __VA_ARGS__)
-- 
2.48.1


