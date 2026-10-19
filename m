Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BD5CCF2E5
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoTP-0007Ge-5r; Mon, 19 Oct 2026 10:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8a9be26b0aac54d97b4228dc1bd61049d80472a8@kylie.crudebyte.com>)
 id 1xIoTN-0007G0-8L
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:21 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <8a9be26b0aac54d97b4228dc1bd61049d80472a8@kylie.crudebyte.com>)
 id 1xIoTL-0007Vh-O0
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:36:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3sjb3UBBgzDNLh3mbrEpyXJaIuJ4otItdxce6XxFjQo=; b=KWRnw
 84CstdT21DvgjQLnPd3c20K18lL+A2YbQCe05aES9oBH+rhRsV9Ky3KsRROsNzyVg+4kZkrJpPNyE
 9QLa60L0LK3b0T7dTnmuScH8bWKWDzkvfB5rEPYJlr84bKu8Q7iRYM5UsVlwnHnpCY8n+X+2y8obX
 7Gp2C900RxfKyek4D8JSWHdy7WRM7ZSwfZFtxnfBJYSrrgJDBOvwPfRe+o0zyQzrhLPVvhR3sFdaF
 5KkGWMyKuHl3yLEkiec0kM9fH/HdvgU1O7zLlxWay6fkc0GqGKdsatWApnRskTNOlb5Umwr1Se819
 iZ3lTBTCPUN51GduQQR5CKoIx1iNQQyt8t/zy3d8kkrIZH9y07ru3Gu33MG63uszIto1aFCGSIFcd
 P0V2i1KcymKfd6AjSeh6AryfOPrZ1wkjd9ekiWYw5ceJ7In017911KnXzKaax2xjvGSKR+ilroyG7
 uhX4x9bdV6eLbHdpiHYNtwmTCC5G8EJT5fM3EAl8Pl7/ftZ+dSoSxjJ1g0T4XnNU6DM6YAskZu9QE
 R8KLROo12FozG/dWRplq2w7PICp49vzJ6gQko7c/GSp2KHrJO2CJmgVEkatgw1duij2vcIqkHYP2R
 /w76epKCU8cczu3qsWVFuLh6ophNxTFHSbIW5jYeB9PppN6iF7ZXp8RRADxqrA=;
Message-ID: <8a9be26b0aac54d97b4228dc1bd61049d80472a8.1792420035.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1792420035.git.qemu_oss@crudebyte.com>
References: <cover.1792420035.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 19 Oct 2026 16:27:16 +0200
Subject: [PULL 3/9] tests/9p-client: add Rerror function (legacy 9p2000.u)
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Peter Maydell <peter.maydell@linaro.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=8a9be26b0aac54d97b4228dc1bd61049d80472a8@kylie.crudebyte.com;
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

Link: https://lore.kernel.org/qemu-devel/13b2cead57321d45b6503059e35c1ec1b49a629a.1791368962.git.qemu_oss@crudebyte.com
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


