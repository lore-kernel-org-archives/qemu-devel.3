Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E008CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoU6-0008L3-PV; Mon, 19 Oct 2026 10:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d8dd4017095383bd4b14a7ee8151248f6902eb72@kylie.crudebyte.com>)
 id 1xIoTn-00085v-55
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:48 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d8dd4017095383bd4b14a7ee8151248f6902eb72@kylie.crudebyte.com>)
 id 1xIoTl-0007Xk-Ee
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=D/l6eXUlVJjuO9j0jWaOG3I5EU2cMuMJYuYVQoLiou8=; b=Ocqku
 JdGfeEdZ1BjqCAWGeyeXFMGti/TIP9M5Fe4QLJLuqO3ZXW2H7BCLyc6i2TB9hfkeuLpYxYb+i42z9
 rdoZOGPyvFH6F18W0/iw+TVD6y7qygiZHtlo1SYTR8gFAVCVvYuiDP+r+nZoRL3Dfza4fWZkDxoaD
 rrf4CzSjL1PKb0Z3JwsP5hvz5p6XnMqawvXmWA3fDS72zO0irTcsgniuD8df85UVIE5wPHrmzYDZ/
 jKoS7ijwYiWWMdpr9Hl1S06/gbQjnIOeR8XKK0xiWShPSypoe0B/aUjuZ9QZtK33c7qdP8E/7+lU9
 JCaGhdZJW9hsndWPQ8BQILiCjPLsOc8fkfFq7H0PUriXqW528NsgeIQz9cJ81eaamxvee/JO1WLG9
 DaTUz3XDddEBl1c5pPXqpdUVRVPk8AeV/XBHnAXy0+Irf/UoquApvOAJkXcWb+VflrveO/1/QwJY7
 uM0tTUc5gBtV8a6EuYiUupqJgG1ESugOrUxe3pmBJFVvd/uur/feE8ThICRgfjrU+yOFMEFywhzAd
 GavCFy79hpA5WNgDJbWlMcs1Uow013EjH0BCBqAFsfAnBHhYvQd/yFeUac9q7kjLp1F2zT+zJG2Ib
 o7KPRHBRlfP1H+bJWZYed4+BeJEAlpp1FIlYFOpPqUZCcsnkXM/0gzeWRG2NJE=;
Message-ID: <d8dd4017095383bd4b14a7ee8151248f6902eb72.1792420035.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1792420035.git.qemu_oss@crudebyte.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2026 16:27:16 +0200
Subject: [PULL 7/9] tests/9p-client: add Tcreate / Rcreate test client
 functions
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d8dd4017095383bd4b14a7ee8151248f6902eb72@kylie.crudebyte.com;
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

Add v9fs_tcreate() and v9fs_rcreate() functions to the 9p test
client for the legacy 9p2000(.u) Tcreate request type.

This is a preparatory patch, these functions will be used by the
subsequently added 9p race test.

Link: https://lore.kernel.org/qemu-devel/532fed8595419fd57ec7d24dc5dbcbd8b1190e80.1791368962.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 60 +++++++++++++++++++++++++++
 tests/qtest/libqos/virtio-9p-client.h | 50 ++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index 4a3fc1511b..ce67a4b8c5 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -1365,3 +1365,63 @@ void v9fs_rstat(P9Req *req, v9fs_stat *stat)
 
     v9fs_req_free(req);
 }
+
+/* size[4] Tcreate tag[2] fid[4] name[s] perm[4] mode[1] extension[s] */
+TCreateRes v9fs_tcreate(TCreateOpt opt)
+{
+    P9Req *req;
+    uint8_t mode = opt.mode;
+    uint32_t body_size = 4 + 4 + 1;
+    uint16_t string_size;
+
+    g_assert(opt.client);
+    /* expecting either Rcreate or an error response, but obviously not both */
+    g_assert(!opt.expectErr || !(opt.rcreate.qid || opt.rcreate.iounit));
+
+    if (!opt.perm) {
+        opt.perm = 0644;
+    }
+    if (!opt.extension) {
+        opt.extension = "";
+    }
+
+    string_size = v9fs_string_size(opt.name) +
+                  v9fs_string_size(opt.extension);
+    g_assert_cmpint(body_size, <=, UINT32_MAX - string_size);
+    body_size += string_size;
+
+    req = v9fs_req_init(opt.client, body_size, P9_TCREATE, opt.tag);
+    v9fs_uint32_write(req, opt.fid);
+    v9fs_string_write(req, opt.name);
+    v9fs_uint32_write(req, opt.perm);
+    v9fs_memwrite(req, &mode, 1);
+    v9fs_string_write(req, opt.extension);
+    v9fs_req_send(req);
+
+    if (!opt.requestOnly) {
+        v9fs_req_wait_for_reply(req, NULL);
+        if (opt.expectErr) {
+            v9fs_req_check_err(req, opt.expectErr);
+        } else {
+            v9fs_rcreate(req, opt.rcreate.qid, opt.rcreate.iounit);
+        }
+        req = NULL; /* request was freed */
+    }
+
+    return (TCreateRes) { .req = req };
+}
+
+/* size[4] Rcreate tag[2] qid[13] iounit[4] */
+void v9fs_rcreate(P9Req *req, v9fs_qid *qid, uint32_t *iounit)
+{
+    v9fs_req_recv(req, P9_RCREATE);
+    if (qid) {
+        v9fs_memread(req, qid, 13);
+    } else {
+        v9fs_memskip(req, 13);
+    }
+    if (iounit) {
+        v9fs_uint32_read(req, iounit);
+    }
+    v9fs_req_free(req);
+}
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index f604cc0ee5..88e0f41ff0 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -372,6 +372,54 @@ typedef struct TMkdirRes {
     P9Req *req;
 } TMkdirRes;
 
+/* create directory */
+#define P9_CREATE_PERM_DMDIR     0x80000000
+
+/* options for 'Tcreate' 9p request (legacy 9p2000.u) */
+typedef struct TCreateOpt {
+    /* 9P client being used (mandatory) */
+    QVirtio9P *client;
+    /* user supplied tag number being returned with response (optional) */
+    uint16_t tag;
+    /* file ID of the directory the new file shall be created in (required) */
+    uint32_t fid;
+    /* name of the new file (required) */
+    const char *name;
+    /*
+     * Create mode bits (including file type bits):
+     * e.g. 0644 for a regular file,
+     * or P9_CREATE_PERM_DMDIR | 0755 for a directory
+     * (optional)
+     */
+    uint32_t perm;
+    /*
+     * Open mode byte:
+     * OREAD (0), OWRITE (1), ORDWR (2), OEXEC(3), OTRUNC(0x10), ORCLOSE(0x40)
+     * (optional)
+     */
+    uint8_t mode;
+    /*
+     * Extension data for special files (e.g. symlink target), empty for
+     * regular files. (optional)
+     */
+    const char *extension;
+    /* data being received from 9p server as 'Rcreate' response (optional) */
+    struct {
+        v9fs_qid *qid;
+        uint32_t *iounit;
+    } rcreate;
+    /* only send Tcreate request but not wait for a reply? (optional) */
+    bool requestOnly;
+    /* do we expect an error response, if yes which error code? (optional) */
+    uint32_t expectErr;
+} TCreateOpt;
+
+/* result of 'Tcreate' 9p request */
+typedef struct TCreateRes {
+    /* if requestOnly was set: request object for further processing */
+    P9Req *req;
+} TCreateRes;
+
 /* options for 'Tlcreate' 9p request */
 typedef struct TlcreateOpt {
     /* 9P client being used (mandatory) */
@@ -666,6 +714,8 @@ TFlushRes v9fs_tflush(TFlushOpt);
 void v9fs_rflush(P9Req *req);
 TMkdirRes v9fs_tmkdir(TMkdirOpt);
 void v9fs_rmkdir(P9Req *req, v9fs_qid *qid);
+TCreateRes v9fs_tcreate(TCreateOpt opt);
+void v9fs_rcreate(P9Req *req, v9fs_qid *qid, uint32_t *iounit);
 TlcreateRes v9fs_tlcreate(TlcreateOpt);
 void v9fs_rlcreate(P9Req *req, v9fs_qid *qid, uint32_t *iounit);
 TsymlinkRes v9fs_tsymlink(TsymlinkOpt);
-- 
2.47.3


