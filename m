Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4272C44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifkx-0003rq-Ae; Sat, 11 Jul 2026 18:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifku-0003jl-RE; Sat, 11 Jul 2026 18:01:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifkt-0008Bm-0j; Sat, 11 Jul 2026 18:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=9UdAnkZwEqHrYu4VUtdYR8CUvmU8vYUaplzEWlVnJMU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=onYuOlpPmmGOD9r/V5Qa0YTZTiegnFXycc33PIYqW7XfGhflAZIvX9FgYGBT8RttQ
 o7roEQeMQbRIA77tN+ql30C7/1vBMNRVXOtSH7vCMD2xctl53rL6hhCoAragbxr+ze
 ZKxdpPd/Hjhlay+KV1Z9ElfKmxn7823h/bMpDtlL8cpSpd+Txw3942uyT3hJf8KN22
 4MHQJOuoKx3IQZPPVKciInybj5MjwOF9M8cFUP1drQ24wRi8cqQDwD9VryEjNn0oVT
 mnnz/6bioHWLJZ6tza5s5Gtb5NFSe+vOe55SWh6CPQAcMtV53tRTf1t2J+ZaCH96Df
 gFg8sev9Xclag==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D9031C0A9C;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2258E3EAF27;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5DEE913305; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 17/81] tests/9p: add Txattrcreate / Rxattrcreate test
 client functions
Date: Sun, 12 Jul 2026 00:57:55 +0300
Message-ID: <20260711215904.3757-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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
index 83af6dab5d1..305b0dac63a 100644
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
index f7ef7f00679..c432b0daee4 100644
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
index 099c5e0ca05..99a897b1585 100644
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


