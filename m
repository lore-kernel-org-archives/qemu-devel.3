Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2419BCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENZb-00063d-8y; Wed, 07 Oct 2026 05:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c4c016544de7d9d68dc671b55060a17e8a90acb9@kylie.crudebyte.com>)
 id 1xELHr-00024N-OK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:38:34 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c4c016544de7d9d68dc671b55060a17e8a90acb9@kylie.crudebyte.com>)
 id 1xELHe-0004C2-TW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=iJ8RxpGrOJPqH9NFiPOUQ3dtdao14xrLeu7eVJ3LWuM=; b=sxs99
 axXTf7FD9IadFz2YrK+P1Zc+xjFXKRbHWPTL97wZq7dGkSAmWUTJfsVG+nqcQMaic9rqst/qji7IY
 evx1jHm9CszRI4E840DALUVb8U0YyawqUeUIUlMFfhht6+//U7ZLiY2Rh9YXD0yae5DDKQcZ2UfNJ
 Wh7ec+VBCfiSnm2kvxj92GjHdI1KZZfIZDAoopXohMnFHFSmBR7hYJa9xlY2rUFz6ao31B4RKEvgS
 IL76ZwPjZrGzyzAjzLAKIN49p9mC3oZYrNtV8KujR3CMfA0fUSHWD+sMsNLAzhZQwoMrgiXvcCwb+
 ZkwBby4dcKXUFhwxcQMGvW0a0tdnxDqlLTFjXpLlDhsoudxhjQ/mEh2TFQCbYtompx8By39BTS6x6
 +droMEONEh8Z5pt/zzct+DMCbd2AaXhHr+7oCMvYq3q+GYKK51zVACWd/88r77NZkROkzHIsCxkck
 rz44fHYAvrwVclHDezdvsZjSDS4F8VFT2bNrJbmiQyNEkU1QduLDYOfo7jUigcdrkS369UOOtaoHp
 HrNRfxZSw1lJmXPPQ5rGoVO7M3NrvlCbePGO5Sd9aNrjjNhBY8OnAnMFMPXFRk5l+dIO6hAbQ6xBM
 0GBldI40JckwUlpwAVGbxhlbCb7QEmHakpfxy77iIWmvYXmZ54ASw5TfIGTzf4=;
Message-ID: <c4c016544de7d9d68dc671b55060a17e8a90acb9.1791291812.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791291812.git.qemu_oss@crudebyte.com>
References: <cover.1791291812.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 5 Oct 2026 11:04:06 +0000
Subject: [PATCH 8/9] tests/9p-client: track the negotiated 9p version for
 session
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c4c016544de7d9d68dc671b55060a17e8a90acb9@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
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


