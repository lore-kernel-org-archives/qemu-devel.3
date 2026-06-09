Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07FBCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxP6-0002as-4i; Tue, 09 Jun 2026 10:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7ccb2b891c1afdfe38eeed8addd1e24713c2c8ae@kylie.crudebyte.com>)
 id 1wWxOu-0002YH-KW; Tue, 09 Jun 2026 10:25:58 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <7ccb2b891c1afdfe38eeed8addd1e24713c2c8ae@kylie.crudebyte.com>)
 id 1wWxOq-0001Jd-Ov; Tue, 09 Jun 2026 10:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=BUH244s3Gt7moinlYKDoR8pCKz0Kbx4PwxJ54VEws+w=; b=aMHb6
 r0qJSzQxrhiFSuuh2TzeFDTolqDHsCAgJwuqH/vpBOXihRSflDAkvHtsLCV323C366bb9Vq0HpyN6
 kYpzy4BXQZ5WhSs/FX3q2swE6zjyyxuCdag3jGK7AwoXwUpUl0S6t69EMHvIheRTicTqi6S8o4JLW
 LwUOkkS5hXf3xx0ljvdwfcmq98Mar/UmssmwXphXQI1N9tP9UiJ2LIwNI2dtUGV4r04aH+AbvMbEf
 0wPaXJK5z3U488x37s0E5bJ/V8Sqf5Ld373gpYv1lFNE5M4BvhcDZGtl9p7YZo7GLaB50g41QdtCT
 PUUFoJ/xKlVjpGPrwzAKUcuBjbIcFw0uZQ8pe1KgeP7W8GnS7sfVQmTUBn+wdP9c9pcUrESqaywkw
 C4YTRVYVrkuXQfvDXMhmVzUndyu+HD5mokz4PUA+McCPYoaeodenNLZfbo0nZtWUUMscHkIa8C6eN
 a1PPQV2+0/K6FWZa+kxIauO86/8xdNecZtBsUCwlsmf8lbeMTlWXLhdy32AtDeYzF4Iyzaz1ep4kl
 lHz+tnIe65XH8kRbwJ+KPptwJzv0M+HeqGOMLOO6kL82mglecRpmBm4OoA0mj9aQclmYJdy+dipTC
 rt3MskwJcmoTYxBO+Y94QF/9tzfpqMsNcO8JwgqcJ54APULZ83k/XP22TRCexo=;
Message-ID: <7ccb2b891c1afdfe38eeed8addd1e24713c2c8ae.1781012549.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 09 Jun 2026 15:47:06 +0200
Subject: [PATCH v2 06/12] tests/9p: add Txattrcreate / Rxattrcreate test
 client functions
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=7ccb2b891c1afdfe38eeed8addd1e24713c2c8ae@kylie.crudebyte.com;
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


