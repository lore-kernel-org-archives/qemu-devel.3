Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A69ECA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENfr-0008JY-EW; Wed, 07 Oct 2026 05:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d7299a05e48ca9a18757259f4273380f3eaef5af@kylie.crudebyte.com>)
 id 1xELKH-0002Y9-Kv
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:41:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <d7299a05e48ca9a18757259f4273380f3eaef5af@kylie.crudebyte.com>)
 id 1xELJy-0004C2-Jf
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 02:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=AOgKE60QTgc9oLfM3g99Y6UskTWDDDXSXiHpDWKWwUQ=; b=LTCw8
 WCTeOTo1ApPAnz45XL/CYAOi28Bro35SqmmkNmWrGA3eQbo73IHY2PH0W1pAeapRs4RjFwceDlHPB
 3le/i41xVC7gHZ1oDLCPEapefrQpcViIxQb9ADUO/SSBBf+gMT+ZkA2Uyf9CdzWcm3dPih6h5ZfFD
 r5XeR5ypUeLTZRPrXb3T9lJWRQfbAwFELNa5nVTqoU1hHWt8QC+iYEcIt57yqCsmAk8VYnqR+4bIV
 DtNDpKHrqU/Trlyi3FrA0Q1hP4ZOgGzdbbO37jEU7Ddb2TB4aknwEvxHdcEvTo6M8U/cnggKNupeO
 ghzJlnYEvjiPn+nXWZidQU8Uw6gSYf+oOolehP0K6P9Gx8vRq2E+sN8JOBKoh2lPEXCOjWcTeSAkB
 qNyXvfkT3aCkfSoL2P1eVDr6f+toPhRYnimIt7dIwJhY7gn8SRXNYEUVofY3Cy/LS47Ay0q+S3Oui
 yhqO+JbK7gw4OmHUFEY17t/jc/NeX6HEu4bwcfPMXp3rRFQoM0MJt5PpxOy4hkJ6bumeWujEUdwct
 ZWDCoCFeoKsnDNJH4OBcIiP8a6WEjWcVgN3OaaM6BTdH2P8XY3xgSbHOEuDLIX0SAIaU1sgH9fz+r
 0v2jjOn0WbkXOBmTlRYl0k4NZ/17Ci7bGPYKlaxVSJhUOqO2y6P29ykMe58PxA=;
Message-ID: <d7299a05e48ca9a18757259f4273380f3eaef5af.1791291812.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1791291812.git.qemu_oss@crudebyte.com>
References: <cover.1791291812.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 3 Oct 2026 19:43:26 +0200
Subject: [PATCH 3/9] tests/9p-client: add Rerror function (legacy 9p2000.u)
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=d7299a05e48ca9a18757259f4273380f3eaef5af@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_48_96=1,
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


