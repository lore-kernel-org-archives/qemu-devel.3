Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147A1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCDH-0005um-6n; Mon, 29 Jun 2026 09:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54b8f64c422d0ed6d992387f0de419420cdb9fea@kylie.crudebyte.com>)
 id 1weCDE-0005tO-6A; Mon, 29 Jun 2026 09:39:48 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <54b8f64c422d0ed6d992387f0de419420cdb9fea@kylie.crudebyte.com>)
 id 1weCDC-0004Vt-8R; Mon, 29 Jun 2026 09:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=bahZBcXVLOQmQeZVYzUyGC3qGp5fyPz+QA3ZZ0QrvZs=; b=fyPp5
 LZxIt1jZpXd1hHSuEX+Zjsrk6k2SomFP2NCHcSaRm0aavkMBp9N6+98vZrMuxfNiNKW/v8pCVjdYF
 6T0KUFJYXyz7Dnnx9HoFjXGpAM6IM+wQLRN3KnJ80igI47EHfz4UAK+vffNvhC6BTifjj+Ym8H7tu
 yY6MIrNgbGc8twGSPFTRDDdfSNGMA4otWXXlXSzkogmO+WR+aBIM/hvkZY8bLPk+f/g5f2PNCbRiM
 alLEBxm6noNg70bgNfm41QnN09ZAviMkwvGYQBmuOqp1EWh88SgpiT/7/rSkDxA1rxq9CAPOB5VSd
 RIsgor9iYc83NcyGOOXpAzX3p7usi1cEoIZ0sa5lq/YcEhT/WDPgDH557acjRCnEIXbYZVtFGOSJn
 ouPoKMEn23S6gqpdTdqyGNHssoOiKMfTo3hyjtmg5jhgpz0J5wvfkHcJEb1/18ColXplEtxKe2Dvj
 lV5YEdKoGoZBDkUO/nF/Psh/LSwUqKnpgJo0/J69IOSha6tOVUPnJY2+YCrlMUXpqM8RuCa4IXdKR
 qF7tBgI0BYfSy9i0MZKWfoeq56vZJCTMABgxvainYPlVyYNZz9tPI/ye5sG9YztVCe2d1573Z3toT
 a6Q96Nv90Zf5HFXd1EGVpxj+kRoh9j98Ot9/A2O0VZ9BvDaO32doWZUyE3qCHQ=;
Message-ID: <54b8f64c422d0ed6d992387f0de419420cdb9fea.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 12/23] tests/9p: add Tread / Rread test client functions
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=54b8f64c422d0ed6d992387f0de419420cdb9fea@kylie.crudebyte.com;
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

Link: https://lore.kernel.org/qemu-devel/049bdd1e66416f5200fb3d59d2da5e8ec149926d.1781361555.git.qemu_oss@crudebyte.com
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


