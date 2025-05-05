Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCED3C3ABB0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBsXA-00038d-9J; Mon, 05 May 2025 05:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4719a2d59176a6c850e2b4f1af44cecd25430fce@kylie.crudebyte.com>)
 id 1uBsX7-00030L-5m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <4719a2d59176a6c850e2b4f1af44cecd25430fce@kylie.crudebyte.com>)
 id 1uBsX5-0005Hs-9N
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=fBu2ksFPOv5qG79kmGMboUHwg9Rt0hh/y2JUq6uOd94=; b=KplKb
 K4FlZfxAuuRJ809D1eu7fm58j8W+VuyRnTV1U1mo5F1jQO/i6yh5IFNazN0QXQl+ssn328lbjlj6d
 WHtIdobcV7XmQbu1awfxPFgqu7uArpJ3dmxUXdrF9NiqBGE7IjMXcGqwC+IxlQlYMfZUlS96F2MDU
 tFbdCMgKTxpxRyNiowPDn3xxG3Ay+8/GKToDB6YWasSVasBEs2FypAe2utDrLXR9e8upNA+4Ae4mq
 3Wze3sWJ2xtqhuTkbNeuDQMqHI+/PXuwf6yJ33THLpePnkXLAWSjU237iNwqoLYEKwq8Hv2VL2Grf
 n4VUObgtv0c+rKmRRYt+VXowDTk8h6HST6iGfL1Ger6CyCOqx8yd7obtCNsCPmGo+ulEJQH06wLA2
 Wz/wk8CPXe5519ykpHusNRokBSr9VU6zfx4XAG7yjkd1lDdjJuS+ZAJ2pklI8hHFquKNUvB0sV47k
 20cFFjb1J5vLaIyd/Nyf0nV/As4dJH+DZQ3HOcLdWMlTXQCT7Ww8zXqDOKoJpwG2ljK5PImKOHxeU
 n8nct9KW4up/l+/IAHA9PZAmhv9yiZsyHK6EkGEuTuQnfy5NRrASzifloFgmyK0P9b0x7cYg8HplQ
 YiKjIuWw7nvJNc5D9XbuDeB9uiNBxpPzHE42koAx92aKuJ/YW7QBo5m5XKSayo=;
Message-Id: <4719a2d59176a6c850e2b4f1af44cecd25430fce.1746438650.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1746438650.git.qemu_oss@crudebyte.com>
References: <cover.1746438650.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 05 May 2025 11:50:51 +0200
Subject: [PULL 7/9] tests/9p: add 'Tsetattr' request to test client
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=4719a2d59176a6c850e2b4f1af44cecd25430fce@kylie.crudebyte.com;
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

Add and implement functions to 9pfs test client for sending a 9p2000.L
'Tsetattr' request and receiving its 'Rsetattr' response counterpart.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <20250312152933.383967-6-groug@kaod.org>
---
 tests/qtest/libqos/virtio-9p-client.c | 49 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 34 +++++++++++++++++++
 tests/qtest/virtio-9p-test.c          |  1 +
 3 files changed, 84 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 98b77db51d..6ab4501c6e 100644
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
index 78228eb97d..e3221a3104 100644
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
index ab3a12c816..f515a9bb15 100644
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
2.30.2


