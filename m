Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A0FCD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJR-0007z7-Jv; Sat, 13 Jun 2026 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d53f0337eb7f8525a14e394599d809ecf6805e5e@kylie.crudebyte.com>)
 id 1wYQJL-0007u4-D5; Sat, 13 Jun 2026 11:30:15 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d53f0337eb7f8525a14e394599d809ecf6805e5e@kylie.crudebyte.com>)
 id 1wYQJJ-0005EM-Pb; Sat, 13 Jun 2026 11:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=8z6iKW8YNi1KKFTG5t1wGDQ446H2qhx33nkQX+TXy8E=; b=jacz8
 DEnZq/0+rpG+WlmzOMtn46ds2rcnW56AlXdzB2uLxvVTvHdAO6yCWfdRp2KpCx8xeHthDjnGbF9IO
 5/J4LqGQs3BuSyrXg5O9VSAptBsGuv4kVRqTeLdZg6pBOp5kPOS3z64iuIIaOOF/f6PIfhLNOpqXD
 HiMmaPpjRq87aFQKaT2k5uguwAB96kUOSV7C0z4DpVct8hy7mPDKIPkwH28FtWCJ2z2nUrh2N/p21
 o9/oM0Ion7QqUaB0l9Bjg8Yq2TrETEndpv72uMWTlIa9UozjgYoSoQ1n2NVu+Ns/B7Wypoovvq2Jy
 ZMUXNlfmx+obx8WDjd40jcZElWF4U058VFNcusATb7UvuRQyigw8mBpQsJLjLNncJ3RfLuvBv5YQp
 hWDwOwEa+/+oNAuVXPvyNcvHWGTkptSuLHJ5QCs+0gmjaV8NT6CAkVxddXxuOi2e5mbNoDyy6VFjJ
 2dmcts1FJowzm2n0tYlQRFaKUhEyBG4dQOi4HNLyRrKdJ7EevhQfdfNE7wVLhwSGBKuMCdl4+VlfC
 wV2gs/PNEMlnh6sq42C0UwlekI/Gl5KVRx1/349gYJsJLat9wV40wagBmyIkm/fhKt/Jz5edlDO4t
 y9c/JLGU5K3ZaUkFceVGN3qxPW+BDttn398c/6j9QotM8F9M1dbukogWTJRSeQ=;
Message-ID: <d53f0337eb7f8525a14e394599d809ecf6805e5e.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 05/12] tests/9p: add Tclunk / Rclunk test client functions
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d53f0337eb7f8525a14e394599d809ecf6805e5e@kylie.crudebyte.com;
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

Add v9fs_tclunk() and v9fs_rclunk() functions to the 9P test client
for closing file handles (or "FIDs") in test cases.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 34 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 22 +++++++++++++++++
 tests/qtest/virtio-9p-test.c          |  1 +
 3 files changed, 57 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index b9785ef8cb..83af6dab5d 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -242,6 +242,7 @@ static const char *rmessage_name(uint8_t id)
         id == P9_RFLUSH ? "RFLUSH" :
         id == P9_RREADDIR ? "RREADDIR" :
         id == P9_RREAD ? "RREAD" :
+        id == P9_RCLUNK ? "RCLUNK" :
         "<unknown>";
 }
 
@@ -1148,3 +1149,36 @@ void v9fs_rread(P9Req *req, uint32_t *count, void *data)
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
index 37f2517cff..f7ef7f0067 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -504,6 +504,26 @@ typedef struct TReadRes {
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
@@ -557,5 +577,7 @@ TunlinkatRes v9fs_tunlinkat(TunlinkatOpt);
 void v9fs_runlinkat(P9Req *req);
 TReadRes v9fs_tread(TReadOpt opt);
 void v9fs_rread(P9Req *req, uint32_t *count, void *data);
+TClunkRes v9fs_tclunk(TClunkOpt opt);
+void v9fs_rclunk(P9Req *req);
 
 #endif
diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
index 8ccec77e70..099c5e0ca0 100644
--- a/tests/qtest/virtio-9p-test.c
+++ b/tests/qtest/virtio-9p-test.c
@@ -32,6 +32,7 @@
 #define tlink(...) v9fs_tlink((TlinkOpt) __VA_ARGS__)
 #define tunlinkat(...) v9fs_tunlinkat((TunlinkatOpt) __VA_ARGS__)
 #define tread(...) v9fs_tread((TReadOpt) __VA_ARGS__)
+#define tclunk(...) v9fs_tclunk((TClunkOpt) __VA_ARGS__)
 
 static void pci_config(void *obj, void *data, QGuestAllocator *t_alloc)
 {
-- 
2.47.3


