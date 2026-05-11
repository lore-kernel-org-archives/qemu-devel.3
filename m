Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B087DCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRUt-0000V1-9h; Mon, 11 May 2026 10:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1wMRUU-0000SR-Tx; Mon, 11 May 2026 10:20:17 -0400
Received: from canpmsgout01.his.huawei.com ([113.46.200.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arei.gonglei@huawei.com>)
 id 1wMRUQ-00021P-Ol; Mon, 11 May 2026 10:20:14 -0400
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=QZpgixKufnikDtZ8GsTp1Ep13ODbGUralTy75Z05Y7Y=;
 b=NJ3iujfgAAQYBBPQpG9JF0BNqIF4r6uWuR8hwW+GEFKWqRlkobFiHiQJyXd2REBcUjKqHjdvZ
 e2nrsyHa/RXO6YgdNlAjTtxYIyqAaCftbToAG8lNOEiQli+kaV1SUcSDKmp8Viwe0LP3xgQV62X
 W/aW5+hVHcvAjNpzxLimGlM=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gDhW060M4z1T4FV;
 Mon, 11 May 2026 22:12:12 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
 by mail.maildlp.com (Postfix) with ESMTPS id A598A4048F;
 Mon, 11 May 2026 22:19:51 +0800 (CST)
Received: from DESKTOP-EH3TE8S.china.huawei.com (10.174.54.174) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 11 May 2026 22:19:50 +0800
From: Gonglei <arei.gonglei@huawei.com>
To: <arei.gonglei@huawei.com>, <qemu-devel@nongnu.org>,
 <qemu-stable@nongnu.org>
CC: <berrange@redhat.com>, <mcascell@redhat.com>, Buzzy <buzzy0257@gmail.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>
Subject: [PULL 1/1] backends/cryptodev-lkcf: fix use-after-free in session
 lifecycle
Date: Mon, 11 May 2026 22:19:46 +0800
Message-ID: <20260511141947.267-2-arei.gonglei@huawei.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <20260511141947.267-1-arei.gonglei@huawei.com>
References: <20260511141947.267-1-arei.gonglei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.54.174]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf200006.china.huawei.com (7.185.36.61)
Received-SPF: pass client-ip=113.46.200.216;
 envelope-from=arei.gonglei@huawei.com; helo=canpmsgout01.his.huawei.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The cryptodev-lkcf backend had a race condition where session close
could free a session while tasks using that session were still pending
in the queue. This leads to use-after-free when the worker thread
later accesses the freed session pointer.

Add reference counting (in_use) and pending_close flag to ensure:
- New operations are rejected when a session is closing
- Session close waits for all in-flight tasks to complete
- No use-after-free can occur

Fixes: CVE-2026-6288
Fixes: 39fff6f3e8 ("cryptodev: Add a lkcf-backend for cryptodev")
Reported-by: Buzzy <buzzy0257@gmail.com>
Signed-off-by: Gonglei <arei.gonglei@huawei.com>
Tested-by: Buzzy <buzzy0257@gmail.com>
Reviewed-by: zhenwei pi <zhenwei.pi@linux.dev>
---
 backends/cryptodev-lkcf.c | 59 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/backends/cryptodev-lkcf.c b/backends/cryptodev-lkcf.c
index 40c7bd3c5a..3a93c81372 100644
--- a/backends/cryptodev-lkcf.c
+++ b/backends/cryptodev-lkcf.c
@@ -66,6 +66,9 @@ typedef struct CryptoDevBackendLKCFSession {
     size_t keylen;
     QCryptoAkCipherKeyType keytype;
     QCryptoAkCipherOptions akcipher_opts;
+    int in_use;  /* number of tasks currently using this session */
+    /* session close requested, waiting for in_use to become 0 */
+    bool pending_close;
 } CryptoDevBackendLKCFSession;
 
 typedef struct CryptoDevLKCFTask CryptoDevLKCFTask;
@@ -428,6 +431,18 @@ out:
     if (key_id >= 0) {
         keyctl_unlink(key_id, KCTL_KEY_RING);
     }
+
+    /*
+     * Decrement session in_use counter and signal if session is pending close.
+     * This allows close_session to proceed after all tasks complete.
+     */
+    qemu_mutex_lock(&task->lkcf->mutex);
+    task->sess->in_use--;
+    if (task->sess->pending_close && task->sess->in_use == 0) {
+        qemu_cond_broadcast(&task->lkcf->cond);
+    }
+    qemu_mutex_unlock(&task->lkcf->mutex);
+
     task->status = status;
 
     qemu_mutex_lock(&task->lkcf->rsp_mutex);
@@ -486,12 +501,32 @@ static int cryptodev_lkcf_operation(
         return -VIRTIO_CRYPTO_INVSESS;
     }
 
-    sess = lkcf->sess[op_info->session_id];
     if (algtype != QCRYPTODEV_BACKEND_ALGO_TYPE_ASYM) {
         error_report("algtype not supported: %u", algtype);
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
+    /*
+     * Check if session is pending close and increment in_use counter
+     * atomically under the mutex. This prevents the session from being
+     * freed while a task is pending.
+     */
+    qemu_mutex_lock(&lkcf->mutex);
+    sess = lkcf->sess[op_info->session_id];
+    if (!sess) {
+        qemu_mutex_unlock(&lkcf->mutex);
+        error_report("Cannot find a valid session id: %" PRIu64 "",
+                     op_info->session_id);
+        return -VIRTIO_CRYPTO_INVSESS;
+    }
+    if (sess->pending_close) {
+        qemu_mutex_unlock(&lkcf->mutex);
+        error_report("Session %" PRIu64 " is closing", op_info->session_id);
+        return -VIRTIO_CRYPTO_INVSESS;
+    }
+    sess->in_use++;
+    qemu_mutex_unlock(&lkcf->mutex);
+
     task = g_new0(CryptoDevLKCFTask, 1);
     task->op_info = op_info;
     task->cb = op_info->cb;
@@ -606,8 +641,30 @@ static int cryptodev_lkcf_close_session(CryptoDevBackend *backend,
     CryptoDevBackendLKCFSession *session;
 
     assert(session_id < MAX_SESSIONS && lkcf->sess[session_id]);
+
+    qemu_mutex_lock(&lkcf->mutex);
     session = lkcf->sess[session_id];
+
+    /*
+     * Mark session as pending close. New operations using this session
+     * will be rejected. We hold the mutex until in_use becomes 0 to
+     * prevent race conditions.
+     */
+    session->pending_close = true;
+
+    /*
+     * Wait for all in-flight tasks using this session to complete.
+     * The worker thread decrements in_use after task execution.
+     */
+    while (session->in_use > 0) {
+        qemu_cond_wait(&lkcf->cond, &lkcf->mutex);
+    }
+
+    /*
+     * Now safe to remove session and free resources.
+     */
     lkcf->sess[session_id] = NULL;
+    qemu_mutex_unlock(&lkcf->mutex);
 
     g_free(session->key);
     g_free(session);
-- 
2.53.0.windows.1


