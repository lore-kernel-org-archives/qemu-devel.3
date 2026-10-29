Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C31606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VGgrrM/J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMZGJ-0005py-7B; Thu, 29 Oct 2026 19:10:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMZGF-0005ot-EQ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:10:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xMZGB-0004uD-JF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 19:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793315414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9qvdSaIaK87sVcHW5zbdFmyJqw37YG2nepSnLCDJBSI=;
 b=VGgrrM/J91d1Xky06DdWtQz3ntvoIEsho1yCX/q8nV559tRst2PzBWsZuvYKdGtz/HpjM+
 tQ9aA9F8saiDR0+DoriLRTIuJFSdB6qbc5sArq7FoGV1Ng0vGkzxKWMjU+YP7HPkNIN72p
 A47s7X9hok6gFGftjUnwjMLkbiQ+njw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-EEwW4pK2MuyndO0idojNxQ-1; Thu,
 29 Oct 2026 19:10:13 -0400
X-MC-Unique: EEwW4pK2MuyndO0idojNxQ-1
X-Mimecast-MFC-AGG-ID: EEwW4pK2MuyndO0idojNxQ_1793315412
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E2A4180ABF2; Thu, 29 Oct 2026 23:10:12 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.61])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F374030002CB; Thu, 29 Oct 2026 23:10:09 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com, mst@redhat.com,
 devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: [PATCH v2 2/4] virtio-blk-test: Add a basic GET_ID test case
Date: Fri, 30 Oct 2026 00:09:59 +0100
Message-ID: <20261029231001.194240-3-kwolf@redhat.com>
In-Reply-To: <20261029231001.194240-1-kwolf@redhat.com>
References: <20261029231001.194240-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This covers the simple common case with no surprises: A serial that is
shorter than 20 characters and can fit in the request buffer.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qtest/virtio-blk-test.c | 96 +++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tests/qtest/virtio-blk-test.c b/tests/qtest/virtio-blk-test.c
index 98c906ebb4a..825ea261bed 100644
--- a/tests/qtest/virtio-blk-test.c
+++ b/tests/qtest/virtio-blk-test.c
@@ -95,6 +95,8 @@ static uint64_t virtio_blk_request(QGuestAllocator *alloc, QVirtioDevice *d,
         g_assert_cmpuint(data_size %
                          sizeof(struct virtio_blk_discard_write_zeroes), ==, 0);
         break;
+    case VIRTIO_BLK_T_GET_ID:
+        break;
     default:
         g_assert_cmpuint(data_size, ==, 0);
     }
@@ -771,6 +773,91 @@ static void resize(void *obj, void *data, QGuestAllocator *t_alloc)
 
 }
 
+static QVirtQueue *get_id_setup(QVirtioDevice *dev, QGuestAllocator *t_alloc)
+{
+    QVirtQueue *vq;
+    uint64_t features = qvirtio_get_features(dev);
+
+    features = features & (1ull << VIRTIO_F_VERSION_1);
+    qvirtio_set_features(dev, features);
+
+    vq = qvirtqueue_setup(dev, t_alloc, 0);
+    qvirtio_set_driver_ok(dev);
+    return vq;
+}
+
+static uint8_t get_id_request(QVirtioDevice *dev, QVirtQueue *vq,
+                              char *buf, size_t buf_len,
+                              char pattern_byte,
+                              QGuestAllocator *t_alloc)
+{
+    QTestState *qts = global_qtest;
+    uint64_t req_addr;
+    uint32_t free_head;
+    uint8_t status;
+
+    QVirtioBlkReq req = {
+        .type = VIRTIO_BLK_T_GET_ID,
+        .data = buf,
+    };
+
+    req_addr = virtio_blk_request(t_alloc, dev, &req, buf_len);
+
+    memset(req.data, pattern_byte, buf_len);
+    memwrite(req_addr + 16, req.data, buf_len);
+
+    free_head = qvirtqueue_add(qts, vq, req_addr, 16, false, true);
+    qvirtqueue_add(qts, vq, req_addr + 16, buf_len, true, true);
+    qvirtqueue_add(qts, vq, req_addr + 16 + buf_len, 1, true, false);
+
+    qvirtqueue_kick(qts, dev, vq, free_head);
+
+    qvirtio_wait_used_elem(qts, dev, vq, free_head, NULL,
+                           QVIRTIO_BLK_TIMEOUT_US);
+    status = readb(req_addr + 16 + buf_len);
+    memread(req_addr + 16, buf, buf_len);
+
+    guest_free(t_alloc, req_addr);
+
+    return status;
+}
+
+static void get_id_serial_short(void *obj, void *data, QGuestAllocator *t_alloc)
+{
+    QVirtioBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
+    QVirtQueue *vq;
+    uint8_t status;
+    const char expected[20] = "abc";
+    char buf[20];
+
+    vq = get_id_setup(dev, t_alloc);
+    status = get_id_request(dev, vq, buf, 20, 0xa5, t_alloc);
+    g_assert_cmpint(status, ==, 0);
+    g_assert_cmpmem(buf, 20, expected, sizeof(expected));
+
+    qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
+}
+
+static void get_id_serial_short_20_characters(void *obj, void *data,
+                                              QGuestAllocator *t_alloc)
+{
+    QVirtioBlk *blk_if = obj;
+    QVirtioDevice *dev = blk_if->vdev;
+    QVirtQueue *vq;
+    uint8_t status;
+    /* Edge case of a serial with exactly 20 characters: No NUL termination */
+    const char expected[25] = "01234567890123456789\xa5\xa5\xa5\xa5\xa5";
+    char buf[25];
+
+    vq = get_id_setup(dev, t_alloc);
+    status = get_id_request(dev, vq, buf, 25, 0xa5, t_alloc);
+    g_assert_cmpint(status, ==, 0);
+    g_assert_cmpmem(buf, 25, expected, sizeof(expected));
+
+    qvirtqueue_cleanup(blk_if->vdev->bus, vq, t_alloc);
+}
+
 static void *virtio_blk_test_setup(GString *cmd_line, void *arg)
 {
     char *tmp_path = drive_create();
@@ -802,6 +889,15 @@ static void register_virtio_blk_test(void)
     qos_add_test("nxvirtq", "virtio-blk-pci",
                       test_nonexistent_virtqueue, &opts);
     qos_add_test("hotplug", "virtio-blk-pci", pci_hotplug, &opts);
+
+    /* serial number tests */
+    opts.edge.extra_device_opts = "serial=abc";
+    qos_add_test("get_id/serial_short", "virtio-blk",
+                 get_id_serial_short, &opts);
+
+    opts.edge.extra_device_opts = "serial=01234567890123456789";
+    qos_add_test("get_id/serial_short_20_characters", "virtio-blk",
+                 get_id_serial_short_20_characters, &opts);
 }
 
 libqos_init(register_virtio_blk_test);
-- 
2.56.0


