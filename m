Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EE2CD8C92
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:59:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmU-0000Ne-2q; Sun, 07 Jun 2026 13:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <20720aa8a3d90233314e26966c480fdcc17409ce@kylie.crudebyte.com>)
 id 1wWHmS-0000NK-8W; Sun, 07 Jun 2026 13:59:28 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <20720aa8a3d90233314e26966c480fdcc17409ce@kylie.crudebyte.com>)
 id 1wWHmQ-0004Mo-IQ; Sun, 07 Jun 2026 13:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=+Pb1E062e+vdMI39HgiCkAtZTwKmpyquagDGi2YMRJw=; b=mOGpV
 UGIOQV7y2elbfFMGLPgBi5zRzO9MVKVqoJGwyeEopFzOWICoq/dpy2pVi5RF4frIscRTi0MP+1wsY
 QlFe91q/0FmIMujIeiD6LvIaM9FYsp6o7d+4vsNS8GX3tYbFgSCZbuOG7YuIQ1F0tFa4wi4SSQ7Db
 JA69IUPzZGMpWt452yd3wwKbJqzbM4POr1YkHSOKXhcyKNjhCY+AzmZVovGVxIQiWY4r/m4MVFHZj
 pXJ9hm3/YVu6Eo/bQwUiGgrIYJaW8wlw74H2np5qLQNsfnPzR3DxM41jX+oATVYbzXLtPZcFqp0Gc
 ufkJYovKFOl7K8KcIlUIhe903lkarEUVYltypeqnYXde8iH4rmF7NXBIC33XGwAjFFL/x3xPNRT6b
 1kcaIEmjfMpN/sVs5//32TZXtobcQ/E5CCAm8L5wzwQiUHFVdUXfl5JbTy1jDfAZdoMCaKsiYXi2m
 nJlk0YDfMyon07UeIaKR1oPReZ33GAmP6jYjs0IyYCNd2ZT6cDUd4ugFZ8R3jjZIvN7f7lMEh4QO1
 afs7FILZA9nbVDVeyJ2/ypMAaEbO8/MTB6C5/soOAad7GjGEP3lQEgZeYq40bfhLoAHuZP9nShrrT
 8gwJ+3QproqwlLlgDtRhjWtCJQLB6YfKeheemOGfl+LxJhauvFMcAQFBNo4oMI=;
Message-ID: <20720aa8a3d90233314e26966c480fdcc17409ce.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 04/12] tests/9p: add Tread / Rread test client functions
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=20720aa8a3d90233314e26966c480fdcc17409ce@kylie.crudebyte.com;
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

Add v9fs_tread() and v9fs_rread() functions to the 9P test client
for reading files from 9pfs server in test cases.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 45 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 33 ++++++++++++++++++++
 tests/qtest/virtio-9p-test.c          |  1 +
 3 files changed, 79 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index af01d4c345..b9785ef8cb 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -241,6 +241,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "RREADDIR" :
+        id == P9_RREAD ? "RREAD" :
         "<unknown>";
 }
 
@@ -1103,3 +1104,47 @@ void v9fs_runlinkat(P9Req *req)
     v9fs_req_recv(req, P9_RUNLINKAT);
     v9fs_req_free(req);
 }
+
+/* size[4] Tread tag[2] fid[4] offset[8] count[4] */
+TReadRes v9fs_tread(TReadOpt opt)
+{
+    P9Req *req;
+    uint32_t err;
+
+    g_assert(opt.client);
+
+    uint32_t body_size = 4 + 8 + 4;
+
+    req = v9fs_req_init(opt.client, body_size, P9_TREAD, opt.tag);
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_uint64_write(req, opt.offset);
+    v9fs_uint32_write(req, opt.count);
+    v9fs_req_send(req);
+
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_rlerror(req, &err);
+            g_assert_cmpint(err, ==, opt.expectErr);
+        } else {
+            v9fs_rread(req, opt.rread.count, opt.rread.data);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TReadRes) {
+        .req = req,
+        .count = opt.rread.count ? *opt.rread.count : 0
+    };
+}
+
+/* size[4] Rread tag[2] count[4] data[count] */
+void v9fs_rread(P9Req *req, uint32_t *count, void *data)
+{
+    v9fs_req_recv(req, P9_RREAD);
+    v9fs_uint32_read(req, count);
+    if (data && *count > 0) {
+        v9fs_memread(req, data, *count);
+    }
+    v9fs_req_free(req);
+}
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index e3221a3104..37f2517cff 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -473,6 +473,37 @@ typedef struct TunlinkatRes {
     P9Req *req;
 } TunlinkatRes;
 
+/* options for 'Tread' 9p request */
+typedef struct TReadOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID of file to read from (required) */
+    uint32_t fid;
+    /* start position of read from beginning of file (optional) */
+    uint64_t offset;
+    /* how many bytes to read (required) */
+    uint32_t count;
+    /* data being received from 9p server as 'Rread' response (optional) */
+    struct {
+        uint32_t *count;
+        void *data;
+    } rread;
+    /* only send Tread request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an Rlerror response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TReadOpt;
+
+/* result of 'Tread' 9p request */
+typedef struct TReadRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+    /* amount of bytes read */
+    uint32_t count;
+} TReadRes;
+
 void v9fs_set_allocator(QGuestAllocator *t_alloc);
 void v9fs_memwrite(P9Req *req, const void *addr, size_t len);
 void v9fs_memskip(P9Req *req, size_t len);
@@ -524,5 +555,7 @@ TlinkRes v9fs_tlink(TlinkOpt);
 void v9fs_rlink(P9Req *req);
 TunlinkatRes v9fs_tunlinkat(TunlinkatOpt);
 void v9fs_runlinkat(P9Req *req);
+TReadRes v9fs_tread(TReadOpt opt);
+void v9fs_rread(P9Req *req, uint32_t *count, void *data);
 
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 1c69d41e33..8ccec77e70 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -31,6 +31,7 @@
 #define tsymlink(...) v9fs_tsymlink((TsymlinkOpt) __VA_ARGS__)
 #define tlink(...) v9fs_tlink((TlinkOpt) __VA_ARGS__)
 #define tunlinkat(...) v9fs_tunlinkat((TunlinkatOpt) __VA_ARGS__)
+#define tread(...) v9fs_tread((TReadOpt) __VA_ARGS__)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


