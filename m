Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883C0C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wildU-0003jj-2K; Sun, 12 Jul 2026 00:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildR-0003Zt-25; Sun, 12 Jul 2026 00:17:45 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildM-0006SM-L2; Sun, 12 Jul 2026 00:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=9XS6VxmUhp4MZETHCgVw/1/lM/LF2wYYMaFTXjAttnU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L72WX1ARjTpBLqigiK6dAH1qmOLNrrUiWVUZtoTUAsOZuYfX2XkfzHgg+GNWPWTxS
 7j1pL59nOMp4LUiWRGGE1eMkjMBWgKOGVk+A613VU5PrY+2aZR9op8Yj+3ZHgiZaTc
 w4wb2KAod0Qrnb+tlpLimvEjpq9BjtqD9zSnDSrnqhIPCqCmA1SGv8vIeOnnGIgvy0
 TfyntRUR62p93oBgrUYzWu8mlooJd4q5wo1CVgX7Fd/YtOmn4AtXmONANHJ4tWHVue
 4X1GoekVac6JYdDGK5fISjKXHOT7BY8m1iMOpypvlVlFH+5X9B0bGQhHroGJRgJpOs
 2x1p0Rfl7RDZw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 153421C0BED;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 493253EB94D;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3F2C4133DD; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 18/75] tests/9p: add Txattrcreate / Rxattrcreate test
 client functions
Date: Sun, 12 Jul 2026 07:14:36 +0300
Message-ID: <20260712041539.108341-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add v9fs_txattrcreate() and v9fs_rxattrcreate() functions to the
9P test client for testing creation of xattrs with 9pfs server.

Link: https://lore.kernel.org/qemu-devel/5dbc5061dab1f7829fffc40bf89d7ff443e4bcab.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 7664feb26fef19caa4d72e07a9097fa625b593e5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index bfc11c9c347..105e3bbf610 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -242,6 +242,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RREADDIR ? "RREADDIR" :
         id == P9_RREAD ? "RREAD" :
         id == P9_RCLUNK ? "RCLUNK" :
+        id == P9_RXATTRCREATE ? "RXATTRCREATE" :
         "<unknown>";
 }
 
@@ -1132,3 +1133,47 @@ void v9fs_rclunk(P9Req *req)
     v9fs_req_recv(req, P9_RCLUNK);
     v9fs_req_free(req);
 }
+
+/* size[4] Txattrcreate tag[2] fid[4] name[s] attr_size[8] flags[4] */
+TXattrCreateRes v9fs_txattrcreate(TXattrCreateOpt opt)
+{
+    P9Req *req;
+    uint32_t err;
+
+    g_assert(opt.client);
+    g_assert(opt.name);
+
+    uint32_t body_size = 4 + 8 + 4;
+    uint16_t string_size = v9fs_string_size(opt.name);
+
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(opt.client, body_size, P9_TXATTRCREATE, opt.tag);
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_string_write(req, opt.name);
+    v9fs_uint64_write(req, opt.size);
+    v9fs_uint32_write(req, opt.flags);
+    v9fs_req_send(req);
+
+    err = 0;
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_rlerror(req, &err);
+            g_assert_cmpint(err, ==, opt.expectErr);
+        } else {
+            v9fs_rxattrcreate(req);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TXattrCreateRes) { .req = req, .err = err };
+}
+
+/* size[4] Rxattrcreate tag[2] */
+void v9fs_rxattrcreate(P9Req *req)
+{
+    v9fs_req_recv(req, P9_RXATTRCREATE);
+    v9fs_req_free(req);
+}
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index 2b40dce8c0f..aa7276d2c3a 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -492,6 +492,34 @@ typedef struct TClunkRes {
     P9Req *req;
 } TClunkRes;
 
+/* options for 'Txattrcreate' 9p request */
+typedef struct TXattrCreateOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID to convert to xattr fid (required) */
+    uint32_t fid;
+    /* name of the xattr (required) */
+    const char *name;
+    /* size of the xattr value (required) */
+    uint64_t size;
+    /* flags: P9_XATTR_CREATE or P9_XATTR_REPLACE (optional) */
+    uint32_t flags;
+    /* only send Txattrcreate request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an Rlerror response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TXattrCreateOpt;
+
+/* result of 'Txattrcreate' 9p request */
+typedef struct TXattrCreateRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+    /* error code if Rlerror received */
+    uint32_t err;
+} TXattrCreateRes;
+
 void v9fs_set_allocator(QGuestAllocator *t_alloc);
 void v9fs_memwrite(P9Req *req, const void *addr, size_t len);
 void v9fs_memskip(P9Req *req, size_t len);
@@ -545,5 +573,7 @@ TReadRes v9fs_tread(TReadOpt opt);
 void v9fs_rread(P9Req *req, uint32_t *count, void *data);
 TClunkRes v9fs_tclunk(TClunkOpt opt);
 void v9fs_rclunk(P9Req *req);
+TXattrCreateRes v9fs_txattrcreate(TXattrCreateOpt opt);
+void v9fs_rxattrcreate(P9Req *req);
 
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index c6d6bed80cf..e383f8e4549 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -32,6 +32,7 @@
 #define tunlinkat(...) v9fs_tunlinkat((TunlinkatOpt) __VA_ARGS__)
 #define tread(...) v9fs_tread((TReadOpt) __VA_ARGS__)
 #define tclunk(...) v9fs_tclunk((TClunkOpt) __VA_ARGS__)
+#define txattrcreate(...) v9fs_txattrcreate((TXattrCreateOpt) __VA_ARGS__)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


