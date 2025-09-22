Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FA3DCA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 22:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0obx-0005tq-ID; Mon, 22 Sep 2025 18:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obv-0005sl-LT
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v0obu-0001vD-0X
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 18:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758578533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+TfaxV/wez/uLDfuf+bd3G0/itM6OL3XKa9FRn6eFIw=;
 b=cc+xaHpPp9U0tarIhqb3Hz0o1hChaSuuLMduNyCaOOd8lx5/98f3sAyxKR3H2So80QipKm
 5NYLXOl3tG5XJnQEbAZ5il93GIcGiOLcxISmprnZRcnA1bbVVB9oFtQSk6LScORl+WlqeN
 7AwADeJLw7aCHqmadYcyfc5iLZeUIWU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-264-fZKruXZkP26S0qWOuoTnYA-1; Mon,
 22 Sep 2025 18:02:08 -0400
X-MC-Unique: fZKruXZkP26S0qWOuoTnYA-1
X-Mimecast-MFC-AGG-ID: fZKruXZkP26S0qWOuoTnYA_1758578524
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8AB3E19560AF; Mon, 22 Sep 2025 22:02:04 +0000 (UTC)
Received: from localhost (unknown [10.2.17.92])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C6571195608E; Mon, 22 Sep 2025 22:02:03 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 <qemu-block@nongnu.org>, Hanna Reitz <hreitz@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 5/5] tests/virtio-scsi: add a virtio_error() IOThread test
Date: Mon, 22 Sep 2025 18:01:49 -0400
Message-ID: <20250922220149.498967-6-stefanha@redhat.com>
In-Reply-To: <20250922220149.498967-1-stefanha@redhat.com>
References: <20250922220149.498967-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that virtio_error() calls should work in an IOThread, add a
virtio-scsi IOThread test cases that triggers virtio_error().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qtest/virtio-scsi-test.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/qtest/virtio-scsi-test.c b/tests/qtest/virtio-scsi-test.c
index db10d572d0..e2350c52f6 100644
--- a/tests/qtest/virtio-scsi-test.c
+++ b/tests/qtest/virtio-scsi-test.c
@@ -311,6 +311,31 @@ fail:
     unlink(tmp_path);
 }
 
+static void test_iothread_virtio_error(void *obj, void *data,
+                                       QGuestAllocator *t_alloc)
+{
+    QVirtioSCSIPCI *scsi_pci = obj;
+    QVirtioSCSI *scsi = &scsi_pci->scsi;
+    QVirtioSCSIQueues *vs;
+    QVirtQueue *vq;
+
+    alloc = t_alloc;
+    vs = qvirtio_scsi_init(scsi->vdev);
+    vq = vs->vq[2];
+
+    /* Move avail.idx out of bounds to trigger virtio_error() */
+    qvirtqueue_set_avail_idx(global_qtest, scsi->vdev, vq, vq->size * 2);
+    scsi->vdev->bus->virtqueue_kick(scsi->vdev, vq);
+
+    /*
+     * Reset the device out of the error state. If QEMU hangs or crashes then
+     * this will fail.
+     */
+    qvirtio_reset(scsi->vdev);
+
+    qvirtio_scsi_pci_free(vs);
+}
+
 static void *virtio_scsi_hotplug_setup(GString *cmd_line, void *arg)
 {
     g_string_append(cmd_line,
@@ -383,6 +408,13 @@ static void register_virtio_scsi_test(void)
     };
     qos_add_test("iothread-attach-node", "virtio-scsi-pci",
                  test_iothread_attach_node, &opts);
+
+    opts.before = virtio_scsi_setup_iothread;
+    opts.edge = (QOSGraphEdgeOptions) {
+        .extra_device_opts = "iothread=thread0",
+    };
+    qos_add_test("iothread-virtio-error", "virtio-scsi-pci",
+                 test_iothread_virtio_error, &opts);
 }
 
 libqos_init(register_virtio_scsi_test);
-- 
2.51.0


