Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8268CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoT9-0007Co-Gh; Mon, 19 Oct 2026 10:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69d00f0bb898e3e635d376e6a7e063e0aff072e0@kylie.crudebyte.com>)
 id 1xIoT7-0007CU-SB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:05 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <69d00f0bb898e3e635d376e6a7e063e0aff072e0@kylie.crudebyte.com>)
 id 1xIoT6-0007UC-3n
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=bgyHkocTAQn8Zy/D/YQYiC18eCMiUqs9zorblhNGkY0=; b=co9Lu
 XOEW/FDJMZxfEQZFvRWaT7eq3D9uUNZmnuYkDHaTrpbzpqIfy7v0+gOCAk9dZKZONnBZiSjLPsjro
 ur6xFPOVilMbTEhIZJiur1RA+7ySxxATJpvjISRLYAl2g1UZllX2OAvwfz0r/GkTWug7fsHxzBRi+
 yLjFRem3RatjOOEamtAVOZ4Dgp01FjdWqRtDz0cMOxI1KItBkgy+P/Eyzc+qDvAjHVx6gitZBGMn8
 aKTGcRNb3Gg/JwasmFRz79s223RcuBFXOpdwB4aO+nVFyCwZ7eau1N/f3l4SmYZ7HmWGZXnSdsJN6
 XIrZhklHJPsvL/bnqH8IcmbSFV2ONJfh2pzdeED52wbXsSRFM+ukLtvXvVCAn5+xhuffW9t6P2fyx
 w8yTNui0rL2euzwHwfQ5v3W0/cayTD5/DQtUZVBCrbzlisqK+0Crajm2Vpa1eyFCnED1CBjquuGxp
 qPKN1MRDOM/0mrNRFEhf2xvFxjTBE+UIg5YrWKEEEslHA0vuTclBwCBB7mJnFfA0M8R3G+6jWnuec
 tR4O+JRe4qI6z98Xd//WV98D47g6QhTO+cst4+6mkswqhFD7MEubZKk/m/DkhjuR/V7AY1uKLPbYX
 nmG7EymqJn6xww+OmZABuoiPrKAm+HhucQd43hVD2M8FUbeCB3FQdaBCAzDqs0=;
Message-ID: <69d00f0bb898e3e635d376e6a7e063e0aff072e0.1792420035.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1792420035.git.qemu_oss@crudebyte.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2026 16:27:16 +0200
Subject: [PULL 1/9] tests/9p-client: add Txattrwalk / Rxattrwalk test client
 functions
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=69d00f0bb898e3e635d376e6a7e063e0aff072e0@kylie.crudebyte.com;
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

Add v9fs_txattrwalk() and v9fs_rxattrwalk() functions to the 9p test
client. This can be used to retrieve a list of xattrs or to acquire
a FID that can subsequently be used to retrieve the value of an xattr.

This is a preparatory patch, these functions will be used by the
subsequently added 9p race test.

Link: https://lore.kernel.org/qemu-devel/fcd4dd1ed8cf6ae9af99ba5ade8b5922875e442d.1791368962.git.qemu_oss@crudebyte.com
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


