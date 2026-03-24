Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0672F532E4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 06:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4uyQ-0000Nz-F3; Tue, 24 Mar 2026 02:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w4uyN-0000NW-Ql; Tue, 24 Mar 2026 02:10:39 -0400
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhaoguohan@kylinos.cn>)
 id 1w4uyJ-0006gF-LH; Tue, 24 Mar 2026 02:10:39 -0400
X-UUID: 2353fbbc274811f1a21c59e7364eecb8-20260324
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:54895ef7-03a2-4509-a7df-f7abbef6bbc5, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:2b8ee2698afda296d2fc6f2026cf7607,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|850|898,TC:nil,Content:0|1
 5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2353fbbc274811f1a21c59e7364eecb8-20260324
X-User: zhaoguohan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <zhaoguohan@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 729945883; Tue, 24 Mar 2026 14:10:20 +0800
From: zhaoguohan@kylinos.cn
To: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 GuoHan Zhao <zhaoguohan@kylinos.cn>
Subject: [PATCH] block/curl: factor common cleanup and free password
Date: Tue, 24 Mar 2026 14:10:16 +0800
Message-ID: <20260324061016.973051-1-zhaoguohan@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <27e0e408-eec9-4507-94f8-d8f9c392dc61@linaro.org>
References: <27e0e408-eec9-4507-94f8-d8f9c392dc61@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=124.126.103.232;
 envelope-from=zhaoguohan@kylinos.cn; helo=mailgw.kylinos.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

Factor duplicated cleanup code into a helper and reuse it in the
open failure path and curl_close().

Also free s->password, fixing a leak.

Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
---
 block/curl.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 66aecfb20ec6..577b8d5a4e67 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -622,6 +622,27 @@ static void curl_attach_aio_context(BlockDriverState *bs,
     curl_multi_setopt(s->multi, CURLMOPT_TIMERFUNCTION, curl_timer_cb);
 }
 
+static void curl_cleanup(BDRVCURLState *s)
+{
+    g_free(s->cookie);
+    s->cookie = NULL;
+    g_free(s->url);
+    s->url = NULL;
+    g_free(s->username);
+    s->username = NULL;
+    g_free(s->password);
+    s->password = NULL;
+    g_free(s->proxyusername);
+    s->proxyusername = NULL;
+    g_free(s->proxypassword);
+    s->proxypassword = NULL;
+    if (s->sockets) {
+        curl_drop_all_sockets(s->sockets);
+        g_hash_table_destroy(s->sockets);
+        s->sockets = NULL;
+    }
+}
+
 static QemuOptsList runtime_opts = {
     .name = "curl",
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -900,15 +921,7 @@ out:
     state->curl = NULL;
 out_noclean:
     qemu_mutex_destroy(&s->mutex);
-    g_free(s->cookie);
-    g_free(s->url);
-    g_free(s->username);
-    g_free(s->proxyusername);
-    g_free(s->proxypassword);
-    if (s->sockets) {
-        curl_drop_all_sockets(s->sockets);
-        g_hash_table_destroy(s->sockets);
-    }
+    curl_cleanup(s);
     qemu_opts_del(opts);
     return -EINVAL;
 }
@@ -1010,12 +1023,7 @@ static void curl_close(BlockDriverState *bs)
     curl_detach_aio_context(bs);
     qemu_mutex_destroy(&s->mutex);
 
-    g_hash_table_destroy(s->sockets);
-    g_free(s->cookie);
-    g_free(s->url);
-    g_free(s->username);
-    g_free(s->proxyusername);
-    g_free(s->proxypassword);
+    curl_cleanup(s);
 }
 
 static int64_t coroutine_fn curl_co_getlength(BlockDriverState *bs)
-- 
2.43.0


