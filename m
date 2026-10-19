Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DA1CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoUA-0008Re-Ir; Mon, 19 Oct 2026 10:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b1ba6810f10139f5346c8fe49102d534aa94ce88@kylie.crudebyte.com>)
 id 1xIoTu-0008Dr-2J
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:59 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <b1ba6810f10139f5346c8fe49102d534aa94ce88@kylie.crudebyte.com>)
 id 1xIoTs-0007YI-BX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=oATbJdAiOnpwZcYA8cLN5rFgwHZ9uzquoQVshJz889Q=; b=f1kC6
 4ozb0guQariBTywET5kYKZtOQSqwa/y+74YZzD6SPmlEZZDWDQfRkIZWR9kQrQyeQ51bjd2EWZLCx
 ACNw+uboMqzYtBOoaLaZqF+UhvSZhn50f+XvcoFdkFftea8CZUuepUaD4SXQ2e7yaFN4hosmMLF7O
 tOytrdXK34QqVyl5lEjI8So9oZgk4v3wzEE5ZXnaF+WFOpiYTeLOS65Xuzrg3+CwoUDYJHswmH/IP
 +LGldvDJPtZykifMmKxmX74gkgoV6UJtjz/b4djTRqOJHl31GwSi+HvhuaEFYvzU1Z8lcYmCjs0MJ
 vWRYJ8vYlteDtQ9Q3NyOBsdYVn4rfKipiRfFPmRNcrcjZJfReuluAsqjZJjInxhzGg6D9aBAyBTlW
 LGBaAW1YOLnqWfHspZDPmuZysuOUCRB/bTxYvFEzBoC9Ii4xCwlJZ+L7hy8sbWYJieEh3afvtW+1g
 lDRaYxtmu2lnUXOwn6T7K9B7vodlk0Qop4eaGluhIFclvEkQY5ceDSGkJ7ea3i2kUQK/nJNlsTabb
 e0jBBVzIhDC2R4sthqXswoZluU1TV27Hx00XmBkdovq2G2Shd5Ih0KbA6dW4shmyJxfYYeHj2zkPe
 W4ti9ZuC5S3ALlsjKFTmw2yEqESlD+cYG2EgsIzGEps39glX3Cgo+HtaEDHfuk=;
Message-ID: <b1ba6810f10139f5346c8fe49102d534aa94ce88.1792420035.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1792420035.git.qemu_oss@crudebyte.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2026 16:27:16 +0200
Subject: [PULL 8/9] tests/9p-client: track the negotiated 9p version for
 session
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=b1ba6810f10139f5346c8fe49102d534aa94ce88@kylie.crudebyte.com;
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

So far v9fs_tattach() always sent an implied Tversion request, which
was supposed to be a convenient mechanisms such that not every test
case code would need to call v9fs_tversion() prior to a
v9fs_tattach(). The problem however is that this implicit Tversion
defaults to 9p2000.L, and it would also be (re)sent if an explicit
v9fs_tversion() call had been issued with 9p2000.u before, which then
would reset the session to the unintended 9p2000.L protocol version.

Fix this by storing the initial Tversion request's (desired) protocol
version to the client object. And only issue the implicit Tversion
request inside of v9fs_tattach() if no protocol version had been
negotiated already.

This is a preparatory patch for the subsequently added race test,
which negotiates a 9p2000.u session.

It also allows request / response handling to later become more
protocol dialect aware (e.g. expecting specific request / response
types according to negotiated protocol version during a session).

Link: https://lore.kernel.org/qemu-devel/419b2b047c0f61b9e4a7e58f117c03ec6feea1ea.1791368962.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 15 ++++++++++++++-
 tests/qtest/libqos/virtio-9p.h        |  6 ++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index ce67a4b8c5..20c7af91bd 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -366,6 +366,15 @@ TVersionRes v9fs_tversion(TVersionOpt opt)
     v9fs_string_write(req, opt.version);
     v9fs_req_send(req);
 
+    /* store session's protocol version to client object */
+    if (!strcmp(opt.version, "9P2000.u")) {
+        opt.client->proto_version = V9FS_PROTO_2000U;
+    } else if (!strcmp(opt.version, "9P2000.L")) {
+        opt.client->proto_version = V9FS_PROTO_2000L;
+    } else {
+        g_assert_not_reached();
+    }
+
     if (!opt.requestOnly) {
         v9fs_req_wait_for_reply(req, NULL);
         if (opt.expectErr) {
@@ -412,7 +421,11 @@ TAttachRes v9fs_tattach(TAttachOpt opt)
     /* expecting either Rattach or Rlerror, but obviously not both */
     g_assert(!opt.expectErr || !opt.rattach.qid);
 
-    if (!opt.requestOnly) {
+    /*
+     * convenience feature: send an implicit Tversion request, however only if
+     * Tversion has not been issued for this session before.
+     */
+    if (!opt.requestOnly && opt.client->proto_version == 0) {
         v9fs_tversion((TVersionOpt) { .client = opt.client });
     }
 
diff --git a/tests/qtest/libqos/virtio-9p.h b/tests/qtest/libqos/virtio-9p.h
index e7efeef7a1..db21c5059c 100644
--- a/tests/qtest/libqos/virtio-9p.h
+++ b/tests/qtest/libqos/virtio-9p.h
@@ -22,6 +22,7 @@
 #include "qgraph.h"
 #include "virtio.h"
 #include "virtio-pci.h"
+#include "hw/9pfs/9p.h"
 
 typedef struct QVirtio9P QVirtio9P;
 typedef struct QVirtio9PPCI QVirtio9PPCI;
@@ -32,6 +33,11 @@ typedef struct QVirtio9PDevice QVirtio9PDevice;
 struct QVirtio9P {
     QVirtioDevice *vdev;
     QVirtQueue *vq;
+    /*
+     * The protocol version negotiated for this 9p session via Tversion request
+     * (0 if no protocol version negotiated yet)
+     */
+    P9ProtoVersion proto_version;
 };
 
 struct QVirtio9PPCI {
-- 
2.47.3


