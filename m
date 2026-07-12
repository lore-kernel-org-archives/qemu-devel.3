Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BB1C44507
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wildU-0003pH-LQ; Sun, 12 Jul 2026 00:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildQ-0003Xe-Mp; Sun, 12 Jul 2026 00:17:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildM-0006SF-L2; Sun, 12 Jul 2026 00:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=WGTkRAj5cySGX4FAmqNWOy5T4WGwmvhPcjO9mhMd8HU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vULvLyjI0UFz4jWVKlzLnl0C4A6qzbjqTwf/lkPKIZpyVMe53rnjo0VVxqs4ffJji
 JNJ3UgeMHWwNuNT8kvcwqNNX7QlYcjFeU9WRHKmDjj4qgyBbOZRwevlshfSKzRUHxU
 CrlAvKLK7JrmVyKL3jK90Q/J9YWQrk1I47gjGj2hLSNP6yC19TcxK2UD+Scr/92Ea/
 WA1qJFAWGt55eqYlRJw5eY0QKCx137BM8jvpBqB2lJxtWq4zyJ0kxs1k95AtatNAdl
 qfSlwSXHql4/RRu9zqYemBcHpmlalPk/JeN5N/P3jmgPUNWelV1JRfi60xbUIDVXr9
 uwthQlJLgHvNg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0F8D51C0BEC;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 42CD73EB94C;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3CEC0133DB; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 17/75] tests/9p: add Tclunk / Rclunk test client
 functions
Date: Sun, 12 Jul 2026 07:14:35 +0300
Message-ID: <20260712041539.108341-17-mjt@tls.msk.ru>
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

Add v9fs_tclunk() and v9fs_rclunk() functions to the 9P test client
for closing file handles (or "FIDs") in test cases.

Link: https://lore.kernel.org/qemu-devel/d53f0337eb7f8525a14e394599d809ecf6805e5e.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit c46150530b3dd6370affa3422f2175ac4668836a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 3493b46b71c..bfc11c9c347 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -241,6 +241,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "RREADDIR" :
         id == P9_RREAD ? "RREAD" :
+        id == P9_RCLUNK ? "RCLUNK" :
         "<unknown>";
 }
 
@@ -1098,3 +1099,36 @@ void v9fs_rread(P9Req *req, uint32_t *count, void *data)
     }
     v9fs_req_free(req);
 }
+
+/* size[4] Tclunk tag[2] fid[4] */
+TClunkRes v9fs_tclunk(TClunkOpt opt)
+{
+    P9Req *req;
+    uint32_t err;
+
+    g_assert(opt.client);
+
+    req = v9fs_req_init(opt.client, 4, P9_TCLUNK, opt.tag);
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_req_send(req);
+
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_rlerror(req, &err);
+            g_assert_cmpint(err, ==, opt.expectErr);
+        } else {
+            v9fs_rclunk(req);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TClunkRes) { .req = req };
+}
+
+/* size[4] Rclunk tag[2] */
+void v9fs_rclunk(P9Req *req)
+{
+    v9fs_req_recv(req, P9_RCLUNK);
+    v9fs_req_free(req);
+}
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index 8067dcb0990..2b40dce8c0f 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -472,6 +472,26 @@ typedef struct TReadRes {
     uint32_t count;
 } TReadRes;
 
+/* options for 'Tclunk' 9p request */
+typedef struct TClunkOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID to clunk (required) */
+    uint32_t fid;
+    /* only send Tclunk request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an Rlerror response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TClunkOpt;
+
+/* result of 'Tclunk' 9p request */
+typedef struct TClunkRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+} TClunkRes;
+
 void v9fs_set_allocator(QGuestAllocator *t_alloc);
 void v9fs_memwrite(P9Req *req, const void *addr, size_t len);
 void v9fs_memskip(P9Req *req, size_t len);
@@ -523,5 +543,7 @@ TunlinkatRes v9fs_tunlinkat(TunlinkatOpt);
 void v9fs_runlinkat(P9Req *req);
 TReadRes v9fs_tread(TReadOpt opt);
 void v9fs_rread(P9Req *req, uint32_t *count, void *data);
+TClunkRes v9fs_tclunk(TClunkOpt opt);
+void v9fs_rclunk(P9Req *req);
 
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index a3f35d49426..c6d6bed80cf 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -31,6 +31,7 @@
 #define tlink(...) v9fs_tlink((TlinkOpt) __VA_ARGS__)
 #define tunlinkat(...) v9fs_tunlinkat((TunlinkatOpt) __VA_ARGS__)
 #define tread(...) v9fs_tread((TReadOpt) __VA_ARGS__)
+#define tclunk(...) v9fs_tclunk((TClunkOpt) __VA_ARGS__)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


