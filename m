Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D79BCD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV9l-0002gR-Ap; Sat, 13 Jun 2026 16:40:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9i-0002cx-Pq; Sat, 13 Jun 2026 16:40:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9g-0004mi-WC; Sat, 13 Jun 2026 16:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=y7G/QIRnRsuPk7/oRZJGZMI9BKG1yQA33e2zndC2EKs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vbyCxAh3Naz/9uO+igaDddSjyZIt5qYYWiwQOz7DVDFgJip81mSl0jR+bZJV/Mv1p
 6AFcI5CC8wIacIqFMHzybiI26zQkOYbo2qgCSibswDwuhjPFoBjIUw+M2TtM3jLjUJ
 FnFZAyeQGEAg5gJmNOUDCoLPDsbPwsXHXWHrVFIEZk3IFSNzH7UNA5mbtfWDYZcqjk
 Rs9+w8AxJVbfD55OejaVJn3y3a1WkkxPrK+4IX8IX/Sa8KnALKAEfb2mOX4YkM3ytV
 WcfyyyXEPIPD9EpfcBRphDqCjiqYhOakoreZxF7hGnovDbCiUrMWuHGzcsnq7raIoM
 0/uS4I2ajWlmQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5F7871B6F0E;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8CF63CE95B;
 Sat, 13 Jun 2026 23:36:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 47/72] tests/qtest/libqos: add qvirtqueue_reset_pool()
 for descriptor pool reset
Date: Sat, 13 Jun 2026 23:35:13 +0300
Message-ID: <20260613203542.1809153-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add a function to reset the virtqueue descriptor pool state without
reinitializing the device. This is useful for tests that issue a high
number of requests and are limited by the simplified virtio test
driver's descriptor tracking, which decrements num_free but never
increments it back.

The function is safe for synchronous test code where requests are
sent and completed before the next request is issued.

Acked-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/qemu-devel/96cf23eea1204b34443218fe76bd4a5eaf9163e8.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit be33c56898f8b18617cff91525f0b68abee8de07)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qtest/libqos/virtio.c b/tests/qtest/libqos/virtio.c
index 010ff40834..ccbb325222 100644
--- a/tests/qtest/libqos/virtio.c
+++ b/tests/qtest/libqos/virtio.c
@@ -464,6 +464,29 @@ bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
     return true;
 }
 
+/*
+ * qvirtqueue_reset_pool:
+ * @vq: The virtqueue to reset
+ *
+ * Reset the descriptor pool state without reinitializing the device.
+ * This is useful for tests that issue a high number of requests and
+ * are limited by the simplified virtio test driver's descriptor tracking,
+ * which decrements num_free but never increments it back.
+ *
+ * This is only safe for synchronous test code where requests are
+ * sent and completed before the next request is issued. Do not use
+ * with asynchronous code where multiple requests may be in-flight.
+ *
+ * Note: This only resets the available descriptor pool (free_head,
+ * num_free). The used ring position (last_used_idx) is NOT reset
+ * and should continue to track consumed responses across iterations.
+ */
+void qvirtqueue_reset_pool(QVirtQueue *vq)
+{
+    vq->free_head = 0;
+    vq->num_free = vq->size;
+}
+
 void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx)
 {
     g_assert(vq->event);
diff --git a/tests/qtest/libqos/virtio.h b/tests/qtest/libqos/virtio.h
index e238f1726f..f17be0b9b6 100644
--- a/tests/qtest/libqos/virtio.h
+++ b/tests/qtest/libqos/virtio.h
@@ -150,6 +150,8 @@ void qvirtqueue_kick(QTestState *qts, QVirtioDevice *d, QVirtQueue *vq,
 bool qvirtqueue_get_buf(QTestState *qts, QVirtQueue *vq, uint32_t *desc_idx,
                         uint32_t *len);
 
+void qvirtqueue_reset_pool(QVirtQueue *vq);
+
 void qvirtqueue_set_used_event(QTestState *qts, QVirtQueue *vq, uint16_t idx);
 
 void qvirtio_start_device(QVirtioDevice *vdev);
-- 
2.47.3


