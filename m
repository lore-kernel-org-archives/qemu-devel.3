Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04899CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:16:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENaN-0006r9-KG; Wed, 07 Oct 2026 05:05:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e636ae2adc142414859e65152317949b3734503f@kylie.crudebyte.com>)
 id 1xELLB-0002fd-4Q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:41:43 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e636ae2adc142414859e65152317949b3734503f@kylie.crudebyte.com>)
 id 1xELKt-0004C2-Vt
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=+Y8/MEhhw7dTr+JFJolHL7vFyQWF9Q7QCWyhn9FUpR8=; b=j1bDa
 A51oGkjNrwHYALtDtA/r3a08hmkw70VfReIU03RHQTIZxe/WrjypUQCVZB+KtdZGtzDGomi7c6Lzl
 aJ2AVvcjlhj6OFL6U1fl1OWLrbgLzhD+r/29vHCJJ+2NQ9GtpJvcnfSwCcIRARdgCsMlNhE3r18ch
 5y5LQbiPkeUzOhw4GsdX3F0WSIPk1slws2/v/A1qfyWR6kXvlLqIbxouTCwous40ICw6TcZ6DQEpX
 7mZkQk8JpxNln7PkbB9qpvUs+Ffwb7VWQzqZjDD9nih6iT/CjqAiFn0jcwS3n6GPAN4FyK0/yOVML
 6zhRkVIbbOeN3OV1giOMIb2ieZq4lvvazfJAA8Y3SLEIDTRs0lCa46yoniPZT5hfRf64mlPJAwySG
 4Xyaw5b+CQwraGx770iQeLu4nhBYTimowYZEYn+fMYrl8doK93JrvoNEsxVwVbm66fGPP4b4Nq2bk
 FrV+1xngVLGJsf7DTknUetor/Pb2cqx5mp27fX1PdVp7uLdHbt9vOe5NmsM3/VZ1FgIFWm+3HfB6+
 8W1S4LWJqNtzvXiw6yDKf1XuDN2JizCxZDrea08nZcF13HLoPl9rdqtiRuX8bjIN1zXxsQEXKoOWz
 DIDS213F+3oLYaXkUpp31nma28SEeynMaWrpou+9u8dCETsSn18H1Mgp/Vq8XY=;
Message-ID: <e636ae2adc142414859e65152317949b3734503f.1791291812.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791291812.git.qemu_oss@crudebyte.com>
References: <cover.1791291812.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 30 Sep 2026 12:57:07 +0000
Subject: [PATCH 1/9] tests/9p-client: add Txattrwalk / Rxattrwalk test client
 functions
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=e636ae2adc142414859e65152317949b3734503f@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: 13
X-Spam_score: 1.3
X-Spam_bar: +
X-Spam_report: (1.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Add v9fs_txattrwalk() and v9fs_rxattrwalk() functions to the 9p test
client. This can be used to retrieve a list of xattrs or to acquire
a FID that can subsequently be used to retrieve the value of an xattr.

This is a preparatory patch, these functions will be used by the
subsequently added 9p race test.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 48 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 28 ++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 305b0dac63..b2f0037b7b 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -1227,3 +1227,51 @@ void v9fs_rxattrcreate(P9Req *req)
     v9fs_req_recv(req, P9_RXATTRCREATE);
     v9fs_req_free(req);
 }
+
+/* size[4] Txattrwalk tag[2] fid[4] newfid[4] name[s] */
+TXattrWalkRes v9fs_txattrwalk(TXattrWalkOpt opt)
+{
+    P9Req *req;
+    uint32_t err;
+    uint32_t body_size = 4 + 4;
+    uint16_t string_size;
+    uint64_t xattr_size = 0;
+
+    g_assert(opt.client);
+    g_assert(opt.name);
+
+    string_size = v9fs_string_size(opt.name);
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(opt.client, body_size, P9_TXATTRWALK, opt.tag);
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_uint32_write(req, opt.newfid);
+    v9fs_string_write(req, opt.name);
+    v9fs_req_send(req);
+
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_rlerror(req, &err);
+            g_assert_cmpint(err, ==, opt.expectErr);
+        } else {
+            v9fs_rxattrwalk(req, &xattr_size);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TXattrWalkRes) { .req = req, xattr_size };
+}
+
+/* size[4] Rxattrwalk tag[2] size[8] */
+void v9fs_rxattrwalk(P9Req *req, uint64_t *size)
+{
+    v9fs_req_recv(req, P9_RXATTRWALK);
+    if (size) {
+        v9fs_uint64_read(req, size);
+    } else {
+        v9fs_memskip(req, 8);
+    }
+    v9fs_req_free(req);
+}
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index 4b04324503..c910407f70 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -553,6 +553,32 @@ typedef struct TXattrCreateRes {
     uint32_t err;
 } TXattrCreateRes;
 
+/* options for 'Txattrwalk' 9p request */
+typedef struct TXattrWalkOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID of file/dir from which to walk (required) */
+    uint32_t fid;
+    /* file ID that will refer to the walked-to xattr (required) */
+    uint32_t newfid;
+    /* xattr name, or empty for a list of all xattrs (required) */
+    const char *name;
+    /* only send Txattrwalk request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an Rlerror response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TXattrWalkOpt;
+
+/* result of 'Txattrwalk' 9p request */
+typedef struct TXattrWalkRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+    /* size of xattr */
+    uint64_t size;
+} TXattrWalkRes;
+
 void v9fs_set_allocator(QGuestAllocator *t_alloc);
 void v9fs_memwrite(P9Req *req, const void *addr, size_t len);
 void v9fs_memskip(P9Req *req, size_t len);
@@ -610,5 +636,7 @@ TClunkRes v9fs_tclunk(TClunkOpt opt);
 void v9fs_rclunk(P9Req *req);
 TXattrCreateRes v9fs_txattrcreate(TXattrCreateOpt opt);
 void v9fs_rxattrcreate(P9Req *req);
+TXattrWalkRes v9fs_txattrwalk(TXattrWalkOpt opt);
+void v9fs_rxattrwalk(P9Req *req, uint64_t *size);
 
 #endif
-- 
2.47.3


