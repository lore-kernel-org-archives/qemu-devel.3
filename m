Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94FACD8C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:00:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmQ-0000Mu-2g; Sun, 07 Jun 2026 13:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a7139564d7fb7fdeb9f391a9a40155d09a3f16cc@kylie.crudebyte.com>)
 id 1wWHmO-0000MU-Ud; Sun, 07 Jun 2026 13:59:24 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <a7139564d7fb7fdeb9f391a9a40155d09a3f16cc@kylie.crudebyte.com>)
 id 1wWHmN-0004MT-A4; Sun, 07 Jun 2026 13:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=BUH244s3Gt7moinlYKDoR8pCKz0Kbx4PwxJ54VEws+w=; b=G5z2G
 uXd39ohCPe4GeM18uAF43d7pWbpSWlll5gKYepMKuYCEd8pPq7hZSSLm11KX0hCrIzg7wU7XQd0EP
 ROGuIkm+L87rusKqft6OsnceuFL3CtyZSl9C9oqxxSXw9j8dYboetghZcM5N704FDS2Bs9k2Qg+Gp
 ejjVa81947ABtW93obtLSAGsseQlABDHqUidK7KJMd3xTd+r/jblt3HLki9NS2K6zSxpw79XpW8QQ
 OCEuK67jTDU4MnRPvTM1lr0bYWNlwAjprMmM9FwiPPGhj9ztSYGLvLUhIVcs1tw0vdbg+mYAIsXur
 HwgGojnBD7FvXFeY3M+CfXDOFvt7ns+T/BxoJam9awr2iybElOoMwU0Jfc2ExvJC7aeOgBN8u04Wk
 PwXRdZMxg3iGza1xQx5qraWk/HL7a68mluoMnbSB5YTgKx5VQYyZ6bGOT1f6gSg5SexeppaNrNJ1t
 a42ULY/P7hu5UWfCA85+TkqsgeQLJ6m/sFChOpSnwM16tf2iR4ovE8yXe1BCFyJADNRF/hT0aokxi
 EDB9g3Y1mIrippGY947pbUsCv7t/z7kkE/pdOmg4DbDJ2LyQQJ4b6smRyvDNAkusWHCueMlaClXLI
 BYgviF0tBo4tuO77Npj8JLoCEzBPbpM0Fu83qGK0ZqDCb6q8N0IUeaZlL7Mzqs=;
Message-ID: <a7139564d7fb7fdeb9f391a9a40155d09a3f16cc.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 06/12] tests/9p: add Txattrcreate / Rxattrcreate test client
 functions
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=a7139564d7fb7fdeb9f391a9a40155d09a3f16cc@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add v9fs_txattrcreate() and v9fs_rxattrcreate() functions to the
9P test client for testing creation of xattrs with 9pfs server.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 45 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 30 ++++++++++++++++++
 tests/qtest/virtio-9p-test.c          |  1 +
 3 files changed, 76 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 83af6dab5d..305b0dac63 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -243,6 +243,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RREADDIR ? "RREADDIR" :
         id == P9_RREAD ? "RREAD" :
         id == P9_RCLUNK ? "RCLUNK" :
+        id == P9_RXATTRCREATE ? "RXATTRCREATE" :
         "<unknown>";
 }
 
@@ -1182,3 +1183,47 @@ void v9fs_rclunk(P9Req *req)
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
index f7ef7f0067..c432b0daee 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -524,6 +524,34 @@ typedef struct TClunkRes {
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
@@ -579,5 +607,7 @@ TReadRes v9fs_tread(TReadOpt opt);
 void v9fs_rread(P9Req *req, uint32_t *count, void *data);
 TClunkRes v9fs_tclunk(TClunkOpt opt);
 void v9fs_rclunk(P9Req *req);
+TXattrCreateRes v9fs_txattrcreate(TXattrCreateOpt opt);
+void v9fs_rxattrcreate(P9Req *req);
 
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 099c5e0ca0..99a897b158 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -33,6 +33,7 @@
 #define tunlinkat(...) v9fs_tunlinkat((TunlinkatOpt) __VA_ARGS__)
 #define tread(...) v9fs_tread((TReadOpt) __VA_ARGS__)
 #define tclunk(...) v9fs_tclunk((TClunkOpt) __VA_ARGS__)
+#define txattrcreate(...) v9fs_txattrcreate((TXattrCreateOpt) __VA_ARGS__)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


