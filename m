Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB0FCD4F50
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 18:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP2lM-0006Hp-Id; Mon, 18 May 2026 14:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <96cf23eea1204b34443218fe76bd4a5eaf9163e8@kylie.crudebyte.com>)
 id 1wP2l5-0006HN-Ci; Mon, 18 May 2026 14:32:07 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <96cf23eea1204b34443218fe76bd4a5eaf9163e8@kylie.crudebyte.com>)
 id 1wP2l3-0002O5-Qx; Mon, 18 May 2026 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=XoyYoo89AyoQKbQdczMsvDAvQaW1Tggzuljl0HV6HPM=; b=m/YRb
 JQO6EA+VMQ3e90+efYlgFGQDUqYw7rKMOID8auiNeFqIaPMfpgoGPaZBwZ3S2YCDQeRhHpdjygC+F
 BsKEsr+KBDd0lVhzoG18vA04on1PcXq7wDR7fefUW3riZdvaTSnyYW3Cqj6L8gG82pMV5tKIQTbqI
 Sbea2ZqmXq/dPRQJJo4K+UoGUlUyxNxF8lEwONj464PhS5Tan8WaYvRLrcqNCK8HSDkwKtI2R6dAu
 rqP27V7JF6BFLPVmiaYag0jeiOkeCskuAulcjrEMoDMD0y+2G27pbJg3Dt2GuGMy5KuBAjaGFR70V
 /34+cpPXqHD4X9gprDLkXLQdeSKVrcoKsGcewRUFsileY0zmW1oeqnJwU91Zwq+IJgNP5DifL4T15
 fmZCMO8DcWgNlIrO12lBNJEQQIKjCbF5MHkWyrUJFyjoQxL96Xcng/HlGoKjUBqP7dtijMRvcHapd
 7/sC/yKmGHS9eSi92VNVTqY0I0NDkWKkoqSy1Iuu1hWoYLWKkcoQe5Y5uKpHdYUajkafkcuP8+WAr
 K+q9L/ZB9gmw47Aod29Do//0RucxUXfDUpugTcC0f3kAraK23EqU+b/bRR5sjybyBUq1OFzg3i4bR
 B/kGftf8BbVnrglPeuk67jvwo5A5Kv30+NgLDNUaM50QeHT8zAO61Ta1mJetIs=;
Message-ID: <96cf23eea1204b34443218fe76bd4a5eaf9163e8.1779126034.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779126034.git.qemu_oss@crudebyte.com>
References: <cover.1779126034.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 18 May 2026 19:36:01 +0200
Subject: [PATCH 5/6] tests/qtest/libqos: add qvirtqueue_reset_pool() for
 descriptor pool reset
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Jia Jia <physicalmtea@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=96cf23eea1204b34443218fe76bd4a5eaf9163e8@kylie.crudebyte.com;
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


