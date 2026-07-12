Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8A25C44506
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wild3-000341-Ke; Sun, 12 Jul 2026 00:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wild1-0002tj-4u; Sun, 12 Jul 2026 00:17:19 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcz-0006Re-AO; Sun, 12 Jul 2026 00:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=Khjy8c154DF+/mev2cp945KvRTfUKn0Bm6J5UfJfPfE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ne43Szd1Lzm5jT1VAllmuY5zAlzF+5v9ec3OzQGPuUD6R2yUhFDEwDWJLOWz5xH85
 Yw4v/h49mulpO/UMyE1YmGzLpQkZcjxK7BQyZhWmQwggullYMF/UxiY7aV44NIJict
 rTQ46mRDxMiTKeIS58UWbT2dH4ix9RnCXbd941YPeRcqIoCSWBwTTwEV/y+e8h9udD
 kgqyCttkB2Q5THrvV1L9RHrzSeCULLBYGMu6lu7yo3p471vzCzcNzgagxD9Cp7pKTC
 e3UcolCZ8SeJdX0gAdq76NX0dpAnp4N+MOZ5YlcuL33RQcdwDUAMzfhHmbpWhn8Fd3
 y/hdSRj6XwOdQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0905E1C0BEB;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3C0113EB94B;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3A8EB133D9; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 16/75] tests/9p: add Tread / Rread test client
 functions
Date: Sun, 12 Jul 2026 07:14:34 +0300
Message-ID: <20260712041539.108341-16-mjt@tls.msk.ru>
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

Add v9fs_tread() and v9fs_rread() functions to the 9P test client
for reading files from 9pfs server in test cases.

Link: https://lore.kernel.org/qemu-devel/049bdd1e66416f5200fb3d59d2da5e8ec149926d.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 54b8f64c422d0ed6d992387f0de419420cdb9fea)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 98b77db51d7..3493b46b71c 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -240,6 +240,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RUNLINKAT ? "RUNLINKAT" :
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "RREADDIR" :
+        id == P9_RREAD ? "RREAD" :
         "<unknown>";
 }
 
@@ -1053,3 +1054,47 @@ void v9fs_runlinkat(P9Req *req)
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
index 78228eb97d9..8067dcb0990 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -441,6 +441,37 @@ typedef struct TunlinkatRes {
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
@@ -490,5 +521,7 @@ TlinkRes v9fs_tlink(TlinkOpt);
 void v9fs_rlink(P9Req *req);
 TunlinkatRes v9fs_tunlinkat(TunlinkatOpt);
 void v9fs_runlinkat(P9Req *req);
+TReadRes v9fs_tread(TReadOpt opt);
+void v9fs_rread(P9Req *req, uint32_t *count, void *data);
 
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 1af02e9c7bb..a3f35d49426 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -30,6 +30,7 @@
 #define tsymlink(...) v9fs_tsymlink((TsymlinkOpt) __VA_ARGS__)
 #define tlink(...) v9fs_tlink((TlinkOpt) __VA_ARGS__)
 #define tunlinkat(...) v9fs_tunlinkat((TunlinkatOpt) __VA_ARGS__)
+#define tread(...) v9fs_tread((TReadOpt) __VA_ARGS__)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


