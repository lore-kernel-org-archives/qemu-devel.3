Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E9ECA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEP48-0000OE-Ua; Wed, 07 Oct 2026 06:40:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <13b2cead57321d45b6503059e35c1ec1b49a629a@kylie.crudebyte.com>)
 id 1xEP3f-0008W0-Bg
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:39:40 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <13b2cead57321d45b6503059e35c1ec1b49a629a@kylie.crudebyte.com>)
 id 1xEP3d-00082g-I5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=AOgKE60QTgc9oLfM3g99Y6UskTWDDDXSXiHpDWKWwUQ=; b=UKiAu
 ZCEgEQ582LIpFIBpGrk53TKS7rWWUmb1PESZi+aXKBqVRdi6nwxhQRiHzrtgAYHZQ3mLQFmX6gW6t
 1UwNa2MPoVLFWI180lpek+Hfq9v36IYxQTVLuf0tz6gSNGOwSvnM8YiYHqrRdRnIw2myTGoclsvWN
 BARsGXuN9X2pm7UC6k3rY8AhHMZMdRfTaM8gBKusifkOTo0x8NcWqyI+mOYfSB98xidQgY4Cl3PZ8
 VvWy60nKAq+j6ZVCQPbMLmRXUH54UgRoAiv5d5obg4BPxpafAgimvt2/1otbqxL475ayAVn4Q+h4U
 Yx0O5IEYWTqkpO/IYmn39NGVBrjKrzlV2uyDnhLZhYe2AT1Ij5ySqr9r9+TyUFkTR6pxSuh2Y6wbW
 JY9KNV1bV5WO9Z7YO4eSGYEV8677NbbbECqE6m6bf1DQJ0uL4ObNg5Itw1gsIP+dO/d3I6srKKwGL
 RSEDW3AvLrpyq11W5u/hYADC+vXs5hP0ICnQ31SWep44OT8kS9M5x6T/9zIb36E9RvLg0bU6i9zEM
 Rhrei4u/ngsbIACjAz3vYcpOzg/zGWkelawmRNuBhTJZiKTL0NdZNSKqfGx+c4VfZ0KG3ubD9U48G
 GXAUcM9Xjy7F+5+dCU4kTexSPdJpzLrcW3lR3V21aEQvoUCulxLeR0+D4oN9+s=;
Message-ID: <13b2cead57321d45b6503059e35c1ec1b49a629a.1791368962.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791368962.git.qemu_oss@crudebyte.com>
References: <cover.1791368962.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 7 Oct 2026 12:27:33 +0200
Subject: [PATCH v2 3/9] tests/9p-client: add Rerror function (legacy 9p2000.u)
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=13b2cead57321d45b6503059e35c1ec1b49a629a@kylie.crudebyte.com;
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

Add v9fs_rerror() function to the 9p test client. This function is
the legacy 9p2000.u variant for returned errors (i.e. in contrast
to the already existing Rlerror response handler function
v9fs_rlerror() for the 9p2000.L protocol version).

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 tests/qtest/libqos/virtio-9p-client.c | 11 +++++++++++
 tests/qtest/libqos/virtio-9p-client.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tests/qtest/libqos/virtio-9p-client.c b/tests/qtest/libqos/virtio-9p-client.c
index b2f0037b7b..005ae53a3f 100644
--- a/tests/qtest/libqos/virtio-9p-client.c
+++ b/tests/qtest/libqos/virtio-9p-client.c
@@ -287,6 +287,17 @@ void v9fs_req_free(P9Req *req)
     g_free(req);
 }
 
+/* size[4] Rerror tag[2] ename[s] errno[4] */
+void v9fs_rerror(P9Req *req, uint32_t *err)
+{
+    g_autofree char *ename = NULL;
+
+    v9fs_req_recv(req, P9_RERROR);
+    v9fs_string_read(req, NULL, &ename);
+    v9fs_uint32_read(req, err);
+    v9fs_req_free(req);
+}
+
 /* size[4] Rlerror tag[2] ecode[4] */
 void v9fs_rlerror(P9Req *req, uint32_t *err)
 {
diff --git a/tests/qtest/libqos/virtio-9p-client.h b/tests/qtest/libqos/virtio-9p-client.h
index c910407f70..5a00a0870c 100644
--- a/tests/qtest/libqos/virtio-9p-client.h
+++ b/tests/qtest/libqos/virtio-9p-client.h
@@ -599,6 +599,7 @@ void v9fs_req_send(P9Req *req);
 void v9fs_req_wait_for_reply(P9Req *req, uint32_t *len);
 void v9fs_req_recv(P9Req *req, uint8_t id);
 void v9fs_req_free(P9Req *req);
+void v9fs_rerror(P9Req *req, uint32_t *err);
 void v9fs_rlerror(P9Req *req, uint32_t *err);
 TVersionRes v9fs_tversion(TVersionOpt);
 void v9fs_rversion(P9Req *req, uint16_t *len, char **version);
-- 
2.47.3


