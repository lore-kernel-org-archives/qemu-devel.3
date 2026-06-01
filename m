Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EC1CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU00y-0004TU-1f; Mon, 01 Jun 2026 06:37:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <be33c56898f8b18617cff91525f0b68abee8de07@kylie.crudebyte.com>)
 id 1wU00u-0004So-LY; Mon, 01 Jun 2026 06:36:57 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <be33c56898f8b18617cff91525f0b68abee8de07@kylie.crudebyte.com>)
 id 1wU00s-00075i-Gp; Mon, 01 Jun 2026 06:36:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=3bAH1zxl2nTq/kZfGqArQY/bbatoiPlV2qADmOh86XQ=; b=NFoR6
 3NVAJcZcAiDOHjtYL6u143Cam7LNwB5ZxQjICc9d499iMQaJJ71E5xahNgMKDGvqamW2ySp0jmCZy
 cBBGT+k9uPKmhbRswwTRr7Hve2k5V9dgOb5KHAFEkhmIMb4NVnAO1RNbtm6GIgJRIMY5QNjLgR34z
 2YVcis76C9rbETgHk+GLGVBknHZeJGL2ELxXJObNJpb7cmVQEmkLu8IFuGWzr2ijbJ5EH94XyQt9h
 7hIZvvYDSkRSjsuNS/hEByuEVF1u1RVO55hdVimiAHfQQAtcxypPaKYsyQPEFPgnPGulHSCNdYknm
 FPHamXDg2/0TG9arBYIABqrdO8Uo0jlN7gXKx3JS9gxEJGTtUEzZ1DJFh9GxoKNMS2PBhgoLTeWZa
 rw/c9G9uTNxRO3X+uZTmxGBXn9hAWXg0f9UcuvhEGTLSQJanUolC8ckf7WGT1FVO6sxdq8kQYvWee
 QT3tMclIyKL0yZXG4u3xFp/m+IHVXJYSb7J8M+yxfeTyFrpEGbJ+do363kvG9ZiYr1lGN1lwdNZ1O
 8Avv/yFq+u6P+RD3Y8dLYFXTJLQimmuCA+FOuVxnI9nqy+JKNztMu8TSQzqyrzHbTHf/DIFm+9B75
 uWH+Q+BUYS72fmYDbUr5V+IYGxRmsV9TkSVw/TWCT8UDRJUFEws3GY96xkqJMU=;
Message-ID: <be33c56898f8b18617cff91525f0b68abee8de07.1780307575.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780307575.git.qemu_oss@crudebyte.com>
References: <cover.1780307575.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 01 Jun 2026 11:52:56 +0200
Subject: [PULL 5/7] tests/qtest/libqos: add qvirtqueue_reset_pool() for
 descriptor pool reset
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Wang Jihe <wangjihe.mail@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=be33c56898f8b18617cff91525f0b68abee8de07@kylie.crudebyte.com;
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
---
 tests/qtest/libqos/virtio.c | 23 +++++++++++++++++++++++
 tests/qtest/libqos/virtio.h |  2 ++
 2 files changed, 25 insertions(+)

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


