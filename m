Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D14CCD8C89
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHm9-0000HL-Q1; Sun, 07 Jun 2026 13:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8977b3ef87a2c56c1d978cee4e630a0a1b873311@kylie.crudebyte.com>)
 id 1wWHm8-0000H2-3k; Sun, 07 Jun 2026 13:59:08 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8977b3ef87a2c56c1d978cee4e630a0a1b873311@kylie.crudebyte.com>)
 id 1wWHm6-0004JG-Ho; Sun, 07 Jun 2026 13:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=8z6iKW8YNi1KKFTG5t1wGDQ446H2qhx33nkQX+TXy8E=; b=HNj3Z
 ptHgNsw9cduMe/DQSMvksFfcNoNBIhsf23nqBDdqb9fISp9oteF++68kQm9sesxG9dNAuJVavf470
 N1JYIOO023gDoL8H5nfrV7YO1RfdSAoeiQzWoIbpktst8H0aSbnbhLcHXFSm8G2txp+TsWGLHt0lS
 q8StdbehDI48LweTsxXm5ruCenbIVW+U8NMqRlJSZgp1fFownoSkHFrJgqHP5mmu1xXM3/iyDAeFl
 INJEx1dpb3cNlLchnZJNw31/pNLb6c22dn9HZGJ64w3vQHmU6EhcAhd46aLL9tFUGdV0dOxv/AL7b
 Xnjse5InpmqGsBo4W+rdNdY1qgj2C7Tww+Gj+22Ixb17AEzg2VWKBNRhJVRUr3Y88Nej0rnrzpFss
 8i81NjscklwWKsT3GNTOYNK6TfaCZ2d6EiW1qBefzrT5n2G4mAc4SAgRnMLumpbruYwvdoPZKROOO
 RgBc9cr7A3hbTg3UhrgYfUw30NzbDP9pHaHIpXsJVKW2E0YZO6rUjVvp94k+RgHNc+/Vl2xbXrJcj
 LYuC4+lTn90piWux4PUr3UeMymqroyIY6OUCsa8d2OEUYWsp+BPUP9yMxt1nlFfAVU9/U1BeJEQZz
 bO/5iU8uh/oKlD+1RX971ovgRR7szFVubquQLgXU4Xh1kHkdUbvRq+Ceh4gefY=;
Message-ID: <8977b3ef87a2c56c1d978cee4e630a0a1b873311.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 05/12] tests/9p: add Tclunk / Rclunk test client functions
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=8977b3ef87a2c56c1d978cee4e630a0a1b873311@kylie.crudebyte.com;
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


